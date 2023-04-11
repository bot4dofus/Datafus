package com.ankamagames.dofus.internalDatacenter.stats
{
   public class UsableStat extends DetailedStat
   {
       
      
      public var usedValue:Number = 0;
      
      public function UsableStat(id:Number, baseValue:Number, additionalValue:Number, objectsAndMountBonusValue:Number, alignGiftBonusValue:Number, contextModifValue:Number, usedValue:Number)
      {
         super(id,baseValue,additionalValue,objectsAndMountBonusValue,alignGiftBonusValue,contextModifValue);
         this.usedValue = usedValue;
      }
      
      override public function toString() : String
      {
         return getFormattedMessage("base: " + _baseValue.toString() + " additional: " + _additionalValue.toString() + " objectsAndMountBonus: " + _objectsAndMountBonusValue.toString() + " alignGiftBonus: " + _alignGiftBonusValue.toString() + " contextModif: " + _contextModifValue.toString() + " used: " + this.usedValue.toString() + " total: " + _totalValue.toString());
      }
      
      override public function reset() : void
      {
         _baseValue = _additionalValue = _objectsAndMountBonusValue = _alignGiftBonusValue = _contextModifValue = this.usedValue = _totalValue = 0;
      }
   }
}
