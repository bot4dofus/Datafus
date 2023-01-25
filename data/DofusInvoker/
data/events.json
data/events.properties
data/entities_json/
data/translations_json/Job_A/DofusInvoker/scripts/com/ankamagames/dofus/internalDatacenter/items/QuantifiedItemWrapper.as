package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.utils.display.spellZone.ICellZoneProvider;
   
   public class QuantifiedItemWrapper extends ItemWrapper implements ISlotData, ICellZoneProvider, IDataCenter
   {
       
      
      public function QuantifiedItemWrapper()
      {
         super();
      }
      
      public static function create(position:uint, objectUID:uint, objectGID:uint, quantity:uint, newEffects:Vector.<ObjectEffect>, useCache:Boolean = true) : QuantifiedItemWrapper
      {
         var item:ItemWrapper = ItemWrapper.create(position,objectUID,objectGID,quantity,newEffects,useCache);
         return item.clone(QuantifiedItemWrapper) as QuantifiedItemWrapper;
      }
      
      override public function get info1() : String
      {
         return quantity > 0 ? quantity.toString() : null;
      }
      
      override public function get active() : Boolean
      {
         return quantity > 0;
      }
      
      override public function toString() : String
      {
         return "[QuantifiedItemWrapper#" + objectUID + "_" + name + "]";
      }
   }
}
