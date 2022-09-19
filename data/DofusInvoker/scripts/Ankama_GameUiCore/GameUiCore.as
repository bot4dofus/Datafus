package Ankama_GameUiCore
{
   import Ankama_Cartography.Cartography;
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_GameUiCore.managers.ExternalNotificationManager;
   import Ankama_GameUiCore.ui.ActionBar;
   import Ankama_GameUiCore.ui.Banner;
   import Ankama_GameUiCore.ui.BannerMenu;
   import Ankama_GameUiCore.ui.Chat;
   import Ankama_GameUiCore.ui.CinematicPlayer;
   import Ankama_GameUiCore.ui.ExternalActionBar;
   import Ankama_GameUiCore.ui.ExternalNotificationUi;
   import Ankama_GameUiCore.ui.FightModificatorUi;
   import Ankama_GameUiCore.ui.HardcoreDeath;
   import Ankama_GameUiCore.ui.KISInfractionPopup;
   import Ankama_GameUiCore.ui.KISPopUp;
   import Ankama_GameUiCore.ui.KISPreventAndSanctionPopup;
   import Ankama_GameUiCore.ui.MainMenu;
   import Ankama_GameUiCore.ui.MapInfo;
   import Ankama_GameUiCore.ui.ModalCover;
   import Ankama_GameUiCore.ui.OfflineSales;
   import Ankama_GameUiCore.ui.PayZone;
   import Ankama_GameUiCore.ui.Proto;
   import Ankama_GameUiCore.ui.Report;
   import Ankama_GameUiCore.ui.RewardsUi;
   import Ankama_GameUiCore.ui.Smileys;
   import Ankama_GameUiCore.ui.Zoom;
   import Ankama_GameUiCore.ui.alterations.AlterationsUi;
   import Ankama_GameUiCore.ui.alterations.PreviewedAlterationsUi;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationsDescr;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.GameRolePlayFreeSoulRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectDropAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightFriendlyAnswerAction;
   import com.ankamagames.dofus.logic.game.roleplay.frames.AlterationFrame;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.ExternalNotificationApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.HighlightApi;
   import com.ankamagames.dofus.uiApi.NotificationApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class GameUiCore extends Sprite
   {
      
      private static var _self:GameUiCore;
      
      private static const TOOLTIP_TARGET:Rectangle = new Rectangle(20,20,0,0);
       
      
      protected var banner:Banner;
      
      protected var bannerMenu:BannerMenu;
      
      protected var actionBar:ActionBar;
      
      protected var externalActionBar:ExternalActionBar;
      
      protected var chat:Chat;
      
      protected var smileys:Smileys;
      
      protected var mapInfo:MapInfo;
      
      protected var mainMenu:MainMenu;
      
      protected var payZone:PayZone;
      
      protected var hardcoreDeath:HardcoreDeath;
      
      protected var previewedAlterationsUi:PreviewedAlterationsUi;
      
      protected var alterationsUi:AlterationsUi;
      
      protected var fightModificatorUi:FightModificatorUi;
      
      protected var rewardsUi:RewardsUi;
      
      protected var report:Report;
      
      protected var zoom:Zoom;
      
      protected var cinematic:CinematicPlayer;
      
      protected var externalnotification:ExternalNotificationUi;
      
      protected var offlineSales:OfflineSales;
      
      protected var proto:Proto;
      
      protected var modalCover:ModalCover;
      
      protected var kisPopUp:KISPopUp = null;
      
      protected var kisInfractionPopup:KISInfractionPopup = null;
      
      protected var kisPreventSanctionPopup:KISPreventAndSanctionPopup = null;
      
      public const MILLISECONDS_IN_DAY:Number = 86400000;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="NotificationApi")]
      public var notifApi:NotificationApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="ExternalNotificationApi")]
      public var extNotifApi:ExternalNotificationApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="HighlightApi")]
      public var highlight:HighlightApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Cartography")]
      public var modCartography:Cartography;
      
      private var _channels:Object;
      
      private var _currentPopupName:String;
      
      private var _waitingObject:Object;
      
      private var _waitingObjectName:String;
      
      private var _waitingObjectQuantity:int;
      
      private var _folded:Boolean = false;
      
      private var _ignoreName:String;
      
      private var _aTextInfos:Array;
      
      private var _inactivityPopup:String = null;
      
      public var areGiftsRequired:Boolean;
      
      public function GameUiCore()
      {
         this._aTextInfos = [];
         super();
      }
      
      public static function getInstance() : GameUiCore
      {
         return _self;
      }
      
      public function main() : void
      {
         Api.system = this.sysApi;
         Api.ui = this.uiApi;
         Api.extNotif = this.extNotifApi;
         Api.social = this.socialApi;
         Api.fight = this.fightApi;
         Api.player = this.playerApi;
         Api.data = this.dataApi;
         Api.chat = this.chatApi;
         Api.util = this.utilApi;
         Api.highlight = this.highlight;
         ExternalNotificationManager.getInstance().init();
         this.sysApi.addHook(HookList.GameStart,this.onGameStart);
         this.sysApi.addHook(HookList.SmileysStart,this.onSmileysStart);
         this.sysApi.addHook(ChatHookList.EnabledChannels,this.onEnabledChannels);
         this.sysApi.addHook(ChatHookList.TextInformation,this.onTextInformation);
         this.sysApi.addHook(RoleplayHookList.PlayerFightRequestSent,this.onPlayerFightRequestSent);
         this.sysApi.addHook(RoleplayHookList.PlayerFightFriendlyRequested,this.onPlayerFightFriendlyRequested);
         this.sysApi.addHook(RoleplayHookList.PlayerFightFriendlyAnswered,this.onPlayerFightFriendlyAnswered);
         this.sysApi.addHook(RoleplayHookList.Alterations,this.onAlterations);
         this.sysApi.addHook(RoleplayHookList.AlterationAdded,this.onAlterationAdded);
         this.sysApi.addHook(RoleplayHookList.AlterationsUpdated,this.onAlterationsUpdated);
         this.sysApi.addHook(RoleplayHookList.OpenAlterationUi,this.onOpenAlterationUi);
         this.sysApi.addHook(RoleplayHookList.DisplayAlterationPinnedTooltip,this.onAlterationPinnedTooltipUi);
         this.sysApi.addHook(HookList.GameRolePlayPlayerLifeStatus,this.onGameRolePlayPlayerLifeStatus);
         this.sysApi.addHook(HookList.SubscriptionZone,this.onSubscriptionZone);
         this.sysApi.addHook(HookList.NonSubscriberPopup,this.onNonSubscriberPopup);
         this.sysApi.addHook(HookList.GuestLimitationPopup,this.onGuestLimitationPopup);
         this.sysApi.addHook(HookList.GuestMode,this.onGuestMode);
         this.sysApi.addHook(BeriliaHookList.SlotDropedOnWorld,this.onSlotDropedOnWorld);
         this.sysApi.addHook(InventoryHookList.RoleplayBuffViewContent,this.onRoleplayBuffViewContent);
         this.sysApi.addHook(QuestHookList.RewardableAchievementsVisible,this.onRewardableAchievementsVisible);
         this.sysApi.addHook(QuestHookList.AchievementRewardSuccess,this.onAchievementRewardSuccess);
         this.sysApi.addHook(QuestHookList.AchievementFinished,this.onAchievementFinished);
         this.sysApi.addHook(CustomUiHookList.OpenReport,this.onReportOpen);
         this.sysApi.addHook(HookList.WorldRightClick,this.onWorldRightClick);
         this.sysApi.addHook(HookList.WorldMouseWheel,this.onWorldMouseWheel);
         this.sysApi.addHook(HookList.Cinematic,this.onCinematic);
         this.sysApi.addHook(HookList.InactivityNotification,this.onInactivityNotification);
         this.sysApi.addHook(QuestHookList.AreaFightModificatorUpdate,this.onAreaFightModificatorUpdate);
         this.sysApi.addHook(HookList.OpenOfflineSales,this.onOpenOfflineSales);
         this.sysApi.addHook(HookList.OpenMainMenu,this.onOpenMainMenu);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("transparancyMode",this.onShortcut);
         this.uiApi.addShortcutHook("showGrid",this.onShortcut);
         this.uiApi.addShortcutHook("foldAll",this.onShortcut);
         this.uiApi.addShortcutHook("cellSelectionOnly",this.onShortcut);
         this.uiApi.addShortcutHook("showCoord",this.onShortcut);
         _self = this;
      }
      
      public function getTooltipFightPlacer() : Object
      {
         var ref:Object = null;
         if(this.uiApi.getUi(UIEnum.BANNER))
         {
            ref = this.uiApi.getUi(UIEnum.BANNER).getElement("tooltipFightPlacer");
         }
         return ref;
      }
      
      private function onShortcut(s:String) : Boolean
      {
         var val:Boolean = false;
         switch(s)
         {
            case "closeUi":
               if(this.uiApi.getUi("cartographyUi"))
               {
                  this.uiApi.unloadUi("cartographyUi");
               }
               else
               {
                  this.onOpenMainMenu();
               }
               return true;
            case "transparancyMode":
               val = this.configApi.getConfigProperty("atouin","transparentOverlayMode");
               this.configApi.setConfigProperty("atouin","transparentOverlayMode",!val);
               return true;
            case "showGrid":
               val = this.configApi.getConfigProperty("atouin","alwaysShowGrid");
               this.configApi.setConfigProperty("atouin","alwaysShowGrid",!val);
               return true;
            case "showCoord":
               val = this.configApi.getConfigProperty("dofus","mapCoordinates");
               this.configApi.setConfigProperty("dofus","mapCoordinates",!val);
               return true;
            case "foldAll":
               this._folded = !this._folded;
               this.sysApi.dispatchHook(CustomUiHookList.FoldAll,this._folded);
               return true;
            case "cellSelectionOnly":
               val = this.configApi.getConfigProperty("dofus","cellSelectionOnly");
               this.configApi.setConfigProperty("dofus","cellSelectionOnly",!val);
               return true;
            default:
               return false;
         }
      }
      
      private function onGameStart() : void
      {
         this.uiApi.loadUi(UIEnum.MAP_INFO_UI,null,null,StrataEnum.STRATA_LOW);
         this.modCartography.openBannerMap();
         this.uiApi.loadUi(UIEnum.BANNER);
         if(!this.uiApi.getUi(UIEnum.CHAT_UI))
         {
            this.uiApi.loadUi(UIEnum.CHAT_UI,UIEnum.CHAT_UI,[this._channels,this._aTextInfos]);
            this._aTextInfos = [];
         }
         this.uiApi.loadUi("bannerMenu");
      }
      
      private function onSmileysStart(type:int, forceOpen:String = "") : void
      {
         if(!this.uiApi.getUi(UIEnum.SMILEY_UI))
         {
            this.uiApi.loadUi(UIEnum.SMILEY_UI,UIEnum.SMILEY_UI,[type],StrataEnum.STRATA_TOP);
         }
      }
      
      private function onEnabledChannels(v:Object) : void
      {
         if(!this.uiApi.getUi(UIEnum.CHAT_UI))
         {
            this._channels = v;
         }
      }
      
      private function onTextInformation(content:String = "", channel:int = 0, timestamp:Number = 0, saveMsg:Boolean = true, forceDisplay:Boolean = false) : void
      {
         if(!this.uiApi.getUi(UIEnum.CHAT_UI))
         {
            this._aTextInfos.push({
               "content":content,
               "channel":channel,
               "timestamp":timestamp,
               "saveMsg":saveMsg
            });
         }
      }
      
      private function onPlayerFightRequestSent(targetName:String, friendly:Boolean) : void
      {
         if(friendly)
         {
            this._currentPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.fight.challenge"),this.uiApi.getText("ui.fight.youChallenge",targetName),[this.uiApi.getText("ui.charcrea.undo")],[this.onFightFriendlyRefused],null,this.onFightFriendlyRefused);
         }
      }
      
      private function onPlayerFightFriendlyRequested(targetName:String) : void
      {
         this._ignoreName = targetName;
         this._currentPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.fight.challenge"),this.uiApi.getText("ui.fight.aChallengeYou",targetName),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no"),this.uiApi.getText("ui.common.ignore")],[this.onFightFriendlyAccepted,this.onFightFriendlyRefused,this.onFightFriendlyIgnore],this.onFightFriendlyAccepted,this.onFightFriendlyRefused);
      }
      
      private function onFightFriendlyAccepted() : void
      {
         this.sysApi.sendAction(new PlayerFightFriendlyAnswerAction([true]));
      }
      
      private function onFightFriendlyRefused() : void
      {
         this.sysApi.sendAction(new PlayerFightFriendlyAnswerAction([false]));
      }
      
      private function onFightFriendlyIgnore() : void
      {
         this.sysApi.sendAction(new PlayerFightFriendlyAnswerAction([false]));
         this.sysApi.sendAction(new AddIgnoredAction([this._ignoreName]));
      }
      
      private function onPlayerFightFriendlyAnswered(accept:Boolean) : void
      {
         this.uiApi.unloadUi(this._currentPopupName);
         this._currentPopupName = null;
      }
      
      private function onWorldRightClick() : void
      {
         var menu:ContextMenuData = null;
         if(this.playerApi.isInFight())
         {
            menu = this.menuApi.create(null,"fightWorld");
         }
         else
         {
            menu = this.menuApi.create(null,"world");
         }
         this.modContextMenu.createContextMenu(menu);
      }
      
      private function onWorldMouseWheel(zoomIn:Boolean) : void
      {
         if(this.sysApi.getOption("zoomOnMouseWheel","dofus"))
         {
            Api.system.mouseZoom(zoomIn);
         }
      }
      
      private function onGameRolePlayPlayerLifeStatus(status:uint, hardcore:uint) : void
      {
         if(hardcore == 0)
         {
            switch(status)
            {
               case 0:
                  this.sysApi.dispatchHook(HookList.CloseNotification,"notifPhantom",false);
                  break;
               case 1:
                  this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),this.uiApi.getText("ui.gameuicore.playerDied") + "\n\n" + this.uiApi.getText("ui.gameuicore.freeSoul"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onFreePlayerSoulAccepted,this.onFreePlayerSoulRefused],null,this.onFreePlayerSoulRefused,this.uiApi.createUri(this.sysApi.getConfigEntry("config.content.path") + "gfx/illusUi/gravestone.png"));
                  break;
               case 2:
                  if(this.sysApi.getData("hasSeenPhantomPopup"))
                  {
                     this.notifApi.showNotification(this.uiApi.getText("ui.login.news"),this.uiApi.getText("ui.gameuicore.soulsWorld"),0,"notifPhantom");
                  }
                  else
                  {
                     this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),this.uiApi.getText("ui.gameuicore.soulsWorld"),[this.uiApi.getText("ui.common.ok")]);
                     this.sysApi.setData("hasSeenPhantomPopup",true);
                  }
            }
         }
         else if(!this.uiApi.getUi("hardcoreDeath"))
         {
            this.uiApi.loadUi("hardcoreDeath");
         }
      }
      
      private function onFreePlayerSoulAccepted() : void
      {
         this.sysApi.sendAction(new GameRolePlayFreeSoulRequestAction([]));
      }
      
      private function onFreePlayerSoulRefused() : void
      {
      }
      
      private function onSubscriptionZone(active:Boolean) : void
      {
         var payZonePopupAlreadySeen:Boolean = false;
         if(active)
         {
            if(!this.uiApi.getUi("payZone"))
            {
               payZonePopupAlreadySeen = this.sysApi.getData("payZonePopupAlreadySeen",DataStoreEnum.BIND_COMPUTER);
               if(payZonePopupAlreadySeen)
               {
                  this.uiApi.loadUi("payZone","payZone",["payzone",false,true]);
               }
               else
               {
                  this.uiApi.loadUi("payZone","payZone",["payzone",true,true]);
               }
               this.sysApi.setData("payZonePopupAlreadySeen",true,DataStoreEnum.BIND_COMPUTER);
            }
         }
         else if(this.uiApi.getUi("payZone"))
         {
            this.uiApi.unloadUi("payZone");
         }
      }
      
      private function onNonSubscriberPopup(modeKeyword:String = "payzone") : void
      {
         if(!this.uiApi.getUi("payZone"))
         {
            this.uiApi.loadUi("payZone","payZone",[modeKeyword,true,false]);
         }
      }
      
      public function onGuestLimitationPopup() : void
      {
         if(!this.uiApi.getUi("payZone"))
         {
            this.uiApi.loadUi("payZone","payZone",["guest",true,false],StrataEnum.STRATA_TOP);
         }
      }
      
      private function onGuestMode(active:Boolean) : void
      {
         if(active)
         {
            if(!this.uiApi.getUi("payZone"))
            {
               this.uiApi.loadUi("payZone","payZone",["guest",false,true],StrataEnum.STRATA_TOP);
            }
         }
         else if(this.uiApi.getUi("payZone"))
         {
            this.uiApi.unloadUi("payZone");
         }
      }
      
      private function onAreaFightModificatorUpdate(spellPairId:int) : void
      {
         if(!this.uiApi.getUi("fightModificatorUi") && spellPairId > -1)
         {
            this.uiApi.loadUi("fightModificatorUi","fightModificatorUi",{"pairId":spellPairId});
         }
      }
      
      private function onRoleplayBuffViewContent(buffs:Vector.<ItemWrapper>) : void
      {
         var alterationFrame:AlterationFrame = Kernel.getWorker().getFrame(AlterationFrame) as AlterationFrame;
         alterationFrame.processOldAlterations(buffs);
      }
      
      private function onAlterations(descr:AlterationsDescr) : void
      {
         if(descr.alterations.length > 0 && !this.uiApi.getUi(UIEnum.PREVIEWED_ALTERATIONS_UI))
         {
            this.uiApi.loadUi(UIEnum.PREVIEWED_ALTERATIONS_UI,UIEnum.PREVIEWED_ALTERATIONS_UI,descr);
         }
      }
      
      private function onAlterationAdded(addedAlteration:AlterationWrapper) : void
      {
         if(!this.uiApi.getUi(UIEnum.PREVIEWED_ALTERATIONS_UI))
         {
            this.uiApi.loadUi(UIEnum.PREVIEWED_ALTERATIONS_UI,UIEnum.PREVIEWED_ALTERATIONS_UI,new AlterationsDescr(new <AlterationWrapper>[addedAlteration]));
         }
      }
      
      private function onAlterationsUpdated(alterations:Vector.<AlterationWrapper>) : void
      {
         if(!this.uiApi.getUi(UIEnum.PREVIEWED_ALTERATIONS_UI))
         {
            this.uiApi.loadUi(UIEnum.PREVIEWED_ALTERATIONS_UI,UIEnum.PREVIEWED_ALTERATIONS_UI,new AlterationsDescr(alterations));
         }
      }
      
      private function onAlterationPinnedTooltipUi(alteration:AlterationWrapper) : void
      {
         this.uiApi.showTooltip(alteration,TOOLTIP_TARGET,false,TooltipManager.TOOLTIP_STANDARD_NAME,LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPLEFT,0,"alteration",null,{"pinnable":true},null,true,StrataEnum.STRATA_TOOLTIP,1,"storage");
      }
      
      private function onOpenAlterationUi(descr:AlterationsDescr) : void
      {
         if(!this.uiApi.getUi(UIEnum.ALTERATIONS_UI))
         {
            this.uiApi.loadUi(UIEnum.ALTERATIONS_UI,UIEnum.ALTERATIONS_UI,descr);
         }
      }
      
      public function removeFromBanner(pObject:Object) : void
      {
         if(this.uiApi.keyIsDown(16))
         {
            if(pObject.hasOwnProperty("objectUID"))
            {
               this.sysApi.sendAction(new ObjectSetPositionAction([pObject.objectUID,63]));
            }
         }
      }
      
      public function onSlotDropedOnWorld(pSlot:Object, pDropTarget:Object) : void
      {
         var effect:Object = null;
         switch(true)
         {
            case pSlot.data is SpellWrapper:
            case pSlot.data is BuildWrapper:
               break;
            case pSlot.data is ItemWrapper:
               if(pSlot.data.position > 63 && pSlot.data.position < 318)
               {
                  this.removeFromBanner(pSlot.data);
               }
               for each(effect in pSlot.data.effects)
               {
                  if(effect.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE_STRONG || effect.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE || effect.effectId == ActionIds.ACTION_MARK_NOT_TRADABLE)
                  {
                     this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.objectError.CannotDrop"),10,this.timeApi.getTimestamp());
                     return;
                  }
               }
               if(this.playerApi.isInExchange())
               {
                  return;
               }
               this._waitingObject = pSlot.data;
               this._waitingObjectName = this.dataApi.getItemName(this._waitingObject.objectGID);
               if(this._waitingObject.quantity > 1)
               {
                  this.modCommon.openQuantityPopup(1,this._waitingObject.quantity,this._waitingObject.quantity,this.onValidQtyDrop);
               }
               else
               {
                  this.sysApi.sendAction(new ObjectDropAction([this._waitingObject.objectUID,this._waitingObject.objectGID,1]));
               }
               break;
         }
      }
      
      private function onValidQtyDrop(pQuantity:int) : void
      {
         this._waitingObjectQuantity = pQuantity;
         this.sysApi.sendAction(new ObjectDropAction([this._waitingObject.objectUID,this._waitingObject.objectGID,this._waitingObjectQuantity]));
      }
      
      private function onReportOpen(playerID:Number, playerName:String, context:Object = null) : void
      {
         this.uiApi.unloadUi("report");
         this.uiApi.loadUi("report","report",{
            "playerID":playerID,
            "playerName":playerName,
            "context":context
         });
      }
      
      public function onCinematic(cinematicId:int, checkLastPlayed:Boolean) : void
      {
         var date:Date = new Date();
         var lastPlayDate:Number = this.sysApi.getData("lastPlay_" + cinematicId,DataStoreEnum.BIND_COMPUTER);
         if(checkLastPlayed && lastPlayDate > 0 && date.getTime() < lastPlayDate + 7 * this.MILLISECONDS_IN_DAY)
         {
            return;
         }
         this.sysApi.setData("lastPlay_" + cinematicId,date.getTime(),DataStoreEnum.BIND_COMPUTER);
         if(!this.uiApi.getUi(UIEnum.CHAT_UI))
         {
            this.uiApi.loadUi(UIEnum.CHAT_UI,UIEnum.CHAT_UI,[this._channels,this._aTextInfos]);
            this._aTextInfos = [];
         }
         var cinematicStrId:String = "" + cinematicId;
         if(cinematicId == 10)
         {
            cinematicStrId = this.sysApi.getCurrentLanguage() + "/" + cinematicStrId;
         }
         if(cinematicId > 100)
         {
            if(this.sysApi.getData("trailer1Viewed"))
            {
               return;
            }
            this.sysApi.setData("trailer1Viewed",true);
         }
         this.uiApi.loadUi("cinematic","cinematic",{"cinematicId":cinematicStrId},StrataEnum.STRATA_TOP);
      }
      
      private function onInactivityNotification(inactive:Boolean) : void
      {
         if(inactive && !this._inactivityPopup)
         {
            this._inactivityPopup = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.common.inactivityWarning"),[this.uiApi.getText("ui.common.ok")],[this.inactivityPopupClosed],this.inactivityPopupClosed,this.inactivityPopupClosed);
         }
      }
      
      private function inactivityPopupClosed() : void
      {
         this._inactivityPopup = null;
      }
      
      private function onRewardableAchievementsVisible(b:Boolean) : void
      {
         var rewardUi:UiRootContainer = null;
         if(b)
         {
            rewardUi = this.uiApi.getUi(UIEnum.REWARDS);
            if(!rewardUi)
            {
               this.uiApi.loadUi(UIEnum.REWARDS);
            }
            else
            {
               rewardUi.uiClass.onRewardableAchievementsVisible();
            }
         }
         else
         {
            this.uiApi.unloadUi(UIEnum.REWARDS);
         }
      }
      
      private function onAchievementFinished(finishedAchievement:AchievementAchieved) : void
      {
         var rewardUi:UiRootContainer = this.uiApi.getUi(UIEnum.REWARDS);
         if(rewardUi && !this.playerApi.isInFight())
         {
            rewardUi.uiClass.onRewardableAchievementsVisible();
         }
      }
      
      public function onAchievementRewardSuccess(achievementId:int) : void
      {
         var rewardUi:UiRootContainer = this.uiApi.getUi(UIEnum.REWARDS);
         if(!rewardUi)
         {
            this.uiApi.loadUi(UIEnum.REWARDS);
         }
         else
         {
            rewardUi.uiClass.onAchievementRewardSuccess();
         }
      }
      
      private function onOpenOfflineSales(pTab:uint, pOfflineSales:Object, pUnsoldItems:Object) : void
      {
         this.uiApi.loadUi("offlineSales",null,{
            "tab":pTab,
            "sales":pOfflineSales,
            "unsoldItems":pUnsoldItems
         },1,null,true,false,false);
      }
      
      public function onOpenMainMenu() : void
      {
         if(!this.uiApi.getUi("mainMenu"))
         {
            this.uiApi.loadUi("mainMenu",null,null,StrataEnum.STRATA_TOP);
         }
         else
         {
            this.uiApi.unloadUi("mainMenu");
         }
      }
   }
}
