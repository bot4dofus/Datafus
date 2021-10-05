package flashx.textLayout.elements
{
   public class CellCoordinates
   {
       
      
      private var _column:int;
      
      private var _row:int;
      
      public var table:TableElement;
      
      public function CellCoordinates(row:int, column:int, table:TableElement = null)
      {
         super();
         this._row = row;
         this._column = column;
         this.table = table;
      }
      
      public static function areEqual(coords1:CellCoordinates, coords2:CellCoordinates) : Boolean
      {
         return coords1.row == coords2.row && coords1.column == coords2.column;
      }
      
      public function get column() : int
      {
         return this._column;
      }
      
      public function set column(value:int) : void
      {
         this._column = value;
      }
      
      public function get row() : int
      {
         return this._row;
      }
      
      public function set row(value:int) : void
      {
         this._row = value;
      }
      
      public function isValid() : Boolean
      {
         return this.column > -1 && this.row > -1;
      }
      
      public function clone() : CellCoordinates
      {
         return new CellCoordinates(this.row,this.column);
      }
   }
}
