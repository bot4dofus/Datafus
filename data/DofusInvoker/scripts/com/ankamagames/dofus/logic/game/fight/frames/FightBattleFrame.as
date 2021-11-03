package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.managers.AFKFightManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.steps.WaitStep;
   import com.ankamagames.dofus.logic.game.fight.actions.DisableAfkAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightTurnFinishAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellModifiersManager;
   import com.ankamagames.dofus.logic.game.fight.messages.GameActionFightLeaveMessage;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
   import com.ankamagames.dofus.logic.game.fight.steps.FightVisibilityStep;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.logic.game.fight.types.TriggeredBuff;
   import com.ankamagames.dofus.logic.game.roleplay.frames.InfoEntitiesFrame;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.GameDebugManager;
   import com.ankamagames.dofus.network.messages.game.actions.GameActionAcknowledgementMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionUpdateEffectTriggerCountMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceStartMessage;
   import com.ankamagames.dofus.network.messages.game.character.stats.CharacterStatsListMessage;
   import com.ankamagames.dofus.network.messages.game.character.stats.UpdateSpellModifierMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightNewRoundMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightNewWaveMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPauseMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSynchronizeMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnListMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnReadyMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnReadyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnResumeMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnStartMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnStartPlayingMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.SlaveNoLongerControledMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.SlaveSwitchContextMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEffectTriggerCount;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import gs.TweenMax;
   
   public class FightBattleFrame implements Frame
   {
      
      public static const FIGHT_SEQUENCER_NAME:String = "FightBattleSequencer";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightBattleFrame));
       
      
      public var isFightAboutToEnd:Boolean = false;
      
      private var _sequenceFrameSwitcher:FightSequenceSwitcherFrame;
      
      private var _turnFrame:FightTurnFrame;
      
      private var _currentSequenceFrame:FightSequenceFrame;
      
      private var _sequenceFrames:Array;
      
      private var _executingSequence:Boolean;
      
      private var _confirmTurnEnd:Boolean;
      
      private var _endBattle:Boolean;
      
      private var _battleResults:GameFightEndMessage;
      
      private var _refreshTurnsList:Boolean;
      
      private var _newTurnsList:Vector.<Number>;
      
      private var _newDeadTurnsList:Vector.<Number>;
      
      private var _turnsList:Vector.<Number>;
      
      private var _deadTurnsList:Vector.<Number>;
      
      private var _playerTargetedEntitiesList:Vector.<Number>;
      
      private var _fightIsPaused:Boolean = false;
      
      private var _deathPlayingNumber:int = 0;
      
      private var _synchroniseFighters:Vector.<GameFightFighterInformations> = null;
      
      private var _synchroniseFightersInstanceId:uint = 4.294967295E9;
      
      private var _neverSynchronizedBefore:Boolean = true;
      
      private var _delayCslmsg:CharacterStatsListMessage;
      
      private var _playerNewTurn:AnimatedCharacter;
      
      private var _turnsCount:uint = 0;
      
      private var _destroyed:Boolean;
      
      private var _playingSlaveEntity:Boolean = false;
      
      private var _lastPlayerId:Number;
      
      private var _nextLastPlayerId:Number;
      
      private var _currentPlayerId:Number = 0;
      
      private var _skipTurnTimer:BenchmarkTimer;
      
      private var _infoEntitiesFrame:InfoEntitiesFrame;
      
      private var _masterId:Number;
      
      private var _slaveId:Number;
      
      private var _autoEndTurn:Boolean = false;
      
      private var _autoEndTurnTimer:BenchmarkTimer;
      
      private var _newWave:Boolean;
      
      private var _newWaveId:int;
      
      private var _waveSound:SoundDofus;
      
      private var _sequenceFrameCached:FightSequenceFrame = null;
      
      public function FightBattleFrame()
      {
         this._playerTargetedEntitiesList = new Vector.<Number>(0);
         this._infoEntitiesFrame = new InfoEntitiesFrame();
         super();
      }
      
      public function get priority() : int
      {
         return Priority.HIGH;
      }
      
      public function get fightIsPaused() : Boolean
      {
         return this._fightIsPaused;
      }
      
      public function get fightersList() : Vector.<Number>
      {
         return this._turnsList;
      }
      
      public function set fightersList(turnList:Vector.<Number>) : void
      {
         this._turnsList = turnList;
      }
      
      public function get deadFightersList() : Vector.<Number>
      {
         return this._deadTurnsList;
      }
      
      public function set deadFightersList(deadTurnList:Vector.<Number>) : void
      {
         this._deadTurnsList = deadTurnList;
      }
      
      public function get targetedEntities() : Vector.<Number>
      {
         return this._playerTargetedEntitiesList;
      }
      
      public function get turnsCount() : uint
      {
         return this._turnsCount;
      }
      
      public function set turnsCount(turn:uint) : void
      {
         this._turnsCount = turn;
      }
      
      public function get currentPlayerId() : Number
      {
         return this._currentPlayerId;
      }
      
      public function get executingSequence() : Boolean
      {
         return this._executingSequence;
      }
      
      public function get currentSequenceFrame() : FightSequenceFrame
      {
         return this._currentSequenceFrame;
      }
      
      public function get playingSlaveEntity() : Boolean
      {
         return this._playingSlaveEntity;
      }
      
      public function get slaveId() : Number
      {
         return this._slaveId;
      }
      
      public function get masterId() : Number
      {
         return this._masterId;
      }
      
      public function get deathPlayingNumber() : int
      {
         return this._deathPlayingNumber;
      }
      
      public function set deathPlayingNumber(n:int) : void
      {
         this._deathPlayingNumber = n;
      }
      
      public function pushed() : Boolean
      {
         this._turnFrame = new FightTurnFrame();
         this._playingSlaveEntity = false;
         this._sequenceFrames = [];
         DataMapProvider.getInstance().isInFight = true;
         Kernel.getWorker().addFrame(this._turnFrame);
         this._destroyed = false;
         this._autoEndTurnTimer = new BenchmarkTimer(60,1,"FightBattleFrame._autoEndTurnTimer");
         this._autoEndTurnTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.sendAutoEndTurn);
         this._waveSound = new SoundDofus(UISoundEnum.FIGHT_NEW_WAVE);
         this._waveSound.volume = 1;
         SoundManager.getInstance().manager.upFightMusicVolume();
         this._neverSynchronizedBefore = true;
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var gftmsg:GameFightTurnListMessage = null;
         var gftcimsg:GameFightSynchronizeMessage = null;
         var gauetcmsg:GameActionUpdateEffectTriggerCountMessage = null;
         var sscmsg:SlaveSwitchContextMessage = null;
         var snlcmsg:SlaveNoLongerControledMessage = null;
         var gftsmsg:GameFightTurnStartMessage = null;
         var playerId:Number = NaN;
         var isResumeMessage:* = false;
         var sapi:SoundApi = null;
         var deadEntityInfo:GameFightFighterInformations = null;
         var entitiesFrame:FightEntitiesFrame = null;
         var entitiesIds:Vector.<Number> = null;
         var numEntities:uint = 0;
         var fighterInfos:GameFightFighterInformations = null;
         var i:int = 0;
         var gftemsg:GameFightTurnEndMessage = null;
         var entityInfos:GameContextActorInformations = null;
         var semsg:SequenceEndMessage = null;
         var gfnwmsg:GameFightNewWaveMessage = null;
         var gfnrmsg:GameFightNewRoundMessage = null;
         var gflmsg:GameFightLeaveMessage = null;
         var fighterInfos2:GameFightFighterInformations = null;
         var leaveSequenceFrame:FightSequenceFrame = null;
         var gfemsg:GameFightEndMessage = null;
         var maxEndRescue:uint = 0;
         var gfpmsg:GameFightPauseMessage = null;
         var usmmsg:UpdateSpellModifierMessage = null;
         var fighter:GameFightFighterInformations = null;
         var effectTrigger:GameFightEffectTriggerCount = null;
         var buffTriggered:BasicBuff = null;
         var currentPlayedFighterId:Number = NaN;
         var nextPlayable:Number = NaN;
         var entity:AnimatedCharacter = null;
         var ss:SerialSequencer = null;
         var yOffset:Number = NaN;
         var ss2:SerialSequencer = null;
         var fightContextFrame:FightContextFrame = null;
         var time:int = 0;
         var action:Action = null;
         var fightEntitesFrame:FightEntitiesFrame = null;
         var alivePlayers:int = 0;
         var en:GameContextActorInformations = null;
         var mouseOverEntityInfos:GameFightFighterInformations = null;
         var mouseOverEntity:Boolean = false;
         var mouseOverTimelineEntity:Boolean = false;
         var fighterInfosTE:GameFightFighterInformations = null;
         var fakeDeathMessage:GameActionFightLeaveMessage = null;
         var seqEnd:SequenceEndMessage = null;
         var fakegfemsg:GameFightEndMessage = null;
         switch(true)
         {
            case msg is GameFightTurnListMessage:
               gftmsg = msg as GameFightTurnListMessage;
               if(this._executingSequence || this._currentSequenceFrame)
               {
                  _log.warn("There was a turns list update during this sequence... Let\'s wait its finish before doing it.");
                  this._refreshTurnsList = true;
                  this._newTurnsList = gftmsg.ids;
                  this._newDeadTurnsList = gftmsg.deadsIds;
               }
               else
               {
                  this.updateTurnsList(gftmsg.ids,gftmsg.deadsIds);
               }
               return true;
            case msg is GameFightSynchronizeMessage:
               gftcimsg = msg as GameFightSynchronizeMessage;
               if(this._newWave)
               {
                  for each(fighter in gftcimsg.fighters)
                  {
                     if(fighter.spawnInfo.alive && fighter.wave == this._newWaveId && !FightEntitiesFrame.getCurrentInstance().getEntityInfos(fighter.contextualId))
                     {
                        FightEntitiesFrame.getCurrentInstance().registerActor(fighter);
                     }
                  }
               }
               if(this._executingSequence)
               {
                  this._synchroniseFighters = gftcimsg.fighters;
                  this._synchroniseFightersInstanceId = FightSequenceFrame.currentInstanceId;
               }
               else
               {
                  this.gameFightSynchronize(gftcimsg.fighters);
               }
               return false;
            case msg is GameActionUpdateEffectTriggerCountMessage:
               gauetcmsg = msg as GameActionUpdateEffectTriggerCountMessage;
               for each(effectTrigger in gauetcmsg.targetIds)
               {
                  for each(buffTriggered in BuffManager.getInstance().getAllBuff(effectTrigger.targetId))
                  {
                     if(buffTriggered is TriggeredBuff && buffTriggered.effect.effectUid == effectTrigger.effectId)
                     {
                        (buffTriggered as TriggeredBuff).triggerCount = effectTrigger.count;
                        break;
                     }
                  }
               }
               return true;
            case msg is SlaveSwitchContextMessage:
               sscmsg = msg as SlaveSwitchContextMessage;
               playerId = PlayedCharacterManager.getInstance().id;
               if(sscmsg.masterId == playerId)
               {
                  this._masterId = sscmsg.masterId;
                  this._slaveId = sscmsg.slaveId;
                  if(!this._currentPlayerId && this._turnsList.indexOf(this._masterId) > this._turnsList.indexOf(this._slaveId))
                  {
                     this.prepareNextPlayableCharacter(this._masterId);
                  }
               }
               return false;
            case msg is SlaveNoLongerControledMessage:
               snlcmsg = msg as SlaveNoLongerControledMessage;
               playerId = PlayedCharacterManager.getInstance().id;
               if(snlcmsg.masterId != playerId && this._slaveId == snlcmsg.slaveId)
               {
                  this._masterId = playerId;
                  this._slaveId = this._masterId;
                  this.prepareNextPlayableCharacter(playerId);
                  this._slaveId = 0;
               }
               return false;
            case msg is GameFightTurnStartMessage:
               gftsmsg = msg as GameFightTurnStartMessage;
               playerId = PlayedCharacterManager.getInstance().id;
               this._currentPlayerId = gftsmsg.id;
               if(!this._lastPlayerId)
               {
                  this._lastPlayerId = this._currentPlayerId;
               }
               _log.info("Start turn for entityId: " + this._currentPlayerId);
               if(this._currentPlayerId == playerId)
               {
                  this._slaveId = 0;
               }
               this._playingSlaveEntity = gftsmsg.id == this._slaveId;
               this._turnFrame.turnDuration = gftsmsg.waitTime * 100;
               isResumeMessage = msg is GameFightTurnResumeMessage;
               if(!isResumeMessage)
               {
                  BuffManager.getInstance().decrementDuration(gftsmsg.id);
                  BuffManager.getInstance().resetTriggerCount(gftsmsg.id);
               }
               else
               {
                  currentPlayedFighterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
                  nextPlayable = this.getNextPlayableCharacterId();
                  if(this._slaveId && this._currentPlayerId != currentPlayedFighterId && (this._slaveId == this._currentPlayerId || nextPlayable == this._slaveId))
                  {
                     this.prepareNextPlayableCharacter(this._masterId);
                  }
               }
               if(gftsmsg.id > 0 || this._playingSlaveEntity)
               {
                  if(FightEntitiesFrame.getCurrentInstance().getEntityInfos(gftsmsg.id) && FightEntitiesFrame.getCurrentInstance().getEntityInfos(gftsmsg.id).disposition.cellId != -1 && !FightEntitiesHolder.getInstance().getEntity(gftsmsg.id))
                  {
                     entity = DofusEntities.getEntity(gftsmsg.id) as AnimatedCharacter;
                     if(entity != null)
                     {
                        ss = new SerialSequencer();
                        ss.addStep(new AddGfxEntityStep(154,entity.position.cellId));
                        ss.start();
                        yOffset = 65 * entity.look.getScaleY();
                        ss2 = new SerialSequencer();
                        ss2.addStep(new AddGfxEntityStep(153,entity.position.cellId,0,-yOffset));
                        ss2.start();
                     }
                     this._playerNewTurn = entity;
                  }
               }
               sapi = new SoundApi();
               deadEntityInfo = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gftsmsg.id) as GameFightFighterInformations;
               if((gftsmsg.id == playerId || this._playingSlaveEntity) && deadEntityInfo && deadEntityInfo.spawnInfo.alive)
               {
                  CurrentPlayedFighterManager.getInstance().currentFighterId = gftsmsg.id;
                  if(sapi.playSoundAtTurnStart())
                  {
                     SoundManager.getInstance().manager.playUISound(UISoundEnum.PLAYER_TURN);
                  }
                  SpellWrapper.refreshAllPlayerSpellHolder(gftsmsg.id);
                  this._turnFrame.myTurn = true;
               }
               else
               {
                  this._turnFrame.myTurn = false;
               }
               KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnStart,gftsmsg.id,gftsmsg.waitTime * 100,!!isResumeMessage ? (msg as GameFightTurnResumeMessage).remainingTime * 100 : gftsmsg.waitTime * 100,Dofus.getInstance().options.getOption("turnPicture"));
               if(this._turnFrame.myTurn && PlayerManager.getInstance().kisServerPort > 0)
               {
                  if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.KOLO_TURN_START))
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ArenaExternalNotification,ExternalNotificationTypeEnum.KOLO_TURN_START,!!isResumeMessage ? (msg as GameFightTurnResumeMessage).remainingTime * 100 : gftsmsg.waitTime * 100);
                  }
               }
               if(this._skipTurnTimer)
               {
                  this._skipTurnTimer.stop();
                  this._skipTurnTimer.removeEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
                  this._skipTurnTimer = null;
               }
               if(gftsmsg.id == playerId || this._playingSlaveEntity)
               {
                  if(AFKFightManager.getInstance().isAfk)
                  {
                     fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                     if(fightContextFrame && !fightContextFrame.isKolossium)
                     {
                        time = getTimer();
                        if(AFKFightManager.getInstance().lastTurnSkip + 5 * 1000 < time)
                        {
                           action = new GameFightTurnFinishAction();
                           Kernel.getWorker().process(action);
                        }
                        else
                        {
                           this._skipTurnTimer = new BenchmarkTimer(5 * 1000 - (time - AFKFightManager.getInstance().lastTurnSkip),1,"FightBattleFrame._skipTurnTimer");
                           this._skipTurnTimer.addEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
                           this._skipTurnTimer.start();
                        }
                     }
                  }
                  else
                  {
                     fightEntitesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                     alivePlayers = 0;
                     for each(en in fightEntitesFrame.getEntitiesDictionnary())
                     {
                        if(en is GameFightCharacterInformations && GameFightCharacterInformations(en).spawnInfo.alive && en.contextualId > 0)
                        {
                           alivePlayers++;
                        }
                     }
                     if(alivePlayers > 0)
                     {
                        AFKFightManager.getInstance().initialize();
                     }
                  }
               }
               if(PlayedCharacterManager.getInstance().isSpectator && OptionManager.getOptionManager("dofus").getOption("spectatorAutoShowCurrentFighterInfo") == true)
               {
                  mouseOverEntityInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(FightContextFrame.fighterEntityTooltipId) as GameFightFighterInformations;
                  mouseOverEntity = mouseOverEntityInfos && mouseOverEntityInfos.disposition.cellId == FightContextFrame.currentCell;
                  mouseOverTimelineEntity = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame).timelineOverEntity;
                  if(!mouseOverEntity && !mouseOverTimelineEntity)
                  {
                     KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,FightEntitiesFrame.getCurrentInstance().getEntityInfos(gftsmsg.id) as GameFightFighterInformations);
                  }
               }
               this.removeSavedPosition(gftsmsg.id);
               entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
               entitiesIds = entitiesFrame.getEntitiesIdsList();
               numEntities = entitiesIds.length;
               for(i = 0; i < numEntities; i++)
               {
                  fighterInfos = entitiesFrame.getEntityInfos(entitiesIds[i]) as GameFightFighterInformations;
                  if(fighterInfos && fighterInfos.stats.summoner == gftsmsg.id)
                  {
                     this.removeSavedPosition(entitiesIds[i]);
                  }
               }
               (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame).setFighterRoundStartPosition(gftsmsg.id,entitiesFrame.getEntityInfos(gftsmsg.id).disposition.cellId);
               return true;
            case msg is GameFightTurnStartPlayingMessage:
               SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_PLAYER_TURN_START);
               if(PlayerManager.getInstance().kisServerPort <= 0)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnStartPlaying);
               }
               return true;
            case msg is GameFightTurnEndMessage:
               gftemsg = msg as GameFightTurnEndMessage;
               if(!this._confirmTurnEnd)
               {
                  this._lastPlayerId = gftemsg.id;
               }
               else
               {
                  this._nextLastPlayerId = gftemsg.id;
               }
               entityInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gftemsg.id);
               if(entityInfos is GameFightFighterInformations && !(entityInfos as GameFightFighterInformations).spawnInfo.alive)
               {
                  fighterInfosTE = entityInfos as GameFightFighterInformations;
                  BuffManager.getInstance().markFinishingBuffs(gftemsg.id);
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd,gftemsg.id);
                  if(gftemsg.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                  {
                     CurrentPlayedFighterManager.getInstance().getSpellCastManager().nextTurn();
                     SpellWrapper.refreshAllPlayerSpellHolder(gftemsg.id);
                  }
               }
               if(gftemsg.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  AFKFightManager.getInstance().lastTurnSkip = getTimer();
                  AFKFightManager.getInstance().confirm = true;
                  this._turnFrame.myTurn = false;
               }
               return true;
            case msg is SequenceStartMessage:
               this._autoEndTurn = false;
               if(!this._sequenceFrameSwitcher)
               {
                  this._sequenceFrameSwitcher = new FightSequenceSwitcherFrame();
                  Kernel.getWorker().addFrame(this._sequenceFrameSwitcher);
               }
               this._currentSequenceFrame = new FightSequenceFrame(this,this._currentSequenceFrame);
               this._sequenceFrameSwitcher.currentFrame = this._currentSequenceFrame;
               return true;
            case msg is SequenceEndMessage:
               semsg = msg as SequenceEndMessage;
               if(!this._currentSequenceFrame)
               {
                  _log.warn("Wow wow wow, I\'ve got a Sequence End but no Sequence Start? What the hell?");
                  return true;
               }
               this._currentSequenceFrame.mustAck = semsg.authorId == CurrentPlayedFighterManager.getInstance().currentFighterId;
               this._currentSequenceFrame.ackIdent = semsg.actionId;
               this._sequenceFrameSwitcher.currentFrame = null;
               if(!this._currentSequenceFrame.parent)
               {
                  Kernel.getWorker().removeFrame(this._sequenceFrameSwitcher);
                  this._sequenceFrameSwitcher = null;
                  this._sequenceFrames.push(this._currentSequenceFrame);
                  this._currentSequenceFrame = null;
                  this.executeNextSequence();
               }
               else
               {
                  this._currentSequenceFrame.execute();
                  this._sequenceFrameSwitcher.currentFrame = this._currentSequenceFrame.parent;
                  this._currentSequenceFrame = this._currentSequenceFrame.parent;
               }
               return true;
               break;
            case msg is GameFightTurnReadyRequestMessage:
               if(this._executingSequence)
               {
                  _log.warn("Delaying turn end acknowledgement because we\'re still in a sequence.");
                  this._confirmTurnEnd = true;
               }
               else
               {
                  this.confirmTurnEnd();
               }
               return false;
            case msg is GameFightNewWaveMessage:
               gfnwmsg = msg as GameFightNewWaveMessage;
               this._newWaveId = gfnwmsg.id;
               this._newWave = true;
               KernelEventsManager.getInstance().processCallback(FightHookList.WaveUpdated,gfnwmsg.teamId,gfnwmsg.id,gfnwmsg.nbTurnBeforeNextWave);
               return true;
            case msg is GameFightNewRoundMessage:
               gfnrmsg = msg as GameFightNewRoundMessage;
               this._turnsCount = gfnrmsg.roundNumber;
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = this._turnsCount;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,this._turnsCount);
               if(GameDebugManager.getInstance().buffsDebugActivated)
               {
                  _log.debug("[BUFFS DEBUG] Début du tour de jeu " + this._turnsCount + " !");
               }
               BuffManager.getInstance().spellBuffsToIgnore.length = 0;
               return true;
            case msg is GameFightLeaveMessage:
               gflmsg = msg as GameFightLeaveMessage;
               fighterInfos2 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._lastPlayerId) as GameFightFighterInformations;
               leaveSequenceFrame = new FightSequenceFrame(this);
               if(fighterInfos2 && fighterInfos2.spawnInfo.alive)
               {
                  fakeDeathMessage = new GameActionFightLeaveMessage();
                  leaveSequenceFrame.process(fakeDeathMessage.initGameActionFightLeaveMessage(0,0,gflmsg.charId));
                  this._sequenceFrames.push(leaveSequenceFrame);
                  this.executeNextSequence();
               }
               if(gflmsg.charId == PlayedCharacterManager.getInstance().id && PlayedCharacterManager.getInstance().isSpectator)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave,gflmsg.charId);
               }
               return true;
            case msg is GameFightEndMessage:
               gfemsg = msg as GameFightEndMessage;
               maxEndRescue = 5;
               while(this._currentSequenceFrame && --maxEndRescue)
               {
                  _log.error("/!\\ Fight end but no SequenceEnd was received");
                  seqEnd = new SequenceEndMessage();
                  seqEnd.initSequenceEndMessage();
                  this.process(seqEnd);
               }
               if(this._executingSequence)
               {
                  _log.warn("Delaying fight end because we\'re still in a sequence.");
                  this._endBattle = true;
                  this._battleResults = gfemsg;
               }
               else
               {
                  this.endBattle(gfemsg);
               }
               FightersStateManager.getInstance().endFight();
               CurrentPlayedFighterManager.getInstance().endFight();
               return true;
            case msg is GameContextDestroyMessage:
               if(this._battleResults)
               {
                  _log.debug("Fin de combat propre (resultat connu)");
                  this.endBattle(this._battleResults);
               }
               else
               {
                  _log.debug("Fin de combat brutale (pas de resultat connu)");
                  this._executingSequence = false;
                  fakegfemsg = new GameFightEndMessage();
                  fakegfemsg.initGameFightEndMessage(0,0,0,null);
                  this.process(fakegfemsg);
               }
               return true;
            case msg is GameFightPauseMessage:
               gfpmsg = msg as GameFightPauseMessage;
               if(gfpmsg.isPaused)
               {
                  _log.debug("The fight is paused.");
               }
               else
               {
                  _log.debug("The fight is resuming after pause.");
               }
               this._fightIsPaused = gfpmsg.isPaused;
               KernelEventsManager.getInstance().processCallback(HookList.GameFightPause,gfpmsg.isPaused);
               return true;
            case msg is DisableAfkAction:
               AFKFightManager.getInstance().confirm = false;
               AFKFightManager.getInstance().enabled = false;
               return true;
            case msg is ShowAllNamesAction:
               if(Kernel.getWorker().contains(InfoEntitiesFrame))
               {
                  Kernel.getWorker().removeFrame(this._infoEntitiesFrame);
               }
               else
               {
                  Kernel.getWorker().addFrame(this._infoEntitiesFrame);
               }
               return true;
            case msg is UpdateSpellModifierMessage:
               usmmsg = msg as UpdateSpellModifierMessage;
               SpellModifiersManager.getInstance().setRawSpellModifier(usmmsg.actorId,usmmsg.spellModifier);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         var entityId:Number = NaN;
         var fsf:FightSequenceFrame = null;
         this.applyDelayedStats();
         DataMapProvider.getInstance().isInFight = false;
         TweenMax.killAll(false);
         if(Kernel.getWorker().contains(FightTurnFrame))
         {
            Kernel.getWorker().removeFrame(this._turnFrame);
         }
         BuffManager.getInstance().destroy();
         MarkedCellsManager.getInstance().destroy();
         LinkedCellsManager.getInstance().destroy();
         if(this._executingSequence || Kernel.getWorker().contains(FightSequenceFrame))
         {
            _log.warn("Wow, wait. We\'re pulling FightBattle but there\'s still sequences inside the worker !!");
            fsf = Kernel.getWorker().getFrame(FightSequenceFrame) as FightSequenceFrame;
            Kernel.getWorker().removeFrame(fsf);
         }
         SerialSequencer.clearByType(FIGHT_SEQUENCER_NAME);
         SerialSequencer.clearByType(FightSequenceFrame.FIGHT_SEQUENCERS_CATEGORY);
         AFKFightManager.getInstance().enabled = false;
         this._currentSequenceFrame = null;
         this._sequenceFrameSwitcher = null;
         this._turnFrame = null;
         this._battleResults = null;
         this._newTurnsList = null;
         this._newDeadTurnsList = null;
         this._turnsList = null;
         this._deadTurnsList = null;
         this._sequenceFrames = null;
         this._playingSlaveEntity = false;
         this._masterId = 0;
         this._slaveId = 0;
         if(this._playerNewTurn)
         {
            this._playerNewTurn.destroy();
         }
         if(this._skipTurnTimer)
         {
            this._skipTurnTimer.reset();
            this._skipTurnTimer.removeEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
            this._skipTurnTimer = null;
         }
         this._destroyed = true;
         for each(entityId in this._playerTargetedEntitiesList)
         {
            TooltipManager.hide("tooltipOverEntity_" + entityId);
         }
         TooltipManager.hide("tooltipOverEntity_" + PlayedCharacterManager.getInstance().id);
         if(this._autoEndTurnTimer)
         {
            this._autoEndTurnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.sendAutoEndTurn);
            this._autoEndTurnTimer = null;
         }
         return true;
      }
      
      public function delayCharacterStatsList(msg:CharacterStatsListMessage) : void
      {
         this._delayCslmsg = msg;
      }
      
      public function prepareNextPlayableCharacter(currentCharacterId:Number = 0) : void
      {
         var nextCharacterEntity:GameFightFighterInformations = null;
         var nextCharacterId:Number = NaN;
         if(this._slaveId)
         {
            if(currentCharacterId)
            {
               nextCharacterId = currentCharacterId == this._slaveId ? Number(this._masterId) : Number(this._slaveId);
            }
            else
            {
               nextCharacterId = this.getNextPlayableCharacterId();
            }
            nextCharacterEntity = FightEntitiesFrame.getCurrentInstance().getEntityInfos(nextCharacterId) as GameFightFighterInformations;
            if(!nextCharacterEntity || !nextCharacterEntity.spawnInfo.alive)
            {
               return;
            }
            CurrentPlayedFighterManager.getInstance().currentFighterId = nextCharacterId;
            if(nextCharacterId == this._masterId)
            {
               FightApi.slaveContext = false;
               CurrentPlayedFighterManager.getInstance().resetPlayerSpellList();
               SpellInventoryManagementFrame.getCurrentInstance().applySpellGlobalCoolDownInfo(this._masterId);
               KernelEventsManager.getInstance().processCallback(CustomUiHookList.SpellMovementAllowed,true);
            }
            else if(nextCharacterId == this._slaveId)
            {
               KernelEventsManager.getInstance().processCallback(CustomUiHookList.SpellMovementAllowed,false);
            }
         }
      }
      
      public function getNextPlayableCharacterId() : Number
      {
         var masterIdx:int = 0;
         var slaveIdx:int = 0;
         var currentCharacterIdx:int = 0;
         var currentPlayedCharacterId:Number = CurrentPlayedFighterManager.getInstance().currentFighterId;
         if(!this._slaveId || !this._turnsList)
         {
            return currentPlayedCharacterId;
         }
         for(var i:int = 0; i < this._turnsList.length; i++)
         {
            if(this._turnsList[i] == this._masterId)
            {
               masterIdx = i;
            }
            else if(this._turnsList[i] == this._slaveId)
            {
               slaveIdx = i;
            }
            if(this._turnsList[i] == this._currentPlayerId)
            {
               currentCharacterIdx = i;
            }
         }
         if(masterIdx == currentCharacterIdx)
         {
            return this._slaveId;
         }
         if(slaveIdx == currentCharacterIdx)
         {
            return this._masterId;
         }
         if(masterIdx < currentCharacterIdx && slaveIdx > currentCharacterIdx)
         {
            return this._slaveId;
         }
         if(masterIdx > currentCharacterIdx && slaveIdx < currentCharacterIdx)
         {
            return this._masterId;
         }
         if(masterIdx > slaveIdx && masterIdx < currentCharacterIdx)
         {
            return this._slaveId;
         }
         if(masterIdx < slaveIdx && masterIdx < currentCharacterIdx)
         {
            return this._masterId;
         }
         if(masterIdx > slaveIdx && masterIdx > currentCharacterIdx)
         {
            return this._slaveId;
         }
         if(masterIdx < slaveIdx && masterIdx > currentCharacterIdx)
         {
            return this._masterId;
         }
         return 0;
      }
      
      private function executeNextSequence() : Boolean
      {
         if(this._executingSequence)
         {
            return false;
         }
         var nextSequenceFrame:FightSequenceFrame = this._sequenceFrames.shift();
         if(nextSequenceFrame)
         {
            this._executingSequence = true;
            nextSequenceFrame.execute(this.finishSequence(nextSequenceFrame));
            return true;
         }
         return false;
      }
      
      private function applyDelayedStats() : void
      {
         if(!this._delayCslmsg)
         {
            return;
         }
         var characterFrame:PlayedCharacterUpdatesFrame = Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame;
         if(characterFrame)
         {
            characterFrame.updateCharacterStatsList(this._delayCslmsg.stats);
         }
         this._delayCslmsg = null;
      }
      
      private function waitAnimations() : void
      {
         var entityId:Number = NaN;
         var tiphonSprite:TiphonSprite = null;
         var key:* = null;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var entityIdList:Vector.<Number> = null;
         if(entitiesFrame !== null)
         {
            entityIdList = entitiesFrame.getEntitiesIdsList();
         }
         if(entityIdList === null)
         {
            this.sendAcknowledgement();
            return;
         }
         var tiphonSpriteToListen:TiphonSprite = null;
         var maxFramesLeft:Number = -1;
         for(var index:Number = 0; index < entityIdList.length; index++)
         {
            entityId = entityIdList[index];
            tiphonSprite = DofusEntities.getEntity(entityId) as TiphonSprite;
            if(tiphonSprite !== null)
            {
               if(tiphonSprite.isPlayingAnimation() && !tiphonSprite.isCurrentAnimationStatic())
               {
                  if(tiphonSprite.framesLeft > maxFramesLeft)
                  {
                     maxFramesLeft = tiphonSprite.framesLeft;
                     tiphonSpriteToListen = tiphonSprite;
                  }
               }
            }
         }
         var entities:Array = EntitiesManager.getInstance().entities;
         for(key in entities)
         {
            tiphonSprite = entities[key] as TiphonSprite;
            if(tiphonSprite !== null)
            {
               if(tiphonSprite.isPlayingAnimation() && !tiphonSprite.isCurrentAnimationStatic())
               {
                  if(tiphonSprite.framesLeft > maxFramesLeft)
                  {
                     maxFramesLeft = tiphonSprite.framesLeft;
                     tiphonSpriteToListen = tiphonSprite;
                  }
               }
            }
         }
         if(tiphonSpriteToListen !== null)
         {
            tiphonSpriteToListen.addEventListener(TiphonEvent.ANIMATION_END,this.onLastAnimationFinished);
         }
         else
         {
            this.sendAcknowledgement();
         }
      }
      
      private function onLastAnimationFinished(tiphonEvent:TiphonEvent = null) : void
      {
         tiphonEvent.sprite.removeEventListener(TiphonEvent.ANIMATION_END,this.onLastAnimationFinished);
         this.sendAcknowledgement();
         if(this._confirmTurnEnd)
         {
            this.confirmDelayedTurnEnd();
         }
      }
      
      private function sendAcknowledgement() : void
      {
         if(this._sequenceFrameCached === null)
         {
            return;
         }
         var ack:GameActionAcknowledgementMessage = new GameActionAcknowledgementMessage();
         ack.initGameActionAcknowledgementMessage(true,this._sequenceFrameCached.ackIdent);
         this._sequenceFrameCached = null;
         try
         {
            ConnectionsHandler.getConnection().send(ack);
         }
         catch(e:Error)
         {
         }
      }
      
      private function finishSequence(sequenceFrame:FightSequenceFrame) : Function
      {
         return function():void
         {
            if(_destroyed)
            {
               return;
            }
            if(isFightAboutToEnd)
            {
               waitAnimations();
            }
            if(sequenceFrame.mustAck)
            {
               _sequenceFrameCached = sequenceFrame;
               if(!isFightAboutToEnd)
               {
                  sendAcknowledgement();
               }
            }
            FightEventsHelper.sendAllFightEvent(true);
            _log.info("Sequence finished.");
            _executingSequence = false;
            if(_refreshTurnsList)
            {
               _log.warn("There was a turns list refresh delayed, what about updating it now?");
               _refreshTurnsList = false;
               updateTurnsList(_newTurnsList,_newDeadTurnsList);
               _newTurnsList = null;
               _newDeadTurnsList = null;
            }
            if(!_executingSequence && _sequenceFrames.length && _sequenceFrames[0].instanceId >= _synchroniseFightersInstanceId)
            {
               gameFightSynchronize(_synchroniseFighters);
               _synchroniseFighters = null;
            }
            if(executeNextSequence())
            {
               applyDelayedStats();
               return;
            }
            if(_synchroniseFighters)
            {
               gameFightSynchronize(_synchroniseFighters);
               _synchroniseFighters = null;
            }
            applyDelayedStats();
            if(_endBattle)
            {
               _log.warn("This fight must end ! Finishing things now.");
               _endBattle = false;
               endBattle(_battleResults);
               _battleResults = null;
               return;
            }
            if(_confirmTurnEnd && !isFightAboutToEnd)
            {
               confirmDelayedTurnEnd();
            }
         };
      }
      
      private function confirmDelayedTurnEnd() : void
      {
         _log.warn("There was a turn end delayed, dispatching now.");
         this._confirmTurnEnd = false;
         if(!isNaN(this._nextLastPlayerId))
         {
            this._lastPlayerId = this._nextLastPlayerId;
         }
         this._nextLastPlayerId = Number.NaN;
         this.confirmTurnEnd();
      }
      
      private function sendAutoEndTurn(e:TimerEvent) : void
      {
         var action:Action = null;
         if(this._autoEndTurn)
         {
            action = new GameFightTurnFinishAction();
            Kernel.getWorker().process(action);
            this._autoEndTurn = false;
         }
         this._autoEndTurnTimer.stop();
      }
      
      private function updateTurnsList(turnsList:Vector.<Number>, deadTurnsList:Vector.<Number>) : void
      {
         this._turnsList = turnsList;
         this._deadTurnsList = deadTurnsList;
         KernelEventsManager.getInstance().processCallback(HookList.FightersListUpdated);
         if(Dofus.getInstance().options.getOption("orderFighters") && Kernel.getWorker().getFrame(FightEntitiesFrame))
         {
            (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).updateAllEntitiesNumber(turnsList);
         }
      }
      
      private function confirmTurnEnd() : void
      {
         var entityId:Number = NaN;
         var fighterInfos2:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._lastPlayerId) as GameFightFighterInformations;
         if(fighterInfos2)
         {
            BuffManager.getInstance().markFinishingBuffs(this._lastPlayerId);
            if(this._lastPlayerId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
               KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               SpellWrapper.refreshAllPlayerSpellHolder(this._lastPlayerId);
               for each(entityId in this._playerTargetedEntitiesList)
               {
                  TooltipManager.hide("tooltip_tooltipOverEntity_" + entityId);
               }
               this._playerTargetedEntitiesList.length = 0;
               this.prepareNextPlayableCharacter(this._lastPlayerId);
            }
            KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd,this._lastPlayerId);
         }
         var spellCastManager:SpellCastInFightManager = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(this._lastPlayerId);
         if(spellCastManager !== null)
         {
            spellCastManager.nextTurn();
         }
         var turnEnd:GameFightTurnReadyMessage = new GameFightTurnReadyMessage();
         turnEnd.initGameFightTurnReadyMessage(true);
         ConnectionsHandler.getConnection().send(turnEnd);
      }
      
      private function endBattle(fightEnd:GameFightEndMessage) : void
      {
         var coward:* = undefined;
         var fightContextFrame:FightContextFrame = null;
         EntitiesManager.getInstance().cleanDeadLook();
         var _holder:FightEntitiesHolder = FightEntitiesHolder.getInstance();
         var entities:Dictionary = _holder.getEntities();
         for each(coward in entities)
         {
            (coward as AnimatedCharacter).display();
         }
         _holder.reset();
         this._synchroniseFighters = null;
         Kernel.getWorker().removeFrame(this);
         fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         fightContextFrame.process(fightEnd);
      }
      
      private function onSkipTurnTimeOut(event:TimerEvent) : void
      {
         var action:Action = null;
         this._skipTurnTimer.removeEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
         this._skipTurnTimer = null;
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(AFKFightManager.getInstance().isAfk && (fightContextFrame && !fightContextFrame.isKolossium))
         {
            action = new GameFightTurnFinishAction();
            Kernel.getWorker().process(action);
         }
      }
      
      private function gameFightSynchronize(fighters:Vector.<GameFightFighterInformations>) : void
      {
         var newWaveAppeared:Boolean = false;
         var newWaveMonster:Boolean = false;
         var stats:EntityStats = null;
         var fighterInfos:GameFightFighterInformations = null;
         var buff:BasicBuff = null;
         var sequencer:SerialSequencer = null;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var newWaveMonsterIndex:int = 0;
         BuffManager.getInstance().synchronize();
         for each(fighterInfos in fighters)
         {
            stats = StatsManager.getInstance().getStats(fighterInfos.contextualId);
            if(fighterInfos.spawnInfo.alive)
            {
               newWaveMonster = fighterInfos.wave == this._newWaveId && fighterInfos.wave != 0 && !DofusEntities.getEntity(fighterInfos.contextualId);
               entitiesFrame.updateFighter(fighterInfos,null);
               BuffManager.getInstance().markFinishingBuffs(fighterInfos.contextualId,false);
               for each(buff in BuffManager.getInstance().getAllBuff(fighterInfos.contextualId))
               {
                  if(buff is StatBuff)
                  {
                     (buff as StatBuff).isRecent = false;
                  }
               }
               if(newWaveMonster)
               {
                  newWaveAppeared = true;
                  (DofusEntities.getEntity(fighterInfos.contextualId) as AnimatedCharacter).visible = false;
                  if(!OptionManager.getOptionManager("tubul").getOption("tubulIsDesactivated") && newWaveMonsterIndex == 0)
                  {
                     this._waveSound.play();
                  }
                  sequencer = new SerialSequencer();
                  sequencer.addStep(new WaitStep(300 * newWaveMonsterIndex));
                  sequencer.addStep(new AddGfxEntityStep(2715,fighterInfos.disposition.cellId));
                  sequencer.addStep(new FightVisibilityStep(fighterInfos.contextualId,true));
                  sequencer.start();
                  newWaveMonsterIndex++;
               }
            }
         }
         if(newWaveAppeared)
         {
            this._newWave = false;
            this._newWaveId = -1;
         }
         if(this._neverSynchronizedBefore)
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.UpdateFightersLook);
            this._neverSynchronizedBefore = false;
         }
      }
      
      private function removeSavedPosition(pEntityId:Number) : void
      {
         var savedPos:Object = null;
         var i:int = 0;
         var nbPos:int = 0;
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var savedPositions:Array = fightContextFrame.fightersPositionsHistory[pEntityId];
         if(savedPositions)
         {
            nbPos = savedPositions.length;
            for(i = 0; i < nbPos; i++)
            {
               savedPos = savedPositions[i];
               --savedPos.lives;
               if(savedPos.lives == 0)
               {
                  savedPositions.splice(i,1);
                  i--;
                  nbPos--;
               }
            }
         }
      }
   }
}
