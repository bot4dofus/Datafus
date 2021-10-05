package flashx.textLayout.elements
{
   public class TableFormattedElement extends ContainerFormattedElement
   {
       
      
      private var _table:TableElement;
      
      public function TableFormattedElement()
      {
         super();
      }
      
      public function getTable() : TableElement
      {
         var elem:FlowGroupElement = this;
         while(elem.parent != null && !(elem.parent is TableElement))
         {
            elem = elem.parent;
         }
         return elem.parent as TableElement;
      }
      
      public function get table() : TableElement
      {
         if(this._table)
         {
            return this._table;
         }
         var elem:FlowGroupElement = this;
         while(elem.parent != null && !(elem.parent is TableElement))
         {
            elem = elem.parent;
         }
         this._table = elem.parent as TableElement;
         return this._table;
      }
      
      public function set table(element:TableElement) : void
      {
         this._table = element;
      }
   }
}
