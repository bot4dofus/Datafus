package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Month implements IDataCenter
   {
      
      public static const MODULE:String = "Months";
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(Month));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getMonthById,getMonths);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function Month()
      {
         super();
      }
      
      public static function getMonthById(id:int) : Month
      {
         return GameData.getObject(MODULE,id) as Month;
      }
      
      public static function getMonths() : Array
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
