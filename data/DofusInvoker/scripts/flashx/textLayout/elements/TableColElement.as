package flashx.textLayout.elements
{
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   public final class TableColElement extends TableFormattedElement
   {
       
      
      public var x:Number;
      
      public var colIndex:int;
      
      public function TableColElement(format:ITextLayoutFormat = null)
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
         return "col";
      }
      
      override tlf_internal function canOwnFlowElement(elem:FlowElement) : Boolean
      {
         return false;
      }
      
      override tlf_internal function modelChanged(changeType:String, elem:FlowElement, changeStart:int, changeLen:int, needNormalize:Boolean = true, bumpGeneration:Boolean = true) : void
      {
         super.modelChanged(changeType,elem,changeStart,changeLen,needNormalize,bumpGeneration);
      }
      
      public function get cells() : Vector.<TableCellElement>
      {
         if(!table)
         {
            return null;
         }
         return table.getCellsForColumn(this);
      }
      
      public function get numCells() : int
      {
         if(!table)
         {
            return 0;
         }
         return table.getCellsForColumn(this).length;
      }
   }
}
