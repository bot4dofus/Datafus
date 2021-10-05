package flashx.textLayout.elements
{
   import flash.display.Sprite;
   import flashx.textLayout.compose.TextFlowTableBlock;
   
   public class TableBlockContainer extends Sprite
   {
       
      
      public var userData:TextFlowTableBlock;
      
      public function TableBlockContainer()
      {
         super();
      }
      
      public function getTableWidth() : Number
      {
         if(!this.userData)
         {
            return NaN;
         }
         if(!this.userData.parentTable)
         {
            return NaN;
         }
         return this.userData.parentTable.width;
      }
   }
}
