package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public class ItemRollOutMessage extends ComponentMessage
   {
       
      
      private var _gridItem:GridItem;
      
      public function ItemRollOutMessage(target:GraphicContainer, gridItem:GridItem)
      {
         super(target);
         this._gridItem = gridItem;
      }
      
      public function get item() : GridItem
      {
         return this._gridItem;
      }
   }
}
