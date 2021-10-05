package flashx.textLayout.compose
{
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.text.engine.TextLine;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.edit.SelectionFormat;
   import flashx.textLayout.elements.CellContainer;
   import flashx.textLayout.elements.CellCoordinates;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.TableBlockContainer;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TextFlowTableBlock extends TextFlowLine
   {
       
      
      private var _textHeight:Number;
      
      public var parentTable:TableElement;
      
      public var blockIndex:uint = 0;
      
      private var _container:TableBlockContainer;
      
      private var _cells:Array;
      
      public function TextFlowTableBlock(index:uint)
      {
         this.blockIndex = index;
         this._container = new TableBlockContainer();
         super(null,null);
      }
      
      override tlf_internal function initialize(paragraph:ParagraphElement, outerTargetWidth:Number = 0, lineOffset:Number = 0, absoluteStart:int = 0, numChars:int = 0, textLine:TextLine = null) : void
      {
         this._container.userData = this;
         _lineOffset = lineOffset;
         super.initialize(paragraph,outerTargetWidth,lineOffset,absoluteStart,numChars,textLine);
      }
      
      override tlf_internal function setController(cont:ContainerController, colNumber:int) : void
      {
         super.setController(cont,colNumber);
         if(cont)
         {
            controller.addComposedTableBlock(this.container);
         }
      }
      
      private function getCells() : Array
      {
         if(this._cells == null)
         {
            this._cells = [];
         }
         return this._cells;
      }
      
      public function getCellsInRange(anchorCoords:CellCoordinates, activeCoords:CellCoordinates) : Vector.<TableCellElement>
      {
         if(!this.parentTable)
         {
            return null;
         }
         return this.parentTable.getCellsInRange(anchorCoords,activeCoords,this);
      }
      
      public function clear() : void
      {
         this.clearCells();
      }
      
      public function clearCells() : void
      {
         this._container.removeChildren();
         this.getCells().length = 0;
      }
      
      public function addCell(cell:CellContainer) : void
      {
         var cells:Array = this.getCells();
         if(cells.indexOf(cell) < 0)
         {
            cells.push(cell);
            this._container.addChild(cell);
         }
      }
      
      public function drawBackground(backgroundInfo:*) : void
      {
      }
      
      public function get container() : TableBlockContainer
      {
         return this._container;
      }
      
      public function updateCompositionShapes() : void
      {
         var cell:CellContainer = null;
         var cells:Array = this.getCells();
         for each(cell in cells)
         {
            cell.element.updateCompositionShapes();
         }
      }
      
      public function set height(value:Number) : void
      {
         this._textHeight = value;
      }
      
      override public function get height() : Number
      {
         return this._textHeight;
      }
      
      public function set width(value:Number) : void
      {
         this._container.width = value;
      }
      
      public function get width() : Number
      {
         return this._container.width;
      }
      
      override public function set x(value:Number) : void
      {
         super.x = this._container.x = value;
      }
      
      override public function get x() : Number
      {
         return this._container.x;
      }
      
      override public function set y(value:Number) : void
      {
         super.y = this._container.y = value;
      }
      
      override public function get y() : Number
      {
         return this._container.y;
      }
      
      public function getTableCells() : Vector.<TableCellElement>
      {
         var cellContainer:CellContainer = null;
         var tCells:Vector.<TableCellElement> = new Vector.<TableCellElement>();
         var cells:Array = this.getCells();
         for each(cellContainer in cells)
         {
            tCells.push(cellContainer.element);
         }
         return tCells;
      }
      
      override public function get textHeight() : Number
      {
         return this._textHeight;
      }
      
      override tlf_internal function hiliteBlockSelection(selObj:Shape, selFormat:SelectionFormat, container:DisplayObject, begIdx:int, endIdx:int, prevLine:TextFlowLine, nextLine:TextFlowLine) : void
      {
      }
   }
}
