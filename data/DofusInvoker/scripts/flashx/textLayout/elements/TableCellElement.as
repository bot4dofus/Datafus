package flashx.textLayout.elements
{
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.edit.EditManager;
   import flashx.textLayout.edit.IEditManager;
   import flashx.textLayout.events.DamageEvent;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public final class TableCellElement extends TableFormattedElement
   {
       
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _parcelIndex:int;
      
      private var _container:CellContainer;
      
      private var _enableIME:Boolean = true;
      
      private var _damaged:Boolean = true;
      
      private var _controller:ContainerController;
      
      private var _rowSpan:uint = 1;
      
      private var _columnSpan:uint = 1;
      
      private var _rowIndex:int = -1;
      
      private var _colIndex:int = -1;
      
      private var _includeDescentInCellBounds:Boolean;
      
      private var _savedPaddingTop:Number = 0;
      
      private var _savedPaddingBottom:Number = 0;
      
      private var _savedPaddingLeft:Number = 0;
      
      private var _savedPaddingRight:Number = 0;
      
      protected var _textFlow:TextFlow;
      
      public function TableCellElement()
      {
         super();
         this._controller = new ContainerController(this.container,NaN,NaN);
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "td";
      }
      
      override tlf_internal function canOwnFlowElement(elem:FlowElement) : Boolean
      {
         return elem is FlowElement;
      }
      
      public function isDamaged() : Boolean
      {
         return this._damaged || this._textFlow && this._textFlow.flowComposer.isPotentiallyDamaged(this._textFlow.textLength);
      }
      
      public function compose() : Boolean
      {
         var pt:Number = getEffectivePaddingTop();
         var pb:Number = getEffectivePaddingBottom();
         var pl:Number = getEffectivePaddingLeft();
         var pr:Number = getEffectivePaddingRight();
         if(pt != this._savedPaddingTop)
         {
            this._controller.paddingTop = this._savedPaddingTop = pt;
         }
         if(pb != this._savedPaddingBottom)
         {
            this._controller.paddingBottom = this._savedPaddingBottom = pb;
         }
         if(pl != this._savedPaddingLeft)
         {
            this._controller.paddingLeft = this._savedPaddingLeft = pl;
         }
         if(pr != this._savedPaddingRight)
         {
            this._controller.paddingRight = this._savedPaddingRight = pr;
         }
         var table:TableElement = getTable();
         this._damaged = false;
         var compWidth:Number = 0;
         for(var i:int = 0; i < this.columnSpan; i++)
         {
            if(table && table.getColumnAt(this.colIndex + i))
            {
               compWidth += table.getColumnAt(this.colIndex + i).columnWidth;
            }
         }
         this.width = compWidth;
         if(this._textFlow && this._textFlow.flowComposer)
         {
            return this._textFlow.flowComposer.compose();
         }
         return false;
      }
      
      public function update() : Boolean
      {
         if(this._textFlow && this._textFlow.flowComposer)
         {
            return this._textFlow.flowComposer.updateAllControllers();
         }
         return false;
      }
      
      public function get parcelIndex() : int
      {
         return this._parcelIndex;
      }
      
      public function set parcelIndex(value:int) : void
      {
         this._parcelIndex = value;
      }
      
      public function get rowIndex() : int
      {
         return this._rowIndex;
      }
      
      public function set rowIndex(value:int) : void
      {
         this._rowIndex = value;
      }
      
      public function get colIndex() : int
      {
         return this._colIndex;
      }
      
      public function set colIndex(value:int) : void
      {
         this._colIndex = value;
      }
      
      public function get textFlow() : TextFlow
      {
         var flow:TextFlow = null;
         var im:Class = null;
         if(this._textFlow == null)
         {
            flow = new TextFlow();
            if(table && table.getTextFlow() && table.getTextFlow().interactionManager is IEditManager)
            {
               flow.interactionManager = new EditManager(IEditManager(this._textFlow.interactionManager).undoManager);
            }
            else if(table && table.getTextFlow() && table.getTextFlow().interactionManager)
            {
               im = getDefinitionByName(getQualifiedClassName(table.getTextFlow().interactionManager)) as Class;
               flow.interactionManager = new im();
            }
            else
            {
               flow.normalize();
            }
            this.textFlow = flow;
         }
         return this._textFlow;
      }
      
      public function set textFlow(value:TextFlow) : void
      {
         if(this._textFlow)
         {
            this._textFlow.removeEventListener(DamageEvent.DAMAGE,this.handleCellDamage);
            this._textFlow.flowComposer.removeAllControllers();
         }
         this._textFlow = value;
         this._textFlow.parentElement = this;
         this._textFlow.flowComposer.addController(this._controller);
         this._textFlow.addEventListener(DamageEvent.DAMAGE,this.handleCellDamage);
      }
      
      public function get controller() : ContainerController
      {
         return this._controller;
      }
      
      private function handleCellDamage(ev:DamageEvent) : void
      {
         this.damage();
      }
      
      public function get enableIME() : Boolean
      {
         return this._enableIME;
      }
      
      public function set enableIME(value:Boolean) : void
      {
         this._enableIME = value;
      }
      
      public function get container() : CellContainer
      {
         if(!this._container)
         {
            this._container = new CellContainer(this.enableIME);
            this._container.element = this;
         }
         return this._container;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(value:Number) : void
      {
         if(this._width != value)
         {
            this._damaged = true;
         }
         this._width = value;
         this._controller.setCompositionSize(this._width,this._controller.compositionHeight);
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(value:Number) : void
      {
         if(this._height != value)
         {
            this._damaged = true;
         }
         this._height = value;
         this._controller.setCompositionSize(this._controller.compositionWidth,this._height);
      }
      
      public function getComposedHeight() : Number
      {
         var lastLine:TextFlowLine = null;
         var descent:Number = 0;
         if(!this.includeDescentInCellBounds)
         {
            if(this._textFlow.flowComposer && this._textFlow.flowComposer.numLines)
            {
               lastLine = this._textFlow.flowComposer.getLineAt(this._textFlow.flowComposer.numLines - 1);
               if(lastLine)
               {
                  descent = lastLine.descent;
               }
            }
         }
         return this._controller.getContentBounds().height - descent;
      }
      
      public function getRowHeight() : Number
      {
         return !!this.getRow() ? Number(this.getRow().composedHeight) : Number(NaN);
      }
      
      public function get rowSpan() : uint
      {
         return this._rowSpan;
      }
      
      public function set rowSpan(value:uint) : void
      {
         if(value >= 1)
         {
            this._rowSpan = value;
         }
      }
      
      public function get columnSpan() : uint
      {
         return this._columnSpan;
      }
      
      public function set columnSpan(value:uint) : void
      {
         if(value >= 1)
         {
            this._columnSpan = value;
         }
      }
      
      public function updateCompositionShapes() : void
      {
         this._controller.updateCompositionShapes();
      }
      
      public function getRow() : TableRowElement
      {
         return !!table ? table.getRowAt(this.rowIndex) : null;
      }
      
      public function getNextCell() : TableCellElement
      {
         return !!table ? table.getNextCell(this) : null;
      }
      
      public function getPreviousCell() : TableCellElement
      {
         return !!table ? table.getPreviousCell(this) : null;
      }
      
      public function get x() : Number
      {
         return this.container.x;
      }
      
      public function set x(value:Number) : void
      {
         this.container.x = value;
      }
      
      public function get y() : Number
      {
         return this.container.y;
      }
      
      public function set y(value:Number) : void
      {
         this.container.y = value;
      }
      
      public function damage() : void
      {
         if(table)
         {
            table.hasCellDamage = true;
         }
         this._damaged = true;
      }
      
      public function getTotalPaddingWidth() : Number
      {
         var paddingAmount:Number = 0;
         if(!this.textFlow)
         {
            return 0;
         }
         if(table && table.cellSpacing != undefined)
         {
            paddingAmount += table.cellSpacing;
         }
         if(this.textFlow.computedFormat.blockProgression == BlockProgression.RL)
         {
            paddingAmount += Math.max(getEffectivePaddingTop() + getEffectivePaddingBottom(),getEffectiveBorderTopWidth() + getEffectiveBorderBottomWidth());
         }
         else
         {
            paddingAmount += Math.max(getEffectivePaddingLeft() + getEffectivePaddingRight(),getEffectiveBorderLeftWidth() + getEffectiveBorderRightWidth());
         }
         return paddingAmount;
      }
      
      public function getTotalPaddingHeight() : Number
      {
         var paddingAmount:Number = 0;
         if(!this.textFlow)
         {
            return 0;
         }
         if(table && table.cellSpacing != undefined)
         {
            paddingAmount += table.cellSpacing;
         }
         if(this.textFlow.computedFormat.blockProgression == BlockProgression.RL)
         {
            paddingAmount += Math.max(getEffectivePaddingLeft() + getEffectivePaddingRight(),getEffectiveBorderLeftWidth() + getEffectiveBorderRightWidth());
         }
         else
         {
            paddingAmount += Math.max(getEffectivePaddingTop() + getEffectivePaddingBottom(),getEffectiveBorderTopWidth() + getEffectiveBorderBottomWidth());
         }
         return paddingAmount;
      }
      
      public function get includeDescentInCellBounds() : Boolean
      {
         return this._includeDescentInCellBounds;
      }
      
      public function set includeDescentInCellBounds(value:Boolean) : void
      {
         this._includeDescentInCellBounds = value;
      }
   }
}
