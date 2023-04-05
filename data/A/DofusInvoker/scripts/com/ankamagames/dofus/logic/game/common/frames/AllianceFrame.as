package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.conquest.AllianceOnTheHillWrapper;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.TaxCollectorWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkMapPosition;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkSocialManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.NuggetDistributionAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.SetEnableAVARequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.StartListenAllianceFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.StartListenNuggetsAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.StopListenAllianceFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.StopListenNuggetsAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismAttackRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismExchangeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismRecycleTradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.socialFight.SocialFightJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.socialFight.SocialFightLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.socialFight.SocialFightTakePlaceRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.AddTaxCollectorOrderedSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.AddTaxCollectorPresetSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.MoveTaxCollectorOrderedSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.MoveTaxCollectorPresetSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.RemoveTaxCollectorOrderedSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.RemoveTaxCollectorPresetSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.StartListenTaxCollectorPresetsUpdatesAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.StartListenTaxCollectorUpdatesAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.StopListenTaxCollectorPresetsUpdatesAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.StopListenTaxCollectorUpdatesAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.SocialEntitiesManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.AlignmentHookList;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.PrismAttackResultEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.network.enums.TaxCollectorErrorReasonEnum;
   import com.ankamagames.dofus.network.enums.TaxCollectorMovementTypeEnum;
   import com.ankamagames.dofus.network.messages.game.alliance.KohUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.KothEndMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.fight.AllianceFightFighterAddedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.fight.AllianceFightFighterRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.fight.AllianceFightFinishedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.fight.AllianceFightInfoMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.fight.AllianceFightPhaseUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.fight.AllianceFightStartedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.fight.StartListenAllianceFightMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.fight.StopListenAllianceFightMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.AddTaxCollectorOrderedSpellMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.AddTaxCollectorPresetSpellMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.ConfirmationOfListeningTaxCollectorUpdatesMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.MoveTaxCollectorOrderedSpellMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.MoveTaxCollectorPresetSpellMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.RemoveTaxCollectorOrderedSpellMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.RemoveTaxCollectorPresetSpellMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.StartListenTaxCollectorPresetsUpdatesMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.StartListenTaxCollectorUpdatesMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.StopListenTaxCollectorPresetsUpdatesMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.StopListenTaxCollectorUpdatesMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorAddedMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorAttackedMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorAttackedResultMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorErrorMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorHarvestedMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorMovementsOfflineMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorOrderedSpellUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorPresetSpellUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorPresetsMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TaxCollectorStateUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.collector.tax.TopTaxCollectorListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.AlliancePrismDialogQuestionMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.TaxCollectorDialogQuestionBasicMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.TaxCollectorDialogQuestionExtendedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorEquipmentUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeTaxCollectorGetMessage;
   import com.ankamagames.dofus.network.messages.game.nuggets.NuggetsDistributionMessage;
   import com.ankamagames.dofus.network.messages.game.nuggets.NuggetsInformationMessage;
   import com.ankamagames.dofus.network.messages.game.nuggets.StartListenNuggetsMessage;
   import com.ankamagames.dofus.network.messages.game.nuggets.StopListenNuggetsMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismAddOrUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismAttackRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismAttackResultMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismAttackedMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismExchangeRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismRecycleTradeRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismTeleportationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismsListMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.SetEnableAVARequestMessage;
   import com.ankamagames.dofus.network.messages.game.social.fight.SocialFightJoinRequestMessage;
   import com.ankamagames.dofus.network.messages.game.social.fight.SocialFightLeaveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.social.fight.SocialFightTakePlaceRequestMessage;
   import com.ankamagames.dofus.network.types.game.alliance.KohAllianceInfo;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorMovement;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorPreset;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemGenericQuantity;
   import com.ankamagames.dofus.network.types.game.nuggets.NuggetsBeneficiary;
   import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceFrame));
      
      private static const SIDE_MINE:int = 0;
      
      private static const SIDE_DEFENDERS:int = 1;
      
      private static const SIDE_ATTACKERS:int = 2;
      
      private static var _instance:AllianceFrame;
       
      
      private var _alliancesOnTheHill:Vector.<AllianceOnTheHillWrapper>;
      
      private var _kohNextTick:Number;
      
      private var _startingAvaTimestamp:Number;
      
      private var _dungeonTopTaxCollectors:Vector.<TaxCollectorInformations>;
      
      private var _topTaxCollectors:Vector.<TaxCollectorInformations>;
      
      private var _nuggetsBalance:Number = 0;
      
      public var currentJoinedFight:SocialFightInfo;
      
      public function AllianceFrame()
      {
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
      
      public function getPrismSubAreaById(id:uint) : PrismSubAreaWrapper
      {
         return SocialEntitiesManager.getInstance().prisms[id];
      }
      
      public function get alliancesOnTheHill() : Vector.<AllianceOnTheHillWrapper>
      {
         return this._alliancesOnTheHill;
      }
      
      public function set alliancesOnTheHill(value:Vector.<AllianceOnTheHillWrapper>) : void
      {
         this._alliancesOnTheHill = value;
      }
      
      public function get kohNextTick() : Number
      {
         return this._kohNextTick;
      }
      
      public function get startingAvaTimestamp() : Number
      {
         return this._startingAvaTimestamp;
      }
      
      public function get nuggetsBalance() : Number
      {
         return this._nuggetsBalance;
      }
      
      public function pushed() : Boolean
      {
         SocialEntitiesManager.getInstance().destroy();
         _instance = this;
         return true;
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var startlafmsg:StartListenAllianceFightMessage = null;
         var stoplafmsg:StopListenAllianceFightMessage = null;
         var afimsg:AllianceFightInfoMessage = null;
         var tcadmsg:TaxCollectorAddedMessage = null;
         var newTC:Boolean = false;
         var tcAddedWrapper:TaxCollectorWrapper = null;
         var tcrmsg:TaxCollectorRemovedMessage = null;
         var affamsg:AllianceFightFighterAddedMessage = null;
         var affrmsg:AllianceFightFighterRemovedMessage = null;
         var afsmsg:AllianceFightStartedMessage = null;
         var affmsg:AllianceFightFinishedMessage = null;
         var afpumsg:AllianceFightPhaseUpdateMessage = null;
         var sfjra:SocialFightJoinRequestAction = null;
         var sfjrmsg:SocialFightJoinRequestMessage = null;
         var sflra:SocialFightLeaveRequestAction = null;
         var sflrmsg:SocialFightLeaveRequestMessage = null;
         var sftpra:SocialFightTakePlaceRequestAction = null;
         var sftprmsg:SocialFightTakePlaceRequestMessage = null;
         var mcmsg:CurrentMapMessage = null;
         var oldSubArea:SubArea = null;
         var newSubArea:SubArea = null;
         var searact:SetEnableAVARequestAction = null;
         var searmsg:SetEnableAVARequestMessage = null;
         var kumsg:KohUpdateMessage = null;
         var myAlliance:AllianceWrapper = null;
         var side:int = 0;
         var allianceOnTheHill:AllianceOnTheHillWrapper = null;
         var prismAlliance:AllianceWrapper = null;
         var prismAllianceId:int = 0;
         var myAllianceId:int = 0;
         var kem:KothEndMessage = null;
         var pbrqmsg:PrismAttackRequestMessage = null;
         var purmsg:PrismTeleportationRequestMessage = null;
         var pmermsg:PrismExchangeRequestMessage = null;
         var prtra:PrismRecycleTradeRequestAction = null;
         var prtrm:PrismRecycleTradeRequestMessage = null;
         var pam:PrismAttackedMessage = null;
         var prismSubArea:PrismSubAreaWrapper = null;
         var textToDispatch:String = null;
         var parm:PrismAttackResultMessage = null;
         var prismAttackResultSubArea:PrismSubAreaWrapper = null;
         var prismAttackResultText:String = null;
         var paoumsg:PrismAddOrUpdateMessage = null;
         var prismUpdated:PrismGeolocalizedInformation = null;
         var plmsg:PrismsListMessage = null;
         var prismsList:Vector.<uint> = null;
         var prmsg:PrismRemoveMessage = null;
         var tcamsg:TaxCollectorAttackedMessage = null;
         var worldX:int = 0;
         var worldY:int = 0;
         var taxCollectorN:String = null;
         var sentenceToDisplatch:String = null;
         var tcarmsg:TaxCollectorAttackedResultMessage = null;
         var sentenceToDisplatchResultAttack:String = null;
         var taxCName:String = null;
         var pointAttacked:WorldPointWrapper = null;
         var worldPosX:int = 0;
         var worldPosY:int = 0;
         var tcemsg:TaxCollectorErrorMessage = null;
         var errorTaxCollectorMessage:String = null;
         var tchmsg:TaxCollectorHarvestedMessage = null;
         var tcsumsg:TaxCollectorStateUpdateMessage = null;
         var tcmomsg:TaxCollectorMovementsOfflineMessage = null;
         var tcm:TaxCollectorMovement = null;
         var tcOffName:String = null;
         var tcOffPlayerLink:* = null;
         var tcOffPoint:WorldPointWrapper = null;
         var tcOffWorldMapId:int = 0;
         var tcOffMapLink:String = null;
         var sentenceToDisplatchDisappearances:String = null;
         var tcHarvestedNamesList:* = null;
         var tcDefeatedNamesList:* = null;
         var harvestedNumber:int = 0;
         var defeatedNumber:int = 0;
         var ttclmsg:TopTaxCollectorListMessage = null;
         var sltcua:StartListenTaxCollectorUpdatesAction = null;
         var sltcum:StartListenTaxCollectorUpdatesMessage = null;
         var spltcua:StopListenTaxCollectorUpdatesAction = null;
         var spltcum:StopListenTaxCollectorUpdatesMessage = null;
         var coltcum:ConfirmationOfListeningTaxCollectorUpdatesMessage = null;
         var tceum:TaxCollectorEquipmentUpdateMessage = null;
         var tcw:TaxCollectorWrapper = null;
         var atcosa:AddTaxCollectorOrderedSpellAction = null;
         var atcosm:AddTaxCollectorOrderedSpellMessage = null;
         var rtcosa:RemoveTaxCollectorOrderedSpellAction = null;
         var rtcosm:RemoveTaxCollectorOrderedSpellMessage = null;
         var tcosum:TaxCollectorOrderedSpellUpdatedMessage = null;
         var tc:TaxCollectorWrapper = null;
         var mtcosa:MoveTaxCollectorOrderedSpellAction = null;
         var mtcosm:MoveTaxCollectorOrderedSpellMessage = null;
         var sltcpum:StartListenTaxCollectorPresetsUpdatesMessage = null;
         var spltcpum:StopListenTaxCollectorPresetsUpdatesMessage = null;
         var atcpsa:AddTaxCollectorPresetSpellAction = null;
         var atcpsm:AddTaxCollectorPresetSpellMessage = null;
         var tcpsum:TaxCollectorPresetSpellUpdatedMessage = null;
         var alliance:AllianceWrapper = null;
         var rtcpsa:RemoveTaxCollectorPresetSpellAction = null;
         var rtcpsm:RemoveTaxCollectorPresetSpellMessage = null;
         var mtcpsa:MoveTaxCollectorPresetSpellAction = null;
         var mtcpsm:MoveTaxCollectorPresetSpellMessage = null;
         var tcpsm:TaxCollectorPresetsMessage = null;
         var playerAlliance:AllianceWrapper = null;
         var etcgmsg:ExchangeTaxCollectorGetMessage = null;
         var totalQuantity:uint = 0;
         var taxCollectorObjet:ObjectItemGenericQuantity = null;
         var idFName:Number = NaN;
         var idName:Number = NaN;
         var collectedTaxCollectors:Dictionary = null;
         var taxCollectorWrapper:TaxCollectorWrapper = null;
         var taxcollectorCollectedMsg:* = null;
         var tcdqemsg:TaxCollectorDialogQuestionExtendedMessage = null;
         var slnmsg:StartListenNuggetsMessage = null;
         var stlnmsg:StopListenNuggetsMessage = null;
         var nimsg:NuggetsInformationMessage = null;
         var nda:NuggetDistributionAction = null;
         var ndmsg:NuggetsDistributionMessage = null;
         var prism:PrismSubAreaWrapper = null;
         var oldPrism:PrismSubAreaWrapper = null;
         var allianceInfo:KohAllianceInfo = null;
         var notifId:uint = 0;
         var openSocialArgs:Array = null;
         var prismGeo:PrismGeolocalizedInformation = null;
         var suba:SubArea = null;
         var nid:uint = 0;
         var openSocialParams:Array = null;
         var taxCollectorInfo:TaxCollectorInformations = null;
         var dungeonTopTaxCollectors:Vector.<TaxCollectorWrapper> = null;
         var worldTopTaxCollectors:Vector.<TaxCollectorWrapper> = null;
         var index:uint = 0;
         var taxCollectorPreset:TaxCollectorPreset = null;
         switch(true)
         {
            case msg is StartListenAllianceFightAction:
               startlafmsg = new StartListenAllianceFightMessage();
               startlafmsg.initStartListenAllianceFightMessage();
               ConnectionsHandler.getConnection().send(startlafmsg);
               return true;
            case msg is StopListenAllianceFightAction:
               stoplafmsg = new StopListenAllianceFightMessage();
               stoplafmsg.initStopListenAllianceFightMessage();
               ConnectionsHandler.getConnection().send(stoplafmsg);
               return true;
            case msg is AllianceFightInfoMessage:
               afimsg = msg as AllianceFightInfoMessage;
               SocialEntitiesManager.getInstance().setFightingEntities(afimsg.allianceFights);
               return true;
            case msg is TaxCollectorAddedMessage:
               tcadmsg = msg as TaxCollectorAddedMessage;
               newTC = SocialEntitiesManager.getInstance().addTaxCollector(tcadmsg.description);
               tcAddedWrapper = SocialEntitiesManager.getInstance().taxCollectors[tcadmsg.description.uniqueId];
               if(newTC)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorAdded,tcAddedWrapper);
               }
               this.taxCollectorChatMessage(tcAddedWrapper,TaxCollectorMovementTypeEnum.TAX_COLLECTOR_HIRED,tcAddedWrapper.additionalInformation.collectorCallerId,tcAddedWrapper.additionalInformation.collectorCallerName);
               return true;
            case msg is TaxCollectorRemovedMessage:
               tcrmsg = msg as TaxCollectorRemovedMessage;
               SocialEntitiesManager.getInstance().removeTaxCollector(tcrmsg.collectorId);
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorRemoved,tcrmsg.collectorId);
               KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_taxcollector" + tcrmsg.collectorId,-1);
               return true;
            case msg is AllianceFightFighterAddedMessage:
               affamsg = msg as AllianceFightFighterAddedMessage;
               if(affamsg.fighter.id == PlayedCharacterManager.getInstance().id)
               {
                  this.currentJoinedFight = affamsg.allianceFightInfo;
               }
               SocialEntitiesManager.getInstance().addFighter(affamsg.allianceFightInfo.fightId,affamsg.allianceFightInfo.fightType,affamsg.fighter,affamsg.team);
               return true;
            case msg is AllianceFightFighterRemovedMessage:
               affrmsg = msg as AllianceFightFighterRemovedMessage;
               if(affrmsg.fighterId == PlayedCharacterManager.getInstance().id)
               {
                  this.currentJoinedFight = null;
               }
               SocialEntitiesManager.getInstance().removeFighter(affrmsg.allianceFightInfo.fightId,affrmsg.allianceFightInfo.fightType,affrmsg.fighterId);
               return true;
            case msg is AllianceFightStartedMessage:
               afsmsg = msg as AllianceFightStartedMessage;
               SocialEntitiesManager.getInstance().addFightingEntity(afsmsg.allianceFightInfo.mapId,afsmsg.allianceFightInfo.fightId,afsmsg.allianceFightInfo.fightType,afsmsg.phase.phase,afsmsg.phase.phaseEndTimeStamp);
               return true;
            case msg is AllianceFightFinishedMessage:
               affmsg = msg as AllianceFightFinishedMessage;
               if(this.currentJoinedFight && affmsg.allianceFightInfo.fightId == this.currentJoinedFight.fightId && affmsg.allianceFightInfo.fightType == this.currentJoinedFight.fightType && affmsg.allianceFightInfo.mapId == this.currentJoinedFight.mapId)
               {
                  this.currentJoinedFight = null;
               }
               SocialEntitiesManager.getInstance().removeFightingEntity(affmsg.allianceFightInfo.fightId,affmsg.allianceFightInfo.fightType);
               return true;
            case msg is AllianceFightPhaseUpdateMessage:
               afpumsg = msg as AllianceFightPhaseUpdateMessage;
               SocialEntitiesManager.getInstance().updatePhase(afpumsg.allianceFightInfo.fightId,afpumsg.allianceFightInfo.fightType,afpumsg.newPhase.phase,afpumsg.newPhase.phaseEndTimeStamp);
               return true;
            case msg is SocialFightJoinRequestAction:
               sfjra = msg as SocialFightJoinRequestAction;
               sfjrmsg = new SocialFightJoinRequestMessage();
               sfjrmsg.initSocialFightJoinRequestMessage(sfjra.fightInfo);
               ConnectionsHandler.getConnection().send(sfjrmsg);
               return true;
            case msg is SocialFightLeaveRequestAction:
               sflra = msg as SocialFightLeaveRequestAction;
               sflrmsg = new SocialFightLeaveRequestMessage();
               sflrmsg.initSocialFightLeaveRequestMessage(sflra.fightInfo);
               ConnectionsHandler.getConnection().send(sflrmsg);
               return true;
            case msg is SocialFightTakePlaceRequestAction:
               sftpra = msg as SocialFightTakePlaceRequestAction;
               sftprmsg = new SocialFightTakePlaceRequestMessage();
               sftprmsg.initSocialFightTakePlaceRequestMessage(sftpra.fightInfo,sftpra.playerId);
               ConnectionsHandler.getConnection().send(sftprmsg);
               return true;
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
                  if(!SocialEntitiesManager.getInstance().prisms[oldSubArea.id] && SocialEntitiesManager.getInstance().prisms[newSubArea.id])
                  {
                     prism = SocialEntitiesManager.getInstance().prisms[newSubArea.id];
                     if(prism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
                     {
                        KernelEventsManager.getInstance().processCallback(PrismHookList.KohState,prism);
                     }
                  }
                  if(SocialEntitiesManager.getInstance().prisms[oldSubArea.id] && !SocialEntitiesManager.getInstance().prisms[newSubArea.id])
                  {
                     oldPrism = SocialEntitiesManager.getInstance().prisms[oldSubArea.id];
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
               myAlliance = SocialFrame.getInstance().alliance;
               if(!myAlliance)
               {
                  return true;
               }
               this._alliancesOnTheHill = new Vector.<AllianceOnTheHillWrapper>();
               prismAlliance = this.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id).alliance;
               prismAllianceId = !!prismAlliance ? int(prismAlliance.allianceId) : int(myAlliance.groupId);
               myAllianceId = myAlliance.groupId;
               for each(allianceInfo in kumsg.kohAllianceInfo)
               {
                  if(allianceInfo.alliance.allianceId == prismAllianceId)
                  {
                     side = SIDE_DEFENDERS;
                  }
                  else if(allianceInfo.alliance.allianceId == myAllianceId)
                  {
                     side = SIDE_MINE;
                  }
                  else
                  {
                     side = SIDE_ATTACKERS;
                  }
                  allianceOnTheHill = AllianceOnTheHillWrapper.create(allianceInfo.alliance,allianceInfo.memberCount,allianceInfo.kohAllianceRoleMembers,allianceInfo.scores,allianceInfo.matchDominationScores,side);
                  this._alliancesOnTheHill.push(allianceOnTheHill);
               }
               this._startingAvaTimestamp = kumsg.startingAvaTimestamp;
               this._kohNextTick = kumsg.nextTickTime;
               KernelEventsManager.getInstance().processCallback(AlignmentHookList.KohUpdate,this._alliancesOnTheHill,kumsg.nextTickTime,kumsg.startingAvaTimestamp);
               return true;
               break;
            case msg is KothEndMessage:
               kem = msg as KothEndMessage;
               KernelEventsManager.getInstance().processCallback(AlignmentHookList.KohEnd,kem.winner);
               return true;
            case msg is PrismAttackRequestAction:
               pbrqmsg = new PrismAttackRequestMessage();
               pbrqmsg.initPrismAttackRequestMessage();
               ConnectionsHandler.getConnection().send(pbrqmsg);
               return true;
            case msg is PrismTeleportRequestAction:
               purmsg = new PrismTeleportationRequestMessage();
               purmsg.initPrismTeleportationRequestMessage();
               ConnectionsHandler.getConnection().send(purmsg);
               return true;
            case msg is PrismExchangeRequestAction:
               pmermsg = new PrismExchangeRequestMessage();
               pmermsg.initPrismExchangeRequestMessage();
               ConnectionsHandler.getConnection().send(pmermsg);
               return true;
            case msg is PrismRecycleTradeRequestAction:
               prtra = msg as PrismRecycleTradeRequestAction;
               prtrm = new PrismRecycleTradeRequestMessage();
               prtrm.initPrismRecycleTradeRequestMessage();
               ConnectionsHandler.getConnection().send(prtrm);
               return true;
            case msg is PrismAttackedMessage:
               pam = msg as PrismAttackedMessage;
               prismSubArea = SocialEntitiesManager.getInstance().prisms[pam.prism.subAreaId];
               textToDispatch = I18n.getUiText("ui.prism.attacked",[prismSubArea.subAreaName,prismSubArea.worldX + "," + prismSubArea.worldY]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,HyperlinkSocialManager.getLink(DataEnum.SOCIAL_TAB_ALLIANCE_ID,DataEnum.ALLIANCE_TAB_FIGHTS_ID,[DataEnum.ALLIANCE_FIGHT_TYPE_PRISM,prismSubArea.subAreaId],textToDispatch),ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.PRISM_ATTACK))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.PRISM_ATTACK,[prismSubArea.subAreaName,prismSubArea.worldX + "," + prismSubArea.worldY]);
               }
               if(OptionManager.getOptionManager("dofus").getOption("warnOnAllianceItemAgression"))
               {
                  notifId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.prism.attackedNotificationTitle"),I18n.getUiText("ui.prism.attackedNotification",[SubArea.getSubAreaById(prismSubArea.subAreaId).name,prismSubArea.worldX + "," + prismSubArea.worldY]),NotificationTypeEnum.INVITATION,"PrismAttacked");
                  openSocialArgs = [DataEnum.SOCIAL_TAB_ALLIANCE_ID,DataEnum.ALLIANCE_TAB_FIGHTS_ID,[DataEnum.ALLIANCE_FIGHT_TYPE_PRISM,prismSubArea.subAreaId]];
                  NotificationManager.getInstance().addButtonToNotification(notifId,I18n.getUiText("ui.common.join"),"OpenSocial",openSocialArgs,false,200,0,"hook");
                  NotificationManager.getInstance().sendNotification(notifId);
               }
               return true;
            case msg is PrismAttackResultMessage:
               parm = msg as PrismAttackResultMessage;
               prismAttackResultSubArea = SocialEntitiesManager.getInstance().prisms[parm.prism.subAreaId];
               if(parm.result == PrismAttackResultEnum.DEFENDERS_WIN)
               {
                  prismAttackResultText = I18n.getUiText("ui.prism.notDefeated",[prismAttackResultSubArea.subAreaName,prismAttackResultSubArea.worldX + "," + prismAttackResultSubArea.worldY]);
               }
               else if(parm.result == PrismAttackResultEnum.ATTACKERS_WIN)
               {
                  prismAttackResultText = I18n.getUiText("ui.prism.weakened",[prismAttackResultSubArea.subAreaName,prismAttackResultSubArea.worldX + "," + prismAttackResultSubArea.worldY]);
               }
               if(prismAttackResultText)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,prismAttackResultText,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is PrismAddOrUpdateMessage:
               paoumsg = msg as PrismAddOrUpdateMessage;
               prismUpdated = paoumsg.prism;
               SocialEntitiesManager.getInstance().addOrUpdatePrism(prismUpdated);
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismAddOrUpdate,prismUpdated.subAreaId);
               return true;
            case msg is PrismsListMessage:
               plmsg = msg as PrismsListMessage;
               prismsList = new Vector.<uint>();
               for each(prismGeo in plmsg.prisms)
               {
                  SocialEntitiesManager.getInstance().addOrUpdatePrism(prismGeo);
                  prismsList.push(prismGeo.subAreaId);
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsMultipleUpdate,prismsList);
               return true;
            case msg is PrismRemoveMessage:
               prmsg = msg as PrismRemoveMessage;
               SocialEntitiesManager.getInstance().removePrism(prmsg.prism.subAreaId);
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismRemoved,prmsg.prism.subAreaId);
               return true;
            case msg is AlliancePrismDialogQuestionMessage:
               KernelEventsManager.getInstance().processCallback(SocialHookList.AlliancePrismDialogQuestion);
               return true;
            case msg is TaxCollectorAttackedMessage:
               tcamsg = msg as TaxCollectorAttackedMessage;
               worldX = tcamsg.worldX;
               worldY = tcamsg.worldY;
               taxCollectorN = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcamsg.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcamsg.lastNameId).name;
               sentenceToDisplatch = I18n.getUiText("ui.alliance.taxCollectorAttackedChat",[taxCollectorN,worldX + "," + worldY,SubArea.getSubAreaById(tcamsg.subAreaId).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,HyperlinkSocialManager.getLink(DataEnum.SOCIAL_TAB_ALLIANCE_ID,DataEnum.ALLIANCE_TAB_FIGHTS_ID,[DataEnum.ALLIANCE_FIGHT_TYPE_PRISM,tcamsg.mapId],sentenceToDisplatch),ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK,[taxCollectorN,worldX,worldY]);
               }
               if(OptionManager.getOptionManager("dofus").getOption("warnOnAllianceItemAgression"))
               {
                  suba = SubArea.getSubAreaById(tcamsg.subAreaId);
                  nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.alliance.taxCollectorAttackedTipTitle"),I18n.getUiText("ui.alliance.taxCollectorAttackedTip",[suba.name,worldX + "," + worldY]),NotificationTypeEnum.INVITATION,"TaxCollectorAttacked");
                  openSocialParams = [DataEnum.SOCIAL_TAB_ALLIANCE_ID,DataEnum.ALLIANCE_TAB_FIGHTS_ID,[DataEnum.ALLIANCE_FIGHT_TYPE_TAXCOLLECTOR,tcamsg.mapId]];
                  NotificationManager.getInstance().addButtonToNotification(nid,I18n.getUiText("ui.common.join"),"OpenSocial",openSocialParams,true,200,0,"hook");
                  NotificationManager.getInstance().sendNotification(nid);
               }
               return true;
            case msg is TaxCollectorAttackedResultMessage:
               tcarmsg = msg as TaxCollectorAttackedResultMessage;
               taxCName = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcarmsg.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcarmsg.basicInfos.lastNameId).name;
               pointAttacked = new WorldPointWrapper(tcarmsg.basicInfos.mapId,true,tcarmsg.basicInfos.worldX,tcarmsg.basicInfos.worldY);
               worldPosX = pointAttacked.outdoorX;
               worldPosY = pointAttacked.outdoorY;
               if(tcarmsg.deadOrAlive)
               {
                  sentenceToDisplatchResultAttack = I18n.getUiText("ui.alliance.taxCollectorDied",[taxCName,worldPosX + "," + worldPosY]);
               }
               else
               {
                  sentenceToDisplatchResultAttack = I18n.getUiText("ui.alliance.taxCollectorSurvived",[taxCName,worldPosX + "," + worldPosY]);
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentenceToDisplatchResultAttack,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is TaxCollectorErrorMessage:
               tcemsg = msg as TaxCollectorErrorMessage;
               errorTaxCollectorMessage = "";
               switch(tcemsg.reason)
               {
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ALREADY_ONE:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.alreadyTaxCollectorOnMap");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_HERE:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.cantHireTaxCollecotrHere");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_YET:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.cantHireTaxcollectorTooTired");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ERROR_UNKNOWN:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.unknownErrorTaxCollector");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_MAX_REACHED:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.cantHireMaxTaxCollector");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NO_RIGHTS:
                     errorTaxCollectorMessage = I18n.getUiText("ui.alliance.taxCollectorNoRights");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_ENOUGH_KAMAS:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.notEnougthRichToHireTaxCollector");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_FOUND:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.taxCollectorNotFound");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_OWNED:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.notYourTaxcollector");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorTaxCollectorMessage,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is TaxCollectorHarvestedMessage:
               tchmsg = msg as TaxCollectorHarvestedMessage;
               this.taxCollectorChatMessage(SocialEntitiesManager.getInstance().taxCollectors[tchmsg.taxCollectorId] as TaxCollectorWrapper,TaxCollectorMovementTypeEnum.TAX_COLLECTOR_HARVESTED,tchmsg.harvesterId,tchmsg.harvesterName);
               return true;
            case msg is TaxCollectorStateUpdateMessage:
               tcsumsg = msg as TaxCollectorStateUpdateMessage;
               if(SocialEntitiesManager.getInstance().taxCollectors[tcsumsg.uniqueId])
               {
                  if(SocialEntitiesManager.getInstance().taxCollectors[tcsumsg.uniqueId].state == 1 && tcsumsg.state != 0)
                  {
                     NotificationManager.getInstance().closeNotification("TaxCollectorAttacked");
                  }
                  SocialEntitiesManager.getInstance().taxCollectors[tcsumsg.uniqueId].state = tcsumsg.state;
               }
               return true;
            case msg is TaxCollectorMovementsOfflineMessage:
               tcmomsg = msg as TaxCollectorMovementsOfflineMessage;
               tcHarvestedNamesList = "";
               tcDefeatedNamesList = "";
               harvestedNumber = 0;
               defeatedNumber = 0;
               for each(tcm in tcmomsg.movements)
               {
                  tcOffName = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcm.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcm.basicInfos.lastNameId).name;
                  tcOffPoint = new WorldPointWrapper(tcm.basicInfos.mapId,true,tcm.basicInfos.worldX,tcm.basicInfos.worldY);
                  tcOffWorldMapId = SubArea.getSubAreaByMapId(tcm.basicInfos.mapId).worldmap.id;
                  tcOffMapLink = HyperlinkMapPosition.getLink(tcOffPoint.outdoorX,tcOffPoint.outdoorY,tcOffWorldMapId);
                  if(tcm.movementType == TaxCollectorMovementTypeEnum.TAX_COLLECTOR_HARVESTED)
                  {
                     tcOffPlayerLink = "{player," + tcm.playerName + "," + tcm.playerId + "}";
                     tcHarvestedNamesList += I18n.getUiText("ui.guild.taxCollectorNameWithLocAndPlayer",[tcOffName,tcOffMapLink,tcOffPlayerLink]);
                     tcHarvestedNamesList += ", ";
                     harvestedNumber++;
                  }
                  else if(tcm.movementType == TaxCollectorMovementTypeEnum.TAX_COLLECTOR_DEFEATED)
                  {
                     tcDefeatedNamesList += I18n.getUiText("ui.guild.taxCollectorNameWithLoc",[tcOffName,tcOffMapLink]);
                     tcDefeatedNamesList += ", ";
                     defeatedNumber++;
                  }
               }
               if(harvestedNumber > 0)
               {
                  tcHarvestedNamesList = tcHarvestedNamesList.slice(0,tcHarvestedNamesList.length - 2);
                  if(harvestedNumber == 1)
                  {
                     sentenceToDisplatchDisappearances = I18n.getUiText("ui.guild.taxCollectorHarvestedWhileAbsence",[tcHarvestedNamesList]);
                  }
                  else
                  {
                     sentenceToDisplatchDisappearances = I18n.getUiText("ui.guild.taxCollectorsHarvestedWhileAbsence",[tcHarvestedNamesList]);
                  }
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentenceToDisplatchDisappearances,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               if(defeatedNumber > 0)
               {
                  tcDefeatedNamesList = tcDefeatedNamesList.slice(0,tcDefeatedNamesList.length - 2);
                  if(defeatedNumber == 1)
                  {
                     sentenceToDisplatchDisappearances = I18n.getUiText("ui.guild.taxCollectorDefeatedWhileAbsence",[tcDefeatedNamesList]);
                  }
                  else
                  {
                     sentenceToDisplatchDisappearances = I18n.getUiText("ui.guild.taxCollectorsDefeatedWhileAbsence",[tcDefeatedNamesList]);
                  }
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentenceToDisplatchDisappearances,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is TopTaxCollectorListMessage:
               ttclmsg = msg as TopTaxCollectorListMessage;
               this._dungeonTopTaxCollectors = ttclmsg.dungeonTaxCollectorsInformation;
               this._topTaxCollectors = ttclmsg.worldTaxCollectorsInformation;
               if(this._dungeonTopTaxCollectors && this._topTaxCollectors)
               {
                  dungeonTopTaxCollectors = new Vector.<TaxCollectorWrapper>(0);
                  worldTopTaxCollectors = new Vector.<TaxCollectorWrapper>(0);
                  for each(taxCollectorInfo in this._dungeonTopTaxCollectors)
                  {
                     dungeonTopTaxCollectors.push(TaxCollectorWrapper.create(taxCollectorInfo));
                  }
                  for each(taxCollectorInfo in this._topTaxCollectors)
                  {
                     worldTopTaxCollectors.push(TaxCollectorWrapper.create(taxCollectorInfo));
                  }
                  KernelEventsManager.getInstance().processCallback(SocialHookList.ShowTopTaxCollectors,dungeonTopTaxCollectors,worldTopTaxCollectors);
                  this._dungeonTopTaxCollectors = null;
                  this._topTaxCollectors = null;
               }
               return true;
            case msg is StartListenTaxCollectorUpdatesAction:
               sltcua = msg as StartListenTaxCollectorUpdatesAction;
               sltcum = new StartListenTaxCollectorUpdatesMessage();
               sltcum.initStartListenTaxCollectorUpdatesMessage(sltcua.uId);
               ConnectionsHandler.getConnection().send(sltcum);
               return true;
            case msg is StopListenTaxCollectorUpdatesAction:
               spltcua = msg as StopListenTaxCollectorUpdatesAction;
               spltcum = new StopListenTaxCollectorUpdatesMessage();
               spltcum.initStopListenTaxCollectorUpdatesMessage(spltcua.uId);
               ConnectionsHandler.getConnection().send(spltcum);
               return true;
            case msg is ConfirmationOfListeningTaxCollectorUpdatesMessage:
               coltcum = msg as ConfirmationOfListeningTaxCollectorUpdatesMessage;
               SocialEntitiesManager.getInstance().addTaxCollector(coltcum.information);
               StatsManager.getInstance().addRawStats(coltcum.information.uniqueId,coltcum.information.characteristics.characteristics);
               KernelEventsManager.getInstance().processCallback(SocialHookList.ConsultTaxCollector,coltcum.information);
               return true;
            case msg is TaxCollectorEquipmentUpdateMessage:
               tceum = msg as TaxCollectorEquipmentUpdateMessage;
               StatsManager.getInstance().addRawStats(tceum.uniqueId,tceum.characteristics.characteristics);
               tcw = SocialEntitiesManager.getInstance().taxCollectors[tceum.uniqueId];
               if(tcw)
               {
                  if(tceum.added)
                  {
                     tcw.addEquipment(tceum.object);
                  }
                  else
                  {
                     tcw.removeEquipment(tceum.object);
                  }
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorEquipmentUpdate,tceum.uniqueId,tceum.object,tceum.added,tceum.characteristics);
               return true;
            case msg is AddTaxCollectorOrderedSpellAction:
               atcosa = msg as AddTaxCollectorOrderedSpellAction;
               atcosm = new AddTaxCollectorOrderedSpellMessage();
               atcosm.initAddTaxCollectorOrderedSpellMessage(atcosa.taxCollectorId,atcosa.orderedSpell);
               ConnectionsHandler.getConnection().send(atcosm);
               return true;
            case msg is RemoveTaxCollectorOrderedSpellAction:
               rtcosa = msg as RemoveTaxCollectorOrderedSpellAction;
               rtcosm = new RemoveTaxCollectorOrderedSpellMessage();
               rtcosm.initRemoveTaxCollectorOrderedSpellMessage(rtcosa.taxCollectorId,rtcosa.slotId);
               ConnectionsHandler.getConnection().send(rtcosm);
               return true;
            case msg is TaxCollectorOrderedSpellUpdatedMessage:
               tcosum = msg as TaxCollectorOrderedSpellUpdatedMessage;
               tc = SocialEntitiesManager.getInstance().taxCollectors[tcosum.taxCollectorId];
               if(tc)
               {
                  tc.spells = tcosum.taxCollectorSpells.concat();
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorOrderedSpellUpdated,tcosum.taxCollectorId,tcosum.taxCollectorSpells);
               return true;
            case msg is MoveTaxCollectorOrderedSpellAction:
               mtcosa = msg as MoveTaxCollectorOrderedSpellAction;
               mtcosm = new MoveTaxCollectorOrderedSpellMessage();
               mtcosm.initMoveTaxCollectorOrderedSpellMessage(mtcosa.uId,mtcosa.movedFrom,mtcosa.movedTo);
               ConnectionsHandler.getConnection().send(mtcosm);
               return true;
            case msg is StartListenTaxCollectorPresetsUpdatesAction:
               sltcpum = new StartListenTaxCollectorPresetsUpdatesMessage();
               sltcpum.initStartListenTaxCollectorPresetsUpdatesMessage();
               ConnectionsHandler.getConnection().send(sltcpum);
               return true;
            case msg is StopListenTaxCollectorPresetsUpdatesAction:
               spltcpum = new StopListenTaxCollectorPresetsUpdatesMessage();
               spltcpum.initStopListenTaxCollectorPresetsUpdatesMessage();
               ConnectionsHandler.getConnection().send(spltcpum);
               return true;
            case msg is AddTaxCollectorPresetSpellAction:
               atcpsa = msg as AddTaxCollectorPresetSpellAction;
               atcpsm = new AddTaxCollectorPresetSpellMessage();
               atcpsm.initAddTaxCollectorPresetSpellMessage(atcpsa.presetId,atcpsa.orderedSpell);
               ConnectionsHandler.getConnection().send(atcpsm);
               return true;
            case msg is TaxCollectorPresetSpellUpdatedMessage:
               tcpsum = msg as TaxCollectorPresetSpellUpdatedMessage;
               alliance = SocialFrame.getInstance().alliance;
               if(alliance)
               {
                  for(index = 0; index < alliance.taxCollectorPresets.length; index++)
                  {
                     if(alliance.taxCollectorPresets[index].presetId.uuidString == tcpsum.presetId.uuidString)
                     {
                        taxCollectorPreset = new TaxCollectorPreset();
                        taxCollectorPreset.presetId = tcpsum.presetId;
                        taxCollectorPreset.spells = tcpsum.taxCollectorSpells;
                        alliance.taxCollectorPresets[index] = taxCollectorPreset;
                        break;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorPresetSpellUpdated,tcpsum.presetId,tcpsum.taxCollectorSpells);
               return true;
            case msg is RemoveTaxCollectorPresetSpellAction:
               rtcpsa = msg as RemoveTaxCollectorPresetSpellAction;
               rtcpsm = new RemoveTaxCollectorPresetSpellMessage();
               rtcpsm.initRemoveTaxCollectorPresetSpellMessage(rtcpsa.presetId,rtcpsa.slotId);
               ConnectionsHandler.getConnection().send(rtcpsm);
               return true;
            case msg is MoveTaxCollectorPresetSpellAction:
               mtcpsa = msg as MoveTaxCollectorPresetSpellAction;
               mtcpsm = new MoveTaxCollectorPresetSpellMessage();
               mtcpsm.initMoveTaxCollectorPresetSpellMessage(mtcpsa.presetId,mtcpsa.moveFrom,mtcpsa.moveTo);
               ConnectionsHandler.getConnection().send(mtcpsm);
               return true;
            case msg is TaxCollectorPresetsMessage:
               tcpsm = msg as TaxCollectorPresetsMessage;
               playerAlliance = SocialFrame.getInstance().alliance;
               if(playerAlliance)
               {
                  playerAlliance.taxCollectorPresets = tcpsm.presets;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorPresets,tcpsm.presets);
               return true;
            case msg is ExchangeTaxCollectorGetMessage:
               etcgmsg = msg as ExchangeTaxCollectorGetMessage;
               totalQuantity = 0;
               for each(taxCollectorObjet in etcgmsg.objectsInfos)
               {
                  totalQuantity += taxCollectorObjet.quantity;
               }
               idFName = SocialEntitiesManager.getInstance().getTaxCollectorNameId(etcgmsg.collectorName,0);
               idName = SocialEntitiesManager.getInstance().getTaxCollectorNameId(etcgmsg.collectorName,1);
               collectedTaxCollectors = SocialEntitiesManager.getInstance().collectedTaxCollectors;
               taxCollectorWrapper = new TaxCollectorWrapper();
               taxCollectorWrapper.uniqueId = etcgmsg.mapId;
               taxCollectorWrapper.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(idFName).firstname;
               taxCollectorWrapper.lastName = TaxCollectorName.getTaxCollectorNameById(idName).name;
               taxCollectorWrapper.mapWorldX = etcgmsg.worldX;
               taxCollectorWrapper.mapWorldY = etcgmsg.worldY;
               taxCollectorWrapper.subareaId = etcgmsg.subAreaId;
               taxCollectorWrapper.collectedItems = etcgmsg.objectsInfos;
               taxCollectorWrapper.pods = etcgmsg.pods;
               taxCollectorWrapper.callerId = etcgmsg.callerId;
               taxCollectorWrapper.callerName = etcgmsg.callerName;
               taxCollectorWrapper.entityLook = etcgmsg.look;
               taxCollectorWrapper.tiphonEntityLook = EntityLookAdapter.fromNetwork(etcgmsg.look);
               collectedTaxCollectors[taxCollectorWrapper.uniqueId] = taxCollectorWrapper;
               taxcollectorCollectedMsg = "{taxcollectorCollected," + taxCollectorWrapper.uniqueId + "::" + PatternDecoder.combine(I18n.getUiText("ui.alliance.taxCollector.collected",[etcgmsg.userName,totalQuantity]),"n",totalQuantity <= 1,totalQuantity == 0) + "}";
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,taxcollectorCollectedMsg,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp(),false);
               return true;
            case msg is TaxCollectorDialogQuestionExtendedMessage:
               tcdqemsg = msg as TaxCollectorDialogQuestionExtendedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionExtended,tcdqemsg.maxPods,tcdqemsg.prospecting,tcdqemsg.taxCollectorsCount,tcdqemsg.taxCollectorAttack,tcdqemsg.pods,tcdqemsg.itemsValue,tcdqemsg.alliance);
               return true;
            case msg is TaxCollectorDialogQuestionBasicMessage:
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionBasic);
               return true;
            case msg is StartListenNuggetsAction:
               slnmsg = new StartListenNuggetsMessage();
               slnmsg.initStartListenNuggetsMessage();
               ConnectionsHandler.getConnection().send(slnmsg);
               return true;
            case msg is StopListenNuggetsAction:
               stlnmsg = new StopListenNuggetsMessage();
               stlnmsg.initStopListenNuggetsMessage();
               ConnectionsHandler.getConnection().send(stlnmsg);
               return true;
            case msg is NuggetsInformationMessage:
               nimsg = msg as NuggetsInformationMessage;
               this._nuggetsBalance = nimsg.nuggetsQuantity;
               KernelEventsManager.getInstance().processCallback(SocialHookList.NuggetsInformation);
               return true;
            case msg is NuggetDistributionAction:
               nda = msg as NuggetDistributionAction;
               ndmsg = new NuggetsDistributionMessage();
               ndmsg.initNuggetsDistributionMessage(Vector.<NuggetsBeneficiary>(nda.beneficiaries));
               ConnectionsHandler.getConnection().send(ndmsg);
               return true;
         }
         return false;
      }
      
      private function taxCollectorChatMessage(tcInfos:TaxCollectorWrapper, pType:int, playerId:uint, playerName:String) : void
      {
         var infoText:String = null;
         var taxCollectorName:String = tcInfos.firstName + " " + tcInfos.lastName;
         var worldMapId:int = SubArea.getSubAreaByMapId(tcInfos.uniqueId).worldmap.id;
         var playerLink:* = "{player," + playerName + "," + playerId + "}";
         var mapLink:String = HyperlinkMapPosition.getLink(tcInfos.mapWorldX,tcInfos.mapWorldY,worldMapId,I18n.getUiText("ui.alliance.taxCollector",[tcInfos.alliance.groupName + " [" + tcInfos.alliance.allianceTag + "]"]),"[" + tcInfos.mapWorldX + "," + tcInfos.mapWorldY + "]");
         switch(pType)
         {
            case TaxCollectorMovementTypeEnum.TAX_COLLECTOR_HIRED:
               infoText = I18n.getUiText("ui.alliance.taxCollectorAdded",[taxCollectorName,mapLink,playerLink]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,infoText,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               break;
            case TaxCollectorMovementTypeEnum.TAX_COLLECTOR_HARVESTED:
               infoText = I18n.getUiText("ui.alliance.taxCollectorRemoved",[taxCollectorName,mapLink,playerLink]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,infoText,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
         }
      }
   }
}
