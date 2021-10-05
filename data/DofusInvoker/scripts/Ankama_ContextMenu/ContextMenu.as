package Ankama_ContextMenu
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.behaviors.IMenuBehavior;
   import Ankama_ContextMenu.behaviors.TutorialMenuBehavior;
   import Ankama_ContextMenu.contextMenu.ContextMenuItem;
   import Ankama_ContextMenu.contextMenu.ContextMenuManager;
   import Ankama_ContextMenu.contextMenu.ContextMenuPictureItem;
   import Ankama_ContextMenu.contextMenu.ContextMenuPictureLabelItem;
   import Ankama_ContextMenu.contextMenu.ContextMenuSeparator;
   import Ankama_ContextMenu.contextMenu.ContextMenuTitle;
   import Ankama_ContextMenu.makers.AccountMenuMaker;
   import Ankama_ContextMenu.makers.CompanionMenuMaker;
   import Ankama_ContextMenu.makers.FightAllyMenuMaker;
   import Ankama_ContextMenu.makers.FightWorldMenuMaker;
   import Ankama_ContextMenu.makers.HouseMenuMaker;
   import Ankama_ContextMenu.makers.HumanVendorMenuMaker;
   import Ankama_ContextMenu.makers.InteractiveElementMenuMaker;
   import Ankama_ContextMenu.makers.ItemMenuMaker;
   import Ankama_ContextMenu.makers.MapFlagMenuMaker;
   import Ankama_ContextMenu.makers.MonsterGroupMenuMaker;
   import Ankama_ContextMenu.makers.MountMenuMaker;
   import Ankama_ContextMenu.makers.MultiPlayerMenuMaker;
   import Ankama_ContextMenu.makers.NpcMenuMaker;
   import Ankama_ContextMenu.makers.PaddockItemMenuMaker;
   import Ankama_ContextMenu.makers.PartyMemberMenuMaker;
   import Ankama_ContextMenu.makers.PlayerMenuMaker;
   import Ankama_ContextMenu.makers.PortalMenuMaker;
   import Ankama_ContextMenu.makers.PrismMenuMaker;
   import Ankama_ContextMenu.makers.SkillMenuMaker;
   import Ankama_ContextMenu.makers.SpellMenuMaker;
   import Ankama_ContextMenu.makers.TaxCollectorMenuMaker;
   import Ankama_ContextMenu.makers.WorldMenuMaker;
   import Ankama_ContextMenu.ui.ContextMenuUi;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.AlignmentApi;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.ChatServiceApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.MountApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.display.Sprite;
   
   public class ContextMenu extends Sprite
   {
      
      private static var _self:ContextMenu;
       
      
      private var include_ContextMenuUi:ContextMenuUi = null;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="AlignmentApi")]
      public var alignApi:AlignmentApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="MountApi")]
      public var mountApi:MountApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="BreachApi")]
      public var breachApi:BreachApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="ChatServiceApi")]
      public var chatServiceApi:ChatServiceApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="RoleplayApi")]
      public var roleplayApi:RoleplayApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      public var playersNamesVisible:Boolean;
      
      private var _behavior:IMenuBehavior;
      
      public function ContextMenu()
      {
         super();
      }
      
      public static function getInstance() : ContextMenu
      {
         return _self;
      }
      
      public static function static_createContextMenuTitleObject(label:String, parseText:Boolean = true) : ContextMenuTitle
      {
         return new ContextMenuTitle(label,parseText);
      }
      
      public static function static_createContextMenuItemObject(label:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = true, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuItem
      {
         return new ContextMenuItem(label,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public static function static_createContextMenuPictureItemObject(uri:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuPictureItem
      {
         return new ContextMenuPictureItem(uri,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public static function static_createContextMenuPictureLabelItemObject(uri:String, label:String, textureSize:int, after:Boolean = false, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuPictureLabelItem
      {
         return new ContextMenuPictureLabelItem(uri,label,textureSize,after,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public static function static_createContextMenuSeparatorObject() : ContextMenuSeparator
      {
         return new ContextMenuSeparator();
      }
      
      public function main() : void
      {
         _self = this;
         Api.system = this.sysApi;
         Api.config = this.configApi;
         Api.ui = this.uiApi;
         Api.menu = this.menuApi;
         Api.data = this.dataApi;
         Api.alignment = this.alignApi;
         Api.fight = this.fightApi;
         Api.player = this.playerApi;
         Api.map = this.mapApi;
         Api.social = this.socialApi;
         Api.jobs = this.jobsApi;
         Api.mount = this.mountApi;
         Api.modCommon = this.modCommon;
         Api.roleplay = this.roleplayApi;
         Api.party = this.partyApi;
         Api.binds = this.bindsApi;
         Api.time = this.timeApi;
         Api.storage = this.storageApi;
         Api.tooltip = this.tooltipApi;
         Api.util = this.utilApi;
         Api.breachApi = this.breachApi;
         Api.inventoryApi = this.inventoryApi;
         Api.modMenu = this;
         Api.chatServiceApi = this.chatServiceApi;
         this.sysApi.addHook(HookList.ShowPlayersNames,this.onShowPlayersNames);
         this.menuApi.registerMenuMaker("humanVendor",HumanVendorMenuMaker);
         this.menuApi.registerMenuMaker("multiplayer",MultiPlayerMenuMaker);
         this.menuApi.registerMenuMaker("player",PlayerMenuMaker);
         this.menuApi.registerMenuMaker("mutant",PlayerMenuMaker);
         this.menuApi.registerMenuMaker("account",AccountMenuMaker);
         this.menuApi.registerMenuMaker("spell",SpellMenuMaker);
         this.menuApi.registerMenuMaker("item",ItemMenuMaker);
         this.menuApi.registerMenuMaker("paddockItem",PaddockItemMenuMaker);
         this.menuApi.registerMenuMaker("npc",NpcMenuMaker);
         this.menuApi.registerMenuMaker("taxCollector",TaxCollectorMenuMaker);
         this.menuApi.registerMenuMaker("prism",PrismMenuMaker);
         this.menuApi.registerMenuMaker("portal",PortalMenuMaker);
         this.menuApi.registerMenuMaker("skill",SkillMenuMaker);
         this.menuApi.registerMenuMaker("partyMember",PartyMemberMenuMaker);
         this.menuApi.registerMenuMaker("mount",MountMenuMaker);
         this.menuApi.registerMenuMaker("world",WorldMenuMaker);
         this.menuApi.registerMenuMaker("fightWorld",FightWorldMenuMaker);
         this.menuApi.registerMenuMaker("mapFlag",MapFlagMenuMaker);
         this.menuApi.registerMenuMaker("monsterGroup",MonsterGroupMenuMaker);
         this.menuApi.registerMenuMaker("companion",CompanionMenuMaker);
         this.menuApi.registerMenuMaker("fightAlly",FightAllyMenuMaker);
         this.menuApi.registerMenuMaker("interactiveElement",InteractiveElementMenuMaker);
         this.menuApi.registerMenuMaker("house",HouseMenuMaker);
      }
      
      public function getMenuMaker(label:String) : Object
      {
         return this.menuApi.getMenuMaker(label);
      }
      
      public function createContextMenuTitleObject(label:String, parseText:Boolean = true) : ContextMenuTitle
      {
         return static_createContextMenuTitleObject(label,parseText);
      }
      
      public function createContextMenuItemObject(label:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = true, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuItem
      {
         return static_createContextMenuItemObject(label,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public function createContextMenuPictureItemObject(uri:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuPictureItem
      {
         return static_createContextMenuPictureItemObject(uri,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public function createContextMenuPictureLabelItemObject(uri:String, label:String, textureSize:int, after:Boolean, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = "", forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuPictureLabelItem
      {
         return static_createContextMenuPictureLabelItemObject(uri,label,textureSize,after,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public function createContextMenuSeparatorObject() : ContextMenuSeparator
      {
         return static_createContextMenuSeparatorObject();
      }
      
      public function closeAllMenu() : void
      {
         ContextMenuManager.getInstance().closeAll();
      }
      
      public function createContextMenu(menu:*, positionReference:Object = null, closeCallBack:Function = null, instanceName:String = null, pContainer:UiRootContainer = null) : void
      {
         if(menu == null)
         {
            return;
         }
         if(menu is Array)
         {
            var menu:* = this.menuApi.create(null,null,menu);
         }
         try
         {
            this.sysApi.dispatchHook(CustomUiHookList.OpeningContextMenu,menu);
         }
         catch(e:Error)
         {
            sysApi.log(8,"Context menu exception : " + e);
         }
         var resultMenu:* = menu is Array ? menu : menu.content;
         if(!positionReference && pContainer)
         {
            var positionReference:Object = {
               "x":pContainer.mouseX + 5,
               "y":pContainer.mouseY + 5
            };
         }
         ContextMenuManager.getInstance().openNew(resultMenu,positionReference,closeCallBack,false,instanceName,pContainer);
      }
      
      public function setBehavior(pBehaviorName:String, pBehaviorParams:Object = null) : void
      {
         switch(pBehaviorName)
         {
            case "tutorial":
               this._behavior = new TutorialMenuBehavior(pBehaviorParams);
               break;
            case null:
               this._behavior = null;
         }
      }
      
      public function getBehavior() : IMenuBehavior
      {
         return this._behavior;
      }
      
      public function unload() : void
      {
         Api.system = null;
         Api.config = null;
         Api.ui = null;
         Api.menu = null;
         Api.data = null;
         Api.alignment = null;
         Api.fight = null;
         Api.player = null;
         Api.map = null;
         Api.social = null;
         Api.jobs = null;
         Api.mount = null;
         Api.modCommon = null;
         Api.roleplay = null;
         Api.party = null;
         Api.binds = null;
         Api.time = null;
         Api.storage = null;
         Api.modMenu = null;
         ContextMenuManager.unload();
      }
      
      private function onShowPlayersNames(value:Boolean) : void
      {
         this.playersNamesVisible = value;
      }
   }
}
