package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class VeteranReward implements IDataCenter
   {
      
      public static const MODULE:String = "VeteranRewards";
       
      
      public var id:int;
      
      public var requiredSubDays:uint;
      
      public var itemGID:uint;
      
      public var itemQuantity:uint;
      
      private var _itemWrapper:ItemWrapper;
      
      public function VeteranReward()
      {
         super();
      }
      
      public static function getAllVeteranRewards() : Array
      {
         return GameData.getObjects(MODULE) as Array;
      }
      
      public function get item() : ItemWrapper
      {
         if(!this._itemWrapper)
         {
            this._itemWrapper = ItemWrapper.create(0,0,this.itemGID,this.itemQuantity,null,false);
         }
         return this._itemWrapper;
      }
   }
}
