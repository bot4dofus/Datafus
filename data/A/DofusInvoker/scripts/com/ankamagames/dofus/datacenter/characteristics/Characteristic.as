package com.ankamagames.dofus.datacenter.characteristics
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Characteristic implements IDataCenter
   {
      
      public static const MODULE:String = "Characteristics";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Characteristic));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getCharacteristicById,getCharacteristics);
       
      
      public var id:int;
      
      public var keyword:String;
      
      public var nameId:uint;
      
      public var asset:String;
      
      public var categoryId:int;
      
      public var visible:Boolean;
      
      public var order:int;
      
      public var scaleFormulaId:int;
      
      public var upgradable:Boolean;
      
      private var _name:String;
      
      public function Characteristic()
      {
         super();
      }
      
      public static function getCharacteristicById(id:int) : Characteristic
      {
         return GameData.getObject(MODULE,id) as Characteristic;
      }
      
      public static function getCharacteristics() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
