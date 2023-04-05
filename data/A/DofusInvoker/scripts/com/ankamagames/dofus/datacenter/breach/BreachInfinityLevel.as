package com.ankamagames.dofus.datacenter.breach
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class BreachInfinityLevel implements IDataCenter
   {
      
      public static const MODULE:String = "BreachInfinityLevels";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getBreachInfinityLevelById,getAllBreachInfinityLevel);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var level:uint;
      
      private var _name:String;
      
      public function BreachInfinityLevel()
      {
         super();
      }
      
      public static function getBreachInfinityLevelById(id:int) : BreachInfinityLevel
      {
         return GameData.getObject(MODULE,id) as BreachInfinityLevel;
      }
      
      public static function getAllBreachInfinityLevel() : Array
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
