package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.types.data.GridItem;
   
   public class ItemRightClickMessage extends ComponentMessage
   {
       
      
      private var _gridItem:GridItem;
      
      public function ItemRightClickMessage(grid:Grid, gridItem:GridItem)
      {
         super(grid);
         this._gridItem = gridItem;
      }
      
      public function get item() : GridItem
      {
         return this._gridItem;
      }
   }
}
