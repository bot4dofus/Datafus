package Ankama_Social.ui
{
   import Ankama_Social.Social;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.TextAreaInput;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.GuildChestTab;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkMapPosition;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildLogbookRequestAction;
   import com.ankamagames.dofus.logic.game.common.frames.InventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.misc.lists.StatsHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChestEventTypeEnum;
   import com.ankamagames.dofus.network.enums.GuildRankActivityTypeEnum;
   import com.ankamagames.dofus.network.enums.GuildRightsEnum;
   import com.ankamagames.dofus.network.enums.PaddockCommercialEventTypeEnum;
   import com.ankamagames.dofus.network.enums.PlayerFlowEventTypeEnum;
   import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemNotInContainer;
   import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;
   import com.ankamagames.dofus.network.types.game.guild.logbook.chest.GuildLogbookChestActivity;
   import com.ankamagames.dofus.network.types.game.guild.logbook.global.GuildLevelUpActivity;
   import com.ankamagames.dofus.network.types.game.guild.logbook.global.GuildPaddockActivity;
   import com.ankamagames.dofus.network.types.game.guild.logbook.global.GuildPlayerFlowActivity;
   import com.ankamagames.dofus.network.types.game.guild.logbook.global.GuildPlayerRankUpdateActivity;
   import com.ankamagames.dofus.network.types.game.guild.logbook.global.GuildRankActivity;
   import com.ankamagames.dofus.network.types.game.guild.logbook.global.GuildUnlockNewTabActivity;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.events.Event;
   
   public class GuildLogBook
   {
      
      private static const LOGBOOK_GENERAL_TAB:uint = 0;
      
      private static const LOGBOOK_CHEST_TAB:uint = 1;
      
      private static const UNKNOWN_ACTIVITY:String = "[Unknown activity]";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      private var _guildWrapper:GuildWrapper;
      
      private var _playerId:Number;
      
      private var _generalActivitiesList:Vector.<GuildLogbookEntryBasicInformation>;
      
      private var _chestActivitiesList:Vector.<GuildLogbookEntryBasicInformation>;
      
      private var _emptyActivitiesList:Vector.<GuildLogbookEntryBasicInformation>;
      
      private var _scrollUsed:Boolean = false;
      
      private var _scrollMaxValue:uint = 0;
      
      private var _nCurrentTab:int = 0;
      
      public var ctr_text:GraphicContainer;
      
      public var lbl_guildInfos:TextArea;
      
      public var btn_edit:ButtonContainer;
      
      public var ctr_edit:GraphicContainer;
      
      public var inp_guildInfos:TextAreaInput;
      
      public var btn_notifyMembers:ButtonContainer;
      
      public var btn_valid:ButtonContainer;
      
      public var lbl_cancel:Label;
      
      public var lbl_lastEdit:Label;
      
      public var gd_logbook:Grid;
      
      public var btn_generalLog:ButtonContainer;
      
      public var btn_chestLog:ButtonContainer;
      
      public var ctr_rulesLink:GraphicContainer;
      
      public var lbl_rulesLink:Label;
      
      public function GuildLogBook()
      {
         this._emptyActivitiesList = new Vector.<GuildLogbookEntryBasicInformation>();
         super();
      }
      
      public function main(... args) : void
      {
         this.sysApi.startStats("logBook");
         this.sysApi.addHook(SocialHookList.GuildBulletin,this.onGuildBulletin);
         this.sysApi.addHook(SocialHookList.GuildLogbookInformationsReceived,this.onGuildLogbookReceived);
         this.sysApi.sendAction(new GuildLogbookRequestAction());
         this.uiApi.addComponentHook(this.lbl_cancel,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_edit,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_edit,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_rulesLink,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_chestLog,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_chestLog,ComponentHookList.ON_ROLL_OUT);
         this.inp_guildInfos.maxChars = ProtocolConstantsEnum.USER_MAX_BULLETIN_LEN;
         this._playerId = this.playerApi.id();
         this._emptyActivitiesList.push(new EmptyActivity());
         this.btn_chestLog.softDisabled = this.socialApi.getPlayerGuildRank(this._playerId).rights.indexOf(GuildRightsEnum.RIGHT_OPEN_GUILD_CHEST) == -1;
         this.enableEditButtonIfHasRight();
         this.lbl_rulesLink.fullWidth();
         this.btn_valid.visible = false;
         this.lbl_cancel.visible = false;
         this.lbl_cancel.handCursor = true;
         this.btn_notifyMembers.visible = false;
         this._guildWrapper = this.socialApi.getGuild();
         this.updateBulletin();
         this.gd_logbook.dataProvider = this._emptyActivitiesList;
         if(this.gd_logbook.scrollBarV)
         {
            this.gd_logbook.scrollBarV.addEventListener(Event.CHANGE,this.onScroll);
         }
         this.btn_generalLog.selected = true;
      }
      
      public function enableEditButtonIfHasRight() : void
      {
         this.btn_edit.softDisabled = !this.socialApi.hasGuildRight(this._playerId,GuildRightsEnum.RIGHT_UPDATE_BULLETIN);
         this.btn_edit.handCursor = !this.btn_edit.softDisabled;
      }
      
      public function unload() : void
      {
         if(this.gd_logbook.scrollBarV)
         {
            this.gd_logbook.scrollBarV.removeEventListener(Event.CHANGE,this.onScroll);
         }
         this.sysApi.dispatchHook(StatsHookList.LogBookHistoryStats,this._nCurrentTab == LOGBOOK_GENERAL_TAB ? "General" : "Coffre",this._scrollUsed,this._scrollMaxValue);
         this.sysApi.setData(Social.GUILD_BULLETIN_LAST_VISIT_TIMESTAMP,TimeManager.getInstance().getUtcTimestamp());
      }
      
      private function switchEditMode(editMode:Boolean) : void
      {
         if(editMode)
         {
            this.inp_guildInfos.text = StringUtils.unescape(this._guildWrapper.bulletin);
            this.inp_guildInfos.focus();
            this.inp_guildInfos.setSelection(8388607,8388607);
            this.ctr_edit.visible = true;
            this.ctr_text.visible = false;
            this.inp_guildInfos.scrollBarValue = this.lbl_guildInfos.scrollBarValue;
            this.btn_edit.visible = false;
            this.btn_valid.visible = true;
            this.lbl_cancel.visible = true;
            this.btn_notifyMembers.visible = true;
         }
         else
         {
            this.ctr_edit.visible = false;
            this.ctr_text.visible = true;
            this.btn_edit.visible = true;
            this.lbl_guildInfos.scrollBarValue = this.inp_guildInfos.scrollBarValue;
            this.enableEditButtonIfHasRight();
            this.btn_valid.visible = false;
            this.lbl_cancel.visible = false;
            this.btn_notifyMembers.visible = false;
         }
      }
      
      private function updateBulletin() : void
      {
         var date:Number = NaN;
         this.lbl_guildInfos.text = this._guildWrapper.formattedBulletin;
         this.inp_guildInfos.text = this._guildWrapper.bulletin;
         if(!this.lbl_guildInfos.text)
         {
            this.lbl_guildInfos.text = this.uiApi.getText("ui.guild.guildInfos.default");
         }
         if(this._guildWrapper.bulletinWriterName != "")
         {
            date = this._guildWrapper.bulletinTimestamp * 1000;
            this.lbl_lastEdit.text = this.uiApi.getText("ui.guild.guildInformations.lastModification",this.timeApi.getDate(date,true) + " " + this.timeApi.getClock(date,true,true),this._guildWrapper.bulletinWriterName);
         }
      }
      
      private function onGuildBulletin() : void
      {
         this.updateBulletin();
         this.switchEditMode(false);
         this.sysApi.setData(Social.GUILD_BULLETIN_LAST_VISIT_TIMESTAMP,TimeManager.getInstance().getUtcTimestamp());
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function onScroll(e:Event) : void
      {
         this._scrollUsed = true;
         var tempIndex:int = this.gd_logbook.scrollBarV.value;
         if(this._scrollMaxValue < tempIndex)
         {
            this._scrollMaxValue = tempIndex;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var notifyMembers:Boolean = false;
         if(target == this.btn_edit)
         {
            this.switchEditMode(true);
         }
         else if(target == this.lbl_cancel)
         {
            this.switchEditMode(false);
         }
         else if(target == this.btn_valid)
         {
            if(this.inp_guildInfos.text != this._guildWrapper.bulletin)
            {
               notifyMembers = this.btn_notifyMembers.selected;
               this.sysApi.sendAction(new GuildBulletinSetRequestAction([this.inp_guildInfos.text,notifyMembers]));
            }
            else
            {
               this.switchEditMode(false);
            }
         }
         else if(target == this.btn_generalLog || target == this.btn_chestLog)
         {
            this._nCurrentTab = target == this.btn_generalLog ? int(LOGBOOK_GENERAL_TAB) : int(LOGBOOK_CHEST_TAB);
            this.sysApi.sendAction(new GuildLogbookRequestAction());
         }
         else if(target == this.ctr_rulesLink)
         {
            this.sysApi.goToUrl(this.uiApi.getText("ui.link.listOfRulesOfConduct"));
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         if(target == this.btn_edit && this.btn_edit.softDisabled)
         {
            tooltipText = this.uiApi.getText("ui.guild.guildInfos.noRights");
         }
         else if(target == this.btn_chestLog && this.btn_chestLog.softDisabled)
         {
            tooltipText = this.uiApi.getText("ui.guild.logbook.chest.noRights");
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function updateLogbookLine(data:GuildLogbookEntryBasicInformation, componentsRef:*, selected:Boolean) : void
      {
         var logLine:* = null;
         if(data)
         {
            logLine = "<i>" + this.timeApi.getDate(data.date) + " " + this.timeApi.getClock(data.date) + "</i> - ";
            switch(true)
            {
               case data is GuildLogbookChestActivity:
                  logLine += this.formatChestActivity(data as GuildLogbookChestActivity);
                  break;
               case data is GuildUnlockNewTabActivity:
                  logLine += this.uiApi.getText("ui.guild.logbook.chest.unlock");
                  break;
               case data is GuildPaddockActivity:
                  logLine += this.formatPaddockActivity(data as GuildPaddockActivity);
                  break;
               case data is GuildPlayerFlowActivity:
                  logLine += this.formatPlayerFlowActivity(data as GuildPlayerFlowActivity);
                  break;
               case data is GuildLevelUpActivity:
                  logLine += this.formatLevelUpActivity(data as GuildLevelUpActivity);
                  break;
               case data is GuildRankActivity:
                  logLine += this.formatRankActivity(data as GuildRankActivity);
                  break;
               case data is GuildPlayerRankUpdateActivity:
                  logLine += this.formatPlayerRankActivity(data as GuildPlayerRankUpdateActivity);
                  break;
               case data is EmptyActivity:
                  logLine = this.uiApi.getText("ui.guild.logbook.noActivity");
            }
            componentsRef.lbl_logbookLine.text = logLine;
         }
         else
         {
            componentsRef.lbl_logbookLine.text = "";
         }
      }
      
      private function onGuildLogbookReceived(generalActivities:Vector.<GuildLogbookEntryBasicInformation>, chestActivities:Vector.<GuildLogbookEntryBasicInformation>) : void
      {
         this._generalActivitiesList = generalActivities.sort(this.sortActivities);
         this._chestActivitiesList = chestActivities.sort(this.sortActivities);
         this.openSelectedTab(this._nCurrentTab != -1 ? uint(this._nCurrentTab) : uint(LOGBOOK_GENERAL_TAB));
      }
      
      private function sortActivities(activity1:GuildLogbookEntryBasicInformation, activity2:GuildLogbookEntryBasicInformation) : int
      {
         if(activity2.date > activity1.date)
         {
            return 1;
         }
         if(activity2.date < activity1.date)
         {
            return -1;
         }
         return 0;
      }
      
      private function openSelectedTab(tab:uint) : void
      {
         this._scrollUsed = false;
         this._scrollMaxValue = 0;
         this.getButtonByTab(tab).selected = true;
         var dp:Vector.<GuildLogbookEntryBasicInformation> = this._nCurrentTab == LOGBOOK_GENERAL_TAB ? this._generalActivitiesList : this._chestActivitiesList;
         this.gd_logbook.dataProvider = dp && dp.length != 0 ? dp : this._emptyActivitiesList;
      }
      
      private function getButtonByTab(tab:uint) : ButtonContainer
      {
         if(tab == LOGBOOK_GENERAL_TAB)
         {
            return this.btn_generalLog;
         }
         return this.btn_chestLog;
      }
      
      private function formatChestActivity(data:GuildLogbookChestActivity) : String
      {
         var playerLink:String = null;
         if(data.playerName)
         {
            playerLink = this.chatApi.getPlayerLink(data.playerId,data.playerName);
         }
         var object:ObjectItemNotInContainer = data.object;
         var objectLink:String = this.chatApi.newChatItem(ItemWrapper.create(0,object.objectUID,object.objectGID,object.quantity,object.effects,false));
         var activityString:String = UNKNOWN_ACTIVITY;
         switch(data.eventType)
         {
            case ChestEventTypeEnum.DEPOSIT:
               if(!playerLink)
               {
                  activityString = this.uiApi.getText("ui.guild.logbook.chest.deposit.anonyme",data.quantity,objectLink,this.getRealChestTabName(data.destinationTabId));
               }
               else if(data.playerId == this.playerApi.id())
               {
                  activityString = this.uiApi.getText("ui.guild.logbook.chest.deposit.myself",data.quantity,objectLink,this.getRealChestTabName(data.destinationTabId));
               }
               else
               {
                  activityString = this.uiApi.getText("ui.guild.logbook.chest.deposit.someone",playerLink,data.quantity,objectLink,this.getRealChestTabName(data.destinationTabId));
               }
               break;
            case ChestEventTypeEnum.WITHDRAW:
               if(!playerLink)
               {
                  activityString = this.uiApi.getText("ui.guild.logbook.chest.withdraw.anonyme",data.quantity,objectLink,this.getRealChestTabName(data.sourceTabId));
               }
               else if(data.playerId == this.playerApi.id())
               {
                  activityString = this.uiApi.getText("ui.guild.logbook.chest.withdraw.myself",data.quantity,objectLink,this.getRealChestTabName(data.sourceTabId));
               }
               else
               {
                  activityString = this.uiApi.getText("ui.guild.logbook.chest.withdraw.someone",playerLink,data.quantity,objectLink,this.getRealChestTabName(data.sourceTabId));
               }
               break;
            case ChestEventTypeEnum.TRANSFER:
               if(!playerLink)
               {
                  activityString = this.uiApi.getText("ui.guild.logbook.chest.transfer.anonyme",data.quantity,objectLink,this.getRealChestTabName(data.sourceTabId),this.getRealChestTabName(data.destinationTabId));
               }
               else if(data.playerId == this.playerApi.id())
               {
                  activityString = this.uiApi.getText("ui.guild.logbook.chest.transfer.myself",data.quantity,objectLink,this.getRealChestTabName(data.sourceTabId),this.getRealChestTabName(data.destinationTabId));
               }
               else
               {
                  activityString = this.uiApi.getText("ui.guild.logbook.chest.transfer.someone",playerLink,data.quantity,objectLink,this.getRealChestTabName(data.sourceTabId),this.getRealChestTabName(data.destinationTabId));
               }
         }
         return activityString;
      }
      
      private function getRealChestTabName(tabNumber:uint) : String
      {
         var tab:GuildChestTab = null;
         var inventoryFrame:InventoryManagementFrame = Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
         var tabName:String = inventoryFrame.guildChestTabs[tabNumber - 1].name;
         if(tabName.indexOf("guild.chest.tab") != -1)
         {
            tab = GuildChestTab.getGuildChestTabByIndex(tabNumber);
            if(tab)
            {
               return tab.name;
            }
            return "";
         }
         return tabName;
      }
      
      private function formatPaddockActivity(data:GuildPaddockActivity) : String
      {
         var playerLink:String = this.chatApi.getPlayerLink(data.playerId,data.playerName);
         var activityString:String = UNKNOWN_ACTIVITY;
         switch(data.paddockEventType)
         {
            case PaddockCommercialEventTypeEnum.BUY:
               activityString = this.uiApi.getText("ui.guild.logbook.paddock.buy",playerLink,this.getPaddockNameAndCoord(data.paddockCoordinates));
               break;
            case PaddockCommercialEventTypeEnum.PUT_ON_SELL:
               activityString = this.uiApi.getText("ui.guild.logbook.paddock.sell",playerLink,this.getPaddockNameAndCoord(data.paddockCoordinates));
               break;
            case PaddockCommercialEventTypeEnum.SOLD:
               activityString = this.uiApi.getText("ui.guild.logbook.paddock.sold",this.getPaddockNameAndCoord(data.paddockCoordinates));
         }
         return activityString;
      }
      
      private function getPaddockNameAndCoord(paddockCoordinates:MapCoordinatesExtended) : String
      {
         var subarea:SubArea = SubArea.getSubAreaById(paddockCoordinates.subAreaId);
         return subarea.name + " " + HyperlinkMapPosition.getLink(paddockCoordinates.worldX,paddockCoordinates.worldY,subarea.worldmap.id);
      }
      
      private function formatPlayerFlowActivity(data:GuildPlayerFlowActivity) : String
      {
         var playerLink:String = this.chatApi.getPlayerLink(data.playerId,data.playerName);
         var activityString:String = UNKNOWN_ACTIVITY;
         switch(data.playerFlowEventType)
         {
            case PlayerFlowEventTypeEnum.JOIN:
               activityString = this.uiApi.getText("ui.guild.logbook.playerFlow.join",playerLink);
               break;
            case PlayerFlowEventTypeEnum.LEAVE:
               activityString = this.uiApi.getText("ui.guild.logbook.playerFlow.leave",playerLink);
               break;
            case PlayerFlowEventTypeEnum.APPLY_REFUSED:
               activityString = this.uiApi.getText("ui.guild.logbook.playerFlow.applyRefused",playerLink);
         }
         return activityString;
      }
      
      private function formatLevelUpActivity(data:GuildLevelUpActivity) : String
      {
         return this.uiApi.getText("ui.guild.logbook.guildLevelUp",data.newGuildLevel);
      }
      
      private function formatRankActivity(data:GuildRankActivity) : String
      {
         var rankName:String = data.guildRankMinimalInfos.name;
         if(rankName.indexOf("guild.rank.") != -1)
         {
            rankName = this.socialApi.getGuildRankById(parseInt(rankName.split(".")[2])).name;
         }
         var rankLink:String = this.chatApi.getGuildRankLink(data.guildRankMinimalInfos,rankName);
         var activityString:String = UNKNOWN_ACTIVITY;
         switch(data.rankActivityType)
         {
            case GuildRankActivityTypeEnum.CREATION:
               activityString = this.uiApi.getText("ui.guild.logbook.rank.create",rankLink);
               break;
            case GuildRankActivityTypeEnum.DELETE:
               activityString = this.uiApi.getText("ui.guild.logbook.rank.delete",rankLink);
               break;
            case GuildRankActivityTypeEnum.UPDATE:
               activityString = this.uiApi.getText("ui.guild.logbook.rank.update",rankLink);
         }
         return activityString;
      }
      
      private function formatPlayerRankActivity(data:GuildPlayerRankUpdateActivity) : String
      {
         var targetPlayerLink:String = this.chatApi.getPlayerLink(data.targetPlayerId,data.targetPlayerName);
         var sourcePlayerLink:String = this.chatApi.getPlayerLink(data.sourcePlayerId,data.sourcePlayerName);
         var rankName:String = data.guildRankMinimalInfos.name;
         if(rankName.indexOf("guild.rank.") != -1)
         {
            rankName = this.socialApi.getGuildRankById(parseInt(rankName.split(".")[2])).name;
         }
         var rankLink:String = this.chatApi.getGuildRankLink(data.guildRankMinimalInfos,rankName);
         return this.uiApi.getText("ui.guild.logbook.playerRank",targetPlayerLink,rankLink,sourcePlayerLink);
      }
   }
}

import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;

class EmptyActivity extends GuildLogbookEntryBasicInformation
{
    
   
   function EmptyActivity()
   {
      super();
   }
}
