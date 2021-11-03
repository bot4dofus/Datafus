package com.ankamagames.dofus.internalDatacenter.stats
{
   public class DetailedStat extends Stat
   {
       
      
      protected var _baseValue:Number = 0;
      
      protected var _additionalValue:Number = 0;
      
      protected var _objectsAndMountBonusValue:Number = 0;
      
      protected var _alignGiftBonusValue:Number = 0;
      
      protected var _contextModifValue:Number = 0;
      
      public function DetailedStat(id:Number, baseValue:Number, additionalValue:Number, objectsAndMountBonusValue:Number, alignGiftBonusValue:Number, contextModifValue:Number)
      {
         this._baseValue = baseValue;
         this._additionalValue = additionalValue;
         this._objectsAndMountBonusValue = objectsAndMountBonusValue;
         this._alignGiftBonusValue = alignGiftBonusValue;
         this._contextModifValue = contextModifValue;
         super(id,this._baseValue + this._additionalValue + this._objectsAndMountBonusValue + this._alignGiftBonusValue + this._contextModifValue);
      }
      
      public function get baseValue() : Number
      {
         return this._baseValue;
      }
      
      public function get additionalValue() : Number
      {
         return this._additionalValue;
      }
      
      public function get objectsAndMountBonusValue() : Number
      {
         return this._objectsAndMountBonusValue;
      }
      
      public function get alignGiftBonusValue() : Number
      {
         return this._alignGiftBonusValue;
      }
      
      public function get contextModifValue() : Number
      {
         return this._contextModifValue;
      }
      
      public function set baseValue(value:Number) : void
      {
         this._baseValue = value;
         this.updateTotal();
      }
      
      public function set additionalValue(value:Number) : void
      {
         this._additionalValue = value;
         this.updateTotal();
      }
      
      public function set objectsAndMountBonusValue(value:Number) : void
      {
         this._objectsAndMountBonusValue = value;
         this.updateTotal();
      }
      
      public function set alignGiftBonusValue(value:Number) : void
      {
         this._alignGiftBonusValue = value;
         this.updateTotal();
      }
      
      public function set contextModifValue(value:Number) : void
      {
         this._contextModifValue = value;
         this.updateTotal();
      }
      
      override public function toString() : String
      {
         return getFormattedMessage("base: " + this._baseValue.toString() + " additional: " + this._additionalValue.toString() + " objectsAndMountBonus: " + this._objectsAndMountBonusValue.toString() + " alignGiftBonus: " + this._alignGiftBonusValue.toString() + " contextModif: " + this._contextModifValue.toString() + " total: " + _totalValue.toString());
      }
      
      override public function reset() : void
      {
         this._baseValue = this._additionalValue = this._objectsAndMountBonusValue = this._alignGiftBonusValue = this._contextModifValue = _totalValue = 0;
      }
      
      private function updateTotal() : void
      {
         _totalValue = this._baseValue + this._additionalValue + this._objectsAndMountBonusValue + this._alignGiftBonusValue + this._contextModifValue;
      }
   }
}
