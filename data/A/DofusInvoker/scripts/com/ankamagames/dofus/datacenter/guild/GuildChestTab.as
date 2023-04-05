package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class GuildChestTab
   {
      
      public static const MODULE:String = "GuildChestTabs";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildChestTabById,getGuildChestTabs);
       
      
      public var tabId:int;
      
      public var nameId:uint;
      
      public var index:uint;
      
      public var gfxId:uint;
      
      public var serverType:int;
      
      public var cost:uint;
      
      public var seniority:uint;
      
      public var openRight:uint;
      
      public var dropRight:uint;
      
      public var takeRight:uint;
      
      private var _name:String;
      
      public function GuildChestTab()
      {
         super();
      }
      
      public static function getGuildChestTabById(id:uint) : GuildChestTab
      {
         return GameData.getObject(MODULE,id) as GuildChestTab;
      }
      
      public static function getGuildChestTabByIndex(index:uint) : GuildChestTab
      {
         var tab:GuildChestTab = null;
         var tabs:Vector.<GuildChestTab> = getGuildChestTabsByServerType(PlayerManager.getInstance().server.gameTypeId);
         if(tabs.length == 0)
         {
            tabs = getGuildChestTabsByServerType(-1);
         }
         for each(tab in tabs)
         {
            if(tab.index === index)
            {
               return tab;
            }
         }
         return null;
      }
      
      public static function getGuildChestTabsByServerType(serverType:int) : Vector.<GuildChestTab>
      {
         var tab:GuildChestTab = null;
         var tabs:Array = getGuildChestTabs();
         var filteredTabs:Vector.<GuildChestTab> = new Vector.<GuildChestTab>();
         for each(tab in tabs)
         {
            if(tab.serverType === serverType)
            {
               filteredTabs.push(tab);
            }
         }
         return filteredTabs;
      }
      
      public static function getGuildChestTabs() : Array
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
