package com.ankamagames.dofus.internalDatacenter.stats
{
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import damageCalculation.tools.StatIds;
   
   public class Stat
   {
      
      public static const UNKNOWN_STAT_NAME:String = "unknown";
       
      
      protected var _id:Number;
      
      protected var _totalValue:Number = 0;
      
      protected var _name:String = null;
      
      public function Stat(id:Number, totalValue:Number)
      {
         this._id = StatIds.UNKNOWN;
         super();
         this._id = id;
         this._totalValue = totalValue;
         this._name = this.getStatName();
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get totalValue() : Number
      {
         return this._totalValue;
      }
      
      public function set totalValue(value:Number) : void
      {
         this._totalValue = value;
      }
      
      public function toString() : String
      {
         return this.getFormattedMessage("total: " + this._totalValue.toString());
      }
      
      public function reset() : void
      {
         this._totalValue = 0;
      }
      
      protected function getStatName() : String
      {
         var characteristic:Characteristic = Characteristic.getCharacteristicById(this._id);
         if(characteristic !== null)
         {
            return characteristic.keyword;
         }
         return UNKNOWN_STAT_NAME;
      }
      
      protected function getFormattedMessage(message:String) : String
      {
         return "";
      }
   }
}
