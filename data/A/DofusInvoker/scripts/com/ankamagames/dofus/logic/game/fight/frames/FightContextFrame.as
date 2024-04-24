package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.*;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.atouin.messages.MapsLoadingCompleteMessage;
   import com.ankamagames.atouin.renderers.*;
   import com.ankamagames.atouin.types.*;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import com.ankamagames.berilia.types.tooltip.event.TooltipEvent;
   import com.ankamagames.dofus.datacenter.challenges.Challenge;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.fight.ChallengeTargetWrapper;
   import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;
   import com.ankamagames.dofus.internalDatacenter.fight.EmptyChallengeWrapper;
   import com.ankamagames.dofus.internalDatacenter.fight.FightResultEntryWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.ToggleShowUIAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeBonusSelectAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeModSelectAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeSelectionAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeTargetsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeValidateAction;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.frames.BreachFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PointCellFrame;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.managers.InactivityManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.game.common.managers.SubhintManager;
   import com.ankamagames.dofus.logic.game.common.messages.FightEndingMessage;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
   import com.ankamagames.dofus.logic.game.fight.actions.SurrenderPopupNameAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleEntityIconsAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TogglePointCellAction;
   import com.ankamagames.dofus.logic.game.fight.actions.UpdateSpellModifierAction;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.Preview.DamagePreview;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellDamagesManager;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellModifiersManager;
   import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightReachableCellsMaker;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.EntitiesTooltipsFrame;
   import com.ankamagames.dofus.logic.game.roleplay.managers.MountAutoTripManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChallengeStateEnum;
   import com.ankamagames.dofus.network.enums.FightOutcomeEnum;
   import com.ankamagames.dofus.network.enums.FightTypeEnum;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.network.enums.SpellModifierTypeEnum;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightNoSpellCastMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextReadyMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightResumeMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightResumeWithSlavesMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectatorJoinMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartingMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.arena.ArenaFighterIdleMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.arena.ArenaFighterLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.breach.BreachGameFightEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeAddMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeBonusChoiceMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeBonusChoiceSelectedMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeListMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeModSelectMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeModSelectedMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeNumberMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeProposalMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeResultMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeSelectedMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeSelectionMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeTargetsMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeTargetsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeValidateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapInstanceMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapObstacleUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachEnterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachExitResponseMessage;
   import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultFighterListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultPlayerListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultTaxCollectorListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightResumeSlaveInfo;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.challenge.ChallengeInformation;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeam;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeamWithOutcome;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import tools.enumeration.GameActionMarkTypeEnum;
   
   public class FightContextFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightContextFrame));
      
      private static const FIGHTER_NAME_DEPTH_LIMIT:uint = 2;
      
      public static var preFightIsActive:Boolean = true;
      
      public static var fighterEntityTooltipId:Number;
      
      public static var currentCell:int = -1;
      
      private static var FIGHT_RESULT_KEY_PREFIX:String = "fightResult_";
      
      private static var MAX_FIGHT_RESULT:uint = 15;
      
      private static var fightResultId:Number = 0;
      
      private static var fightResults:Dictionary = new Dictionary();
      
      private static var fightResultIds:Vector.<String> = new Vector.<String>();
       
      
      private const INVISIBLE_POSITION_SELECTION:String = "invisible_position";
      
      private const GLYPH_GFX_ID:String = "glyphGfxId";
      
      protected const REACHABLE_CELL_COLOR:int = 26112;
      
      protected const UNREACHABLE_CELL_COLOR:int = 6684672;
      
      private var _entitiesFrame:FightEntitiesFrame;
      
      private var _preparationFrame:FightPreparationFrame;
      
      private var _battleFrame:FightBattleFrame;
      
      private var _surrenderVoteFrame:FightSurrenderFrame;
      
      private var _overEffectOk:GlowFilter;
      
      private var _overEffectKo:GlowFilter;
      
      private var _linkedEffect:ColorMatrixFilter;
      
      private var _linkedMainEffect:ColorMatrixFilter;
      
      private var _lastEffectEntity:WeakReference;
      
      private var _timerFighterInfo:BenchmarkTimer;
      
      private var _timerMovementRange:BenchmarkTimer;
      
      private var _currentFighterInfo:GameFightFighterInformations;
      
      private var _currentMapRenderId:int = -1;
      
      private var _timelineOverEntity:Boolean;
      
      private var _timelineOverEntityId:Number;
      
      private var _showPermanentTooltips:Boolean;
      
      private var _hiddenEntites:Array;
      
      private var _challengesList:Array;
      
      private var _challengeSelectionMod:uint = 1;
      
      private var _challengeBonusType:uint = 0;
      
      public var challengeChoicePhase:Boolean = false;
      
      private var _fightType:uint;
      
      private var _fightAttackerId:Number;
      
      private var _spellTargetsTooltips:Dictionary;
      
      private var _tooltipLastUpdate:Dictionary;
      
      private var _namedPartyTeams:Vector.<NamedPartyTeam>;
      
      private var _fightersPositionsHistory:Dictionary;
      
      private var _fightersRoundStartPosition:Dictionary;
      
      private var _mustShowTreasureHuntMask:Boolean = false;
      
      private var _roleplayGridDisplayed:Boolean;
      
      private var _surrenderPopupName:String;
      
      public var isFightLeader:Boolean = true;
      
      public var fightLeader:GameContextActorInformations;
      
      public var onlyTheOtherTeamCanPlace:Boolean = false;
      
      public function FightContextFrame()
      {
         this._hiddenEntites = [];
         this._spellTargetsTooltips = new Dictionary();
         this._tooltipLastUpdate = new Dictionary();
         this._fightersPositionsHistory = new Dictionary();
         this._fightersRoundStartPosition = new Dictionary();
         super();
         DamagePreview.init();
      }
      
      public static function saveResults(resultsDescr:Object) : String
      {
         var resultsToDeleteKey:String = null;
         var key:String = FIGHT_RESULT_KEY_PREFIX + fightResultId.toString();
         ++fightResultId;
         fightResults[key] = resultsDescr;
         fightResultIds.push(key);
         if(fightResultIds.length > MAX_FIGHT_RESULT)
         {
            resultsToDeleteKey = fightResultIds.shift();
            if(resultsToDeleteKey !== null && resultsToDeleteKey in fightResults)
            {
               delete fightResults[resultsToDeleteKey];
            }
         }
         return key;
      }
      
      public static function getResults(fightResultKey:String) : Object
      {
         if(fightResultKey in fightResults)
         {
            return fightResults[fightResultKey];
         }
         return null;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get entitiesFrame() : FightEntitiesFrame
      {
         return this._entitiesFrame;
      }
      
      public function get battleFrame() : FightBattleFrame
      {
         return this._battleFrame;
      }
      
      public function get preparationFrame() : FightPreparationFrame
      {
         return this._preparationFrame;
      }
      
      public function get surrenderVoteFrame() : FightSurrenderFrame
      {
         return this._surrenderVoteFrame;
      }
      
      public function get challengesList() : Array
      {
         return this._challengesList;
      }
      
      public function get challengeBonus() : uint
      {
         return this._challengeBonusType;
      }
      
      public function get challengeMod() : uint
      {
         return this._challengeSelectionMod;
      }
      
      public function get fightType() : uint
      {
         return this._fightType;
      }
      
      public function set fightType(t:uint) : void
      {
         this._fightType = t;
         var partyFrame:PartyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
         partyFrame.lastFightType = t;
      }
      
      public function get isKolossium() : Boolean
      {
         return this._fightType === FightTypeEnum.FIGHT_TYPE_PVP_ARENA;
      }
      
      public function get timelineOverEntity() : Boolean
      {
         return this._timelineOverEntity;
      }
      
      public function get timelineOverEntityId() : Number
      {
         return this._timelineOverEntityId;
      }
      
      public function get showPermanentTooltips() : Boolean
      {
         return this._showPermanentTooltips;
      }
      
      public function get hiddenEntites() : Array
      {
         return this._hiddenEntites;
      }
      
      public function get fightersPositionsHistory() : Dictionary
      {
         return this._fightersPositionsHistory;
      }
      
      public function pushed() : Boolean
      {
         InactivityManager.getInstance().pause(true);
         if(!Kernel.beingInReconection && MapDisplayManager.getInstance().getDataMapContainer())
         {
            this._roleplayGridDisplayed = Atouin.getInstance().options.getOption("alwaysShowGrid");
         }
         currentCell = -1;
         this._overEffectOk = new GlowFilter(16777215,1,4,4,3,1);
         this._overEffectKo = new GlowFilter(14090240,1,4,4,3,1);
         var matrix:Array = [0.5,0,0,0,100,0,0.5,0,0,100,0,0,0.5,0,100,0,0,0,1,0];
         this._linkedEffect = new ColorMatrixFilter(matrix);
         var matrix2:Array = [0.5,0,0,0,0,0,0.5,0,0,0,0,0,0.5,0,0,0,0,0,1,0];
         this._linkedMainEffect = new ColorMatrixFilter(matrix2);
         this._entitiesFrame = new FightEntitiesFrame();
         this._preparationFrame = new FightPreparationFrame(this);
         this._battleFrame = new FightBattleFrame();
         this._surrenderVoteFrame = new FightSurrenderFrame();
         this._challengesList = [];
         this._timerFighterInfo = new BenchmarkTimer(100,1,"FightContextFrame._timerFighterInfo");
         this._timerFighterInfo.addEventListener(TimerEvent.TIMER,this.showFighterInfo,false,0,true);
         this._timerMovementRange = new BenchmarkTimer(200,1,"FightContextFrame._timerMovementRange");
         this._timerMovementRange.addEventListener(TimerEvent.TIMER,this.showMovementRange,false,0,true);
         if(MapDisplayManager.getInstance().getDataMapContainer())
         {
            MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
         }
         if(Kernel.getWorker().contains(EntitiesTooltipsFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(EntitiesTooltipsFrame) as EntitiesTooltipsFrame);
         }
         this._showPermanentTooltips = OptionManager.getOptionManager("dofus").getOption("showPermanentTargetsTooltips");
         OptionManager.getOptionManager("dofus").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onUiUnloaded);
         Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_STARTED,this.onUiUnloadStarted);
         Berilia.getInstance().addEventListener(TooltipEvent.TOOLTIPS_ORDERED,this.onTooltipsOrdered);
         try
         {
            Berilia.getInstance().uiSavedModificationPresetName = "fight";
         }
         catch(error:Error)
         {
            _log.error("Failed to set uiSavedModificationPresetName to \'fight\'!\n" + error.message + "\n" + error.getStackTrace());
         }
         return true;
      }
      
      private function onUiUnloaded(pEvent:UiUnloadEvent) : void
      {
         var entityId:Number = NaN;
         if(this._showPermanentTooltips && this.battleFrame)
         {
            for each(entityId in this.battleFrame.targetedEntities)
            {
               this.displayEntityTooltip(entityId);
            }
         }
      }
      
      public function getFighterName(fighterId:Number, depth:uint = 0) : String
      {
         var fighterInfos:GameFightFighterInformations = null;
         var monsterData:Monster = null;
         var compInfos:GameFightEntityInformation = null;
         var genericName:String = null;
         var taxInfos:GameFightTaxCollectorInformations = null;
         fighterInfos = this.getFighterInfos(fighterId);
         if(!fighterInfos)
         {
            return "Unknown Fighter";
         }
         var name:String = null;
         var masterName:String = null;
         switch(true)
         {
            case fighterInfos is GameFightFighterNamedInformations:
               name = (fighterInfos as GameFightFighterNamedInformations).name;
               break;
            case fighterInfos is GameFightMonsterInformations:
               monsterData = Monster.getMonsterById((fighterInfos as GameFightMonsterInformations).creatureGenericId);
               if(monsterData !== null)
               {
                  if(fighterInfos.stats.summoned && fighterInfos.stats.summoner !== PlayedCharacterManager.getInstance().id && depth < FIGHTER_NAME_DEPTH_LIMIT)
                  {
                     masterName = this.getFighterName(fighterInfos.stats.summoner,depth + 1);
                     name = I18n.getUiText("ui.common.belonging",[monsterData.name,masterName]);
                  }
                  else
                  {
                     name = monsterData.name;
                  }
               }
               break;
            case fighterInfos is GameFightEntityInformation:
               compInfos = fighterInfos as GameFightEntityInformation;
               genericName = Companion.getCompanionById(compInfos.entityModelId).name;
               if(compInfos.masterId != PlayedCharacterManager.getInstance().id && depth < FIGHTER_NAME_DEPTH_LIMIT)
               {
                  masterName = this.getFighterName(compInfos.masterId,depth + 1);
                  name = I18n.getUiText("ui.common.belonging",[genericName,masterName]);
               }
               else
               {
                  name = genericName;
               }
               break;
            case fighterInfos is GameFightTaxCollectorInformations:
               taxInfos = fighterInfos as GameFightTaxCollectorInformations;
               name = TaxCollectorFirstname.getTaxCollectorFirstnameById(taxInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(taxInfos.lastNameId).name;
         }
         if(name === null)
         {
            return "Unknown Fighter Type";
         }
         return name;
      }
      
      public function getFighterLevel(fighterId:Number) : uint
      {
         var entity:* = null;
         var creatureLevel:uint = 0;
         var minLevel:uint = 0;
         var fighterInfos:GameFightFighterInformations = this.getFighterInfos(fighterId);
         if(!fighterInfos)
         {
            return 0;
         }
         switch(true)
         {
            case fighterInfos is GameFightMutantInformations:
               return (fighterInfos as GameFightMutantInformations).powerLevel;
            case fighterInfos is GameFightCharacterInformations:
               return (fighterInfos as GameFightCharacterInformations).level;
            case fighterInfos is GameFightEntityInformation:
               return (fighterInfos as GameFightEntityInformation).level;
            case fighterInfos is GameFightTaxCollectorInformations:
               return ProtocolConstantsEnum.MAX_LEVEL;
            case fighterInfos is GameFightMonsterInformations:
               if(this.fightType == FightTypeEnum.FIGHT_TYPE_BREACH)
               {
                  minLevel = uint.MAX_VALUE;
                  for(entity in this._entitiesFrame.entities)
                  {
                     if(this._entitiesFrame.entities[entity] is GameFightMonsterInformations)
                     {
                        creatureLevel = this._entitiesFrame.entities[entity].creatureLevel;
                        if((fighterInfos as GameFightMonsterInformations).creatureGenericId == this._entitiesFrame.entities[entity].creatureGenericId && (this._entitiesFrame.entities[entity] as GameFightMonsterInformations).stats.summoned)
                        {
                           return creatureLevel;
                        }
                        if(!(this._entitiesFrame.entities[entity] as GameFightMonsterInformations).stats.summoned)
                        {
                           if(minLevel > creatureLevel)
                           {
                              minLevel = creatureLevel;
                           }
                        }
                     }
                  }
                  return minLevel;
               }
               if(fighterInfos.stats.summoned)
               {
                  return this.getFighterLevel(fighterInfos.stats.summoner);
               }
               return (fighterInfos as GameFightMonsterInformations).creatureLevel;
               break;
            default:
               return 0;
         }
      }
      
      public function getFighters() : Vector.<Number>
      {
         if(this.battleFrame.fightersList && !Kernel.getWorker().getFrame(FightPreparationFrame))
         {
            return this.battleFrame.fightersList;
         }
         return this.entitiesFrame.getOrdonnedPreFighters();
      }
      
      public function getChallengeById(challengeId:uint) : ChallengeWrapper
      {
         var challenge:ChallengeWrapper = null;
         for each(challenge in this._challengesList)
         {
            if(challenge.id == challengeId)
            {
               return challenge;
            }
         }
         return null;
      }
      
      public function process(msg:Message) : Boolean
      {
         var fscf:FightSpellCastFrame = null;
         var challenge:ChallengeWrapper = null;
         var gfsmsg:GameFightStartingMessage = null;
         var TreasurHuntMask:Sprite = null;
         var playCustom:Boolean = false;
         var mcmsg:CurrentMapMessage = null;
         var wp:WorldPointWrapper = null;
         var questFrame:QuestFrame = null;
         var gcrmsg:GameContextReadyMessage = null;
         var mlcm:MapsLoadingCompleteMessage = null;
         var dofusOptionsManager:OptionManager = null;
         var gfrmsg:GameFightResumeMessage = null;
         var playerId:Number = NaN;
         var cooldownInfos:Vector.<GameFightResumeSlaveInfo> = null;
         var playerCoolDownInfo:GameFightResumeSlaveInfo = null;
         var playedFighterManager:CurrentPlayedFighterManager = null;
         var i:int = 0;
         var num:int = 0;
         var infos:GameFightResumeSlaveInfo = null;
         var spellCastManager:SpellCastInFightManager = null;
         var castingSpellPool:Array = null;
         var targetPool:Array = null;
         var durationPool:Array = null;
         var castingSpell:SpellCastSequenceContext = null;
         var numEffects:uint = 0;
         var buff:FightDispellableEffectExtendedInformations = null;
         var gfutmsg:GameFightUpdateTeamMessage = null;
         var gfspmsg:GameFightSpectateMessage = null;
         var fightStartTime:Number = NaN;
         var attackersName:String = null;
         var defendersName:String = null;
         var castingSpellPools:Array = null;
         var targetPools:Array = null;
         var durationPools:Array = null;
         var castingSpells:SpellCastSequenceContext = null;
         var gfsjmsg:GameFightSpectatorJoinMessage = null;
         var timeBeforeStart2:int = 0;
         var attackersName2:String = null;
         var defendersName2:String = null;
         var gfjmsg:GameFightJoinMessage = null;
         var timeBeforeStart:int = 0;
         var gafccmsg:GameActionFightCarryCharacterMessage = null;
         var gfsm:GameFightStartMessage = null;
         var conmsg:CellOverMessage = null;
         var cellEntity:AnimatedCharacter = null;
         var mcm:MarkedCellsManager = null;
         var portalOnThisCell:MarkInstance = null;
         var coutMsg:CellOutMessage = null;
         var cellEntity2:AnimatedCharacter = null;
         var mcmOut:MarkedCellsManager = null;
         var portalOnThisCellOut:MarkInstance = null;
         var emovmsg:EntityMouseOverMessage = null;
         var emomsg:EntityMouseOutMessage = null;
         var gflmsg:GameFightLeaveMessage = null;
         var teoa:TimelineEntityOverAction = null;
         var tleoutaction:TimelineEntityOutAction = null;
         var entityId:Number = NaN;
         var entities:Vector.<Number> = null;
         var gfemsg:GameFightEndMessage = null;
         var cnmsg:ChallengeNumberMessage = null;
         var clmsg:ChallengeListMessage = null;
         var camsg:ChallengeAddMessage = null;
         var challInfo:ChallengeInformation = null;
         var addedChall:ChallengeWrapper = null;
         var ctmsg:ChallengeTargetsMessage = null;
         var ctrmsg:ChallengeTargetsRequestMessage = null;
         var crmsg:ChallengeResultMessage = null;
         var cmsmsg:ChallengeModSelectMessage = null;
         var cmsdmsg:ChallengeModSelectedMessage = null;
         var cbcmsg:ChallengeBonusChoiceMessage = null;
         var cbcsmsg:ChallengeBonusChoiceSelectedMessage = null;
         var csmsg:ChallengeSelectionMessage = null;
         var csedmsg:ChallengeSelectedMessage = null;
         var cvmsg:ChallengeValidateMessage = null;
         var cpmsg:ChallengeProposalMessage = null;
         var challengeProposals:Vector.<ChallengeWrapper> = null;
         var aflmsg:ArenaFighterLeaveMessage = null;
         var moumsg:MapObstacleUpdateMessage = null;
         var bemsg:BreachEnterMessage = null;
         var tsuia:ToggleShowUIAction = null;
         var usma:UpdateSpellModifierAction = null;
         var spellWrapper:SpellWrapper = null;
         var modstersIds:Vector.<uint> = null;
         var monster:int = 0;
         var gfrwsmsg:GameFightResumeWithSlavesMessage = null;
         var buffTmp:BasicBuff = null;
         var namedTeam:NamedPartyTeam = null;
         var buffS:FightDispellableEffectExtendedInformations = null;
         var buffTmpS:BasicBuff = null;
         var namedTeam2:NamedPartyTeam = null;
         var entity:IEntity = null;
         var entityInfos:GameFightFighterInformations = null;
         var mi:MarkInstance = null;
         var glyph:Glyph = null;
         var mpWithPortals:Vector.<MapPoint> = null;
         var links:Vector.<uint> = null;
         var entity2:IEntity = null;
         var miOut:MarkInstance = null;
         var glyphOut:Glyph = null;
         var fightEnding:FightEndingMessage = null;
         var results:Vector.<FightResultEntryWrapper> = null;
         var resultIndex:uint = 0;
         var hardcoreLoots:FightResultEntryWrapper = null;
         var winners:Vector.<FightResultEntryWrapper> = null;
         var temp:Array = null;
         var resultEntryTemp:FightResultListEntry = null;
         var isSpectator:Boolean = false;
         var winnersName:String = null;
         var losersName:String = null;
         var namedTeamWO:NamedPartyTeamWithOutcome = null;
         var resultsRecap:Object = null;
         var resultsKey:String = null;
         var frew:FightResultEntryWrapper = null;
         var id:Number = NaN;
         var resultEntry:FightResultListEntry = null;
         var currentWinner:uint = 0;
         var loot:ItemWrapper = null;
         var kamas:Number = NaN;
         var kamasPerWinner:Number = NaN;
         var winner:FightResultEntryWrapper = null;
         var it:int = 0;
         var chall:ChallengeInformation = null;
         var challengeW:ChallengeWrapper = null;
         var replaced:Boolean = false;
         var index:int = 0;
         var targetW:ChallengeTargetWrapper = null;
         var proposal:ChallengeInformation = null;
         var challWrapper:ChallengeWrapper = null;
         var mo:MapObstacle = null;
         var breachFrame:BreachFrame = null;
         var spellManager:SpellManager = null;
         switch(true)
         {
            case msg is MapLoadedMessage:
               MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
               return true;
            case msg is GameFightStartingMessage:
               gfsmsg = msg as GameFightStartingMessage;
               TreasurHuntMask = Atouin.getInstance().getWorldMask("treasureHinting",false);
               if(TreasurHuntMask && TreasurHuntMask.visible)
               {
                  Atouin.getInstance().toggleWorldMask("treasureHinting",false);
                  this._mustShowTreasureHuntMask = true;
               }
               else
               {
                  this._mustShowTreasureHuntMask = false;
               }
               TooltipManager.hideAll();
               TooltipPlacer.isInFight = true;
               SubhintManager.getInstance().closeSubhint();
               Atouin.getInstance().cancelZoom();
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               MapDisplayManager.getInstance().activeIdentifiedElements(false);
               FightEventsHelper.reset();
               KernelEventsManager.getInstance().processCallback(HookList.GameFightStarting,gfsmsg.fightType);
               this.fightType = gfsmsg.fightType;
               this._fightAttackerId = gfsmsg.attackerId;
               PlayedCharacterManager.getInstance().fightId = gfsmsg.fightId;
               if(PlayerManager.getInstance().kisServerPort > 0)
               {
                  _log.log(2,"KIS fight started : " + gfsmsg.fightId + "-" + PlayedCharacterManager.getInstance().currentMap.mapId + " (port : " + PlayerManager.getInstance().kisServerPort + ")");
               }
               else
               {
                  _log.log(2,"Game fight started : " + gfsmsg.fightId + "-" + PlayedCharacterManager.getInstance().currentMap.mapId + " (port : " + PlayerManager.getInstance().gameServerPort + ")");
               }
               CurrentPlayedFighterManager.getInstance().currentFighterId = PlayedCharacterManager.getInstance().id;
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = 1;
               playCustom = false;
               if(FeatureManager.getInstance().isFeatureWithKeywordEnabled("character.spell.forgettable.modsters"))
               {
                  modstersIds = MonsterRace.getMonsterRaceById(DataEnum.MONSTER_TYPE_OSATOPIA).monsters;
                  for each(monster in gfsmsg.monsters)
                  {
                     if(modstersIds.indexOf(monster) != -1)
                     {
                        playCustom = true;
                        break;
                     }
                  }
               }
               SoundManager.getInstance().manager.playFightMusic(gfsmsg.containsBoss,playCustom);
               SoundManager.getInstance().manager.playUISound(UISoundEnum.INTRO_FIGHT);
               return true;
            case msg is CurrentMapMessage:
               mcmsg = msg as CurrentMapMessage;
               ConnectionsHandler.pause();
               Kernel.getWorker().pause();
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
               wp = new WorldPointWrapper(mcmsg.mapId);
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               Atouin.getInstance().initPreDisplay(wp);
               Atouin.getInstance().clearEntities();
               this._currentMapRenderId = Atouin.getInstance().display(wp);
               _log.info("Ask map render for fight #" + this._currentMapRenderId);
               PlayedCharacterManager.getInstance().currentMap = wp;
               PlayedCharacterManager.getInstance().currentSubArea = SubArea.getSubAreaByMapId(mcmsg.mapId);
               questFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
               if(questFrame && questFrame.followedQuestsCallback)
               {
                  questFrame.followedQuestsCallback.exec();
               }
               KernelEventsManager.getInstance().processCallback(HookList.CurrentMap,mcmsg.mapId);
               return false;
            case msg is MapsLoadingCompleteMessage:
               _log.info("MapsLoadingCompleteMessage #" + MapsLoadingCompleteMessage(msg).renderRequestId);
               if(this._currentMapRenderId != MapsLoadingCompleteMessage(msg).renderRequestId)
               {
                  return false;
               }
               Atouin.getInstance().showWorld(true);
               Atouin.getInstance().cellOverEnabled = true;
               gcrmsg = new GameContextReadyMessage();
               gcrmsg.initGameContextReadyMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
               ConnectionsHandler.getConnection().send(gcrmsg);
               mlcm = msg as MapsLoadingCompleteMessage;
               SoundManager.getInstance().manager.setSubArea(mlcm.mapData);
               Kernel.getWorker().resume();
               ConnectionsHandler.resume();
               return true;
               break;
            case msg is ToggleEntityIconsAction:
               dofusOptionsManager = OptionManager.getOptionManager("dofus");
               if(dofusOptionsManager === null)
               {
                  return false;
               }
               dofusOptionsManager.setOption("toggleEntityIcons",(msg as ToggleEntityIconsAction).isVisible);
               return true;
               break;
            case msg is GameFightResumeMessage:
               gfrmsg = msg as GameFightResumeMessage;
               playerId = PlayedCharacterManager.getInstance().id;
               this.tacticModeHandler();
               CurrentPlayedFighterManager.getInstance().setCurrentSummonedCreature(gfrmsg.summonCount,playerId);
               CurrentPlayedFighterManager.getInstance().setCurrentSummonedBomb(gfrmsg.bombCount,playerId);
               this._battleFrame.turnsCount = gfrmsg.gameTurn;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,gfrmsg.gameTurn);
               if(msg is GameFightResumeWithSlavesMessage)
               {
                  gfrwsmsg = msg as GameFightResumeWithSlavesMessage;
                  cooldownInfos = gfrwsmsg.slavesInfo;
               }
               else
               {
                  cooldownInfos = new Vector.<GameFightResumeSlaveInfo>();
               }
               playerCoolDownInfo = new GameFightResumeSlaveInfo();
               playerCoolDownInfo.spellCooldowns = gfrmsg.spellCooldowns;
               playerCoolDownInfo.slaveId = PlayedCharacterManager.getInstance().id;
               cooldownInfos.unshift(playerCoolDownInfo);
               playedFighterManager = CurrentPlayedFighterManager.getInstance();
               num = cooldownInfos.length;
               for(i = 0; i < num; i++)
               {
                  infos = cooldownInfos[i];
                  spellCastManager = playedFighterManager.getSpellCastManagerById(infos.slaveId);
                  spellCastManager.currentTurn = gfrmsg.gameTurn;
                  spellCastManager.updateCooldowns(cooldownInfos[i].spellCooldowns);
                  if(infos.slaveId != playerId)
                  {
                     CurrentPlayedFighterManager.getInstance().setCurrentSummonedCreature(infos.summonCount,infos.slaveId);
                     CurrentPlayedFighterManager.getInstance().setCurrentSummonedBomb(infos.bombCount,infos.slaveId);
                  }
               }
               castingSpellPool = [];
               numEffects = gfrmsg.effects.length;
               for(i = 0; i < numEffects; i++)
               {
                  buff = gfrmsg.effects[i];
                  if(!castingSpellPool[buff.effect.targetId])
                  {
                     castingSpellPool[buff.effect.targetId] = [];
                  }
                  targetPool = castingSpellPool[buff.effect.targetId];
                  if(!targetPool[buff.effect.turnDuration])
                  {
                     targetPool[buff.effect.turnDuration] = [];
                  }
                  durationPool = targetPool[buff.effect.turnDuration];
                  castingSpell = durationPool[buff.effect.spellId];
                  if(!castingSpell)
                  {
                     castingSpell = new SpellCastSequenceContext();
                     castingSpell.casterId = buff.sourceId;
                     castingSpell.spellData = Spell.getSpellById(buff.effect.spellId);
                     durationPool[buff.effect.spellId] = castingSpell;
                  }
                  buffTmp = BuffManager.makeBuffFromEffect(buff.effect,castingSpell,buff.actionId);
                  BuffManager.getInstance().addBuff(buffTmp);
               }
               Kernel.getWorker().addForeachTreatment(this,this.addMark,[],gfrmsg.marks);
               Kernel.getWorker().addSingleTreatment(this,this.stopReconnection,[]);
               return true;
            case msg is GameFightUpdateTeamMessage:
               gfutmsg = msg as GameFightUpdateTeamMessage;
               PlayedCharacterManager.getInstance().teamId = gfutmsg.team.teamId;
               return true;
            case msg is GameFightSpectateMessage:
               gfspmsg = msg as GameFightSpectateMessage;
               this.tacticModeHandler();
               this._battleFrame.turnsCount = gfspmsg.gameTurn;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,gfspmsg.gameTurn);
               fightStartTime = gfspmsg.fightStart;
               attackersName = "";
               defendersName = "";
               for each(namedTeam in this._namedPartyTeams)
               {
                  if(namedTeam.partyName && namedTeam.partyName != "")
                  {
                     if(namedTeam.teamId == TeamEnum.TEAM_CHALLENGER)
                     {
                        attackersName = namedTeam.partyName;
                     }
                     else if(namedTeam.teamId == TeamEnum.TEAM_DEFENDER)
                     {
                        defendersName = namedTeam.partyName;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(FightHookList.SpectateUpdate,fightStartTime,attackersName,defendersName);
               castingSpellPools = [];
               for each(buffS in gfspmsg.effects)
               {
                  if(!castingSpellPools[buffS.effect.targetId])
                  {
                     castingSpellPools[buffS.effect.targetId] = [];
                  }
                  targetPools = castingSpellPools[buffS.effect.targetId];
                  if(!targetPools[buffS.effect.turnDuration])
                  {
                     targetPools[buffS.effect.turnDuration] = [];
                  }
                  durationPools = targetPools[buffS.effect.turnDuration];
                  castingSpells = durationPools[buffS.effect.spellId];
                  if(!castingSpells)
                  {
                     castingSpells = new SpellCastSequenceContext();
                     castingSpells.casterId = buffS.sourceId;
                     castingSpells.spellData = Spell.getSpellById(buffS.effect.spellId);
                     durationPools[buffS.effect.spellId] = castingSpells;
                  }
                  buffTmpS = BuffManager.makeBuffFromEffect(buffS.effect,castingSpells,buffS.actionId);
                  BuffManager.getInstance().addBuff(buffTmpS,!(buffTmpS is StatBuff));
               }
               Kernel.getWorker().addForeachTreatment(this,this.addMark,[],gfspmsg.marks);
               Kernel.getWorker().addSingleTreatment(this,this.sendFightEvents,[]);
               return true;
            case msg is GameFightSpectatorJoinMessage:
               gfsjmsg = msg as GameFightSpectatorJoinMessage;
               preFightIsActive = !gfsjmsg.isFightStarted;
               this.fightType = gfsjmsg.fightType;
               Kernel.getWorker().addFrame(this._entitiesFrame);
               if(preFightIsActive)
               {
                  Kernel.getWorker().addFrame(this._preparationFrame);
               }
               else
               {
                  Kernel.getWorker().removeFrame(this._preparationFrame);
                  Kernel.getWorker().addFrame(this._battleFrame);
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
               }
               PlayedCharacterManager.getInstance().isSpectator = true;
               PlayedCharacterManager.getInstance().isFighting = true;
               timeBeforeStart2 = gfsjmsg.timeMaxBeforeFightStart * 100;
               if(timeBeforeStart2 == 0 && preFightIsActive)
               {
                  timeBeforeStart2 = -1;
               }
               KernelEventsManager.getInstance().processCallback(HookList.GameFightJoin,gfsjmsg.canBeCancelled,gfsjmsg.canSayReady,true,timeBeforeStart2,gfsjmsg.fightType,gfsjmsg.isTeamPhase);
               this._namedPartyTeams = gfsjmsg.namedPartyTeams;
               attackersName2 = "";
               defendersName2 = "";
               for each(namedTeam2 in gfsjmsg.namedPartyTeams)
               {
                  if(namedTeam2.partyName && namedTeam2.partyName != "")
                  {
                     if(namedTeam2.teamId == TeamEnum.TEAM_CHALLENGER)
                     {
                        attackersName2 = namedTeam2.partyName;
                     }
                     else if(namedTeam2.teamId == TeamEnum.TEAM_DEFENDER)
                     {
                        defendersName2 = namedTeam2.partyName;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(FightHookList.SpectateUpdate,0,attackersName2,defendersName2);
               return true;
            case msg is INetworkMessage && INetworkMessage(msg).getMessageId() == GameFightJoinMessage.protocolId:
               gfjmsg = msg as GameFightJoinMessage;
               MountAutoTripManager.getInstance().stopCurrentTrip();
               preFightIsActive = !gfjmsg.isFightStarted;
               this.fightType = gfjmsg.fightType;
               if(!Kernel.getWorker().contains(FightEntitiesFrame))
               {
                  Kernel.getWorker().addFrame(this._entitiesFrame);
               }
               if(preFightIsActive)
               {
                  if(!Kernel.getWorker().contains(FightPreparationFrame))
                  {
                     Kernel.getWorker().addFrame(this._preparationFrame);
                  }
                  this.onlyTheOtherTeamCanPlace = !gfjmsg.isTeamPhase;
               }
               else
               {
                  Kernel.getWorker().removeFrame(this._preparationFrame);
                  Kernel.getWorker().addFrame(this._battleFrame);
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
                  this.onlyTheOtherTeamCanPlace = false;
               }
               if(this.fightType == FightTypeEnum.FIGHT_TYPE_PVP_ARENA && !Kernel.getWorker().contains(FightSurrenderFrame))
               {
                  Kernel.getWorker().addFrame(this._surrenderVoteFrame);
               }
               PlayedCharacterManager.getInstance().isSpectator = false;
               PlayedCharacterManager.getInstance().isFighting = true;
               timeBeforeStart = gfjmsg.timeMaxBeforeFightStart * 100;
               if(timeBeforeStart == 0 && preFightIsActive)
               {
                  timeBeforeStart = -1;
               }
               KernelEventsManager.getInstance().processCallback(HookList.GameFightJoin,gfjmsg.canBeCancelled,gfjmsg.canSayReady,false,timeBeforeStart,gfjmsg.fightType,gfjmsg.isTeamPhase);
               if(PlayerManager.getInstance().kisServerPort > 0)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ArenaExternalNotification,ExternalNotificationTypeEnum.KOLO_JOIN,timeBeforeStart);
               }
               return true;
            case msg is GameActionFightCarryCharacterMessage:
               gafccmsg = msg as GameActionFightCarryCharacterMessage;
               if(this._lastEffectEntity && this._lastEffectEntity.object.id == gafccmsg.targetId)
               {
                  this.process(new EntityMouseOutMessage(this._lastEffectEntity.object as IInteractive));
               }
               return false;
            case msg is GameFightStartMessage:
               gfsm = msg as GameFightStartMessage;
               preFightIsActive = false;
               Kernel.getWorker().removeFrame(this._preparationFrame);
               this._entitiesFrame.removeSwords();
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().resetInitialCooldown();
               Kernel.getWorker().addFrame(this._battleFrame);
               KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
               if(PlayerManager.getInstance().kisServerPort > 0)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ArenaExternalNotification,ExternalNotificationTypeEnum.KOLO_START,30000);
               }
               return true;
            case msg is GameContextDestroyMessage:
               TooltipManager.hide();
               Kernel.getWorker().removeFrame(this);
               return true;
            case msg is CellOverMessage:
               conmsg = msg as CellOverMessage;
               fscf = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
               for each(entity in EntitiesManager.getInstance().getEntitiesOnCell(conmsg.cellId))
               {
                  if(entity is AnimatedCharacter && !(entity as AnimatedCharacter).isMoving)
                  {
                     if(!(fscf != null && fscf.isTeleportationPreviewEntity(entity.id)))
                     {
                        entityInfos = this._entitiesFrame.getEntityInfos(entity.id) as GameFightFighterInformations;
                        if(!(entityInfos && entityInfos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE))
                        {
                           cellEntity = entity as AnimatedCharacter;
                        }
                     }
                     continue;
                     continue;
                     break;
                  }
               }
               currentCell = conmsg.cellId;
               if(cellEntity)
               {
                  this.overEntity(cellEntity.id);
               }
               if(fscf !== null && fscf.spell !== null && fscf.spell.portalProjectionForbiddenWithModifiers)
               {
                  return true;
               }
               mcm = MarkedCellsManager.getInstance();
               portalOnThisCell = mcm.getMarkAtCellId(conmsg.cellId,GameActionMarkTypeEnum.PORTAL);
               if(portalOnThisCell)
               {
                  for each(mi in mcm.getMarks(portalOnThisCell.markType,portalOnThisCell.teamId,false))
                  {
                     glyph = mcm.getGlyph(mi.markId);
                     if(glyph && glyph.lbl_number)
                     {
                        glyph.lbl_number.visible = true;
                     }
                  }
                  if(portalOnThisCell.active && mcm.getActivePortalsCount(portalOnThisCell.teamId) >= 2)
                  {
                     mpWithPortals = mcm.getMarksMapPoint(GameActionMarkTypeEnum.PORTAL,portalOnThisCell.teamId);
                     links = LinkedCellsManager.getInstance().getLinks(MapPoint.fromCellId(conmsg.cellId),mpWithPortals);
                     if(links)
                     {
                        LinkedCellsManager.getInstance().drawPortalLinks(links);
                     }
                  }
               }
               return true;
               break;
            case msg is CellOutMessage:
               coutMsg = msg as CellOutMessage;
               for each(entity2 in EntitiesManager.getInstance().getEntitiesOnCell(coutMsg.cellId))
               {
                  if(entity2 is AnimatedCharacter)
                  {
                     cellEntity2 = entity2 as AnimatedCharacter;
                     break;
                  }
               }
               currentCell = -1;
               if(cellEntity2)
               {
                  TooltipManager.hide();
                  TooltipManager.hide("fighter");
                  this.outEntity(cellEntity2.id);
               }
               mcmOut = MarkedCellsManager.getInstance();
               portalOnThisCellOut = mcmOut.getMarkAtCellId(coutMsg.cellId,GameActionMarkTypeEnum.PORTAL);
               if(portalOnThisCellOut)
               {
                  for each(miOut in mcmOut.getMarks(portalOnThisCellOut.markType,portalOnThisCellOut.teamId,false))
                  {
                     glyphOut = mcmOut.getGlyph(miOut.markId);
                     if(glyphOut && glyphOut.lbl_number)
                     {
                        glyphOut.lbl_number.visible = false;
                     }
                  }
               }
               LinkedCellsManager.getInstance().clearLinks();
               return true;
            case msg is EntityMouseOverMessage:
               emovmsg = msg as EntityMouseOverMessage;
               currentCell = emovmsg.entity.position.cellId;
               this.overEntity(emovmsg.entity.id);
               return true;
            case msg is EntityMouseOutMessage:
               emomsg = msg as EntityMouseOutMessage;
               currentCell = -1;
               this.outEntity(emomsg.entity.id);
               return true;
            case msg is GameFightLeaveMessage:
               gflmsg = msg as GameFightLeaveMessage;
               if(gflmsg.charId == PlayedCharacterManager.getInstance().id)
               {
                  if(Kernel.getWorker().getFrame(AllianceFrame))
                  {
                     AllianceFrame.getInstance().currentJoinedFight = null;
                  }
                  PlayedCharacterManager.getInstance().fightId = -1;
               }
               if(TooltipManager.isVisible("tooltipOverEntity_" + gflmsg.charId))
               {
                  currentCell = -1;
                  this.outEntity(gflmsg.charId);
               }
               return false;
            case msg is TimelineEntityOverAction:
               teoa = msg as TimelineEntityOverAction;
               this._timelineOverEntity = true;
               this._timelineOverEntityId = teoa.targetId;
               fscf = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
               if(!fscf)
               {
                  this.removeSpellTargetsTooltips();
               }
               this.overEntity(teoa.targetId,teoa.showRange,teoa.highlightTimelineFighter,teoa.timelineTarget);
               return true;
            case msg is TimelineEntityOutAction:
               tleoutaction = msg as TimelineEntityOutAction;
               entities = this._entitiesFrame.getEntitiesIdsList();
               for each(entityId in entities)
               {
                  if((!this._showPermanentTooltips || this._showPermanentTooltips && this._battleFrame.targetedEntities.indexOf(entityId) == -1) && entityId != tleoutaction.targetId)
                  {
                     TooltipManager.hide("tooltipOverEntity_" + entityId);
                  }
               }
               this._timelineOverEntity = false;
               this.outEntity(tleoutaction.targetId);
               this.removeSpellTargetsTooltips();
               return true;
            case msg is TogglePointCellAction:
               if(Kernel.getWorker().contains(PointCellFrame))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
                  Kernel.getWorker().removeFrame(PointCellFrame.getInstance());
               }
               else
               {
                  Kernel.getWorker().addFrame(PointCellFrame.getInstance());
               }
               return true;
            case msg is GameFightEndMessage:
               gfemsg = msg as GameFightEndMessage;
               if(TacticModeManager.getInstance().tacticModeActivated)
               {
                  TacticModeManager.getInstance().hide(true);
               }
               if(this._entitiesFrame.isInCreaturesFightMode())
               {
                  this._entitiesFrame.showCreaturesInFight(false);
               }
               if(this._mustShowTreasureHuntMask)
               {
                  Atouin.getInstance().toggleWorldMask("treasureHinting",true);
                  this._mustShowTreasureHuntMask = false;
               }
               TooltipManager.hide();
               TooltipManager.hide("fighter");
               TooltipPlacer.isInFight = false;
               this.hideMovementRange();
               CurrentPlayedFighterManager.getInstance().resetPlayerSpellList();
               MapDisplayManager.getInstance().activeIdentifiedElements(true);
               FightEventsHelper.sendAllFightEvent(true);
               SoundManager.getInstance().manager.stopFightMusic();
               PlayedCharacterManager.getInstance().isFighting = false;
               PlayedCharacterManager.getInstance().fightId = -1;
               SpellWrapper.removeAllSpellWrapperBut(PlayedCharacterManager.getInstance().id,SecureCenter.ACCESS_KEY);
               SpellWrapper.resetAllCoolDown(PlayedCharacterManager.getInstance().id,SecureCenter.ACCESS_KEY);
               SpellModifiersManager.getInstance().destroy();
               if(Kernel.getWorker().getFrame(AllianceFrame))
               {
                  AllianceFrame.getInstance().currentJoinedFight = null;
               }
               if(gfemsg.results == null)
               {
                  KernelEventsManager.getInstance().processCallback(FightHookList.SpectatorWantLeave);
               }
               else
               {
                  fightEnding = new FightEndingMessage();
                  fightEnding.initFightEndingMessage();
                  Kernel.getWorker().process(fightEnding);
                  results = new Vector.<FightResultEntryWrapper>();
                  resultIndex = 0;
                  winners = new Vector.<FightResultEntryWrapper>();
                  temp = [];
                  for each(resultEntryTemp in gfemsg.results)
                  {
                     temp.push(resultEntryTemp);
                  }
                  isSpectator = true;
                  for(i = 0; i < temp.length; i++)
                  {
                     resultEntry = temp[i];
                     switch(true)
                     {
                        case resultEntry is FightResultPlayerListEntry:
                           id = (resultEntry as FightResultPlayerListEntry).id;
                           frew = new FightResultEntryWrapper(resultEntry,this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations,isSpectator);
                           frew.alive = FightResultPlayerListEntry(resultEntry).alive;
                           break;
                        case resultEntry is FightResultTaxCollectorListEntry:
                           id = (resultEntry as FightResultTaxCollectorListEntry).id;
                           frew = new FightResultEntryWrapper(resultEntry,this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations,isSpectator);
                           frew.alive = FightResultTaxCollectorListEntry(resultEntry).alive;
                           break;
                        case resultEntry is FightResultFighterListEntry:
                           id = (resultEntry as FightResultFighterListEntry).id;
                           frew = new FightResultEntryWrapper(resultEntry,this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations,isSpectator);
                           frew.alive = FightResultFighterListEntry(resultEntry).alive;
                           break;
                        case resultEntry is FightResultListEntry:
                           frew = new FightResultEntryWrapper(resultEntry,null,isSpectator);
                     }
                     frew.fightInitiator = this._fightAttackerId == id;
                     frew.wave = resultEntry.wave;
                     if(i + 1 < temp.length && temp[i + 1] && temp[i + 1].outcome == resultEntry.outcome && temp[i + 1].wave != resultEntry.wave)
                     {
                        frew.isLastOfHisWave = true;
                     }
                     if(resultEntry.outcome == FightOutcomeEnum.RESULT_DEFENDER_GROUP)
                     {
                        hardcoreLoots = frew;
                     }
                     else
                     {
                        if(resultEntry.outcome == FightOutcomeEnum.RESULT_VICTORY)
                        {
                           winners.push(frew);
                        }
                        var _loc133_:* = resultIndex++;
                        results[_loc133_] = frew;
                     }
                     if(frew.id == PlayedCharacterManager.getInstance().id)
                     {
                        isSpectator = false;
                        switch(resultEntry.outcome)
                        {
                           case FightOutcomeEnum.RESULT_VICTORY:
                              KernelEventsManager.getInstance().processCallback(TriggerHookList.FightResultVictory);
                              SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_FIGHT_WON);
                              break;
                           case FightOutcomeEnum.RESULT_LOST:
                              SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_FIGHT_LOST);
                        }
                        if(frew.rewards.objects.length >= SpeakingItemManager.GREAT_DROP_LIMIT)
                        {
                           SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_GREAT_DROP);
                        }
                     }
                  }
                  if(hardcoreLoots)
                  {
                     currentWinner = 0;
                     for each(loot in hardcoreLoots.rewards.objects)
                     {
                        winners[currentWinner].rewards.objects.push(loot);
                        currentWinner++;
                        currentWinner %= winners.length;
                     }
                     kamas = hardcoreLoots.rewards.kamas;
                     kamasPerWinner = Math.floor(kamas / winners.length);
                     if(kamas % winners.length != 0)
                     {
                        kamasPerWinner++;
                     }
                     for each(winner in winners)
                     {
                        if(kamas < kamasPerWinner)
                        {
                           winner.rewards.kamas = kamas;
                        }
                        else
                        {
                           winner.rewards.kamas = kamasPerWinner;
                        }
                        kamas -= winner.rewards.kamas;
                     }
                  }
                  winnersName = "";
                  losersName = "";
                  for each(namedTeamWO in gfemsg.namedPartyTeamsOutcomes)
                  {
                     if(namedTeamWO.team.partyName && namedTeamWO.team.partyName != "")
                     {
                        if(namedTeamWO.outcome == FightOutcomeEnum.RESULT_VICTORY)
                        {
                           winnersName = namedTeamWO.team.partyName;
                        }
                        else if(namedTeamWO.outcome == FightOutcomeEnum.RESULT_LOST)
                        {
                           losersName = namedTeamWO.team.partyName;
                        }
                     }
                  }
                  resultsRecap = new Object();
                  resultsRecap.results = results;
                  resultsRecap.rewardRate = gfemsg.rewardRate;
                  resultsRecap.sizeMalus = gfemsg.lootShareLimitMalus;
                  resultsRecap.duration = gfemsg.duration;
                  resultsRecap.challenges = this.challengesList;
                  resultsRecap.challengeBonusType = this._challengeBonusType;
                  resultsRecap.turns = this._battleFrame.turnsCount;
                  resultsRecap.fightType = this._fightType;
                  resultsRecap.winnersName = winnersName;
                  resultsRecap.losersName = losersName;
                  resultsRecap.playSound = true;
                  resultsRecap.isSpectator = isSpectator;
                  if(msg is BreachGameFightEndMessage)
                  {
                     resultsRecap.budget = (gfemsg as BreachGameFightEndMessage).budget;
                  }
                  resultsKey = saveResults(resultsRecap);
                  if(!PlayedCharacterManager.getInstance().isSpectator)
                  {
                     FightEventsHelper.sendFightEvent(FightEventEnum.FIGHT_END,[resultsKey],0,-1,true);
                  }
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightEnd,resultsKey);
                  if(PlayerManager.getInstance().kisServerPort > 0)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ArenaExternalNotification,ExternalNotificationTypeEnum.KOLO_FIGHT_END);
                  }
               }
               Kernel.getWorker().removeFrame(this);
               return true;
            case msg is ChallengeNumberMessage:
               cnmsg = msg as ChallengeNumberMessage;
               this._challengesList = [];
               for(it = 0; it < cnmsg.challengeNumber; it++)
               {
                  this._challengesList.push(new EmptyChallengeWrapper());
               }
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeListUpdate,this.challengesList);
               return true;
            case msg is ChallengeListMessage:
               clmsg = msg as ChallengeListMessage;
               for each(chall in clmsg.challengesInformation)
               {
                  if(Challenge.getChallengeById(chall.challengeId))
                  {
                     challengeW = this.getChallengeById(chall.challengeId);
                     if(!challengeW)
                     {
                        challengeW = new ChallengeWrapper();
                        this.challengesList.push(challengeW);
                     }
                     challengeW.id = chall.challengeId;
                     challengeW.setTargetsFromTargetInformation(chall.targetsList);
                     challengeW.xpBonus = chall.xpBonus;
                     challengeW.dropBonus = chall.dropBonus;
                     challengeW.state = chall.state;
                  }
               }
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeListUpdate,this.challengesList);
               KernelEventsManager.getInstance().processCallback(FightHookList.CloseChallengeProposal);
               return true;
            case msg is ChallengeAddMessage:
               camsg = msg as ChallengeAddMessage;
               challInfo = camsg.challengeInformation;
               if(!Challenge.getChallengeById(challInfo.challengeId))
               {
                  return true;
               }
               addedChall = this.getChallengeById(challInfo.challengeId);
               if(!addedChall)
               {
                  addedChall = new ChallengeWrapper();
                  replaced = false;
                  for(index = 0; index < this.challengesList.length; index++)
                  {
                     if(this.challengesList[index] is EmptyChallengeWrapper)
                     {
                        this.challengesList[index] = addedChall;
                        replaced = true;
                        break;
                     }
                  }
                  if(!replaced)
                  {
                     this.challengesList.push(addedChall);
                  }
               }
               addedChall.id = challInfo.challengeId;
               addedChall.setTargetsFromTargetInformation(challInfo.targetsList);
               addedChall.xpBonus = challInfo.xpBonus;
               addedChall.dropBonus = challInfo.dropBonus;
               addedChall.state = challInfo.state;
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeListUpdate,this.challengesList);
               return true;
               break;
            case msg is ChallengeTargetsMessage:
               ctmsg = msg as ChallengeTargetsMessage;
               challenge = this.getChallengeById(ctmsg.challengeInformation.challengeId);
               if(challenge == null)
               {
                  _log.warn("Got a challenge update with no corresponding challenge (challenge id " + ctmsg.challengeInformation.challengeId + "), skipping.");
                  return false;
               }
               challenge.setTargetsFromTargetInformation(ctmsg.challengeInformation.targetsList);
               challenge.xpBonus = ctmsg.challengeInformation.xpBonus;
               challenge.dropBonus = ctmsg.challengeInformation.dropBonus;
               challenge.state = ctmsg.challengeInformation.state;
               for each(targetW in challenge.targets)
               {
                  if(targetW.targetCell != -1 && (targetW.attackers.indexOf(PlayedCharacterManager.getInstance().id) != -1 || targetW.attackers.length == 0))
                  {
                     HyperlinkShowCellManager.showCell(targetW.targetCell);
                  }
               }
               return true;
               break;
            case msg is ChallengeTargetsRequestAction:
               ctrmsg = new ChallengeTargetsRequestMessage();
               ctrmsg.initChallengeTargetsRequestMessage((msg as ChallengeTargetsRequestAction).challengeId);
               ConnectionsHandler.getConnection().send(ctrmsg);
               return true;
            case msg is ChallengeResultMessage:
               crmsg = msg as ChallengeResultMessage;
               challenge = this.getChallengeById(crmsg.challengeId);
               if(!challenge)
               {
                  _log.warn("Got a challenge result with no corresponding challenge (challenge id " + crmsg.challengeId + "), skipping.");
                  return false;
               }
               challenge.state = !!crmsg.success ? uint(ChallengeStateEnum.CHALLENGE_COMPLETED) : uint(ChallengeStateEnum.CHALLENGE_FAILED);
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeListUpdate,this.challengesList);
               return true;
               break;
            case msg is ChallengeModSelectAction:
               cmsmsg = new ChallengeModSelectMessage();
               this._challengeSelectionMod = (msg as ChallengeModSelectAction).mod;
               cmsmsg.initChallengeModSelectMessage(this._challengeSelectionMod);
               ConnectionsHandler.getConnection().send(cmsmsg);
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeModSelected,this._challengeSelectionMod);
               return true;
            case msg is ChallengeModSelectedMessage:
               cmsdmsg = msg as ChallengeModSelectedMessage;
               this._challengeSelectionMod = cmsdmsg.challengeMod;
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeModSelected,this._challengeSelectionMod);
               return true;
            case msg is ChallengeBonusSelectAction:
               cbcmsg = new ChallengeBonusChoiceMessage();
               cbcmsg.initChallengeBonusChoiceMessage((msg as ChallengeBonusSelectAction).bonus);
               ConnectionsHandler.getConnection().send(cbcmsg);
               return true;
            case msg is ChallengeBonusChoiceSelectedMessage:
               cbcsmsg = msg as ChallengeBonusChoiceSelectedMessage;
               this._challengeBonusType = cbcsmsg.challengeBonus;
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeBonusSelected,this._challengeBonusType);
               return true;
            case msg is ChallengeSelectionAction:
               csmsg = new ChallengeSelectionMessage();
               csmsg.initChallengeSelectionMessage((msg as ChallengeSelectionAction).challengeId);
               ConnectionsHandler.getConnection().send(csmsg);
               return true;
            case msg is ChallengeSelectedMessage:
               csedmsg = msg as ChallengeSelectedMessage;
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeSelected,csedmsg.challengeInformation.challengeId);
               return true;
            case msg is ChallengeValidateAction:
               cvmsg = new ChallengeValidateMessage();
               cvmsg.initChallengeValidateMessage((msg as ChallengeValidateAction).challengeId);
               ConnectionsHandler.getConnection().send(cvmsg);
               return true;
            case msg is ChallengeProposalMessage:
               cpmsg = msg as ChallengeProposalMessage;
               challengeProposals = new Vector.<ChallengeWrapper>();
               for each(proposal in cpmsg.challengeProposals)
               {
                  challWrapper = new ChallengeWrapper();
                  challWrapper.id = proposal.challengeId;
                  challWrapper.setTargetsFromTargetInformation(proposal.targetsList);
                  challWrapper.xpBonus = proposal.xpBonus;
                  challWrapper.dropBonus = proposal.dropBonus;
                  challWrapper.state = proposal.state;
                  challengeProposals.push(challWrapper);
               }
               this.challengeChoicePhase = true;
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeProposal,challengeProposals);
               KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeProposalUpdateTimer,cpmsg.timer * 1000);
               return true;
            case msg is ArenaFighterLeaveMessage:
               aflmsg = msg as ArenaFighterLeaveMessage;
               KernelEventsManager.getInstance().processCallback(FightHookList.ArenaFighterLeave,aflmsg.leaver);
               return true;
            case msg is MapObstacleUpdateMessage:
               moumsg = msg as MapObstacleUpdateMessage;
               for each(mo in moumsg.obstacles)
               {
                  InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId,mo.state == MapObstacleStateEnum.OBSTACLE_OPENED);
               }
               return true;
            case msg is GameActionFightNoSpellCastMessage:
               return true;
            case msg is ShowTacticModeAction:
               if(PlayedCharacterApi.getInstance().isInPreFight())
               {
                  return false;
               }
               if(PlayedCharacterApi.getInstance().isInFight() || PlayedCharacterManager.getInstance().isSpectator)
               {
                  if((msg as ShowTacticModeAction).force)
                  {
                     if(!TacticModeManager.getInstance().tacticModeActivated)
                     {
                        TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
                     }
                  }
                  else
                  {
                     this.tacticModeHandler(true);
                  }
               }
               return true;
               break;
            case msg is BreachEnterMessage:
               bemsg = msg as BreachEnterMessage;
               PlayedCharacterManager.getInstance().isInBreach = true;
               if(!Kernel.getWorker().getFrame(BreachFrame))
               {
                  breachFrame = new BreachFrame();
                  breachFrame.ownerId = bemsg.owner;
                  Kernel.getWorker().addFrame(breachFrame);
               }
               KernelEventsManager.getInstance().processCallback(HookList.BreachTeleport,true);
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
                  if(Kernel.getWorker().getFrame(BreachFrame))
                  {
                     Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(BreachFrame));
                  }
               }
               return true;
            case msg is ToggleShowUIAction:
               tsuia = msg as ToggleShowUIAction;
               tsuia.toggleUIs();
               return true;
            case msg is UpdateSpellModifierAction:
               usma = msg as UpdateSpellModifierAction;
               spellWrapper = SpellWrapper.getSpellWrapperById(usma.spellId,usma.entityId);
               if(spellWrapper !== null)
               {
                  ++spellWrapper.versionNum;
                  if(usma.statId === SpellModifierTypeEnum.CAST_INTERVAL)
                  {
                     spellManager = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(usma.entityId).getSpellManagerBySpellId(usma.spellId);
                     if(spellManager !== null)
                     {
                        spellWrapper.actualCooldown = spellManager.cooldown;
                     }
                  }
                  else if(usma.statId === SpellModifierTypeEnum.AP_COST)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.SpellUpdate,spellWrapper);
                  }
               }
               return true;
            case msg is ArenaFighterIdleMessage:
               KernelEventsManager.getInstance().processCallback(HookList.KISInactivityNotification,[]);
               return true;
            case msg is SurrenderPopupNameAction:
               this._surrenderPopupName = (msg as SurrenderPopupNameAction).popupName;
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         if(TacticModeManager.getInstance().tacticModeActivated)
         {
            TacticModeManager.getInstance().hide(true);
         }
         if(Berilia.getInstance().getUi(this._surrenderPopupName))
         {
            Berilia.getInstance().unloadUi(this._surrenderPopupName);
         }
         if(Berilia.getInstance().getUi(this.surrenderVoteFrame.refusalPopupName))
         {
            Berilia.getInstance().unloadUi(this.surrenderVoteFrame.refusalPopupName);
         }
         if(this._battleFrame)
         {
            Kernel.getWorker().removeFrame(this._battleFrame);
         }
         if(this._entitiesFrame)
         {
            Kernel.getWorker().removeFrame(this._entitiesFrame);
         }
         if(this._preparationFrame)
         {
            Kernel.getWorker().removeFrame(this._preparationFrame);
         }
         if(this._surrenderVoteFrame)
         {
            Kernel.getWorker().removeFrame(this._surrenderVoteFrame);
         }
         SerialSequencer.clearByType(FightSequenceFrame.FIGHT_SEQUENCERS_CATEGORY);
         this._preparationFrame = null;
         this._battleFrame = null;
         this._lastEffectEntity = null;
         this.removeSpellTargetsTooltips();
         TooltipManager.hideAll();
         if(this._timerFighterInfo)
         {
            this._timerFighterInfo.reset();
            this._timerFighterInfo.removeEventListener(TimerEvent.TIMER,this.showFighterInfo);
            this._timerFighterInfo = null;
         }
         if(this._timerMovementRange)
         {
            this._timerMovementRange.reset();
            this._timerMovementRange.removeEventListener(TimerEvent.TIMER,this.showMovementRange);
            this._timerMovementRange = null;
         }
         this._currentFighterInfo = null;
         if(MapDisplayManager.getInstance().getDataMapContainer())
         {
            MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(true);
         }
         Atouin.getInstance().displayGrid(this._roleplayGridDisplayed);
         OptionManager.getOptionManager("dofus").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onUiUnloaded);
         var simf:SpellInventoryManagementFrame = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
         simf.deleteSpellsGlobalCoolDownsData();
         PlayedCharacterManager.getInstance().isSpectator = false;
         Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_STARTED,this.onUiUnloadStarted);
         Berilia.getInstance().removeEventListener(TooltipEvent.TOOLTIPS_ORDERED,this.onTooltipsOrdered);
         try
         {
            Berilia.getInstance().uiSavedModificationPresetName = null;
         }
         catch(error:Error)
         {
            _log.error("Failed to reset uiSavedModificationPresetName!\n" + error.message + "\n" + error.getStackTrace());
         }
         InactivityManager.getInstance().pause(false);
         return true;
      }
      
      public function outEntity(id:Number) : void
      {
         var entityId:Number = NaN;
         var ttName:String = null;
         var entitiesOnCell:Array = null;
         var entityOnCell:AnimatedCharacter = null;
         this._timerFighterInfo.reset();
         this._timerMovementRange.reset();
         var tooltipsEntitiesIds:Vector.<Number> = new Vector.<Number>(0);
         tooltipsEntitiesIds.push(id);
         var entitiesIdsList:Vector.<Number> = this._entitiesFrame.getEntitiesIdsList();
         fighterEntityTooltipId = id;
         var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
         if(!entity || !entity.position)
         {
            if(entitiesIdsList.indexOf(fighterEntityTooltipId) == -1)
            {
               _log.info("Mouse out an unknown entity : " + id);
               return;
            }
         }
         else
         {
            entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(entity.position.cellId,AnimatedCharacter);
            for each(entityOnCell in entitiesOnCell)
            {
               if(tooltipsEntitiesIds.indexOf(entityOnCell.id) == -1)
               {
                  tooltipsEntitiesIds.push(entityOnCell.id);
               }
            }
         }
         if(this._lastEffectEntity && this._lastEffectEntity.object)
         {
            Sprite(this._lastEffectEntity.object).filters = [];
         }
         this._lastEffectEntity = null;
         var fscf:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         for each(entityId in tooltipsEntitiesIds)
         {
            ttName = "tooltipOverEntity_" + entityId;
            if((!this._showPermanentTooltips || this._showPermanentTooltips && this.battleFrame.targetedEntities.indexOf(entityId) == -1) && TooltipManager.isVisible(ttName) && (fscf == null || !fscf.isTeleportationPreviewEntity(entityId)))
            {
               TooltipManager.hide(ttName);
            }
         }
         if(this._showPermanentTooltips)
         {
            for each(entityId in this.battleFrame.targetedEntities)
            {
               this.displayEntityTooltip(entityId);
            }
         }
         if(entity != null)
         {
            Sprite(entity).filters = [];
         }
         this.hideMovementRange();
         var inviSel:Selection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
         if(inviSel)
         {
            inviSel.remove();
         }
         this.removeAsLinkEntityEffect();
         if(this._currentFighterInfo && this._currentFighterInfo.contextualId == id)
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,null);
            if(PlayedCharacterManager.getInstance().isSpectator && OptionManager.getOptionManager("dofus").getOption("spectatorAutoShowCurrentFighterInfo") == true)
            {
               KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._battleFrame.currentPlayerId) as GameFightFighterInformations);
            }
         }
         var fightPreparationFrame:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if(fightPreparationFrame)
         {
            fightPreparationFrame.updateSwapPositionRequestsIcons();
         }
      }
      
      public function removeSpellTargetsTooltips() : void
      {
         var ttEntityId:* = undefined;
         for(ttEntityId in this._spellTargetsTooltips)
         {
            TooltipPlacer.removeTooltipPositionByName("tooltip_tooltipOverEntity_" + ttEntityId);
            delete this._spellTargetsTooltips[ttEntityId];
            TooltipManager.hide("tooltipOverEntity_" + ttEntityId);
            SpellDamagesManager.getInstance().removeSpellDamages(ttEntityId);
            if(this._showPermanentTooltips && this._battleFrame && this._battleFrame.targetedEntities.indexOf(ttEntityId) != -1)
            {
               this.displayEntityTooltip(ttEntityId);
            }
         }
      }
      
      public function displayEntityTooltip(pEntityId:Number, pSpell:Object = null, pForceRefresh:Boolean = false, pSpellImpactCell:int = -1, pMakerParams:Object = null) : int
      {
         var entitiesOnCell:Array = null;
         var fighterNamedInfo:GameFightFighterNamedInformations = null;
         var timer:int = getTimer();
         var infos:GameFightFighterInformations = this._entitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations;
         var updateTime:uint = getTimer();
         this._tooltipLastUpdate[pEntityId] = updateTime;
         if(!infos || this._battleFrame.targetedEntities.indexOf(pEntityId) != -1 && this._hiddenEntites.indexOf(pEntityId) != -1)
         {
            return getTimer() - timer;
         }
         var spellImpactCell:int = pSpellImpactCell != -1 ? int(pSpellImpactCell) : int(currentCell);
         if(pSpell && spellImpactCell == -1)
         {
            return getTimer() - timer;
         }
         if(pSpell is SpellWrapper)
         {
            entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(spellImpactCell,AnimatedCharacter);
            if((pSpell as SpellWrapper).needTakenCellWithModifiers && entitiesOnCell.length == 0)
            {
               return getTimer() - timer;
            }
         }
         var tooltipCacheName:String = "EntityShortInfos" + infos.contextualId;
         infos = this._entitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations;
         var entity:IDisplayable = DofusEntities.getEntity(pEntityId) as IDisplayable;
         if(pMakerParams != null && pMakerParams.previewEntity != null)
         {
            entity = pMakerParams.previewEntity;
         }
         if(entity == null)
         {
            return getTimer() - timer;
         }
         var target:IRectangle = entity.absoluteBounds;
         var typeString:String = "monsterFighter";
         if(infos is GameFightCharacterInformations)
         {
            tooltipCacheName = "PlayerShortInfos" + infos.contextualId;
            typeString = null;
            fighterNamedInfo = infos as GameFightFighterNamedInformations;
            if(fighterNamedInfo && fighterNamedInfo.hiddenInPrefight)
            {
               return getTimer() - timer;
            }
         }
         else if(infos is GameFightEntityInformation)
         {
            typeString = "companionFighter";
         }
         TooltipManager.show(infos,target,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"tooltipOverEntity_" + infos.contextualId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,typeString,null,pMakerParams,tooltipCacheName,false,StrataEnum.STRATA_WORLD,Atouin.getInstance().currentZoom);
         var fightPreparationFrame:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if(fightPreparationFrame)
         {
            fightPreparationFrame.updateSwapPositionRequestsIcons();
         }
         if(tooltipCacheName && TooltipManager.hasCache(tooltipCacheName))
         {
            this._entitiesFrame.updateEntityIconPosition(pEntityId);
         }
         return getTimer() - timer;
      }
      
      public function addToHiddenEntities(entityId:Number) : void
      {
         if(this._hiddenEntites.indexOf(entityId) == -1)
         {
            this._hiddenEntites.push(entityId);
         }
      }
      
      public function removeFromHiddenEntities(entityId:Number) : void
      {
         if(this._hiddenEntites.indexOf(entityId) != -1)
         {
            this._hiddenEntites.splice(this._hiddenEntites.indexOf(entityId),1);
         }
      }
      
      private function initFighterPositionHistory(pFighterId:Number) : void
      {
         var fightContextFrame:FightContextFrame = null;
         if(!this._fightersPositionsHistory[pFighterId])
         {
            fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            this._fightersPositionsHistory[pFighterId] = [{
               "cellId":fightContextFrame.entitiesFrame.getEntityInfos(pFighterId).disposition.cellId,
               "lives":2
            }];
         }
      }
      
      public function getFighterPreviousPosition(pFighterId:Number) : int
      {
         this.initFighterPositionHistory(pFighterId);
         var positions:Array = this._fightersPositionsHistory[pFighterId];
         var savedPos:Object = positions.length > 1 ? positions[positions.length - 2] : null;
         return !!savedPos ? int(savedPos.cellId) : -1;
      }
      
      public function deleteFighterPreviousPosition(pFighterId:Number) : void
      {
         if(this._fightersPositionsHistory[pFighterId])
         {
            this._fightersPositionsHistory[pFighterId].pop();
         }
      }
      
      public function saveFighterPosition(pFighterId:Number, pCellId:uint) : void
      {
         this.initFighterPositionHistory(pFighterId);
         this._fightersPositionsHistory[pFighterId].push({
            "cellId":pCellId,
            "lives":2
         });
      }
      
      public function getFighterRoundStartPosition(pFighterId:Number) : int
      {
         return this._fightersRoundStartPosition[pFighterId];
      }
      
      public function setFighterRoundStartPosition(pFighterId:Number, cellId:int) : int
      {
         return this._fightersRoundStartPosition[pFighterId] = cellId;
      }
      
      public function refreshTimelineOverEntityInfos() : void
      {
         var entity:IEntity = null;
         if(this._timelineOverEntity && this._timelineOverEntityId)
         {
            entity = DofusEntities.getEntity(this._timelineOverEntityId);
            if(entity && entity.position)
            {
               FightContextFrame.currentCell = entity.position.cellId;
               this.overEntity(this._timelineOverEntityId);
            }
         }
      }
      
      private function getFighterInfos(fighterId:Number) : GameFightFighterInformations
      {
         return this.entitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations;
      }
      
      private function showFighterInfo(event:TimerEvent) : void
      {
         this._timerFighterInfo.reset();
         KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,this._currentFighterInfo);
      }
      
      private function showMovementRange(event:TimerEvent) : void
      {
         this._timerMovementRange.reset();
         var reachableRangeSelection:Selection = new Selection();
         reachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA,0.7);
         reachableRangeSelection.color = new Color(this.REACHABLE_CELL_COLOR);
         var unreachableRangeSelection:Selection = new Selection();
         unreachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA,0.7);
         unreachableRangeSelection.color = new Color(this.UNREACHABLE_CELL_COLOR);
         var fightReachableCellsMaker:FightReachableCellsMaker = new FightReachableCellsMaker(this._currentFighterInfo);
         reachableRangeSelection.zone = new Custom(fightReachableCellsMaker.reachableCells);
         unreachableRangeSelection.zone = new Custom(fightReachableCellsMaker.unreachableCells);
         SelectionManager.getInstance().addSelection(reachableRangeSelection,"movementReachableRange",this._currentFighterInfo.disposition.cellId);
         SelectionManager.getInstance().addSelection(unreachableRangeSelection,"movementUnreachableRange",this._currentFighterInfo.disposition.cellId);
      }
      
      private function hideMovementRange() : void
      {
         var s:Selection = SelectionManager.getInstance().getSelection("movementReachableRange");
         if(s)
         {
            s.remove();
         }
         s = SelectionManager.getInstance().getSelection("movementUnreachableRange");
         if(s)
         {
            s.remove();
         }
      }
      
      private function addMarks(marks:Vector.<GameActionMark>) : void
      {
         var mark:GameActionMark = null;
         var spell:SpellWrapper = null;
         var step:AddGlyphGfxStep = null;
         var spellData:Spell = null;
         var glyphGfxId:int = 0;
         var cellZone:GameActionMarkedCell = null;
         for each(mark in marks)
         {
            spell = SpellWrapper.create(mark.markSpellId,mark.markSpellLevel,true,mark.markAuthorId);
            spellData = spell.spell;
            glyphGfxId = MarkedCellsManager.getInstance().getResolvedMarkGlyphIdFromSpell(spell,mark.markAuthorId,mark.markimpactCell);
            if(mark.markType == GameActionMarkTypeEnum.WALL || spellData.getSpellLevel(mark.markSpellLevel).hasZoneShape(SpellShapeEnum.semicolon))
            {
               if(glyphGfxId !== 0)
               {
                  for each(cellZone in mark.cells)
                  {
                     step = new AddGlyphGfxStep(glyphGfxId,cellZone.cellId,mark.markId,mark.markType,mark.markTeamId,mark.active);
                     step.start();
                  }
               }
            }
            else if(glyphGfxId !== 0 && !MarkedCellsManager.getInstance().getGlyph(mark.markId) && mark.markimpactCell != -1)
            {
               step = new AddGlyphGfxStep(glyphGfxId,mark.markimpactCell,mark.markId,mark.markType,mark.markTeamId,mark.active);
               step.start();
            }
            MarkedCellsManager.getInstance().addMark(mark.markAuthorId,mark.markId,mark.markType,spellData,spellData.getSpellLevel(mark.markSpellLevel),mark.cells,mark.markTeamId,mark.active,mark.markimpactCell);
         }
      }
      
      private function stopReconnection() : void
      {
         Kernel.beingInReconection = false;
      }
      
      private function sendFightEvents() : void
      {
         FightEventsHelper.sendAllFightEvent();
      }
      
      private function addMark(mark:GameActionMark) : void
      {
         var spell:SpellWrapper = null;
         var step:AddGlyphGfxStep = null;
         var spellData:Spell = null;
         var cellZone:GameActionMarkedCell = null;
         spell = SpellWrapper.create(mark.markSpellId,mark.markSpellLevel,true,mark.markAuthorId);
         spellData = spell.spell;
         var glyphGfxId:int = MarkedCellsManager.getInstance().getResolvedMarkGlyphIdFromSpell(spell,mark.markAuthorId,mark.markimpactCell);
         if(mark.markType == GameActionMarkTypeEnum.WALL || spellData.getSpellLevel(mark.markSpellLevel).hasZoneShape(SpellShapeEnum.semicolon))
         {
            if(glyphGfxId !== 0)
            {
               for each(cellZone in mark.cells)
               {
                  step = new AddGlyphGfxStep(glyphGfxId,cellZone.cellId,mark.markId,mark.markType,mark.markTeamId,mark.active);
                  step.start();
               }
            }
         }
         else if(glyphGfxId !== 0 && !MarkedCellsManager.getInstance().getGlyph(mark.markId) && mark.markimpactCell != -1)
         {
            step = new AddGlyphGfxStep(glyphGfxId,mark.markimpactCell,mark.markId,mark.markType,mark.markTeamId,mark.active);
            step.start();
         }
         MarkedCellsManager.getInstance().addMark(mark.markAuthorId,mark.markId,mark.markType,spellData,spellData.getSpellLevel(mark.markSpellLevel),mark.cells,mark.markTeamId,mark.active,mark.markimpactCell);
      }
      
      private function removeAsLinkEntityEffect() : void
      {
         var entityId:Number = NaN;
         var entity:DisplayObject = null;
         var index:int = 0;
         for each(entityId in this._entitiesFrame.getEntitiesIdsList())
         {
            entity = DofusEntities.getEntity(entityId) as DisplayObject;
            if(entity && entity.filters && entity.filters.length)
            {
               for(index = 0; index < entity.filters.length; index++)
               {
                  if(entity.filters[index] is ColorMatrixFilter)
                  {
                     entity.filters = entity.filters.splice(index,index);
                     break;
                  }
               }
            }
         }
      }
      
      private function highlightAsLinkedEntity(id:Number, isMainEntity:Boolean) : void
      {
         var filter:ColorMatrixFilter = null;
         var entity:IEntity = DofusEntities.getEntity(id);
         if(!entity)
         {
            return;
         }
         var entitySprite:Sprite = entity as Sprite;
         if(entitySprite)
         {
            filter = !!isMainEntity ? this._linkedMainEffect : this._linkedEffect;
            if(entitySprite.filters.length)
            {
               if(entitySprite.filters[0] != filter)
               {
                  entitySprite.filters = [filter];
               }
            }
            else
            {
               entitySprite.filters = [filter];
            }
         }
      }
      
      private function overEntity(id:Number, showRange:Boolean = true, highlightTimelineFighter:Boolean = true, timelineTarget:IRectangle = null) : void
      {
         var entityId:Number = NaN;
         var showInfos:* = false;
         var entityInfo:GameFightFighterInformations = null;
         var inviSelection:Selection = null;
         var pos:int = 0;
         var lastMovPoint:int = 0;
         var reachableCells:FightReachableCellsMaker = null;
         var makerParams:Object = null;
         var effect:GlowFilter = null;
         var fightTurnFrame:FightTurnFrame = null;
         var myTurn:Boolean = false;
         var entitiesIdsList:Vector.<Number> = this._entitiesFrame.getEntitiesIdsList();
         fighterEntityTooltipId = id;
         var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
         if(!entity)
         {
            if(entitiesIdsList.indexOf(fighterEntityTooltipId) == -1)
            {
               _log.warn("Mouse over an unknown entity : " + id);
               return;
            }
            showRange = false;
         }
         var infos:GameFightFighterInformations = this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations;
         if(!infos)
         {
            _log.warn("Mouse over an unknown entity : " + id);
            return;
         }
         var summonerId:Number = infos.stats.summoner;
         if(infos is GameFightEntityInformation)
         {
            summonerId = (infos as GameFightEntityInformation).masterId;
         }
         for each(entityId in entitiesIdsList)
         {
            if(entityId != id)
            {
               entityInfo = this._entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations;
               if(entityInfo && entityInfo.stats.invisibilityState != GameActionFightInvisibilityStateEnum.INVISIBLE && (entityInfo.stats.summoner == id || summonerId == entityId || entityInfo.stats.summoner == summonerId && summonerId || entityInfo is GameFightEntityInformation && (entityInfo as GameFightEntityInformation).masterId == id))
               {
                  this.highlightAsLinkedEntity(entityId,summonerId == entityId);
               }
            }
         }
         this._currentFighterInfo = infos;
         showInfos = true;
         if(PlayedCharacterManager.getInstance().isSpectator && OptionManager.getOptionManager("dofus").getOption("spectatorAutoShowCurrentFighterInfo") == true)
         {
            showInfos = this._battleFrame.currentPlayerId != id;
         }
         if(showInfos && highlightTimelineFighter)
         {
            this._timerFighterInfo.reset();
            this._timerFighterInfo.start();
         }
         if(infos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
         {
            _log.info("Mouse over an invisible entity in timeline");
            inviSelection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
            if(!inviSelection)
            {
               inviSelection = new Selection();
               inviSelection.color = new Color(52326);
               inviSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
               SelectionManager.getInstance().addSelection(inviSelection,this.INVISIBLE_POSITION_SELECTION);
            }
            pos = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityPosition(infos.contextualId);
            if(pos > -1)
            {
               lastMovPoint = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityMovementPoint(infos.contextualId);
               reachableCells = new FightReachableCellsMaker(this._currentFighterInfo,pos,lastMovPoint);
               inviSelection.zone = new Custom(reachableCells.reachableCells);
               SelectionManager.getInstance().update(this.INVISIBLE_POSITION_SELECTION,pos);
            }
            return;
         }
         var fscf:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         if(!fscf)
         {
            makerParams = {"target":timelineTarget};
            this.displayEntityTooltip(id,null,false,-1,makerParams);
         }
         var movementSelection:Selection = SelectionManager.getInstance().getSelection(FightTurnFrame.SELECTION_PATH);
         if(movementSelection)
         {
            movementSelection.remove();
         }
         if(showRange)
         {
            if(Kernel.getWorker().contains(FightBattleFrame) && !Kernel.getWorker().contains(FightSpellCastFrame))
            {
               this._timerMovementRange.reset();
               this._timerMovementRange.start();
            }
         }
         if(this._lastEffectEntity && this._lastEffectEntity.object is Sprite && this._lastEffectEntity.object != entity)
         {
            Sprite(this._lastEffectEntity.object).filters = [];
         }
         var entitySprite:Sprite = entity as Sprite;
         if(entitySprite)
         {
            fightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            myTurn = !!fightTurnFrame ? Boolean(fightTurnFrame.myTurn) : true;
            if((!fscf || FightSpellCastFrame.isCurrentTargetTargetable()) && myTurn)
            {
               effect = this._overEffectOk;
            }
            else
            {
               effect = this._overEffectKo;
            }
            if(entitySprite.filters.length)
            {
               if(entitySprite.filters[0] != effect)
               {
                  entitySprite.filters = [effect];
               }
            }
            else
            {
               entitySprite.filters = [effect];
            }
            this._lastEffectEntity = new WeakReference(entity);
         }
      }
      
      private function tacticModeHandler(forceOpen:Boolean = false) : void
      {
         if(forceOpen && !TacticModeManager.getInstance().tacticModeActivated)
         {
            TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
         }
         else if(TacticModeManager.getInstance().tacticModeActivated)
         {
            TacticModeManager.getInstance().hide();
         }
      }
      
      private function onPropertyChanged(pEvent:PropertyChangeEvent) : void
      {
         var entityId:Number = NaN;
         var showInfos:Boolean = false;
         switch(pEvent.propertyName)
         {
            case "showPermanentTargetsTooltips":
               this._showPermanentTooltips = pEvent.propertyValue as Boolean;
               for each(entityId in this._battleFrame.targetedEntities)
               {
                  if(!this._showPermanentTooltips)
                  {
                     TooltipManager.hide("tooltipOverEntity_" + entityId);
                  }
                  else
                  {
                     this.displayEntityTooltip(entityId);
                  }
               }
               break;
            case "spectatorAutoShowCurrentFighterInfo":
               if(PlayedCharacterManager.getInstance().isSpectator)
               {
                  showInfos = pEvent.propertyValue as Boolean;
                  if(!showInfos)
                  {
                     KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,null);
                  }
                  else
                  {
                     KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._battleFrame.currentPlayerId) as GameFightFighterInformations);
                  }
               }
         }
      }
      
      private function onUiUnloadStarted(pEvent:UiUnloadEvent) : void
      {
         var nameSplit:Array = null;
         var entityId:Number = NaN;
         var entity:AnimatedCharacter = null;
         if(pEvent.name && pEvent.name.indexOf("tooltipOverEntity_") != -1)
         {
            nameSplit = pEvent.name.split("_");
            entityId = nameSplit[nameSplit.length - 1];
            entity = DofusEntities.getEntity(entityId) as AnimatedCharacter;
            if(entity && entity.parent && entity.displayed && this._entitiesFrame.hasIcon(entityId))
            {
               this._entitiesFrame.getIcon(entityId).place(this._entitiesFrame.getIconEntityBounds(entity));
            }
         }
      }
      
      private function onTooltipsOrdered(pEvent:TooltipEvent) : void
      {
         var entityId:Number = NaN;
         var entitiesIds:Vector.<Number> = this.entitiesFrame.getEntitiesIdsList();
         for each(entityId in entitiesIds)
         {
            if(Berilia.getInstance().getUi("tooltip_tooltipOverEntity_" + entityId))
            {
               this._entitiesFrame.updateEntityIconPosition(entityId);
            }
         }
      }
   }
}
