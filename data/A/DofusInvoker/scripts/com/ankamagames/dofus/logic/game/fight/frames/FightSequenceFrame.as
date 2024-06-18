package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
   import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.spells.SpellScript;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.dofus.logic.game.common.managers.MapMovementAdapter;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastSequence;
   import com.ankamagames.dofus.logic.game.common.misc.SpellCastSequence;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.messages.GameActionFightLeaveMessage;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdProtocol;
   import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
   import com.ankamagames.dofus.logic.game.fight.steps.FightActionPointsLossDodgeStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightActionPointsVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightCarryCharacterStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightChangeLookStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightChangeVisibilityStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightCloseCombatStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDeathStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDispellEffectStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDispellSpellStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDispellStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDisplayBuffStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightEnteringStateStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightEntityMovementStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightEntitySlideStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightExchangePositionsStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightFighterStatsListStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightInvisibleTemporarilyDetectedStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightKillStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightLeavingStateStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightLifeVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightLossAnimStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightMarkActivateStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightMarkCellsStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightMarkTriggeredStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightModifyEffectsDurationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightMovementPointsLossDodgeStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightMovementPointsVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightPlaySpellScriptStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightReducedDamagesStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightReflectedDamagesStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightReflectedSpellStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightRefreshFighterStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightShieldPointsVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightSpellCastStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightSpellCooldownVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightSpellImmunityStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightStealingKamasStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightSummonStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightTackledStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightTeleportStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightTemporaryBoostStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightThrowCharacterStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightTurnListStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightUnmarkCellsStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightUpdateStatStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightVanishStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightVisibilityStep;
   import com.ankamagames.dofus.logic.game.fight.steps.IFightStep;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.misc.utils.GameDebugManager;
   import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightActivateGlyphTrapMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightChangeLookMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCloseCombatMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDeathMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellEffectMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellSpellMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellableEffectMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDodgePointLossMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDropCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightExchangePositionsMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibilityMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibleDetectedMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightKillMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifeAndShieldPointsLostMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsGainMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsLostMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightMarkCellsMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightModifyEffectsDurationMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightMultipleSummonMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightPointsVariationMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReduceDamagesMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReflectDamagesMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReflectSpellMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSlideMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellCastMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellCooldownVariationMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellImmunityMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightStealKamaMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSummonMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTackledMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTeleportOnSameMapMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightThrowCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerEffectMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerGlyphTrapMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightUnmarkCellsMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightVanishMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceStartMessage;
   import com.ankamagames.dofus.network.messages.game.character.stats.FighterStatsListMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSynchronizeMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnListMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.RefreshCharacterStatsMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightRefreshFighterMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterRandomStaticPoseMessage;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameContextBasicSpawnInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameContextSummonsInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
   import com.ankamagames.dofus.network.types.game.context.fight.SpawnCharacterInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.SpawnCompanionInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.SpawnMonsterInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.SpawnScaledMonsterInformation;
   import com.ankamagames.dofus.scripts.SpellScriptContext;
   import com.ankamagames.dofus.scripts.SpellScriptManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.dofus.types.sequences.AddGfxInLineStep;
   import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.jerakine.sequencer.ParallelStartSequenceStep;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.WaitAnimationEventStep;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import tools.ActionIdHelper;
   import tools.enumeration.ElementEnum;
   import tools.enumeration.GameActionMarkTypeEnum;
   
   public class FightSequenceFrame implements Frame, ISpellCastSequence
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightSequenceFrame));
      
      private static var _lastCastingSpell:SpellCastSequenceContext;
      
      private static var _currentInstanceId:uint;
      
      public static const FIGHT_SEQUENCERS_CATEGORY:String = "FightSequencer";
       
      
      private var _steps:Vector.<ISequencable>;
      
      public var mustAck:Boolean;
      
      public var ackIdent:int;
      
      private var _sequenceEndCallback:Function;
      
      private var _subSequenceWaitingCount:uint = 0;
      
      private var _scriptInit:Boolean;
      
      private var _sequencer:SerialSequencer;
      
      private var _parent:FightSequenceFrame;
      
      private var _fightBattleFrame:FightBattleFrame;
      
      private var _fightEntitiesFrame:FightEntitiesFrame;
      
      private var _instanceId:uint;
      
      private var _teleportThroughPortal:Boolean;
      
      private var _updateMovementAreaAtSequenceEnd:Boolean;
      
      private var _playSpellScriptStep:FightPlaySpellScriptStep;
      
      private var _tmpSpellCastSequence:SpellCastSequence;
      
      private var _permanentTooltipsCallback:Callback;
      
      private var _forcedCastSequenceContext:SpellCastSequenceContext;
      
      private var _castContexts:Vector.<SpellCastSequenceContext>;
      
      public function FightSequenceFrame(pFightBattleFrame:FightBattleFrame, parent:FightSequenceFrame = null)
      {
         super();
         this._instanceId = _currentInstanceId++;
         this._fightBattleFrame = pFightBattleFrame;
         this._parent = parent;
         this.clearBuffer();
      }
      
      public static function get lastCastingSpell() : SpellCastSequenceContext
      {
         return _lastCastingSpell;
      }
      
      public static function get currentInstanceId() : uint
      {
         return _currentInstanceId;
      }
      
      private static function deleteTooltip(fighterId:Number) : void
      {
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(FightContextFrame.fighterEntityTooltipId == fighterId && FightContextFrame.fighterEntityTooltipId != fightContextFrame.timelineOverEntityId)
         {
            if(fightContextFrame)
            {
               fightContextFrame.outEntity(fighterId);
            }
         }
      }
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function get context() : SpellCastSequenceContext
      {
         if(this._castContexts && this._castContexts.length > 1)
         {
            return this._castContexts[this._castContexts.length - 1];
         }
         return this._forcedCastSequenceContext;
      }
      
      public function get steps() : Vector.<ISequencable>
      {
         return this._steps;
      }
      
      public function get parent() : FightSequenceFrame
      {
         return this._parent;
      }
      
      public function get isWaiting() : Boolean
      {
         return this._subSequenceWaitingCount != 0 || !this._scriptInit;
      }
      
      public function get instanceId() : uint
      {
         return this._instanceId;
      }
      
      public function pushed() : Boolean
      {
         this._scriptInit = false;
         return true;
      }
      
      public function pulled() : Boolean
      {
         this._steps = null;
         this._forcedCastSequenceContext = null;
         this._castContexts = null;
         _lastCastingSpell = null;
         this._sequenceEndCallback = null;
         this._parent = null;
         this._fightBattleFrame = null;
         this._fightEntitiesFrame = null;
         this._sequencer.clear();
         return true;
      }
      
      public function get fightEntitiesFrame() : FightEntitiesFrame
      {
         if(!this._fightEntitiesFrame)
         {
            this._fightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         }
         return this._fightEntitiesFrame;
      }
      
      public function addSubSequence(sequence:ISequencer) : void
      {
         ++this._subSequenceWaitingCount;
         this._steps.push(new ParallelStartSequenceStep([sequence],false));
      }
      
      public function process(msg:Message) : Boolean
      {
         var fightEntitiesFrame:FightEntitiesFrame = null;
         var gfrfmsg:GameFightRefreshFighterMessage = null;
         var gafscmsg:GameActionFightSpellCastMessage = null;
         var forceDetailedLogs:Boolean = false;
         var closeCombatWeaponId:uint = 0;
         var tempSpellCastContext:SpellCastSequenceContext = null;
         var sourceCellId:int = 0;
         var critical:* = false;
         var entities:Dictionary = null;
         var fighter:GameFightFighterInformations = null;
         var playerManager:PlayedCharacterManager = null;
         var isAlly:Boolean = false;
         var playerId:Number = NaN;
         var sourceInfos:GameFightFighterInformations = null;
         var playerInfos:GameFightFighterInformations = null;
         var target:GameFightFighterInformations = null;
         var gmmmsg:GameMapMovementMessage = null;
         var fslmsg:FighterStatsListMessage = null;
         var gafpvmsg:GameActionFightPointsVariationMessage = null;
         var gaflasplmsg:GameActionFightLifeAndShieldPointsLostMessage = null;
         var gaflpgmsg:GameActionFightLifePointsGainMessage = null;
         var gaflplmsg:GameActionFightLifePointsLostMessage = null;
         var gaftosmmsg:GameActionFightTeleportOnSameMapMessage = null;
         var gafepmsg:GameActionFightExchangePositionsMessage = null;
         var gafsmsg:GameActionFightSlideMessage = null;
         var fightContextFrame_gafsmsg:FightContextFrame = null;
         var slideTargetInfos:GameContextActorInformations = null;
         var gafsnmsg:GameActionFightSummonMessage = null;
         var gafmsmsg:GameActionFightMultipleSummonMessage = null;
         var gffinfos:GameFightFighterInformations = null;
         var rcmsg:RefreshCharacterStatsMessage = null;
         var gafmcmsg:GameActionFightMarkCellsMessage = null;
         var gafucmsg:GameActionFightUnmarkCellsMessage = null;
         var gafclmsg:GameActionFightChangeLookMessage = null;
         var gafimsg:GameActionFightInvisibilityMessage = null;
         var inviInfo:GameContextActorInformations = null;
         var gaflmsg:GameActionFightLeaveMessage = null;
         var gafdmsg:GameActionFightDeathMessage = null;
         var gafvmsg:GameActionFightVanishMessage = null;
         var entityInfosv:GameContextActorInformations = null;
         var fightContextFrame_gafvmsg:FightContextFrame = null;
         var gafdiemsg:GameActionFightDispellEffectMessage = null;
         var gafdsmsg:GameActionFightDispellSpellMessage = null;
         var gafdimsg:GameActionFightDispellMessage = null;
         var gafdplmsg:GameActionFightDodgePointLossMessage = null;
         var gafscvmsg:GameActionFightSpellCooldownVariationMessage = null;
         var gafsimsg:GameActionFightSpellImmunityMessage = null;
         var gafkmsg:GameActionFightKillMessage = null;
         var gafredmsg:GameActionFightReduceDamagesMessage = null;
         var gafrfdmsg:GameActionFightReflectDamagesMessage = null;
         var gafrsmsg:GameActionFightReflectSpellMessage = null;
         var gafskmsg:GameActionFightStealKamaMessage = null;
         var gaftmsg:GameActionFightTackledMessage = null;
         var gaftgtmsg:GameActionFightTriggerGlyphTrapMessage = null;
         var gafagtmsg:GameActionFightActivateGlyphTrapMessage = null;
         var gaftbmsg:GameActionFightDispellableEffectMessage = null;
         var gafmedmsg:GameActionFightModifyEffectsDurationMessage = null;
         var gafcchmsg:GameActionFightCarryCharacterMessage = null;
         var gaftcmsg:GameActionFightThrowCharacterMessage = null;
         var throwCellId:uint = 0;
         var fightContextFrame_gaftcmsg:FightContextFrame = null;
         var gafdcmsg:GameActionFightDropCharacterMessage = null;
         var dropCellId:uint = 0;
         var gafidMsg:GameActionFightInvisibleDetectedMessage = null;
         var gftmsg:GameFightTurnListMessage = null;
         var gafccmsg:GameActionFightCloseCombatMessage = null;
         var fighterInfo:GameContextActorInformations = null;
         var castSteps:SpellCastSequence = null;
         var startIndex:uint = 0;
         var stepsChanged:Boolean = false;
         var playSpellScriptStepPosition:uint = 0;
         var lookWithMount:TiphonEntityLook = null;
         var sliced:Vector.<ISequencable> = null;
         var stepIndex:uint = 0;
         var stepSubIndex:uint = 0;
         var spellTargetEntities:Array = null;
         var isSpellKnown:Boolean = false;
         var playerSpellLevel:SpellLevel = null;
         var spellKnown:SpellWrapper = null;
         var spell:Spell = null;
         var castSpellLevel:SpellLevel = null;
         var fighterInfos:GameFightFighterInformations = null;
         var simf:SpellInventoryManagementFrame = null;
         var gcdValue:int = 0;
         var spellCastManager:SpellCastInFightManager = null;
         var spellManager:SpellManager = null;
         var gfsc:GameFightSpellCooldown = null;
         var shape:uint = 0;
         var ei:EffectInstance = null;
         var ts:TiphonSprite = null;
         var targetedCell:GraphicCell = null;
         var cellPos:Point = null;
         var infos:GameFightFighterInformations = null;
         var fightContextFrame_gafcchmsg:FightContextFrame = null;
         var carried:TiphonSprite = null;
         var carriedByCarried:AnimatedCharacter = null;
         fightEntitiesFrame = null;
         switch(true)
         {
            case msg is GameFightRefreshFighterMessage:
               gfrfmsg = msg as GameFightRefreshFighterMessage;
               this.keepInMindToUpdateMovementArea();
               this._steps.push(new FightRefreshFighterStep(gfrfmsg.informations));
               return true;
            case msg is GameActionFightCloseCombatMessage:
            case msg is GameActionFightSpellCastMessage:
               forceDetailedLogs = GameDebugManager.getInstance().detailedFightLog_showEverything;
               if(!this._castContexts)
               {
                  this._castContexts = new Vector.<SpellCastSequenceContext>();
               }
               if(msg is GameActionFightSpellCastMessage)
               {
                  gafscmsg = msg as GameActionFightSpellCastMessage;
                  if(forceDetailedLogs)
                  {
                     gafscmsg.verboseCast = true;
                  }
               }
               else
               {
                  gafccmsg = msg as GameActionFightCloseCombatMessage;
                  closeCombatWeaponId = gafccmsg.weaponGenericId;
                  gafscmsg = new GameActionFightSpellCastMessage();
                  gafscmsg.initGameActionFightSpellCastMessage(gafccmsg.actionId,gafccmsg.sourceId,gafccmsg.targetId,gafccmsg.destinationCellId,gafccmsg.critical,gafccmsg.silentCast,gafccmsg.verboseCast);
                  if(forceDetailedLogs)
                  {
                     gafscmsg.verboseCast = true;
                  }
                  if(gafccmsg.sourceId == PlayedCharacterManager.getInstance().id)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_PLAYER_CLOSE_COMBAT);
                  }
               }
               tempSpellCastContext = new SpellCastSequenceContext();
               tempSpellCastContext.casterId = gafscmsg.sourceId;
               tempSpellCastContext.spellData = Spell.getSpellById(gafscmsg.spellId);
               tempSpellCastContext.spellLevelData = tempSpellCastContext.spellData.getSpellLevel(gafscmsg.spellLevel);
               tempSpellCastContext.isCriticalFail = gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL;
               tempSpellCastContext.isCriticalHit = gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_HIT;
               tempSpellCastContext.isSilentCast = gafscmsg.silentCast;
               tempSpellCastContext.portalIds = gafscmsg.portalsIds;
               tempSpellCastContext.portalMapPoints = MarkedCellsManager.getInstance().getMapPointsFromMarkIds(gafscmsg.portalsIds);
               fightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
               sourceCellId = -1;
               if(fightEntitiesFrame && fightEntitiesFrame.hasEntity(gafscmsg.sourceId))
               {
                  fighterInfo = fightEntitiesFrame.getEntityInfos(gafscmsg.sourceId);
                  if(fighterInfo)
                  {
                     sourceCellId = fighterInfo.disposition.cellId;
                  }
               }
               if(sourceCellId !== -1 && tempSpellCastContext.portalMapPoints.length > 0)
               {
                  sourceCellId = tempSpellCastContext.portalMapPoints[tempSpellCastContext.portalMapPoints.length - 1].cellId;
               }
               if(GameDebugManager.getInstance().buffsDebugActivated)
               {
                  _log.debug("\r[BUFFS DEBUG] Sort " + tempSpellCastContext.spellData.name + " (" + gafscmsg.spellId + ") lancé par " + gafscmsg.sourceId + " sur " + gafscmsg.targetId + " (cellule " + gafscmsg.destinationCellId + ")");
               }
               if(!this._fightBattleFrame.currentPlayerId)
               {
                  BuffManager.getInstance().spellBuffsToIgnore.push(tempSpellCastContext);
               }
               if(gafscmsg.destinationCellId != -1)
               {
                  tempSpellCastContext.targetedCellId = gafscmsg.destinationCellId;
               }
               if(gafscmsg && gafscmsg.actionId == ActionIds.ACTION_FINISH_MOVE)
               {
                  if(!OptionManager.getOptionManager("dofus").getOption("showFinishMoves"))
                  {
                     return true;
                  }
                  castSteps = new SpellCastSequence(tempSpellCastContext);
                  this.pushPlaySpellScriptStep(castSteps,gafscmsg.destinationCellId);
                  startIndex = 0;
                  stepsChanged = true;
                  playSpellScriptStepPosition = 0;
                  while(stepsChanged)
                  {
                     stepsChanged = false;
                     for(stepIndex = 0; stepIndex < this._steps.length; stepIndex++)
                     {
                        if(this._steps[stepIndex] == this._playSpellScriptStep)
                        {
                           playSpellScriptStepPosition = stepIndex;
                        }
                        if(this._tmpSpellCastSequence)
                        {
                           for(stepSubIndex = startIndex; stepSubIndex < this._tmpSpellCastSequence.steps.length; stepSubIndex++)
                           {
                              if(this._steps[stepIndex] == this._tmpSpellCastSequence.steps[stepSubIndex])
                              {
                                 stepsChanged = true;
                                 startIndex = stepSubIndex;
                                 this._steps = this._steps.slice(0,stepIndex).concat(this._steps.slice(stepIndex + 1));
                                 break;
                              }
                           }
                        }
                        if(stepsChanged)
                        {
                           break;
                        }
                     }
                  }
                  lookWithMount = EntitiesLooksManager.getInstance().getRealTiphonEntityLook(gafscmsg.sourceId);
                  sliced = this._steps.slice(playSpellScriptStepPosition + 1);
                  this._steps = this._steps.slice(0,playSpellScriptStepPosition + 1);
                  this.pushStep(new FightChangeLookStep(gafscmsg.sourceId,EntityLookAdapter.fromNetwork(EntityLookAdapter.toNetwork(TiphonUtility.getLookWithoutMount(lookWithMount)))));
                  this._steps = this._steps.concat(castSteps.steps).concat(sliced);
                  this._fightBattleFrame.isFightAboutToEnd = true;
                  return true;
               }
               if(this._forcedCastSequenceContext)
               {
                  if(closeCombatWeaponId != 0)
                  {
                     this.pushStep(new FightCloseCombatStep(gafscmsg.sourceId,closeCombatWeaponId,gafscmsg.critical,gafscmsg.verboseCast));
                  }
                  else if(sourceCellId >= 0)
                  {
                     this.pushStep(new FightSpellCastStep(gafscmsg.sourceId,gafscmsg.destinationCellId,sourceCellId,gafscmsg.spellId,gafscmsg.spellLevel,gafscmsg.critical,gafscmsg.verboseCast));
                  }
                  this._castContexts.push(tempSpellCastContext);
                  if(msg is GameActionFightCloseCombatMessage)
                  {
                     this._forcedCastSequenceContext.weaponId = GameActionFightCloseCombatMessage(msg).weaponGenericId;
                     this.pushPlaySpellScriptStep(this);
                  }
                  else if(!tempSpellCastContext.isCriticalFail)
                  {
                     this._forcedCastSequenceContext = tempSpellCastContext;
                     this.pushPlaySpellScriptStep(this);
                  }
                  return true;
               }
               this._forcedCastSequenceContext = tempSpellCastContext;
               this._tmpSpellCastSequence = new SpellCastSequence(this._forcedCastSequenceContext);
               if(msg is GameActionFightCloseCombatMessage)
               {
                  this._forcedCastSequenceContext.weaponId = GameActionFightCloseCombatMessage(msg).weaponGenericId;
                  this._playSpellScriptStep = this.pushPlaySpellScriptStep(this._tmpSpellCastSequence);
               }
               else if(!this._forcedCastSequenceContext.isCriticalFail)
               {
                  this._playSpellScriptStep = this.pushPlaySpellScriptStep(this._tmpSpellCastSequence);
               }
               this._steps = this._steps.concat(this._tmpSpellCastSequence.steps);
               if(gafscmsg.critical != FightSpellCastCriticalEnum.CRITICAL_FAIL)
               {
                  spellTargetEntities = [];
                  spellTargetEntities.push(gafscmsg.targetId);
                  CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(gafscmsg.sourceId).castSpell(gafscmsg.spellId,gafscmsg.spellLevel,spellTargetEntities);
               }
               critical = gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_HIT;
               entities = FightEntitiesFrame.getCurrentInstance().entities;
               fighter = entities[gafscmsg.sourceId];
               if(closeCombatWeaponId != 0)
               {
                  this.pushStep(new FightCloseCombatStep(gafscmsg.sourceId,closeCombatWeaponId,gafscmsg.critical,gafscmsg.verboseCast));
               }
               else
               {
                  this.pushStep(new FightSpellCastStep(gafscmsg.sourceId,gafscmsg.destinationCellId,sourceCellId,gafscmsg.spellId,gafscmsg.spellLevel,gafscmsg.critical,gafscmsg.verboseCast));
               }
               if(gafscmsg.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.FightSpellCast);
               }
               playerManager = PlayedCharacterManager.getInstance();
               isAlly = false;
               if(entities && entities[playerManager.id] && fighter && (entities[playerManager.id] as GameFightFighterInformations).spawnInfo.teamId == fighter.spawnInfo.teamId)
               {
                  isAlly = true;
               }
               if(isAlly && !this._forcedCastSequenceContext.isCriticalFail)
               {
                  isSpellKnown = false;
                  for each(spellKnown in playerManager.spellsInventory)
                  {
                     if(spellKnown.id == gafscmsg.spellId)
                     {
                        isSpellKnown = true;
                        playerSpellLevel = spellKnown.spellLevelInfos;
                        break;
                     }
                  }
                  spell = Spell.getSpellById(gafscmsg.spellId);
                  castSpellLevel = spell.getSpellLevel(gafscmsg.spellLevel);
                  if(castSpellLevel.globalCooldown)
                  {
                     if(isSpellKnown && gafscmsg.sourceId != playerManager.id)
                     {
                        if(castSpellLevel.globalCooldown == -1)
                        {
                           gcdValue = playerSpellLevel.minCastInterval;
                        }
                        else
                        {
                           gcdValue = castSpellLevel.globalCooldown;
                        }
                        spellCastManager = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(playerManager.id);
                        if(spellCastManager)
                        {
                           spellManager = spellCastManager.getSpellManagerBySpellId(gafscmsg.spellId,true,castSpellLevel.id);
                           if(spellCastManager.currentTurn > 1)
                           {
                              if(spellManager && spellManager.cooldown <= gcdValue)
                              {
                                 this.pushStep(new FightSpellCooldownVariationStep(playerManager.id,0,gafscmsg.spellId,gcdValue,true));
                              }
                           }
                           else
                           {
                              this.pushStep(new FightSpellCooldownVariationStep(playerManager.id,0,gafscmsg.spellId,gcdValue,true));
                           }
                        }
                     }
                     simf = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
                     for each(fighterInfos in entities)
                     {
                        gfsc = new GameFightSpellCooldown();
                        if(fighterInfos is GameFightEntityInformation && gafscmsg.sourceId != fighterInfos.contextualId)
                        {
                           gfsc.initGameFightSpellCooldown(gafscmsg.spellId,castSpellLevel.globalCooldown);
                           simf.addSpellGlobalCoolDownInfo(fighterInfos.contextualId,gfsc);
                        }
                        else if(fighterInfos is GameFightCharacterInformations && gafscmsg.sourceId != fighterInfos.contextualId && fighterInfos.contextualId == playerManager.id)
                        {
                           gfsc.initGameFightSpellCooldown(gafscmsg.spellId,castSpellLevel.globalCooldown);
                           simf.addSpellGlobalCoolDownInfo(fighterInfos.contextualId,gfsc);
                        }
                     }
                  }
               }
               if(!fightEntitiesFrame)
               {
                  return true;
               }
               playerId = PlayedCharacterManager.getInstance().id;
               sourceInfos = fightEntitiesFrame.getEntityInfos(gafscmsg.sourceId) as GameFightFighterInformations;
               playerInfos = fightEntitiesFrame.getEntityInfos(playerId) as GameFightFighterInformations;
               if(critical)
               {
                  if(gafscmsg.sourceId == playerId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_OWNER);
                  }
                  else if(playerInfos && sourceInfos.spawnInfo.teamId == playerInfos.spawnInfo.teamId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ALLIED);
                  }
                  else
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ENEMY);
                  }
               }
               else if(gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
               {
                  if(gafscmsg.sourceId == playerId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_OWNER);
                  }
                  else if(playerInfos && sourceInfos.spawnInfo.teamId == playerInfos.spawnInfo.teamId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ALLIED);
                  }
                  else
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ENEMY);
                  }
               }
               target = fightEntitiesFrame.getEntityInfos(gafscmsg.targetId) as GameFightFighterInformations;
               if(target && target.disposition.cellId == -1)
               {
                  for each(ei in this._forcedCastSequenceContext.spellLevelData.effects)
                  {
                     if(ei.hasOwnProperty("zoneShape"))
                     {
                        shape = ei.zoneShape;
                        break;
                     }
                  }
                  if(shape == SpellShapeEnum.P)
                  {
                     ts = DofusEntities.getEntity(gafscmsg.targetId) as TiphonSprite;
                     if(ts && this._forcedCastSequenceContext && this._forcedCastSequenceContext.targetedCellId >= 0)
                     {
                        targetedCell = InteractiveCellManager.getInstance().getCell(this._forcedCastSequenceContext.targetedCellId);
                        cellPos = targetedCell.parent.localToGlobal(new Point(targetedCell.x + targetedCell.width / 2,targetedCell.y + targetedCell.height / 2));
                        ts.x = cellPos.x;
                        ts.y = cellPos.y;
                     }
                  }
               }
               this._castContexts.push(this._forcedCastSequenceContext);
               return true;
               break;
            case msg is GameMapMovementMessage:
               gmmmsg = msg as GameMapMovementMessage;
               this.keepInMindToUpdateMovementArea();
               this.fighterHasMoved(gmmmsg);
               return true;
            case msg is FighterStatsListMessage:
               fslmsg = msg as FighterStatsListMessage;
               this.pushStep(new FightFighterStatsListStep(fslmsg.stats));
               return true;
            case msg is GameActionFightPointsVariationMessage:
               gafpvmsg = msg as GameActionFightPointsVariationMessage;
               this.pushPointsVariationStep(gafpvmsg.targetId,gafpvmsg.actionId,gafpvmsg.delta);
               return true;
            case msg is GameActionFightLifeAndShieldPointsLostMessage:
               gaflasplmsg = msg as GameActionFightLifeAndShieldPointsLostMessage;
               this.pushStep(new FightShieldPointsVariationStep(gaflasplmsg.targetId,-gaflasplmsg.shieldLoss,gaflasplmsg.elementId));
               this.pushStep(new FightLifeVariationStep(gaflasplmsg.targetId,-gaflasplmsg.loss,-gaflasplmsg.permanentDamages,gaflasplmsg.elementId));
               return true;
            case msg is GameActionFightLifePointsGainMessage:
               gaflpgmsg = msg as GameActionFightLifePointsGainMessage;
               this.pushStep(new FightLifeVariationStep(gaflpgmsg.targetId,gaflpgmsg.delta,0,ElementEnum.ELEMENT_NONE));
               return true;
            case msg is GameActionFightLifePointsLostMessage:
               gaflplmsg = msg as GameActionFightLifePointsLostMessage;
               this.pushStep(new FightLifeVariationStep(gaflplmsg.targetId,-gaflplmsg.loss,-gaflplmsg.permanentDamages,gaflplmsg.elementId));
               return true;
            case msg is GameActionFightTeleportOnSameMapMessage:
               gaftosmmsg = msg as GameActionFightTeleportOnSameMapMessage;
               this.keepInMindToUpdateMovementArea();
               this.fighterHasBeenTeleported(gaftosmmsg);
               return true;
            case msg is GameActionFightExchangePositionsMessage:
               gafepmsg = msg as GameActionFightExchangePositionsMessage;
               this.keepInMindToUpdateMovementArea();
               this.fightersExchangedPositions(gafepmsg);
               return true;
            case msg is GameActionFightSlideMessage:
               gafsmsg = msg as GameActionFightSlideMessage;
               this.keepInMindToUpdateMovementArea();
               fightContextFrame_gafsmsg = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               slideTargetInfos = fightContextFrame_gafsmsg.entitiesFrame.getEntityInfos(gafsmsg.targetId);
               if(slideTargetInfos)
               {
                  fightContextFrame_gafsmsg.saveFighterPosition(gafsmsg.targetId,gafsmsg.endCellId);
                  this.pushSlideStep(gafsmsg.targetId,gafsmsg.startCellId,gafsmsg.endCellId);
               }
               return true;
            case msg is GameActionFightSummonMessage:
               gafsnmsg = msg as GameActionFightSummonMessage;
               this.keepInMindToUpdateMovementArea();
               this.fighterSummonEntity(gafsnmsg);
               return true;
            case msg is GameActionFightMultipleSummonMessage:
               gafmsmsg = msg as GameActionFightMultipleSummonMessage;
               this.keepInMindToUpdateMovementArea();
               gffinfos = new GameFightFighterInformations();
               this.pushStep(new FightUpdateStatStep(gffinfos.contextualId,gffinfos.stats.characteristics.characteristics));
               gffinfos = this.fighterSummonMultipleEntities(gafmsmsg,gffinfos);
               return true;
            case msg is RefreshCharacterStatsMessage:
               rcmsg = msg as RefreshCharacterStatsMessage;
               fightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
               if(fightEntitiesFrame)
               {
                  infos = fightEntitiesFrame.getEntityInfos(rcmsg.fighterId) as GameFightFighterInformations;
                  if(infos)
                  {
                     infos.stats = rcmsg.stats;
                  }
               }
               this.pushStep(new FightUpdateStatStep(rcmsg.fighterId,rcmsg.stats.characteristics.characteristics));
               return true;
            case msg is GameActionFightMarkCellsMessage:
               gafmcmsg = msg as GameActionFightMarkCellsMessage;
               this.cellsHasBeenMarked(gafmcmsg);
               return true;
            case msg is GameActionFightUnmarkCellsMessage:
               gafucmsg = msg as GameActionFightUnmarkCellsMessage;
               this.pushStep(new FightUnmarkCellsStep(gafucmsg.markId));
               return true;
            case msg is GameActionFightChangeLookMessage:
               gafclmsg = msg as GameActionFightChangeLookMessage;
               this.pushStep(new FightChangeLookStep(gafclmsg.targetId,EntityLookAdapter.fromNetwork(gafclmsg.entityLook)));
               return true;
            case msg is GameActionFightInvisibilityMessage:
               gafimsg = msg as GameActionFightInvisibilityMessage;
               this.keepInMindToUpdateMovementArea();
               fightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
               inviInfo = fightEntitiesFrame.getEntityInfos(gafimsg.targetId);
               if(GameDebugManager.getInstance().buffsDebugActivated)
               {
                  _log.debug("[BUFFS DEBUG] Changement de l\'invisibilité de " + gafimsg.targetId + " (cellule " + inviInfo.disposition.cellId + ")" + " nouvel état " + gafimsg.state);
               }
               fightEntitiesFrame.setLastKnownEntityPosition(gafimsg.targetId,inviInfo.disposition.cellId);
               fightEntitiesFrame.setLastKnownEntityMovementPoint(gafimsg.targetId,0,true);
               this.pushStep(new FightChangeVisibilityStep(gafimsg.targetId,gafimsg.state));
               return true;
            case msg is GameActionFightLeaveMessage:
               gaflmsg = msg as GameActionFightLeaveMessage;
               this.keepInMindToUpdateMovementArea();
               this.fighterHasLeftBattle(gaflmsg);
               return true;
            case msg is GameActionFightDeathMessage:
               gafdmsg = msg as GameActionFightDeathMessage;
               this.keepInMindToUpdateMovementArea();
               this.fighterHasBeenKilled(gafdmsg);
               return true;
            case msg is GameActionFightVanishMessage:
               gafvmsg = msg as GameActionFightVanishMessage;
               this.keepInMindToUpdateMovementArea();
               this.pushStep(new FightVanishStep(gafvmsg.targetId,gafvmsg.sourceId));
               entityInfosv = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gafvmsg.targetId);
               if(entityInfosv is GameFightFighterInformations)
               {
                  (entityInfosv as GameFightFighterInformations).spawnInfo.alive = false;
               }
               fightContextFrame_gafvmsg = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(fightContextFrame_gafvmsg)
               {
                  fightContextFrame_gafvmsg.outEntity(gafvmsg.targetId);
               }
               FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(gafvmsg.targetId);
               return true;
            case msg is GameActionFightTriggerEffectMessage:
               return true;
            case msg is GameActionFightDispellEffectMessage:
               gafdiemsg = msg as GameActionFightDispellEffectMessage;
               if(GameDebugManager.getInstance().buffsDebugActivated)
               {
                  _log.debug("[BUFFS DEBUG] Message de retrait du buff " + gafdiemsg.boostUID + " de " + gafdiemsg.targetId);
               }
               this.pushStep(new FightDispellEffectStep(gafdiemsg.targetId,gafdiemsg.boostUID));
               return true;
            case msg is GameActionFightDispellSpellMessage:
               gafdsmsg = msg as GameActionFightDispellSpellMessage;
               if(GameDebugManager.getInstance().buffsDebugActivated)
               {
                  _log.debug("[BUFFS DEBUG] Message de retrait des buffs du sort " + gafdsmsg.spellId + " de " + gafdsmsg.targetId);
               }
               this.pushStep(new FightDispellSpellStep(gafdsmsg.targetId,gafdsmsg.spellId,gafdsmsg.verboseCast));
               return true;
            case msg is GameActionFightDispellMessage:
               gafdimsg = msg as GameActionFightDispellMessage;
               if(GameDebugManager.getInstance().buffsDebugActivated)
               {
                  _log.debug("[BUFFS DEBUG] Message de retrait de tous les buffs de " + gafdimsg.targetId);
               }
               this.pushStep(new FightDispellStep(gafdimsg.targetId));
               return true;
            case msg is GameActionFightDodgePointLossMessage:
               gafdplmsg = msg as GameActionFightDodgePointLossMessage;
               this.pushPointsLossDodgeStep(gafdplmsg.targetId,gafdplmsg.actionId,gafdplmsg.amount);
               return true;
            case msg is GameActionFightSpellCooldownVariationMessage:
               gafscvmsg = msg as GameActionFightSpellCooldownVariationMessage;
               this.pushStep(new FightSpellCooldownVariationStep(gafscvmsg.targetId,gafscvmsg.actionId,gafscvmsg.spellId,gafscvmsg.value));
               return true;
            case msg is GameActionFightSpellImmunityMessage:
               gafsimsg = msg as GameActionFightSpellImmunityMessage;
               this.pushStep(new FightSpellImmunityStep(gafsimsg.targetId));
               return true;
            case msg is GameActionFightKillMessage:
               gafkmsg = msg as GameActionFightKillMessage;
               this.pushStep(new FightKillStep(gafkmsg.targetId,gafkmsg.sourceId));
               return true;
            case msg is GameActionFightReduceDamagesMessage:
               gafredmsg = msg as GameActionFightReduceDamagesMessage;
               this.pushStep(new FightReducedDamagesStep(gafredmsg.targetId,gafredmsg.amount));
               return true;
            case msg is GameActionFightReflectDamagesMessage:
               gafrfdmsg = msg as GameActionFightReflectDamagesMessage;
               this.pushStep(new FightReflectedDamagesStep(gafrfdmsg.sourceId));
               return true;
            case msg is GameActionFightReflectSpellMessage:
               gafrsmsg = msg as GameActionFightReflectSpellMessage;
               this.pushStep(new FightReflectedSpellStep(gafrsmsg.targetId));
               return true;
            case msg is GameActionFightStealKamaMessage:
               gafskmsg = msg as GameActionFightStealKamaMessage;
               this.pushStep(new FightStealingKamasStep(gafskmsg.sourceId,gafskmsg.targetId,gafskmsg.amount));
               return true;
            case msg is GameActionFightTackledMessage:
               gaftmsg = msg as GameActionFightTackledMessage;
               if(gaftmsg.sourceId == PlayedCharacterManager.getInstance().id)
               {
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_PLAYER_TACKLED);
               }
               this.pushStep(new FightTackledStep(gaftmsg.sourceId));
               return true;
            case msg is GameActionFightTriggerGlyphTrapMessage:
               if(this._forcedCastSequenceContext)
               {
                  this._fightBattleFrame.process(new SequenceEndMessage());
                  this._fightBattleFrame.process(new SequenceStartMessage());
                  this._fightBattleFrame.currentSequenceFrame.process(msg);
                  return true;
               }
               gaftgtmsg = msg as GameActionFightTriggerGlyphTrapMessage;
               this.fighterHasTriggeredGlyphOrTrap(gaftgtmsg);
               return true;
               break;
            case msg is GameActionFightActivateGlyphTrapMessage:
               gafagtmsg = msg as GameActionFightActivateGlyphTrapMessage;
               this.pushStep(new FightMarkActivateStep(gafagtmsg.markId,gafagtmsg.active));
               return true;
            case msg is GameActionFightDispellableEffectMessage:
               gaftbmsg = msg as GameActionFightDispellableEffectMessage;
               this.keepInMindToUpdateMovementArea();
               this.fighterHasBeenBuffed(gaftbmsg);
               return true;
            case msg is GameActionFightModifyEffectsDurationMessage:
               gafmedmsg = msg as GameActionFightModifyEffectsDurationMessage;
               this.pushStep(new FightModifyEffectsDurationStep(gafmedmsg.sourceId,gafmedmsg.targetId,gafmedmsg.delta));
               return false;
            case msg is GameActionFightCarryCharacterMessage:
               gafcchmsg = msg as GameActionFightCarryCharacterMessage;
               this.keepInMindToUpdateMovementArea();
               if(gafcchmsg.cellId != -1)
               {
                  fightContextFrame_gafcchmsg = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                  fightContextFrame_gafcchmsg.saveFighterPosition(gafcchmsg.targetId,gafcchmsg.cellId);
                  carried = DofusEntities.getEntity(gafcchmsg.targetId) as TiphonSprite;
                  carriedByCarried = carried.carriedEntity as AnimatedCharacter;
                  while(carriedByCarried)
                  {
                     fightContextFrame_gafcchmsg.saveFighterPosition(carriedByCarried.id,gafcchmsg.cellId);
                     carriedByCarried = carriedByCarried.carriedEntity as AnimatedCharacter;
                  }
                  this.pushStep(new FightCarryCharacterStep(gafcchmsg.sourceId,gafcchmsg.targetId,gafcchmsg.cellId));
                  this._steps.push(new CallbackStep(new Callback(deleteTooltip,gafcchmsg.targetId)));
               }
               return false;
            case msg is GameActionFightThrowCharacterMessage:
               gaftcmsg = msg as GameActionFightThrowCharacterMessage;
               this.keepInMindToUpdateMovementArea();
               throwCellId = this._forcedCastSequenceContext && this._forcedCastSequenceContext.targetedCellId >= 0 ? uint(this._forcedCastSequenceContext.targetedCellId) : uint(gaftcmsg.cellId);
               fightContextFrame_gaftcmsg = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               fightContextFrame_gaftcmsg.saveFighterPosition(gaftcmsg.targetId,throwCellId);
               this.pushThrowCharacterStep(gaftcmsg.sourceId,gaftcmsg.targetId,throwCellId);
               return false;
            case msg is GameActionFightDropCharacterMessage:
               gafdcmsg = msg as GameActionFightDropCharacterMessage;
               this.keepInMindToUpdateMovementArea();
               dropCellId = gafdcmsg.cellId;
               if(dropCellId == -1 && this._forcedCastSequenceContext)
               {
                  dropCellId = this._forcedCastSequenceContext.targetedCellId;
               }
               this.pushThrowCharacterStep(gafdcmsg.sourceId,gafdcmsg.targetId,dropCellId);
               return false;
            case msg is GameActionFightInvisibleDetectedMessage:
               gafidMsg = msg as GameActionFightInvisibleDetectedMessage;
               this.pushStep(new FightInvisibleTemporarilyDetectedStep(DofusEntities.getEntity(gafidMsg.sourceId) as AnimatedCharacter,gafidMsg.cellId));
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(gafidMsg.targetId,gafidMsg.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(gafidMsg.targetId,0);
               return true;
            case msg is GameFightTurnListMessage:
               gftmsg = msg as GameFightTurnListMessage;
               this.pushStep(new FightTurnListStep(gftmsg.ids,gftmsg.deadsIds));
               return true;
            case msg is GameFightSynchronizeMessage:
               this.keepInMindToUpdateMovementArea();
               return false;
            case msg is AbstractGameActionMessage:
               _log.error("Unsupported game action " + msg + " ! This action was discarded.");
               return true;
            default:
               return false;
         }
      }
      
      public function execute(callback:Function = null) : void
      {
         this._sequencer = new SerialSequencer(FIGHT_SEQUENCERS_CATEGORY);
         this._sequencer.addEventListener(SequencerEvent.SEQUENCE_STEP_FINISH,this.onStepEnd);
         if(this._parent)
         {
            _log.info("Process sub sequence");
            this._parent.addSubSequence(this._sequencer);
         }
         else
         {
            _log.info("Execute sequence");
         }
         this.executeBuffer(callback);
      }
      
      private function fighterHasBeenKilled(gafdmsg:GameActionFightDeathMessage) : void
      {
         var actorInfo:GameFightFighterInformations = null;
         var gcai:GameContextActorInformations = null;
         var playerId:Number = NaN;
         var sourceInfos:GameFightFighterInformations = null;
         var targetInfos:GameFightFighterInformations = null;
         var playerInfos:GameFightFighterInformations = null;
         var summonDestroyedWithSummoner:Boolean = false;
         var summonerIsMe:Boolean = false;
         var step:ISequencable = null;
         var summonerInfos:GameFightFighterInformations = null;
         var summonedEntityInfos:GameFightMonsterInformations = null;
         var monster:Monster = null;
         var fighterInfos:GameFightFighterInformations = null;
         var entitiesDictionnary:Dictionary = FightEntitiesFrame.getCurrentInstance().entities;
         for each(gcai in entitiesDictionnary)
         {
            if(gcai is GameFightFighterInformations)
            {
               actorInfo = gcai as GameFightFighterInformations;
               if(actorInfo.spawnInfo.alive && actorInfo.stats.summoner == gafdmsg.targetId)
               {
                  this.pushStep(new FightDeathStep(gcai.contextualId));
               }
            }
         }
         playerId = PlayedCharacterManager.getInstance().id;
         sourceInfos = this.fightEntitiesFrame.getEntityInfos(gafdmsg.sourceId) as GameFightFighterInformations;
         targetInfos = this.fightEntitiesFrame.getEntityInfos(gafdmsg.targetId) as GameFightFighterInformations;
         playerInfos = this.fightEntitiesFrame.getEntityInfos(playerId) as GameFightFighterInformations;
         summonDestroyedWithSummoner = false;
         summonerIsMe = true;
         if(targetInfos.stats.summoned && !(targetInfos is GameFightFighterNamedInformations) && !(targetInfos is GameFightEntityInformation))
         {
            summonerInfos = this.fightEntitiesFrame.getEntityInfos(targetInfos.stats.summoner) as GameFightFighterInformations;
            summonDestroyedWithSummoner = summonerInfos == null || !summonerInfos.spawnInfo.alive;
            summonerIsMe = summonerInfos != null && summonerInfos == playerInfos;
         }
         if(!summonDestroyedWithSummoner && summonerIsMe)
         {
            this.fightEntitiesFrame.addLastKilledAlly(targetInfos);
         }
         if(gafdmsg.targetId != this._fightBattleFrame.currentPlayerId && (this._fightBattleFrame.slaveId == gafdmsg.targetId || this._fightBattleFrame.masterId == gafdmsg.targetId))
         {
            this._fightBattleFrame.prepareNextPlayableCharacter(gafdmsg.targetId);
         }
         var speakingItemManager:SpeakingItemManager = SpeakingItemManager.getInstance();
         if(gafdmsg.targetId == playerId)
         {
            if(gafdmsg.sourceId == gafdmsg.targetId)
            {
               speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_HIMSELF);
            }
            else if(sourceInfos.spawnInfo.teamId != playerInfos.spawnInfo.teamId)
            {
               speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
            }
            else
            {
               speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
            }
         }
         else if(gafdmsg.sourceId == playerId)
         {
            if(targetInfos)
            {
               if(targetInfos.spawnInfo.teamId != playerInfos.spawnInfo.teamId)
               {
                  speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ENEMY);
               }
               else
               {
                  speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ALLY);
               }
            }
         }
         var entityDeathStepAlreadyInBuffer:Boolean = false;
         for each(step in this._steps)
         {
            if(step is FightDeathStep && (step as FightDeathStep).entityId == gafdmsg.targetId)
            {
               entityDeathStepAlreadyInBuffer = true;
            }
         }
         if(!entityDeathStepAlreadyInBuffer)
         {
            this.pushStep(new FightDeathStep(gafdmsg.targetId));
         }
         var entityInfos:GameContextActorInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gafdmsg.targetId);
         var ftf:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         var updatePath:Boolean = ftf && ftf.myTurn && gafdmsg.targetId != playerId && TackleUtil.isTackling(playerInfos,targetInfos,ftf.lastPath);
         var currentPlayedFighterManager:CurrentPlayedFighterManager = CurrentPlayedFighterManager.getInstance();
         if(entityInfos is GameFightMonsterInformations)
         {
            summonedEntityInfos = entityInfos as GameFightMonsterInformations;
            summonedEntityInfos.spawnInfo.alive = false;
            if(currentPlayedFighterManager.checkPlayableEntity(summonedEntityInfos.stats.summoner))
            {
               monster = Monster.getMonsterById(summonedEntityInfos.creatureGenericId);
               if(monster.useSummonSlot)
               {
                  currentPlayedFighterManager.removeSummonedCreature(summonedEntityInfos.stats.summoner);
               }
               if(monster.useBombSlot)
               {
                  currentPlayedFighterManager.removeSummonedBomb(summonedEntityInfos.stats.summoner);
               }
               SpellWrapper.refreshAllPlayerSpellHolder(summonedEntityInfos.stats.summoner);
            }
         }
         else if(entityInfos is GameFightFighterInformations)
         {
            fighterInfos = entityInfos as GameFightFighterInformations;
            fighterInfos.spawnInfo.alive = false;
            if(fighterInfos.stats.summoner != 0)
            {
               if(currentPlayedFighterManager.checkPlayableEntity(fighterInfos.stats.summoner))
               {
                  currentPlayedFighterManager.removeSummonedCreature(fighterInfos.stats.summoner);
                  SpellWrapper.refreshAllPlayerSpellHolder(fighterInfos.stats.summoner);
               }
            }
         }
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(fightContextFrame)
         {
            fightContextFrame.outEntity(gafdmsg.targetId);
         }
         FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(gafdmsg.targetId);
         if(updatePath)
         {
            ftf.updatePath();
         }
      }
      
      private function fighterHasLeftBattle(gaflmsg:GameActionFightLeaveMessage) : void
      {
         var gcaiL:GameContextActorInformations = null;
         var entityInfosL:GameContextActorInformations = null;
         var summonerIdL:Number = NaN;
         var summonedEntityInfosL:GameFightMonsterInformations = null;
         var currentPlayedFighterManager:CurrentPlayedFighterManager = null;
         var monster:Monster = null;
         var fightEntityFrame_gaflmsg:FightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
         var entitiesL:Dictionary = fightEntityFrame_gaflmsg.entities;
         for each(gcaiL in entitiesL)
         {
            if(gcaiL is GameFightFighterInformations)
            {
               summonerIdL = (gcaiL as GameFightFighterInformations).stats.summoner;
               if(summonerIdL == gaflmsg.targetId)
               {
                  this.pushStep(new FightDeathStep(gcaiL.contextualId));
               }
            }
         }
         this.pushStep(new FightDeathStep(gaflmsg.targetId,false));
         entityInfosL = fightEntityFrame_gaflmsg.getEntityInfos(gaflmsg.targetId);
         if(entityInfosL is GameFightMonsterInformations)
         {
            summonedEntityInfosL = entityInfosL as GameFightMonsterInformations;
            currentPlayedFighterManager = CurrentPlayedFighterManager.getInstance();
            if(currentPlayedFighterManager.checkPlayableEntity(summonedEntityInfosL.stats.summoner))
            {
               monster = Monster.getMonsterById(summonedEntityInfosL.creatureGenericId);
               if(monster.useSummonSlot)
               {
                  currentPlayedFighterManager.removeSummonedCreature(summonedEntityInfosL.stats.summoner);
               }
               if(monster.useBombSlot)
               {
                  currentPlayedFighterManager.removeSummonedBomb(summonedEntityInfosL.stats.summoner);
               }
            }
         }
         if(entityInfosL && entityInfosL is GameFightFighterInformations)
         {
            fightEntityFrame_gaflmsg.removeSpecificKilledAlly(entityInfosL as GameFightFighterInformations);
         }
      }
      
      private function cellsHasBeenMarked(gafmcmsg:GameActionFightMarkCellsMessage) : void
      {
         var spellGrade:uint = 0;
         var tmpSpell:Spell = null;
         var spellLevel:SpellLevel = null;
         var effect:EffectInstanceDice = null;
         var spellId:uint = gafmcmsg.mark.markSpellId;
         if(this._forcedCastSequenceContext && this._forcedCastSequenceContext.spellData && this._forcedCastSequenceContext.spellData.id != 1750)
         {
            this._forcedCastSequenceContext.markId = gafmcmsg.mark.markId;
            this._forcedCastSequenceContext.markType = gafmcmsg.mark.markType;
            this._forcedCastSequenceContext.casterId = gafmcmsg.sourceId;
            spellGrade = gafmcmsg.mark.markSpellLevel;
         }
         else
         {
            tmpSpell = Spell.getSpellById(spellId);
            spellLevel = tmpSpell.getSpellLevel(gafmcmsg.mark.markSpellLevel);
            for each(effect in spellLevel.effects)
            {
               if(effect.effectId == ActionIds.ACTION_FIGHT_ADD_TRAP_CASTING_SPELL || effect.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL || effect.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL_ENDTURN)
               {
                  spellId = effect.parameter0 as uint;
                  spellGrade = Spell.getSpellById(spellId).getSpellLevel(effect.parameter1 as uint).grade;
                  break;
               }
            }
         }
         this.pushStep(new FightMarkCellsStep(gafmcmsg.mark.markId,gafmcmsg.mark.markType,gafmcmsg.mark.cells,spellId,spellGrade,gafmcmsg.mark.markTeamId,gafmcmsg.mark.markimpactCell,gafmcmsg.sourceId));
      }
      
      private function fighterSummonMultipleEntities(gafmsmsg:GameActionFightMultipleSummonMessage, gffinfos:GameFightFighterInformations) : GameFightFighterInformations
      {
         var summons:GameContextSummonsInformation = null;
         var sum:GameContextBasicSpawnInformation = null;
         var gffninfos:GameFightFighterNamedInformations = null;
         var gfeinfos:GameFightEntityInformation = null;
         var gfminfos:GameFightMonsterInformations = null;
         var gfsminfos:GameFightMonsterInformations = null;
         for each(summons in gafmsmsg.summons)
         {
            for each(sum in summons.summons)
            {
               switch(true)
               {
                  case summons.spawnInformation is SpawnCharacterInformation:
                     gffninfos = new GameFightFighterNamedInformations();
                     gffninfos.initGameFightFighterNamedInformations(sum.informations.contextualId,sum.informations.disposition,summons.look,sum,summons.wave,summons.stats,null,(summons.spawnInformation as SpawnCharacterInformation).name);
                     gffinfos = gffninfos;
                     break;
                  case summons.spawnInformation is SpawnCompanionInformation:
                     gfeinfos = new GameFightEntityInformation();
                     gfeinfos.initGameFightEntityInformation(sum.informations.contextualId,sum.informations.disposition,summons.look,sum,summons.wave,summons.stats,null,(summons.spawnInformation as SpawnCompanionInformation).modelId,(summons.spawnInformation as SpawnCompanionInformation).level,(summons.spawnInformation as SpawnCompanionInformation).ownerId);
                     gffinfos = gfeinfos;
                     break;
                  case summons.spawnInformation is SpawnMonsterInformation:
                     gfminfos = new GameFightMonsterInformations();
                     gfminfos.initGameFightMonsterInformations(sum.informations.contextualId,sum.informations.disposition,summons.look,sum,summons.wave,summons.stats,null,(summons.spawnInformation as SpawnMonsterInformation).creatureGenericId,(summons.spawnInformation as SpawnMonsterInformation).creatureGrade);
                     gffinfos = gfminfos;
                     break;
                  case summons.spawnInformation is SpawnScaledMonsterInformation:
                     gfsminfos = new GameFightMonsterInformations();
                     gfsminfos.initGameFightMonsterInformations(sum.informations.contextualId,sum.informations.disposition,summons.look,sum,summons.wave,summons.stats,null,(summons.spawnInformation as SpawnScaledMonsterInformation).creatureGenericId,0,(summons.spawnInformation as SpawnScaledMonsterInformation).creatureLevel);
                     gffinfos = gfsminfos;
                     break;
                  default:
                     gffinfos = new GameFightFighterInformations();
                     gffinfos.initGameFightFighterInformations(sum.informations.contextualId,sum.informations.disposition,summons.look,sum,summons.wave,summons.stats);
                     break;
               }
               this.summonEntity(gffinfos,gafmsmsg.sourceId,gafmsmsg.actionId);
            }
         }
         return gffinfos;
      }
      
      private function fighterSummonEntity(gafsnmsg:GameActionFightSummonMessage) : void
      {
         var summon:GameFightFighterInformations = null;
         var fightEntities:Dictionary = null;
         var fighterId:* = undefined;
         var gfsfrsmsg:GameFightShowFighterRandomStaticPoseMessage = null;
         var illusionCreature:Sprite = null;
         var infos:GameFightFighterInformations = null;
         for each(summon in gafsnmsg.summons)
         {
            if(gafsnmsg.actionId == ActionIds.ACTION_CHARACTER_ADD_ILLUSION_RANDOM || gafsnmsg.actionId == ActionIds.ACTION_CHARACTER_ADD_ILLUSION_MIRROR)
            {
               fightEntities = this.fightEntitiesFrame.entities;
               for(fighterId in fightEntities)
               {
                  infos = this.fightEntitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations;
                  if(!this.fightEntitiesFrame.entityIsIllusion(fighterId) && infos.hasOwnProperty("name") && summon.hasOwnProperty("name") && infos["name"] == summon["name"])
                  {
                     summon.stats.summoner = infos.contextualId;
                     break;
                  }
               }
               gfsfrsmsg = new GameFightShowFighterRandomStaticPoseMessage();
               gfsfrsmsg.initGameFightShowFighterRandomStaticPoseMessage(summon);
               Kernel.getWorker().getFrame(FightEntitiesFrame).process(gfsfrsmsg);
               illusionCreature = DofusEntities.getEntity(summon.contextualId) as Sprite;
               if(illusionCreature)
               {
                  illusionCreature.visible = false;
               }
               this.pushStep(new FightVisibilityStep(summon.contextualId,true));
            }
            else
            {
               this.summonEntity(summon,gafsnmsg.sourceId,gafsnmsg.actionId);
            }
         }
      }
      
      private function fightersExchangedPositions(gafepmsg:GameActionFightExchangePositionsMessage) : void
      {
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!this.isSpellTeleportingToPreviousPosition())
         {
            fightContextFrame.saveFighterPosition(gafepmsg.sourceId,gafepmsg.targetCellId);
         }
         else
         {
            fightContextFrame.deleteFighterPreviousPosition(gafepmsg.sourceId);
         }
         fightContextFrame.saveFighterPosition(gafepmsg.targetId,gafepmsg.targetCellId);
         this._steps.push(new CallbackStep(new Callback(deleteTooltip,gafepmsg.targetId)));
         this._steps.push(new CallbackStep(new Callback(deleteTooltip,gafepmsg.targetCellId)));
         this.pushStep(new FightExchangePositionsStep(gafepmsg.sourceId,gafepmsg.casterCellId,gafepmsg.targetId,gafepmsg.targetCellId));
      }
      
      private function fighterHasBeenTeleported(gaftosmmsg:GameActionFightTeleportOnSameMapMessage) : void
      {
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!this.isSpellTeleportingToPreviousPosition())
         {
            if(!this._teleportThroughPortal)
            {
               fightContextFrame.saveFighterPosition(gaftosmmsg.targetId,gaftosmmsg.cellId);
            }
            else
            {
               fightContextFrame.saveFighterPosition(gaftosmmsg.targetId,gaftosmmsg.cellId);
            }
         }
         else if(fightContextFrame.getFighterPreviousPosition(gaftosmmsg.targetId) == gaftosmmsg.cellId)
         {
            fightContextFrame.deleteFighterPreviousPosition(gaftosmmsg.targetId);
         }
         this.pushTeleportStep(gaftosmmsg.targetId,gaftosmmsg.cellId);
         this._teleportThroughPortal = false;
      }
      
      private function fighterHasMoved(gmmmsg:GameMapMovementMessage) : void
      {
         var i:int = 0;
         var carriedEntity:AnimatedCharacter = null;
         if(gmmmsg.actorId == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerFightMove);
         }
         var movementPath:MovementPath = MapMovementAdapter.getClientMovement(gmmmsg.keyMovements);
         var movementPathCells:Vector.<uint> = movementPath.getCells();
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var nbCells:int = movementPathCells.length;
         var movingEntity:TiphonSprite = DofusEntities.getEntity(gmmmsg.actorId) as TiphonSprite;
         for(i = 1; i < nbCells; i++)
         {
            fightContextFrame.saveFighterPosition(gmmmsg.actorId,movementPathCells[i]);
            carriedEntity = !!movingEntity ? movingEntity.carriedEntity as AnimatedCharacter : null;
            while(carriedEntity)
            {
               fightContextFrame.saveFighterPosition(carriedEntity.id,movementPathCells[i]);
               carriedEntity = carriedEntity.carriedEntity as AnimatedCharacter;
            }
         }
         var fscf:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         if(fscf)
         {
            fscf.entityMovement(gmmmsg.actorId);
         }
         this._steps.push(new CallbackStep(new Callback(deleteTooltip,gmmmsg.actorId)));
         this.pushStep(new FightEntityMovementStep(gmmmsg.actorId,movementPath));
      }
      
      private function fighterHasTriggeredGlyphOrTrap(gaftgtmsg:GameActionFightTriggerGlyphTrapMessage) : void
      {
         var triggeredSpellId:int = 0;
         var eid:EffectInstanceDice = null;
         var context:SpellScriptContext = null;
         this.pushStep(new FightMarkTriggeredStep(gaftgtmsg.triggeringCharacterId,gaftgtmsg.sourceId,gaftgtmsg.markId));
         this._forcedCastSequenceContext = new SpellCastSequenceContext();
         this._forcedCastSequenceContext.casterId = gaftgtmsg.sourceId;
         var triggeringCharacterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gaftgtmsg.triggeringCharacterId) as GameFightFighterInformations;
         var triggeredCellId:int = !!triggeringCharacterInfos ? int(triggeringCharacterInfos.disposition.cellId) : -1;
         var mark:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(gaftgtmsg.markId);
         if(triggeredCellId != -1)
         {
            if(mark)
            {
               for each(eid in mark.associatedSpellLevel.effects)
               {
                  if(mark.markType == GameActionMarkTypeEnum.GLYPH && eid.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL || mark.markType == GameActionMarkTypeEnum.TRAP && eid.effectId == ActionIds.ACTION_FIGHT_ADD_TRAP_CASTING_SPELL)
                  {
                     triggeredSpellId = eid.parameter0 as int;
                     break;
                  }
               }
               if(triggeredSpellId)
               {
                  this._forcedCastSequenceContext.spellData = Spell.getSpellById(triggeredSpellId);
                  this._forcedCastSequenceContext.spellLevelData = this._forcedCastSequenceContext.spellData.getSpellLevel(mark.associatedSpellLevel.grade);
                  this._forcedCastSequenceContext.targetedCellId = gaftgtmsg.markImpactCell;
                  context = new SpellScriptContext();
                  context.scriptId = SpellScript.INVALID_ID;
                  if(mark.markType == GameActionMarkTypeEnum.GLYPH)
                  {
                     this._forcedCastSequenceContext.defaultTargetGfxId = 1016;
                     context.scriptId = SpellScript.FECA_GLYPH_SCRIPT_ID;
                  }
                  else if(mark.markType == GameActionMarkTypeEnum.TRAP)
                  {
                     this._forcedCastSequenceContext.defaultTargetGfxId = 1017;
                     context.scriptId = SpellScript.SRAM_TRAP_SCRIPT_ID;
                  }
                  if(context.scriptId != SpellScript.INVALID_ID)
                  {
                     this.pushPlaySpellScriptStep(this,gaftgtmsg.markImpactCell);
                  }
               }
            }
         }
         if(mark && mark.markType == GameActionMarkTypeEnum.PORTAL)
         {
            this._teleportThroughPortal = true;
         }
      }
      
      private function fighterHasBeenBuffed(gaftbmsg:GameActionFightDispellableEffectMessage) : void
      {
         var myCastingSpell:SpellCastSequenceContext = null;
         var castedSpell:SpellCastSequenceContext = null;
         var e:Effect = null;
         var description:String = null;
         var sb:StateBuff = null;
         var step:AbstractSequencable = null;
         var actionId:int = 0;
         var targetBuffs:Array = null;
         var oldBuff:BasicBuff = null;
         if(GameDebugManager.getInstance().buffsDebugActivated)
         {
            e = Effect.getEffectById(gaftbmsg.actionId);
            description = "";
            if(e != null)
            {
               description = e.description;
            }
            _log.debug("\r[BUFFS DEBUG] Message de nouveau buff \'" + description + "\' (" + gaftbmsg.actionId + ") lancé par " + gaftbmsg.sourceId + " sur " + gaftbmsg.effect.targetId + " (uid " + gaftbmsg.effect.uid + ", sort " + gaftbmsg.effect.spellId + ", durée " + gaftbmsg.effect.turnDuration + ", desenvoutable " + gaftbmsg.effect.dispelable + ", buff parent " + gaftbmsg.effect.parentBoostUid + ")");
         }
         for each(castedSpell in this._castContexts)
         {
            if(castedSpell.spellData.id == gaftbmsg.effect.spellId && castedSpell.casterId == gaftbmsg.sourceId)
            {
               myCastingSpell = castedSpell;
               break;
            }
         }
         if(!myCastingSpell)
         {
            if(gaftbmsg.actionId == ActionIdProtocol.ACTION_CHARACTER_UPDATE_BOOST)
            {
               myCastingSpell = new SpellCastSequenceContext(false);
            }
            else
            {
               myCastingSpell = new SpellCastSequenceContext(this._forcedCastSequenceContext == null);
            }
            if(this._forcedCastSequenceContext)
            {
               myCastingSpell.id = this._forcedCastSequenceContext.id;
               if(this._forcedCastSequenceContext.spellData && this._forcedCastSequenceContext.spellData.id == gaftbmsg.effect.spellId)
               {
                  myCastingSpell.spellLevelData = this._forcedCastSequenceContext.spellLevelData;
               }
            }
            myCastingSpell.spellData = Spell.getSpellById(gaftbmsg.effect.spellId);
            myCastingSpell.casterId = gaftbmsg.sourceId;
         }
         var buffEffect:AbstractFightDispellableEffect = gaftbmsg.effect;
         var buff:BasicBuff = BuffManager.makeBuffFromEffect(buffEffect,myCastingSpell,gaftbmsg.actionId);
         var targetId:Number = gaftbmsg.effect.targetId;
         if(buff is StateBuff)
         {
            sb = buff as StateBuff;
            if(sb.actionId == ActionIds.ACTION_FIGHT_DISABLE_STATE)
            {
               step = new FightLeavingStateStep(sb.targetId,sb.stateId,buff);
            }
            else
            {
               step = new FightEnteringStateStep(sb.targetId,sb.stateId,sb.effect.durationString,buff);
            }
            if(myCastingSpell != null)
            {
               step.castingSpellId = myCastingSpell.id;
            }
            this._steps.push(step);
         }
         if(buff is StatBuff)
         {
            (buff as StatBuff).isRecent = true;
         }
         if(buffEffect is FightTemporaryBoostEffect)
         {
            actionId = gaftbmsg.actionId;
            if(actionId != ActionIds.ACTION_CHARACTER_MAKE_INVISIBLE && actionId != ActionIdProtocol.ACTION_CHARACTER_UPDATE_BOOST && actionId != ActionIds.ACTION_CHARACTER_CHANGE_LOOK && actionId != ActionIds.ACTION_CHARACTER_CHANGE_COLOR && actionId != ActionIds.ACTION_CHARACTER_ADD_APPEARANCE && actionId != ActionIds.ACTION_FIGHT_SET_STATE)
            {
               if(GameDebugManager.getInstance().detailedFightLog_showEverything)
               {
                  buff.effect.visibleInFightLog = true;
               }
               if(GameDebugManager.getInstance().detailedFightLog_showBuffsInUi)
               {
                  buff.effect.visibleInBuffUi = true;
               }
               if(actionId === ActionIds.ACTION_SET_SPELL_RANGE_MAX || actionId === ActionIds.ACTION_SET_SPELL_RANGE_MIN)
               {
                  targetBuffs = BuffManager.getInstance().getAllBuff(gaftbmsg.effect.targetId);
                  if(targetBuffs !== null)
                  {
                     for each(oldBuff in targetBuffs)
                     {
                        if(oldBuff.effect.effectUid === buff.effect.effectUid)
                        {
                           this.pushStep(new FightDispellEffectStep(targetId,oldBuff.id));
                        }
                     }
                  }
               }
               this.pushStep(new FightTemporaryBoostStep(targetId,buff.effect.description,buff.effect.duration,buff.effect.durationString,buff.effect.visibleInFightLog,buff));
            }
            if(actionId == ActionIds.ACTION_CHARACTER_BOOST_SHIELD)
            {
               this.pushStep(new FightShieldPointsVariationStep(targetId,(buff as StatBuff).delta,ElementEnum.ELEMENT_NONE));
            }
         }
         this.pushStep(new FightDisplayBuffStep(buff));
      }
      
      private function executeBuffer(callback:Function) : void
      {
         var step:ISequencable = null;
         var allowHitAnim:Boolean = false;
         var allowSpellEffects:Boolean = false;
         var startStep:Array = null;
         var endStep:Array = null;
         var removed:Boolean = false;
         var entityAttaqueAnimWait:Dictionary = null;
         var lifeLoseSum:Dictionary = null;
         var lifeLoseLastStep:Dictionary = null;
         var shieldLoseSum:Dictionary = null;
         var shieldLoseLastStep:Dictionary = null;
         var deathNumber:int = 0;
         var i:int = 0;
         var b:* = undefined;
         var index:* = undefined;
         var waitStep:WaitAnimationEventStep = null;
         var animStep:PlayAnimationStep = null;
         var deathStep:FightDeathStep = null;
         var deadEntityIndex:int = 0;
         var fapvs:FightActionPointsVariationStep = null;
         var fspvs:FightShieldPointsVariationStep = null;
         var fspvsTarget:IEntity = null;
         var flvs:FightLifeVariationStep = null;
         var flvsTarget:IEntity = null;
         var idx:int = 0;
         var idx2:int = 0;
         var loseLifeTarget:* = undefined;
         var j:uint = 0;
         var cleanedBuffer:Array = [];
         var deathStepRef:Dictionary = new Dictionary(true);
         var hitStep:Vector.<TiphonSprite> = new Vector.<TiphonSprite>();
         var loseLifeStep:Dictionary = new Dictionary(true);
         var waitHitEnd:Boolean = false;
         for each(step in this._steps)
         {
            if(step is FightMarkTriggeredStep)
            {
               waitHitEnd = true;
            }
         }
         allowHitAnim = OptionManager.getOptionManager("dofus").getOption("allowHitAnim");
         allowSpellEffects = OptionManager.getOptionManager("dofus").getOption("allowSpellEffects");
         startStep = [];
         endStep = [];
         entityAttaqueAnimWait = new Dictionary();
         lifeLoseSum = new Dictionary(true);
         lifeLoseLastStep = new Dictionary(true);
         shieldLoseSum = new Dictionary(true);
         shieldLoseLastStep = new Dictionary(true);
         deathNumber = 0;
         for(i = this._steps.length; --i >= 0; )
         {
            if(removed && step)
            {
               step.clear();
            }
            removed = true;
            step = this._steps[i];
            switch(true)
            {
               case step is PlayAnimationStep:
                  animStep = step as PlayAnimationStep;
                  if(animStep.animation.indexOf(AnimationEnum.ANIM_HIT) != -1)
                  {
                     if(!allowHitAnim)
                     {
                        continue;
                     }
                     animStep.waitEvent = waitHitEnd;
                     if(animStep.target == null || deathStepRef[EntitiesManager.getInstance().getEntityID(animStep.target as IEntity)] || hitStep.indexOf(animStep.target))
                     {
                        continue;
                     }
                     if(animStep.animation != AnimationEnum.ANIM_HIT && animStep.animation != AnimationEnum.ANIM_HIT_CARRYING && !animStep.target.hasAnimation(animStep.animation,1))
                     {
                        animStep.animation = AnimationEnum.ANIM_HIT;
                     }
                     hitStep.push(animStep.target);
                  }
                  if(this._forcedCastSequenceContext && this._forcedCastSequenceContext.casterId < 0)
                  {
                     if(entityAttaqueAnimWait[animStep.target])
                     {
                        cleanedBuffer.unshift(entityAttaqueAnimWait[animStep.target]);
                        delete entityAttaqueAnimWait[animStep.target];
                     }
                     if(animStep.animation.indexOf(AnimationEnum.ANIM_ATTAQUE_BASE) != -1)
                     {
                        entityAttaqueAnimWait[animStep.target] = new WaitAnimationEventStep(animStep);
                     }
                  }
                  break;
               case step is FightDeathStep:
                  deathStep = step as FightDeathStep;
                  deathStepRef[deathStep.entityId] = true;
                  deadEntityIndex = this._fightBattleFrame.targetedEntities.indexOf(deathStep.entityId);
                  if(deadEntityIndex != -1)
                  {
                     this._fightBattleFrame.targetedEntities.splice(deadEntityIndex,1);
                     TooltipManager.hide("tooltipOverEntity_" + deathStep.entityId);
                  }
                  deathNumber++;
                  break;
               case step is FightActionPointsVariationStep:
                  fapvs = step as FightActionPointsVariationStep;
                  if(!fapvs.voluntarlyUsed)
                  {
                     break;
                  }
                  startStep.push(fapvs);
                  removed = false;
                  continue;
               case step is FightShieldPointsVariationStep:
                  fspvs = step as FightShieldPointsVariationStep;
                  fspvsTarget = fspvs.target;
                  if(fspvsTarget == null)
                  {
                     break;
                  }
                  if(fspvs.value < 0)
                  {
                     fspvs.virtual = true;
                     if(shieldLoseSum[fspvsTarget] == null)
                     {
                        shieldLoseSum[fspvsTarget] = 0;
                     }
                     shieldLoseSum[fspvsTarget] += fspvs.value;
                     shieldLoseLastStep[fspvsTarget] = fspvs;
                  }
                  break;
               case step is FightLifeVariationStep:
                  flvs = step as FightLifeVariationStep;
                  flvsTarget = flvs.target;
                  if(flvsTarget == null)
                  {
                     break;
                  }
                  if(flvs.delta < 0)
                  {
                     loseLifeStep[flvsTarget] = flvs;
                  }
                  if(lifeLoseSum[flvsTarget] == null)
                  {
                     lifeLoseSum[flvsTarget] = 0;
                  }
                  lifeLoseSum[flvsTarget] += flvs.delta;
                  lifeLoseLastStep[flvsTarget] = flvs;
                  break;
               case step is AddGfxEntityStep:
               case step is AddGfxInLineStep:
               case step is AddGlyphGfxStep:
               case step is ParableGfxMovementStep:
               case step is AddWorldEntityStep:
                  if(!(!allowSpellEffects && PlayedCharacterManager.getInstance().isFighting))
                  {
                     break;
                  }
                  continue;
            }
            removed = false;
            cleanedBuffer.unshift(step);
         }
         this._fightBattleFrame.deathPlayingNumber = deathNumber;
         for each(b in cleanedBuffer)
         {
            if(b is FightLifeVariationStep && lifeLoseSum[b.target] == 0 && shieldLoseSum[b.target] != null)
            {
               b.skipTextEvent = true;
            }
         }
         for(index in lifeLoseSum)
         {
            if(index != "null" && lifeLoseSum[index] != 0)
            {
               idx = cleanedBuffer.indexOf(lifeLoseLastStep[index]);
               cleanedBuffer.splice(idx,0,new FightLossAnimStep(index,lifeLoseSum[index],FightLifeVariationStep.COLOR));
            }
            lifeLoseLastStep[index] = -1;
            lifeLoseSum[index] = 0;
         }
         for(index in shieldLoseSum)
         {
            if(index != "null" && shieldLoseSum[index] != 0)
            {
               idx2 = cleanedBuffer.indexOf(shieldLoseLastStep[index]);
               cleanedBuffer.splice(idx2,0,new FightLossAnimStep(index,shieldLoseSum[index],FightShieldPointsVariationStep.COLOR));
            }
            shieldLoseLastStep[index] = -1;
            shieldLoseSum[index] = 0;
         }
         for each(waitStep in entityAttaqueAnimWait)
         {
            endStep.push(waitStep);
         }
         if(allowHitAnim)
         {
            for(loseLifeTarget in loseLifeStep)
            {
               if(hitStep.indexOf(loseLifeTarget) == -1)
               {
                  for(j = 0; j < cleanedBuffer.length; j++)
                  {
                     if(cleanedBuffer[j] == loseLifeStep[loseLifeTarget])
                     {
                        cleanedBuffer.splice(j,0,new PlayAnimationStep(loseLifeTarget as TiphonSprite,AnimationEnum.ANIM_HIT,true,false));
                        break;
                     }
                  }
               }
            }
         }
         cleanedBuffer = startStep.concat(cleanedBuffer).concat(endStep);
         for each(step in cleanedBuffer)
         {
            this._sequencer.addStep(step);
         }
         this.clearBuffer();
         if(callback != null && !this._parent)
         {
            this._sequenceEndCallback = callback;
            this._permanentTooltipsCallback = new Callback(this.showPermanentTooltips,cleanedBuffer);
            this._sequencer.addEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         }
         _lastCastingSpell = this._forcedCastSequenceContext;
         this._scriptInit = true;
         if(!this._parent)
         {
            if(!this._subSequenceWaitingCount)
            {
               this._sequencer.start();
            }
            else
            {
               _log.warn("Waiting sub sequence init end (" + this._subSequenceWaitingCount + " seq)");
            }
         }
         else
         {
            if(callback != null)
            {
               callback();
            }
            this._parent.subSequenceInitDone();
         }
      }
      
      private function onSequenceEnd(e:SequencerEvent) : void
      {
         this._sequencer.removeEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         if(this._permanentTooltipsCallback)
         {
            this._permanentTooltipsCallback.exec();
         }
         this._sequenceEndCallback();
         this.updateMovementArea();
      }
      
      private function onStepEnd(e:SequencerEvent, isEnd:Boolean = true) : void
      {
         this._sequencer.removeEventListener(SequencerEvent.SEQUENCE_STEP_FINISH,this.onStepEnd);
      }
      
      private function subSequenceInitDone() : void
      {
         --this._subSequenceWaitingCount;
         if(!this.isWaiting && this._sequencer && !this._sequencer.running)
         {
            _log.warn("Sub sequence init end -- Run main sequence");
            this._sequencer.start();
         }
      }
      
      private function pushTeleportStep(fighterId:Number, destinationCell:int) : void
      {
         var step:FightTeleportStep = null;
         this._steps.push(new CallbackStep(new Callback(deleteTooltip,fighterId)));
         if(destinationCell != -1)
         {
            step = new FightTeleportStep(fighterId,MapPoint.fromCellId(destinationCell));
            if(this.context != null)
            {
               step.castingSpellId = this.context.id;
            }
            this._steps.push(step);
         }
      }
      
      private function pushSlideStep(fighterId:Number, startCell:int, endCell:int) : void
      {
         if(startCell < 0 || endCell < 0)
         {
            return;
         }
         this._steps.push(new CallbackStep(new Callback(deleteTooltip,fighterId)));
         var step:FightEntitySlideStep = new FightEntitySlideStep(fighterId,MapPoint.fromCellId(startCell),MapPoint.fromCellId(endCell));
         if(this.context != null)
         {
            step.castingSpellId = this.context.id;
         }
         this._steps.push(step);
      }
      
      private function pushPointsVariationStep(fighterId:Number, actionId:uint, delta:int) : void
      {
         var step:IFightStep = null;
         switch(actionId)
         {
            case ActionIdProtocol.ACTION_CHARACTER_ACTION_POINTS_USE:
               step = new FightActionPointsVariationStep(fighterId,delta,true);
               break;
            case ActionIds.ACTION_CHARACTER_ACTION_POINTS_LOST:
            case ActionIds.ACTION_CHARACTER_ACTION_POINTS_WIN:
               step = new FightActionPointsVariationStep(fighterId,delta,false);
               break;
            case ActionIdProtocol.ACTION_CHARACTER_MOVEMENT_POINTS_USE:
               step = new FightMovementPointsVariationStep(fighterId,delta,true);
               break;
            case ActionIds.ACTION_CHARACTER_MOVEMENT_POINTS_LOST:
            case ActionIds.ACTION_CHARACTER_MOVEMENT_POINTS_WIN:
               step = new FightMovementPointsVariationStep(fighterId,delta,false);
               break;
            default:
               _log.warn("Points variation with unsupported action (" + actionId + "), skipping.");
               return;
         }
         if(this.context != null)
         {
            step.castingSpellId = this.context.id;
         }
         this._steps.push(step);
      }
      
      private function pushStep(step:AbstractSequencable) : void
      {
         if(this.context != null)
         {
            step.castingSpellId = this.context.id;
         }
         this._steps.push(step);
      }
      
      private function pushPointsLossDodgeStep(fighterId:Number, actionId:uint, amount:int) : void
      {
         var step:IFightStep = null;
         switch(actionId)
         {
            case ActionIdProtocol.ACTION_FIGHT_SPELL_DODGED_PA:
               step = new FightActionPointsLossDodgeStep(fighterId,amount);
               break;
            case ActionIdProtocol.ACTION_FIGHT_SPELL_DODGED_PM:
               step = new FightMovementPointsLossDodgeStep(fighterId,amount);
               break;
            default:
               _log.warn("Points dodge with unsupported action (" + actionId + "), skipping.");
               return;
         }
         if(this.context != null)
         {
            step.castingSpellId = this.context.id;
         }
         this._steps.push(step);
      }
      
      private function pushPlaySpellScriptStep(castSequence:ISpellCastSequence, specificTargetedCellId:int = -1) : FightPlaySpellScriptStep
      {
         var scriptTypes:Vector.<SpellScriptContext> = SpellScriptManager.getInstance().resolveScriptUsageFromCastContext(castSequence.context,specificTargetedCellId);
         var step:FightPlaySpellScriptStep = new FightPlaySpellScriptStep(scriptTypes,castSequence,castSequence.context.spellLevelData.grade);
         if(this.context !== null)
         {
            step.castingSpellId = this.context.id;
         }
         this._steps.push(step);
         return step;
      }
      
      private function pushThrowCharacterStep(fighterId:Number, carriedId:Number, cellId:int) : void
      {
         var step:FightThrowCharacterStep = new FightThrowCharacterStep(fighterId,carriedId,cellId);
         if(this.context != null)
         {
            step.castingSpellId = this.context.id;
            step.portals = this.context.portalMapPoints;
            step.portalIds = this.context.portalIds;
         }
         this._steps.push(step);
      }
      
      private function clearBuffer() : void
      {
         this._steps = new Vector.<ISequencable>(0,false);
      }
      
      private function keepInMindToUpdateMovementArea() : void
      {
         if(this._updateMovementAreaAtSequenceEnd)
         {
            return;
         }
         var fightTurnFrame:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if(fightTurnFrame && fightTurnFrame.myTurn)
         {
            this._updateMovementAreaAtSequenceEnd = true;
         }
      }
      
      private function updateMovementArea() : void
      {
         if(!this._updateMovementAreaAtSequenceEnd)
         {
            return;
         }
         var fightTurnFrame:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if(fightTurnFrame && fightTurnFrame.myTurn)
         {
            fightTurnFrame.drawMovementArea();
            this._updateMovementAreaAtSequenceEnd = false;
         }
      }
      
      private function showTargetTooltip(pEntityId:Number) : void
      {
         var fcf:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var entityInfos:GameFightFighterInformations = this.fightEntitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations;
         if(entityInfos.spawnInfo.alive && this._forcedCastSequenceContext && (this._forcedCastSequenceContext.casterId == PlayedCharacterManager.getInstance().id || fcf.battleFrame.playingSlaveEntity) && pEntityId != this.context.casterId && this._fightBattleFrame.targetedEntities.indexOf(pEntityId) == -1 && fcf.hiddenEntites.indexOf(pEntityId) == -1)
         {
            this._fightBattleFrame.targetedEntities.push(pEntityId);
            if(OptionManager.getOptionManager("dofus").getOption("showPermanentTargetsTooltips") == true)
            {
               fcf.displayEntityTooltip(pEntityId);
            }
         }
      }
      
      private function isSpellTeleportingToPreviousPosition() : Boolean
      {
         var spellEffect:EffectInstanceDice = null;
         if(this.context && this.context.spellLevelData)
         {
            for each(spellEffect in this.context.spellLevelData.effects)
            {
               if(spellEffect.effectId == ActionIds.ACTION_FIGHT_ROLLBACK_PREVIOUS_POSITION)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function showPermanentTooltips(pSteps:Array) : void
      {
         var step:AbstractSequencable = null;
         var targetId:Number = NaN;
         if(!this.fightEntitiesFrame)
         {
            return;
         }
         var targetInfo:GameContextActorInformations = null;
         for each(step in pSteps)
         {
            if(step is IFightStep && !(step is FightTurnListStep))
            {
               for each(targetId in (step as IFightStep).targets)
               {
                  if(this.fightEntitiesFrame.hasEntity(targetId))
                  {
                     targetInfo = this.fightEntitiesFrame.getEntityInfos(targetId);
                     if(targetInfo && targetInfo.disposition.cellId != -1)
                     {
                        this.showTargetTooltip(targetId);
                     }
                  }
               }
            }
         }
      }
      
      private function summonEntity(entity:GameFightFighterInformations, sourceId:Number, actionId:uint) : void
      {
         var entityInfosS:GameContextActorInformations = null;
         var summonedEntityInfosS:GameFightMonsterInformations = null;
         var monsterS:Monster = null;
         var gfsgmsg:GameFightShowFighterMessage = new GameFightShowFighterMessage();
         gfsgmsg.initGameFightShowFighterMessage(entity);
         Kernel.getWorker().getFrame(FightEntitiesFrame).process(gfsgmsg);
         if(ActionIdHelper.isRevive(actionId))
         {
            this.fightEntitiesFrame.removeLastKilledAlly(entity.spawnInfo.teamId);
         }
         var summonedCreature:Sprite = DofusEntities.getEntity(entity.contextualId) as Sprite;
         if(summonedCreature)
         {
            summonedCreature.visible = false;
         }
         this.pushStep(new FightSummonStep(sourceId,entity));
         var isBomb:Boolean = false;
         var isCreature:Boolean = false;
         var summonedCharacterInfoS:GameFightCharacterInformations = null;
         if(actionId == ActionIds.ACTION_SUMMON_BOMB)
         {
            isBomb = true;
         }
         else
         {
            entityInfosS = FightEntitiesFrame.getCurrentInstance().getEntityInfos(entity.contextualId);
            isBomb = false;
            summonedEntityInfosS = entityInfosS as GameFightMonsterInformations;
            if(summonedEntityInfosS)
            {
               monsterS = Monster.getMonsterById(summonedEntityInfosS.creatureGenericId);
               if(monsterS && monsterS.useBombSlot)
               {
                  isBomb = true;
               }
               if(monsterS && monsterS.useSummonSlot)
               {
                  isCreature = true;
               }
            }
            else
            {
               summonedCharacterInfoS = entityInfosS as GameFightCharacterInformations;
            }
         }
         if(isCreature || summonedCharacterInfoS)
         {
            CurrentPlayedFighterManager.getInstance().addSummonedCreature(sourceId);
         }
         else if(isBomb)
         {
            CurrentPlayedFighterManager.getInstance().addSummonedBomb(sourceId);
         }
         var nextPlayableCharacterId:Number = this._fightBattleFrame.getNextPlayableCharacterId();
         if(this._fightBattleFrame.currentPlayerId != CurrentPlayedFighterManager.getInstance().currentFighterId && nextPlayableCharacterId != CurrentPlayedFighterManager.getInstance().currentFighterId && nextPlayableCharacterId == entity.contextualId)
         {
            this._fightBattleFrame.prepareNextPlayableCharacter();
         }
      }
      
      public function set context(context:SpellCastSequenceContext) : void
      {
         _lastCastingSpell = context;
      }
      
      public function set steps(steps:Vector.<ISequencable>) : void
      {
         this._steps = steps;
      }
   }
}
