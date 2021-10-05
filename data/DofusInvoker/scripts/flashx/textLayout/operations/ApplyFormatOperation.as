package flashx.textLayout.operations
{
   import flashx.textLayout.edit.ElementRange;
   import flashx.textLayout.edit.ParaEdit;
   import flashx.textLayout.edit.PointFormat;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class ApplyFormatOperation extends FlowTextOperation
   {
       
      
      private var applyLeafFormat:ITextLayoutFormat;
      
      private var applyParagraphFormat:ITextLayoutFormat;
      
      private var applyContainerFormat:ITextLayoutFormat;
      
      private var undoLeafArray:Array;
      
      private var undoParagraphArray:Array;
      
      private var undoContainerArray:Array;
      
      public function ApplyFormatOperation(operationState:SelectionState, leafFormat:ITextLayoutFormat, paragraphFormat:ITextLayoutFormat, containerFormat:ITextLayoutFormat = null)
      {
         super(operationState);
         this.leafFormat = leafFormat;
         this.paragraphFormat = paragraphFormat;
         this.containerFormat = containerFormat;
      }
      
      public function get leafFormat() : ITextLayoutFormat
      {
         return this.applyLeafFormat;
      }
      
      public function set leafFormat(value:ITextLayoutFormat) : void
      {
         this.applyLeafFormat = !!value ? new TextLayoutFormat(value) : null;
      }
      
      public function get paragraphFormat() : ITextLayoutFormat
      {
         return this.applyParagraphFormat;
      }
      
      public function set paragraphFormat(value:ITextLayoutFormat) : void
      {
         this.applyParagraphFormat = !!value ? new TextLayoutFormat(value) : null;
      }
      
      public function get containerFormat() : ITextLayoutFormat
      {
         return this.applyContainerFormat;
      }
      
      public function set containerFormat(value:ITextLayoutFormat) : void
      {
         this.applyContainerFormat = !!value ? new TextLayoutFormat(value) : null;
      }
      
      private function doInternal() : SelectionState
      {
         var anyNewSelectionState:SelectionState = null;
         var begSel:int = 0;
         var endSel:int = 0;
         var paragraph:ParagraphElement = null;
         var newFormat:PointFormat = null;
         var range:ElementRange = null;
         if(this.applyLeafFormat)
         {
            begSel = absoluteStart;
            endSel = absoluteEnd;
            if(absoluteStart == absoluteEnd)
            {
               paragraph = textFlow.findLeaf(absoluteStart).getParagraph();
               if(paragraph.textLength <= 1)
               {
                  endSel++;
                  anyNewSelectionState = originalSelectionState.clone();
                  anyNewSelectionState.pointFormat = null;
               }
               else if(originalSelectionState.selectionManagerOperationState && textFlow.interactionManager)
               {
                  anyNewSelectionState = originalSelectionState.clone();
                  newFormat = new PointFormat(anyNewSelectionState.pointFormat);
                  newFormat.apply(this.applyLeafFormat);
                  anyNewSelectionState.pointFormat = newFormat;
               }
            }
            if(begSel != endSel)
            {
               range = ElementRange.createElementRange(textFlow,begSel,endSel);
               begSel = range.absoluteStart;
               endSel = range.absoluteEnd;
               if(endSel == textFlow.textLength - 1)
               {
                  endSel++;
               }
               if(!this.undoLeafArray)
               {
                  this.undoLeafArray = new Array();
                  ParaEdit.cacheStyleInformation(textFlow,begSel,endSel,this.undoLeafArray);
               }
               ParaEdit.applyTextStyleChange(textFlow,begSel,endSel,this.applyLeafFormat,null);
            }
         }
         if(this.applyParagraphFormat)
         {
            if(!this.undoParagraphArray)
            {
               this.undoParagraphArray = new Array();
               ParaEdit.cacheParagraphStyleInformation(textFlow,absoluteStart,absoluteEnd,this.undoParagraphArray);
            }
            ParaEdit.applyParagraphStyleChange(textFlow,absoluteStart,absoluteEnd,this.applyParagraphFormat,null);
         }
         if(this.applyContainerFormat)
         {
            if(!this.undoContainerArray)
            {
               this.undoContainerArray = new Array();
               ParaEdit.cacheContainerStyleInformation(textFlow,absoluteStart,absoluteEnd,this.undoContainerArray);
            }
            ParaEdit.applyContainerStyleChange(textFlow,absoluteStart,absoluteEnd,this.applyContainerFormat,null);
         }
         return anyNewSelectionState;
      }
      
      override public function doOperation() : Boolean
      {
         var newSelectionState:SelectionState = this.doInternal();
         if(newSelectionState && textFlow.interactionManager)
         {
            textFlow.interactionManager.setSelectionState(newSelectionState);
         }
         return true;
      }
      
      override public function redo() : SelectionState
      {
         var newSelectionState:SelectionState = this.doInternal();
         return !!newSelectionState ? newSelectionState : originalSelectionState;
      }
      
      override public function undo() : SelectionState
      {
         var obj:Object = null;
         for each(obj in this.undoLeafArray)
         {
            ParaEdit.setTextStyleChange(textFlow,obj.begIdx,obj.endIdx,obj.style);
         }
         for each(obj in this.undoParagraphArray)
         {
            ParaEdit.setParagraphStyleChange(textFlow,obj.begIdx,obj.endIdx,obj.attributes);
         }
         for each(obj in this.undoContainerArray)
         {
            ParaEdit.setContainerStyleChange(obj);
         }
         return originalSelectionState;
      }
   }
}
