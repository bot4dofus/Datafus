package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildRightGroup implements IDataCenter
   {
      
      public static const MODULE:String = "GuildRightGroups";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildRightGroup));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildRightGroupById,getGuildRightGroups);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var order:int;
      
      public var guildRights:Vector.<GuildRight>;
      
      private var _name:String;
      
      private var _sortedGuildRightsByOrder:Vector.<GuildRight>;
      
      public function GuildRightGroup()
      {
         super();
      }
      
      public static function getGuildRightGroupById(id:int) : GuildRightGroup
      {
         return GameData.getObject(MODULE,id) as GuildRightGroup;
      }
      
      public static function getGuildRightGroups() : Array
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
      
      public function getSortedGuildRightsByOrder() : Vector.<GuildRight>
      {
         var utilApi:UtilApi = null;
         if(!this._sortedGuildRightsByOrder)
         {
            utilApi = new UtilApi();
            this._sortedGuildRightsByOrder = utilApi.sort(this.guildRights,"order",true,true);
         }
         return this._sortedGuildRightsByOrder;
      }
   }
}
