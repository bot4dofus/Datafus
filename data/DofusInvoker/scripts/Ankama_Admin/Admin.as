package Ankama_Admin
{
   import Ankama_Admin.adminMenu.AdminMenu;
   import Ankama_Admin.adminMenu.items.MenuItem;
   import Ankama_Admin.ui.AdminSelectItem;
   import Ankama_ContextMenu.contextMenu.ContextMenuItem;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.dofus.internalDatacenter.house.HouseInstanceWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionGuild;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FileApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class Admin extends Sprite
   {
      
      private static var _self:Admin;
      
      private static var _adminMenu:AdminMenu;
       
      
      private var _include_SelectItem:AdminSelectItem = null;
      
      [Api(name="FileApi")]
      public var fileApi:FileApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="RoleplayApi")]
      public var roleplayApi:RoleplayApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playedCharacterApi:PlayedCharacterApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var contextMod:Object;
      
      [Module(name="Ankama_Console")]
      public var consoleMod:Object;
      
      public function Admin()
      {
         super();
      }
      
      public static function getInstance() : Admin
      {
         return _self;
      }
      
      public function main(... args) : void
      {
         if(!this.sysApi.hasRight())
         {
            return;
         }
         _self = this;
         Api.fileApi = this.fileApi;
         Api.uiApi = this.uiApi;
         Api.systemApi = this.sysApi;
         Api.dataApi = this.dataApi;
         Api.contextMod = this.contextMod;
         Api.consoleMod = this.consoleMod;
         _adminMenu = new AdminMenu();
         this.sysApi.addHook(HookList.MapComplementaryInformationsData,this.onGameStart);
         this.sysApi.addHook(CustomUiHookList.OpeningContextMenu,this.onOpeningContextMenu);
      }
      
      public function reloadXml() : void
      {
         _adminMenu = new AdminMenu();
      }
      
      private function onOpeningContextMenu(contextMenuData:ContextMenuData) : void
      {
         var info:Object = null;
         var tempContent:Array = null;
         var newMenu:Array = null;
         var elem:Object = null;
         var elem2:Object = null;
         var elem3:Object = null;
         var data:Object = null;
         var option:* = undefined;
         var playerInfos:Dictionary = null;
         var entity:IEntity = null;
         var cellId:uint = 0;
         var entities:Array = null;
         var subMenu:Object = null;
         var infos:GameContextActorInformations = null;
         var house:HouseWrapper = null;
         var houseInstance:HouseInstanceWrapper = null;
         var ownerSubItem:MenuItem = null;
         var ownerContextMenuItem:ContextMenuItem = null;
         if(contextMenuData)
         {
            info = {};
            info.m = this.playedCharacterApi.currentMap().mapId;
            info.n = this.playedCharacterApi.getPlayedCharacterInfo().name;
            info.s = this.sysApi.getCurrentServer().name;
            info.v = this.sysApi.getCurrentVersion();
            info.d = new Date().date;
            if(contextMenuData.makerName == "player")
            {
               if(contextMenuData.data)
               {
                  data = contextMenuData.data;
                  if(data.hasOwnProperty("name"))
                  {
                     info.p = data.name;
                  }
                  if(data is String)
                  {
                     info.p = data as String;
                  }
                  if(data.hasOwnProperty("humanoidInfo") && data.humanoidInfo.hasOwnProperty("options") && data.humanoidInfo.options)
                  {
                     if(data.humanoidInfo is HumanInformations)
                     {
                        for each(option in (data.humanoidInfo as HumanInformations).options)
                        {
                           if(option is HumanOptionGuild)
                           {
                              info.g = option.guildInformations.guildName;
                           }
                           if(option is HumanOptionAlliance)
                           {
                              info.a = option.allianceInformations.allianceName;
                           }
                        }
                     }
                  }
               }
               tempContent = [];
               newMenu = _adminMenu.process(info);
               for each(elem in newMenu)
               {
                  tempContent.push(elem);
               }
               for each(elem2 in contextMenuData.content)
               {
                  tempContent.push(elem2);
               }
               contextMenuData.content.length = 0;
               for each(elem3 in tempContent)
               {
                  contextMenuData.content.push(elem3);
               }
            }
            else if(contextMenuData.makerName == "multiplayer")
            {
               playerInfos = new Dictionary();
               entity = this.roleplayApi.getEntityByName(contextMenuData.data.name);
               cellId = entity.position.cellId;
               entities = this.roleplayApi.getEntitiesOnCell(cellId);
               for each(entity in entities)
               {
                  if(entity.id > 0)
                  {
                     infos = this.roleplayApi.getEntityInfos(entity);
                     if(!infos.hasOwnProperty("fight"))
                     {
                        playerInfos[infos["name"]] = infos;
                     }
                  }
               }
               for each(subMenu in contextMenuData.content)
               {
                  info = {};
                  data = playerInfos[subMenu.label];
                  if(data.hasOwnProperty("name"))
                  {
                     info.p = data.name;
                  }
                  if(data is String)
                  {
                     info.p = data as String;
                  }
                  if(data.hasOwnProperty("humanoidInfo") && data.humanoidInfo.hasOwnProperty("guildInformations") && data.humanoidInfo.guildInformations && data.humanoidInfo.guildInformations.guildName)
                  {
                     info.g = data.humanoidInfo.guildInformations.guildName;
                  }
                  subMenu.child = _adminMenu.process(info).concat(subMenu.child);
               }
            }
            else if(contextMenuData.makerName == "house")
            {
               house = contextMenuData.data;
               for each(houseInstance in house.houseInstances)
               {
                  if(houseInstance.hasOwner)
                  {
                     info = {"p":"*" + houseInstance.ownerName + "#" + houseInstance.ownerTag};
                     ownerSubItem = new MenuItem();
                     ownerSubItem.label = info.p;
                     ownerContextMenuItem = ownerSubItem.getContextMenuItem(info) as ContextMenuItem;
                     ownerContextMenuItem.child = _adminMenu.process(info);
                     contextMenuData.content.push(ownerContextMenuItem);
                  }
               }
            }
         }
      }
      
      private function onGameStart(... args) : void
      {
         this.sysApi.removeHook(HookList.MapComplementaryInformationsData);
         _adminMenu.onStart();
      }
   }
}
