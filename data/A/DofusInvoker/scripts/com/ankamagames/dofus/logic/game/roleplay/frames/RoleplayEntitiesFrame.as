package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.atouin.messages.MapZoomMessage;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.houses.HavenbagTheme;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.optionalFeatures.Modster;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.sounds.SoundAnimation;
   import com.ankamagames.dofus.datacenter.sounds.SoundBones;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.factories.RolePlayEntitiesFactory;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.conquest.KothColorsEnum;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseInstanceWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.TaxCollectorWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkZaapPosition;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.StartZoomAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.KohOverAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockMoveItemRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockRemoveItemRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.frames.BreachFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ContextChangeFrame;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PointCellFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.frames.StackManagementFrame;
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.misc.SpellCastSequence;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.dofus.logic.game.roleplay.managers.AnimFunManager;
   import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.DelayedActionMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.GameRolePlaySetAnimationMessage;
   import com.ankamagames.dofus.logic.game.roleplay.types.Fight;
   import com.ankamagames.dofus.logic.game.roleplay.types.FightTeam;
   import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
   import com.ankamagames.dofus.logic.game.roleplay.types.GroundObject;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRefreshEntityLookMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveMultipleElementsMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationsMessage;
   import com.ankamagames.dofus.network.messages.game.context.ShowCellMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionStateUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightRemoveTeamMemberMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.GameDataPaddockObjectAddMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.GameDataPaddockObjectListAddMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.GameDataPaddockObjectRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockMoveItemRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockRemoveItemRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.GameRolePlayShowActorMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.GameRolePlayShowMultipleActorsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataInHavenBagMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataInHouseMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsWithCoordsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapFightCountMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapInformationsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.SubareaRewardRateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.anomaly.AnomalyOpenedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.anomaly.AnomalyStateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.anomaly.MapComplementaryInformationsAnomalyMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachEnterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachExitResponseMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachTeleportRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachTeleportResponseMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.MapComplementaryInformationsBreachMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayMonsterAngryAtPlayerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayMonsterNotAngryAtPlayerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayRemoveChallengeMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayShowChallengeMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HousePropertiesMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.ListMapNpcsQuestStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundAddedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundListAddedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundRemovedMultipleMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.GameDataPlayFarmObjectAnimationMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveMapUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUsedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.StatedMapUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.UpdateMapPlayersAgressableStatusMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.UpdateSelfAgressableStatusMessage;
   import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AlternativeMonstersInGroupLightInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcWithQuestInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformationsWithAlternatives;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionEmote;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionFollowers;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionObjectUse;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionSkillUse;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionSpeedMultiplier;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.npc.MapNpcQuestInfo;
   import com.ankamagames.dofus.network.types.game.house.HouseInstanceInformations;
   import com.ankamagames.dofus.network.types.game.house.HouseOnMapInformations;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.look.IndexedEntityLook;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
   import com.ankamagames.dofus.network.types.game.pvp.AgressableStatusMessage;
   import com.ankamagames.dofus.scripts.SpellScriptContext;
   import com.ankamagames.dofus.scripts.SpellScriptManager;
   import com.ankamagames.dofus.types.data.Follower;
   import com.ankamagames.dofus.types.entities.AnimStatiqueSubEntityBehavior;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.entities.RoleplayObjectEntity;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.types.enums.EntityIconEnum;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.enum.OptionEnum;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.ASwf;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.tiphon.display.TiphonAnimation;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.tiphon.engine.TiphonEventsManager;
   import com.ankamagames.tiphon.engine.TiphonMultiBonesManager;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   
   public class RoleplayEntitiesFrame extends AbstractEntitiesFrame implements Frame
   {
       
      
      private var _fights:Dictionary;
      
      private var _objects:Dictionary;
      
      private var _objectsByCellId:Dictionary;
      
      private var _paddockItem:Dictionary;
      
      private var _fightNumber:uint = 0;
      
      private var _loader:IResourceLoader;
      
      private var _currentPaddockItemCellId:uint;
      
      private var _currentEmoticon:uint = 0;
      
      private var _mapTotalRewardRate:int = 0;
      
      private var _playersId:Array;
      
      private var _npcList:Dictionary;
      
      private var _housesList:Dictionary;
      
      private var _emoteTimesBySprite:Dictionary;
      
      private var _waitForMap:Boolean;
      
      private var _monstersIds:Vector.<Number>;
      
      private var _allianceFrame:AllianceFrame;
      
      private var _socialFrame:SocialFrame;
      
      private var _breachFrame:BreachFrame;
      
      private var _lastStaticAnimations:Dictionary;
      
      private var _waitingEmotesAnims:Dictionary;
      
      private var _auraCycleTimer:BenchmarkTimer;
      
      private var _auraCycleIndex:int;
      
      private var _lastEntityWithAura:AnimatedCharacter;
      
      private var _dispatchPlayerNewLook:Boolean;
      
      private var _aggressions:Vector.<Aggression>;
      
      private var _aggroTimeoutIdsMonsterAssoc:Dictionary;
      
      private var _taxCollectorOnCurrentMap:TaxCollectorWrapper;
      
      public function RoleplayEntitiesFrame()
      {
         this._lastStaticAnimations = new Dictionary();
         this._waitingEmotesAnims = new Dictionary();
         this._aggressions = new Vector.<Aggression>(0);
         this._aggroTimeoutIdsMonsterAssoc = new Dictionary();
         super();
      }
      
      public function get currentEmoticon() : uint
      {
         return this._currentEmoticon;
      }
      
      public function set currentEmoticon(emoteId:uint) : void
      {
         this._currentEmoticon = emoteId;
      }
      
      public function get dispatchPlayerNewLook() : Boolean
      {
         return this._dispatchPlayerNewLook;
      }
      
      public function set dispatchPlayerNewLook(pValue:Boolean) : void
      {
         this._dispatchPlayerNewLook = pValue;
      }
      
      public function get fightNumber() : uint
      {
         return this._fightNumber;
      }
      
      public function get currentSubAreaId() : uint
      {
         return _currentSubAreaId;
      }
      
      public function get playersId() : Array
      {
         return this._playersId;
      }
      
      public function get housesInformations() : Dictionary
      {
         return this._housesList;
      }
      
      public function get fights() : Dictionary
      {
         return this._fights;
      }
      
      public function get isCreatureMode() : Boolean
      {
         return _creaturesMode;
      }
      
      public function get lastStaticAnimations() : Dictionary
      {
         return this._lastStaticAnimations;
      }
      
      public function get mapTotalRewardRate() : int
      {
         return this._mapTotalRewardRate;
      }
      
      public function get taxCollectorOnCurrentMap() : TaxCollectorWrapper
      {
         return this._taxCollectorOnCurrentMap;
      }
      
      override public function pushed() : Boolean
      {
         var ccFrame:ContextChangeFrame = null;
         var connexion:String = null;
         var mirmsg:MapInformationsRequestMessage = null;
         this.initNewMap();
         this._playersId = [];
         this._monstersIds = new Vector.<Number>();
         this._emoteTimesBySprite = new Dictionary();
         _entitiesVisibleNumber = 0;
         this._auraCycleIndex = 0;
         this._auraCycleTimer = new BenchmarkTimer(1800,0,"RoleplayEntitiesFrame._auraCycleTimer");
         if(OptionManager.getOptionManager("tiphon").getOption("auraMode") == OptionEnum.AURA_CYCLE)
         {
            this._auraCycleTimer.addEventListener(TimerEvent.TIMER,this.onAuraCycleTimer);
            this._auraCycleTimer.start();
         }
         if(MapDisplayManager.getInstance().currentMapRendered)
         {
            ccFrame = Kernel.getWorker().getFrame(ContextChangeFrame) as ContextChangeFrame;
            connexion = "";
            if(ccFrame)
            {
               connexion = ccFrame.mapChangeConnexion;
            }
            mirmsg = new MapInformationsRequestMessage();
            mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
            ConnectionsHandler.getConnection().send(mirmsg,connexion);
         }
         else
         {
            this._waitForMap = true;
         }
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onGroundObjectLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onGroundObjectLoadFailed);
         _interactiveElements = new Vector.<InteractiveElement>();
         Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Tiphon.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onTiphonPropertyChanged);
         this._allianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         this._socialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
         return super.pushed();
      }
      
      override public function process(msg:Message) : Boolean
      {
         var animatedCharacter:AnimatedCharacter = null;
         var mcidmsg:MapComplementaryInformationsDataMessage = null;
         var currentMapHasChanged:Boolean = false;
         var currentSubAreaHasChanged:Boolean = false;
         var roleplayContextFrame:RoleplayContextFrame = null;
         var previousMap:WorldPointWrapper = null;
         var mapWithNoMonsters:Boolean = false;
         var emoteId:int = 0;
         var emoteStartTime:Number = NaN;
         var thisFightExists:Boolean = false;
         var fight:FightCommonInformations = null;
         var fightCache:Fight = null;
         var fightIdsToRemove:Array = null;
         var rpIntFrame:RoleplayInteractivesFrame = null;
         var imumsg:InteractiveMapUpdateMessage = null;
         var smumsg:StatedMapUpdateMessage = null;
         var stackFrame:StackManagementFrame = null;
         var taimsg:AnomalyStateMessage = null;
         var aomsg:AnomalyOpenedMessage = null;
         var dataStoreType:DataStoreType = null;
         var srrmsg:SubareaRewardRateMessage = null;
         var btrmsg:BreachTeleportRequestMessage = null;
         var btrespmsg:BreachTeleportResponseMessage = null;
         var bemsg:BreachEnterMessage = null;
         var hpmsg:HousePropertiesMessage = null;
         var houseInstanceInfo:HouseInstanceInformations = null;
         var houseInstanceWrapper:HouseInstanceWrapper = null;
         var h:* = undefined;
         var grpsamsg:GameRolePlayShowActorMessage = null;
         var grpsmamsg:GameRolePlayShowMultipleActorsMessage = null;
         var gcrelmsg:GameContextRefreshEntityLookMessage = null;
         var gmcomsg:GameMapChangeOrientationMessage = null;
         var gmcomsg2:GameMapChangeOrientationsMessage = null;
         var num:int = 0;
         var grsamsg:GameRolePlaySetAnimationMessage = null;
         var characterEntity:AnimatedCharacter = null;
         var emcm:EntityMovementCompleteMessage = null;
         var entityMovementComplete:AnimatedCharacter = null;
         var emsm:EntityMovementStoppedMessage = null;
         var characterEntityStopped:AnimatedCharacter = null;
         var grpsclmsg:GameRolePlayShowChallengeMessage = null;
         var gfosumsg:GameFightOptionStateUpdateMessage = null;
         var gfutmsg:GameFightUpdateTeamMessage = null;
         var gfrtmmsg:GameFightRemoveTeamMemberMessage = null;
         var grprcmsg:GameRolePlayRemoveChallengeMessage = null;
         var gcremsg:GameContextRemoveElementMessage = null;
         var playerCompt:uint = 0;
         var monsterId:Number = NaN;
         var contextMenu:UiRootContainer = null;
         var gcrmemsg:GameContextRemoveMultipleElementsMessage = null;
         var fakeRemoveElementMessage:GameContextRemoveElementMessage = null;
         var mfcmsg:MapFightCountMessage = null;
         var umpasm:UpdateMapPlayersAgressableStatusMessage = null;
         var asmsg:Vector.<AgressableStatusMessage> = null;
         var playerInfo:GameRolePlayHumanoidInformations = null;
         var playerOption:* = undefined;
         var hasAllianceInfo:Boolean = false;
         var usasm:UpdateSelfAgressableStatusMessage = null;
         var myPlayerInfo:GameRolePlayHumanoidInformations = null;
         var myPlayerOption:* = undefined;
         var ogamsg:ObjectGroundAddedMessage = null;
         var ogrmsg:ObjectGroundRemovedMessage = null;
         var ogrmmsg:ObjectGroundRemovedMultipleMessage = null;
         var oglamsg:ObjectGroundListAddedMessage = null;
         var comptObjects:uint = 0;
         var prira:PaddockRemoveItemRequestAction = null;
         var prirmsg:PaddockRemoveItemRequestMessage = null;
         var pmira:PaddockMoveItemRequestAction = null;
         var cursorIcon:Texture = null;
         var iw:ItemWrapper = null;
         var gdpormsg:GameDataPaddockObjectRemoveMessage = null;
         var gdpoamsg:GameDataPaddockObjectAddMessage = null;
         var gdpolamsg:GameDataPaddockObjectListAddMessage = null;
         var gdpfoamsg:GameDataPlayFarmObjectAnimationMessage = null;
         var lmnqsum:ListMapNpcsQuestStatusUpdateMessage = null;
         var map:MapPosition = null;
         var nbQuest:int = 0;
         var quests:Array = null;
         var npc:TiphonSprite = null;
         var q:Quest = null;
         var scmsg:ShowCellMessage = null;
         var roleplayContextFrame2:RoleplayContextFrame = null;
         var name:String = null;
         var text:String = null;
         var sza:StartZoomAction = null;
         var player:DisplayObject = null;
         var scmamsg:SwitchCreatureModeAction = null;
         var grpmaapmsg:GameRolePlayMonsterAngryAtPlayerMessage = null;
         var monsterInfos:GameRolePlayGroupMonsterInformations = null;
         var grpmnaamsg:GameRolePlayMonsterNotAngryAtPlayerMessage = null;
         var ccFrame:ContextChangeFrame = null;
         var connexion:String = null;
         var mirmsg:MapInformationsRequestMessage = null;
         var mcidm:MapComplementaryInformationsDataMessage = null;
         var mciwcmsg:MapComplementaryInformationsWithCoordsMessage = null;
         var mcidihmsg:MapComplementaryInformationsDataInHouseMessage = null;
         var isPlayerHouse:Boolean = false;
         var newSubArea:SubArea = null;
         var actor:GameRolePlayActorInformations = null;
         var actor1:GameRolePlayActorInformations = null;
         var ac:AnimatedCharacter = null;
         var character:GameRolePlayCharacterInformations = null;
         var option:* = undefined;
         var dam:DelayedActionMessage = null;
         var hosu:HumanOptionSkillUse = null;
         var duration:uint = 0;
         var iumsg:InteractiveUsedMessage = null;
         var emote:Emoticon = null;
         var staticOnly:Boolean = false;
         var time:Date = null;
         var emoteAnimMsg:GameRolePlaySetAnimationMessage = null;
         var taxCollectorInfo:GameRolePlayTaxCollectorInformations = null;
         var taxCollector:TaxCollectorWrapper = null;
         var now:Number = NaN;
         var fightId:int = 0;
         var oldHousesList:Dictionary = null;
         var houseDoorKey:* = undefined;
         var houseWrapper:HouseWrapper = null;
         var house:HouseOnMapInformations = null;
         var numDoors:int = 0;
         var i:int = 0;
         var mo:MapObstacle = null;
         var mciamsg:MapComplementaryInformationsAnomalyMessage = null;
         var partyManagementFrame:PartyManagementFrame = null;
         var anomalyNid:uint = 0;
         var doorsLength:int = 0;
         var j:int = 0;
         var humi:HumanInformations = null;
         var infos:GameRolePlayHumanoidInformations = null;
         var rpInfos:GameRolePlayCharacterInformations = null;
         var actorInformation:GameRolePlayActorInformations = null;
         var fakeShowActorMsg:GameRolePlayShowActorMessage = null;
         var k:int = 0;
         var orientation:ActorOrientation = null;
         var myAura:Emoticon = null;
         var rpEmoticonFrame:EmoticonFrame = null;
         var emoteId2:uint = 0;
         var aura:Emoticon = null;
         var eprmsg:EmotePlayRequestMessage = null;
         var playerId:Number = NaN;
         var aggression:Aggression = null;
         var needUpdate:Boolean = false;
         var menuEntity:AnimatedCharacter = null;
         var menuItem:* = undefined;
         var ch:AnimatedCharacter = null;
         var modContextMenu:Object = null;
         var elementId:Number = NaN;
         var playerMessage:AgressableStatusMessage = null;
         var cell:uint = 0;
         var objectId:uint = 0;
         var item:PaddockItem = null;
         var cellId:uint = 0;
         var mapInfo:MapNpcQuestInfo = null;
         var l:uint = 0;
         var questId:int = 0;
         var mapQuests:Object = null;
         var rect:Rectangle = null;
         var id:* = undefined;
         var entity:* = undefined;
         var fightTeam:FightTeam = null;
         switch(true)
         {
            case msg is MapLoadedMessage:
               if(this._waitForMap)
               {
                  ccFrame = Kernel.getWorker().getFrame(ContextChangeFrame) as ContextChangeFrame;
                  connexion = "";
                  if(ccFrame)
                  {
                     connexion = ccFrame.mapChangeConnexion;
                  }
                  mirmsg = new MapInformationsRequestMessage();
                  mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                  ConnectionsHandler.getConnection().send(mirmsg,connexion);
                  this._waitForMap = false;
               }
               return false;
            case msg is MapComplementaryInformationsDataMessage:
               mcidmsg = msg as MapComplementaryInformationsDataMessage;
               currentMapHasChanged = false;
               currentSubAreaHasChanged = false;
               _interactiveElements = mcidmsg.interactiveElements;
               this._fightNumber = mcidmsg.fights.length;
               this._mapTotalRewardRate = 0;
               this._taxCollectorOnCurrentMap = null;
               TooltipManager.hide();
               if(!(msg is MapComplementaryInformationsBreachMessage))
               {
                  mcidm = msg as MapComplementaryInformationsDataMessage;
                  if(mcidm.subAreaId != DataEnum.SUBAREA_INFINITE_BREACH)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.BreachTeleport,false);
                  }
                  else
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.BreachTeleport,true);
                  }
                  if(PlayedCharacterManager.getInstance().isInBreach)
                  {
                     if(Berilia.getInstance().getUi("breachTracking"))
                     {
                        Berilia.getInstance().unloadUi("breachTracking");
                     }
                     PlayedCharacterManager.getInstance().isInBreach = false;
                     Kernel.getWorker().removeFrame(this._breachFrame);
                  }
               }
               if(PlayedCharacterManager.getInstance().isInHouse && !(msg is MapComplementaryInformationsDataInHouseMessage))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                  PlayedCharacterManager.getInstance().isInHouse = false;
                  PlayedCharacterManager.getInstance().isInHisHouse = false;
               }
               if(PlayedCharacterManager.getInstance().isIndoor && !(msg is MapComplementaryInformationsWithCoordsMessage))
               {
                  PlayedCharacterManager.getInstance().isIndoor = false;
               }
               if(msg is MapComplementaryInformationsWithCoordsMessage)
               {
                  mciwcmsg = msg as MapComplementaryInformationsWithCoordsMessage;
                  PlayedCharacterManager.getInstance().isIndoor = true;
                  _worldPoint = new WorldPointWrapper(mciwcmsg.mapId,true,mciwcmsg.worldX,mciwcmsg.worldY);
               }
               else if(msg is MapComplementaryInformationsDataInHouseMessage)
               {
                  mcidihmsg = msg as MapComplementaryInformationsDataInHouseMessage;
                  isPlayerHouse = PlayerManager.getInstance().nickname == mcidihmsg.currentHouse.houseInfos.ownerTag.nickname && PlayerManager.getInstance().tag == mcidihmsg.currentHouse.houseInfos.ownerTag.tagNumber;
                  PlayedCharacterManager.getInstance().isInHouse = true;
                  if(isPlayerHouse)
                  {
                     PlayedCharacterManager.getInstance().isInHisHouse = true;
                  }
                  this._housesList = new Dictionary();
                  this._housesList[0] = HouseWrapper.createInside(mcidihmsg.currentHouse);
                  KernelEventsManager.getInstance().processCallback(HookList.HouseEntered,isPlayerHouse,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY,this._housesList[0]);
                  _worldPoint = new WorldPointWrapper(mcidihmsg.mapId,true,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY);
               }
               else
               {
                  _worldPoint = new WorldPointWrapper(mcidmsg.mapId);
               }
               if(msg is MapComplementaryInformationsDataInHavenBagMessage)
               {
                  Kernel.getWorker().addFrame(new HavenbagFrame((msg as MapComplementaryInformationsDataInHavenBagMessage).roomId,(msg as MapComplementaryInformationsDataInHavenBagMessage).theme,(msg as MapComplementaryInformationsDataInHavenBagMessage).ownerInformations));
                  PlayedCharacterManager.getInstance().isInHavenbag = true;
               }
               else if(HavenbagTheme.isMapIdInHavenbag(mcidmsg.mapId))
               {
                  Atouin.getInstance().showWorld(true);
               }
               roleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
               previousMap = PlayedCharacterManager.getInstance().currentMap;
               if(roleplayContextFrame.newCurrentMapIsReceived || previousMap.mapId != _worldPoint.mapId || previousMap.outdoorX != _worldPoint.outdoorX || previousMap.outdoorY != _worldPoint.outdoorY)
               {
                  currentMapHasChanged = true;
                  PlayedCharacterManager.getInstance().currentMap = _worldPoint;
                  this.initNewMap();
               }
               roleplayContextFrame.newCurrentMapIsReceived = false;
               if(_currentSubAreaId != mcidmsg.subAreaId || !PlayedCharacterManager.getInstance().currentSubArea)
               {
                  currentSubAreaHasChanged = true;
                  _currentSubAreaId = mcidmsg.subAreaId;
                  newSubArea = SubArea.getSubAreaById(_currentSubAreaId);
                  PlayedCharacterManager.getInstance().currentSubArea = newSubArea;
               }
               this._playersId = [];
               this._monstersIds = new Vector.<Number>();
               for each(actor in mcidmsg.actors)
               {
                  if(actor.contextualId > 0)
                  {
                     this._playersId.push(actor.contextualId);
                  }
                  else if(actor is GameRolePlayGroupMonsterInformations)
                  {
                     this._monstersIds.push(actor.contextualId);
                  }
               }
               updateCreaturesLimit();
               _entitiesVisibleNumber = this._playersId.length + this._monstersIds.length;
               _creaturesMode = _creaturesLimit == 0 || _creaturesLimit < 50 && _entitiesVisibleNumber >= _creaturesLimit;
               mapWithNoMonsters = true;
               emoteId = 0;
               emoteStartTime = 0;
               for each(actor1 in mcidmsg.actors)
               {
                  ac = this.addOrUpdateActor(actor1) as AnimatedCharacter;
                  if(ac)
                  {
                     if(ac.id == PlayedCharacterManager.getInstance().id)
                     {
                        if(ac.libraryIsAvailable)
                        {
                           this.updateUsableEmotesListInit(ac.look);
                        }
                        else
                        {
                           ac.addEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
                        }
                        if(this.dispatchPlayerNewLook)
                        {
                           KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange,ac.look);
                           this.dispatchPlayerNewLook = false;
                        }
                     }
                     if(actor1 is GameRolePlayCharacterInformations)
                     {
                        character = actor1 as GameRolePlayCharacterInformations;
                        if(character)
                        {
                           emoteId = 0;
                           emoteStartTime = 0;
                           for each(option in character.humanoidInfo.options)
                           {
                              if(option is HumanOptionEmote)
                              {
                                 emoteId = option.emoteId;
                                 emoteStartTime = option.emoteStartTime;
                              }
                              else if(option is HumanOptionObjectUse)
                              {
                                 dam = new DelayedActionMessage(character.contextualId,option.objectGID,option.delayEndTime);
                                 Kernel.getWorker().process(dam);
                              }
                              else if(option is HumanOptionSkillUse)
                              {
                                 hosu = option as HumanOptionSkillUse;
                                 duration = hosu.skillEndTime - TimeManager.getInstance().getUtcTimestamp();
                                 duration /= 100;
                                 if(duration > 0)
                                 {
                                    iumsg = new InteractiveUsedMessage();
                                    iumsg.initInteractiveUsedMessage(character.contextualId,hosu.elementId,hosu.skillId,duration);
                                    Kernel.getWorker().process(iumsg);
                                 }
                              }
                           }
                           if(emoteId > 0)
                           {
                              emote = Emoticon.getEmoticonById(emoteId);
                              if(emote && emote.persistancy)
                              {
                                 this._currentEmoticon = emote.id;
                                 if(!emote.aura)
                                 {
                                    staticOnly = false;
                                    time = new Date();
                                    if(time.getTime() - emoteStartTime >= emote.duration)
                                    {
                                       staticOnly = true;
                                    }
                                    emoteAnimMsg = new GameRolePlaySetAnimationMessage(actor1,emote.getAnimName(),emote.spellLevelId,emoteStartTime,!emote.persistancy,emote.eight_directions,staticOnly);
                                    if(ac.rendered)
                                    {
                                       this.process(emoteAnimMsg);
                                    }
                                    else
                                    {
                                       if(emoteAnimMsg.playStaticOnly)
                                       {
                                          ac.visible = false;
                                       }
                                       this._waitingEmotesAnims[ac.id] = emoteAnimMsg;
                                       ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
                                       ac.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
                                    }
                                 }
                              }
                           }
                        }
                     }
                     else if(actor1 is GameRolePlayTaxCollectorInformations)
                     {
                        taxCollectorInfo = actor1 as GameRolePlayTaxCollectorInformations;
                        if(taxCollectorInfo.taxCollectorAttack > 0)
                        {
                           taxCollector = new TaxCollectorWrapper();
                           taxCollector.lastName = TaxCollectorName.getTaxCollectorNameById(taxCollectorInfo.identification.lastNameId).name;
                           taxCollector.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(taxCollectorInfo.identification.firstNameId).firstname;
                           taxCollector.alliance = AllianceWrapper.getFromNetwork(taxCollectorInfo.identification.allianceIdentity);
                           now = TimeManager.getInstance().getTimestamp();
                           taxCollector.attackTimestamp = now + taxCollectorInfo.taxCollectorAttack * TimeApi.MINUTE_TO_MILLISECOND;
                           this._taxCollectorOnCurrentMap = taxCollector;
                        }
                     }
                  }
                  if(mapWithNoMonsters)
                  {
                     if(actor1 is GameRolePlayGroupMonsterInformations)
                     {
                        mapWithNoMonsters = false;
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.MapWithMonsters);
                     }
                  }
                  if(actor1 is GameRolePlayCharacterInformations)
                  {
                     ChatAutocompleteNameManager.getInstance().addEntry((actor1 as GameRolePlayCharacterInformations).name,0);
                  }
               }
               this.switchPokemonMode();
               thisFightExists = false;
               fightIdsToRemove = [];
               for each(fight in mcidmsg.fights)
               {
                  thisFightExists = false;
                  for each(fightCache in this._fights)
                  {
                     if(fight.fightId == fightCache.fightId)
                     {
                        thisFightExists = true;
                     }
                  }
                  if(!thisFightExists)
                  {
                     this.addFight(fight);
                  }
               }
               for each(fightCache in this._fights)
               {
                  thisFightExists = false;
                  for each(fight in mcidmsg.fights)
                  {
                     if(fight.fightId == fightCache.fightId)
                     {
                        thisFightExists = true;
                     }
                  }
                  if(!thisFightExists)
                  {
                     fightIdsToRemove.push(fightCache.fightId);
                  }
               }
               for each(fightId in fightIdsToRemove)
               {
                  delete this._fights[fightId];
               }
               if(mcidmsg.houses && mcidmsg.houses.length > 0)
               {
                  oldHousesList = new Dictionary();
                  for(houseDoorKey in this._housesList)
                  {
                     oldHousesList[houseDoorKey] = this._housesList[houseDoorKey];
                  }
                  this._housesList = new Dictionary();
                  for each(house in mcidmsg.houses)
                  {
                     if(house.doorsOnMap.length != 0)
                     {
                        if(oldHousesList[house.doorsOnMap[0]] && oldHousesList[house.doorsOnMap[0]].houseId == house.houseId)
                        {
                           houseWrapper = oldHousesList[house.doorsOnMap[0]];
                        }
                        else
                        {
                           houseWrapper = HouseWrapper.create(house);
                           houseWrapper.worldmapId = Math.floor(_worldPoint.mapId);
                           houseWrapper.worldX = _worldPoint.outdoorX;
                           houseWrapper.worldY = _worldPoint.outdoorY;
                        }
                        numDoors = house.doorsOnMap.length;
                        for(i = 0; i < numDoors; i++)
                        {
                           this._housesList[house.doorsOnMap[i]] = houseWrapper;
                        }
                     }
                  }
                  oldHousesList = new Dictionary();
               }
               if(currentMapHasChanged)
               {
                  for each(mo in mcidmsg.obstacles)
                  {
                     InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId,mo.state == MapObstacleStateEnum.OBSTACLE_OPENED);
                  }
               }
               rpIntFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               imumsg = new InteractiveMapUpdateMessage();
               imumsg.initInteractiveMapUpdateMessage(mcidmsg.interactiveElements);
               rpIntFrame.process(imumsg);
               smumsg = new StatedMapUpdateMessage();
               smumsg.initStatedMapUpdateMessage(mcidmsg.statedElements);
               rpIntFrame.process(smumsg);
               if(currentMapHasChanged || currentSubAreaHasChanged)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData,PlayedCharacterManager.getInstance().currentMap,_currentSubAreaId,Dofus.getInstance().options.getOption("mapCoordinates"));
               }
               if(msg is MapComplementaryInformationsAnomalyMessage)
               {
                  mciamsg = msg as MapComplementaryInformationsAnomalyMessage;
                  KernelEventsManager.getInstance().processCallback(HookList.AnomalyMapInfos,SubArea.getSubAreaById(mciamsg.subAreaId).level,mciamsg.closingTime);
                  PlayedCharacterManager.getInstance().isInAnomaly = true;
               }
               else if(PlayedCharacterManager.getInstance().isInAnomaly)
               {
                  PlayedCharacterManager.getInstance().isInAnomaly = false;
               }
               if(currentMapHasChanged && OptionManager.getOptionManager("dofus").getOption("allowAnimsFun"))
               {
                  AnimFunManager.getInstance().initializeByMap(mcidmsg.mapId);
               }
               if(Kernel.getWorker().contains(EntitiesTooltipsFrame))
               {
                  (Kernel.getWorker().getFrame(EntitiesTooltipsFrame) as EntitiesTooltipsFrame).update();
               }
               if(Kernel.getWorker().contains(InfoEntitiesFrame))
               {
                  (Kernel.getWorker().getFrame(InfoEntitiesFrame) as InfoEntitiesFrame).update();
               }
               if(Kernel.getWorker().contains(PartyManagementFrame))
               {
                  partyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
                  if(partyManagementFrame.playerShouldReceiveRewards)
                  {
                     KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaLeagueRewards,partyManagementFrame.playerRewards.seasonId,partyManagementFrame.playerRewards.leagueId,partyManagementFrame.playerRewards.ladderPosition,partyManagementFrame.playerRewards.endSeasonReward);
                     partyManagementFrame.playerShouldReceiveRewards = false;
                     partyManagementFrame.playerRewards = null;
                  }
               }
               stackFrame = Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame;
               stackFrame.resumeStack();
               if(currentMapHasChanged)
               {
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_MAP);
               }
               return false;
            case msg is AnomalyStateMessage:
               taimsg = msg as AnomalyStateMessage;
               KernelEventsManager.getInstance().processCallback(HookList.AnomalyState,taimsg.open,taimsg.closingTime,taimsg.subAreaId);
               return true;
            case msg is AnomalyOpenedMessage:
               aomsg = msg as AnomalyOpenedMessage;
               dataStoreType = new DataStoreType("Module_Ankama_Cartography",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
               if(StoreDataManager.getInstance().getData(dataStoreType,"anomalynotificationdata"))
               {
                  anomalyNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.anomaly.name"),I18n.getUiText("ui.anomaly.notification",[HyperlinkZaapPosition.getLink(aomsg.subAreaId)]),NotificationTypeEnum.SERVER_INFORMATION,"anomaly_" + aomsg.subAreaId,false,false);
                  NotificationManager.getInstance().sendNotification(anomalyNid);
               }
               return true;
            case msg is SubareaRewardRateMessage:
               srrmsg = msg as SubareaRewardRateMessage;
               this._mapTotalRewardRate = srrmsg.subAreaRate;
               KernelEventsManager.getInstance().processCallback(HookList.MapRewardRate,srrmsg.subAreaRate);
               return true;
            case msg is BreachTeleportRequestAction:
               btrmsg = new BreachTeleportRequestMessage();
               btrmsg.initBreachTeleportRequestMessage();
               ConnectionsHandler.getConnection().send(btrmsg);
               return true;
            case msg is BreachTeleportResponseMessage:
               btrespmsg = msg as BreachTeleportResponseMessage;
               KernelEventsManager.getInstance().processCallback(HookList.BreachTeleport,btrespmsg.teleported);
               return true;
            case msg is BreachEnterMessage:
               bemsg = msg as BreachEnterMessage;
               PlayedCharacterManager.getInstance().isInBreach = true;
               if(!Kernel.getWorker().getFrame(BreachFrame))
               {
                  this._breachFrame = new BreachFrame();
                  this._breachFrame.ownerId = bemsg.owner;
                  Kernel.getWorker().addFrame(this._breachFrame);
               }
               else
               {
                  this._breachFrame = Kernel.getWorker().getFrame(BreachFrame) as BreachFrame;
                  this._breachFrame.ownerId = bemsg.owner;
               }
               return true;
            case msg is BreachExitResponseMessage:
               KernelEventsManager.getInstance().processCallback(HookList.BreachTeleport,false);
               if(PlayedCharacterManager.getInstance().isInBreach)
               {
                  if(Berilia.getInstance().getUi("breachTracking"))
                  {
                     Berilia.getInstance().unloadUi("breachTracking");
                  }
                  PlayedCharacterManager.getInstance().isInBreach = false;
                  Kernel.getWorker().removeFrame(this._breachFrame);
               }
               return true;
            case msg is HousePropertiesMessage:
               hpmsg = msg as HousePropertiesMessage;
               if(!this._housesList)
               {
                  return true;
               }
               houseInstanceInfo = hpmsg.properties;
               if(this._housesList[0])
               {
                  for(h in this._housesList[0].houseInstances)
                  {
                     if(this._housesList[0].houseInstances[h].id == houseInstanceInfo.instanceId)
                     {
                        houseInstanceWrapper = HouseInstanceWrapper.create(houseInstanceInfo);
                        this._housesList[0].houseInstances[h] = houseInstanceWrapper;
                     }
                  }
               }
               else
               {
                  doorsLength = hpmsg.doorsOnMap.length;
                  for(j = 0; j < doorsLength; j++)
                  {
                     for(h in this._housesList[hpmsg.doorsOnMap[j]].houseInstances)
                     {
                        if(this._housesList[hpmsg.doorsOnMap[j]].houseInstances[h].id == houseInstanceInfo.instanceId)
                        {
                           houseInstanceWrapper = HouseInstanceWrapper.create(houseInstanceInfo,this._housesList[hpmsg.doorsOnMap[j]].houseInstances[h].indexOfThisInstanceForTheOwner);
                           this._housesList[hpmsg.doorsOnMap[j]].houseInstances[h] = houseInstanceWrapper;
                        }
                     }
                  }
               }
               return true;
               break;
            case msg is GameRolePlayShowActorMessage:
               if(Kernel.getWorker().avoidFlood(getQualifiedClassName(msg)))
               {
                  return true;
               }
               grpsamsg = msg as GameRolePlayShowActorMessage;
               if(grpsamsg.informations.contextualId == PlayedCharacterManager.getInstance().id)
               {
                  humi = (grpsamsg.informations as GameRolePlayHumanoidInformations).humanoidInfo as HumanInformations;
                  PlayedCharacterManager.getInstance().restrictions = humi.restrictions;
                  PlayedCharacterManager.getInstance().infos.entityLook = grpsamsg.informations.look;
                  infos = getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayHumanoidInformations;
                  if(infos)
                  {
                     infos.humanoidInfo.restrictions = PlayedCharacterManager.getInstance().restrictions;
                  }
               }
               animatedCharacter = DofusEntities.getEntity(grpsamsg.informations.contextualId) as AnimatedCharacter;
               if(animatedCharacter && animatedCharacter.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == -1)
               {
                  animatedCharacter.visibleAura = false;
               }
               if(!animatedCharacter)
               {
                  updateCreaturesLimit();
               }
               animatedCharacter = this.addOrUpdateActor(grpsamsg.informations);
               if(animatedCharacter && grpsamsg.informations.contextualId == PlayedCharacterManager.getInstance().id)
               {
                  if(animatedCharacter.libraryIsAvailable)
                  {
                     this.updateUsableEmotesListInit(animatedCharacter.look);
                  }
                  else
                  {
                     animatedCharacter.addEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
                  }
               }
               if(this.switchPokemonMode())
               {
                  return true;
               }
               if(grpsamsg.informations is GameRolePlayCharacterInformations)
               {
                  ChatAutocompleteNameManager.getInstance().addEntry((grpsamsg.informations as GameRolePlayCharacterInformations).name,0);
               }
               if(grpsamsg.informations is GameRolePlayCharacterInformations && PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE)
               {
                  rpInfos = grpsamsg.informations as GameRolePlayCharacterInformations;
                  switch(PlayedCharacterManager.getInstance().levelDiff(int(rpInfos.alignmentInfos.characterPower - grpsamsg.informations.contextualId)))
                  {
                     case -1:
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_WEAK);
                        break;
                     case 1:
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_STRONG);
                  }
               }
               if(OptionManager.getOptionManager("dofus").getOption("allowAnimsFun") && grpsamsg.informations is GameRolePlayGroupMonsterInformations)
               {
                  AnimFunManager.getInstance().restart();
               }
               return true;
               break;
            case msg is GameRolePlayShowMultipleActorsMessage:
               grpsmamsg = msg as GameRolePlayShowMultipleActorsMessage;
               for each(actorInformation in grpsmamsg.informationsList)
               {
                  fakeShowActorMsg = new GameRolePlayShowActorMessage();
                  fakeShowActorMsg.informations = actorInformation;
                  this.process(fakeShowActorMsg);
               }
               return true;
            case msg is GameContextRefreshEntityLookMessage:
               if(Kernel.getWorker().avoidFlood(getQualifiedClassName(msg)))
               {
                  return true;
               }
               gcrelmsg = msg as GameContextRefreshEntityLookMessage;
               animatedCharacter = this.updateActorLook(gcrelmsg.id,gcrelmsg.look,true);
               if(animatedCharacter && gcrelmsg.id == PlayedCharacterManager.getInstance().id)
               {
                  if(animatedCharacter.libraryIsAvailable)
                  {
                     this.updateUsableEmotesListInit(animatedCharacter.look);
                  }
                  else
                  {
                     animatedCharacter.addEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
                  }
               }
               return true;
               break;
            case msg is GameMapChangeOrientationMessage:
               gmcomsg = msg as GameMapChangeOrientationMessage;
               updateActorOrientation(gmcomsg.orientation.id,gmcomsg.orientation.direction);
               return true;
            case msg is GameMapChangeOrientationsMessage:
               gmcomsg2 = msg as GameMapChangeOrientationsMessage;
               num = gmcomsg2.orientations.length;
               for(k = 0; k < num; k++)
               {
                  orientation = gmcomsg2.orientations[k];
                  updateActorOrientation(orientation.id,orientation.direction);
               }
               return true;
            case msg is GameRolePlaySetAnimationMessage:
               grsamsg = msg as GameRolePlaySetAnimationMessage;
               characterEntity = DofusEntities.getEntity(grsamsg.informations.contextualId) as AnimatedCharacter;
               if(!characterEntity)
               {
                  _log.error("GameRolePlaySetAnimationMessage : l\'entitée " + grsamsg.informations.contextualId + " n\'a pas ete trouvee");
                  return true;
               }
               this.playAnimationOnEntity(characterEntity,grsamsg.animation,grsamsg.spellLevelId,grsamsg.directions8,grsamsg.duration,grsamsg.playStaticOnly);
               return true;
               break;
            case msg is EntityMovementCompleteMessage:
               emcm = msg as EntityMovementCompleteMessage;
               entityMovementComplete = emcm.entity as AnimatedCharacter;
               if(_entities[entityMovementComplete.getRootEntity().id])
               {
                  (_entities[entityMovementComplete.getRootEntity().id] as GameContextActorInformations).disposition.cellId = entityMovementComplete.position.cellId;
               }
               if(_entitiesIcons[emcm.entity.id])
               {
                  _entitiesIcons[emcm.entity.id].needUpdate = true;
               }
               return false;
            case msg is EntityMovementStoppedMessage:
               emsm = msg as EntityMovementStoppedMessage;
               if(_entitiesIcons[emsm.entity.id])
               {
                  _entitiesIcons[emsm.entity.id].needUpdate = true;
               }
               return false;
            case msg is CharacterMovementStoppedMessage:
               characterEntityStopped = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
               if(OptionManager.getOptionManager("tiphon").getOption("auraMode") > OptionEnum.AURA_NONE && OptionManager.getOptionManager("tiphon").getOption("alwaysShowAuraOnFront") && characterEntityStopped.getDirection() == DirectionsEnum.DOWN && characterEntityStopped.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) != -1 && PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
               {
                  rpEmoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
                  for each(emoteId2 in rpEmoticonFrame.emotes)
                  {
                     aura = Emoticon.getEmoticonById(emoteId2);
                     if(aura && aura.aura)
                     {
                        if(!myAura || aura.weight > myAura.weight)
                        {
                           myAura = aura;
                        }
                     }
                  }
                  if(myAura)
                  {
                     eprmsg = new EmotePlayRequestMessage();
                     eprmsg.initEmotePlayRequestMessage(myAura.id);
                     ConnectionsHandler.getConnection().send(eprmsg);
                  }
               }
               return true;
            case msg is GameRolePlayShowChallengeMessage:
               grpsclmsg = msg as GameRolePlayShowChallengeMessage;
               this.addFight(grpsclmsg.commonsInfos);
               return true;
            case msg is GameFightOptionStateUpdateMessage:
               gfosumsg = msg as GameFightOptionStateUpdateMessage;
               this.updateSwordOptions(gfosumsg.fightId,gfosumsg.teamId,gfosumsg.option,gfosumsg.state);
               KernelEventsManager.getInstance().processCallback(HookList.GameFightOptionStateUpdate,gfosumsg.fightId,gfosumsg.teamId,gfosumsg.option,gfosumsg.state);
               return true;
            case msg is GameFightUpdateTeamMessage:
               gfutmsg = msg as GameFightUpdateTeamMessage;
               this.updateFight(gfutmsg.fightId,gfutmsg.team);
               return true;
            case msg is GameFightRemoveTeamMemberMessage:
               gfrtmmsg = msg as GameFightRemoveTeamMemberMessage;
               this.removeFighter(gfrtmmsg.fightId,gfrtmmsg.teamId,gfrtmmsg.charId);
               return true;
            case msg is GameRolePlayRemoveChallengeMessage:
               grprcmsg = msg as GameRolePlayRemoveChallengeMessage;
               KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayRemoveFight,grprcmsg.fightId);
               this.removeFight(grprcmsg.fightId);
               return true;
            case msg is GameContextRemoveElementMessage:
               gcremsg = msg as GameContextRemoveElementMessage;
               delete this._lastStaticAnimations[gcremsg.id];
               playerCompt = 0;
               for each(playerId in this._playersId)
               {
                  if(playerId == gcremsg.id)
                  {
                     this._playersId.splice(playerCompt,1);
                  }
                  else
                  {
                     playerCompt++;
                  }
               }
               monsterId = this._monstersIds.indexOf(gcremsg.id);
               if(monsterId != -1)
               {
                  this._monstersIds.splice(monsterId,1);
               }
               if(_entitiesIconsNames[gcremsg.id])
               {
                  delete _entitiesIconsNames[gcremsg.id];
               }
               if(_entitiesIcons[gcremsg.id])
               {
                  removeIcon(gcremsg.id);
               }
               delete this._waitingEmotesAnims[gcremsg.id];
               this.removeEntityListeners(gcremsg.id);
               for each(aggression in this._aggressions)
               {
                  if(aggression.playerId == gcremsg.id || aggression.monsterId == gcremsg.id)
                  {
                     this.removeAggression(aggression.monsterId);
                  }
               }
               removeActor(gcremsg.id);
               if(OptionManager.getOptionManager("dofus").getOption("allowAnimsFun") && monsterId != -1)
               {
                  AnimFunManager.getInstance().restart();
               }
               contextMenu = Berilia.getInstance().getUi("multiplayerMenu");
               if(contextMenu)
               {
                  for each(menuItem in contextMenu.properties[0])
                  {
                     ch = menuItem.callbackArgs[0];
                     if(ch.id == gcremsg.id)
                     {
                        needUpdate = true;
                     }
                     else if(!menuEntity)
                     {
                        menuEntity = ch;
                     }
                  }
                  if(needUpdate)
                  {
                     if(menuEntity)
                     {
                        modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                        modContextMenu.closeAllMenu();
                        modContextMenu.createContextMenu(MenusFactory.create(getEntityInfos(menuEntity.id),"multiplayer",[menuEntity]),null,null,"multiplayerMenu");
                     }
                     else
                     {
                        Berilia.getInstance().unloadUi("multiplayerMenu");
                     }
                  }
               }
               return true;
            case msg is GameContextRemoveMultipleElementsMessage:
               gcrmemsg = msg as GameContextRemoveMultipleElementsMessage;
               fakeRemoveElementMessage = new GameContextRemoveElementMessage();
               for each(elementId in gcrmemsg.elementsIds)
               {
                  fakeRemoveElementMessage.id = elementId;
                  this.process(fakeRemoveElementMessage);
               }
               return true;
            case msg is MapFightCountMessage:
               mfcmsg = msg as MapFightCountMessage;
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,mfcmsg.fightCount);
               return true;
            case msg is UpdateMapPlayersAgressableStatusMessage:
               umpasm = msg as UpdateMapPlayersAgressableStatusMessage;
               asmsg = umpasm.playerAvAMessages;
               hasAllianceInfo = false;
               for each(playerMessage in asmsg)
               {
                  playerInfo = getEntityInfos(playerMessage.playerId) as GameRolePlayHumanoidInformations;
                  if(playerInfo)
                  {
                     for each(playerOption in playerInfo.humanoidInfo.options)
                     {
                        if(playerOption is HumanOptionAlliance)
                        {
                           hasAllianceInfo = true;
                           (playerOption as HumanOptionAlliance).aggressable = playerMessage.enable;
                           this.updateConquestIcon(playerMessage.playerId,playerMessage.roleAvAId,playerMessage.pictoScore);
                           break;
                        }
                     }
                     if(!hasAllianceInfo)
                     {
                        removeIconsCategory(playerMessage.playerId,EntityIconEnum.AVA_CATEGORY);
                     }
                  }
               }
               return true;
            case msg is UpdateSelfAgressableStatusMessage:
               usasm = msg as UpdateSelfAgressableStatusMessage;
               myPlayerInfo = getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayHumanoidInformations;
               if(myPlayerInfo)
               {
                  for each(myPlayerOption in myPlayerInfo.humanoidInfo.options)
                  {
                     if(myPlayerOption is HumanOptionAlliance)
                     {
                        (myPlayerOption as HumanOptionAlliance).aggressable = usasm.status;
                        break;
                     }
                  }
               }
               if(PlayedCharacterManager.getInstance().characteristics)
               {
                  PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = usasm.status;
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange,usasm.status,usasm.probationTime);
               this.updateConquestIcon(PlayedCharacterManager.getInstance().id,usasm.roleAvAId,usasm.pictoScore);
               return true;
            case msg is KohOverAction:
               removeCategoryForAllEntities(EntityIconEnum.AVA_CATEGORY);
               return true;
            case msg is ObjectGroundAddedMessage:
               ogamsg = msg as ObjectGroundAddedMessage;
               this.addObject(ogamsg.objectGID,ogamsg.cellId);
               return true;
            case msg is ObjectGroundRemovedMessage:
               ogrmsg = msg as ObjectGroundRemovedMessage;
               this.removeObject(ogrmsg.cell);
               return true;
            case msg is ObjectGroundRemovedMultipleMessage:
               ogrmmsg = msg as ObjectGroundRemovedMultipleMessage;
               for each(cell in ogrmmsg.cells)
               {
                  this.removeObject(cell);
               }
               return true;
            case msg is ObjectGroundListAddedMessage:
               oglamsg = msg as ObjectGroundListAddedMessage;
               comptObjects = 0;
               for each(objectId in oglamsg.referenceIds)
               {
                  this.addObject(objectId,oglamsg.cells[comptObjects]);
                  comptObjects++;
               }
               return true;
            case msg is PaddockRemoveItemRequestAction:
               prira = msg as PaddockRemoveItemRequestAction;
               prirmsg = new PaddockRemoveItemRequestMessage();
               prirmsg.initPaddockRemoveItemRequestMessage(prira.cellId);
               ConnectionsHandler.getConnection().send(prirmsg);
               return true;
            case msg is PaddockMoveItemRequestAction:
               pmira = msg as PaddockMoveItemRequestAction;
               this._currentPaddockItemCellId = pmira.object.disposition.cellId;
               cursorIcon = new Texture();
               iw = ItemWrapper.create(0,0,pmira.object.item.id,0,null,false);
               cursorIcon.uri = iw.iconUri;
               cursorIcon.finalize();
               PointCellFrame.getInstance().setPointCellParameters(this.onCellPointed,cursorIcon,true,this.paddockCellValidator,true);
               Kernel.getWorker().addFrame(PointCellFrame.getInstance() as Frame);
               return true;
            case msg is GameDataPaddockObjectRemoveMessage:
               gdpormsg = msg as GameDataPaddockObjectRemoveMessage;
               this.removePaddockItem(gdpormsg.cellId);
               return true;
            case msg is GameDataPaddockObjectAddMessage:
               gdpoamsg = msg as GameDataPaddockObjectAddMessage;
               this.addPaddockItem(gdpoamsg.paddockItemDescription);
               return true;
            case msg is GameDataPaddockObjectListAddMessage:
               gdpolamsg = msg as GameDataPaddockObjectListAddMessage;
               for each(item in gdpolamsg.paddockItemDescription)
               {
                  this.addPaddockItem(item);
               }
               return true;
            case msg is GameDataPlayFarmObjectAnimationMessage:
               gdpfoamsg = msg as GameDataPlayFarmObjectAnimationMessage;
               for each(cellId in gdpfoamsg.cellId)
               {
                  this.activatePaddockItem(cellId);
               }
               return true;
            case msg is ListMapNpcsQuestStatusUpdateMessage:
               lmnqsum = msg as ListMapNpcsQuestStatusUpdateMessage;
               quests = [];
               q = null;
               for each(npc in this._npcList)
               {
                  this.removeBackground(npc);
               }
               for each(mapInfo in lmnqsum.mapInfo)
               {
                  if(MapDisplayManager.getInstance().currentMapPoint.mapId == mapInfo.mapId)
                  {
                     this.addNpcClip(mapInfo);
                  }
                  nbQuest = 0;
                  for(l = 0; l < mapInfo.npcsIdsWithQuest.length; l++)
                  {
                     for each(questId in mapInfo.questFlags[l].questsToStartId)
                     {
                        q = Quest.getQuestById(questId);
                        if(q != null && mapInfo.questFlags[l].questsToStartId.indexOf(q.id) != -1)
                        {
                           nbQuest++;
                        }
                     }
                  }
                  if(nbQuest > 0)
                  {
                     map = MapPosition.getMapPositionById(mapInfo.mapId);
                     for each(mapQuests in quests)
                     {
                        if(mapQuests.x == map.posX && mapQuests.y == map.posY)
                        {
                           mapQuests.nb += nbQuest;
                           nbQuest = 0;
                           break;
                        }
                     }
                     if(nbQuest > 0)
                     {
                        quests.push({
                           "id":"quests_" + map.id,
                           "x":map.posX,
                           "y":map.posY,
                           "nb":nbQuest
                        });
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.RefreshMapQuests,quests);
               return true;
            case msg is ShowCellMessage:
               scmsg = msg as ShowCellMessage;
               HyperlinkShowCellManager.showCell(scmsg.cellId);
               roleplayContextFrame2 = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
               name = roleplayContextFrame2.getActorName(scmsg.sourceId);
               text = I18n.getUiText("ui.fight.showCell",[name,"{cell," + scmsg.cellId + "::" + scmsg.cellId + "}"]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is StartZoomAction:
               sza = msg as StartZoomAction;
               if(Atouin.getInstance().currentZoom != 1)
               {
                  Atouin.getInstance().cancelZoom();
                  KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
                  updateAllIcons();
                  return true;
               }
               player = DofusEntities.getEntity(sza.playerId) as DisplayObject;
               if(player && player.stage)
               {
                  rect = player.getRect(Atouin.getInstance().worldContainer);
                  Atouin.getInstance().zoom(sza.value,rect.x + rect.width / 2,rect.y + rect.height / 2);
                  KernelEventsManager.getInstance().processCallback(HookList.StartZoom,true);
                  updateAllIcons();
               }
               return true;
               break;
            case msg is SwitchCreatureModeAction:
               scmamsg = msg as SwitchCreatureModeAction;
               if(_creaturesMode != scmamsg.isActivated)
               {
                  _creaturesMode = scmamsg.isActivated;
                  for(id in _entities)
                  {
                     this.updateActorLook(id,(_entities[id] as GameContextActorInformations).look);
                  }
               }
               return true;
            case msg is MapZoomMessage:
               for each(entity in _entities)
               {
                  fightTeam = entity as FightTeam;
                  if(fightTeam && fightTeam.fight && fightTeam.teamInfos)
                  {
                     this.updateSwordOptions(fightTeam.fight.fightId,fightTeam.teamInfos.teamId);
                  }
               }
               return true;
            case msg is GameRolePlayMonsterAngryAtPlayerMessage:
               grpmaapmsg = msg as GameRolePlayMonsterAngryAtPlayerMessage;
               monsterInfos = getEntityInfos(grpmaapmsg.monsterGroupId) as GameRolePlayGroupMonsterInformations;
               if(!monsterInfos || grpmaapmsg.playerId != PlayedCharacterManager.getInstance().id)
               {
                  return true;
               }
               if(!this._aggroTimeoutIdsMonsterAssoc[grpmaapmsg.monsterGroupId])
               {
                  this._aggroTimeoutIdsMonsterAssoc[grpmaapmsg.monsterGroupId] = new Vector.<uint>(0);
               }
               this._aggroTimeoutIdsMonsterAssoc[grpmaapmsg.monsterGroupId].push(setTimeout(this.onMonsterAngryAtPlayer,Math.max(grpmaapmsg.angryStartTime - TimeManager.getInstance().getUtcTimestamp(),0),grpmaapmsg.playerId,grpmaapmsg.monsterGroupId,grpmaapmsg.attackTime));
               return true;
               break;
            case msg is GameRolePlayMonsterNotAngryAtPlayerMessage:
               grpmnaamsg = msg as GameRolePlayMonsterNotAngryAtPlayerMessage;
               this.removeAggression(grpmnaamsg.monsterGroupId);
               return true;
            default:
               return false;
         }
      }
      
      private function playAnimationOnEntity(characterEntity:AnimatedCharacter, animation:String, spellLevelId:uint, directions8:Boolean, duration:uint, playStaticOnly:Boolean) : void
      {
         var f:Follower = null;
         var rider:TiphonSprite = null;
         var context:SpellCastSequenceContext = null;
         var castSequence:SpellCastSequence = null;
         var scriptContexts:Vector.<SpellScriptContext> = null;
         var availableDirection:Array = null;
         var characterDirection:uint = 0;
         var nearestDirection:uint = 0;
         if(_creaturesMode)
         {
            characterEntity.visible = true;
         }
         else if(animation == null)
         {
            if(!directions8)
            {
               if(characterEntity.getDirection() % 2 == 0)
               {
                  characterEntity.setDirection(characterEntity.getDirection() + 1);
               }
            }
            this._emoteTimesBySprite[characterEntity.name] = duration;
            characterEntity.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
            rider = characterEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
            if(rider)
            {
               rider.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
            }
            context = new SpellCastSequenceContext();
            context.casterId = characterEntity.id;
            context.spellLevelData = SpellLevel.getLevelById(spellLevelId);
            context.spellData = context.spellLevelData.spell;
            context.targetedCellId = characterEntity.position !== null ? int(characterEntity.position.cellId) : -1;
            castSequence = new SpellCastSequence(context);
            scriptContexts = SpellScriptManager.getInstance().resolveScriptUsageFromCastContext(castSequence.context);
            SpellScriptManager.getInstance().runBulk(scriptContexts,castSequence,new Callback(this.executeSpellBuffer,castSequence),new Callback(this.executeSpellBuffer,castSequence));
         }
         else if(animation == AnimationEnum.ANIM_STATIQUE)
         {
            this._currentEmoticon = 0;
            characterEntity.setAnimation(animation);
            this._emoteTimesBySprite[characterEntity.name] = 0;
         }
         else
         {
            availableDirection = characterEntity.getAvaibleDirection(animation,true);
            characterDirection = characterEntity.getDirection();
            if(availableDirection.length != 8 || availableDirection.indexOf(characterDirection) == -1)
            {
               nearestDirection = this.getNearestAvailableDirection(availableDirection,characterDirection);
               if(nearestDirection < 8)
               {
                  characterEntity.setDirection(nearestDirection);
               }
            }
            if(!characterEntity.hasAnimation(animation,characterEntity.getDirection()))
            {
               _log.error("L\'animation " + animation + "_" + characterEntity.getDirection() + " est introuvable.");
               characterEntity.visible = true;
            }
            else
            {
               this._emoteTimesBySprite[characterEntity.name] = duration;
               characterEntity.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
               characterEntity.addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
               rider = characterEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
               if(rider)
               {
                  rider.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
                  rider.addEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
               }
               characterEntity.setAnimation(animation);
               if(playStaticOnly)
               {
                  if(characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET) && characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length)
                  {
                     characterEntity.setSubEntityBehaviour(1,new AnimStatiqueSubEntityBehavior());
                  }
                  characterEntity.stopAnimationAtLastFrame();
                  if(rider)
                  {
                     rider.stopAnimationAtLastFrame();
                  }
               }
            }
         }
         for each(f in characterEntity.followers)
         {
            if(f.type == Follower.TYPE_PET && f.entity is AnimatedCharacter)
            {
               this.playAnimationOnEntity(f.entity as AnimatedCharacter,animation,spellLevelId,directions8,duration,playStaticOnly);
            }
         }
      }
      
      private function getNearestAvailableDirection(availableDir:Array, characterDir:int) : int
      {
         var dirDiff:uint = 0;
         var nearestDir:uint = 10;
         for(var i:int = availableDir.length - 1; i >= 0; i--)
         {
            if(availableDir[i])
            {
               dirDiff = i - characterDir;
               if(dirDiff == 1)
               {
                  return i;
               }
               if(characterDir - nearestDir > Math.abs(dirDiff))
               {
                  nearestDir = i;
               }
            }
         }
         return nearestDir;
      }
      
      private function executeSpellBuffer(castSequence:SpellCastSequence) : void
      {
         var step:ISequencable = null;
         var serialSequencer:SerialSequencer = new SerialSequencer();
         for each(step in castSequence.steps)
         {
            serialSequencer.addStep(step);
         }
         serialSequencer.addStep(new CallbackStep(new Callback(function():void
         {
            _currentEmoticon = 0;
         })));
         serialSequencer.start();
      }
      
      private function initNewMap() : void
      {
         var go:* = undefined;
         for each(go in this._objectsByCellId)
         {
            (go as IDisplayable).remove();
         }
         this._npcList = new Dictionary();
         this._fights = new Dictionary();
         this._objects = new Dictionary();
         this._objectsByCellId = new Dictionary();
         this._paddockItem = new Dictionary();
      }
      
      override protected function switchPokemonMode() : Boolean
      {
         if(super.switchPokemonMode())
         {
            KernelEventsManager.getInstance().processCallback(TriggerHookList.CreaturesMode);
            return true;
         }
         return false;
      }
      
      override public function pulled() : Boolean
      {
         var fight:Fight = null;
         var entityId:* = undefined;
         var entity:AnimatedCharacter = null;
         var monsterId:* = undefined;
         var team:FightTeam = null;
         var timeoutId:uint = 0;
         if(Kernel.getWorker().contains(HavenbagFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(HavenbagFrame));
         }
         for each(fight in this._fights)
         {
            for each(team in fight.teams)
            {
               (team.teamEntity as TiphonSprite).removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onFightEntityRendered);
               TooltipManager.hide("fightOptions_" + fight.fightId + "_" + team.teamInfos.teamId);
            }
         }
         if(this._loader)
         {
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onGroundObjectLoaded);
            this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onGroundObjectLoadFailed);
            this._loader = null;
         }
         if(OptionManager.getOptionManager("dofus").getOption("allowAnimsFun"))
         {
            AnimFunManager.getInstance().stop();
         }
         this._fights = null;
         this._objects = null;
         this._npcList = null;
         this._objectsByCellId = null;
         this._paddockItem = null;
         this._housesList = null;
         Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Tiphon.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onTiphonPropertyChanged);
         removeAllIcons();
         if(this._auraCycleTimer)
         {
            if(OptionManager.getOptionManager("tiphon").getOption("auraMode") == OptionEnum.AURA_CYCLE)
            {
               this._auraCycleTimer.removeEventListener(TimerEvent.TIMER,this.onAuraCycleTimer);
               this._auraCycleTimer.stop();
            }
            this._auraCycleTimer = null;
         }
         this._lastEntityWithAura = null;
         for(entityId in _entities)
         {
            entity = EntitiesManager.getInstance().getEntity(entityId) as AnimatedCharacter;
            if(entity)
            {
               entity.removeEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
            }
         }
         for(monsterId in this._aggroTimeoutIdsMonsterAssoc)
         {
            for each(timeoutId in this._aggroTimeoutIdsMonsterAssoc[monsterId])
            {
               clearTimeout(timeoutId);
            }
            delete this._aggroTimeoutIdsMonsterAssoc[monsterId];
         }
         EnterFrameDispatcher.removeEventListener(this.setAggressiveMonstersOrientations);
         this._aggressions.length = 0;
         return super.pulled();
      }
      
      public function isFight(entityId:Number) : Boolean
      {
         if(!_entities)
         {
            return false;
         }
         return _entities[entityId] is FightTeam;
      }
      
      public function getFightTeam(entityId:Number) : FightTeam
      {
         return _entities[entityId] as FightTeam;
      }
      
      public function getFightId(entityId:Number) : uint
      {
         return (_entities[entityId] as FightTeam).fight.fightId;
      }
      
      public function getFightLeaderId(entityId:Number) : Number
      {
         return (_entities[entityId] as FightTeam).teamInfos.leaderId;
      }
      
      public function getFightTeamType(entityId:Number) : uint
      {
         return (_entities[entityId] as FightTeam).teamType;
      }
      
      public function updateMonstersGroups() : void
      {
         var entityInfo:GameContextActorInformations = null;
         var entities:Dictionary = entities;
         for each(entityInfo in entities)
         {
            if(entityInfo is GameRolePlayGroupMonsterInformations)
            {
               this.updateMonstersGroup(entityInfo as GameRolePlayGroupMonsterInformations);
            }
         }
      }
      
      private function updateMonstersGroup(pMonstersInfo:GameRolePlayGroupMonsterInformations) : void
      {
         var monsterInfos:MonsterInGroupLightInformations = null;
         var underling:MonsterInGroupLightInformations = null;
         var monster:Monster = null;
         var monsterGrade:int = 0;
         var length:int = 0;
         var monstersGroup:Vector.<MonsterInGroupLightInformations> = this.getMonsterGroup(pMonstersInfo.staticInfos);
         var groupHasMiniBoss:Boolean = Monster.getMonsterById(pMonstersInfo.staticInfos.mainCreatureLightInfos.genericId).isMiniBoss;
         var i:uint = 0;
         if(monstersGroup)
         {
            for each(monsterInfos in monstersGroup)
            {
               if(monsterInfos.genericId == pMonstersInfo.staticInfos.mainCreatureLightInfos.genericId)
               {
                  monstersGroup.splice(monstersGroup.indexOf(monsterInfos),1);
                  break;
               }
            }
         }
         var followersLooks:Vector.<EntityLook> = null;
         var followersSpeeds:Vector.<Number> = null;
         if(Dofus.getInstance().options.getOption("showEveryMonsters"))
         {
            if(monstersGroup)
            {
               length = monstersGroup.length;
            }
            else
            {
               length = pMonstersInfo.staticInfos.underlings.length;
            }
            followersLooks = new Vector.<EntityLook>(length,true);
            followersSpeeds = new Vector.<Number>(followersLooks.length,true);
         }
         for each(underling in pMonstersInfo.staticInfos.underlings)
         {
            if(followersLooks)
            {
               monster = Monster.getMonsterById(underling.genericId);
               monsterGrade = -1;
               if(!monstersGroup)
               {
                  monsterGrade = 0;
               }
               else
               {
                  for each(monsterInfos in monstersGroup)
                  {
                     if(monsterInfos.genericId == underling.genericId)
                     {
                        monstersGroup.splice(monstersGroup.indexOf(monsterInfos),1);
                        monsterGrade = monsterInfos.grade;
                        break;
                     }
                  }
               }
               if(monsterGrade >= 0)
               {
                  followersSpeeds[i] = monster.speedAdjust;
                  followersLooks[i] = EntityLookAdapter.toNetwork(TiphonEntityLook.fromString(monster.look));
                  i++;
               }
            }
            if(!groupHasMiniBoss && Monster.getMonsterById(underling.genericId).isMiniBoss)
            {
               groupHasMiniBoss = true;
               if(!followersLooks)
               {
                  break;
               }
            }
         }
         if(followersLooks)
         {
            this.manageFollowers(DofusEntities.getEntity(pMonstersInfo.contextualId) as AnimatedCharacter,followersLooks,followersSpeeds,null,true);
         }
      }
      
      private function getMonsterGroup(pStaticMonsterInfos:GroupMonsterStaticInformations) : Vector.<MonsterInGroupLightInformations>
      {
         var newGroup:Vector.<MonsterInGroupLightInformations> = null;
         var pmf:PartyManagementFrame = null;
         var partyMembers:Vector.<PartyMemberWrapper> = null;
         var nbMembers:int = 0;
         var monsterGroup:AlternativeMonstersInGroupLightInformations = null;
         var member:PartyMemberWrapper = null;
         var infos:GroupMonsterStaticInformationsWithAlternatives = pStaticMonsterInfos as GroupMonsterStaticInformationsWithAlternatives;
         if(infos)
         {
            pmf = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
            partyMembers = pmf.partyMembers;
            nbMembers = partyMembers.length;
            if(nbMembers == 0 && PlayedCharacterManager.getInstance().hasCompanion)
            {
               nbMembers = 2;
            }
            else
            {
               for each(member in partyMembers)
               {
                  nbMembers += member.companions.length;
               }
            }
            for each(monsterGroup in infos.alternatives)
            {
               if(!newGroup || monsterGroup.playerCount <= nbMembers)
               {
                  newGroup = monsterGroup.monsters;
               }
            }
         }
         return !!newGroup ? newGroup.concat() : null;
      }
      
      override public function addOrUpdateActor(infos:GameContextActorInformations, animationModifier:IAnimationModifier = null) : AnimatedCharacter
      {
         var ac:AnimatedCharacter = null;
         var questClip:Sprite = null;
         var q:Quest = null;
         var monstersInfos:GameRolePlayGroupMonsterInformations = null;
         var groupHasMiniBoss:Boolean = false;
         var entityLooks:Vector.<EntityLook> = null;
         var followersTypes:Vector.<uint> = null;
         var pets:Array = null;
         var migi:MonsterInGroupInformations = null;
         var option:* = undefined;
         var indexedLooks:Array = null;
         var indexedEL:IndexedEntityLook = null;
         var iEL:IndexedEntityLook = null;
         var tel:TiphonEntityLook = null;
         var mapPosition:MapPosition = null;
         ac = super.addOrUpdateActor(infos);
         switch(true)
         {
            case infos is GameRolePlayNpcWithQuestInformations:
               this._npcList[infos.contextualId] = ac;
               q = Quest.getFirstValidQuest((infos as GameRolePlayNpcWithQuestInformations).questFlag);
               this.removeBackground(ac);
               if(q != null)
               {
                  if((infos as GameRolePlayNpcWithQuestInformations).questFlag.questsToStartId.indexOf(q.id) != -1)
                  {
                     if(q.repeatType == 0)
                     {
                        questClip = EmbedAssets.getSprite("QUEST_CLIP");
                        ac.addBackground("questClip",questClip,true);
                     }
                     else
                     {
                        questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                        ac.addBackground("questRepeatableClip",questClip,true);
                     }
                  }
                  else if(q.repeatType == 0)
                  {
                     questClip = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                     ac.addBackground("questObjectiveClip",questClip,true);
                  }
                  else
                  {
                     questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                     ac.addBackground("questRepeatableObjectiveClip",questClip,true);
                  }
               }
               if(ac.look.getBone() == 1)
               {
                  ac.addAnimationModifier(_customBreedAnimationModifier);
               }
               if(_creaturesMode || ac.getAnimation() == AnimationEnum.ANIM_STATIQUE)
               {
                  ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               break;
            case infos is GameRolePlayGroupMonsterInformations:
               monstersInfos = infos as GameRolePlayGroupMonsterInformations;
               groupHasMiniBoss = Monster.getMonsterById(monstersInfos.staticInfos.mainCreatureLightInfos.genericId).isMiniBoss;
               if(!groupHasMiniBoss && monstersInfos.staticInfos.underlings && monstersInfos.staticInfos.underlings.length > 0)
               {
                  for each(migi in monstersInfos.staticInfos.underlings)
                  {
                     groupHasMiniBoss = Monster.getMonsterById(migi.genericId).isMiniBoss;
                     if(groupHasMiniBoss)
                     {
                        break;
                     }
                  }
               }
               this.updateMonstersGroup(monstersInfos);
               if(this._monstersIds.indexOf(infos.contextualId) == -1)
               {
                  this._monstersIds.push(infos.contextualId);
               }
               if(Kernel.getWorker().contains(EntitiesTooltipsFrame))
               {
                  (Kernel.getWorker().getFrame(EntitiesTooltipsFrame) as EntitiesTooltipsFrame).update();
               }
               if(PlayerManager.getInstance().serverGameType != 0 && monstersInfos.hasHardcoreDrop)
               {
                  addEntityIcon(monstersInfos.contextualId,"treasure");
               }
               if(groupHasMiniBoss)
               {
                  addEntityIcon(monstersInfos.contextualId,"archmonsters");
               }
               break;
            case infos is GameRolePlayHumanoidInformations:
               if(infos.contextualId > 0 && this._playersId && this._playersId.indexOf(infos.contextualId) == -1)
               {
                  this._playersId.push(infos.contextualId);
               }
               entityLooks = new Vector.<EntityLook>();
               followersTypes = new Vector.<uint>();
               for each(option in (infos as GameRolePlayHumanoidInformations).humanoidInfo.options)
               {
                  switch(true)
                  {
                     case option is HumanOptionFollowers:
                        indexedLooks = [];
                        for each(indexedEL in option.followingCharactersLook)
                        {
                           indexedLooks.push(indexedEL);
                        }
                        indexedLooks.sortOn("index");
                        for each(iEL in indexedLooks)
                        {
                           entityLooks.push(iEL.look);
                           followersTypes.push(Follower.TYPE_NETWORK);
                        }
                        break;
                     case option is HumanOptionSpeedMultiplier:
                        ac.speedAdjust = 10 * (option.speedMultiplier - 1);
                        break;
                  }
               }
               pets = ac.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET_FOLLOWER);
               for each(tel in pets)
               {
                  entityLooks.push(EntityLookAdapter.toNetwork(tel));
                  followersTypes.push(Follower.TYPE_PET);
               }
               this.manageFollowers(ac,entityLooks,null,followersTypes);
               if(ac.look.getBone() == 1)
               {
                  ac.addAnimationModifier(_customBreedAnimationModifier);
                  mapPosition = MapPosition.getMapPositionById(PlayedCharacterManager.getInstance().currentMap.mapId);
                  if(mapPosition.isUnderWater)
                  {
                     ac.addAnimationModifier(_underWaterAnimationModifier);
                  }
               }
               if(_creaturesMode || ac.getAnimation() == AnimationEnum.ANIM_STATIQUE)
               {
                  ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               break;
            case infos is GameRolePlayTaxCollectorInformations:
            case infos is GameRolePlayPrismInformations:
            case infos is GameRolePlayPortalInformations:
               ac.allowMovementThrough = true;
               break;
            case infos is GameRolePlayNpcInformations:
               this._npcList[infos.contextualId] = ac;
               break;
            default:
               _log.warn("Unknown GameRolePlayActorInformations type : " + infos + ".");
         }
         return ac;
      }
      
      override protected function updateActorLook(actorId:Number, newLook:EntityLook, smoke:Boolean = false) : AnimatedCharacter
      {
         var anim:String = null;
         var toRemove:Array = null;
         var pets:Array = null;
         var toAdd:Array = null;
         var found:Boolean = false;
         var tel:TiphonEntityLook = null;
         var f:Follower = null;
         var ac:AnimatedCharacter = DofusEntities.getEntity(actorId) as AnimatedCharacter;
         if(ac)
         {
            anim = (TiphonUtility.getEntityWithoutMount(ac) as TiphonSprite).getAnimation();
            if(!_creaturesMode)
            {
               pets = EntityLookAdapter.fromNetwork(newLook).getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET_FOLLOWER);
               toAdd = [];
               found = false;
               for each(tel in pets)
               {
                  found = false;
                  for each(f in ac.followers)
                  {
                     if(f.type == Follower.TYPE_PET && f.entity is TiphonSprite && (f.entity as TiphonSprite).look.equals(tel))
                     {
                        found = true;
                        break;
                     }
                  }
                  if(!found)
                  {
                     toAdd.push(tel);
                  }
               }
               for each(tel in toAdd)
               {
                  ac.addFollower(this.createFollower(tel,ac,Follower.TYPE_PET),true);
               }
            }
            toRemove = [];
            for each(f in ac.followers)
            {
               found = false;
               if(f.type == Follower.TYPE_PET)
               {
                  for each(tel in pets)
                  {
                     if(f.entity is TiphonSprite && (f.entity as TiphonSprite).look.equals(tel))
                     {
                        found = true;
                        break;
                     }
                  }
                  if(!found)
                  {
                     toRemove.push(f);
                  }
               }
            }
            for each(f in toRemove)
            {
               ac.removeFollower(f);
            }
            if(anim.indexOf("_Statique_") != -1 && (!this._lastStaticAnimations[actorId] || this._lastStaticAnimations[actorId] != anim))
            {
               this._lastStaticAnimations[actorId] = {"anim":anim};
            }
            if(ac.look.getBone() != newLook.bonesId && this._lastStaticAnimations[actorId])
            {
               this._lastStaticAnimations[actorId].targetBone = newLook.bonesId;
               ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
               ac.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
               ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
         }
         return super.updateActorLook(actorId,newLook,smoke);
      }
      
      private function onEntityRendered(pEvent:TiphonEvent) : void
      {
         var ac:AnimatedCharacter = pEvent.currentTarget as AnimatedCharacter;
         if(ac && this._lastStaticAnimations[ac.id] && ac.look && this._lastStaticAnimations[ac.id].targetBone == ac.look.getBone() && ac.rendered)
         {
            ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
            ac.setAnimation(this._lastStaticAnimations[ac.id].anim);
            delete this._lastStaticAnimations[ac.id];
         }
      }
      
      private function removeBackground(ac:TiphonSprite) : void
      {
         if(!ac)
         {
            return;
         }
         ac.removeBackground("questClip");
         ac.removeBackground("questObjectiveClip");
         ac.removeBackground("questRepeatableClip");
         ac.removeBackground("questRepeatableObjectiveClip");
      }
      
      private function manageFollowers(animatedCharacter:AnimatedCharacter, followers:Vector.<EntityLook>, speedAdjust:Vector.<Number> = null, types:Vector.<uint> = null, areMonsters:Boolean = false) : void
      {
         var num:int = 0;
         var i:int = 0;
         var followerBaseLook:EntityLook = null;
         var followerEntityLook:TiphonEntityLook = null;
         if(_creaturesMode && !areMonsters)
         {
            return;
         }
         if(!animatedCharacter.followersEqual(followers))
         {
            animatedCharacter.removeAllFollowers();
            num = followers.length;
            for(i = 0; i < num; i++)
            {
               followerBaseLook = followers[i];
               followerEntityLook = EntityLookAdapter.fromNetwork(followerBaseLook);
               animatedCharacter.addFollower(this.createFollower(followerEntityLook,animatedCharacter,!!types ? uint(types[i]) : (!!areMonsters ? uint(Follower.TYPE_MONSTER) : uint(Follower.TYPE_NETWORK)),speedAdjust != null ? Number(speedAdjust[i]) : Number(0)));
            }
         }
      }
      
      private function createFollower(look:TiphonEntityLook, parent:AnimatedCharacter, followerType:uint, speedAdjust:Number = 0) : Follower
      {
         var mapPosition:MapPosition = null;
         var followerEntity:AnimatedCharacter = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),look,parent);
         if(speedAdjust)
         {
            followerEntity.speedAdjust = speedAdjust;
         }
         if(look.getBone() == 1)
         {
            followerEntity.addAnimationModifier(_customBreedAnimationModifier);
            mapPosition = MapPosition.getMapPositionById(PlayedCharacterManager.getInstance().currentMap.mapId);
            if(mapPosition.isUnderWater)
            {
               followerEntity.addAnimationModifier(_underWaterAnimationModifier);
            }
         }
         return new Follower(followerEntity,followerType);
      }
      
      private function addFight(infos:FightCommonInformations) : void
      {
         var team:FightTeamInformations = null;
         var teamEntity:IEntity = null;
         var fightTeam:FightTeam = null;
         if(this._fights[infos.fightId])
         {
            return;
         }
         var teams:Vector.<FightTeam> = new Vector.<FightTeam>(0,false);
         var fight:Fight = new Fight(infos.fightId,teams);
         var c1:String = Math.round(Math.random() * 16).toString(16);
         var c2:String = Math.round(Math.random() * 16).toString(16);
         var c3:String = Math.round(Math.random() * 16).toString(16);
         var fightColorStr:String = "0x" + c1 + c1 + c2 + c2 + c3 + c3;
         var fightColor:int = int(fightColorStr);
         var teamCounter:uint = 0;
         for each(team in infos.fightTeams)
         {
            teamEntity = RolePlayEntitiesFactory.createFightEntity(infos,team,MapPoint.fromCellId(infos.fightTeamsPositions[teamCounter]),fightColor);
            (teamEntity as IDisplayable).display();
            fightTeam = new FightTeam(fight,team.teamTypeId,teamEntity,team,infos.fightTeamsOptions[team.teamId]);
            registerActorWithId(fightTeam,teamEntity.id);
            teams.push(fightTeam);
            teamCounter++;
            (teamEntity as TiphonSprite).addEventListener(TiphonEvent.RENDER_SUCCEED,this.onFightEntityRendered,false,0,true);
         }
         this._fights[infos.fightId] = fight;
      }
      
      private function addObject(pObjectUID:uint, pCellId:uint) : void
      {
         var objectUri:Uri = null;
         var modster:Modster = null;
         var innerGlow:GlowFilter = null;
         var outerGlow:GlowFilter = null;
         var isKroma:* = false;
         if(this._objectsByCellId && this._objectsByCellId[pCellId])
         {
            _log.error("To add an object on the ground, the destination cell must be empty.");
            return;
         }
         var objectEntity:IInteractive = new RoleplayObjectEntity(pObjectUID,MapPoint.fromCellId(pCellId));
         var item:Item = Item.getItemById(pObjectUID);
         var forcedAdapter:Class = null;
         if(item && item.typeId == DataEnum.ITEM_TYPE_MODSTER)
         {
            modster = Modster.getModsterByScrollId(item.id);
            if(modster)
            {
               isKroma = modster.itemIdKroma == item.id;
               objectUri = new Uri(LangManager.getInstance().getEntry("config.gfx.path") + "modsters/" + modster.modsterId + ".swf|" + (!!isKroma ? "Chroma" : "Normal"));
               forcedAdapter = AdvancedSwfAdapter;
            }
            else
            {
               objectUri = new Uri(LangManager.getInstance().getEntry("config.gfx.path.item.vector") + item.iconId + ".swf");
            }
            innerGlow = new GlowFilter(0,1,3,3,3);
            outerGlow = new GlowFilter(16777215,0.6,6,6,4);
            (objectEntity as RoleplayObjectEntity).filters = [innerGlow,outerGlow];
         }
         else
         {
            objectUri = new Uri(LangManager.getInstance().getEntry("config.gfx.path.item.vector") + item.iconId + ".swf");
         }
         (objectEntity as IDisplayable).display();
         var groundObject:GameContextActorInformations = new GroundObject(Item.getItemById(pObjectUID));
         groundObject.contextualId = objectEntity.id;
         groundObject.disposition.cellId = pCellId;
         groundObject.disposition.direction = DirectionsEnum.DOWN_RIGHT;
         if(this._objects == null)
         {
            this._objects = new Dictionary();
         }
         this._objects[objectUri] = objectEntity;
         this._objectsByCellId[pCellId] = this._objects[objectUri];
         registerActorWithId(groundObject,objectEntity.id);
         this._loader.load(objectUri,null,forcedAdapter,forcedAdapter == null);
      }
      
      private function removeObject(pCellId:uint) : void
      {
         if(this._objectsByCellId[pCellId] != null)
         {
            if(_entities[this._objectsByCellId[pCellId].id] != null)
            {
               unregisterActor(this._objectsByCellId[pCellId].id);
            }
            (this._objectsByCellId[pCellId] as IDisplayable).remove();
            delete this._objectsByCellId[pCellId];
         }
      }
      
      private function updateFight(fightId:uint, team:FightTeamInformations) : void
      {
         var newMember:FightTeamMemberInformations = null;
         var present:Boolean = false;
         var teamMember:FightTeamMemberInformations = null;
         var fight:Fight = this._fights[fightId];
         if(fight == null)
         {
            return;
         }
         var fightTeam:FightTeam = fight.getTeamById(team.teamId);
         var tInfo:FightTeamInformations = (_entities[fightTeam.teamEntity.id] as FightTeam).teamInfos;
         if(tInfo.teamMembers == team.teamMembers)
         {
            return;
         }
         for each(newMember in team.teamMembers)
         {
            present = false;
            for each(teamMember in tInfo.teamMembers)
            {
               if(teamMember.id == newMember.id)
               {
                  present = true;
               }
            }
            if(!present)
            {
               tInfo.teamMembers.push(newMember);
            }
         }
      }
      
      private function removeFighter(fightId:uint, teamId:uint, charId:Number) : void
      {
         var fightTeam:FightTeam = null;
         var teamInfos:FightTeamInformations = null;
         var newMembers:Vector.<FightTeamMemberInformations> = null;
         var member:FightTeamMemberInformations = null;
         var fight:Fight = this._fights[fightId];
         if(fight)
         {
            fightTeam = fight.teams[teamId];
            teamInfos = fightTeam.teamInfos;
            newMembers = new Vector.<FightTeamMemberInformations>(0,false);
            for each(member in teamInfos.teamMembers)
            {
               if(member.id != charId)
               {
                  newMembers.push(member);
               }
            }
            teamInfos.teamMembers = newMembers;
         }
      }
      
      private function removeFight(fightId:uint) : void
      {
         var team:FightTeam = null;
         var fight:Fight = this._fights[fightId];
         if(fight == null)
         {
            return;
         }
         for each(team in fight.teams)
         {
            _log.debug("suppression de la team " + team.teamEntity.id);
            Kernel.getWorker().process(new EntityMouseOutMessage(team.teamEntity as IInteractive));
            (team.teamEntity as IDisplayable).remove();
            TooltipManager.hide("fightOptions_" + fightId + "_" + team.teamInfos.teamId);
            unregisterActor(team.teamEntity.id);
         }
         delete this._fights[fightId];
      }
      
      private function addPaddockItem(item:PaddockItem) : void
      {
         var contextualId:int = 0;
         var i:Item = Item.getItemById(item.objectGID);
         if(this._paddockItem[item.cellId])
         {
            contextualId = (this._paddockItem[item.cellId] as IEntity).id;
         }
         else
         {
            contextualId = EntitiesManager.getInstance().getFreeEntityId();
         }
         var gcpii:GameContextPaddockItemInformations = new GameContextPaddockItemInformations(contextualId,i.appearance,item.cellId,item.durability,i);
         var e:IEntity = this.addOrUpdateActor(gcpii);
         this._paddockItem[item.cellId] = e;
      }
      
      private function removePaddockItem(cellId:uint) : void
      {
         var e:IEntity = this._paddockItem[cellId];
         if(!e)
         {
            return;
         }
         (e as IDisplayable).remove();
         delete this._paddockItem[cellId];
      }
      
      private function activatePaddockItem(cellId:uint) : void
      {
         var seq:SerialSequencer = null;
         var item:TiphonSprite = this._paddockItem[cellId];
         if(item)
         {
            seq = new SerialSequencer();
            seq.addStep(new PlayAnimationStep(item,AnimationEnum.ANIM_HIT));
            seq.addStep(new PlayAnimationStep(item,AnimationEnum.ANIM_STATIQUE));
            seq.start();
         }
      }
      
      private function onFightEntityRendered(event:TiphonEvent) : void
      {
         if(!_entities || !event.target)
         {
            return;
         }
         var fightTeam:FightTeam = _entities[event.target.id];
         if(fightTeam && fightTeam.fight && fightTeam.teamInfos)
         {
            this.updateSwordOptions(fightTeam.fight.fightId,fightTeam.teamInfos.teamId);
         }
      }
      
      private function updateSwordOptions(fightId:uint, teamId:uint, option:int = -1, state:Boolean = false) : void
      {
         var opt:* = undefined;
         var fight:Fight = this._fights[fightId];
         if(fight == null)
         {
            return;
         }
         var fightTeam:FightTeam = fight.teams[teamId];
         if(fightTeam == null)
         {
            return;
         }
         if(option != -1)
         {
            fightTeam.teamOptions[option] = state;
         }
         var textures:Vector.<String> = new Vector.<String>();
         for(opt in fightTeam.teamOptions)
         {
            if(fightTeam.teamOptions[opt])
            {
               textures.push("fightOption" + opt);
            }
         }
         if(fightTeam.hasGroupMember())
         {
            textures.push("fightOption4");
         }
         TooltipManager.show(textures,(fightTeam.teamEntity as IDisplayable).absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"fightOptions_" + fightId + "_" + teamId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,"texturesList",null,null,null,false,0,Atouin.getInstance().currentZoom,false);
      }
      
      private function paddockCellValidator(cellId:int) : Boolean
      {
         var infos:GameContextActorInformations = null;
         var entity:IEntity = EntitiesManager.getInstance().getEntityOnCell(cellId);
         if(entity)
         {
            infos = getEntityInfos(entity.id);
            if(infos is GameContextPaddockItemInformations)
            {
               return false;
            }
         }
         return DataMapProvider.getInstance().farmCell(MapPoint.fromCellId(cellId).x,MapPoint.fromCellId(cellId).y) && DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(cellId).x,MapPoint.fromCellId(cellId).y,true);
      }
      
      private function removeEntityListeners(pEntityId:Number) : void
      {
         var rider:TiphonSprite = null;
         var ts:TiphonSprite = DofusEntities.getEntity(pEntityId) as TiphonSprite;
         if(ts)
         {
            ts.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
            rider = ts.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
            if(rider)
            {
               rider.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
            }
            ts.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
         }
      }
      
      private function updateUsableEmotesListInit(pLook:TiphonEntityLook) : void
      {
         var realEntityLook:TiphonEntityLook = null;
         var gcai:GameContextActorInformations = null;
         var bonesToLoad:Array = null;
         if(_entities && _entities[PlayedCharacterManager.getInstance().id])
         {
            gcai = _entities[PlayedCharacterManager.getInstance().id] as GameContextActorInformations;
            realEntityLook = EntityLookAdapter.fromNetwork(gcai.look);
         }
         var followerPetLook:Array = realEntityLook.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET_FOLLOWER);
         if((_creaturesMode || _creaturesFightMode || followerPetLook && followerPetLook.length != 0) && realEntityLook)
         {
            bonesToLoad = TiphonMultiBonesManager.getInstance().getAllBonesFromLook(realEntityLook);
            TiphonMultiBonesManager.getInstance().forceBonesLoading(bonesToLoad,new Callback(this.updateUsableEmotesList,realEntityLook));
         }
         else
         {
            this.updateUsableEmotesList(pLook);
         }
      }
      
      private function updateUsableEmotesList(pLook:TiphonEntityLook) : void
      {
         var emote:EmoteWrapper = null;
         var animName:String = null;
         var emoteAvailable:Boolean = false;
         var subCat:* = null;
         var subIndex:* = null;
         var sw:ShortcutWrapper = null;
         var emoteIndex:int = 0;
         var isGhost:Boolean = PlayedCharacterManager.getInstance().isGhost;
         var isIncarnation:Boolean = PlayedCharacterManager.getInstance().isIncarnation;
         var rpEmoticonFrame:EmoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
         var emotes:Array = rpEmoticonFrame.emotesList;
         var subEntities:Dictionary = pLook.getSubEntities();
         var updateShortcutsBar:Boolean = false;
         var usableEmotes:Array = [];
         for each(emote in emotes)
         {
            emoteAvailable = false;
            if(emote && emote.emote)
            {
               animName = emote.emote.getAnimName();
               if(emote.emote.aura && !isGhost && !isIncarnation || Tiphon.skullLibrary.hasAnim(pLook.getBone(),animName))
               {
                  emoteAvailable = true;
               }
               else if(animName == null && emote.emote.spellLevelId != 0 && !this.isCreatureMode)
               {
                  emoteAvailable = true;
               }
               else if(subEntities)
               {
                  for(subCat in subEntities)
                  {
                     for(subIndex in subEntities[subCat])
                     {
                        if(Tiphon.skullLibrary.hasAnim(subEntities[subCat][subIndex].getBone(),animName))
                        {
                           emoteAvailable = true;
                           break;
                        }
                     }
                     if(emoteAvailable)
                     {
                        break;
                     }
                  }
               }
               emoteIndex = rpEmoticonFrame.emotes.indexOf(emote.id);
               for each(sw in InventoryManager.getInstance().shortcutBarItems)
               {
                  if(sw && sw.type == 4 && sw.id == emote.id && sw.active != emoteAvailable)
                  {
                     sw.active = emoteAvailable;
                     updateShortcutsBar = true;
                     break;
                  }
               }
               if(emoteAvailable)
               {
                  usableEmotes.push(emote.id);
                  if(emoteIndex == -1)
                  {
                     rpEmoticonFrame.emotes.push(emote.id);
                  }
               }
               else if(emoteIndex != -1)
               {
                  rpEmoticonFrame.emotes.splice(emoteIndex,1);
               }
            }
         }
         KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteEnabledListUpdated,usableEmotes);
         if(updateShortcutsBar)
         {
            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
         }
      }
      
      private function onEntityReadyForEmote(pEvent:TiphonEvent) : void
      {
         var entity:AnimatedCharacter = pEvent.currentTarget as AnimatedCharacter;
         entity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
         if(this._playersId.indexOf(entity.id) != -1)
         {
            this.process(this._waitingEmotesAnims[entity.id]);
         }
         delete this._waitingEmotesAnims[entity.id];
      }
      
      private function onAnimationAdded(e:TiphonEvent) : void
      {
         var name:String = null;
         var vsa:Vector.<SoundAnimation> = null;
         var sa:SoundAnimation = null;
         var dataSoundLabel:String = null;
         var entity:TiphonSprite = e.currentTarget as TiphonSprite;
         entity.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
         var animation:TiphonAnimation = entity.rawAnimation;
         var soundBones:SoundBones = SoundBones.getSoundBonesById(entity.look.getBone());
         if(soundBones)
         {
            name = getQualifiedClassName(animation);
            vsa = soundBones.getSoundAnimations(name);
            animation.spriteHandler.tiphonEventManager.removeEvents(TiphonEventsManager.BALISE_SOUND,name);
            for each(sa in vsa)
            {
               dataSoundLabel = TiphonEventsManager.BALISE_DATASOUND + TiphonEventsManager.BALISE_PARAM_BEGIN + (sa.label != null && sa.label != "null" ? sa.label : "") + TiphonEventsManager.BALISE_PARAM_END;
               animation.spriteHandler.tiphonEventManager.addEvent(dataSoundLabel,sa.startFrame,name);
            }
         }
      }
      
      private function onGroundObjectLoaded(e:ResourceLoadedEvent) : void
      {
         var objectMc:MovieClip = null;
         var aswf:ASwf = null;
         var child:DisplayObject = null;
         if(e.resourceType == ResourceType.RESOURCE_ASWF)
         {
            aswf = ASwf(e.resource);
            objectMc = new (aswf.applicationDomain.getDefinition(e.uri.subPath) as Class)() as MovieClip;
         }
         else
         {
            objectMc = e.resource;
         }
         objectMc.width = 34;
         objectMc.height = 34;
         objectMc.x -= objectMc.width / 2;
         objectMc.y -= objectMc.height / 2;
         if(this._objects[e.uri])
         {
            child = this._objects[e.uri].addChild(objectMc);
            (child as MovieClip).stop();
         }
      }
      
      private function onGroundObjectLoadFailed(e:ResourceErrorEvent) : void
      {
      }
      
      override public function onPlayAnim(e:TiphonEvent) : void
      {
         var tempStr:String = e.params.substring(6,e.params.length - 1);
         var animsRandom:Array = tempStr.split(",");
         var whichAnim:int = this._emoteTimesBySprite[(e.currentTarget as TiphonSprite).name] % animsRandom.length;
         e.sprite.setAnimation(animsRandom[whichAnim]);
      }
      
      private function onAnimationEnd(e:TiphonEvent) : void
      {
         var statiqueAnim:String = null;
         var animNam:String = null;
         var tiphonSprite:TiphonSprite = e.currentTarget as TiphonSprite;
         tiphonSprite.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         var subEnt:Object = tiphonSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(subEnt != null)
         {
            animNam = subEnt.getAnimation();
            if(animNam.indexOf("_") == -1)
            {
               animNam = tiphonSprite.getAnimation();
            }
         }
         else
         {
            animNam = tiphonSprite.getAnimation();
         }
         if(animNam.indexOf("_Statique_") == -1)
         {
            statiqueAnim = animNam.replace("_","_Statique_");
         }
         else
         {
            statiqueAnim = animNam;
         }
         if(tiphonSprite.hasAnimation(statiqueAnim,tiphonSprite.getDirection()) || subEnt && subEnt is TiphonSprite && TiphonSprite(subEnt).hasAnimation(statiqueAnim,TiphonSprite(subEnt).getDirection()))
         {
            tiphonSprite.setAnimation(statiqueAnim);
         }
         else
         {
            tiphonSprite.setAnimation(AnimationEnum.ANIM_STATIQUE);
            this._currentEmoticon = 0;
         }
      }
      
      private function onPlayerSpriteInit(pEvent:TiphonEvent) : void
      {
         var currentLook:TiphonEntityLook = (pEvent.sprite as TiphonSprite).look;
         if(pEvent.params == currentLook.getBone())
         {
            pEvent.sprite.removeEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
            this.updateUsableEmotesListInit(currentLook);
         }
      }
      
      private function onCellPointed(success:Boolean, cellId:uint, entityId:Number) : void
      {
         var m:PaddockMoveItemRequestMessage = null;
         if(success)
         {
            m = new PaddockMoveItemRequestMessage();
            m.initPaddockMoveItemRequestMessage(this._currentPaddockItemCellId,cellId);
            ConnectionsHandler.getConnection().send(m);
         }
      }
      
      private function updateConquestIcon(pPlayerId:Number, pPlayerRoleId:Number = -1, scoreValue:int = -1) : void
      {
         var infos:GameRolePlayHumanoidInformations = null;
         var option:* = undefined;
         infos = getEntityInfos(pPlayerId) as GameRolePlayHumanoidInformations;
         if(infos)
         {
            for each(option in infos.humanoidInfo.options)
            {
               if(option is HumanOptionAlliance)
               {
                  this.addConquestIcon(infos.contextualId,option as HumanOptionAlliance,pPlayerRoleId,scoreValue);
                  break;
               }
            }
         }
      }
      
      private function addConquestIcon(pEntityId:Number, pHumanOptionAlliance:HumanOptionAlliance, pRoleId:Number = -1, scoreValue:int = -1) : void
      {
         var prismInfo:PrismSubAreaWrapper = null;
         var playerConquestIcon:String = null;
         var iconsNames:Vector.<String> = null;
         var iconName:String = null;
         if(PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable != AggressableStatusEnum.NON_AGGRESSABLE && this._socialFrame && this._socialFrame.hasAlliance && this._allianceFrame)
         {
            prismInfo = this._allianceFrame.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id);
            if(prismInfo && prismInfo.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
            {
               switch(pHumanOptionAlliance.aggressable)
               {
                  case AggressableStatusEnum.AvA_DISQUALIFIED:
                     playerConquestIcon = "neutral";
                     break;
                  case AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE:
                     if(pEntityId == PlayedCharacterManager.getInstance().id || pHumanOptionAlliance.allianceInformation.allianceId != this._socialFrame.alliance.allianceId)
                     {
                        playerConquestIcon = "clock";
                     }
                     else
                     {
                        playerConquestIcon = this.getPlayerConquestIcon(pHumanOptionAlliance.allianceInformation.allianceId,prismInfo.alliance.allianceId,pRoleId);
                     }
                     break;
                  case AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE:
                     playerConquestIcon = this.getPlayerConquestIcon(pHumanOptionAlliance.allianceInformation.allianceId,prismInfo.alliance.allianceId,pRoleId);
               }
               if(playerConquestIcon)
               {
                  iconsNames = getIconNamesByCategory(pEntityId,EntityIconEnum.AVA_CATEGORY);
                  if(iconsNames)
                  {
                     iconName = iconsNames[0];
                     iconsNames.length = 0;
                     removeIcon(pEntityId,iconName,true);
                  }
                  addEntityIcon(pEntityId,playerConquestIcon,EntityIconEnum.AVA_CATEGORY,0,0,-1,scoreValue);
               }
            }
         }
         if(!playerConquestIcon && _entitiesIconsNames[pEntityId] && _entitiesIconsNames[pEntityId][EntityIconEnum.AVA_CATEGORY])
         {
            removeIconsCategory(pEntityId,EntityIconEnum.AVA_CATEGORY);
         }
      }
      
      override protected function changeColor(entityId:Number, name:String, color:ColorTransform = null) : void
      {
         var info:* = undefined;
         var prism:PrismSubAreaWrapper = null;
         var entityAlliance:uint = 0;
         if(name.indexOf("role") == -1)
         {
            return;
         }
         for each(info in _entities[entityId].humanoidInfo.options)
         {
            if(info is HumanOptionAlliance)
            {
               entityAlliance = info.allianceInformation.allianceId;
            }
         }
         prism = this._allianceFrame.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id);
         if(!prism)
         {
            return;
         }
         var prismAllianceId:uint = prism.alliance.groupId;
         var playerAlliance:uint = this._socialFrame.alliance.groupId;
         if(prismAllianceId == entityAlliance)
         {
            super.changeColor(entityId,name,KothColorsEnum.COLOR_DEFENDER_AVA_BLUE);
         }
         else if(entityAlliance == playerAlliance)
         {
            super.changeColor(entityId,name,KothColorsEnum.COLOR_ATTACKER_AVA_GREEN);
         }
         else
         {
            super.changeColor(entityId,name,KothColorsEnum.COLOR_ATTACKER_AVA_RED);
         }
      }
      
      private function getPlayerConquestIcon(pPlayerAllianceId:int, pPrismAllianceId:int, pPlayerRoleId:Number) : String
      {
         if(pPlayerRoleId == -1)
         {
            return null;
         }
         var name:* = "role" + pPlayerRoleId.toString();
         if(pPlayerRoleId == 8)
         {
            if(pPlayerAllianceId == pPrismAllianceId)
            {
               name += "d";
            }
            else
            {
               name += "a";
            }
         }
         return name;
      }
      
      private function onTiphonPropertyChanged(event:PropertyChangeEvent) : void
      {
         if(event.propertyName == "auraMode" && event.propertyOldValue != event.propertyValue)
         {
            if(this._auraCycleTimer.running)
            {
               this._auraCycleTimer.removeEventListener(TimerEvent.TIMER,this.onAuraCycleTimer);
               this._auraCycleTimer.stop();
            }
            switch(event.propertyValue)
            {
               case OptionEnum.AURA_CYCLE:
                  this._auraCycleTimer.addEventListener(TimerEvent.TIMER,this.onAuraCycleTimer);
                  this._auraCycleTimer.start();
                  this.setEntitiesAura(false);
                  break;
               case OptionEnum.AURA_ON_ROLLOVER:
               case OptionEnum.AURA_NONE:
                  this.setEntitiesAura(false);
                  break;
               case OptionEnum.AURA_ALWAYS:
               default:
                  this.setEntitiesAura(true);
            }
         }
      }
      
      private function onAuraCycleTimer(event:TimerEvent) : void
      {
         var firstEntityWithAuraIndex:int = 0;
         var firstEntityWithAura:AnimatedCharacter = null;
         var nextEntityWithAura:AnimatedCharacter = null;
         var entity:AnimatedCharacter = null;
         var entitiesIdsList:Vector.<Number> = getEntitiesIdsList();
         if(this._auraCycleIndex >= entitiesIdsList.length)
         {
            this._auraCycleIndex = 0;
         }
         var l:int = entitiesIdsList.length;
         for(var i:int = 0; i < l; i++)
         {
            entity = DofusEntities.getEntity(entitiesIdsList[i]) as AnimatedCharacter;
            if(entity)
            {
               if(!firstEntityWithAura && entity.hasAura && entity.getDirection() == DirectionsEnum.DOWN)
               {
                  firstEntityWithAura = entity;
                  firstEntityWithAuraIndex = i;
               }
               if(i == this._auraCycleIndex && entity.hasAura && entity.getDirection() == DirectionsEnum.DOWN)
               {
                  nextEntityWithAura = entity;
                  break;
               }
               if(!entity.hasAura)
               {
                  ++this._auraCycleIndex;
               }
            }
         }
         if(this._lastEntityWithAura)
         {
            this._lastEntityWithAura.visibleAura = false;
         }
         if(nextEntityWithAura)
         {
            nextEntityWithAura.visibleAura = true;
            this._lastEntityWithAura = nextEntityWithAura;
         }
         else if(!nextEntityWithAura && firstEntityWithAura)
         {
            firstEntityWithAura.visibleAura = true;
            this._lastEntityWithAura = firstEntityWithAura;
            this._auraCycleIndex = firstEntityWithAuraIndex;
         }
         ++this._auraCycleIndex;
      }
      
      private function setEntitiesAura(visible:Boolean) : void
      {
         var entity:AnimatedCharacter = null;
         var entitiesIdsList:Vector.<Number> = getEntitiesIdsList();
         for(var i:int = 0; i < entitiesIdsList.length; i++)
         {
            entity = DofusEntities.getEntity(entitiesIdsList[i]) as AnimatedCharacter;
            if(entity)
            {
               entity.visibleAura = visible;
            }
         }
      }
      
      override protected function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         super.onPropertyChanged(e);
         if(e.propertyName == "allowAnimsFun")
         {
            AnimFunManager.getInstance().stop();
            if(e.propertyValue)
            {
               AnimFunManager.getInstance().initializeByMap(PlayedCharacterManager.getInstance().currentMap.mapId);
            }
         }
      }
      
      private function onMonsterAngryAtPlayer(playerId:Number, monsterGroupId:Number, attackTime:Number) : void
      {
         var aggression:Aggression = null;
         addEntityIcon(monsterGroupId,"spotted",EntityIconEnum.AGGRO_CATEGORY,-22,-31);
         for each(aggression in this._aggressions)
         {
            if(aggression.monsterId == monsterGroupId)
            {
               return;
            }
         }
         EnterFrameDispatcher.addEventListener(this.setAggressiveMonstersOrientations,EnterFrameConst.AGGRESSIONS);
         this._aggressions.push(new Aggression(monsterGroupId,playerId));
         if(!this._aggroTimeoutIdsMonsterAssoc[monsterGroupId])
         {
            this._aggroTimeoutIdsMonsterAssoc[monsterGroupId] = new Vector.<uint>(0);
         }
         this._aggroTimeoutIdsMonsterAssoc[monsterGroupId].push(setTimeout(this.removeAggression,Math.max(attackTime - TimeManager.getInstance().getUtcTimestamp(),0),monsterGroupId));
      }
      
      private function setAggressiveMonstersOrientations(e:Event) : void
      {
         var aggression:Aggression = null;
         var player:AnimatedCharacter = null;
         var monster:AnimatedCharacter = null;
         var follower:Follower = null;
         for each(aggression in this._aggressions)
         {
            player = DofusEntities.getEntity(aggression.playerId) as AnimatedCharacter;
            monster = DofusEntities.getEntity(aggression.monsterId) as AnimatedCharacter;
            if(player && player.rendered && monster && monster.rendered)
            {
               monster.setDirection(monster.position.advancedOrientationTo(player.position,this.getNumDirections(monster) < 8));
               for each(follower in monster.followers)
               {
                  (follower.entity as TiphonSprite).setDirection(follower.entity.position.advancedOrientationTo(player.position,this.getNumDirections(follower.entity as TiphonSprite) < 8));
               }
            }
         }
      }
      
      private function getNumDirections(character:TiphonSprite) : int
      {
         var b:Boolean = false;
         var num:int = 0;
         for each(b in character.getAvaibleDirection())
         {
            if(b)
            {
               num++;
            }
         }
         return num;
      }
      
      private function removeAggression(monsterId:Number) : void
      {
         var aggression:Aggression = null;
         var timeoutId:uint = 0;
         var monsterIndex:int = 0;
         (DofusEntities.getEntity(monsterId) as AnimatedCharacter).setAnimation("AnimStatique");
         if(this._aggroTimeoutIdsMonsterAssoc[monsterId])
         {
            for each(timeoutId in this._aggroTimeoutIdsMonsterAssoc[monsterId])
            {
               clearTimeout(timeoutId);
            }
            delete this._aggroTimeoutIdsMonsterAssoc[monsterId];
         }
         var monsterIndexes:Vector.<int> = new Vector.<int>(0);
         for each(aggression in this._aggressions)
         {
            if(aggression.monsterId == monsterId)
            {
               monsterIndexes.push(this._aggressions.indexOf(aggression));
            }
         }
         if(monsterIndexes.length > 0)
         {
            for each(monsterIndex in monsterIndexes)
            {
               this._aggressions.splice(monsterIndex,1);
            }
         }
         if(!this._aggressions.length)
         {
            EnterFrameDispatcher.removeEventListener(this.setAggressiveMonstersOrientations);
         }
         if(_entitiesIconsCounts[monsterId])
         {
            _entitiesIconsCounts[monsterId]["spotted"] = 1;
         }
         removeIcon(monsterId,"spotted");
      }
      
      private function addNpcClip(mapInfo:MapNpcQuestInfo) : void
      {
         var npc:TiphonSprite = null;
         var questClip:Sprite = null;
         var iq:int = 0;
         var q:Quest = null;
         var nbnpcqnr:int = mapInfo.npcsIdsWithQuest.length;
         for(iq = 0; iq < nbnpcqnr; iq++)
         {
            npc = this._npcList[mapInfo.npcsIdsWithQuest[iq]];
            if(npc)
            {
               q = Quest.getFirstValidQuest(mapInfo.questFlags[iq]);
               if(q != null)
               {
                  if(mapInfo.questFlags[iq].questsToStartId.indexOf(q.id) != -1)
                  {
                     if(q.repeatType == 0)
                     {
                        questClip = EmbedAssets.getSprite("QUEST_CLIP");
                        npc.addBackground("questClip",questClip,true);
                     }
                     else
                     {
                        questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                        npc.addBackground("questRepeatableClip",questClip,true);
                     }
                  }
                  else if(q.repeatType == 0)
                  {
                     questClip = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                     npc.addBackground("questObjectiveClip",questClip,true);
                  }
                  else
                  {
                     questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                     npc.addBackground("questRepeatableObjectiveClip",questClip,true);
                  }
               }
            }
         }
      }
   }
}

class Aggression
{
    
   
   private var _monsterId:Number;
   
   private var _playerId:Number;
   
   function Aggression(monsterId:Number, playerId:Number)
   {
      super();
      this._monsterId = monsterId;
      this._playerId = playerId;
   }
   
   public function get monsterId() : Number
   {
      return this._monsterId;
   }
   
   public function get playerId() : Number
   {
      return this._playerId;
   }
}
