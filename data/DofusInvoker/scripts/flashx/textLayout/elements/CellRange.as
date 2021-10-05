package flashx.textLayout.elements
{
   public class CellRange
   {
       
      
      private var _table:TableElement;
      
      private var _anchorCoords:CellCoordinates;
      
      private var _activeCoords:CellCoordinates;
      
      public function CellRange(table:TableElement, anchorCoords:CellCoordinates, activeCoords:CellCoordinates)
      {
         super();
         this._table = table;
         this._anchorCoords = this.clampToRange(anchorCoords);
         this._activeCoords = this.clampToRange(activeCoords);
      }
      
      private function clampToRange(coords:CellCoordinates) : CellCoordinates
      {
         if(coords == null)
         {
            return null;
         }
         if(coords.row < 0)
         {
            coords.row = 0;
         }
         if(coords.column < 0)
         {
            coords.column = 0;
         }
         if(this._table == null)
         {
            return coords;
         }
         if(coords.row >= this._table.numRows)
         {
            coords.row = this._table.numRows - 1;
         }
         if(coords.column >= this._table.numColumns)
         {
            coords.column = this._table.numColumns - 1;
         }
         return coords;
      }
      
      public function updateRange(newAnchorCoordinates:CellCoordinates, newActiveCoordinates:CellCoordinates) : Boolean
      {
         this.clampToRange(newAnchorCoordinates);
         this.clampToRange(newActiveCoordinates);
         if(!CellCoordinates.areEqual(this._anchorCoords,newAnchorCoordinates) || !CellCoordinates.areEqual(this._activeCoords,newActiveCoordinates))
         {
            this._anchorCoords = newAnchorCoordinates;
            this._activeCoords = newActiveCoordinates;
            return true;
         }
         return false;
      }
      
      public function get table() : TableElement
      {
         return this._table;
      }
      
      public function set table(value:TableElement) : void
      {
         this._table = value;
      }
      
      public function get anchorCoordinates() : CellCoordinates
      {
         return this._anchorCoords;
      }
      
      public function set anchorCoordinates(value:CellCoordinates) : void
      {
         this._anchorCoords = value;
      }
      
      public function get activeCoordinates() : CellCoordinates
      {
         return this._activeCoords;
      }
      
      public function set activeCoordinates(value:CellCoordinates) : void
      {
         this._activeCoords = value;
      }
   }
}
