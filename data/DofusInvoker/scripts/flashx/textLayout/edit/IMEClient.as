package flashx.textLayout.edit
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.IME;
   import flash.text.engine.TextLine;
   import flash.text.ime.CompositionAttributeRange;
   import flash.text.ime.IIMEClient;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.IMEStatus;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.operations.ApplyFormatToElementOperation;
   import flashx.textLayout.operations.FlowOperation;
   import flashx.textLayout.operations.InsertTextOperation;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.utils.GeometryUtil;
   import flashx.undo.UndoManager;
   
   use namespace tlf_internal;
   
   class IMEClient implements IIMEClient
   {
       
      
      private var _editManager:EditManager;
      
      private var _undoManager:UndoManager;
      
      private var _imeAnchorPosition:int;
      
      private var _imeLength:int;
      
      private var _controller:ContainerController;
      
      private var _closing:Boolean;
      
      function IMEClient(editManager:EditManager)
      {
         var flowComposer:IFlowComposer = null;
         var controllerIndex:int = 0;
         super();
         this._editManager = editManager;
         this._imeAnchorPosition = this._editManager.absoluteStart;
         if(this._editManager.textFlow)
         {
            flowComposer = this._editManager.textFlow.flowComposer;
            if(flowComposer)
            {
               controllerIndex = flowComposer.findControllerIndexAtPosition(this._imeAnchorPosition);
               this._controller = flowComposer.getControllerAt(controllerIndex);
               if(this._controller)
               {
                  this._controller.setFocus();
               }
            }
         }
         this._closing = false;
         if(this._editManager.undoManager == null)
         {
            this._undoManager = new UndoManager();
            this._editManager.setUndoManager(this._undoManager);
         }
      }
      
      public function selectionChanged() : void
      {
         if(this._editManager.absoluteStart > this._imeAnchorPosition + this._imeLength || this._editManager.absoluteEnd < this._imeAnchorPosition)
         {
            this.compositionAbandoned();
         }
      }
      
      private function doIMEClauseOperation(selState:SelectionState, clause:int) : void
      {
         var leaf:FlowLeafElement = this._editManager.textFlow.findLeaf(selState.absoluteStart);
         var leafAbsoluteStart:int = leaf.getAbsoluteStart();
         var format:TextLayoutFormat = new TextLayoutFormat();
         format.setStyle(IMEStatus.IME_CLAUSE,clause.toString());
         this._editManager.doOperation(new ApplyFormatToElementOperation(selState,leaf,format,selState.absoluteStart - leafAbsoluteStart,selState.absoluteEnd - leafAbsoluteStart));
      }
      
      private function doIMEStatusOperation(selState:SelectionState, attrRange:CompositionAttributeRange) : void
      {
         var imeStatus:String = null;
         if(attrRange == null)
         {
            imeStatus = IMEStatus.DEAD_KEY_INPUT_STATE;
         }
         else if(!attrRange.converted)
         {
            if(!attrRange.selected)
            {
               imeStatus = IMEStatus.NOT_SELECTED_RAW;
            }
            else
            {
               imeStatus = IMEStatus.SELECTED_RAW;
            }
         }
         else if(!attrRange.selected)
         {
            imeStatus = IMEStatus.NOT_SELECTED_CONVERTED;
         }
         else
         {
            imeStatus = IMEStatus.SELECTED_CONVERTED;
         }
         var leaf:FlowLeafElement = this._editManager.textFlow.findLeaf(selState.absoluteStart);
         var leafAbsoluteStart:int = leaf.getAbsoluteStart();
         var format:TextLayoutFormat = new TextLayoutFormat();
         format.setStyle(IMEStatus.IME_STATUS,imeStatus);
         this._editManager.doOperation(new ApplyFormatToElementOperation(selState,leaf,format,selState.absoluteStart - leafAbsoluteStart,selState.absoluteEnd - leafAbsoluteStart));
      }
      
      private function deleteIMEText(textFlow:TextFlow) : void
      {
         var leafFormat:TextLayoutFormat = null;
         var absoluteStart:int = 0;
         var leaf:FlowLeafElement = textFlow.getFirstLeaf();
         while(leaf)
         {
            if(leaf.getStyle(IMEStatus.IME_STATUS) !== undefined || leaf.getStyle(IMEStatus.IME_CLAUSE) !== undefined)
            {
               leafFormat = new TextLayoutFormat(leaf.format);
               leafFormat.setStyle(IMEStatus.IME_STATUS,undefined);
               leafFormat.setStyle(IMEStatus.IME_CLAUSE,undefined);
               leaf.format = leafFormat;
               absoluteStart = leaf.getAbsoluteStart();
               ModelEdit.deleteText(textFlow,absoluteStart,absoluteStart + leaf.textLength,false);
               leaf = textFlow.findLeaf(absoluteStart);
            }
            else
            {
               leaf = leaf.getNextLeaf();
            }
         }
      }
      
      private function rollBackIMEChanges() : void
      {
         var previousIMEOperation:FlowOperation = this._editManager.undoManager.peekUndo() as FlowOperation;
         if(this._imeLength > 0 && previousIMEOperation && previousIMEOperation.endGeneration == this._editManager.textFlow.generation && previousIMEOperation.canUndo())
         {
            if(this._editManager.undoManager)
            {
               this._editManager.undoManager.undo();
            }
            this._editManager.undoManager.popRedo();
         }
         else
         {
            this._editManager.undoManager.popUndo();
            this.deleteIMEText(this._editManager.textFlow);
         }
         this._imeLength = 0;
      }
      
      public function updateComposition(text:String, attributes:Vector.<CompositionAttributeRange>, compositionStartIndex:int, compositionEndIndex:int) : void
      {
         var pointFormat:ITextLayoutFormat = null;
         var selState:SelectionState = null;
         var insertOp:InsertTextOperation = null;
         var newSelectionStart:int = 0;
         var newSelectionEnd:int = 0;
         var attrLen:int = 0;
         var i:int = 0;
         var attrRange:CompositionAttributeRange = null;
         var clauseSelState:SelectionState = null;
         if(this._imeLength > 0)
         {
            this.rollBackIMEChanges();
         }
         if(text.length > 0)
         {
            pointFormat = this._editManager.getSelectionState().pointFormat;
            selState = new SelectionState(this._editManager.textFlow,this._imeAnchorPosition,this._imeAnchorPosition + this._imeLength,pointFormat);
            this._editManager.beginIMEOperation();
            if(this._editManager.absoluteStart != this._editManager.absoluteEnd)
            {
               this._editManager.deleteText();
            }
            insertOp = new InsertTextOperation(selState,text);
            this._imeLength = text.length;
            this._editManager.doOperation(insertOp);
            if(attributes && attributes.length > 0)
            {
               attrLen = attributes.length;
               for(i = 0; i < attrLen; i++)
               {
                  attrRange = attributes[i];
                  clauseSelState = new SelectionState(this._editManager.textFlow,this._imeAnchorPosition + attrRange.relativeStart,this._imeAnchorPosition + attrRange.relativeEnd);
                  this.doIMEClauseOperation(clauseSelState,i);
                  this.doIMEStatusOperation(clauseSelState,attrRange);
               }
            }
            else
            {
               clauseSelState = new SelectionState(this._editManager.textFlow,this._imeAnchorPosition,this._imeAnchorPosition + this._imeLength,pointFormat);
               this.doIMEClauseOperation(clauseSelState,0);
               this.doIMEStatusOperation(clauseSelState,null);
            }
            newSelectionStart = this._imeAnchorPosition + compositionStartIndex;
            newSelectionEnd = this._imeAnchorPosition + compositionEndIndex;
            if(this._editManager.absoluteStart != newSelectionStart || this._editManager.absoluteEnd != newSelectionEnd)
            {
               this._editManager.selectRange(this._imeAnchorPosition + compositionStartIndex,this._imeAnchorPosition + compositionEndIndex);
            }
            this._editManager.endIMEOperation();
         }
      }
      
      public function confirmComposition(text:String = null, preserveSelection:Boolean = false) : void
      {
         this.endIMESession();
      }
      
      public function compositionAbandoned() : void
      {
         var imeCompositionAbandoned:Function = IME["compositionAbandoned"];
         if(IME["compositionAbandoned"] !== undefined)
         {
            imeCompositionAbandoned();
         }
      }
      
      private function endIMESession() : void
      {
         if(!this._editManager || this._closing)
         {
            return;
         }
         this._closing = true;
         if(this._imeLength > 0)
         {
            this.rollBackIMEChanges();
         }
         if(this._undoManager)
         {
            this._editManager.setUndoManager(null);
         }
         this._editManager.endIMESession();
         this._editManager = null;
      }
      
      public function getTextBounds(startIndex:int, endIndex:int) : Rectangle
      {
         var boundsResult:Array = null;
         var bounds:Rectangle = null;
         var textLine:TextLine = null;
         var resultTopLeft:Point = null;
         var resultBottomRight:Point = null;
         var containerTopLeft:Point = null;
         var containerBottomLeft:Point = null;
         var flowComposer:IFlowComposer = null;
         var lineIndex:int = 0;
         var line:TextFlowLine = null;
         var previousLine:TextFlowLine = null;
         var nextLine:TextFlowLine = null;
         if(startIndex >= 0 && startIndex < this._editManager.textFlow.textLength && endIndex >= 0 && endIndex < this._editManager.textFlow.textLength)
         {
            if(startIndex != endIndex)
            {
               boundsResult = GeometryUtil.getHighlightBounds(new TextRange(this._editManager.textFlow,startIndex,endIndex));
               if(boundsResult.length > 0)
               {
                  bounds = boundsResult[0].rect;
                  textLine = boundsResult[0].textLine;
                  resultTopLeft = textLine.localToGlobal(bounds.topLeft);
                  resultBottomRight = textLine.localToGlobal(bounds.bottomRight);
                  if(textLine.parent)
                  {
                     containerTopLeft = textLine.parent.globalToLocal(resultTopLeft);
                     containerBottomLeft = textLine.parent.globalToLocal(resultBottomRight);
                     return new Rectangle(containerTopLeft.x,containerTopLeft.y,containerBottomLeft.x - containerTopLeft.x,containerBottomLeft.y - containerTopLeft.y);
                  }
               }
            }
            else
            {
               flowComposer = this._editManager.textFlow.flowComposer;
               lineIndex = flowComposer.findLineIndexAtPosition(startIndex);
               if(lineIndex == flowComposer.numLines)
               {
                  lineIndex--;
               }
               if(flowComposer.getLineAt(lineIndex).controller == this._controller)
               {
                  line = flowComposer.getLineAt(lineIndex);
                  previousLine = lineIndex != 0 ? flowComposer.getLineAt(lineIndex - 1) : null;
                  nextLine = lineIndex != flowComposer.numLines - 1 ? flowComposer.getLineAt(lineIndex + 1) : null;
                  return line.computePointSelectionRectangle(startIndex,this._controller.container,previousLine,nextLine,true);
               }
            }
         }
         return new Rectangle(0,0,0,0);
      }
      
      public function get compositionStartIndex() : int
      {
         return this._imeAnchorPosition;
      }
      
      public function get compositionEndIndex() : int
      {
         return this._imeAnchorPosition + this._imeLength;
      }
      
      public function get verticalTextLayout() : Boolean
      {
         return this._editManager.textFlow.computedFormat.blockProgression == BlockProgression.RL;
      }
      
      public function get selectionActiveIndex() : int
      {
         return this._editManager.activePosition;
      }
      
      public function get selectionAnchorIndex() : int
      {
         return this._editManager.anchorPosition;
      }
      
      public function selectRange(anchorIndex:int, activeIndex:int) : void
      {
         this._editManager.selectRange(anchorIndex,activeIndex);
      }
      
      public function setFocus() : void
      {
         if(this._controller && this._controller.container && this._controller.container.stage && this._controller.container.stage.focus != this._controller.container)
         {
            this._controller.setFocus();
         }
      }
      
      public function getTextInRange(startIndex:int, endIndex:int) : String
      {
         var tempIndex:int = 0;
         var textFlow:TextFlow = this._editManager.textFlow;
         if(startIndex < -1 || endIndex < -1 || startIndex > textFlow.textLength - 1 || endIndex > textFlow.textLength - 1)
         {
            return null;
         }
         if(endIndex < startIndex)
         {
            tempIndex = endIndex;
            endIndex = startIndex;
            startIndex = tempIndex;
         }
         if(startIndex == -1)
         {
            startIndex = 0;
         }
         return textFlow.getText(startIndex,endIndex);
      }
   }
}
