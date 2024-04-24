package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.data.DefaultMap;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.atouin.messages.MapLoadingFailedMessage;
   import com.ankamagames.atouin.messages.MapsLoadingCompleteMessage;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.houses.HavenbagTheme;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.PaddockWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.actions.InteractiveElementActivationAction;
   import com.ankamagames.dofus.logic.game.common.actions.PivotCharacterAction;
   import com.ankamagames.dofus.logic.game.common.actions.ToggleShowUIAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.LeaveBidHouseAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangePlayerMultiCraftRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRequestOnTaxCollectorAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.StartExchangeTaxCollectorEquipmentAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.LeaveExchangeMountAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.PortalUseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.GameRolePlayFreeSoulRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.GameRolePlayTaxCollectorFightRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.ExchangeBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.ExchangeSellAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.ExchangeShopStockMouvmentRemoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.ExchangeShopStockMovementAddAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.LeaveShopStockAction;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.frames.BidHouseManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.frames.CommonExchangeManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.CraftFrame;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ExchangeManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SpectatorManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.StackManagementFrame;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.SocialEntitiesManager;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.misc.SpellCastSequence;
   import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DisplayContextualMenuAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcGenericActionRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightFriendlyAnswerAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagEnterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagInvitePlayerAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagInvitePlayerAnswerAction;
   import com.ankamagames.dofus.logic.game.roleplay.managers.MountAutoTripManager;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.misc.utils.SurveyManager;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.ExchangeErrorEnum;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.network.enums.FighterRefusedReasonEnum;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.network.enums.MountCharacteristicEnum;
   import com.ankamagames.dofus.network.messages.game.collector.tax.GameRolePlayTaxCollectorFightRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.display.DisplayNumericalValuePaddockMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapInstanceMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.ErrorMapNotFoundMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.death.GameRolePlayFreeSoulRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.document.DocumentReadingBeginMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayAggressionMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayFightRequestCanceledMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayPlayerFightFriendlyAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayPlayerFightFriendlyAnsweredMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayPlayerFightFriendlyRequestedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayPlayerFightRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.EnterHavenBagRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.KickHavenBagRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting.InviteInHavenBagClosedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting.InviteInHavenBagMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting.InviteInHavenBagOfferMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting.TeleportHavenBagAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting.TeleportHavenBagRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobAllowMultiCraftRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobMultiCraftAvailableSkillsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.ListMapNpcsQuestStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcDialogCreationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcGenericActionFailureMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcGenericActionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.PortalDialogCreationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockPropertiesMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockSellBuyDialogMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.PortalUseRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.visual.GameRolePlaySpellAnimMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.ChallengeFightJoinRefusedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.TeleportDestinationsMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.ZaapDestinationsMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBuyMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBuyOkMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeErrorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMovePricedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOkMultiCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangePlayerMultiCraftRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangePlayerRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestOnTaxCollectorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestedTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeSellMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeSellOkMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkCraftWithInformationMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcShopMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkRecycleTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkRunesTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidBuyerMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidSellerMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedMountStockMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedTaxCollectorEquipmentMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedTaxCollectorShopMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.StartExchangeTaxCollectorEquipmentMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObtainedItemMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObtainedItemWithBonusMessage;
   import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
   import com.ankamagames.dofus.scripts.SpellScriptContext;
   import com.ankamagames.dofus.scripts.SpellScriptManager;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextualManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.utils.display.AngleToOrientation;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   
   public class RoleplayContextFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayContextFrame));
      
      private static const MOUNT_BOOSTS_ICONS_PATH:String = XmlConfig.getInstance().getEntry("config.content.path") + "gfx/characteristics/mount.swf|";
      
      private static var FORGETTABLE_SPELLS_UI:String = "forgettableSpellsUi";
      
      private static var FORGETTABLE_MODSTERS_UI:String = "forgettableModstersUi";
       
      
      private var _priority:int = 0;
      
      private var _entitiesFrame:RoleplayEntitiesFrame;
      
      private var _worldFrame:RoleplayWorldFrame;
      
      private var _interactivesFrame:RoleplayInteractivesFrame;
      
      private var _npcDialogFrame:NpcDialogFrame;
      
      private var _documentFrame:DocumentFrame;
      
      private var _zaapFrame:ZaapFrame;
      
      private var _paddockFrame:PaddockFrame;
      
      private var _emoticonFrame:EmoticonFrame;
      
      private var _exchangeManagementFrame:ExchangeManagementFrame;
      
      private var _spectatorManagementFrame:SpectatorManagementFrame;
      
      private var _bidHouseManagementFrame:BidHouseManagementFrame;
      
      private var _estateFrame:EstateFrame;
      
      private var _allianceFrame:AllianceFrame;
      
      private var _craftFrame:CraftFrame;
      
      private var _commonExchangeFrame:CommonExchangeManagementFrame;
      
      private var _movementFrame:RoleplayMovementFrame;
      
      private var _delayedActionFrame:DelayedActionFrame;
      
      private var _currentWaitingFightId:uint;
      
      private var _crafterId:Number;
      
      private var _customerID:Number;
      
      private var _playersMultiCraftSkill:Array;
      
      private var _currentPaddock:PaddockWrapper;
      
      private var _playerEntity:AnimatedCharacter;
      
      private var _interactionIsLimited:Boolean = false;
      
      private var _previousMapId:Number = 0;
      
      private var _newCurrentMapIsReceived:Boolean = false;
      
      private var _obtainedItemMsg:ObtainedItemMessage;
      
      private var _itemIcon:Texture;
      
      private var _itemBonusIcon:Texture;
      
      private var _obtainedItemTextFormat:TextFormat;
      
      private var _obtainedItemBonusTextFormat:TextFormat;
      
      private var _mountBoosTextFormat:TextFormat;
      
      private var _listMapNpcsMsg:ListMapNpcsQuestStatusUpdateMessage;
      
      public function RoleplayContextFrame()
      {
         super();
      }
      
      public function get crafterId() : Number
      {
         return this._crafterId;
      }
      
      public function get customerID() : Number
      {
         return this._customerID;
      }
      
      public function get priority() : int
      {
         return this._priority;
      }
      
      public function set priority(p:int) : void
      {
         this._priority = p;
      }
      
      public function get entitiesFrame() : RoleplayEntitiesFrame
      {
         return this._entitiesFrame;
      }
      
      private function get socialFrame() : SocialFrame
      {
         return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
      }
      
      public function get hasWorldInteraction() : Boolean
      {
         return !this._interactionIsLimited;
      }
      
      public function get commonExchangeFrame() : CommonExchangeManagementFrame
      {
         return this._commonExchangeFrame;
      }
      
      public function get currentPaddock() : PaddockWrapper
      {
         return this._currentPaddock;
      }
      
      public function get previousMapId() : Number
      {
         return this._previousMapId;
      }
      
      public function get newCurrentMapIsReceived() : Boolean
      {
         return this._newCurrentMapIsReceived;
      }
      
      public function set newCurrentMapIsReceived(value:Boolean) : void
      {
         this._newCurrentMapIsReceived = value;
      }
      
      public function pushed() : Boolean
      {
         this._entitiesFrame = new RoleplayEntitiesFrame();
         this._delayedActionFrame = new DelayedActionFrame();
         this._movementFrame = new RoleplayMovementFrame();
         this._worldFrame = new RoleplayWorldFrame();
         this._interactivesFrame = new RoleplayInteractivesFrame();
         Kernel.getWorker().addFrame(this._delayedActionFrame);
         this._npcDialogFrame = new NpcDialogFrame();
         this._documentFrame = new DocumentFrame();
         this._zaapFrame = new ZaapFrame();
         this._paddockFrame = new PaddockFrame();
         this._exchangeManagementFrame = new ExchangeManagementFrame();
         this._spectatorManagementFrame = new SpectatorManagementFrame();
         this._bidHouseManagementFrame = new BidHouseManagementFrame();
         this._estateFrame = new EstateFrame();
         this._craftFrame = new CraftFrame();
         Kernel.getWorker().addFrame(this._spectatorManagementFrame);
         if(!Kernel.getWorker().contains(EstateFrame))
         {
            Kernel.getWorker().addFrame(this._estateFrame);
         }
         this._allianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         if(!Kernel.getWorker().contains(EmoticonFrame))
         {
            this._emoticonFrame = new EmoticonFrame();
            Kernel.getWorker().addFrame(this._emoticonFrame);
         }
         else
         {
            this._emoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
         }
         this._playersMultiCraftSkill = new Array();
         this._obtainedItemTextFormat = new TextFormat("Verdana",24,7615756,true);
         this._obtainedItemBonusTextFormat = new TextFormat("Verdana",24,16733440,true);
         this._itemIcon = new Texture();
         this._itemBonusIcon = new Texture();
         var itemIconFilter:GlowFilter = new GlowFilter(0,1,2,2,2,1);
         this._itemIcon.filters = [itemIconFilter];
         this._itemBonusIcon.filters = [itemIconFilter];
         this._mountBoosTextFormat = new TextFormat("Verdana",24,7615756,true);
         var stackFrame:StackManagementFrame = Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame;
         stackFrame.paused = false;
         new ToggleShowUIAction().unhide();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var message:String = null;
         var playerId:Number = NaN;
         var mcmsg:CurrentMapMessage = null;
         var newSubArea:SubArea = null;
         var wp:WorldPointWrapper = null;
         var commonMod:Object = null;
         var questFrame:QuestFrame = null;
         var mlcm:MapsLoadingCompleteMessage = null;
         var cwiamsg:ChangeWorldInteractionAction = null;
         var bidHouseSwitch:Boolean = false;
         var stackFrame:StackManagementFrame = null;
         var ngara:NpcGenericActionRequestAction = null;
         var playerEntity:IEntity = null;
         var ngarmsg:NpcGenericActionRequestMessage = null;
         var erotca:ExchangeRequestOnTaxCollectorAction = null;
         var erotcmsg:ExchangeRequestOnTaxCollectorMessage = null;
         var playerEntity4:IEntity = null;
         var grptcfrmsg:GameRolePlayTaxCollectorFightRequestMessage = null;
         var ieaa:InteractiveElementActivationAction = null;
         var ieamsg:InteractiveElementActivationMessage = null;
         var dcma:DisplayContextualMenuAction = null;
         var entityInfo:GameContextActorInformations = null;
         var roleplayInteractivesFrame:RoleplayInteractivesFrame = null;
         var ndcmsg:NpcDialogCreationMessage = null;
         var entityNpcLike:Object = null;
         var pura:PortalUseRequestAction = null;
         var purmsg:PortalUseRequestMessage = null;
         var esmsmsg:ExchangeStartedMountStockMessage = null;
         var estcsm:ExchangeStartedTaxCollectorShopMessage = null;
         var setcea:StartExchangeTaxCollectorEquipmentAction = null;
         var setcem:StartExchangeTaxCollectorEquipmentMessage = null;
         var estcem:ExchangeStartedTaxCollectorEquipmentMessage = null;
         var esonmsg:ExchangeStartOkNpcShopMessage = null;
         var esmsg:ExchangeStartedMessage = null;
         var commonExchangeFrame:CommonExchangeManagementFrame = null;
         var oimsg:ObtainedItemMessage = null;
         var interactiveFrame:RoleplayInteractivesFrame = null;
         var player:AnimatedCharacter = null;
         var animTimer:BenchmarkTimer = null;
         var pfra:PlayerFightRequestAction = null;
         var gppfrm:GameRolePlayPlayerFightRequestMessage = null;
         var playerEntity2:IEntity = null;
         var pffaa:PlayerFightFriendlyAnswerAction = null;
         var grppffam:GameRolePlayPlayerFightFriendlyAnsweredMessage = null;
         var grpfrcm:GameRolePlayFightRequestCanceledMessage = null;
         var grppffrm:GameRolePlayPlayerFightFriendlyRequestedMessage = null;
         var grpfsrmmsg:GameRolePlayFreeSoulRequestMessage = null;
         var ldrbidHousemsg:LeaveDialogRequestMessage = null;
         var ermsg:ExchangeErrorMessage = null;
         var errorMessage:String = null;
         var channelId:uint = 0;
         var grpamsg:GameRolePlayAggressionMessage = null;
         var ldrmsg:LeaveDialogRequestMessage = null;
         var essmaa:ExchangeShopStockMovementAddAction = null;
         var eompmsg:ExchangeObjectMovePricedMessage = null;
         var essmra:ExchangeShopStockMouvmentRemoveAction = null;
         var eommsg:ExchangeObjectMoveMessage = null;
         var eba:ExchangeBuyAction = null;
         var ebmsg:ExchangeBuyMessage = null;
         var esa:ExchangeSellAction = null;
         var eslmsg:ExchangeSellMessage = null;
         var ebomsg:ExchangeBuyOkMessage = null;
         var esomsg:ExchangeSellOkMessage = null;
         var epra:ExchangePlayerRequestAction = null;
         var eprmsg:ExchangePlayerRequestMessage = null;
         var epmcra:ExchangePlayerMultiCraftRequestAction = null;
         var epmcrmsg:ExchangePlayerMultiCraftRequestMessage = null;
         var jamcrmsg:JobAllowMultiCraftRequestMessage = null;
         var messId:uint = 0;
         var cfjrmsg:ChallengeFightJoinRefusedMessage = null;
         var drbm:DocumentReadingBeginMessage = null;
         var psbdmsg:PaddockSellBuyDialogMessage = null;
         var ldrmsg2:LeaveDialogRequestMessage = null;
         var dnvpmsg:DisplayNumericalValuePaddockMessage = null;
         var mount:IEntity = null;
         var grpsamsg:GameRolePlaySpellAnimMessage = null;
         var context:SpellCastSequenceContext = null;
         var castSequence:SpellCastSequence = null;
         var contexts:Vector.<SpellScriptContext> = null;
         var hea:HavenbagEnterAction = null;
         var enterhbrmsg:EnterHavenBagRequestMessage = null;
         var hipa:HavenbagInvitePlayerAction = null;
         var hipaa:HavenbagInvitePlayerAnswerAction = null;
         var thbamsg:TeleportHavenBagAnswerMessage = null;
         var iihbomsg:InviteInHavenBagOfferMessage = null;
         var notifyUser:Boolean = false;
         var tihbomsgNid:uint = 0;
         var iihbmsg:InviteInHavenBagMessage = null;
         var iihbcmsg:InviteInHavenBagClosedMessage = null;
         var tsuia:ToggleShowUIAction = null;
         var commonMod2:Object = null;
         var emnfmsg:ErrorMapNotFoundMessage = null;
         var currentMapX:int = 0;
         var currentMapY:int = 0;
         var currentWorldId:int = 0;
         var virtualMap:Map = null;
         var menuResult:Boolean = false;
         var npcEntity:GameRolePlayNpcInformations = null;
         var npcLook:TiphonEntityLook = null;
         var ponyEntity:GameRolePlayTaxCollectorInformations = null;
         var prismEntity:GameRolePlayPrismInformations = null;
         var allianceName:String = null;
         var portalEntity:GameRolePlayPortalInformations = null;
         var portalType:uint = 0;
         var area:Area = null;
         var areaName:String = null;
         var ldrdcmsg:LeaveDialogRequestMessage = null;
         var bonusQty:uint = 0;
         var infos:GameRolePlayCharacterInformations = null;
         var targetPlayerLevel:int = 0;
         var fightType:int = 0;
         var rcf:RoleplayContextFrame = null;
         var playerInfo:GameRolePlayActorInformations = null;
         var name:String = null;
         var gcai:GameContextActorInformations = null;
         var jmcasm:JobMultiCraftAvailableSkillsMessage = null;
         var mcefp:MultiCraftEnableForPlayer = null;
         var alreadyIn:Boolean = false;
         var mcefplayer:MultiCraftEnableForPlayer = null;
         var compt:uint = 0;
         var index:int = 0;
         var mountBoosIcon:Texture = null;
         var boostIconUri:Uri = null;
         var thbrmsg:TeleportHavenBagRequestMessage = null;
         var khbrqt:KickHavenBagRequestMessage = null;
         switch(true)
         {
            case msg is CurrentMapMessage:
               mcmsg = msg as CurrentMapMessage;
               this._newCurrentMapIsReceived = true;
               newSubArea = SubArea.getSubAreaByMapId(mcmsg.mapId);
               PlayedCharacterManager.getInstance().currentSubArea = newSubArea;
               Kernel.getWorker().pause(null,[SystemMessageDisplayMessage]);
               ConnectionsHandler.pause();
               if(mcmsg is CurrentMapInstanceMessage)
               {
                  MapDisplayManager.getInstance().mapInstanceId = (mcmsg as CurrentMapInstanceMessage).instantiatedMapId;
               }
               else
               {
                  MapDisplayManager.getInstance().mapInstanceId = 0;
               }
               if(TacticModeManager.getInstance().tacticModeActivated)
               {
                  TacticModeManager.getInstance().hide();
               }
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               wp = null;
               if(this._entitiesFrame && Kernel.getWorker().contains(RoleplayEntitiesFrame))
               {
                  Kernel.getWorker().removeFrame(this._entitiesFrame);
               }
               if(this._worldFrame && Kernel.getWorker().contains(RoleplayWorldFrame))
               {
                  Kernel.getWorker().removeFrame(this._worldFrame);
               }
               if(this._interactivesFrame && Kernel.getWorker().contains(RoleplayInteractivesFrame))
               {
                  Kernel.getWorker().removeFrame(this._interactivesFrame);
               }
               if(this._movementFrame && Kernel.getWorker().contains(RoleplayMovementFrame))
               {
                  Kernel.getWorker().removeFrame(this._movementFrame);
               }
               if(PlayedCharacterManager.getInstance().isInHouse)
               {
                  wp = new WorldPointWrapper(mcmsg.mapId,true,PlayedCharacterManager.getInstance().currentMap.outdoorX,PlayedCharacterManager.getInstance().currentMap.outdoorY);
               }
               else
               {
                  wp = new WorldPointWrapper(mcmsg.mapId);
               }
               if(PlayedCharacterManager.getInstance().currentMap)
               {
                  this._previousMapId = PlayedCharacterManager.getInstance().currentMap.mapId;
               }
               PlayedCharacterManager.getInstance().currentMap = wp;
               Atouin.getInstance().clearEntities();
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,0);
               Atouin.getInstance().display(wp,!HavenbagTheme.isMapIdInHavenbag(wp.mapId));
               TooltipManager.hideAll();
               commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
               commonMod.closeAllMenu();
               this._currentPaddock = null;
               questFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
               if(questFrame && questFrame.followedQuestsCallback)
               {
                  questFrame.followedQuestsCallback.exec();
               }
               KernelEventsManager.getInstance().processCallback(HookList.CurrentMap,mcmsg.mapId);
               return false;
            case msg is ListMapNpcsQuestStatusUpdateMessage:
               if(this._entitiesFrame && Kernel.getWorker().contains(RoleplayEntitiesFrame))
               {
                  this._listMapNpcsMsg = null;
                  return false;
               }
               this._listMapNpcsMsg = msg as ListMapNpcsQuestStatusUpdateMessage;
               return true;
               break;
            case msg is MapsLoadingCompleteMessage:
               mlcm = msg as MapsLoadingCompleteMessage;
               if(!Kernel.getWorker().contains(RoleplayEntitiesFrame))
               {
                  Kernel.getWorker().addFrame(this._entitiesFrame);
               }
               TooltipManager.hideAll();
               KernelEventsManager.getInstance().processCallback(HookList.MapsLoadingComplete,mlcm.mapPoint);
               if(!Kernel.getWorker().contains(RoleplayWorldFrame))
               {
                  Kernel.getWorker().addFrame(this._worldFrame);
               }
               if(!Kernel.getWorker().contains(RoleplayInteractivesFrame))
               {
                  Kernel.getWorker().addFrame(this._interactivesFrame);
               }
               if(!Kernel.getWorker().contains(RoleplayMovementFrame))
               {
                  Kernel.getWorker().addFrame(this._movementFrame);
               }
               SoundManager.getInstance().manager.setSubArea(mlcm.mapData);
               Atouin.getInstance().updateCursor();
               Kernel.getWorker().resume();
               Kernel.getWorker().clearUnstoppableMsgClassList();
               ConnectionsHandler.resume();
               SurveyManager.getInstance().checkSurveys();
               if(this._listMapNpcsMsg)
               {
                  Kernel.getWorker().process(this._listMapNpcsMsg);
                  this._listMapNpcsMsg = null;
               }
               return true;
            case msg is MapLoadingFailedMessage:
               switch(MapLoadingFailedMessage(msg).errorReason)
               {
                  case MapLoadingFailedMessage.NO_FILE:
                     commonMod2 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                     commonMod2.openPopup(I18n.getUiText("ui.popup.information"),I18n.getUiText("ui.popup.noMapdataFile"),[I18n.getUiText("ui.common.ok")]);
                     emnfmsg = new ErrorMapNotFoundMessage();
                     emnfmsg.initErrorMapNotFoundMessage(MapLoadingFailedMessage(msg).id);
                     ConnectionsHandler.getConnection().send(emnfmsg);
                     MapDisplayManager.getInstance().fromMap(new DefaultMap(MapLoadingFailedMessage(msg).id));
                     return true;
                  default:
                     return false;
               }
               break;
            case msg is MapLoadedMessage:
               if(MapDisplayManager.getInstance().isDefaultMap)
               {
                  currentMapX = PlayedCharacterManager.getInstance().currentMap.x;
                  currentMapY = PlayedCharacterManager.getInstance().currentMap.y;
                  currentWorldId = PlayedCharacterManager.getInstance().currentMap.worldId;
                  virtualMap = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
                  virtualMap.rightNeighbourId = WorldPoint.fromCoords(currentWorldId,currentMapX + 1,currentMapY).mapId;
                  virtualMap.leftNeighbourId = WorldPoint.fromCoords(currentWorldId,currentMapX - 1,currentMapY).mapId;
                  virtualMap.bottomNeighbourId = WorldPoint.fromCoords(currentWorldId,currentMapX,currentMapY + 1).mapId;
                  virtualMap.topNeighbourId = WorldPoint.fromCoords(currentWorldId,currentMapX,currentMapY - 1).mapId;
               }
               return true;
            case msg is ChangeWorldInteractionAction:
               cwiamsg = msg as ChangeWorldInteractionAction;
               bidHouseSwitch = false;
               if(Kernel.getWorker().contains(BidHouseManagementFrame) && this._bidHouseManagementFrame.switching)
               {
                  bidHouseSwitch = true;
               }
               this._interactionIsLimited = !cwiamsg.enabled;
               switch(cwiamsg.total)
               {
                  case true:
                     if(cwiamsg.enabled)
                     {
                        if(!Kernel.getWorker().contains(RoleplayWorldFrame) && !bidHouseSwitch && SystemApi.wordInteractionEnable)
                        {
                           _log.info("Enabling interaction with the roleplay world.");
                           Kernel.getWorker().addFrame(this._worldFrame);
                        }
                        this._worldFrame.cellClickEnabled = true;
                        this._worldFrame.allowOnlyCharacterInteraction = false;
                        this._worldFrame.pivotingCharacter = false;
                     }
                     else if(Kernel.getWorker().contains(RoleplayWorldFrame))
                     {
                        _log.info("Disabling interaction with the roleplay world.");
                        Kernel.getWorker().removeFrame(this._worldFrame);
                     }
                     break;
                  case false:
                     if(cwiamsg.enabled)
                     {
                        if(!Kernel.getWorker().contains(RoleplayWorldFrame) && !bidHouseSwitch)
                        {
                           _log.info("Enabling total interaction with the roleplay world.");
                           Kernel.getWorker().addFrame(this._worldFrame);
                           this._worldFrame.cellClickEnabled = true;
                           this._worldFrame.allowOnlyCharacterInteraction = false;
                           this._worldFrame.pivotingCharacter = false;
                        }
                        if(!Kernel.getWorker().contains(RoleplayInteractivesFrame))
                        {
                           Kernel.getWorker().addFrame(this._interactivesFrame);
                        }
                     }
                     else if(Kernel.getWorker().contains(RoleplayWorldFrame))
                     {
                        _log.info("Disabling partial interactions with the roleplay world.");
                        this._worldFrame.allowOnlyCharacterInteraction = true;
                     }
               }
               stackFrame = Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame;
               if(!(!this._interactionIsLimited && !SystemApi.wordInteractionEnable))
               {
                  stackFrame.paused = this._interactionIsLimited;
               }
               if(!stackFrame.paused && stackFrame.waitingMessage)
               {
                  this._worldFrame.process(stackFrame.waitingMessage);
                  stackFrame.waitingMessage = null;
               }
               return true;
            case msg is NpcGenericActionRequestAction:
               ngara = msg as NpcGenericActionRequestAction;
               playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               ngarmsg = new NpcGenericActionRequestMessage();
               ngarmsg.initNpcGenericActionRequestMessage(ngara.npcId,ngara.actionId,PlayedCharacterManager.getInstance().currentMap.mapId);
               if((playerEntity as IMovable).isMoving)
               {
                  (playerEntity as IMovable).stop();
                  this._movementFrame.setFollowingMessage(ngarmsg);
               }
               else
               {
                  ConnectionsHandler.getConnection().send(ngarmsg);
               }
               return true;
            case msg is ExchangeRequestOnTaxCollectorAction:
               erotca = msg as ExchangeRequestOnTaxCollectorAction;
               erotcmsg = new ExchangeRequestOnTaxCollectorMessage();
               erotcmsg.initExchangeRequestOnTaxCollectorMessage();
               playerEntity4 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if((playerEntity4 as IMovable).isMoving)
               {
                  this._movementFrame.setFollowingMessage(erotcmsg);
                  (playerEntity4 as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(erotcmsg);
               }
               return true;
            case msg is GameRolePlayTaxCollectorFightRequestAction:
               grptcfrmsg = new GameRolePlayTaxCollectorFightRequestMessage();
               grptcfrmsg.initGameRolePlayTaxCollectorFightRequestMessage();
               ConnectionsHandler.getConnection().send(grptcfrmsg);
               return true;
            case msg is InteractiveElementActivationAction:
               ieaa = msg as InteractiveElementActivationAction;
               ieamsg = new InteractiveElementActivationMessage(ieaa.interactiveElement,ieaa.position,ieaa.skillInstanceId,ieaa.additionalParam);
               Kernel.getWorker().process(ieamsg);
               return true;
            case msg is DisplayContextualMenuAction:
               dcma = msg as DisplayContextualMenuAction;
               entityInfo = this.entitiesFrame.getEntityInfos(dcma.playerId);
               if(entityInfo)
               {
                  menuResult = RoleplayManager.getInstance().displayCharacterContextualMenu(entityInfo);
               }
               return false;
            case msg is PivotCharacterAction:
               roleplayInteractivesFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               if(roleplayInteractivesFrame && !roleplayInteractivesFrame.usingInteractive)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                  this._worldFrame.pivotingCharacter = true;
                  this._playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
                  StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onListenOrientation);
                  StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onClickOrientation);
               }
               return true;
            case msg is NpcGenericActionFailureMessage:
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.NpcDialogCreationFailure);
               return true;
            case msg is NpcDialogCreationMessage:
               ndcmsg = msg as NpcDialogCreationMessage;
               entityNpcLike = this._entitiesFrame.getEntityInfos(ndcmsg.npcId);
               if(!Kernel.getWorker().contains(NpcDialogFrame))
               {
                  Kernel.getWorker().addFrame(this._npcDialogFrame);
               }
               Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
               TooltipManager.hideAll();
               if(entityNpcLike is GameRolePlayNpcInformations)
               {
                  npcEntity = entityNpcLike as GameRolePlayNpcInformations;
                  npcLook = EntityLookAdapter.fromNetwork(npcEntity.look);
                  npcLook = TiphonUtility.getLookWithoutMount(npcLook);
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.NpcDialogCreation,ndcmsg.mapId,npcEntity.npcId,npcLook);
               }
               else if(entityNpcLike is GameRolePlayTaxCollectorInformations)
               {
                  ponyEntity = entityNpcLike as GameRolePlayTaxCollectorInformations;
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PonyDialogCreation,ndcmsg.mapId,ponyEntity.identification.firstNameId,ponyEntity.identification.lastNameId,EntityLookAdapter.fromNetwork(ponyEntity.look));
               }
               else if(entityNpcLike is GameRolePlayPrismInformations)
               {
                  prismEntity = entityNpcLike as GameRolePlayPrismInformations;
                  if(prismEntity.prism is AlliancePrismInformation)
                  {
                     allianceName = (prismEntity.prism as AlliancePrismInformation).alliance.allianceName;
                     if(allianceName == "#NONAME#")
                     {
                        allianceName = I18n.getUiText("ui.social.noName");
                     }
                  }
                  else if(SocialFrame.getInstance().hasAlliance)
                  {
                     allianceName = SocialFrame.getInstance().alliance.groupName;
                  }
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PrismDialogCreation,ndcmsg.mapId,allianceName,EntityLookAdapter.fromNetwork(prismEntity.look));
               }
               else if(entityNpcLike is GameRolePlayPortalInformations)
               {
                  portalEntity = entityNpcLike as GameRolePlayPortalInformations;
                  portalType = (ndcmsg as PortalDialogCreationMessage).type;
                  area = Area.getAreaById(portalEntity.portal.areaId);
                  if(!area)
                  {
                     return true;
                  }
                  areaName = area.name;
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PortalDialogCreation,ndcmsg.mapId,portalType,areaName,EntityLookAdapter.fromNetwork(portalEntity.look));
               }
               else
               {
                  ldrdcmsg = new LeaveDialogRequestMessage();
                  ConnectionsHandler.getConnection().send(ldrdcmsg);
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
               }
               return true;
            case msg is PortalUseRequestAction:
               pura = msg as PortalUseRequestAction;
               purmsg = new PortalUseRequestMessage();
               purmsg.initPortalUseRequestMessage(pura.portalId);
               ConnectionsHandler.getConnection().send(purmsg);
               return true;
            case msg is GameContextDestroyMessage:
               TooltipManager.hide();
               Kernel.getWorker().removeFrame(this);
               return true;
            case msg is ExchangeStartedBidBuyerMessage:
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
               }
               this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_BUY);
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
               }
               this._bidHouseManagementFrame.processExchangeStartedBidBuyerMessage(msg as ExchangeStartedBidBuyerMessage);
               return true;
            case msg is ExchangeStartedBidSellerMessage:
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
               }
               this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_SELL);
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
               }
               this._bidHouseManagementFrame.processExchangeStartedBidSellerMessage(msg as ExchangeStartedBidSellerMessage);
               return true;
            case msg is ExchangeStartedMountStockMessage:
               esmsmsg = ExchangeStartedMountStockMessage(msg);
               this.addCommonExchangeFrame(ExchangeTypeEnum.MOUNT);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               PlayedCharacterManager.getInstance().isInExchange = true;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeBankStarted,ExchangeTypeEnum.MOUNT,esmsmsg.objectsInfos,0);
               this._exchangeManagementFrame.initBankStock(esmsmsg.objectsInfos);
               return true;
            case msg is ExchangeStartedTaxCollectorShopMessage:
               estcsm = ExchangeStartedTaxCollectorShopMessage(msg);
               this.addCommonExchangeFrame(ExchangeTypeEnum.TAXCOLLECTOR);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               PlayedCharacterManager.getInstance().isInExchange = true;
               InventoryManager.getInstance().bankInventory.kamas = estcsm.kamas;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeBankStarted,ExchangeTypeEnum.TAXCOLLECTOR,estcsm.objects,estcsm.kamas);
               this._exchangeManagementFrame.initBankStock(estcsm.objects);
               return true;
            case msg is StartExchangeTaxCollectorEquipmentAction:
               setcea = msg as StartExchangeTaxCollectorEquipmentAction;
               setcem = new StartExchangeTaxCollectorEquipmentMessage();
               setcem.initStartExchangeTaxCollectorEquipmentMessage(setcea.uid);
               ConnectionsHandler.getConnection().send(setcem);
               return true;
            case msg is ExchangeStartedTaxCollectorEquipmentMessage:
               estcem = msg as ExchangeStartedTaxCollectorEquipmentMessage;
               StatsManager.getInstance().addRawStats(estcem.information.uniqueId,estcem.information.characteristics.characteristics);
               SocialEntitiesManager.getInstance().addTaxCollector(estcem.information);
               KernelEventsManager.getInstance().processCallback(SocialHookList.ModifyTaxCollector,estcem.information);
               this.addCommonExchangeFrame(ExchangeTypeEnum.TAXCOLLECTOR);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               PlayedCharacterManager.getInstance().isInExchange = true;
               return true;
            case msg is ExchangeRequestedTradeMessage:
               this.addCommonExchangeFrame(ExchangeTypeEnum.PLAYER_TRADE);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                  this._exchangeManagementFrame.processExchangeRequestedTradeMessage(msg as ExchangeRequestedTradeMessage);
               }
               return true;
            case msg is ExchangeStartOkNpcTradeMessage:
               this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_TRADE);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                  this._exchangeManagementFrame.processExchangeStartOkNpcTradeMessage(msg as ExchangeStartOkNpcTradeMessage);
               }
               return true;
            case msg is ExchangeStartOkNpcShopMessage:
               esonmsg = msg as ExchangeStartOkNpcShopMessage;
               this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_SHOP);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               this._exchangeManagementFrame.process(msg);
               return true;
            case msg is ExchangeStartOkRunesTradeMessage:
               this.addCommonExchangeFrame(ExchangeTypeEnum.RUNES_TRADE);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                  this._exchangeManagementFrame.processExchangeStartOkRunesTradeMessage(msg as ExchangeStartOkRunesTradeMessage);
               }
               return true;
            case msg is ExchangeStartOkRecycleTradeMessage:
               this.addCommonExchangeFrame(ExchangeTypeEnum.RECYCLE_TRADE);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                  this._exchangeManagementFrame.processExchangeStartOkRecycleTradeMessage(msg as ExchangeStartOkRecycleTradeMessage);
               }
               return true;
            case msg is ExchangeStartedMessage:
               esmsg = msg as ExchangeStartedMessage;
               commonExchangeFrame = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(commonExchangeFrame)
               {
                  commonExchangeFrame.resetEchangeSequence();
               }
               switch(esmsg.exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                  case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                  case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                  case ExchangeTypeEnum.RUNES_TRADE:
                     this.addCraftFrame();
                     break;
                  case ExchangeTypeEnum.BIDHOUSE_BUY:
                  case ExchangeTypeEnum.BIDHOUSE_SELL:
                  case ExchangeTypeEnum.PLAYER_TRADE:
                  case ExchangeTypeEnum.RECYCLE_TRADE:
               }
               this.addCommonExchangeFrame(esmsg.exchangeType);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               this._exchangeManagementFrame.process(msg);
               return true;
            case msg is ExchangeOkMultiCraftMessage:
               this.addCraftFrame();
               this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               this._craftFrame.processExchangeOkMultiCraftMessage(msg as ExchangeOkMultiCraftMessage);
               return true;
            case msg is ExchangeStartOkCraftWithInformationMessage:
               this.addCraftFrame();
               this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
               this._craftFrame.processExchangeStartOkCraftWithInformationMessage(msg as ExchangeStartOkCraftWithInformationMessage);
               return true;
            case msg is ObtainedItemMessage:
               oimsg = msg as ObtainedItemMessage;
               interactiveFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               player = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
               if(interactiveFrame && player.getAnimation() != AnimationEnum.ANIM_STATIQUE)
               {
                  animTimer = interactiveFrame.getInteractiveActionTimer(player);
               }
               if(animTimer && animTimer.running)
               {
                  this._obtainedItemMsg = oimsg;
                  animTimer.addEventListener(TimerEvent.TIMER,this.onInteractiveAnimationEnd);
               }
               else
               {
                  bonusQty = msg is ObtainedItemWithBonusMessage ? uint((msg as ObtainedItemWithBonusMessage).bonusQuantity) : uint(0);
                  this.displayObtainedItem(oimsg.genericId,oimsg.baseQuantity,bonusQty);
               }
               return true;
            case msg is PlayerFightRequestAction:
               pfra = PlayerFightRequestAction(msg);
               if(!pfra.launch && !pfra.friendly)
               {
                  infos = this.entitiesFrame.getEntityInfos(pfra.targetedPlayerId) as GameRolePlayCharacterInformations;
                  if(infos)
                  {
                     if(pfra.ava)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer,pfra.targetedPlayerId,true,infos.name,0,pfra.cellId);
                        return true;
                     }
                     if(infos.alignmentInfos.alignmentSide == 0)
                     {
                        rcf = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                        playerInfo = rcf.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations;
                        if(!(playerInfo is GameRolePlayMutantInformations))
                        {
                           KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer,pfra.targetedPlayerId,false,infos.name,2,pfra.cellId);
                           return true;
                        }
                     }
                     targetPlayerLevel = int(infos.alignmentInfos.characterPower - pfra.targetedPlayerId);
                     fightType = PlayedCharacterManager.getInstance().levelDiff(targetPlayerLevel);
                     if(fightType)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer,pfra.targetedPlayerId,false,infos.name,fightType,pfra.cellId);
                        return true;
                     }
                  }
               }
               gppfrm = new GameRolePlayPlayerFightRequestMessage();
               gppfrm.initGameRolePlayPlayerFightRequestMessage(pfra.targetedPlayerId,pfra.cellId,pfra.friendly);
               playerEntity2 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if((playerEntity2 as IMovable).isMoving)
               {
                  this._movementFrame.setFollowingMessage(pfra);
                  (playerEntity2 as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(gppfrm);
               }
               return true;
            case msg is PlayerFightFriendlyAnswerAction:
               pffaa = PlayerFightFriendlyAnswerAction(msg);
               this.sendPlayPlayerFightFriendlyAnswerMessage(pffaa.accept);
               return true;
            case msg is GameRolePlayPlayerFightFriendlyAnsweredMessage:
               grppffam = msg as GameRolePlayPlayerFightFriendlyAnsweredMessage;
               if(this._currentWaitingFightId == grppffam.fightId)
               {
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered,grppffam.accept);
               }
               return true;
            case msg is GameRolePlayFightRequestCanceledMessage:
               grpfrcm = msg as GameRolePlayFightRequestCanceledMessage;
               if(this._currentWaitingFightId == grpfrcm.fightId)
               {
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered,false);
               }
               return true;
            case msg is GameRolePlayPlayerFightFriendlyRequestedMessage:
               grppffrm = msg as GameRolePlayPlayerFightFriendlyRequestedMessage;
               this._currentWaitingFightId = grppffrm.fightId;
               if(grppffrm.sourceId != PlayedCharacterManager.getInstance().id)
               {
                  if(this._entitiesFrame.getEntityInfos(grppffrm.sourceId))
                  {
                     name = (this._entitiesFrame.getEntityInfos(grppffrm.sourceId) as GameRolePlayNamedActorInformations).name;
                  }
                  if(name == null || this.socialFrame.isIgnored(name) || MountAutoTripManager.getInstance().isTravelling)
                  {
                     this.sendPlayPlayerFightFriendlyAnswerMessage(false);
                     return true;
                  }
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyRequested,name);
               }
               else
               {
                  gcai = this._entitiesFrame.getEntityInfos(grppffrm.targetId);
                  if(gcai)
                  {
                     KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightRequestSent,GameRolePlayNamedActorInformations(gcai).name,true);
                  }
               }
               return true;
            case msg is GameRolePlayFreeSoulRequestAction:
               grpfsrmmsg = new GameRolePlayFreeSoulRequestMessage();
               ConnectionsHandler.getConnection().send(grpfsrmmsg);
               return true;
            case msg is LeaveBidHouseAction:
               ldrbidHousemsg = new LeaveDialogRequestMessage();
               ldrbidHousemsg.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(ldrbidHousemsg);
               return true;
            case msg is ExchangeErrorMessage:
               ermsg = msg as ExchangeErrorMessage;
               channelId = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
               switch(ermsg.errorType)
               {
                  case ExchangeErrorEnum.REQUEST_CHARACTER_OCCUPIED:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterOccupied");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_TOOL_TOO_FAR:
                     errorMessage = I18n.getUiText("ui.craft.notNearCraftTable");
                     break;
                  case ExchangeErrorEnum.REQUEST_IMPOSSIBLE:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchange");
                     break;
                  case ExchangeErrorEnum.BID_SEARCH_ERROR:
                     break;
                  case ExchangeErrorEnum.BUY_ERROR:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeBuyError");
                     break;
                  case ExchangeErrorEnum.MOUNT_PADDOCK_ERROR:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeMountPaddockError");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_JOB_NOT_EQUIPED:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterJobNotEquiped");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_NOT_SUSCRIBER:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterNotSuscriber");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_OVERLOADED:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterOverloaded");
                     break;
                  case ExchangeErrorEnum.SELL_ERROR:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeSellError");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_GUEST:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterGuest");
                     channelId = ChatFrame.RED_CHANNEL_ID;
                     break;
                  default:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchange");
               }
               if(errorMessage)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorMessage,channelId,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeError,ermsg.errorType);
               return true;
            case msg is GameRolePlayAggressionMessage:
               grpamsg = msg as GameRolePlayAggressionMessage;
               message = I18n.getUiText("ui.pvp.aAttackB",[GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(grpamsg.attackerId)).name,GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(grpamsg.defenderId)).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,message,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               playerId = PlayedCharacterManager.getInstance().id;
               if(playerId == grpamsg.attackerId)
               {
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESS);
               }
               else if(playerId == grpamsg.defenderId)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.PlayerAggression,grpamsg.attackerId,GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(grpamsg.attackerId)).name);
                  if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.ATTACK))
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.ATTACK,[GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(grpamsg.attackerId)).name]);
                  }
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESSED);
               }
               return true;
            case msg is LeaveShopStockAction:
               ldrmsg = new LeaveDialogRequestMessage();
               ldrmsg.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(ldrmsg);
               return true;
            case msg is ExchangeShopStockMovementAddAction:
               essmaa = msg as ExchangeShopStockMovementAddAction;
               eompmsg = new ExchangeObjectMovePricedMessage();
               eompmsg.initExchangeObjectMovePricedMessage(essmaa.objectUID,essmaa.quantity,essmaa.price);
               ConnectionsHandler.getConnection().send(eompmsg);
               return true;
            case msg is ExchangeShopStockMouvmentRemoveAction:
               essmra = msg as ExchangeShopStockMouvmentRemoveAction;
               eommsg = new ExchangeObjectMoveMessage();
               eommsg.initExchangeObjectMoveMessage(essmra.objectUID,essmra.quantity);
               ConnectionsHandler.getConnection().send(eommsg);
               return true;
            case msg is ExchangeBuyAction:
               eba = msg as ExchangeBuyAction;
               ebmsg = new ExchangeBuyMessage();
               ebmsg.initExchangeBuyMessage(eba.objectUID,eba.quantity);
               ConnectionsHandler.getConnection().send(ebmsg);
               return true;
            case msg is ExchangeSellAction:
               esa = msg as ExchangeSellAction;
               eslmsg = new ExchangeSellMessage();
               eslmsg.initExchangeSellMessage(esa.objectUID,esa.quantity);
               ConnectionsHandler.getConnection().send(eslmsg);
               return true;
            case msg is ExchangeBuyOkMessage:
               ebomsg = msg as ExchangeBuyOkMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.BuyOk);
               return true;
            case msg is ExchangeSellOkMessage:
               esomsg = msg as ExchangeSellOkMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.SellOk);
               return true;
            case msg is ExchangePlayerRequestAction:
               epra = msg as ExchangePlayerRequestAction;
               eprmsg = new ExchangePlayerRequestMessage();
               eprmsg.initExchangePlayerRequestMessage(epra.exchangeType,epra.target);
               ConnectionsHandler.getConnection().send(eprmsg);
               return true;
            case msg is ExchangePlayerMultiCraftRequestAction:
               epmcra = msg as ExchangePlayerMultiCraftRequestAction;
               switch(epmcra.exchangeType)
               {
                  case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                     this._customerID = epmcra.target;
                     this._crafterId = PlayedCharacterManager.getInstance().id;
                     break;
                  case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                     this._crafterId = epmcra.target;
                     this._customerID = PlayedCharacterManager.getInstance().id;
               }
               epmcrmsg = new ExchangePlayerMultiCraftRequestMessage();
               epmcrmsg.initExchangePlayerMultiCraftRequestMessage(epmcra.exchangeType,epmcra.target,epmcra.skillId);
               ConnectionsHandler.getConnection().send(epmcrmsg);
               return true;
            case msg is JobAllowMultiCraftRequestMessage:
               jamcrmsg = msg as JobAllowMultiCraftRequestMessage;
               messId = (msg as JobAllowMultiCraftRequestMessage).getMessageId();
               switch(messId)
               {
                  case JobAllowMultiCraftRequestMessage.protocolId:
                     PlayedCharacterManager.getInstance().publicMode = jamcrmsg.enabled;
                     KernelEventsManager.getInstance().processCallback(CraftHookList.JobAllowMultiCraftRequest,jamcrmsg.enabled);
                     break;
                  case JobMultiCraftAvailableSkillsMessage.protocolId:
                     jmcasm = msg as JobMultiCraftAvailableSkillsMessage;
                     if(jmcasm.enabled)
                     {
                        mcefp = new MultiCraftEnableForPlayer();
                        mcefp.playerId = jmcasm.playerId;
                        mcefp.skills = jmcasm.skills;
                        alreadyIn = false;
                        for each(mcefplayer in this._playersMultiCraftSkill)
                        {
                           if(mcefplayer.playerId == mcefp.playerId)
                           {
                              alreadyIn = true;
                              mcefplayer.skills = jmcasm.skills;
                           }
                        }
                        if(!alreadyIn)
                        {
                           this._playersMultiCraftSkill.push(mcefp);
                        }
                     }
                     else
                     {
                        compt = 0;
                        index = -1;
                        for(compt = 0; compt < this._playersMultiCraftSkill.length; compt++)
                        {
                           if(this._playersMultiCraftSkill[compt].playerId == jmcasm.playerId)
                           {
                              index = compt;
                           }
                        }
                        if(index > -1)
                        {
                           this._playersMultiCraftSkill.splice(index,1);
                        }
                     }
               }
               return true;
            case msg is ChallengeFightJoinRefusedMessage:
               cfjrmsg = msg as ChallengeFightJoinRefusedMessage;
               switch(cfjrmsg.reason)
               {
                  case FighterRefusedReasonEnum.CHALLENGE_FULL:
                     message = I18n.getUiText("ui.fight.challengeFull");
                     break;
                  case FighterRefusedReasonEnum.TEAM_FULL:
                     message = I18n.getUiText("ui.fight.teamFull");
                     break;
                  case FighterRefusedReasonEnum.WRONG_ALIGNMENT:
                     message = I18n.getUiText("ui.fight.wrongAlignment");
                     break;
                  case FighterRefusedReasonEnum.WRONG_GUILD:
                     message = I18n.getUiText("ui.fight.wrongGuild");
                     break;
                  case FighterRefusedReasonEnum.TOO_LATE:
                     message = I18n.getUiText("ui.fight.tooLate");
                     break;
                  case FighterRefusedReasonEnum.MUTANT_REFUSED:
                     message = I18n.getUiText("ui.fight.mutantRefused");
                     break;
                  case FighterRefusedReasonEnum.WRONG_MAP:
                     message = I18n.getUiText("ui.fight.wrongMap");
                     break;
                  case FighterRefusedReasonEnum.JUST_RESPAWNED:
                     message = I18n.getUiText("ui.fight.justRespawned");
                     break;
                  case FighterRefusedReasonEnum.IM_OCCUPIED:
                     message = I18n.getUiText("ui.fight.imOccupied");
                     break;
                  case FighterRefusedReasonEnum.OPPONENT_OCCUPIED:
                     message = I18n.getUiText("ui.fight.opponentOccupied");
                     break;
                  case FighterRefusedReasonEnum.MULTIACCOUNT_NOT_ALLOWED:
                     message = I18n.getUiText("ui.fight.onlyOneAllowedAccount");
                     break;
                  case FighterRefusedReasonEnum.INSUFFICIENT_RIGHTS:
                     message = I18n.getUiText("ui.fight.insufficientRights");
                     break;
                  case FighterRefusedReasonEnum.MEMBER_ACCOUNT_NEEDED:
                     message = I18n.getUiText("ui.fight.memberAccountNeeded");
                     break;
                  case FighterRefusedReasonEnum.GUEST_ACCOUNT:
                     message = I18n.getUiText("ui.fight.guestAccount");
                     break;
                  case FighterRefusedReasonEnum.OPPONENT_NOT_MEMBER:
                     message = I18n.getUiText("ui.fight.opponentNotMember");
                     break;
                  case FighterRefusedReasonEnum.TEAM_LIMITED_BY_MAINCHARACTER:
                     message = I18n.getUiText("ui.fight.teamLimitedByMainCharacter");
                     break;
                  case FighterRefusedReasonEnum.GHOST_REFUSED:
                     message = I18n.getUiText("ui.fight.ghostRefused");
                     break;
                  case FighterRefusedReasonEnum.AVA_ZONE:
                     message = I18n.getUiText("ui.fight.cantAttackAvAZone");
                     break;
                  default:
                     return true;
               }
               if(message != null)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,message,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is DocumentReadingBeginMessage:
               drbm = msg as DocumentReadingBeginMessage;
               TooltipManager.hideAll();
               if(!Kernel.getWorker().contains(DocumentFrame))
               {
                  Kernel.getWorker().addFrame(this._documentFrame);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.DocumentReadingBegin,drbm.documentId);
               return true;
            case msg is ZaapDestinationsMessage || msg is TeleportDestinationsMessage:
               if(!Kernel.getWorker().contains(ZaapFrame))
               {
                  Kernel.getWorker().addFrame(this._zaapFrame);
                  Kernel.getWorker().process(msg);
               }
               return false;
            case msg is PaddockSellBuyDialogMessage:
               psbdmsg = msg as PaddockSellBuyDialogMessage;
               TooltipManager.hideAll();
               if(!Kernel.getWorker().contains(PaddockFrame))
               {
                  Kernel.getWorker().addFrame(this._paddockFrame);
               }
               Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
               KernelEventsManager.getInstance().processCallback(MountHookList.PaddockSellBuyDialog,psbdmsg.bsell,psbdmsg.ownerId,psbdmsg.price);
               return true;
            case msg is LeaveExchangeMountAction:
               ldrmsg2 = new LeaveDialogRequestMessage();
               ldrmsg2.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(ldrmsg2);
               return true;
            case msg is PaddockPropertiesMessage:
               this._currentPaddock = PaddockWrapper.create(PaddockPropertiesMessage(msg).properties);
               return true;
            case msg is DisplayNumericalValuePaddockMessage:
               dnvpmsg = msg as DisplayNumericalValuePaddockMessage;
               mount = DofusEntities.getEntity(dnvpmsg.rideId);
               if(mount)
               {
                  mountBoosIcon = new Texture();
                  boostIconUri = new Uri();
                  switch(dnvpmsg.type)
                  {
                     case MountCharacteristicEnum.ENERGY:
                        boostIconUri.uri = MOUNT_BOOSTS_ICONS_PATH + "Dragodinde_tooltip_tx_pictoEnergie";
                        break;
                     case MountCharacteristicEnum.SERENITY:
                        if(dnvpmsg.value > 0)
                        {
                           boostIconUri.uri = MOUNT_BOOSTS_ICONS_PATH + "Dragodinde_tooltip_tx_pictoSerenite";
                        }
                        else
                        {
                           boostIconUri.uri = MOUNT_BOOSTS_ICONS_PATH + "Dragodinde_tooltip_tx_pictoAgressivite";
                        }
                        break;
                     case MountCharacteristicEnum.STAMINA:
                        boostIconUri.uri = MOUNT_BOOSTS_ICONS_PATH + "Dragodinde_tooltip_tx_pictoEndurance";
                        break;
                     case MountCharacteristicEnum.LOVE:
                        boostIconUri.uri = MOUNT_BOOSTS_ICONS_PATH + "Dragodinde_tooltip_tx_pictoAmour";
                        break;
                     case MountCharacteristicEnum.MATURITY:
                        boostIconUri.uri = MOUNT_BOOSTS_ICONS_PATH + "Dragodinde_tooltip_tx_pictoMaturite";
                        break;
                     case MountCharacteristicEnum.TIREDNESS:
                  }
                  mountBoosIcon.uri = boostIconUri;
                  mountBoosIcon.finalize();
                  CharacteristicContextualManager.getInstance().addStatContextualWithIcon(mountBoosIcon,dnvpmsg.value.toString(),mount,this._mountBoosTextFormat,1,GameContextEnum.ROLE_PLAY,1,1500);
               }
               return true;
            case msg is GameRolePlaySpellAnimMessage:
               if(Kernel.getWorker().avoidFlood(getQualifiedClassName(msg)))
               {
                  return true;
               }
               grpsamsg = msg as GameRolePlaySpellAnimMessage;
               context = new SpellCastSequenceContext();
               context.casterId = grpsamsg.casterId;
               context.spellData = Spell.getSpellById(grpsamsg.spellId);
               context.spellLevelData = context.spellData !== null ? context.spellData.getSpellLevel(grpsamsg.spellLevel) : null;
               context.targetedCellId = grpsamsg.targetCellId;
               context.direction = grpsamsg.direction;
               castSequence = new SpellCastSequence(context);
               contexts = SpellScriptManager.getInstance().resolveScriptUsageFromCastContext(castSequence.context);
               SpellScriptManager.getInstance().runBulk(contexts,castSequence,new Callback(this.executeSpellBuffer,null,true,true,castSequence),new Callback(this.executeSpellBuffer,null,true,false,castSequence));
               return true;
               break;
            case msg is HavenbagEnterAction:
               hea = msg as HavenbagEnterAction;
               enterhbrmsg = new EnterHavenBagRequestMessage();
               enterhbrmsg.initEnterHavenBagRequestMessage(hea.ownerId);
               ConnectionsHandler.getConnection().send(enterhbrmsg);
               return true;
            case msg is HavenbagInvitePlayerAction:
               hipa = msg as HavenbagInvitePlayerAction;
               if(hipa.invite)
               {
                  thbrmsg = new TeleportHavenBagRequestMessage();
                  thbrmsg.initTeleportHavenBagRequestMessage(hipa.guestId);
                  ConnectionsHandler.getConnection().send(thbrmsg);
               }
               else
               {
                  khbrqt = new KickHavenBagRequestMessage();
                  khbrqt.initKickHavenBagRequestMessage(hipa.guestId);
                  ConnectionsHandler.getConnection().send(khbrqt);
               }
               return true;
            case msg is HavenbagInvitePlayerAnswerAction:
               hipaa = msg as HavenbagInvitePlayerAnswerAction;
               thbamsg = new TeleportHavenBagAnswerMessage();
               thbamsg.initTeleportHavenBagAnswerMessage(hipaa.accept);
               ConnectionsHandler.getConnection().send(thbamsg);
               return true;
            case msg is InviteInHavenBagOfferMessage:
               iihbomsg = msg as InviteInHavenBagOfferMessage;
               notifyUser = true;
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.HAVENBAG_INVITATION))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.HAVENBAG_INVITATION,[iihbomsg.hostInformations.name]);
                  notifyUser = ExternalNotificationManager.getInstance().notificationNotify(ExternalNotificationTypeEnum.HAVENBAG_INVITATION);
               }
               tihbomsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.invitation"),I18n.getUiText("ui.havenbag.inviteProposition",["{player," + iihbomsg.hostInformations.name + "," + iihbomsg.hostInformations.id + "::" + iihbomsg.hostInformations.name + "}"]),NotificationTypeEnum.INVITATION,"havenbagInvite_" + iihbomsg.hostInformations.id);
               NotificationManager.getInstance().addTimerToNotification(tihbomsgNid,iihbomsg.timeLeftBeforeCancel,false,false,notifyUser);
               NotificationManager.getInstance().addButtonToNotification(tihbomsgNid,I18n.getUiText("ui.common.refuse"),"HavenbagInvitePlayerAnswerAction",[iihbomsg.hostInformations.id,false],true,130);
               NotificationManager.getInstance().addButtonToNotification(tihbomsgNid,I18n.getUiText("ui.common.accept"),"HavenbagInvitePlayerAnswerAction",[iihbomsg.hostInformations.id,true],false,130);
               NotificationManager.getInstance().addCallbackToNotification(tihbomsgNid,"HavenbagInvitePlayerAnswerAction",[iihbomsg.hostInformations.id,false]);
               NotificationManager.getInstance().sendNotification(tihbomsgNid);
               return true;
            case msg is InviteInHavenBagMessage:
               iihbmsg = msg as InviteInHavenBagMessage;
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText(!!iihbmsg.accept ? "ui.havenbag.invite.confirmed" : "ui.havenbag.invite.declined",[iihbmsg.guestInformations.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is InviteInHavenBagClosedMessage:
               iihbcmsg = msg as InviteInHavenBagClosedMessage;
               NotificationManager.getInstance().closeNotification("havenbagInvite_" + iihbcmsg.hostInformations.id);
               return true;
            case msg is ToggleShowUIAction:
               tsuia = msg as ToggleShowUIAction;
               tsuia.toggleUIs();
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         var allianceFrame:AllianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         this._interactivesFrame.clear();
         MountAutoTripManager.getInstance().stopCurrentTrip();
         Kernel.getWorker().removeFrame(this._entitiesFrame);
         Kernel.getWorker().removeFrame(this._delayedActionFrame);
         Kernel.getWorker().removeFrame(this._worldFrame);
         Kernel.getWorker().removeFrame(this._movementFrame);
         Kernel.getWorker().removeFrame(this._interactivesFrame);
         Kernel.getWorker().removeFrame(this._spectatorManagementFrame);
         Kernel.getWorker().removeFrame(this._npcDialogFrame);
         Kernel.getWorker().removeFrame(this._documentFrame);
         Kernel.getWorker().removeFrame(this._zaapFrame);
         Kernel.getWorker().removeFrame(this._paddockFrame);
         if(Kernel.getWorker().contains(HavenbagFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(HavenbagFrame));
         }
         return true;
      }
      
      public function getActorName(actorId:Number) : String
      {
         var actorInfos:GameRolePlayActorInformations = null;
         var tcInfos:GameRolePlayTaxCollectorInformations = null;
         actorInfos = this.getActorInfos(actorId);
         if(!actorInfos)
         {
            return "Unknown Actor";
         }
         switch(true)
         {
            case actorInfos is GameRolePlayNamedActorInformations:
               return (actorInfos as GameRolePlayNamedActorInformations).name;
            case actorInfos is GameRolePlayTaxCollectorInformations:
               tcInfos = actorInfos as GameRolePlayTaxCollectorInformations;
               return TaxCollectorFirstname.getTaxCollectorFirstnameById(tcInfos.identification.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcInfos.identification.lastNameId).name;
            case actorInfos is GameRolePlayNpcInformations:
               return Npc.getNpcById((actorInfos as GameRolePlayNpcInformations).npcId).name;
            case actorInfos is GameRolePlayGroupMonsterInformations:
            case actorInfos is GameRolePlayPrismInformations:
            case actorInfos is GameRolePlayPortalInformations:
               _log.error("Fail: getActorName called with an actorId corresponding to a monsters group or a prism or a portal (" + actorInfos + ").");
               return "<error: cannot get a name>";
            default:
               return "Unknown Actor Type";
         }
      }
      
      private function sendPlayPlayerFightFriendlyAnswerMessage(accept:Boolean) : void
      {
         var grppffam2:GameRolePlayPlayerFightFriendlyAnswerMessage = new GameRolePlayPlayerFightFriendlyAnswerMessage();
         grppffam2.initGameRolePlayPlayerFightFriendlyAnswerMessage(this._currentWaitingFightId,accept);
         ConnectionsHandler.getConnection().send(grppffam2);
      }
      
      private function getActorInfos(actorId:Number) : GameRolePlayActorInformations
      {
         return this.entitiesFrame.getEntityInfos(actorId) as GameRolePlayActorInformations;
      }
      
      private function executeSpellBuffer(callback:Function, hadScript:Boolean, scriptSuccess:Boolean = false, castSequence:SpellCastSequence = null) : void
      {
         var step:ISequencable = null;
         var serialSequencer:SerialSequencer = new SerialSequencer();
         for each(step in castSequence.steps)
         {
            serialSequencer.addStep(step);
         }
         serialSequencer.start();
      }
      
      private function addCraftFrame() : void
      {
         if(!Kernel.getWorker().contains(CraftFrame))
         {
            Kernel.getWorker().addFrame(this._craftFrame);
         }
      }
      
      private function addCommonExchangeFrame(pExchangeType:uint) : void
      {
         if(!Kernel.getWorker().contains(CommonExchangeManagementFrame))
         {
            this._commonExchangeFrame = new CommonExchangeManagementFrame(pExchangeType);
            Kernel.getWorker().addFrame(this._commonExchangeFrame);
         }
      }
      
      private function onListenOrientation(e:MouseEvent) : void
      {
         var point:Point = this._playerEntity.localToGlobal(new Point(0,0));
         var difY:Number = StageShareManager.stage.mouseY - point.y;
         var difX:Number = StageShareManager.stage.mouseX - point.x;
         var orientation:uint = AngleToOrientation.angleToOrientation(Math.atan2(difY,difX));
         var direction:int = this._playerEntity.getDirection();
         var currentEmoticon:Emoticon = Emoticon.getEmoticonById(this._entitiesFrame.currentEmoticon);
         if(direction == orientation)
         {
            return;
         }
         if(!currentEmoticon || currentEmoticon && currentEmoticon.eight_directions)
         {
            this._playerEntity.setDirection(orientation);
         }
         else if(orientation % 2 == 0)
         {
            this._playerEntity.setDirection(orientation + 1);
         }
         else
         {
            this._playerEntity.setDirection(orientation);
         }
      }
      
      private function onClickOrientation(e:MouseEvent) : void
      {
         Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onListenOrientation);
         StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onClickOrientation);
         var animation:String = this._playerEntity.getAnimation();
         var gmcormsg:GameMapChangeOrientationRequestMessage = new GameMapChangeOrientationRequestMessage();
         gmcormsg.initGameMapChangeOrientationRequestMessage(this._playerEntity.getDirection());
         ConnectionsHandler.getConnection().send(gmcormsg);
      }
      
      private function onInteractiveAnimationEnd(pTimerEvent:TimerEvent) : void
      {
         var bonusQty:uint = 0;
         pTimerEvent.currentTarget.removeEventListener(TimerEvent.TIMER,this.onInteractiveAnimationEnd);
         if(this._obtainedItemMsg)
         {
            bonusQty = this._obtainedItemMsg is ObtainedItemWithBonusMessage ? uint((this._obtainedItemMsg as ObtainedItemWithBonusMessage).bonusQuantity) : uint(0);
            this.displayObtainedItem(this._obtainedItemMsg.genericId,this._obtainedItemMsg.baseQuantity,bonusQty);
         }
         this._obtainedItemMsg = null;
      }
      
      private function displayObtainedItem(pItemGID:uint, pItemQuantity:uint, pItemBonusQuantity:uint = 0) : void
      {
         var entity:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
         var itemW:ItemWrapper = ItemWrapper.create(0,0,pItemGID,1,null);
         var iconUri:Uri = itemW.getIconUri();
         this._itemIcon.uri = iconUri;
         this._itemIcon.finalize();
         CharacteristicContextualManager.getInstance().addStatContextualWithIcon(this._itemIcon,pItemQuantity.toString(),entity,this._obtainedItemTextFormat,1,GameContextEnum.ROLE_PLAY,1,1500);
         if(pItemBonusQuantity > 0)
         {
            this._itemBonusIcon.uri = iconUri;
            this._itemBonusIcon.finalize();
            CharacteristicContextualManager.getInstance().addStatContextualWithIcon(this._itemBonusIcon,pItemBonusQuantity.toString(),entity,this._obtainedItemBonusTextFormat,1,GameContextEnum.ROLE_PLAY,1,1500);
         }
      }
      
      public function getMultiCraftSkills(pPlayerId:Number) : Vector.<uint>
      {
         var mcefp:MultiCraftEnableForPlayer = null;
         for each(mcefp in this._playersMultiCraftSkill)
         {
            if(mcefp.playerId == pPlayerId)
            {
               return mcefp.skills;
            }
         }
         return null;
      }
   }
}

class MultiCraftEnableForPlayer
{
    
   
   public var playerId:Number;
   
   public var skills:Vector.<uint>;
   
   function MultiCraftEnableForPlayer()
   {
      super();
   }
}
