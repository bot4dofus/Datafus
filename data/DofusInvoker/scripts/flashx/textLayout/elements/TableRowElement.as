package flashx.textLayout.elements
{
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TableRowElement extends TableFormattedElement
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var height:Number;
      
      public var rowIndex:int;
      
      public var parcelIndex:int;
      
      public var columnIndex:Number = 0;
      
      public var iMaxRowDepth:Number = 0;
      
      public var beyondParcel:Boolean = false;
      
      public var composedHeight:Number = 0;
      
      public var totalHeight:Number = 0;
      
      public var isMaxHeight:Boolean = false;
      
      public function TableRowElement(format:ITextLayoutFormat = null)
      {
         super();
         if(format)
         {
            this.format = format;
         }
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "tr";
      }
      
      override tlf_internal function canOwnFlowElement(elem:FlowElement) : Boolean
      {
         return elem is TableCellElement;
      }
      
      override tlf_internal function modelChanged(changeType:String, elem:FlowElement, changeStart:int, changeLen:int, needNormalize:Boolean = true, bumpGeneration:Boolean = true) : void
      {
         super.modelChanged(changeType,elem,changeStart,changeLen,needNormalize,bumpGeneration);
      }
      
      public function getCells() : Vector.<TableCellElement>
      {
         var table:TableElement = getTable();
         if(!table)
         {
            return null;
         }
         return table.getCellsForRow(this);
      }
      
      public function get cells() : Array
      {
         var table:TableElement = getTable();
         if(!table)
         {
            return null;
         }
         return table.getCellsForRowArray(this);
      }
      
      public function get numCells() : int
      {
         var table:TableElement = getTable();
         if(!table)
         {
            return 0;
         }
         return table.getCellsForRow(this).length;
      }
      
      public function getCellAt(index:int) : TableCellElement
      {
         var cells:Vector.<TableCellElement> = this.getCells();
         if(!cells || index < 0 || index >= cells.length)
         {
            return null;
         }
         return cells[index];
      }
      
      public function addCell(cell:TableCellElement) : TableCellElement
      {
         var table:TableElement = getTable();
         var cellLength:int = numChildren;
         if(!table)
         {
            throw new Error("Table must be set");
         }
         cell.rowIndex = this.rowIndex;
         if(cell.colIndex == -1)
         {
            cell.colIndex = cellLength;
         }
         this.cells.push(cell);
         return cell;
      }
      
      public function addCellAt(index:int) : TableCellElement
      {
         throw new Error("Add cell at is not implemented");
      }
      
      public function getColumnCount() : int
      {
         return int(this.numCells) || int(numChildren);
      }
   }
}
