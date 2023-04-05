package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class RandomDropItem implements IDataCenter
   {
       
      
      public var id:uint;
      
      public var itemId:uint;
      
      public var probability:Number;
      
      public var minQuantity:uint;
      
      public var maxQuantity:uint;
      
      private var _item:ItemWrapper;
      
      public function RandomDropItem()
      {
         super();
      }
      
      public function get itemWrapper() : ItemWrapper
      {
         if(!this._item)
         {
            this._item = ItemWrapper.create(0,0,this.itemId,0,null);
         }
         return this._item;
      }
   }
}
