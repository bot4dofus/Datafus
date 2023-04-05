package com.ankamagames.dofus.datacenter.abuse
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AbuseReasons implements IDataCenter
   {
      
      public static const MODULE:String = "AbuseReasons";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbuseReasons));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getReasonNameById,getReasonNames);
       
      
      public var abuseReasonId:uint;
      
      public var mask:uint;
      
      public var reasonTextId:int;
      
      private var _name:String;
      
      public function AbuseReasons()
      {
         super();
      }
      
      public static function getReasonNameById(id:uint) : AbuseReasons
      {
         return GameData.getObject(MODULE,id) as AbuseReasons;
      }
      
      public static function getReasonNames() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.reasonTextId);
         }
         return this._name;
      }
   }
}
