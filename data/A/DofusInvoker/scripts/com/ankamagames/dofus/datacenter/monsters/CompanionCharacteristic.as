package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class CompanionCharacteristic implements IDataCenter
   {
      
      public static const MODULE:String = "CompanionCharacteristics";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getCompanionCharacteristicById,getCompanionCharacteristics);
       
      
      public var id:int;
      
      public var caracId:int;
      
      public var companionId:int;
      
      public var order:int;
      
      public var statPerLevelRange:Vector.<Vector.<Number>>;
      
      private var _name:String;
      
      public function CompanionCharacteristic()
      {
         super();
      }
      
      public static function getCompanionCharacteristicById(id:uint) : CompanionCharacteristic
      {
         return GameData.getObject(MODULE,id) as CompanionCharacteristic;
      }
      
      public static function getCompanionCharacteristics() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         var carac:Characteristic = null;
         if(!this._name)
         {
            carac = Characteristic.getCharacteristicById(this.caracId);
            if(carac)
            {
               this._name = carac.name;
            }
            else
            {
               this._name = "???";
            }
         }
         return this._name;
      }
   }
}
