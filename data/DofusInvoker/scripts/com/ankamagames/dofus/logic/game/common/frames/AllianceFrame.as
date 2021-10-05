package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.conquest.AllianceOnTheHillWrapper;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceChangeGuildRightsAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInsiderInfoRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceMotdSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.SetEnableAVARequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismAttackRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightJoinLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightSwapRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismInfoJoinLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismModuleExchangeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismSetSabotagedRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismSettingsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismUseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismsListRegisterAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.misc.lists.AlignmentHookList;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.PrismListenEnum;
   import com.ankamagames.dofus.network.enums.PrismSetSabotagedRefusedReasonEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.network.enums.SocialGroupCreationResultEnum;
   import com.ankamagames.dofus.network.enums.SocialGroupInvitationStateEnum;
   import com.ankamagames.dofus.network.enums.SocialNoticeErrorEnum;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceBulletinMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceBulletinSetErrorMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceBulletinSetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceChangeGuildRightsMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationResultMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationStartedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsErrorMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceGuildLeavingMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInsiderInfoMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInsiderInfoRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationStateRecrutedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationStateRecruterMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceJoinedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceKickRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceLeftMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMembershipMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationStartedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMotdMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMotdSetErrorMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMotdSetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.KohUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.AlliancePrismDialogQuestionMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismAttackRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightAddedMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightAttackerAddMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightAttackerRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightDefenderAddMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightDefenderLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightJoinLeaveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightSwapRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismInfoJoinLeaveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismModuleExchangeRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismSetSabotagedRefusedMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismSetSabotagedRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismSettingsErrorMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismSettingsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismUseRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismsInfoValidMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismsListMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismsListRegisterMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismsListUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.SetEnableAVARequestMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.UpdateSelfAgressableStatusMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInAllianceInformations;
   import com.ankamagames.dofus.network.types.game.prism.AllianceInsiderPrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
   import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
   import com.ankamagames.dofus.network.types.game.social.GuildInsiderFactSheetInformations;
   import com.ankamagames.dofus.types.enums.EntityIconEnum;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceFrame));
      
      private static const SIDE_MINE:int = 0;
      
      private static const SIDE_DEFENDERS:int = 1;
      
      private static const SIDE_ATTACKERS:int = 2;
      
      private static var _instance:AllianceFrame;
       
      
      private var _allianceDialogFrame:AllianceDialogFrame;
      
      private var _hasAlliance:Boolean = false;
      
      private var _alliance:AllianceWrapper;
      
      private var _allAlliances:Dictionary;
      
      private var _alliancesOnTheHill:Vector.<AllianceOnTheHillWrapper>;
      
      private var _actualKohInfos:Object;
      
      private var _infoJoinLeave:Boolean;
      
      private var _autoLeaveHelpers:Boolean;
      
      private var _currentPrismsListenMode:uint;
      
      private var _prismsListeners:Dictionary;
      
      public function AllianceFrame()
      {
         this._allAlliances = new Dictionary(true);
         this._actualKohInfos = {};
         super();
      }
      
      public static function getInstance() : AllianceFrame
      {
         return _instance;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get hasAlliance() : Boolean
      {
         return this._hasAlliance;
      }
      
      public function get alliance() : AllianceWrapper
      {
         return this._alliance;
      }
      
      public function getAllianceById(id:uint) : AllianceWrapper
      {
         var aw:AllianceWrapper = this._allAlliances[id];
         if(!aw)
         {
            aw = AllianceWrapper.getAllianceById(id);
         }
         return aw;
      }
      
      public function getPrismSubAreaById(id:uint) : PrismSubAreaWrapper
      {
         return PrismSubAreaWrapper.prismList[id];
      }
      
      public function get alliancesOnTheHill() : Vector.<AllianceOnTheHillWrapper>
      {
         return this._alliancesOnTheHill;
      }
      
      public function get actualKohInfos() : Object
      {
         return this._actualKohInfos;
      }
      
      public function pushed() : Boolean
      {
         PrismSubAreaWrapper.reset();
         _instance = this;
         this._infoJoinLeave = false;
         this._allianceDialogFrame = new AllianceDialogFrame();
         this._prismsListeners = new Dictionary();
         return true;
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var mcmsg:CurrentMapMessage = null;
         var oldSubArea:SubArea = null;
         var newSubArea:SubArea = null;
         var searact:SetEnableAVARequestAction = null;
         var searmsg:SetEnableAVARequestMessage = null;
         var kumsg:KohUpdateMessage = null;
         var nbAlliances:int = 0;
         var side:int = 0;
         var prismAllianceId:int = 0;
         var allianceOnTheHill:AllianceOnTheHillWrapper = null;
         var myAllianceId:int = 0;
         var amsmsg:AllianceModificationStartedMessage = null;
         var acrmsg:AllianceCreationResultMessage = null;
         var aerrorMessage:String = null;
         var ammsg:AllianceMembershipMessage = null;
         var aia:AllianceInvitationAction = null;
         var aimsg:AllianceInvitationMessage = null;
         var aidmsg:AllianceInvitedMessage = null;
         var aisrermsg:AllianceInvitationStateRecruterMessage = null;
         var aisredmsg:AllianceInvitationStateRecrutedMessage = null;
         var ajmsg:AllianceJoinedMessage = null;
         var joinMessage:String = null;
         var akra:AllianceKickRequestAction = null;
         var akrmsg:AllianceKickRequestMessage = null;
         var aglmsg:AllianceGuildLeavingMessage = null;
         var rpFrame:RoleplayEntitiesFrame = null;
         var afra:AllianceFactsRequestAction = null;
         var afrmsg:AllianceFactsRequestMessage = null;
         var afmsg:AllianceFactsMessage = null;
         var firstAlliance:Boolean = false;
         var allianceSheet:AllianceWrapper = null;
         var allianceGuilds:Vector.<GuildFactSheetWrapper> = null;
         var guildSheetForA:GuildFactSheetWrapper = null;
         var nbAllianceMembers:int = 0;
         var afsocialFrame:SocialFrame = null;
         var afemsg:AllianceFactsErrorMessage = null;
         var acgra:AllianceChangeGuildRightsAction = null;
         var acgrmsg:AllianceChangeGuildRightsMessage = null;
         var aiira:AllianceInsiderInfoRequestAction = null;
         var aiirmsg:AllianceInsiderInfoRequestMessage = null;
         var aiimsg:AllianceInsiderInfoMessage = null;
         var myAllianceGuilds:Vector.<GuildFactSheetWrapper> = null;
         var guildSheetForMyA:GuildFactSheetWrapper = null;
         var first:Boolean = false;
         var prismIdsList:Vector.<uint> = null;
         var nbMembersInAlliance:int = 0;
         var aisocialFrame:SocialFrame = null;
         var prismsUpdateMsg:PrismsListUpdateMessage = null;
         var psract:PrismSettingsRequestAction = null;
         var psrmsg:PrismSettingsRequestMessage = null;
         var psemsg:PrismSettingsErrorMessage = null;
         var text:String = null;
         var pfjlract:PrismFightJoinLeaveRequestAction = null;
         var pfjlrmsg:PrismFightJoinLeaveRequestMessage = null;
         var pfsract:PrismFightSwapRequestAction = null;
         var pfsrmsg:PrismFightSwapRequestMessage = null;
         var pijlract:PrismInfoJoinLeaveRequestAction = null;
         var pijlrmsg:PrismInfoJoinLeaveRequestMessage = null;
         var plract:PrismsListRegisterAction = null;
         var updateRegistration:Boolean = false;
         var isListeningMode:int = 0;
         var listenMode:int = 0;
         var pbra:PrismAttackRequestAction = null;
         var pbrqmsg:PrismAttackRequestMessage = null;
         var pura:PrismUseRequestAction = null;
         var purmsg:PrismUseRequestMessage = null;
         var pmera:PrismModuleExchangeRequestAction = null;
         var pmermsg:PrismModuleExchangeRequestMessage = null;
         var pssra:PrismSetSabotagedRequestAction = null;
         var pssrmsg:PrismSetSabotagedRequestMessage = null;
         var pssrdmsg:PrismSetSabotagedRefusedMessage = null;
         var sErrorMessage:String = null;
         var pfdamsg:PrismFightDefenderAddMessage = null;
         var pfdlmsg:PrismFightDefenderLeaveMessage = null;
         var pfaamsg:PrismFightAttackerAddMessage = null;
         var pfarmsg:PrismFightAttackerRemoveMessage = null;
         var plumsg:PrismsListUpdateMessage = null;
         var prismModifiedIds:Array = null;
         var prismSubWUpdated:PrismSubAreaWrapper = null;
         var allianceWu:AllianceWrapper = null;
         var pGeoU:PrismGeolocalizedInformation = null;
         var aInsiderPrismU:AllianceInsiderPrismInformation = null;
         var aPrismU:AlliancePrismInformation = null;
         var plmsg:PrismsListMessage = null;
         var l:uint = 0;
         var pfamsg:PrismFightAddedMessage = null;
         var pfrmsg:PrismFightRemovedMessage = null;
         var pivmsg:PrismsInfoValidMessage = null;
         var apdqmsg:AlliancePrismDialogQuestionMessage = null;
         var amsra:AllianceMotdSetRequestAction = null;
         var amsrmsg:AllianceMotdSetRequestMessage = null;
         var amomsg:AllianceMotdMessage = null;
         var content:String = null;
         var pattern:RegExp = null;
         var motdContent:Array = null;
         var amosemsg:AllianceMotdSetErrorMessage = null;
         var reason:String = null;
         var absra:AllianceBulletinSetRequestAction = null;
         var absrmsg:AllianceBulletinSetRequestMessage = null;
         var abomsg:AllianceBulletinMessage = null;
         var bulletinContent:Array = null;
         var abosemsg:AllianceBulletinSetErrorMessage = null;
         var prism:PrismSubAreaWrapper = null;
         var oldPrism:PrismSubAreaWrapper = null;
         var i:int = 0;
         var pid:Number = NaN;
         var usasmsg:UpdateSelfAgressableStatusMessage = null;
         var giai:GuildInAllianceInformations = null;
         var gifsi:GuildInsiderFactSheetInformations = null;
         var insPrism:PrismSubareaEmptyInfo = null;
         var p:SocialEntityInFightWrapper = null;
         var defender:Object = null;
         var listenModeSaved:Object = null;
         var plrmsg:PrismsListRegisterMessage = null;
         var text2:String = null;
         var prismUpdated:PrismSubareaEmptyInfo = null;
         var worldX:int = 0;
         var worldY:int = 0;
         var prismN:* = null;
         var sentenceToDispatch:String = null;
         var nid:uint = 0;
         var indPrism:uint = 0;
         var textMotd:String = null;
         switch(true)
         {
            case msg is CurrentMapMessage:
               mcmsg = msg as CurrentMapMessage;
               if(!PlayedCharacterManager.getInstance() || !PlayedCharacterManager.getInstance().currentMap)
               {
                  break;
               }
               oldSubArea = SubArea.getSubAreaByMapId(PlayedCharacterManager.getInstance().currentMap.mapId);
               newSubArea = SubArea.getSubAreaByMapId(mcmsg.mapId);
               if(PlayedCharacterManager.getInstance().currentSubArea && newSubArea && oldSubArea && newSubArea.id != oldSubArea.id)
               {
                  if(!PrismSubAreaWrapper.prismList[oldSubArea.id] && PrismSubAreaWrapper.prismList[newSubArea.id])
                  {
                     prism = PrismSubAreaWrapper.prismList[newSubArea.id];
                     if(prism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
                     {
                        KernelEventsManager.getInstance().processCallback(PrismHookList.KohState,prism);
                     }
                  }
                  if(PrismSubAreaWrapper.prismList[oldSubArea.id] && !PrismSubAreaWrapper.prismList[newSubArea.id])
                  {
                     oldPrism = PrismSubAreaWrapper.prismList[oldSubArea.id];
                     if(oldPrism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
                     {
                        KernelEventsManager.getInstance().processCallback(PrismHookList.KohState,null);
                     }
                  }
               }
               return false;
               break;
            case msg is SetEnableAVARequestAction:
               searact = msg as SetEnableAVARequestAction;
               searmsg = new SetEnableAVARequestMessage();
               searmsg.initSetEnableAVARequestMessage(searact.enable);
               ConnectionsHandler.getConnection().send(searmsg);
               return true;
            case msg is KohUpdateMessage:
               kumsg = msg as KohUpdateMessage;
               this._alliancesOnTheHill = new Vector.<AllianceOnTheHillWrapper>();
               nbAlliances = kumsg.alliances.length;
               prismAllianceId = PlayedCharacterManager.getInstance().currentSubArea.id;
               myAllianceId = 0;
               if(this.alliance)
               {
                  myAllianceId = this.alliance.allianceId;
               }
               for(i = 0; i < nbAlliances; i++)
               {
                  if(kumsg.alliances[i].allianceId == myAllianceId)
                  {
                     side = SIDE_MINE;
                  }
                  else if(kumsg.alliances[i].allianceId == prismAllianceId)
                  {
                     side = SIDE_DEFENDERS;
                  }
                  else
                  {
                     side = SIDE_ATTACKERS;
                  }
                  allianceOnTheHill = AllianceOnTheHillWrapper.create(kumsg.alliances[i].allianceId,kumsg.alliances[i].allianceTag,kumsg.alliances[i].allianceName,kumsg.alliances[i].allianceEmblem,kumsg.allianceNbMembers[i],kumsg.allianceRoundWeigth[i],kumsg.allianceMatchScore[i],side);
                  this._alliancesOnTheHill.push(allianceOnTheHill);
               }
               this._actualKohInfos = {
                  "allianceMapWinners":kumsg.allianceMapWinners,
                  "allianceMapWinnerScore":kumsg.allianceMapWinnerScore,
                  "allianceMapMyAllianceScore":kumsg.allianceMapMyAllianceScore,
                  "nextTickTime":kumsg.nextTickTime
               };
               KernelEventsManager.getInstance().processCallback(AlignmentHookList.KohUpdate,this._alliancesOnTheHill,kumsg.allianceMapWinners,kumsg.allianceMapWinnerScore,kumsg.allianceMapMyAllianceScore,kumsg.nextTickTime);
               return true;
            case msg is AllianceCreationStartedMessage:
               Kernel.getWorker().addFrame(this._allianceDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationStarted,false,false);
               return true;
            case msg is AllianceModificationStartedMessage:
               amsmsg = msg as AllianceModificationStartedMessage;
               Kernel.getWorker().addFrame(this._allianceDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationStarted,amsmsg.canChangeName,amsmsg.canChangeEmblem);
               return true;
            case msg is AllianceCreationResultMessage:
               acrmsg = msg as AllianceCreationResultMessage;
               switch(acrmsg.result)
               {
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_ALREADY_IN_GROUP:
                     aerrorMessage = I18n.getUiText("ui.alliance.alreadyInAlliance");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_CANCEL:
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                     aerrorMessage = I18n.getUiText("ui.guild.AlreadyUseEmblem");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_LEAVE:
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:
                     aerrorMessage = I18n.getUiText("ui.alliance.alreadyUseName");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:
                     aerrorMessage = I18n.getUiText("ui.alliance.invalidName");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_TAG_ALREADY_EXISTS:
                     aerrorMessage = I18n.getUiText("ui.alliance.alreadyUseTag");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_TAG_INVALID:
                     aerrorMessage = I18n.getUiText("ui.alliance.invalidTag");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:
                     aerrorMessage = I18n.getUiText("ui.guild.requirementUnmet");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_OK:
                     Kernel.getWorker().removeFrame(this._allianceDialogFrame);
                     this._hasAlliance = true;
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_UNKNOWN:
                     aerrorMessage = I18n.getUiText("ui.common.unknownFail");
               }
               if(aerrorMessage)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,aerrorMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationResult,acrmsg.result);
               return true;
            case msg is AllianceMembershipMessage:
               ammsg = msg as AllianceMembershipMessage;
               if(this._alliance != null)
               {
                  this._alliance.update(ammsg.allianceInfo.allianceId,ammsg.allianceInfo.allianceTag,ammsg.allianceInfo.allianceName,ammsg.allianceInfo.allianceEmblem,ammsg.leadingGuildId);
               }
               else
               {
                  this._alliance = AllianceWrapper.create(ammsg.allianceInfo.allianceId,ammsg.allianceInfo.allianceTag,ammsg.allianceInfo.allianceName,ammsg.allianceInfo.allianceEmblem,ammsg.leadingGuildId);
               }
               this._hasAlliance = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated,true);
               return true;
            case msg is AllianceInvitationAction:
               aia = msg as AllianceInvitationAction;
               aimsg = new AllianceInvitationMessage();
               aimsg.initAllianceInvitationMessage(aia.targetId);
               ConnectionsHandler.getConnection().send(aimsg);
               return true;
            case msg is AllianceInvitedMessage:
               aidmsg = msg as AllianceInvitedMessage;
               Kernel.getWorker().addFrame(this._allianceDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvited,aidmsg.allianceInfo.allianceName,aidmsg.recruterId,aidmsg.recruterName);
               return true;
            case msg is AllianceInvitationStateRecruterMessage:
               aisrermsg = msg as AllianceInvitationStateRecruterMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvitationStateRecruter,aisrermsg.invitationState,aisrermsg.recrutedName);
               if(aisrermsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || aisrermsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._allianceDialogFrame);
               }
               else
               {
                  Kernel.getWorker().addFrame(this._allianceDialogFrame);
               }
               return true;
            case msg is AllianceInvitationStateRecrutedMessage:
               aisredmsg = msg as AllianceInvitationStateRecrutedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvitationStateRecruted,aisredmsg.invitationState);
               if(aisredmsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || aisredmsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._allianceDialogFrame);
               }
               return true;
            case msg is AllianceJoinedMessage:
               ajmsg = msg as AllianceJoinedMessage;
               this._hasAlliance = true;
               this._alliance = AllianceWrapper.create(ajmsg.allianceInfo.allianceId,ajmsg.allianceInfo.allianceTag,ajmsg.allianceInfo.allianceName,ajmsg.allianceInfo.allianceEmblem,ajmsg.leadingGuildId);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated,true);
               joinMessage = I18n.getUiText("ui.alliance.joinAllianceMessage",[ajmsg.allianceInfo.allianceName]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,joinMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is AllianceKickRequestAction:
               akra = msg as AllianceKickRequestAction;
               akrmsg = new AllianceKickRequestMessage();
               akrmsg.initAllianceKickRequestMessage(akra.guildId);
               ConnectionsHandler.getConnection().send(akrmsg);
               return true;
            case msg is AllianceGuildLeavingMessage:
               aglmsg = msg as AllianceGuildLeavingMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceGuildLeaving,aglmsg.kicked,aglmsg.guildId);
               return true;
            case msg is AllianceLeftMessage:
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceLeft);
               this._hasAlliance = false;
               this._alliance = null;
               rpFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if(rpFrame)
               {
                  for each(pid in rpFrame.playersId)
                  {
                     rpFrame.removeIconsCategory(pid,EntityIconEnum.AVA_CATEGORY);
                  }
                  usasmsg = new UpdateSelfAgressableStatusMessage();
                  usasmsg.initUpdateSelfAgressableStatusMessage(AggressableStatusEnum.NON_AGGRESSABLE);
                  rpFrame.process(usasmsg);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated,false);
               return true;
            case msg is AllianceFactsRequestAction:
               afra = msg as AllianceFactsRequestAction;
               afrmsg = new AllianceFactsRequestMessage();
               afrmsg.initAllianceFactsRequestMessage(afra.allianceId);
               ConnectionsHandler.getConnection().send(afrmsg);
               return true;
            case msg is AllianceFactsMessage:
               afmsg = msg as AllianceFactsMessage;
               firstAlliance = true;
               allianceSheet = this._allAlliances[afmsg.infos.allianceId];
               allianceGuilds = new Vector.<GuildFactSheetWrapper>();
               nbAllianceMembers = 0;
               afsocialFrame = SocialFrame.getInstance();
               for each(giai in afmsg.guilds)
               {
                  guildSheetForA = afsocialFrame.getGuildById(giai.guildId);
                  if(guildSheetForA)
                  {
                     guildSheetForA.update(giai.guildId,giai.guildName,giai.guildEmblem,guildSheetForA.leaderId,guildSheetForA.leaderName,giai.guildLevel,giai.nbMembers,guildSheetForA.creationDate,guildSheetForA.members,guildSheetForA.nbConnectedMembers,guildSheetForA.nbTaxCollectors,guildSheetForA.lastActivity,afmsg.infos.allianceId,afmsg.infos.allianceName,afmsg.infos.allianceTag,firstAlliance);
                  }
                  else
                  {
                     guildSheetForA = GuildFactSheetWrapper.create(giai.guildId,giai.guildName,giai.guildEmblem,0,"",giai.guildLevel,giai.nbMembers,0,null,0,0,0,afmsg.infos.allianceId,afmsg.infos.allianceName,afmsg.infos.allianceTag,firstAlliance);
                  }
                  nbAllianceMembers += giai.nbMembers;
                  afsocialFrame.updateGuildById(giai.guildId,guildSheetForA);
                  allianceGuilds.push(guildSheetForA);
                  firstAlliance = false;
               }
               if(allianceSheet)
               {
                  allianceSheet.update(afmsg.infos.allianceId,afmsg.infos.allianceTag,afmsg.infos.allianceName,afmsg.infos.allianceEmblem,0,afmsg.infos.creationDate,allianceGuilds.length,nbAllianceMembers,allianceGuilds,afmsg.controlledSubareaIds,afmsg.leaderCharacterId,afmsg.leaderCharacterName);
               }
               else
               {
                  allianceSheet = AllianceWrapper.create(afmsg.infos.allianceId,afmsg.infos.allianceTag,afmsg.infos.allianceName,afmsg.infos.allianceEmblem,0,afmsg.infos.creationDate,allianceGuilds.length,nbAllianceMembers,allianceGuilds,afmsg.controlledSubareaIds,afmsg.leaderCharacterId,afmsg.leaderCharacterName);
                  this._allAlliances[afmsg.infos.allianceId] = allianceSheet;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.OpenOneAlliance,allianceSheet);
               return true;
            case msg is AllianceFactsErrorMessage:
               afemsg = msg as AllianceFactsErrorMessage;
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.alliance.doesntExistAnymore"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is AllianceChangeGuildRightsAction:
               acgra = msg as AllianceChangeGuildRightsAction;
               acgrmsg = new AllianceChangeGuildRightsMessage();
               acgrmsg.initAllianceChangeGuildRightsMessage(acgra.guildId,acgra.rights);
               ConnectionsHandler.getConnection().send(acgrmsg);
               return true;
            case msg is AllianceInsiderInfoRequestAction:
               aiira = msg as AllianceInsiderInfoRequestAction;
               aiirmsg = new AllianceInsiderInfoRequestMessage();
               aiirmsg.initAllianceInsiderInfoRequestMessage();
               ConnectionsHandler.getConnection().send(aiirmsg);
               return true;
            case msg is AllianceInsiderInfoMessage:
               aiimsg = msg as AllianceInsiderInfoMessage;
               myAllianceGuilds = new Vector.<GuildFactSheetWrapper>();
               first = true;
               prismIdsList = new Vector.<uint>();
               nbMembersInAlliance = 0;
               aisocialFrame = SocialFrame.getInstance();
               for each(gifsi in aiimsg.guilds)
               {
                  guildSheetForMyA = aisocialFrame.getGuildById(gifsi.guildId);
                  if(guildSheetForMyA)
                  {
                     guildSheetForMyA.update(gifsi.guildId,gifsi.guildName,gifsi.guildEmblem,gifsi.leaderId,gifsi.leaderName,gifsi.guildLevel,gifsi.nbMembers,guildSheetForMyA.creationDate,guildSheetForMyA.members,gifsi.nbConnectedMembers,gifsi.nbTaxCollectors,gifsi.lastActivity,aiimsg.allianceInfos.allianceId,aiimsg.allianceInfos.allianceName,aiimsg.allianceInfos.allianceTag,first);
                  }
                  else
                  {
                     guildSheetForMyA = GuildFactSheetWrapper.create(gifsi.guildId,gifsi.guildName,gifsi.guildEmblem,gifsi.leaderId,gifsi.leaderName,gifsi.guildLevel,gifsi.nbMembers,0,null,gifsi.nbConnectedMembers,gifsi.nbTaxCollectors,gifsi.lastActivity,aiimsg.allianceInfos.allianceId,aiimsg.allianceInfos.allianceName,aiimsg.allianceInfos.allianceTag,first);
                  }
                  nbMembersInAlliance += gifsi.nbMembers;
                  aisocialFrame.updateGuildById(gifsi.guildId,guildSheetForMyA);
                  myAllianceGuilds.push(guildSheetForMyA);
                  first = false;
               }
               for each(insPrism in aiimsg.prisms)
               {
                  if(insPrism is PrismGeolocalizedInformation && (insPrism as PrismGeolocalizedInformation).prism is AllianceInsiderPrismInformation)
                  {
                     prismIdsList.push(insPrism.subAreaId);
                  }
               }
               prismsUpdateMsg = new PrismsListUpdateMessage();
               prismsUpdateMsg.initPrismsListUpdateMessage(aiimsg.prisms);
               this.process(prismsUpdateMsg);
               if(this._alliance)
               {
                  this._alliance.update(aiimsg.allianceInfos.allianceId,aiimsg.allianceInfos.allianceTag,aiimsg.allianceInfos.allianceName,aiimsg.allianceInfos.allianceEmblem,0,aiimsg.allianceInfos.creationDate,aiimsg.guilds.length,nbMembersInAlliance,myAllianceGuilds,prismIdsList);
               }
               else
               {
                  this._alliance = AllianceWrapper.create(aiimsg.allianceInfos.allianceId,aiimsg.allianceInfos.allianceTag,aiimsg.allianceInfos.allianceName,aiimsg.allianceInfos.allianceEmblem,0,aiimsg.allianceInfos.creationDate,aiimsg.guilds.length,nbMembersInAlliance,myAllianceGuilds,prismIdsList);
               }
               this._allAlliances[aiimsg.allianceInfos.allianceId] = this._alliance;
               this._hasAlliance = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceUpdateInformations);
               return true;
            case msg is PrismSettingsRequestAction:
               psract = msg as PrismSettingsRequestAction;
               psrmsg = new PrismSettingsRequestMessage();
               psrmsg.initPrismSettingsRequestMessage(psract.subAreaId,psract.startDefenseTime);
               ConnectionsHandler.getConnection().send(psrmsg);
               return true;
            case msg is PrismSettingsErrorMessage:
               psemsg = msg as PrismSettingsErrorMessage;
               text = I18n.getUiText("ui.error.cantModifiedPrismVulnerabiltyHour");
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is PrismFightJoinLeaveRequestAction:
               pfjlract = msg as PrismFightJoinLeaveRequestAction;
               pfjlrmsg = new PrismFightJoinLeaveRequestMessage();
               this._autoLeaveHelpers = false;
               if(pfjlract.subAreaId == 0 && !pfjlract.join)
               {
                  for each(p in TaxCollectorsManager.getInstance().prismsFighters)
                  {
                     for each(defender in p.allyCharactersInformations)
                     {
                        if(defender.playerCharactersInformations.id == PlayedCharacterManager.getInstance().id)
                        {
                           this._autoLeaveHelpers = true;
                           pfjlrmsg.initPrismFightJoinLeaveRequestMessage(p.uniqueId,pfjlract.join);
                           ConnectionsHandler.getConnection().send(pfjlrmsg);
                           return true;
                        }
                     }
                  }
               }
               else
               {
                  pfjlrmsg.initPrismFightJoinLeaveRequestMessage(pfjlract.subAreaId,pfjlract.join);
                  ConnectionsHandler.getConnection().send(pfjlrmsg);
               }
               return true;
            case msg is PrismFightSwapRequestAction:
               pfsract = msg as PrismFightSwapRequestAction;
               pfsrmsg = new PrismFightSwapRequestMessage();
               pfsrmsg.initPrismFightSwapRequestMessage(pfsract.subAreaId,pfsract.targetId);
               ConnectionsHandler.getConnection().send(pfsrmsg);
               return true;
            case msg is PrismInfoJoinLeaveRequestAction:
               pijlract = msg as PrismInfoJoinLeaveRequestAction;
               pijlrmsg = new PrismInfoJoinLeaveRequestMessage();
               pijlrmsg.initPrismInfoJoinLeaveRequestMessage(pijlract.join);
               this._infoJoinLeave = pijlract.join;
               ConnectionsHandler.getConnection().send(pijlrmsg);
               return true;
            case msg is PrismsListRegisterAction:
               plract = msg as PrismsListRegisterAction;
               updateRegistration = false;
               isListeningMode = 0;
               if(this._prismsListeners[plract.uiName])
               {
                  isListeningMode = this._prismsListeners[plract.uiName];
               }
               listenMode = plract.listen;
               if(listenMode != PrismListenEnum.PRISM_LISTEN_NONE)
               {
                  if(isListeningMode == PrismListenEnum.PRISM_LISTEN_NONE)
                  {
                     this._prismsListeners[plract.uiName] = listenMode;
                  }
                  if(this._currentPrismsListenMode == PrismListenEnum.PRISM_LISTEN_MINE)
                  {
                     updateRegistration = false;
                  }
                  else
                  {
                     updateRegistration = true;
                  }
               }
               else
               {
                  if(isListeningMode > PrismListenEnum.PRISM_LISTEN_NONE)
                  {
                     this._prismsListeners[plract.uiName] = PrismListenEnum.PRISM_LISTEN_NONE;
                  }
                  for each(listenModeSaved in this._prismsListeners)
                  {
                     if(listenModeSaved == PrismListenEnum.PRISM_LISTEN_MINE)
                     {
                        listenMode = PrismListenEnum.PRISM_LISTEN_MINE;
                        break;
                     }
                     if(listenModeSaved == PrismListenEnum.PRISM_LISTEN_ALL)
                     {
                        listenMode = PrismListenEnum.PRISM_LISTEN_ALL;
                     }
                  }
                  updateRegistration = true;
               }
               if(updateRegistration)
               {
                  plrmsg = new PrismsListRegisterMessage();
                  plrmsg.initPrismsListRegisterMessage(listenMode);
                  ConnectionsHandler.getConnection().send(plrmsg);
                  this._currentPrismsListenMode = listenMode;
               }
               return true;
            case msg is PrismAttackRequestAction:
               pbra = msg as PrismAttackRequestAction;
               pbrqmsg = new PrismAttackRequestMessage();
               pbrqmsg.initPrismAttackRequestMessage();
               ConnectionsHandler.getConnection().send(pbrqmsg);
               return true;
            case msg is PrismUseRequestAction:
               pura = msg as PrismUseRequestAction;
               purmsg = new PrismUseRequestMessage();
               purmsg.initPrismUseRequestMessage(pura.moduleType);
               ConnectionsHandler.getConnection().send(purmsg);
               return true;
            case msg is PrismModuleExchangeRequestAction:
               pmera = msg as PrismModuleExchangeRequestAction;
               pmermsg = new PrismModuleExchangeRequestMessage();
               pmermsg.initPrismModuleExchangeRequestMessage();
               ConnectionsHandler.getConnection().send(pmermsg);
               return true;
            case msg is PrismSetSabotagedRequestAction:
               pssra = msg as PrismSetSabotagedRequestAction;
               pssrmsg = new PrismSetSabotagedRequestMessage();
               pssrmsg.initPrismSetSabotagedRequestMessage(pssra.subAreaId);
               ConnectionsHandler.getConnection().send(pssrmsg);
               return true;
            case msg is PrismSetSabotagedRefusedMessage:
               pssrdmsg = msg as PrismSetSabotagedRefusedMessage;
               switch(pssrdmsg.reason)
               {
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_REFUSED:
                     sErrorMessage = I18n.getUiText("ui.prism.sabotageRefused");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_INSUFFICIENT_RIGHTS:
                     sErrorMessage = I18n.getUiText("ui.social.taxCollectorNoRights");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_MEMBER_ACCOUNT_NEEDED:
                     sErrorMessage = I18n.getUiText("ui.payzone.limit");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_RESTRICTED_ACCOUNT:
                     sErrorMessage = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_WRONG_STATE:
                     sErrorMessage = I18n.getUiText("ui.prism.sabotageRefusedWrongState");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_WRONG_ALLIANCE:
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_NO_PRISM:
                     _log.debug("ERROR : Prism sabotage failed for reason " + pssrdmsg.reason);
               }
               if(sErrorMessage)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sErrorMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is PrismFightDefenderAddMessage:
               pfdamsg = msg as PrismFightDefenderAddMessage;
               TaxCollectorsManager.getInstance().addFighter(1,pfdamsg.subAreaId,pfdamsg.defender,true);
               return true;
            case msg is PrismFightDefenderLeaveMessage:
               pfdlmsg = msg as PrismFightDefenderLeaveMessage;
               if(this._autoLeaveHelpers && pfdlmsg.fighterToRemoveId == PlayedCharacterManager.getInstance().id)
               {
                  text2 = I18n.getUiText("ui.prism.AutoDisjoin");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text2,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               TaxCollectorsManager.getInstance().removeFighter(1,pfdlmsg.subAreaId,pfdlmsg.fighterToRemoveId,true);
               return true;
            case msg is PrismFightAttackerAddMessage:
               pfaamsg = msg as PrismFightAttackerAddMessage;
               TaxCollectorsManager.getInstance().addFighter(1,pfaamsg.subAreaId,pfaamsg.attacker,false);
               return true;
            case msg is PrismFightAttackerRemoveMessage:
               pfarmsg = msg as PrismFightAttackerRemoveMessage;
               TaxCollectorsManager.getInstance().removeFighter(1,pfarmsg.subAreaId,pfarmsg.fighterToRemoveId,false);
               return true;
            case msg is PrismsListUpdateMessage:
               plumsg = msg as PrismsListUpdateMessage;
               prismModifiedIds = new Array();
               for each(prismUpdated in plumsg.prisms)
               {
                  if(prismUpdated is PrismGeolocalizedInformation && (prismUpdated as PrismGeolocalizedInformation).prism is AllianceInsiderPrismInformation)
                  {
                     pGeoU = prismUpdated as PrismGeolocalizedInformation;
                     aInsiderPrismU = pGeoU.prism as AllianceInsiderPrismInformation;
                     prismSubWUpdated = PrismSubAreaWrapper.prismList[prismUpdated.subAreaId];
                     worldX = pGeoU.worldX;
                     worldY = pGeoU.worldY;
                     prismN = SubArea.getSubAreaById(pGeoU.subAreaId).name + " (" + SubArea.getSubAreaById(pGeoU.subAreaId).area.name + ")";
                     if(aInsiderPrismU.state == PrismStateEnum.PRISM_STATE_SABOTAGED && prismSubWUpdated && prismSubWUpdated.state != PrismStateEnum.PRISM_STATE_SABOTAGED)
                     {
                        sentenceToDispatch = I18n.getUiText("ui.prism.sabotaged",[prismN,worldX + "," + worldY]);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentenceToDispatch,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
                     }
                     else if(aInsiderPrismU.state == PrismStateEnum.PRISM_STATE_ATTACKED && prismSubWUpdated && prismSubWUpdated.state != PrismStateEnum.PRISM_STATE_ATTACKED)
                     {
                        sentenceToDispatch = I18n.getUiText("ui.prism.attacked",[prismN,worldX + "," + worldY]);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"{openSocial,2,2,1," + pGeoU.subAreaId + "::" + sentenceToDispatch + "}",ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
                        if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.PRISM_ATTACK))
                        {
                           KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.PRISM_ATTACK,[prismN,pGeoU.worldX + "," + pGeoU.worldY]);
                        }
                        if(OptionManager.getOptionManager("dofus").getOption("warnOnGuildItemAgression"))
                        {
                           nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.prism.attackedNotificationTitle"),I18n.getUiText("ui.prism.attackedNotification",[SubArea.getSubAreaById(pGeoU.subAreaId).name,pGeoU.worldX + "," + pGeoU.worldY]),NotificationTypeEnum.INVITATION,"PrismAttacked");
                           NotificationManager.getInstance().addButtonToNotification(nid,I18n.getUiText("ui.common.join"),"OpenSocial",[2,2,[1,pGeoU.subAreaId]],false,200,0,"hook");
                           NotificationManager.getInstance().sendNotification(nid);
                        }
                     }
                     else if(prismSubWUpdated && prismSubWUpdated.state == PrismStateEnum.PRISM_STATE_FIGHTING && aInsiderPrismU.state != PrismStateEnum.PRISM_STATE_FIGHTING)
                     {
                        if(aInsiderPrismU.state == PrismStateEnum.PRISM_STATE_NORMAL)
                        {
                           sentenceToDispatch = I18n.getUiText("ui.prism.notDefeated",[prismN,worldX + "," + worldY]);
                        }
                        else if(aInsiderPrismU.state == PrismStateEnum.PRISM_STATE_WEAKENED)
                        {
                           sentenceToDispatch = I18n.getUiText("ui.prism.weakened",[prismN,worldX + "," + worldY]);
                        }
                        if(sentenceToDispatch)
                        {
                           KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentenceToDispatch,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
                        }
                     }
                  }
                  prismModifiedIds.push(prismUpdated.subAreaId);
                  PrismSubAreaWrapper.getFromNetwork(prismUpdated,this._alliance);
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsListUpdate,prismModifiedIds);
               return true;
            case msg is PrismsListMessage:
               plmsg = msg as PrismsListMessage;
               l = plmsg.prisms.length;
               for(indPrism = 0; indPrism < l; indPrism++)
               {
                  PrismSubAreaWrapper.getFromNetwork(plmsg.prisms[indPrism],this._alliance);
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsList,PrismSubAreaWrapper.prismList);
               return true;
            case msg is PrismFightAddedMessage:
               pfamsg = msg as PrismFightAddedMessage;
               TaxCollectorsManager.getInstance().addPrism(pfamsg.fight);
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInFightAdded,pfamsg.fight.subAreaId);
               return true;
            case msg is PrismFightRemovedMessage:
               pfrmsg = msg as PrismFightRemovedMessage;
               delete TaxCollectorsManager.getInstance().prismsFighters[pfrmsg.subAreaId];
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInFightRemoved,pfrmsg.subAreaId);
               return true;
            case msg is PrismsInfoValidMessage:
               pivmsg = msg as PrismsInfoValidMessage;
               TaxCollectorsManager.getInstance().setPrismsInFight(pivmsg.fights);
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsInFightList);
               return true;
            case msg is AlliancePrismDialogQuestionMessage:
               apdqmsg = msg as AlliancePrismDialogQuestionMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AlliancePrismDialogQuestion);
               return true;
            case msg is AllianceMotdSetRequestAction:
               amsra = msg as AllianceMotdSetRequestAction;
               amsrmsg = new AllianceMotdSetRequestMessage();
               amsrmsg.initAllianceMotdSetRequestMessage(amsra.content);
               ConnectionsHandler.getConnection().send(amsrmsg);
               return true;
            case msg is AllianceMotdMessage:
               amomsg = msg as AllianceMotdMessage;
               content = amomsg.content;
               pattern = /</g;
               content = content.replace(pattern,"&lt;");
               motdContent = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).checkCensored(content,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,amomsg.memberId,amomsg.memberName);
               this._alliance.motd = amomsg.content;
               this._alliance.formattedMotd = motdContent[0];
               this._alliance.motdWriterId = amomsg.memberId;
               this._alliance.motdWriterName = amomsg.memberName;
               this._alliance.motdTimestamp = amomsg.timestamp;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMotd);
               if(amomsg.content != "" && !OptionManager.getOptionManager("dofus").getOption("disableAllianceMotd"))
               {
                  textMotd = I18n.getUiText("ui.motd.alliance") + I18n.getUiText("ui.common.colon") + motdContent[0];
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,textMotd,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is AllianceMotdSetErrorMessage:
               amosemsg = msg as AllianceMotdSetErrorMessage;
               switch(amosemsg.reason)
               {
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_UNKNOWN_ERROR:
                     reason = I18n.getUiText("ui.common.unknownFail");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_COOLDOWN:
                     reason = I18n.getUiText("ui.motd.errorCooldown");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_INVALID_RIGHTS:
                     reason = I18n.getUiText("ui.social.taxCollectorNoRights");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,reason,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is AllianceBulletinSetRequestAction:
               absra = msg as AllianceBulletinSetRequestAction;
               absrmsg = new AllianceBulletinSetRequestMessage();
               absrmsg.initAllianceBulletinSetRequestMessage(absra.content,absra.notifyMembers);
               ConnectionsHandler.getConnection().send(absrmsg);
               return true;
            case msg is AllianceBulletinMessage:
               abomsg = msg as AllianceBulletinMessage;
               content = abomsg.content;
               pattern = /</g;
               content = content.replace(pattern,"&lt;");
               bulletinContent = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).checkCensored(content,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,abomsg.memberId,abomsg.memberName);
               this._alliance.bulletin = abomsg.content;
               this._alliance.formattedBulletin = bulletinContent[0];
               this._alliance.bulletinWriterId = abomsg.memberId;
               this._alliance.bulletinWriterName = abomsg.memberName;
               this._alliance.bulletinTimestamp = abomsg.timestamp;
               this._alliance.lastNotifiedTimestamp = abomsg.lastNotifiedTimestamp;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceBulletin);
               return true;
            case msg is AllianceBulletinSetErrorMessage:
               abosemsg = msg as AllianceBulletinSetErrorMessage;
               switch(abosemsg.reason)
               {
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_UNKNOWN_ERROR:
                     reason = I18n.getUiText("ui.common.unknownFail");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_COOLDOWN:
                     reason = I18n.getUiText("ui.motd.errorCooldown");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_INVALID_RIGHTS:
                     reason = I18n.getUiText("ui.social.taxCollectorNoRights");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,reason,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
         }
         return false;
      }
   }
}
