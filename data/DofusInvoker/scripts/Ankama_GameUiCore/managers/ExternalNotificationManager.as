package Ankama_GameUiCore.managers
{
   import Ankama_GameUiCore.Api;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.datacenter.externalnotifications.ExternalNotification;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationModeEnum;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ChatServiceHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.ExchangeReplayStopReasonEnum;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.network.enums.FightTypeEnum;
   import com.ankamagames.dofus.network.enums.PvpArenaStepEnum;
   import com.ankamagames.dofus.network.enums.SocialContactCategoryEnum;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.ExternalNotificationApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class ExternalNotificationManager extends Sprite
   {
      
      private static var _instance:ExternalNotificationManager;
      
      private static const DEBUG:Boolean = false;
      
      private static var ENABLE_AVATARS:Boolean = true;
      
      private static var notifCount:int = 0;
      
      private static const ITEM_INDEX_CODE:String = String.fromCharCode(65532);
       
      
      private var sysApi:SystemApi;
      
      private var uiApi:UiApi;
      
      private var socialApi:SocialApi;
      
      private var extNotifApi:ExternalNotificationApi;
      
      private var fightApi:FightApi;
      
      private var playerApi:PlayedCharacterApi;
      
      private var dataApi:DataApi;
      
      private var chatApi:ChatApi;
      
      private var utilApi:UtilApi;
      
      private var iconsIds:Dictionary;
      
      private var iconsBgColorsIds:Dictionary;
      
      private var messages:Dictionary;
      
      private var _arenaRegistered:Boolean;
      
      public function ExternalNotificationManager()
      {
         super();
      }
      
      private static function log(pMsg:*) : void
      {
         if(DEBUG)
         {
            Api.system.log(2,pMsg);
         }
      }
      
      public static function getInstance() : ExternalNotificationManager
      {
         if(!_instance)
         {
            _instance = new ExternalNotificationManager();
         }
         return _instance;
      }
      
      public function init() : void
      {
         this.iconsIds = new Dictionary();
         this.iconsBgColorsIds = new Dictionary();
         this.messages = new Dictionary();
         this.sysApi = Api.system as SystemApi;
         this.uiApi = Api.ui as UiApi;
         this.socialApi = Api.social as SocialApi;
         this.extNotifApi = Api.extNotif as ExternalNotificationApi;
         this.fightApi = Api.fight as FightApi;
         this.playerApi = Api.player as PlayedCharacterApi;
         this.dataApi = Api.data as DataApi;
         this.chatApi = Api.chat as ChatApi;
         this.utilApi = Api.util as UtilApi;
         ENABLE_AVATARS = this.sysApi.getOs().toLowerCase() != "linux";
         this.initData();
         this.initHooks();
      }
      
      public function initHooks() : void
      {
         this.sysApi.removeHook(HookList.ExternalNotification);
         this.sysApi.removeHook(HookList.InactivityNotification);
         this.sysApi.removeHook(CraftHookList.ExchangeMultiCraftRequest);
         this.sysApi.removeHook(CraftHookList.ExchangeItemAutoCraftStoped);
         this.sysApi.removeHook(RoleplayHookList.ArenaRegistrationStatusUpdate);
         this.sysApi.removeHook(HookList.GameFightStarting);
         this.sysApi.removeHook(HookList.GameFightStart);
         this.sysApi.removeHook(HookList.GameFightEnd);
         this.sysApi.removeHook(HookList.FightText);
         this.sysApi.removeHook(HookList.GameFightTurnStartPlaying);
         this.sysApi.removeHook(RoleplayHookList.PlayerFightFriendlyRequested);
         this.sysApi.removeHook(ExchangeHookList.ExchangeRequestCharacterToMe);
         this.sysApi.removeHook(ChatHookList.ChatServer);
         this.sysApi.removeHook(ChatHookList.ChatServerWithObject);
         this.sysApi.removeHook(ChatHookList.TextInformation);
         this.sysApi.removeHook(SocialHookList.GuildInvited);
         this.sysApi.removeHook(QuestHookList.AchievementFinished);
         this.sysApi.removeHook(QuestHookList.QuestValidated);
         this.sysApi.addHook(HookList.ExternalNotification,this.onExternalNotification);
         this.sysApi.addHook(HookList.InactivityNotification,this.onInactivityNotification);
         this.sysApi.addHook(CraftHookList.ExchangeMultiCraftRequest,this.onMultiCraftRequest);
         this.sysApi.addHook(CraftHookList.ExchangeItemAutoCraftStoped,this.onCraftStopped);
         this.sysApi.addHook(RoleplayHookList.ArenaRegistrationStatusUpdate,this.onArenaRegistrationUpdate);
         this.sysApi.addHook(HookList.ArenaExternalNotification,this.onArenaExternalNotif);
         this.sysApi.addHook(HookList.GameFightStarting,this.onGameFightStarting);
         this.sysApi.addHook(HookList.GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(HookList.FightText,this.onFightText);
         this.sysApi.addHook(HookList.GameFightTurnStartPlaying,this.onFightTurnStartPlaying);
         this.sysApi.addHook(RoleplayHookList.PlayerFightFriendlyRequested,this.onPlayerFight);
         this.sysApi.addHook(ExchangeHookList.ExchangeRequestCharacterToMe,this.onExchange);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceChannelMessage,this.onUserMessage);
         this.sysApi.addHook(ChatHookList.ChatServer,this.onChatServer);
         this.sysApi.addHook(ChatHookList.ChatServerWithObject,this.onChatServerWithObject);
         this.sysApi.addHook(ChatHookList.TextInformation,this.onTextInformation);
         this.sysApi.addHook(SocialHookList.GuildInvited,this.onGuildInvitation);
         this.sysApi.addHook(QuestHookList.AchievementFinished,this.onAchievementFinished);
         this.sysApi.addHook(QuestHookList.QuestValidated,this.onQuestValidated);
         if(this.sysApi.getBuildType() != BuildTypeEnum.RELEASE && this.sysApi.getConfigEntry("config.dev.externalNotiflood"))
         {
            this.onInactivityNotification(true);
            this.onMultiCraftRequest(1,"Jenexistepas",15);
            this.onCraftStopped(2);
            this.onArenaRegistrationUpdate(true,1);
            this.onGameFightStarting(0);
            this.onGameFightStart();
            this.onFightTurnStartPlaying();
            this.onPlayerFight("Jenexistepas");
            this.onChatServer(0,15,0,"","Jenexistepas","test de notif ?");
            this.onTextInformation("test de notif ?",ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO);
            this.onGuildInvitation(42,"Fausse Guilde",0,"Jenexistepas");
            this.onQuestValidated(469);
         }
      }
      
      private function initData() : void
      {
         var extNotif:ExternalNotification = null;
         var extNotifType:int = 0;
         var extNotifs:Array = this.dataApi.getExternalNotifications();
         var colorsIds:Vector.<String> = new <String>["green","blue","yellow","red"];
         for each(extNotif in extNotifs)
         {
            extNotifType = ExternalNotificationTypeEnum[extNotif.name];
            this.messages[extNotifType] = this.uiApi.getTextFromKey(extNotif.messageId);
            this.iconsIds[extNotifType] = extNotif.iconId;
            this.iconsBgColorsIds[extNotifType] = colorsIds[extNotif.colorId - 1];
         }
      }
      
      private function getIconId(pNotifType:int) : int
      {
         return this.iconsIds[pNotifType];
      }
      
      private function getIconBgColorId(pNotifType:int) : String
      {
         return this.iconsBgColorsIds[pNotifType];
      }
      
      private function getChatMessage(pChannel:uint, pContent:String) : Object
      {
         var chatMessage:Object = {};
         chatMessage.text = pContent;
         if(chatMessage.text.indexOf("{") != -1 && chatMessage.text.indexOf("}") != -1)
         {
            chatMessage.text = this.chatApi.getStaticHyperlink(chatMessage.text);
         }
         chatMessage.css = "chat";
         switch(pChannel)
         {
            case ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_INFO;
               chatMessage.cssClass = "p10";
               break;
            case ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE:
               chatMessage.notifType = ExternalNotificationTypeEnum.PRIVATE_MSG;
               chatMessage.cssClass = "p9";
               break;
            case ChatActivableChannelsEnum.CHANNEL_GUILD:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_GUILD;
               chatMessage.cssClass = "p2";
               break;
            case ChatActivableChannelsEnum.CHANNEL_PARTY:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_GROUP;
               chatMessage.cssClass = "p4";
               break;
            case ChatActivableChannelsEnum.CHANNEL_TEAM:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_TEAM;
               chatMessage.cssClass = "p1";
               break;
            case ChatActivableChannelsEnum.CHANNEL_GLOBAL:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_GENERAL;
               chatMessage.cssClass = "p0";
               break;
            case ChatActivableChannelsEnum.CHANNEL_ADMIN:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_ADMIN;
               chatMessage.cssClass = "p8";
               break;
            case ChatActivableChannelsEnum.CHANNEL_ALLIANCE:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_ALIGNMENT;
               chatMessage.cssClass = "p3";
               break;
            case ChatActivableChannelsEnum.CHANNEL_SALES:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_TRADE;
               chatMessage.cssClass = "p5";
               break;
            case ChatActivableChannelsEnum.CHANNEL_ADS:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_PROMO;
               chatMessage.cssClass = "p12";
               break;
            case ChatActivableChannelsEnum.CHANNEL_ARENA:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_KOLO;
               chatMessage.cssClass = "p13";
               break;
            case ChatActivableChannelsEnum.CHANNEL_SEEK:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_RECRUIT;
               chatMessage.cssClass = "p6";
         }
         return chatMessage;
      }
      
      private function addExternalNotification(pExtNotifType:int, pMessage:String, pCss:String = "normal2", pCssClass:String = "left", pEntityContactData:Object = null, isAccountNotif:Boolean = false, duration:int = 0) : void
      {
         ++notifCount;
         this.extNotifApi.addExternalNotification(pExtNotifType,"extNotif" + notifCount,"externalnotification",!isAccountNotif ? this.playerApi.getPlayedCharacterInfo().name.toUpperCase() : this.sysApi.getNickname(),pMessage,"notifications",!pEntityContactData ? int(this.getIconId(pExtNotifType)) : -1,!pEntityContactData ? this.getIconBgColorId(pExtNotifType) : null,pCss,pCssClass,pEntityContactData,duration);
      }
      
      private function addExternalNotificationFromChatMessage(pChannel:uint, pSenderId:Number, prefix:String, pSenderName:String, pContent:String) : void
      {
         var sender:String = null;
         var contactData:Object = null;
         var chatmessage:Object = this.getChatMessage(pChannel,this.chatApi.unEscapeChatString(pContent));
         if(chatmessage.notifType > 0 && this.extNotifApi.canAddExternalNotification(chatmessage.notifType))
         {
            sender = !!pSenderName ? (prefix && prefix != "" ? prefix + " " : "") + pSenderName + this.uiApi.getText("ui.common.colon") : "";
            if(ENABLE_AVATARS)
            {
               switch(pChannel)
               {
                  case ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE:
                     contactData = {
                        "id":pSenderId,
                        "contactCategory":SocialContactCategoryEnum.SOCIAL_CONTACT_INTERLOCUTOR
                     };
                     break;
                  case ChatActivableChannelsEnum.CHANNEL_GUILD:
                     contactData = {
                        "id":pSenderId,
                        "contactCategory":SocialContactCategoryEnum.SOCIAL_CONTACT_GUILD
                     };
               }
            }
            this.addExternalNotification(chatmessage.notifType,sender + chatmessage.text,chatmessage.css,chatmessage.cssClass,contactData);
         }
      }
      
      private function onQuestValidated(pQuestId:uint) : void
      {
         var quest:Quest = null;
         var msg:String = null;
         if(this.extNotifApi.getShowMode() != ExternalNotificationModeEnum.DISABLED && !this.extNotifApi.isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.QUEST_VALIDATED))
         {
            ++notifCount;
            quest = this.dataApi.getQuest(pQuestId);
            msg = "<b>" + this.uiApi.getText("ui.almanax.questDone") + "</b><br/>" + quest.name;
            this.extNotifApi.addExternalNotification(ExternalNotificationTypeEnum.QUEST_VALIDATED,"extNotif" + notifCount,"questNotification",null,msg,null,-1,null,"normal","left",null,0,UISoundEnum.ACHIEVEMENT_UNLOCKED,true);
         }
      }
      
      private function onAchievementFinished(pAchievement:AchievementAchieved) : void
      {
         var achievement:Achievement = null;
         if(this.extNotifApi.getShowMode() != ExternalNotificationModeEnum.DISABLED && !this.extNotifApi.isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.ACHIEVEMENT_UNLOCKED))
         {
            ++notifCount;
            achievement = this.dataApi.getAchievement(pAchievement.id);
            if(!achievement)
            {
               this.sysApi.log(16,"Error : Achievemnt " + pAchievement.id + " doesn\'t exist.");
               return;
            }
            this.extNotifApi.addExternalNotification(ExternalNotificationTypeEnum.ACHIEVEMENT_UNLOCKED,"extNotif" + notifCount,"achievementNotification",null,"<b>" + this.uiApi.getText("ui.achievement.achievementUnlock") + "</b><br/>" + achievement.name,"achievements",achievement.iconId,null,"normal","darkleft",null,0,UISoundEnum.ACHIEVEMENT_UNLOCKED,true,"OpenBook",["achievementTab",{
               "forceOpen":true,
               "achievementId":pAchievement.id
            }]);
         }
      }
      
      private function onExternalNotification(... pArgs) : void
      {
         var contactData:Object = null;
         var type:int = pArgs[0];
         var params:* = pArgs[1];
         if(ENABLE_AVATARS)
         {
            switch(type)
            {
               case ExternalNotificationTypeEnum.FRIEND_CONNECTION:
                  contactData = {
                     "id":params[params.length - 1],
                     "contactCategory":SocialContactCategoryEnum.SOCIAL_CONTACT_FRIEND
                  };
                  break;
               case ExternalNotificationTypeEnum.MEMBER_CONNECTION:
                  contactData = {
                     "id":params[params.length - 1],
                     "contactCategory":SocialContactCategoryEnum.SOCIAL_CONTACT_GUILD
                  };
            }
         }
         var text:String = !params ? this.messages[type] : this.utilApi.applyTextParams(this.messages[type],params);
         if(text.indexOf("{") != -1 && text.indexOf("}") != -1)
         {
            text = this.chatApi.getStaticHyperlink(text);
         }
         this.addExternalNotification(type,text,"normal2","left",contactData);
      }
      
      private function onFightText(pEvtName:String, pParams:Object, pTargets:Object, pTargetsTeam:String = "", forceDetailedLog:Boolean = false) : void
      {
         var gender:String = null;
         var playerId:Number = pParams[0] as Number;
         var playerName:String = this.playerApi.getPlayedCharacterInfo().name;
         var dead:Boolean = pEvtName == FightEventEnum.FIGHTER_DEATH || pEvtName == FightEventEnum.FIGHTER_LIFE_LOSS_AND_DEATH;
         if(dead && playerId == this.playerApi.id() && this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_DEATH))
         {
            gender = this.playerApi.getPlayedCharacterInfo().sex == 0 ? "m" : "f";
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_DEATH,this.uiApi.processText(this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.FIGHT_DEATH],[playerName]),gender));
         }
      }
      
      private function onInactivityNotification(pIsAFK:Boolean) : void
      {
         if(pIsAFK && this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.INACTIVITY_WARNING))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.INACTIVITY_WARNING,this.messages[ExternalNotificationTypeEnum.INACTIVITY_WARNING]);
         }
      }
      
      private function onMultiCraftRequest(pRole:int, pOtherName:String, pAskerId:Number) : void
      {
         if(pRole == ExchangeTypeEnum.MULTICRAFT_CUSTOMER && this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.CRAFT_INVITATION))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.CRAFT_INVITATION,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.CRAFT_INVITATION],[pOtherName]));
         }
         else if(pAskerId != this.playerApi.id() && this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.CRAFT_REQUEST))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.CRAFT_REQUEST,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.CRAFT_REQUEST],[pOtherName]));
         }
      }
      
      private function onCraftStopped(pReason:int) : void
      {
         if(pReason == ExchangeReplayStopReasonEnum.STOPPED_REASON_OK && this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.MULTI_CRAFT_END))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.MULTI_CRAFT_END,this.messages[ExternalNotificationTypeEnum.MULTI_CRAFT_END]);
         }
      }
      
      private function onArenaRegistrationUpdate(pRegistered:Boolean, pStatus:int) : void
      {
         if(pRegistered != this._arenaRegistered)
         {
            if(pRegistered && pStatus == PvpArenaStepEnum.ARENA_STEP_REGISTRED && this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.KOLO_SEARCH))
            {
               this.addExternalNotification(ExternalNotificationTypeEnum.KOLO_SEARCH,this.messages[ExternalNotificationTypeEnum.KOLO_SEARCH]);
            }
            else if(!pRegistered && pStatus != PvpArenaStepEnum.ARENA_STEP_STARTING_FIGHT && this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.KOLO_SEARCH_END))
            {
               this.addExternalNotification(ExternalNotificationTypeEnum.KOLO_SEARCH_END,this.messages[ExternalNotificationTypeEnum.KOLO_SEARCH_END]);
            }
            this._arenaRegistered = pRegistered;
         }
      }
      
      private function onArenaExternalNotif(notifType:int, duration:int = 0) : void
      {
         var text:String = this.messages[notifType];
         if(this.extNotifApi.canAddExternalNotification(notifType))
         {
            this.addExternalNotification(notifType,text,"normal2","left",null,false,duration);
         }
      }
      
      private function onGameFightStarting(pFightType:uint) : void
      {
         if(pFightType == FightTypeEnum.FIGHT_TYPE_PvM && this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_JOIN))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_JOIN,this.messages[ExternalNotificationTypeEnum.FIGHT_JOIN]);
         }
      }
      
      private function onGameFightStart() : void
      {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_START) && PlayerManager.getInstance().kisServerPort <= 0)
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_START,this.messages[ExternalNotificationTypeEnum.FIGHT_START]);
         }
      }
      
      private function onGameFightEnd(resultsKey:String) : void
      {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_END) && PlayerManager.getInstance().kisServerPort <= 0)
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_END,this.messages[ExternalNotificationTypeEnum.FIGHT_END]);
         }
      }
      
      private function onFightTurnStartPlaying() : void
      {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_TURN_START))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_TURN_START,this.messages[ExternalNotificationTypeEnum.FIGHT_TURN_START]);
         }
      }
      
      private function onPlayerFight(pTargetName:String) : void
      {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.CHALLENGE_INVITATION))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.CHALLENGE_INVITATION,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.CHALLENGE_INVITATION],[pTargetName]));
         }
      }
      
      private function onExchange(pMyName:String, pSourceName:String) : void
      {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.EXCHANGE_INVITATION))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.EXCHANGE_INVITATION,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.EXCHANGE_INVITATION],[pSourceName]));
         }
      }
      
      private function onUserMessage(msg:*) : void
      {
         if(msg.author.userId != this.sysApi.getPlayerManager().accountId.toString())
         {
            if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.PRIVATE_MSG))
            {
               this.addExternalNotification(ExternalNotificationTypeEnum.PRIVATE_MSG,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.PRIVATE_MSG],[msg.author.name,msg.content]),"normal2","left",null,true);
            }
         }
      }
      
      private function onChatServer(pChannel:uint = 0, pSenderId:Number = 0, pOriginServerId:int = -1, prefix:String = "", pSenderName:String = "", pContent:String = "", pTimestamp:Number = 0, pFingerprint:String = "", pAdmin:Boolean = false) : void
      {
         this.addExternalNotificationFromChatMessage(pChannel,pSenderId,prefix,pSenderName,pContent);
      }
      
      private function onChatServerWithObject(pChannel:uint = 0, pSenderId:Number = 0, prefix:String = "", pSenderName:String = "", pContent:String = "", pTimestamp:Number = 0, pFingerprint:String = "", pObjects:Object = null) : void
      {
         var numItem:int = 0;
         var i:int = 0;
         var item:ItemWrapper = null;
         var index:int = 0;
         var content:String = pContent;
         if(pObjects)
         {
            numItem = pObjects.length;
            for(i = 0; i < numItem; i++)
            {
               item = pObjects[i];
               index = content.indexOf(ITEM_INDEX_CODE);
               if(index == -1)
               {
                  break;
               }
               content = content.substr(0,index) + this.chatApi.newChatItem(item) + content.substr(index + 1);
            }
         }
         this.addExternalNotificationFromChatMessage(pChannel,pSenderId,prefix,pSenderName,content);
      }
      
      private function onTextInformation(pText:String = "", pChannel:uint = 0, pTimestamp:Number = 0, pSaveMessage:Boolean = true, pForceDisplay:Boolean = false) : void
      {
         if(pChannel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO)
         {
            this.addExternalNotificationFromChatMessage(pChannel,-1,null,null,pText);
         }
      }
      
      private function onGuildInvitation(pGuildId:uint, pGuildName:String, pRecruitedId:Number, pRecruterName:String) : void
      {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.GUILD_INVITATION))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.GUILD_INVITATION,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.GUILD_INVITATION],[pRecruterName,pGuildName]));
         }
      }
   }
}
