package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildRight implements IDataCenter
   {
      
      public static const MODULE:String = "GuildRights";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildRight));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildRightById,getGuildRights);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var order:int;
      
      public var groupId:int;
      
      private var _name:String;
      
      public function GuildRight()
      {
         super();
      }
      
      public static function getGuildRightById(id:int) : GuildRight
      {
         return GameData.getObject(MODULE,id) as GuildRight;
      }
      
      public static function getGuildRights() : Array
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
