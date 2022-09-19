package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ScrollBar;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildApplicationWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.GuildApplicationPlayerDataWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildApplicationReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildApplicationsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSetApplicationUpdatesRequestAction;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.GuildApplicationStateEnum;
   import com.ankamagames.dofus.network.enums.GuildRightsEnum;
   import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class GuildApplications
   {
      
      private static const TOOLTIP_UI_NAME:String = "GuildApplicationsTooltip";
      
      private static const VISIBLE_APPLICATIONS_NB:uint = 4;
      
      private static const PAGING_PACE:uint = 2;
      
      private static const DEFAULT_LIMIT:uint = PAGING_PACE * VISIBLE_APPLICATIONS_NB;
      
      private static const REQUEST_DELAY:Number = 300;
      
      private static const WARNING_LOADING_TIMEOUT:Number = 700;
       
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SecurityApi")]
      public var secureApi:SecurityApi;
      
      public var mainCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var gd_guildApplications:Grid;
      
      public var lbl_pendingApplications:Label;
      
      public var tx_loadingWarning:Texture;
      
      private var _headsPath:String;
      
      private var _componentsDictionary:Dictionary;
      
      private var _cachedItems:GuildApplicationItems;
      
      private var _applicationsRequestsHandle:uint = 0;
      
      private var _currentTotal:int = -1;
      
      private var _lastTimestamp:Number = 0;
      
      private var _isWaitingForApplications:Boolean = false;
      
      private var _loadingWarningHandle:uint = 0;
      
      public function GuildApplications()
      {
         this._componentsDictionary = new Dictionary(true);
         this._cachedItems = new GuildApplicationItems();
         super();
      }
      
      public function main(params:Object = null) : void
      {
         if(params === null)
         {
            params = {};
         }
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.uiApi.addComponentHook(this.mainCtr,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_guildApplications,ComponentHookList.ON_SELECT_ITEM);
         this.sysApi.addHook(SocialHookList.GuildApplicationsReceived,this.onApplications);
         this.sysApi.addHook(SocialHookList.GuildApplicationUpdated,this.onApplicationState);
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this._headsPath = this.uiApi.me().getConstant("heads_uri");
         this.gd_guildApplications.mouseClickEnabled = false;
         this.requestNewerApplications(0,DEFAULT_LIMIT);
         this.setApplicationUpdates(true);
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
         this.setApplicationUpdates(false);
         this.setScrollListenerState(false);
         this.removeApplicationsRequest();
      }
      
      public function updateApplicationLine(applicationItem:GuildApplicationItem, components:*, isSelected:Boolean) : void
      {
         if(applicationItem === null)
         {
            components.ctr_application.visible = false;
            delete this._componentsDictionary[components.tx_statusIcon.name];
            delete this._componentsDictionary[components.btn_accept.name];
            delete this._componentsDictionary[components.lbl_btn_reject.name];
            this.uiApi.removeComponentHook(components.tx_statusIcon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_statusIcon,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.tx_applicationObsolete,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_applicationObsolete,ComponentHookList.ON_ROLL_OUT);
            return;
         }
         components.ctr_application.visible = true;
         var application:GuildApplicationWrapper = applicationItem.application;
         if(application === null)
         {
            components.tx_applicationObsolete.visible = false;
            components.tx_breedIcon.uri = null;
            components.tx_breedIconBackground.visible = false;
            components.tx_breedIcon.visible = false;
            components.lbl_characterInfo.text = null;
            components.lbl_characterInfo.visible = false;
            components.tx_statusIcon.uri = null;
            components.tx_statusIcon.visible = false;
            components.lbl_date.text = null;
            components.lbl_date.visible = false;
            components.lbl_text.text = null;
            components.lbl_text.visible = false;
            components.tx_breedIconPlaceholder.visible = true;
            components.tx_characterInfoPlaceholder.visible = true;
            components.tx_datePlaceholder.visible = true;
            components.tx_textPlaceholder.visible = true;
            delete this._componentsDictionary[components.tx_statusIcon.name];
            delete this._componentsDictionary[components.btn_accept.name];
            delete this._componentsDictionary[components.lbl_btn_reject.name];
            this.uiApi.removeComponentHook(components.tx_statusIcon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_statusIcon,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.tx_applicationObsolete,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_applicationObsolete,ComponentHookList.ON_ROLL_OUT);
            return;
         }
         if(applicationItem.isObsolete)
         {
            components.tx_applicationObsolete.visible = true;
            delete this._componentsDictionary[components.tx_statusIcon.name];
            delete this._componentsDictionary[components.btn_accept.name];
            delete this._componentsDictionary[components.lbl_btn_reject.name];
            this.uiApi.removeComponentHook(components.tx_statusIcon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_statusIcon,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.tx_applicationObsolete,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_applicationObsolete,ComponentHookList.ON_ROLL_OUT);
            return;
         }
         this.uiApi.removeComponentHook(components.tx_applicationObsolete,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.tx_applicationObsolete,ComponentHookList.ON_ROLL_OUT);
         components.tx_applicationObsolete.visible = false;
         components.tx_breedIconPlaceholder.visible = false;
         components.tx_characterInfoPlaceholder.visible = false;
         components.tx_datePlaceholder.visible = false;
         components.tx_textPlaceholder.visible = false;
         var playerData:GuildApplicationPlayerDataWrapper = application.playerData;
         var accountName:String = PlayerManager.getInstance().formatTagName(playerData.accountName,playerData.accountTag.toString(),null,false);
         var fullName:* = playerData.playerName + " (" + accountName + ")";
         if(playerData.statusId == PlayerStatusEnum.PLAYER_STATUS_OFFLINE || playerData.statusId == PlayerStatusEnum.PLAYER_STATUS_UNKNOWN)
         {
            fullName = "{account," + playerData.accountName + "," + playerData.accountName + "," + playerData.accountId + "," + SocialCharacterCategoryEnum.CATEGORY_CONTACT + "::" + fullName + "}";
         }
         else
         {
            fullName = "{player," + playerData.playerName + "," + playerData.playerId + "," + null + "," + 0 + "," + 0 + "," + playerData.accountId + "::" + fullName + "}";
         }
         components.tx_breedIcon.uri = this.uiApi.createUri(this._headsPath + playerData.breed + "" + (!!playerData.sex ? 1 : 0) + ".png");
         components.tx_breedIconBackground.visible = true;
         components.tx_breedIcon.visible = true;
         var levelLabel:String = this.uiApi.getText("ui.common.short.level");
         if(levelLabel !== null)
         {
            levelLabel = levelLabel.toLowerCase();
         }
         components.lbl_characterInfo.text = fullName + " - " + levelLabel + " " + playerData.level + " - " + Breed.getBreedById(playerData.breed).name;
         components.lbl_characterInfo.visible = true;
         components.tx_statusIcon.uri = this.socialApi.getStatusIcon(playerData.statusId);
         components.tx_statusIcon.visible = true;
         components.lbl_date.text = this.timeApi.getIRLDate(application.creationDate);
         components.lbl_date.visible = true;
         components.lbl_text.text = application.text;
         components.lbl_text.visible = true;
         this._componentsDictionary[components.tx_statusIcon.name] = playerData;
         this.uiApi.addComponentHook(components.tx_statusIcon,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(components.tx_statusIcon,ComponentHookList.ON_ROLL_OUT);
         components.btn_accept.softDisabled = !this.canManageApplications() || this.secureApi.SecureModeisActive();
         components.lbl_btn_reject.cssClass = this.canManageApplications() && !this.secureApi.SecureModeisActive() ? this.uiApi.me().getConstant("btn_reject_enabled") : this.uiApi.me().getConstant("btn_reject_disabled");
         if(this.canManageApplications() && !this.secureApi.SecureModeisActive())
         {
            this.uiApi.addComponentHook(components.btn_accept,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.lbl_btn_reject,ComponentHookList.ON_RELEASE);
            this._componentsDictionary[components.btn_accept.name] = application.playerId;
            this._componentsDictionary[components.lbl_btn_reject.name] = application.playerId;
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            this.uiApi.addComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_accept,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.lbl_btn_reject,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_accept,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.lbl_btn_reject,ComponentHookList.ON_RELEASE);
         }
      }
      
      private function setApplicationUpdates(areEnabled:Boolean) : void
      {
         var socialBase:SocialBase = null;
         var socialBaseContainer:UiRootContainer = this.uiApi.getUi(UIEnum.SOCIAL_BASE);
         if(socialBaseContainer !== null)
         {
            socialBase = socialBaseContainer.uiClass;
            if(socialBase !== null && socialBase.getTab() === DataEnum.SOCIAL_TAB_GUILD_ID && socialBase.getSubTab() === DataEnum.GUILD_TAB_MEMBERS_ID)
            {
               return;
            }
         }
         this.sysApi.sendAction(GuildSetApplicationUpdatesRequestAction.create(areEnabled));
      }
      
      private function removeApplicationsRequest() : void
      {
         if(this._applicationsRequestsHandle > 0)
         {
            clearTimeout(this._applicationsRequestsHandle);
            this._applicationsRequestsHandle = 0;
         }
      }
      
      private function requestNewerApplications(timestamp:Number, limit:Number) : void
      {
         this._isWaitingForApplications = true;
         this.sysApi.sendAction(GuildApplicationsRequestAction.create(timestamp,limit));
         this._applicationsRequestsHandle = 0;
         if(this._loadingWarningHandle !== 0)
         {
            clearTimeout(this._loadingWarningHandle);
            this._loadingWarningHandle = 0;
         }
         this._loadingWarningHandle = setTimeout(this.setLoadingWarningIconState,WARNING_LOADING_TIMEOUT,true);
      }
      
      private function setLoadingWarningIconState(isVisible:Boolean) : void
      {
         if(this._loadingWarningHandle !== 0 && !isVisible)
         {
            clearTimeout(this._loadingWarningHandle);
            this._loadingWarningHandle = 0;
         }
         if(this.tx_loadingWarning === null)
         {
            return;
         }
         this.tx_loadingWarning.visible = isVisible;
      }
      
      private function setScrollListenerState(isListening:Boolean) : Boolean
      {
         if(!this.isScrollListenerPossible())
         {
            return false;
         }
         if(isListening)
         {
            this.gd_guildApplications.scrollBarV.addEventListener(Event.CHANGE,this.onScroll);
         }
         else
         {
            this.gd_guildApplications.scrollBarV.removeEventListener(Event.CHANGE,this.onScroll);
         }
         return true;
      }
      
      private function isScrollListenerPossible() : Boolean
      {
         return this.gd_guildApplications.scrollBarV !== null;
      }
      
      private function setApplicationsRequest(timestamp:Number, limit:uint) : void
      {
         if(this._isWaitingForApplications)
         {
            return;
         }
         if(this._applicationsRequestsHandle !== 0)
         {
            clearTimeout(this._applicationsRequestsHandle);
            this._applicationsRequestsHandle = 0;
         }
         this._applicationsRequestsHandle = setTimeout(this.requestNewerApplications,REQUEST_DELAY,timestamp,limit);
      }
      
      private function refreshCurrentTotalInUi() : void
      {
         this.lbl_pendingApplications.text = PatternDecoder.combine(this.uiApi.getText("ui.guild.pendingApplications",[this._currentTotal]),"f",this._currentTotal <= 1,this._currentTotal == 0);
         this.lbl_pendingApplications.fullWidth();
         this.tx_loadingWarning.x = this.lbl_pendingApplications.x + this.lbl_pendingApplications.width + Number(this.uiApi.me().getConstant("loading_warning_icon_margin"));
      }
      
      private function canManageApplications() : Boolean
      {
         return this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_APPLY_AND_INVITATION) != -1;
      }
      
      private function onApplications(applications:Vector.<GuildApplicationWrapper>, timestamp:uint, limit:uint, total:uint) : void
      {
         var item:GuildApplicationItem = null;
         this._isWaitingForApplications = false;
         this.setLoadingWarningIconState(false);
         var isNewTotal:Boolean = this._currentTotal === -1 || this._currentTotal !== total;
         if(isNewTotal)
         {
            this._currentTotal = total;
            this.refreshCurrentTotalInUi();
         }
         var application:GuildApplicationWrapper = null;
         for each(application in applications)
         {
            item = this._cachedItems.getItem(application.playerId,application.creationDate);
            if(item !== null)
            {
               item.application = application;
            }
            else
            {
               this._cachedItems.addApplication(application);
            }
         }
         this._lastTimestamp = application !== null ? Number(application.creationDate) : Number(0);
         this.gd_guildApplications.dataProvider = this._cachedItems.items;
         this.setScrollListenerState(this._cachedItems.total < this._currentTotal);
      }
      
      private function onApplicationState(application:GuildApplicationWrapper, state:uint, playerId:Number) : void
      {
         var isDeleted:* = false;
         var item:GuildApplicationItem = this._cachedItems.getItem(application.playerId,application.creationDate);
         if(item !== null)
         {
            isDeleted = state === GuildApplicationStateEnum.DELETED;
            if(playerId === this.playerApi.id() && isDeleted)
            {
               this._cachedItems.removeItem(application.playerId,application.creationDate);
            }
            else
            {
               item.application = application;
               item.isObsolete = isDeleted;
            }
            this.gd_guildApplications.dataProvider = this._cachedItems.items;
         }
         switch(state)
         {
            case GuildApplicationStateEnum.ADDED:
               ++this._currentTotal;
               if(!this.setScrollListenerState(true))
               {
                  this.requestNewerApplications(this._lastTimestamp,DEFAULT_LIMIT);
               }
               break;
            case GuildApplicationStateEnum.DELETED:
               this.setScrollListenerState(true);
               this._currentTotal = Math.max(0,this._currentTotal - 1);
               break;
            default:
               return;
         }
         this.refreshCurrentTotalInUi();
      }
      
      private function onScroll(event:Event) : void
      {
         if(this._isWaitingForApplications || this._applicationsRequestsHandle > 0)
         {
            return;
         }
         var scrollbar:ScrollBar = this.gd_guildApplications.scrollBarV;
         if(scrollbar === null || event.target !== scrollbar || this.gd_guildApplications.dataProvider === null)
         {
            return;
         }
         if(scrollbar.value !== scrollbar.max)
         {
            return;
         }
         var limit:Number = Math.min(DEFAULT_LIMIT,this._currentTotal - this.gd_guildApplications.firstItemDisplayedIndex);
         this.setApplicationsRequest(this._lastTimestamp,limit);
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var guildApplicationsUi:UiRootContainer = null;
         switch(target)
         {
            case this.mainCtr:
               guildApplicationsUi = this.uiApi.getUi(UIEnum.GUILD_APPLICATIONS);
               if(guildApplicationsUi !== null)
               {
                  guildApplicationsUi.setOnTop();
               }
               return;
            case this.btn_close:
               this.uiApi.unloadUi(UIEnum.GUILD_APPLICATIONS);
               return;
            default:
               if(target.name.indexOf("btn_accept") !== -1 && this._componentsDictionary.hasOwnProperty(target.name))
               {
                  this.sysApi.sendAction(GuildApplicationReplyAction.create(this._componentsDictionary[target.name],true));
               }
               else if(target.name.indexOf("lbl_btn_reject") !== -1 && this._componentsDictionary.hasOwnProperty(target.name))
               {
                  this.sysApi.sendAction(GuildApplicationReplyAction.create(this._componentsDictionary[target.name],false));
               }
               return;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var playerData:GuildApplicationPlayerDataWrapper = null;
         var tooltipText:String = null;
         if(target.name.indexOf("tx_statusIcon") !== -1 && this._componentsDictionary.hasOwnProperty(target.name))
         {
            playerData = this._componentsDictionary[target.name];
            tooltipText = this.socialApi.getStatusText(playerData.statusId,playerData.statusMessage);
         }
         else if(target.name.indexOf("btn_accept") !== -1 || target.name.indexOf("lbl_btn_reject") !== -1)
         {
            if(!this.canManageApplications())
            {
               tooltipText = this.uiApi.getText("ui.guild.applicationOperationForbidden");
            }
            else if(this.secureApi.SecureModeisActive())
            {
               tooltipText = this.uiApi.getText("ui.charSel.deletionErrorUnsecureMode");
            }
         }
         else if(target.name.indexOf("tx_applicationObsolete") !== -1)
         {
            tooltipText = this.uiApi.getText("ui.guild.applicationIsObsolete");
         }
         if(tooltipText === null)
         {
            return;
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
      }
      
      public function onShortcut(shortcutLabel:String) : Boolean
      {
         var me:UiRootContainer = null;
         if(shortcutLabel === ShortcutHookListEnum.CLOSE_UI)
         {
            me = this.uiApi.me();
            if(me === null)
            {
               this.sysApi.log(16,"GuildApplications: the current UI is null!");
               return false;
            }
            this.uiApi.unloadUi(me.name);
            return true;
         }
         return false;
      }
   }
}

import com.ankamagames.dofus.internalDatacenter.guild.GuildApplicationWrapper;

final class GuildApplicationItem
{
    
   
   public var application:GuildApplicationWrapper = null;
   
   private var _isObsolete:Boolean = false;
   
   public var updateCallback:Function = null;
   
   function GuildApplicationItem(application:GuildApplicationWrapper, isObsolete:Boolean, updateCallback:Function)
   {
      super();
      this.application = application;
      this.isObsolete = isObsolete;
      this.updateCallback = updateCallback;
   }
   
   public function set isObsolete(isObsolete:Boolean) : void
   {
      if(this._isObsolete !== isObsolete)
      {
         this.updateCallback(this);
      }
      this._isObsolete = isObsolete;
   }
   
   public function get isObsolete() : Boolean
   {
      return this._isObsolete;
   }
}

import com.ankamagames.dofus.internalDatacenter.guild.GuildApplicationWrapper;
import flash.utils.Dictionary;

final class GuildApplicationItems
{
    
   
   private var _cache:Vector.<GuildApplicationItem>;
   
   private var _cacheDict:Dictionary;
   
   private var _total:uint = 0;
   
   function GuildApplicationItems()
   {
      this._cache = new Vector.<GuildApplicationItem>(0);
      this._cacheDict = new Dictionary();
      super();
   }
   
   private static function getKey(playerId:Number, creationDate:Number) : String
   {
      return playerId.toString() + creationDate.toString();
   }
   
   public function get length() : uint
   {
      return this._cache.length;
   }
   
   public function get total() : uint
   {
      return this._total;
   }
   
   public function get items() : Vector.<GuildApplicationItem>
   {
      return this._cache;
   }
   
   public function addApplication(application:GuildApplicationWrapper, isObsolete:Boolean = false) : void
   {
      var item:GuildApplicationItem = new GuildApplicationItem(application,isObsolete,this.onItemUpdate);
      this._cache.push(item);
      this._cacheDict[getKey(item.application.playerId,item.application.creationDate)] = item;
      if(!item.isObsolete)
      {
         ++this._total;
      }
   }
   
   public function getItem(playerId:Number, creationDate:Number) : GuildApplicationItem
   {
      var key:String = getKey(playerId,creationDate);
      if(key in this._cacheDict)
      {
         return this._cacheDict[key];
      }
      return null;
   }
   
   public function removeItem(playerId:Number, creationDate:Number) : void
   {
      var item:GuildApplicationItem = null;
      var application:GuildApplicationWrapper = null;
      var key:String = getKey(playerId,creationDate);
      if(key in this._cacheDict)
      {
         delete this._cacheDict[key];
      }
      for(var index:uint = 0; index < this._cache.length; index++)
      {
         item = this._cache[index];
         if(!(item === null || item.application === null))
         {
            application = item.application;
            if(application.playerId === playerId && application.creationDate === creationDate)
            {
               if(!item.isObsolete)
               {
                  this._total = Math.max(0,this._total - 1);
               }
               this._cache.removeAt(index);
               break;
            }
         }
      }
   }
   
   private function onItemUpdate(item:GuildApplicationItem) : void
   {
      if(item.isObsolete)
      {
         this._total = Math.max(0,this._total - 1);
      }
      else
      {
         ++this._total;
      }
   }
}
