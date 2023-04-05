package com.ankamagames.dofus.datacenter.servers
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class ServerGameType implements IDataCenter
   {
      
      public static const MODULE:String = "ServerGameTypes";
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(ServerGameType));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getServerGameTypeById,getServerGameTypes);
       
      
      public var id:int;
      
      public var selectableByPlayer:Boolean;
      
      public var nameId:uint;
      
      public var rulesId:uint;
      
      public var descriptionId:uint;
      
      private var _name:String;
      
      private var _rules:String;
      
      private var _description:String;
      
      public function ServerGameType()
      {
         super();
      }
      
      public static function getServerGameTypeById(id:int) : ServerGameType
      {
         return GameData.getObject(MODULE,id) as ServerGameType;
      }
      
      public static function getServerGameTypes() : Array
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
      
      public function get rules() : String
      {
         if(!this._rules)
         {
            this._rules = I18n.getText(this.rulesId);
         }
         return this._rules;
      }
      
      public function get description() : String
      {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
   }
}
