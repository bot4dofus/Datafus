package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import chat.protocol.friendinvite.data.FriendInvite;
   import chat.protocol.friendinvite.data.FriendInviteList;
   import chat.protocol.user.data.EndpointProperties;
   import chat.protocol.user.data.Friend;
   import chat.protocol.user.data.FriendList;
   import chat.protocol.user.data.UserPresence;
   import chat.protocol.user.data.UserStatus;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.arena.ArenaLeague;
   import com.ankamagames.dofus.datacenter.communication.Smiley;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.internalDatacenter.arena.ArenaRankInfosWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.ContactWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.FriendWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SocialCharacterWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveEnemyAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveIgnoredAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.StatusShareSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.GameFightSpectatePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagEnterAction;
   import com.ankamagames.dofus.misc.lists.ChatServiceHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.PlayerStateEnum;
   import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ChatServiceApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
   import flash.utils.Dictionary;
   
   public class Friends
   {
      
      private static const SOCIAL_LEAGUE_ICON_PREFIX:String = "social_";
      
      private static const CTR_CAT:String = "ctr_cat";
      
      private static const CTR_FRIEND:String = "ctr_launcher_friend";
      
      private static const CTR_CONTACT:String = "ctr_contact";
      
      private static const CTR_ITEM_BLOCKED:String = "bloquedItemCtr";
      
      private static const CTR_MESSAGE:String = "ctr_message";
      
      private static const CTR_SORT:String = "ctr_sort";
      
      private static const CTR_SORT_FRIEND:String = "ctr_sort_friend";
      
      private static const CTR_SORT_BLOCKED:String = "ctr_sort_bloqued";
      
      private static const MAX_CONTACT:uint = 200;
      
      private static const KEY_TEXT_ANKAMA_FRIENDS:String = "ui.social.ankamaFriends";
      
      private static const KEY_TEXT_CONTACTS:String = "ui.social.contactsInGame";
      
      private static const KEY_TEXT_CONTACTS_R:String = "ui.common.contacts_r";
      
      private static const KEY_TEXT_ENEMIES:String = "ui.social.contactInGameBlocked";
      
      private static const KEY_TEXT_IGNOREDS:String = "ui.social.contactInGameIgnored";
      
      private static const GROUP_KOLI:String = "GROUP_KOLI";
      
      private static const GROUP_DUNGEON:String = "GROUP_DUNGEON";
      
      private static const GROUP_PVM:String = "GROUP_PVM";
      
      private static const SERVER_NAME:String = "SERVER_NAME";
      
      private static const DOFUS:String = "DOFUS";
      
      private static const WAKFU:String = "WAKFU";
      
      private static const WAVEN:String = "WAVEN";
      
      private static const KROSMAGA:String = "KROSMAGA";
      
      private static const HEIGHT_REDUCED_FRIENDS_GRID:int = 338;
      
      private static const HEIGHT_EXPANDED_FRIENDS_GRID:int = 471;
      
      private static const HEIGHT_DEFAULT_FRIENDS_GRID:int = 500;
      
      private static const POSY_REDUCED_BTN_OPENWAIT:int = 0;
      
      private static const POSY_EXPANDED_BTN_OPENWAIT:int = 130;
      
      private static const ID_ZAAP:int = 102;
      
      private static const GREAT_VALUE:int = 1000;
       
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="ChatServiceApi")]
      public var chatServiceApi:ChatServiceApi;
      
      private var _chatService:Object;
      
      private var _launcherList:Vector.<Friend>;
      
      private var _pendingList:Vector.<FriendInvite>;
      
      private var _friendsList:Vector.<SocialCharacterWrapper>;
      
      private var _contactsList:Vector.<SocialCharacterWrapper>;
      
      private var _mergedList:Vector.<SocialCharacterWrapper>;
      
      private var _enemiesList:Vector.<SocialCharacterWrapper>;
      
      private var _ignoredList:Vector.<SocialCharacterWrapper>;
      
      private var _nCurrentTab:uint = 0;
      
      private var _bHideOfflineGuys:Boolean = false;
      
      private var _bShowOnlyDofusGuys:Boolean = false;
      
      private var _tabsSortType:Dictionary;
      
      private var _componentData:Dictionary;
      
      private var _dictionnaryFriends:Dictionary;
      
      private var _iconsPath:String;
      
      private var _texturesPath:String;
      
      private var _gameIconsPath:String;
      
      private var _friendIdWaitingForKick:String = null;
      
      private var _contactIdWaitingForKick:int = -1;
      
      private var _enemyIdWaitingForKick:int = -1;
      
      private var _bgLevelUri:Object;
      
      private var _bgPrestigeUri:Object;
      
      private var _currentTabName:String;
      
      private var _currentSortElem:SortType;
      
      private var _closedCategories:Array;
      
      private var _dataMatrix:Array;
      
      public var btn_friend:ButtonContainer;
      
      public var btn_contact:ButtonContainer;
      
      public var btn_blocked:ButtonContainer;
      
      public var btn_openWait:ButtonContainer;
      
      public var tx_pendingListPlusMinus:Texture;
      
      public var gd_friends:Grid;
      
      public var gd_pendingInvitations:Grid;
      
      public var btn_hideOfflineFriends:ButtonContainer;
      
      public var btn_hideOfflineContacts:ButtonContainer;
      
      public var btn_showOnlyDofusGuys:ButtonContainer;
      
      public var btn_shareStatus:ButtonContainer;
      
      public var btn_tabBreed:ButtonContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabGuild:ButtonContainer;
      
      public var btn_tabAchievement:ButtonContainer;
      
      public var btn_tabLeague:ButtonContainer;
      
      public var btn_tabState:ButtonContainer;
      
      public var lbl_accountName:Label;
      
      public var lbl_categoryCounterA:Label;
      
      public var lbl_categoryCounterB:Label;
      
      public var ctr_combo:GraphicContainer;
      
      public var cbx_activity:ComboBox;
      
      public var lbl_pendingTitle:Label;
      
      public var tx_notifPending:Texture;
      
      public function Friends()
      {
         this._tabsSortType = new Dictionary(true);
         this._componentData = new Dictionary(true);
         this._dictionnaryFriends = new Dictionary(true);
         super();
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function main(params:Array) : void
      {
         var cbxField_1:String = null;
         var cbxField_2:String = null;
         var cbxField_3:String = null;
         this.sysApi.startStats("userActivity");
         this.btn_friend.soundId = SoundEnum.TAB;
         this.btn_contact.soundId = SoundEnum.TAB;
         this.btn_blocked.soundId = SoundEnum.TAB;
         this.sysApi.addHook(ChatServiceHookList.ChatServiceFriendListUpdated,this.onFriendLauncherListUpdated);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceUserFriendCreated,this.onFriendLauncherCreated);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceUserFriendDeleted,this.onFriendLauncherDeleted);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceFriendInviteListUpdated,this.onPendingInvitationsUpdated);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceFriendInviteCreated,this.onFriendInviteLauncherCreated);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceFriendInviteProcessed,this.onFriendInviteLauncherDeleted);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceUserUpdatedPresence,this.onUserUpdatedPresence);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceUserUpdatedStatus,this.onUserUpdateStatus);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceUserUpdatedActivities,this.onUserUpdateActivities);
         this.sysApi.addHook(SocialHookList.FriendsListUpdated,this.onFriendsOrContactUpdated);
         this.sysApi.addHook(SocialHookList.ContactsListUpdated,this.onFriendsOrContactUpdated);
         this.sysApi.addHook(SocialHookList.EnemiesListUpdated,this.onEnemiesUpdated);
         this.sysApi.addHook(SocialHookList.IgnoredListUpdated,this.onIgnoredUpdated);
         this.sysApi.addHook(SocialHookList.ShareStatusState,this.onStatusShareState);
         this.uiApi.addComponentHook(this.btn_hideOfflineFriends,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_shareStatus,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_friend,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_contact,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_blocked,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_openWait,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this._iconsPath = this.uiApi.me().getConstant("icons_uri");
         this._texturesPath = this.uiApi.me().getConstant("texture");
         this._gameIconsPath = this.uiApi.me().getConstant("games_uri");
         this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
         this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
         this._launcherList = this.chatServiceApi.getFriendsList() as Vector.<Friend>;
         this._pendingList = this.chatServiceApi.getWaitingList() as Vector.<FriendInvite>;
         this._friendsList = this.socialApi.getFriendsList() as Vector.<SocialCharacterWrapper>;
         this._contactsList = this.socialApi.getContactsList() as Vector.<SocialCharacterWrapper>;
         this._enemiesList = this.socialApi.getEnemiesList() as Vector.<SocialCharacterWrapper>;
         this._ignoredList = this.socialApi.getIgnoredList() as Vector.<SocialCharacterWrapper>;
         this.mergeFriendsAndContacts();
         this._closedCategories = this.sysApi.getData("closedFriendsCat");
         if(!this._closedCategories)
         {
            this._closedCategories = [];
         }
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_friend,this.uiApi.me());
         this.btn_friend.selected = true;
         this._nCurrentTab = params != null && params.length > 0 ? uint(params[0]) : uint(0);
         this.btn_hideOfflineFriends.selected = false;
         this.btn_showOnlyDofusGuys.selected = false;
         this.btn_shareStatus.selected = !this.socialApi.getShareStatus();
         this.tx_notifPending.x = this.lbl_pendingTitle.x + this.lbl_pendingTitle.textWidth + 10;
         this.lbl_accountName.setStyleSheet(UiApi.styleForTagName);
         this.lbl_accountName.htmlText = PlayerManager.getInstance().formatTagName(this.sysApi.getPlayerManager().nickname,this.sysApi.getPlayerManager().tag);
         this.lbl_accountName.finalize();
         this.gd_pendingInvitations.dataProvider = this._pendingList;
         this.gd_pendingInvitations.verticalScrollSpeed = 1 / 3;
         this.gd_friends.verticalScrollSpeed = 1 / 3;
         this._tabsSortType[SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA] = new SortType(this.sortByAccountName,true,"account");
         this._tabsSortType[SocialCharacterCategoryEnum.CATEGORY_FRIEND] = new SortType(this.sortByName);
         this._tabsSortType[SocialCharacterCategoryEnum.CATEGORY_CONTACT] = new SortType(this.sortByName);
         this._tabsSortType[SocialCharacterCategoryEnum.CATEGORY_ENEMY] = new SortType(this.sortByName);
         this._tabsSortType[SocialCharacterCategoryEnum.CATEGORY_IGNORED] = new SortType(this.sortByName);
         this._chatService = this.chatServiceApi.service;
         if(this._chatService !== null)
         {
            cbxField_1 = this._chatService.getMyGameActivity(GROUP_KOLI);
            cbxField_2 = this._chatService.getMyGameActivity(GROUP_DUNGEON);
            cbxField_3 = this._chatService.getMyGameActivity(GROUP_PVM);
            this.cbx_activity.dataProvider = [this.uiApi.getText("ui.socialActivity.playAt",this._chatService.CurrentGameName),cbxField_1 != null ? cbxField_1 : "",cbxField_2 != null ? cbxField_2 : "",cbxField_3 != null ? cbxField_3 : ""];
            this.uiApi.addComponentHook(this.cbx_activity,ComponentHookList.ON_SELECT_ITEM);
         }
         this.displaySelectedTab(this._nCurrentTab);
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var itemCategory:Friends_Category_Item = null;
         var showFriendsElem:* = false;
         var character:SocialCharacterWrapper = null;
         var completeInfos:Boolean = false;
         var isClosed:* = false;
         var friendLauncher:Friend = null;
         var accountId:uint = 0;
         var userProperties:Object = null;
         var gameActivities:Dictionary = null;
         var lastActivity:String = null;
         var serverName:String = null;
         var friend:FriendWrapper = null;
         var charEmpty:String = null;
         switch(this.getCategoryLineType(data,line))
         {
            case CTR_MESSAGE:
               componentsRef.lbl_text.text = data;
               break;
            case CTR_CAT:
               itemCategory = data as Friends_Category_Item;
               componentsRef.btn_addToList.visible = itemCategory.e_category != SocialCharacterCategoryEnum.CATEGORY_CONTACT;
               this.addHookOnGridElements(componentsRef.btn_addToList,itemCategory);
               this.addHookOnGridElements(componentsRef.ctr_cat,itemCategory);
               componentsRef.lbl_catName.text = itemCategory.name;
               componentsRef.tx_catplusminus.visible = false;
               if(this._nCurrentTab != 0 && itemCategory.count > 0)
               {
                  componentsRef.tx_catplusminus.visible = true;
                  isClosed = this._closedCategories.indexOf(itemCategory.e_category) == -1;
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this._texturesPath + (!!isClosed ? "icon_minus_grey.png" : "icon_plus_grey.png"));
               }
               break;
            case CTR_SORT:
               showFriendsElem = data.e_category == SocialCharacterCategoryEnum.CATEGORY_FRIEND;
               componentsRef.btn_tabLevel.visible = showFriendsElem;
               componentsRef.btn_tabGuild.visible = showFriendsElem;
               componentsRef.btn_tabBreed.visible = showFriendsElem;
               componentsRef.btn_tabAchievement.visible = showFriendsElem;
               componentsRef.btn_tabLeague.visible = showFriendsElem;
               this.addHookOnGridElements(componentsRef.btn_tabName,data);
               this.addHookOnGridElements(componentsRef.btn_tabLevel,data);
               this.addHookOnGridElements(componentsRef.btn_tabGuild,data);
               this.addHookOnGridElements(componentsRef.btn_tabAchievement,data);
               this.addHookOnGridElements(componentsRef.btn_tabLeague,data);
               break;
            case CTR_SORT_FRIEND:
               this.addHookOnGridElements(componentsRef.btn_sort_friend_account,data);
               this.addHookOnGridElements(componentsRef.btn_sort_friend_activity,data);
               this.addHookOnGridElements(componentsRef.btn_sort_friend_server,data);
               break;
            case CTR_SORT_BLOCKED:
               this.addHookOnGridElements(componentsRef.btn_tabName,data);
               break;
            case CTR_ITEM_BLOCKED:
               componentsRef.lbl_nameBloqued.setStyleSheet(UiApi.styleForTagName);
               componentsRef.lbl_nameBloqued.htmlText = PlayerManager.getInstance().formatTagName(data.name,data.tag);
               componentsRef.lbl_nameBloqued.finalize();
               componentsRef.btn_lbl_btn_unlock.text = this.uiApi.getText(data.e_category == SocialCharacterCategoryEnum.CATEGORY_ENEMY ? "ui.social.unlock" : "ui.social.unignore");
               this.addHookOnGridElements(componentsRef.btn_unlock,data);
               break;
            case CTR_FRIEND:
               if(this._chatService !== null)
               {
                  friendLauncher = data as Friend;
                  accountId = parseInt(friendLauncher.user.userId);
                  componentsRef.btn_addContact.visible = !this.isMutualContact(accountId) && !this.isContact(accountId);
                  componentsRef.btn_addContact.softDisabled = !(this._chatService !== null && this._chatService.authenticated);
                  this.addHookOnGridElements(componentsRef.btn_addContact,data);
                  if(friendLauncher.presence == UserPresence.OFFLINE)
                  {
                     componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "grey.png");
                     componentsRef.tx_game.uri = null;
                  }
                  else
                  {
                     switch(friendLauncher.status)
                     {
                        case UserStatus.AVAILABLE:
                           componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "green.png");
                           break;
                        case UserStatus.AWAY:
                           componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "yellow.png");
                           break;
                        case UserStatus.BUSY:
                           componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "red.png");
                     }
                  }
                  componentsRef.tx_status.finalize();
                  componentsRef.lbl_name.setStyleSheet(UiApi.styleForTagName);
                  componentsRef.lbl_name.htmlText = "{account," + friendLauncher.user.name + "," + friendLauncher.user.tag + "," + friendLauncher.user.userId + "," + SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA + "::" + PlayerManager.getInstance().formatTagName(friendLauncher.user.name,friendLauncher.user.tag) + "}";
                  componentsRef.lbl_name.finalize();
                  componentsRef.lbl_activity.text = "";
                  componentsRef.lbl_character.text = "";
                  if(friendLauncher.presence == UserPresence.ONLINE && data.activities && data.activities.length > 0)
                  {
                     userProperties = data.activities[0];
                     gameActivities = this._chatService.getGameActivitiesByGame(userProperties.applicationId);
                     if(userProperties.activities.length > 0)
                     {
                        lastActivity = userProperties.activities[0];
                        if(gameActivities && gameActivities[lastActivity])
                        {
                           componentsRef.lbl_activity.text = gameActivities[lastActivity];
                        }
                        else if(lastActivity)
                        {
                           componentsRef.lbl_activity.text = lastActivity;
                        }
                        componentsRef.lbl_activity.cssClass = "orange";
                     }
                     else if(userProperties.applicationId)
                     {
                        componentsRef.lbl_activity.cssClass = "";
                        componentsRef.lbl_activity.text = userProperties.applicationId == ID_ZAAP ? this.uiApi.getText("ui.socialActivity.onLauncher") : this.uiApi.getText("ui.socialActivity.playAt",this._chatService.getGameName(userProperties.applicationId));
                     }
                     if(gameActivities)
                     {
                        serverName = !!gameActivities[userProperties.metadata[SERVER_NAME]] ? gameActivities[userProperties.metadata[SERVER_NAME]] : userProperties.metadata[SERVER_NAME];
                        componentsRef.lbl_character.text = serverName;
                     }
                     else
                     {
                        componentsRef.lbl_character.text = "";
                     }
                     this.addHookOnGridElements(componentsRef.tx_game,this._chatService.getGameName(userProperties.applicationId),false);
                     switch(userProperties.applicationId)
                     {
                        case this._chatService.getGameId(DOFUS):
                           componentsRef.tx_game.uri = this.uiApi.createUri(this._gameIconsPath + "dofus.png");
                           break;
                        case this._chatService.getGameId(WAKFU):
                           componentsRef.tx_game.uri = this.uiApi.createUri(this._gameIconsPath + "wakfu.png");
                           break;
                        case this._chatService.getGameId(WAVEN):
                           componentsRef.tx_game.uri = this.uiApi.createUri(this._gameIconsPath + "waven.png");
                           break;
                        case this._chatService.getGameId(KROSMAGA):
                           componentsRef.tx_game.uri = this.uiApi.createUri(this._gameIconsPath + "krosmaga.png");
                           break;
                        default:
                           componentsRef.tx_game.uri = this.uiApi.createUri(this._gameIconsPath + "launcher.png");
                     }
                  }
                  if(componentsRef.tx_game.uri == null)
                  {
                     componentsRef.tx_game.uri = friendLauncher.presence == UserPresence.OFFLINE ? null : this.uiApi.createUri(this._gameIconsPath + "launcher.png");
                  }
                  componentsRef.tx_game.finalize();
               }
               break;
            case CTR_CONTACT:
               character = data as SocialCharacterWrapper;
               componentsRef.btn_addAnkamaFriend.visible = !this.isAnkamaFriend(character.accountId) && !this.isInvited(character.accountId) && this.isMutualContact(character.accountId);
               componentsRef.btn_addAnkamaFriend.softDisabled = this._chatService === null || !this._chatService.authenticated;
               this.addHookOnGridElements(componentsRef.btn_addAnkamaFriend,data);
               componentsRef.lbl_name.setStyleSheet(UiApi.styleForTagName);
               componentsRef.lbl_name.htmlText = !!character.online ? "{player," + character.playerName + "," + character.playerId + "," + null + "," + 0 + "," + 0 + "," + character.accountId + "::" + PlayerManager.getInstance().formatTagName(character.name,character.tag,character.playerName) + "}" : "{account," + character.name + "," + character.tag + "," + character.accountId + "," + SocialCharacterCategoryEnum.CATEGORY_CONTACT + "::" + PlayerManager.getInstance().formatTagName(character.name,character.tag) + "}";
               componentsRef.lbl_name.finalize();
               if(data.statusId)
               {
                  switch(data.statusId)
                  {
                     case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                        componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "green.png");
                        break;
                     case PlayerStatusEnum.PLAYER_STATUS_AFK:
                     case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                        componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "yellow.png");
                        break;
                     case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                        componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "blue.png");
                        break;
                     case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                        componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "red.png");
                        break;
                     default:
                        componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "grey.png");
                  }
               }
               else
               {
                  componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "grey.png");
               }
               completeInfos = character.online && character.e_category == SocialCharacterCategoryEnum.CATEGORY_FRIEND;
               componentsRef.tx_mood.visible = completeInfos;
               componentsRef.tx_fight.visible = completeInfos;
               componentsRef.tx_emblemBackGuild.visible = completeInfos;
               componentsRef.tx_emblemUpGuild.visible = completeInfos;
               componentsRef.tx_level.visible = completeInfos;
               componentsRef.tx_havenbag.visible = completeInfos;
               componentsRef.tx_state.visible = completeInfos;
               componentsRef.tx_breed.visible = completeInfos;
               componentsRef.tx_league.visible = completeInfos;
               if(!completeInfos)
               {
                  componentsRef.lbl_level.text = "";
                  componentsRef.lbl_guild.text = "";
                  componentsRef.lbl_achievement.text = "";
                  return;
               }
               if(character.e_category == SocialCharacterCategoryEnum.CATEGORY_FRIEND)
               {
                  friend = data as FriendWrapper;
                  if(!friend.online)
                  {
                     charEmpty = "-";
                     componentsRef.lbl_level.text = charEmpty;
                     componentsRef.lbl_guild.text = charEmpty;
                     componentsRef.lbl_achievement.text = charEmpty;
                     return;
                  }
                  this.setFriendsInfo(friend,componentsRef);
                  this.saveComponentData(componentsRef,character);
               }
               break;
            case CTR_MESSAGE:
         }
      }
      
      private function setFriendsInfo(friend:FriendWrapper, componentsRef:*) : void
      {
         var icon:EmblemSymbol = null;
         var ariw:ArenaRankInfosWrapper = null;
         var smiley:Smiley = null;
         componentsRef.tx_breed.uri = this.uiApi.createUri(this.uiApi.me().getConstant("heads") + friend.breed + "" + friend.sex + ".png");
         if(friend.level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            componentsRef.lbl_level.cssClass = "darkboldcenter";
            componentsRef.lbl_level.text = (friend.level - ProtocolConstantsEnum.MAX_LEVEL).toString();
            componentsRef.tx_level.uri = this._bgPrestigeUri;
            this.uiApi.addComponentHook(componentsRef.lbl_level,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.lbl_level,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(componentsRef.tx_level,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.tx_level,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            this.uiApi.removeComponentHook(componentsRef.tx_level,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(componentsRef.tx_level,ComponentHookList.ON_ROLL_OUT);
            componentsRef.lbl_level.cssClass = "boldcenter";
            componentsRef.lbl_level.text = friend.level;
            componentsRef.tx_level.uri = this._bgLevelUri;
         }
         componentsRef.lbl_guild.text = friend.realGuildName == "" ? "" : this.chatApi.getGuildLink(friend,friend.guildName);
         if(friend.guildBackEmblem && friend.guildBackEmblem.idEmblem != 0)
         {
            componentsRef.tx_emblemBackGuild.visible = true;
            componentsRef.tx_emblemUpGuild.visible = true;
            componentsRef.tx_emblemBackGuild.uri = friend.guildBackEmblem.iconUri;
            componentsRef.tx_emblemUpGuild.uri = friend.guildUpEmblem.iconUri;
            this.utilApi.changeColor(componentsRef.tx_emblemBackGuild,friend.guildBackEmblem.color,1);
            icon = this.dataApi.getEmblemSymbol(friend.guildUpEmblem.idEmblem);
            this.utilApi.changeColor(componentsRef.tx_emblemUpGuild,friend.guildUpEmblem.color,0,!(icon && icon.colorizable));
         }
         else
         {
            componentsRef.tx_emblemBackGuild.visible = false;
            componentsRef.tx_emblemUpGuild.visible = false;
         }
         componentsRef.lbl_achievement.text = friend.achievementPoints == -1 ? "" : friend.achievementPoints;
         if(friend.leagueId <= 0)
         {
            ariw = new ArenaRankInfosWrapper();
            componentsRef.tx_league.uri = this.uiApi.createUri(this.uiApi.me().getConstant("leagues_uri") + SOCIAL_LEAGUE_ICON_PREFIX + ariw.LEAGUE_DEFAULT_ICON_ID);
         }
         else
         {
            componentsRef.tx_league.uri = this.uiApi.createUri(this.uiApi.me().getConstant("leagues_uri") + SOCIAL_LEAGUE_ICON_PREFIX + this.dataApi.getArenaLeagueById(friend.leagueId).iconWithExtension);
         }
         componentsRef.tx_havenbag.visible = friend.havenbagShared;
         if(friend.moodSmileyId != 0)
         {
            smiley = this.dataApi.getSmiley(friend.moodSmileyId);
            if(smiley)
            {
               componentsRef.tx_mood.uri = this.uiApi.createUri(this.uiApi.me().getConstant("smilies_uri") + smiley.gfxId);
            }
         }
         if(friend.state == PlayerStateEnum.GAME_TYPE_FIGHT)
         {
            componentsRef.tx_state.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + (friend.moodSmileyId == 0 ? "Social_tx_fightState" : "Social_tx_fightState_small"));
         }
      }
      
      public function getCategoryLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data is Friends_Sort_Item)
         {
            switch(data.e_category)
            {
               case SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA:
                  return CTR_SORT_FRIEND;
               case SocialCharacterCategoryEnum.CATEGORY_FRIEND:
               case SocialCharacterCategoryEnum.CATEGORY_CONTACT:
                  return CTR_SORT;
               default:
                  return CTR_SORT_BLOCKED;
            }
         }
         else
         {
            if(data is String)
            {
               return CTR_MESSAGE;
            }
            if(data is Friends_Category_Item)
            {
               return CTR_CAT;
            }
            if(data is SocialCharacterWrapper && (data.e_category == SocialCharacterCategoryEnum.CATEGORY_IGNORED || data.e_category == SocialCharacterCategoryEnum.CATEGORY_ENEMY))
            {
               return CTR_ITEM_BLOCKED;
            }
            if(data is Friend)
            {
               return CTR_FRIEND;
            }
            return CTR_CONTACT;
         }
      }
      
      public function getCategoryDataLength(data:*, selected:Boolean) : *
      {
         return 10;
      }
      
      public function updateWaitLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            if(data.inviter.name == this.sysApi.getPlayerManager().nickname && (data.inviter.tag == "" || data.inviter.tag == this.sysApi.getPlayerManager().tag))
            {
               componentsRef.lbl_invitationPlayerName.setStyleSheet(UiApi.styleForTagName);
               componentsRef.lbl_invitationPlayerName.htmlText = PlayerManager.getInstance().formatTagName(data.recipient.name,data.recipient.tag);
               componentsRef.ctr_invitationSent.visible = true;
               componentsRef.ctr_invitationReceived.visible = false;
               this.addHookOnGridElements(componentsRef.btn_cancelInvitation,data);
            }
            else
            {
               componentsRef.lbl_invitationPlayerName.setStyleSheet(UiApi.styleForTagName);
               componentsRef.lbl_invitationPlayerName.htmlText = PlayerManager.getInstance().formatTagName(data.inviter.name,data.inviter.tag);
               componentsRef.ctr_invitationSent.visible = false;
               componentsRef.ctr_invitationReceived.visible = true;
               this.addHookOnGridElements(componentsRef.btn_acceptInvitation,data);
               this.addHookOnGridElements(componentsRef.btn_refuseInvitation,data);
            }
         }
         else
         {
            componentsRef.lbl_invitationPlayerName.text = "";
            componentsRef.ctr_invitationSent.visible = false;
            componentsRef.ctr_invitationReceived.visible = false;
         }
      }
      
      public function acceptInvitation(... args) : void
      {
         this.chatServiceApi.acceptInvite(args[0]);
      }
      
      public function refuseInvitation(... args) : void
      {
         this.chatServiceApi.rejectInvite(args[0]);
      }
      
      public function cancelInvitation(... args) : void
      {
         this.chatServiceApi.cancelInvite(args[0]);
      }
      
      private function getPlayerLink(character:SocialCharacterWrapper, isFriend:Boolean = false) : String
      {
         return !!character.playerId ? "{player," + character.playerName + "," + character.playerId + "," + 0 + "," + null + "," + 0 + "," + character.accountId + "::" + character.name + (!!isFriend ? "" : " (" + character.playerName + ")") + "}" : "{player," + character.playerName + 0 + "," + 0 + "," + null + "," + 0 + "," + character.accountId + "::" + character.name + (!!isFriend ? "" : " (" + character.playerName + ")") + "}";
      }
      
      private function addHookOnGridElements(componentItem:*, data:*, addRelease:Boolean = true, addRollOver:Boolean = true, addRollOut:Boolean = true) : void
      {
         if(!this._componentData[componentItem.name])
         {
            if(addRelease)
            {
               this.uiApi.addComponentHook(componentItem,ComponentHookList.ON_RELEASE);
            }
            if(addRollOver)
            {
               this.uiApi.addComponentHook(componentItem,ComponentHookList.ON_ROLL_OVER);
            }
            if(addRollOut)
            {
               this.uiApi.addComponentHook(componentItem,ComponentHookList.ON_ROLL_OUT);
            }
         }
         this._componentData[componentItem.name] = data;
      }
      
      private function saveComponentData(components:*, data:SocialCharacterWrapper) : void
      {
         this.addHookOnGridElements(components.lbl_name,data,false);
         this.addHookOnGridElements(components.tx_status,data,false);
         if(data.e_category == SocialCharacterCategoryEnum.CATEGORY_FRIEND)
         {
            this.addHookOnGridElements(components.tx_state,data);
            this.addHookOnGridElements(components.tx_breed,data);
            this.addHookOnGridElements(components.tx_mood,data);
            this.addHookOnGridElements(components.tx_fight,data);
            this.addHookOnGridElements(components.tx_league,data,false);
            this.addHookOnGridElements(components.tx_havenbag,data);
         }
      }
      
      private function displaySelectedTab(tab:uint) : void
      {
         var isWaitListOpen:* = false;
         this.uiApi.getUi("socialBase").uiClass.setSubTab(tab);
         this.gd_friends.height = HEIGHT_DEFAULT_FRIENDS_GRID;
         this.btn_friend.selected = false;
         this.btn_contact.selected = false;
         this.btn_blocked.selected = false;
         switch(tab)
         {
            case 0:
               this.btn_friend.selected = true;
               this.btn_hideOfflineFriends.visible = true;
               this.btn_hideOfflineContacts.visible = false;
               this.btn_showOnlyDofusGuys.visible = true;
               this.btn_shareStatus.visible = false;
               this.btn_openWait.visible = true;
               isWaitListOpen = this._closedCategories.indexOf(0) == -1;
               this.gd_pendingInvitations.visible = isWaitListOpen;
               this.btn_openWait.y = !!isWaitListOpen ? Number(POSY_REDUCED_BTN_OPENWAIT) : Number(POSY_EXPANDED_BTN_OPENWAIT);
               this.gd_friends.height = !!isWaitListOpen ? Number(HEIGHT_REDUCED_FRIENDS_GRID) : Number(HEIGHT_EXPANDED_FRIENDS_GRID);
               this.tx_pendingListPlusMinus.uri = this.uiApi.createUri(this._texturesPath + (!!isWaitListOpen ? "icon_minus_grey.png" : "icon_plus_grey.png"));
               this.lbl_categoryCounterB.visible = false;
               this.ctr_combo.visible = true;
               this.btn_hideOfflineFriends.selected = this.sysApi.getData("hideOfflineFriends");
               this.btn_showOnlyDofusGuys.selected = this.sysApi.getData("showOnlyDofusGuys");
               this._bHideOfflineGuys = this.btn_hideOfflineFriends.selected;
               this._bShowOnlyDofusGuys = this.btn_showOnlyDofusGuys.selected;
               this.onFriendsOrContactUpdated();
               return;
            case 1:
               this.btn_contact.selected = true;
               this.btn_hideOfflineFriends.visible = false;
               this.btn_hideOfflineContacts.visible = true;
               this.btn_showOnlyDofusGuys.visible = false;
               this.btn_shareStatus.visible = true;
               this.btn_openWait.visible = false;
               this.gd_pendingInvitations.visible = false;
               this.btn_hideOfflineContacts.selected = this.sysApi.getData("hideOfflineContacts");
               this._bHideOfflineGuys = this.btn_hideOfflineContacts.selected;
               this.lbl_categoryCounterB.visible = true;
               this.ctr_combo.visible = false;
               this.onFriendsOrContactUpdated();
               return;
            case 2:
               this.btn_blocked.selected = true;
               this.btn_hideOfflineFriends.visible = false;
               this.btn_showOnlyDofusGuys.visible = false;
               this.btn_shareStatus.visible = false;
               this.btn_openWait.visible = false;
               this.gd_pendingInvitations.visible = false;
               this.lbl_categoryCounterB.visible = true;
               this.ctr_combo.visible = false;
         }
         this.refreshGrid(tab);
      }
      
      private function refreshGrid(tabToRefresh:int = -1) : void
      {
         if(tabToRefresh == -1)
         {
            tabToRefresh = this._nCurrentTab;
         }
         if(tabToRefresh == this._nCurrentTab)
         {
            this._dataMatrix = [];
            switch(this._nCurrentTab)
            {
               case 0:
                  this.tx_notifPending.visible = this.hasPendingInvitationsReceived();
                  if(this._chatService === null || !this._chatService.authenticated)
                  {
                     this._dataMatrix = [];
                     this._dataMatrix.push(this.uiApi.getText("ui.popup.accessDenied.serviceUnavailable"));
                     this.gd_friends.dataProvider = this._dataMatrix;
                     this.gd_pendingInvitations.dataProvider = [];
                     return;
                  }
                  this.pushCatAndContentLauncher(SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA,KEY_TEXT_ANKAMA_FRIENDS,this._launcherList,this.lbl_categoryCounterA,this._bHideOfflineGuys);
                  break;
               case 1:
                  this.pushCatAndContent(SocialCharacterCategoryEnum.CATEGORY_FRIEND,KEY_TEXT_CONTACTS_R,this._friendsList,this.lbl_categoryCounterA,this._bHideOfflineGuys);
                  this.pushCatAndContent(SocialCharacterCategoryEnum.CATEGORY_CONTACT,KEY_TEXT_CONTACTS,this._contactsList,this.lbl_categoryCounterB,this._bHideOfflineGuys);
                  break;
               case 2:
                  this.pushCatAndContent(SocialCharacterCategoryEnum.CATEGORY_ENEMY,KEY_TEXT_ENEMIES,this._enemiesList,this.lbl_categoryCounterA);
                  this.pushCatAndContent(SocialCharacterCategoryEnum.CATEGORY_IGNORED,KEY_TEXT_IGNOREDS,this._ignoredList,this.lbl_categoryCounterB);
            }
            this.applySorts();
            this.displayCategories();
         }
      }
      
      private function hasPendingInvitationsReceived() : Boolean
      {
         if(this._chatService === null || !this._chatService.authenticated)
         {
            return false;
         }
         for(var i:int = 0; i < this.gd_pendingInvitations.dataProvider.length; i++)
         {
            if(this.gd_pendingInvitations.dataProvider[i].inviter.name != this.sysApi.getPlayerManager().nickname)
            {
               return true;
            }
         }
         return false;
      }
      
      private function pushCatAndContent(e_category:uint, keyTextCat:String, list:Vector.<SocialCharacterWrapper>, label:Label, onlyOnline:Boolean = false) : void
      {
         var character:SocialCharacterWrapper = null;
         var countToShow:int = 0;
         var countBeforeFilter:int = list.length;
         var categoryTitle:String = this.uiApi.getText(keyTextCat);
         this._dataMatrix.push(new Friends_Category_Item(categoryTitle,e_category,list.length));
         if(list.length > 0)
         {
            this._dataMatrix.push(new Friends_Sort_Item(e_category));
            for each(character in list)
            {
               if(!onlyOnline || character.online)
               {
                  this._dataMatrix.push(character);
                  countToShow++;
               }
            }
         }
         label.text = this.uiApi.getText(keyTextCat) + " : " + countToShow + "/" + (!!onlyOnline ? countBeforeFilter : MAX_CONTACT);
      }
      
      private function pushCatAndContentLauncher(e_category:uint, keyTextCat:String, list:Vector.<Friend>, label:Label, onlyOnline:Boolean = false) : void
      {
         var character:Friend = null;
         var countToShow:int = 0;
         var countBeforeFilter:int = list.length;
         var categoryTitle:String = this.uiApi.getText(keyTextCat);
         this._dataMatrix.push(new Friends_Category_Item(categoryTitle,e_category,list.length));
         if(list.length > 0)
         {
            this._dataMatrix.push(new Friends_Sort_Item(e_category));
            for each(character in list)
            {
               if((!onlyOnline || character.presence == UserPresence.ONLINE) && !this._bShowOnlyDofusGuys || character.activities && character.activities.length > 0 && character.activities[0].applicationId == 1)
               {
                  this._dataMatrix.push(character);
                  countToShow++;
               }
            }
         }
         label.text = this.uiApi.getText(keyTextCat) + " : " + countToShow + "/" + (!!onlyOnline ? countBeforeFilter : MAX_CONTACT);
      }
      
      private function displayCategories(selectedCategoryId:uint = 0, lenght:int = 0, forceOpen:Boolean = false) : void
      {
         var category:Friends_Category_Item = null;
         var entry:Object = null;
         var scrollValue:int = 0;
         if(selectedCategoryId > 0 && lenght > 0)
         {
            if(this._closedCategories.indexOf(selectedCategoryId) != -1)
            {
               this._closedCategories.splice(this._closedCategories.indexOf(selectedCategoryId),1);
            }
            else
            {
               this._closedCategories.push(selectedCategoryId);
            }
         }
         var tempCats:Array = [];
         var selectedIndex:int = -1;
         var index:int = -1;
         for each(entry in this._dataMatrix)
         {
            if(entry is Friends_Category_Item)
            {
               category = entry as Friends_Category_Item;
               tempCats.push(category);
               if(category.e_category == selectedCategoryId)
               {
                  selectedIndex = index;
               }
            }
            else if(entry is Friend || this._closedCategories.indexOf(entry.e_category) == -1)
            {
               tempCats.push(entry);
            }
            index++;
         }
         scrollValue = this.gd_friends.verticalScrollValue;
         if(tempCats.length > 0)
         {
            this.gd_friends.dataProvider = tempCats;
         }
         if(this.gd_friends.selectedIndex != selectedIndex)
         {
            this.gd_friends.silent = true;
            this.gd_friends.selectedIndex = selectedIndex;
            this.gd_friends.silent = false;
         }
         this.gd_friends.verticalScrollValue = scrollValue;
         this.gd_friends.focus();
         this.sysApi.setData("closedFriendsCat",this._closedCategories);
      }
      
      private function applySorts() : void
      {
         var k:* = null;
         for(k in this._tabsSortType)
         {
            this.sortGrid(k);
         }
      }
      
      private function showConfirmPopup(data:Object, textKey:String, onEnterKey:Function, onCancel:Function) : void
      {
         var name:String = null;
         if(data is Friend)
         {
            name = PlayerManager.getInstance().formatTagName(data.user.name,data.user.tag,null,false);
         }
         else if(data.online)
         {
            name = PlayerManager.getInstance().formatTagName(data.name,data.tag,data.playerName,false);
         }
         else
         {
            name = name = PlayerManager.getInstance().formatTagName(data.name,data.tag,null,false);
         }
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText(textKey,name),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[onEnterKey,onCancel],onEnterKey,onCancel);
      }
      
      private function sortGridWithCat(sortFunc:Function, targetName:String = null) : void
      {
         var tab:SortType = this._tabsSortType[this.gd_friends.selectedItem.e_category] as SortType;
         tab.ascending = tab.targetName === targetName ? !tab.ascending : true;
         tab.targetName = targetName;
         tab.sortFunc = sortFunc;
         this._tabsSortType[this.gd_friends.selectedItem.e_category] = tab;
         this.sortGrid(this.gd_friends.selectedItem.e_category);
      }
      
      private function sortGrid(category:String = null) : void
      {
         var startIndex:uint = 0;
         var count:uint = 0;
         var i:uint = 0;
         var tempArray:Array = null;
         var index:int = 0;
         this._currentSortElem = this._tabsSortType[category] as SortType;
         if(this._currentSortElem != null)
         {
            startIndex = 0;
            count = 0;
            i = 0;
            while(i < this._dataMatrix.length && !(this._dataMatrix[i] is Friends_Sort_Item && this._dataMatrix[i].e_category == category))
            {
               startIndex++;
               i++;
            }
            startIndex++;
            i = startIndex;
            while(i < this._dataMatrix.length && !(this._dataMatrix[i] is Friends_Category_Item))
            {
               count++;
               i++;
            }
            if(count > 0)
            {
               tempArray = this._dataMatrix.splice(startIndex,count);
               tempArray = tempArray.sort(this._currentSortElem.sortFunc,!this._currentSortElem.ascending ? Array.DESCENDING : 0);
               for(index = 0; index < tempArray.length; index++)
               {
                  this._dataMatrix.insertAt(startIndex + index,tempArray[index]);
               }
               this.gd_friends.dataProvider = this._dataMatrix;
            }
         }
      }
      
      private function sortByAccountName(firstItem:Friend, secondItem:Friend, forceAscending:Boolean = false) : int
      {
         var firstValue:String = firstItem.user.name.toLowerCase();
         var secondValue:String = secondItem.user.name.toLowerCase();
         if(firstValue > secondValue)
         {
            return forceAscending && !this._currentSortElem.ascending ? -1 : 1;
         }
         if(firstValue < secondValue)
         {
            return forceAscending && !this._currentSortElem.ascending ? 1 : -1;
         }
         return 0;
      }
      
      private function sortByGameForActivities(firstItem:Friend, secondItem:Friend) : int
      {
         var firstActivity:EndpointProperties = this.getFriendActivities(firstItem);
         var secondActivity:EndpointProperties = this.getFriendActivities(secondItem);
         var firstValue:int = !!firstActivity ? int(firstItem.activities[0].applicationId) : int(GREAT_VALUE);
         var secondValue:int = !!secondActivity ? int(secondItem.activities[0].applicationId) : int(GREAT_VALUE);
         if(firstValue > secondValue)
         {
            return !this._currentSortElem.ascending ? -1 : 1;
         }
         if(firstValue < secondValue)
         {
            return !this._currentSortElem.ascending ? 1 : -1;
         }
         return this.sortByActivity(firstItem,secondItem,firstActivity,secondActivity);
      }
      
      private function sortByGameForServer(firstItem:Friend, secondItem:Friend) : int
      {
         var firstActivity:EndpointProperties = this.getFriendActivities(firstItem);
         var secondActivity:EndpointProperties = this.getFriendActivities(secondItem);
         var firstValue:int = !!firstActivity ? int(firstItem.activities[0].applicationId) : 1000;
         var secondValue:int = !!secondActivity ? int(secondItem.activities[0].applicationId) : 1000;
         if(firstValue > secondValue)
         {
            return !this._currentSortElem.ascending ? -1 : 1;
         }
         if(firstValue < secondValue)
         {
            return !this._currentSortElem.ascending ? 1 : -1;
         }
         return this.sortByServer(firstItem,secondItem,firstActivity,secondActivity);
      }
      
      private function getFriendActivities(friend:Friend) : EndpointProperties
      {
         return friend.presence == UserPresence.ONLINE && friend.activities && friend.activities.length > 0 ? friend.activities[0] : null;
      }
      
      private function sortByActivity(firstItem:Friend, secondItem:Friend, firstActivity:EndpointProperties, secondActivity:EndpointProperties) : int
      {
         var firstValue:String = firstActivity != null && firstActivity.activities != null ? (firstActivity.activities.length > 0 ? firstActivity.activities[0].toLocaleLowerCase() : " ") : null;
         var secondValue:String = secondActivity != null && secondActivity.activities != null ? (secondActivity.activities.length > 0 ? secondActivity.activities[0].toLocaleLowerCase() : " ") : null;
         if(firstValue && !secondValue || firstValue > secondValue)
         {
            return 1;
         }
         if(!firstValue && secondValue || firstValue < secondValue)
         {
            return -1;
         }
         return this.sortByAccountName(firstItem,secondItem,true);
      }
      
      private function sortByServer(firstItem:Friend, secondItem:Friend, firstActivity:EndpointProperties, secondActivity:EndpointProperties) : int
      {
         var firstValue:String = !!firstActivity ? firstActivity.metadata[SERVER_NAME] : "";
         var secondValue:String = !!secondActivity ? secondActivity.metadata[SERVER_NAME] : "";
         if(firstValue && !secondValue || firstValue > secondValue)
         {
            return 1;
         }
         if(!firstValue && secondValue || firstValue < secondValue)
         {
            return -1;
         }
         return this.sortByAccountName(firstItem,secondItem,true);
      }
      
      private function sortByName(firstItem:SocialCharacterWrapper, secondItem:SocialCharacterWrapper, forceAscending:Boolean = false) : int
      {
         var firstValue:String = firstItem.name.toLowerCase();
         var secondValue:String = secondItem.name.toLowerCase();
         if(firstValue > secondValue)
         {
            return forceAscending && !this._currentSortElem.ascending ? -1 : 1;
         }
         if(firstValue < secondValue)
         {
            return forceAscending && !this._currentSortElem.ascending ? 1 : -1;
         }
         return 0;
      }
      
      private function sortCompare(firstValue:*, secondValue:*, firstItem:SocialCharacterWrapper, secondItem:SocialCharacterWrapper) : int
      {
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         return this.sortByName(firstItem,secondItem,true);
      }
      
      private function sortByGuildName(firstItem:SocialCharacterWrapper, secondItem:SocialCharacterWrapper) : int
      {
         var firstValue:String = firstItem.guildName.toLowerCase();
         var secondValue:String = secondItem.guildName.toLowerCase();
         return this.sortCompare(firstValue,secondValue,firstItem,secondItem);
      }
      
      private function sortByLevel(firstItem:SocialCharacterWrapper, secondItem:SocialCharacterWrapper) : int
      {
         var firstValue:int = firstItem.level;
         var secondValue:int = secondItem.level;
         return this.sortCompare(firstValue,secondValue,firstItem,secondItem);
      }
      
      private function sortByBreed(firstItem:SocialCharacterWrapper, secondItem:SocialCharacterWrapper) : int
      {
         var firstValue:uint = firstItem.breed;
         var secondValue:uint = secondItem.breed;
         return this.sortCompare(firstValue,secondValue,firstItem,secondItem);
      }
      
      private function sortByAchievement(firstItem:SocialCharacterWrapper, secondItem:SocialCharacterWrapper) : int
      {
         var firstValue:int = firstItem.achievementPoints;
         var secondValue:int = secondItem.achievementPoints;
         return this.sortCompare(firstValue,secondValue,firstItem,secondItem);
      }
      
      private function sortByLeague(firstItem:FriendWrapper, secondItem:FriendWrapper) : int
      {
         var firstValue:int = firstItem.leagueId;
         var secondValue:int = secondItem.leagueId;
         return this.sortCompare(firstValue,secondValue,firstItem as SocialCharacterWrapper,secondItem as SocialCharacterWrapper);
      }
      
      private function sortByState(firstItem:SocialCharacterWrapper, secondItem:SocialCharacterWrapper) : int
      {
         var firstValue:int = firstItem.state;
         var secondValue:int = secondItem.state;
         return this.sortCompare(firstValue,secondValue,firstItem,secondItem);
      }
      
      private function isAnkamaFriend(accountId:uint) : Boolean
      {
         var fw:Friend = null;
         if(this._launcherList == null)
         {
            return false;
         }
         var n:int = this._launcherList.length;
         for(var i:int = 0; i < n; i++)
         {
            fw = this._launcherList[i] as Friend;
            if(fw.user.userId == accountId.toString())
            {
               return true;
            }
         }
         return false;
      }
      
      private function isInvited(accountId:uint) : Boolean
      {
         var fw:FriendInvite = null;
         if(this._pendingList == null)
         {
            return false;
         }
         var n:int = this._pendingList.length;
         for(var i:int = 0; i < n; i++)
         {
            fw = this._pendingList[i] as FriendInvite;
            if(fw.inviter.userId == accountId.toString() || fw.recipient.userId == accountId.toString())
            {
               return true;
            }
         }
         return false;
      }
      
      private function isMutualContact(accountId:uint) : Boolean
      {
         var fw:FriendWrapper = null;
         if(this._friendsList == null)
         {
            return false;
         }
         var n:int = this._friendsList.length;
         for(var i:int = 0; i < n; i++)
         {
            fw = this._friendsList[i] as FriendWrapper;
            if(fw.accountId == accountId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isContact(accountId:uint) : Boolean
      {
         var cw:ContactWrapper = null;
         if(this._contactsList == null)
         {
            return false;
         }
         var n:int = this._contactsList.length;
         for(var i:int = 0; i < n; i++)
         {
            cw = this._contactsList[i] as ContactWrapper;
            if(cw.accountId == accountId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function mergeFriendsAndContacts() : void
      {
         var contact:SocialCharacterWrapper = null;
         this._contactsList = this.socialApi.getContactsList() as Vector.<SocialCharacterWrapper>;
         this._friendsList = this.socialApi.getFriendsList() as Vector.<SocialCharacterWrapper>;
         this._mergedList = new Vector.<SocialCharacterWrapper>();
         var filterContactsByNameFunction:Function = function filterContactsByNameFunction(person:SocialCharacterWrapper, index:int, vector:Vector.<SocialCharacterWrapper>):Boolean
         {
            return person.name == this;
         };
         for each(contact in this._contactsList)
         {
            if(this._friendsList.filter(filterContactsByNameFunction,contact.name).length == 0)
            {
               this._mergedList.push(contact);
            }
         }
      }
      
      private function onFriendLauncherListUpdated(friendList:FriendList) : void
      {
         this._launcherList = friendList.values;
         this.refreshGrid(this._nCurrentTab);
      }
      
      private function onFriendLauncherCreated(friend:Friend) : void
      {
         this.mergeFriendsAndContacts();
         this.refreshGrid(this._nCurrentTab);
      }
      
      private function onFriendLauncherDeleted(friendId:String) : void
      {
         this.mergeFriendsAndContacts();
         this.refreshGrid(this._nCurrentTab);
      }
      
      private function onUserUpdateStatus(userId:String, status:String) : void
      {
         this.refreshGrid(this._nCurrentTab);
      }
      
      private function onUserUpdateActivities(userId:String, activities:Vector.<EndpointProperties>) : void
      {
         this.refreshGrid(this._nCurrentTab);
      }
      
      private function onUserUpdatedPresence(accountId:String, presence:String) : void
      {
         this.refreshGrid(this._nCurrentTab);
      }
      
      private function onPendingInvitationsUpdated(friendInviteList:FriendInviteList) : void
      {
         this._pendingList = friendInviteList.values;
         this.gd_pendingInvitations.dataProvider = this._pendingList;
         this.refreshGrid();
      }
      
      private function onFriendInviteLauncherCreated(friendInvite:FriendInvite) : void
      {
         this.gd_pendingInvitations.dataProvider = this._pendingList;
         this.refreshGrid();
      }
      
      private function onFriendInviteLauncherDeleted(friendInvite:FriendInvite, reason:String) : void
      {
         this.gd_pendingInvitations.dataProvider = this._pendingList;
         this.refreshGrid();
      }
      
      private function onFriendsOrContactUpdated() : void
      {
         this.mergeFriendsAndContacts();
         if(this._nCurrentTab != 2)
         {
            this.refreshGrid(this._nCurrentTab);
         }
      }
      
      private function onEnemiesUpdated() : void
      {
         this._enemiesList = this.socialApi.getEnemiesList() as Vector.<SocialCharacterWrapper>;
         if(this._nCurrentTab == 2)
         {
            this.refreshGrid(this._nCurrentTab);
         }
      }
      
      private function onIgnoredUpdated() : void
      {
         this._ignoredList = this.socialApi.getIgnoredList() as Vector.<SocialCharacterWrapper>;
         if(this._nCurrentTab == 2)
         {
            this.refreshGrid(this._nCurrentTab);
         }
      }
      
      private function onStatusShareState(enable:Boolean) : void
      {
         if(this.btn_shareStatus.selected == enable)
         {
            this.btn_shareStatus.selected = !enable;
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         if(s === "validUi")
         {
         }
         return false;
      }
      
      public function selectWhichTabHintsToDisplay() : void
      {
         this.hintsApi.showSubHints(this.currentTabName);
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(this._chatService !== null)
         {
            loop0:
            switch(target)
            {
               case this.cbx_activity:
                  this.sysApi.dispatchHook(ChatServiceHookList.ChatServiceUserUpdateHisActivity,this.cbx_activity.selectedIndex);
                  switch(this.cbx_activity.selectedIndex)
                  {
                     case 0:
                        this._chatService.updatePlayerDofusActivity();
                        break loop0;
                     case 1:
                        this._chatService.updatePlayerDofusActivity(GROUP_KOLI);
                        break loop0;
                     case 2:
                        this._chatService.updatePlayerDofusActivity(GROUP_DUNGEON);
                        break loop0;
                     case 3:
                        this._chatService.updatePlayerDofusActivity(GROUP_PVM);
                  }
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         switch(target)
         {
            case this.btn_friend:
               if(this._nCurrentTab != 0)
               {
                  this._nCurrentTab = 0;
                  this.displaySelectedTab(this._nCurrentTab);
                  this.currentTabName = target.name;
                  this.hintsApi.uiTutoTabLaunch();
               }
               break;
            case this.btn_contact:
               if(this._nCurrentTab != 1)
               {
                  this._nCurrentTab = 1;
                  this.displaySelectedTab(this._nCurrentTab);
                  this.currentTabName = target.name;
                  this.hintsApi.uiTutoTabLaunch();
               }
               break;
            case this.btn_blocked:
               if(this._nCurrentTab != 2)
               {
                  this._nCurrentTab = 2;
                  this.displaySelectedTab(this._nCurrentTab);
                  this.currentTabName = target.name;
                  this.hintsApi.uiTutoTabLaunch();
               }
               break;
            case this.btn_hideOfflineFriends:
               this._bHideOfflineGuys = this.btn_hideOfflineFriends.selected;
               this.sysApi.setData("hideOfflineFriends",this._bHideOfflineGuys);
               this.refreshGrid(this._nCurrentTab);
               break;
            case this.btn_hideOfflineContacts:
               this._bHideOfflineGuys = this.btn_hideOfflineContacts.selected;
               this.sysApi.setData("hideOfflineContacts",this._bHideOfflineGuys);
               this.refreshGrid(this._nCurrentTab);
               break;
            case this.btn_showOnlyDofusGuys:
               this._bShowOnlyDofusGuys = this.btn_showOnlyDofusGuys.selected;
               this.sysApi.setData("showOnlyDofusGuys",this._bShowOnlyDofusGuys);
               this.refreshGrid(this._nCurrentTab);
               break;
            case this.btn_shareStatus:
               this.sysApi.sendAction(new StatusShareSetAction([!this.btn_shareStatus.selected]));
               break;
            case this.btn_openWait:
               if(this._nCurrentTab == 0 && this._closedCategories.indexOf(0) != -1)
               {
                  this._closedCategories.splice(this._closedCategories.indexOf(0),1);
                  this.btn_openWait.y = POSY_REDUCED_BTN_OPENWAIT;
                  this.gd_friends.height = HEIGHT_REDUCED_FRIENDS_GRID;
                  this.gd_pendingInvitations.visible = true;
                  this.tx_pendingListPlusMinus.uri = this.uiApi.createUri(this._texturesPath + "icon_minus_grey.png");
               }
               else
               {
                  this._closedCategories.push(0);
                  this.btn_openWait.y = POSY_EXPANDED_BTN_OPENWAIT;
                  this.gd_friends.height = HEIGHT_EXPANDED_FRIENDS_GRID;
                  this.gd_pendingInvitations.visible = false;
                  this.tx_pendingListPlusMinus.uri = this.uiApi.createUri(this._texturesPath + "icon_plus_grey.png");
               }
               break;
            default:
               data = this._componentData[target.name];
               if(!data)
               {
                  return;
               }
               if(target.name.indexOf("btn_unlock") != -1)
               {
                  if(data is Friend && this._friendIdWaitingForKick == null)
                  {
                     this._friendIdWaitingForKick = data.user.userId;
                     this.showConfirmPopup(data,"ui.social.doUDeleteFriend",this.onConfirmDeleteFriend,this.onCancelDeleteFriend);
                  }
                  else if((!(data is Friend) && data.e_category == SocialCharacterCategoryEnum.CATEGORY_FRIEND || data.e_category == SocialCharacterCategoryEnum.CATEGORY_CONTACT) && this._contactIdWaitingForKick == -1)
                  {
                     this._contactIdWaitingForKick = data.accountId;
                     this.showConfirmPopup(data,"ui.social.doUDeleteFriend",this.onConfirmDeleteContact,this.onCancelDeleteContact);
                  }
                  else if(data.e_category == SocialCharacterCategoryEnum.CATEGORY_ENEMY && this._enemyIdWaitingForKick == -1)
                  {
                     this._enemyIdWaitingForKick = data.accountId;
                     this.showConfirmPopup(data,"ui.social.doUDeleteEnemy",this.onConfirmDeleteEnemy,this.onCancelDeleteEnemy);
                  }
                  else if(data.e_category == SocialCharacterCategoryEnum.CATEGORY_IGNORED)
                  {
                     this.sysApi.sendAction(new RemoveIgnoredAction([data.accountId]));
                  }
               }
               else if(target.name.indexOf("btn_addToList") != -1)
               {
                  this.showAddFriendUI(data.e_category);
               }
               else if(target.name.indexOf("tx_state") != -1 || target.name.indexOf("tx_mood") != -1 || target.name.indexOf("tx_fight") != -1)
               {
                  if(data.state == PlayerStateEnum.GAME_TYPE_FIGHT)
                  {
                     this.sysApi.sendAction(new GameFightSpectatePlayerRequestAction([data.playerId]));
                  }
               }
               else if(target.name.indexOf("tx_havenbag") != -1)
               {
                  this.sysApi.sendAction(new HavenbagEnterAction([data.playerId]));
               }
               else if(target.name.indexOf(CTR_CAT) != -1 && this._nCurrentTab != 0)
               {
                  this.displayCategories(data.e_category,data.count);
               }
               else if(target.name.indexOf("btn_sort_friend_account") != -1)
               {
                  this.sortGridWithCat(this.sortByAccountName,"account");
               }
               else if(target.name.indexOf("btn_sort_friend_activity") != -1)
               {
                  this.sortGridWithCat(this.sortByGameForActivities,"activity");
               }
               else if(target.name.indexOf("btn_sort_friend_server") != -1)
               {
                  this.sortGridWithCat(this.sortByGameForServer,"server");
               }
               else if(target.name.indexOf("btn_tabGuild") != -1)
               {
                  this.sortGridWithCat(this.sortByGuildName,"guild");
               }
               else if(target.name.indexOf("btn_tabName") != -1)
               {
                  this.sortGridWithCat(this.sortByName,"name");
               }
               else if(target.name.indexOf("btn_tabLevel") != -1)
               {
                  this.sortGridWithCat(this.sortByLevel,"level");
               }
               else if(target.name.indexOf("btn_tabBreed") != -1)
               {
                  this.sortGridWithCat(this.sortByBreed,"breed");
               }
               else if(target.name.indexOf("btn_tabAchievement") != -1)
               {
                  this.sortGridWithCat(this.sortByAchievement,"achievement");
               }
               else if(target.name.indexOf("btn_tabLeague") != -1)
               {
                  this.sortGridWithCat(this.sortByLeague,"league");
               }
               else if(target.name.indexOf("btn_tabState") != -1)
               {
                  this.sortGridWithCat(this.sortByState,"state");
               }
               else if(target.name.indexOf("btn_acceptInvitation") != -1)
               {
                  this.acceptInvitation(data);
               }
               else if(target.name.indexOf("btn_refuseInvitation") != -1)
               {
                  this.refuseInvitation(data);
               }
               else if(target.name.indexOf("btn_cancelInvitation") != -1)
               {
                  this.cancelInvitation(data);
               }
               else if(target.name.indexOf("btn_addAnkamaFriend") != -1)
               {
                  this.showAddFriendUI(SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA,PlayerManager.getInstance().formatTagName(data.name,data.tag,null,false));
               }
               else if(target.name.indexOf("btn_addContact") != -1)
               {
                  this.sysApi.sendAction(new AddFriendAction([data.user.name,data.user.tag]));
               }
               break;
         }
      }
      
      private function showAddFriendUI(category:Object, name:String = "") : void
      {
         if(!this.uiApi.getUi("addFriendWindow"))
         {
            this.uiApi.loadUi("addFriendWindow","addFriendWindow",[category,name]);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var data:Object = null;
         var league:ArenaLeague = null;
         var months:int = 0;
         var days:int = 0;
         var argText:String = null;
         var sdata:Object = null;
         var point:uint = LocationEnum.POINT_BOTTOM;
         var relPoint:uint = LocationEnum.POINT_TOP;
         if(target.name.indexOf("tx_state") != -1 || target.name.indexOf("tx_mood") != -1 || target.name.indexOf("tx_fight") != -1)
         {
            data = this._componentData[target.name];
            if(data.state == PlayerStateEnum.GAME_TYPE_FIGHT)
            {
               text = this.uiApi.getText("ui.spectator.clicToJoin");
            }
         }
         else if(target.name.indexOf("tx_breed") != -1)
         {
            data = this._componentData[target.name];
            text = this.dataApi.getBreed(data.breed).shortName;
         }
         else if(target.name.indexOf("tx_havenbag") != -1)
         {
            text = this.uiApi.getText("ui.havenbag.visit");
         }
         else if(target.name.indexOf("tx_league") != -1)
         {
            league = this.dataApi.getArenaLeagueById(this._componentData[target.name].leagueId);
            if(league)
            {
               text = league.name;
               if(league.isLastLeague && this._componentData[target.name].ladderPosition > 0)
               {
                  text += " " + this._componentData[target.name].ladderPosition;
               }
            }
            else
            {
               text = this.uiApi.getText("ui.party.arena.noLeague");
            }
         }
         else if(target.name.indexOf("lbl_name") != -1)
         {
            data = this._componentData[target.name];
            if(data && !data.online)
            {
               if(data.lastConnection > 0)
               {
                  months = Math.floor(data.lastConnection / 720);
                  days = (data.lastConnection - months * 720) / 24;
                  if(months > 0)
                  {
                     if(days > 0)
                     {
                        argText = this.uiApi.processText(this.uiApi.getText("ui.social.monthsAndDaysSinceLastConnection",months,days),"m",days <= 1);
                     }
                     else
                     {
                        argText = this.uiApi.processText(this.uiApi.getText("ui.social.monthsSinceLastConnection",months),"m",months <= 1);
                     }
                  }
                  else if(days > 0)
                  {
                     argText = this.uiApi.processText(this.uiApi.getText("ui.social.daysSinceLastConnection",days),"m",days <= 1);
                  }
                  else
                  {
                     argText = this.uiApi.getText("ui.social.lessThanADay");
                  }
                  text = this.uiApi.getText("ui.social.lastConnection",argText);
               }
               else
               {
                  text = this.uiApi.getText("ui.social.unknownLastConnection");
               }
               relPoint = 0;
            }
         }
         else if(target.name.indexOf("tx_game") != -1)
         {
            text = this._componentData[target.name];
         }
         else if(target.name.indexOf("tx_status") != -1)
         {
            sdata = this._componentData[target.name];
            if(sdata && sdata.online)
            {
               switch(sdata.statusId)
               {
                  case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                     text = this.uiApi.getText("ui.chat.status.availiable");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_AFK:
                     text = this.uiApi.getText("ui.chat.status.away");
                     if(sdata.awayMessage != "")
                     {
                        text += this.uiApi.getText("ui.common.colon") + sdata.awayMessage;
                     }
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                     text = this.uiApi.getText("ui.chat.status.idle");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                     text = this.uiApi.getText("ui.chat.status.private");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                     text = this.uiApi.getText("ui.chat.status.solo");
                     break;
                  default:
                     text = "";
               }
            }
            else
            {
               text = "";
            }
         }
         else if(target.name.indexOf("tx_level") != -1 || target.name.indexOf("lbl_level") != -1)
         {
            text = this.uiApi.getText("ui.tooltip.OmegaLevel");
         }
         else if(target.name.indexOf("btn_addAnkamaFriend") != -1)
         {
            text = this.uiApi.getText("ui.social.addToFriends");
            if(this._chatService === null || !this._chatService.authenticated)
            {
               text += "\n\n<font color=\"#FF0000\">" + this.uiApi.getText("ui.secureMode.error.checkCode.503") + "</font>";
            }
         }
         else if(target.name.indexOf("btn_addContact") != -1)
         {
            text = this.uiApi.getText("ui.social.addToContacts");
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",point,relPoint,0,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onConfirmDeleteFriend() : void
      {
         if(this._chatService !== null)
         {
            this._chatService.deleteUserFriend(this._friendIdWaitingForKick);
         }
         this._friendIdWaitingForKick = null;
      }
      
      private function onConfirmDeleteContact() : void
      {
         this.sysApi.sendAction(new RemoveFriendAction([this._contactIdWaitingForKick]));
         this._contactIdWaitingForKick = -1;
      }
      
      private function onCancelDeleteFriend() : void
      {
         this._friendIdWaitingForKick = null;
      }
      
      private function onCancelDeleteContact() : void
      {
         this._contactIdWaitingForKick = -1;
      }
      
      private function onConfirmDeleteEnemy() : void
      {
         this.sysApi.sendAction(new RemoveEnemyAction([this._enemyIdWaitingForKick]));
         this._enemyIdWaitingForKick = -1;
      }
      
      private function onCancelDeleteEnemy() : void
      {
         this._enemyIdWaitingForKick = -1;
      }
   }
}

final class Friends_Category_Item
{
    
   
   public var name:String = "";
   
   public var e_category:uint = 0;
   
   public var count:uint = 0;
   
   function Friends_Category_Item(name:String, e_category:uint, count:uint)
   {
      super();
      this.name = name;
      this.e_category = e_category;
      this.count = count;
   }
}

final class Friends_Sort_Item
{
    
   
   public var e_category:uint = 0;
   
   function Friends_Sort_Item(e_category:uint)
   {
      super();
      this.e_category = e_category;
   }
}

final class SortType
{
    
   
   public var sortFunc:Function;
   
   public var ascending:Boolean;
   
   public var targetName:String;
   
   function SortType(_sortFunc:Function, _ascending:Boolean = true, _targetName:String = "name")
   {
      super();
      this.sortFunc = _sortFunc;
      this.ascending = _ascending;
      this.targetName = _targetName;
   }
}
