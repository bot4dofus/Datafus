package com.ankamagames.dofus.logic.game.roleplay.managers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.dofus.datacenter.monsters.AnimFunMonsterData;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.npcs.AnimFunNpcData;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.types.SynchroTimer;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.types.AnimFun;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.types.data.AnimFunData;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.prng.PRNG;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import com.ankamagames.tiphon.display.TiphonAnimation;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.tiphon.events.SwlEvent;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public final class AnimFunManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimFunManager));
      
      public static const ANIM_FUN_TIMER_MIN:int = 40000;
      
      public static const ANIM_FUN_TIMER_MAX:int = 80000;
      
      public static const ANIM_FUN_MAX_ANIM_DURATION:int = 20000;
      
      public static const FAST_ANIM_FUN_TIMER_MIN:int = 4000;
      
      public static const FAST_ANIM_FUN_TIMER_MAX:int = 5000;
      
      public static const ANIM_DELAY_SIZE:uint = 20;
      
      private static var _self:AnimFunManager;
       
      
      private var _animFunNpcData:AnimFunNpcData;
      
      private var _animFunMonsterData:AnimFunMonsterData;
      
      private var _anims:Vector.<AnimFun>;
      
      private var _nbFastAnims:int;
      
      private var _nbNormalAnims:int;
      
      private var _mapId:Number = -1;
      
      private var _entitiesList:Array;
      
      private var _running:Boolean;
      
      private var _animFunPlaying:Boolean;
      
      private var _animFunEntityId:Number;
      
      private var _animSeq:SerialSequencer;
      
      private var _synchedAnimFuns:Dictionary;
      
      private var _fastTimer:SynchroTimer;
      
      private var _normalTimer:SynchroTimer;
      
      private var _lastFastAnimTime:int;
      
      private var _nextFastAnimDelay:int;
      
      private var _lastNormalAnimTime:int;
      
      private var _nextNormalAnimDelay:int;
      
      private var _lastAnim:AnimFun;
      
      private var _lastAnimFast:AnimFun;
      
      private var _lastAnimNormal:AnimFun;
      
      private var _cancelledAnim:AnimFun;
      
      private var _firstAnim:Boolean;
      
      private var _specialAnimFunMaxAnimDuration:int = 0;
      
      public function AnimFunManager()
      {
         this._anims = new Vector.<AnimFun>(0);
         this._entitiesList = new Array();
         this._animSeq = new SerialSequencer();
         this._synchedAnimFuns = new Dictionary();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : AnimFunManager
      {
         if(!_self)
         {
            _self = new AnimFunManager();
         }
         return _self;
      }
      
      public function get mapId() : Number
      {
         return this._mapId;
      }
      
      public function initializeByMap(mapId:Number) : void
      {
         var entity:GameContextActorInformations = null;
         var i:uint = 0;
         var isFastAnim:Boolean = false;
         var actorId:Number = NaN;
         var animdelayTime:uint = 0;
         var animFun:AnimFun = null;
         this._mapId = mapId;
         var rnd:PRNG = new ParkMillerCarta();
         rnd.seed(mapId + 5435);
         var entitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var entities:Dictionary = entitiesFrame.entities;
         this._specialAnimFunMaxAnimDuration = 0;
         this._entitiesList.length = 0;
         for each(entity in entities)
         {
            if(this.hasAnimsFun(entity.contextualId))
            {
               this._entitiesList.push(entity);
            }
         }
         this._anims.length = 0;
         this._nbNormalAnims = this._nbFastAnims = 0;
         this._normalTimer = this._fastTimer = null;
         if(!this._entitiesList.length)
         {
            return;
         }
         this._entitiesList.sortOn("contextualId",Array.NUMERIC);
         for(i = 0; i < ANIM_DELAY_SIZE; i++)
         {
            actorId = this.randomActor(rnd.nextInt());
            if(this.hasAnimsFun(actorId))
            {
               isFastAnim = this.hasFastAnims(actorId);
               if(!isFastAnim)
               {
                  animdelayTime = rnd.nextIntR(ANIM_FUN_TIMER_MIN,ANIM_FUN_TIMER_MAX);
                  ++this._nbNormalAnims;
               }
               else
               {
                  animdelayTime = rnd.nextIntR(FAST_ANIM_FUN_TIMER_MIN,FAST_ANIM_FUN_TIMER_MAX);
                  ++this._nbFastAnims;
               }
               animFun = new AnimFun(actorId,this.randomAnim(actorId,rnd.nextInt()),animdelayTime,isFastAnim);
               this._anims.push(animFun);
            }
         }
         if(this._anims.length > 0)
         {
            this.start();
         }
      }
      
      public function get running() : Boolean
      {
         return this._running;
      }
      
      public function start() : void
      {
         var totalTimeNormalAnim:int = 0;
         var totalTimeFastAnim:int = 0;
         var af:AnimFun = null;
         for each(af in this._anims)
         {
            if(!af.fastAnim)
            {
               totalTimeNormalAnim += af.delayTime;
            }
            else
            {
               totalTimeFastAnim += af.delayTime;
            }
         }
         this._animSeq.addEventListener(SequencerEvent.SEQUENCE_END,this.onAnimFunEnd);
         this._firstAnim = true;
         if(this._nbFastAnims > 0)
         {
            this._fastTimer = new SynchroTimer(totalTimeFastAnim);
            this._fastTimer.start(this.checkAvailableAnim);
         }
         if(this._nbNormalAnims > 0)
         {
            this._normalTimer = new SynchroTimer(totalTimeNormalAnim);
            this._normalTimer.start(this.checkAvailableAnim);
         }
         this._running = true;
      }
      
      public function stop() : void
      {
         Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
         this._running = this._animFunPlaying = false;
         this._animFunEntityId = 0;
         this._lastAnimFast = this._lastAnimNormal = this._lastAnim = null;
         this._anims.length = 0;
         this._entitiesList.length = 0;
         this._animSeq.clear();
         this._animSeq.removeEventListener(SequencerEvent.SEQUENCE_END,this.onAnimFunEnd);
         if(this._fastTimer)
         {
            this._fastTimer.stop();
         }
         if(this._normalTimer)
         {
            this._normalTimer.stop();
         }
      }
      
      public function restart() : void
      {
         this.stop();
         this.initializeByMap(this._mapId);
      }
      
      public function cancelAnim(pEntityId:Number) : void
      {
         var entitySpr:TiphonSprite = null;
         if(this._animFunPlaying && this._animFunEntityId == pEntityId)
         {
            this._cancelledAnim = this._lastAnim;
            entitySpr = DofusEntities.getEntity(this._animFunEntityId) as TiphonSprite;
            entitySpr.dispatchEvent(new Event(TiphonEvent.ANIMATION_END));
         }
         Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
         this._firstAnim = false;
         this._animFunPlaying = false;
         this._animFunEntityId = 0;
      }
      
      private function getTimerValue() : int
      {
         return getTimer() % int.MAX_VALUE;
      }
      
      private function checkAvailableAnim(pTimer:SynchroTimer) : void
      {
         var animFun:AnimFun = null;
         var i:int = 0;
         var sum:int = 0;
         var elapsedTime:int = 0;
         var nbAnims:int = 0;
         var entity:AnimatedCharacter = null;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = null;
         var actorInfos:GameContextActorInformations = null;
         var cellData:CellData = null;
         var fastAnimTimer:* = pTimer == this._fastTimer;
         if(!this._animFunPlaying)
         {
            sum = 0;
            elapsedTime = 0;
            nbAnims = this._anims.length;
            if(fastAnimTimer)
            {
               if(this.getTimerValue() - this._lastFastAnimTime > this._nextFastAnimDelay)
               {
                  for(i = 0; i < nbAnims; i++)
                  {
                     if(this._anims[i].fastAnim)
                     {
                        sum += this._anims[i].delayTime;
                        if(sum >= pTimer.value)
                        {
                           elapsedTime = pTimer.value - (sum - this._anims[i].delayTime);
                           animFun = i > 0 ? this._anims[i - 1] : this._anims[0];
                           this._lastFastAnimTime = this.getTimerValue();
                           this._nextFastAnimDelay = this._anims[i].delayTime;
                           break;
                        }
                     }
                  }
               }
            }
            else if(this.getTimerValue() - this._lastNormalAnimTime > this._nextNormalAnimDelay)
            {
               for(i = 0; i < nbAnims; i++)
               {
                  if(!this._anims[i].fastAnim)
                  {
                     sum += this._anims[i].delayTime;
                     if(sum >= pTimer.value)
                     {
                        elapsedTime = pTimer.value - (sum - this._anims[i].delayTime);
                        animFun = i > 0 ? this._anims[i - 1] : this._anims[0];
                        this._lastNormalAnimTime = this.getTimerValue();
                        this._nextNormalAnimDelay = this._anims[i].delayTime;
                        break;
                     }
                  }
               }
            }
         }
         if(!animFun)
         {
            return;
         }
         if((!this._firstAnim || this._firstAnim && !this._lastAnim) && (this._lastAnim != animFun && (animFun.fastAnim && animFun != this._lastAnimFast || !animFun.fastAnim && animFun != this._lastAnimNormal)))
         {
            if(animFun.fastAnim)
            {
               this._lastAnimFast = animFun;
            }
            else
            {
               this._lastAnimNormal = animFun;
            }
            this._lastAnim = animFun;
            if(animFun)
            {
               if(this.getIsMapStatic())
               {
                  entity = DofusEntities.getEntity(animFun.actorId) as AnimatedCharacter;
                  if(!entity)
                  {
                     return;
                  }
                  roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                  if(!roleplayEntitiesFrame)
                  {
                     return;
                  }
                  actorInfos = roleplayEntitiesFrame.getEntityInfos(animFun.actorId);
                  if(!(actorInfos is GameRolePlayNpcInformations))
                  {
                     cellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[entity.position.cellId];
                     if(!Atouin.getInstance().options.getOption("transparentOverlayMode") && !cellData.visible)
                     {
                        return;
                     }
                  }
                  if(roleplayEntitiesFrame.hasIcon(animFun.actorId))
                  {
                     roleplayEntitiesFrame.forceIconUpdate(animFun.actorId);
                  }
                  this.synchCurrentAnim(animFun,elapsedTime);
               }
            }
            return;
         }
      }
      
      private function playAnimFun(pAnimFun:AnimFun, pStartFrame:int = -1) : void
      {
         var entity:TiphonSprite = DofusEntities.getEntity(pAnimFun.actorId) as TiphonSprite;
         var playAnimStep:PlayAnimationStep = new PlayAnimationStep(entity,pAnimFun.animName);
         var sequencer:SerialSequencer = new SerialSequencer();
         this._specialAnimFunMaxAnimDuration = this.getAnimClipInfo(pAnimFun).duration > ANIM_FUN_MAX_ANIM_DURATION ? int(this.getAnimClipInfo(pAnimFun).duration + 1000) : int(ANIM_FUN_MAX_ANIM_DURATION);
         playAnimStep.timeout = this._specialAnimFunMaxAnimDuration;
         playAnimStep.startFrame = pStartFrame;
         sequencer.addStep(playAnimStep);
         this._animFunPlaying = true;
         this._animFunEntityId = pAnimFun.actorId;
         var subAnimSequencer:Array = this.playSubAnimFun(pAnimFun,pStartFrame);
         subAnimSequencer.push(sequencer);
         var parallelSequencer:ISequencable = SequenceApi.CreateParallelStartSequenceStep(subAnimSequencer);
         parallelSequencer.timeout = this._specialAnimFunMaxAnimDuration;
         this._animSeq.addStep(parallelSequencer);
         this._animSeq.start();
         this._firstAnim = false;
      }
      
      private function playSubAnimFun(pAnimFun:AnimFun, pStartFrame:int = -1) : Array
      {
         var entity:GameContextActorInformations = null;
         var animFun:AnimFun = null;
         var animFunNpcData:AnimFunNpcData = null;
         var entitySprite:TiphonSprite = null;
         var playAnimStep:PlayAnimationStep = null;
         var sequencer:SerialSequencer = null;
         var subAnimSequencer:Array = [];
         if(pAnimFun.data is AnimFunNpcData)
         {
            for each(animFunNpcData in AnimFunNpcData(pAnimFun.data).subAnimFunData)
            {
               entity = this.getEntityByGenericId(animFunNpcData.entityId);
               if(entity)
               {
                  animFun = new AnimFun(entity.contextualId,animFunNpcData,pAnimFun.delayTime,pAnimFun.fastAnim);
                  entitySprite = DofusEntities.getEntity(entity.contextualId) as TiphonSprite;
                  playAnimStep = new PlayAnimationStep(entitySprite,animFun.animName);
                  sequencer = new SerialSequencer();
                  playAnimStep.timeout = this._specialAnimFunMaxAnimDuration;
                  playAnimStep.startFrame = pStartFrame;
                  sequencer.addStep(playAnimStep);
                  subAnimSequencer.push(sequencer);
               }
            }
         }
         return subAnimSequencer;
      }
      
      private function onAnimFunEnd(pEvent:SequencerEvent) : void
      {
         this._animFunPlaying = false;
         this._animFunEntityId = 0;
         this._specialAnimFunMaxAnimDuration = 0;
      }
      
      private function getEntityByGenericId(id:int) : GameContextActorInformations
      {
         var entity:GameContextActorInformations = null;
         var entitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var entities:Dictionary = entitiesFrame.entities;
         for each(entity in entities)
         {
            if(entity is GameRolePlayNpcInformations)
            {
               if((entity as GameRolePlayNpcInformations).npcId == id)
               {
                  return entity;
               }
            }
         }
         return null;
      }
      
      private function randomActor(monsterSeed:int) : int
      {
         var rnd:int = 0;
         if(this._entitiesList.length)
         {
            rnd = monsterSeed % this._entitiesList.length;
            return this._entitiesList[rnd].contextualId;
         }
         return 0;
      }
      
      private function randomAnim(actorId:Number, animSeed:int) : AnimFunData
      {
         var list:Object = null;
         var groupMonsterInfo:GameRolePlayGroupMonsterInformations = null;
         var monster:Monster = null;
         var npcInfo:GameRolePlayNpcInformations = null;
         var npc:Npc = null;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(!roleplayEntitiesFrame)
         {
            return null;
         }
         var entity:GameContextActorInformations = roleplayEntitiesFrame.getEntityInfos(actorId);
         if(entity is GameRolePlayGroupMonsterInformations)
         {
            groupMonsterInfo = entity as GameRolePlayGroupMonsterInformations;
            monster = Monster.getMonsterById(groupMonsterInfo.staticInfos.mainCreatureLightInfos.genericId);
            if(!monster)
            {
               return null;
            }
            list = monster.animFunList;
         }
         else
         {
            if(!(entity is GameRolePlayNpcInformations))
            {
               return null;
            }
            npcInfo = entity as GameRolePlayNpcInformations;
            npc = Npc.getNpcById(npcInfo.npcId);
            if(!npc)
            {
               return null;
            }
            list = npc.animFunList;
         }
         var animIndex:int = 0;
         var max:int = 0;
         var num:int = list.length;
         for(var i:int = 0; i < num; i++)
         {
            max += list[i].animWeight;
         }
         var rand:Number = animSeed % max;
         max = 0;
         for(i = 0; i < num; i++)
         {
            max += list[i].animWeight;
            if(max > rand)
            {
               return list[i];
            }
         }
         return null;
      }
      
      private function getIsMapStatic() : Boolean
      {
         var entity:GameContextActorInformations = null;
         var sprite:AnimatedCharacter = null;
         var entitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var entities:Dictionary = entitiesFrame.entities;
         var monsters:Array = new Array();
         for each(entity in entities)
         {
            sprite = DofusEntities.getEntity(entity.contextualId) as AnimatedCharacter;
            if(sprite && sprite.isMoving)
            {
               return false;
            }
         }
         return true;
      }
      
      private function synchCurrentAnim(pNextAnimFun:AnimFun, pElapsedTime:int) : void
      {
         var i:int = 0;
         var af:AnimFun = null;
         var previousAf:AnimFun = null;
         var entitySpr:TiphonSprite = null;
         var callback:Callback = null;
         var swlLoaded:* = false;
         var nextAnimIndex:int = this._anims.indexOf(pNextAnimFun);
         var nbAnims:int = this._anims.length;
         for(i = nbAnims - 1; i >= 0; i--)
         {
            if(this._anims[i].fastAnim == pNextAnimFun.fastAnim && i < nextAnimIndex)
            {
               previousAf = this._anims[i];
               break;
            }
         }
         if(!this._firstAnim || previousAf == this._cancelledAnim)
         {
            previousAf = null;
         }
         this._cancelledAnim = null;
         af = pNextAnimFun;
         if(af)
         {
            entitySpr = DofusEntities.getEntity(af.actorId) as TiphonSprite;
            Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            swlLoaded = Tiphon.skullLibrary.getResourceById(entitySpr.look.getBone(),af.animName,true) != null;
            if(swlLoaded && (!previousAf || Tiphon.skullLibrary.getResourceById((DofusEntities.getEntity(previousAf.actorId) as TiphonSprite).look.getBone(),previousAf.animName,true) != null))
            {
               this.playSynchAnim(new AnimFunInfo(af,previousAf,pElapsedTime));
            }
            else
            {
               this._synchedAnimFuns[entitySpr] = new AnimFunInfo(af,previousAf,pElapsedTime,this.getTimerValue());
               Tiphon.skullLibrary.addEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            }
         }
      }
      
      private function onSwlLoaded(pEvent:SwlEvent) : void
      {
         var animFunInfo:AnimFunInfo = null;
         var entitySpr:TiphonSprite = DofusEntities.getEntity(this._lastAnim.actorId) as TiphonSprite;
         var hasClass:Boolean = Tiphon.skullLibrary.isLoaded(entitySpr.look.getBone(),this._lastAnim.animName);
         if(hasClass)
         {
            Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            animFunInfo = this._synchedAnimFuns[entitySpr] as AnimFunInfo;
            if(!animFunInfo.previousAnimFun || Tiphon.skullLibrary.getResourceById((DofusEntities.getEntity(animFunInfo.previousAnimFun.actorId) as TiphonSprite).look.getBone(),animFunInfo.previousAnimFun.animName,true) != null)
            {
               if(animFunInfo.previousAnimLoadTime > 0)
               {
                  animFunInfo.loadTime += this.getTimerValue() - animFunInfo.previousAnimLoadTime;
               }
               this.playSynchAnim(animFunInfo);
               delete this._synchedAnimFuns[entitySpr];
            }
            else
            {
               if(animFunInfo.previousAnimFun)
               {
                  animFunInfo.previousAnimLoadTime = this.getTimerValue();
               }
               Tiphon.skullLibrary.addEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            }
         }
      }
      
      private function getAnimSum(pAnimFun:AnimFun) : int
      {
         var i:int = 0;
         var sum:int = 0;
         var nbAnims:int = this._anims.length;
         for(i = 0; i < nbAnims; i++)
         {
            sum += this._anims[i].delayTime;
            if(this._anims[i] == pAnimFun)
            {
               return sum;
            }
         }
         return 0;
      }
      
      private function playSynchAnim(pAnimFunInfo:AnimFunInfo) : void
      {
         var animClipInfo:AnimFunClipInfo = null;
         var previousSum:int = 0;
         var currentSum:int = 0;
         var delay:int = pAnimFunInfo.elapsedTime + (pAnimFunInfo.loadTime > 0 ? this.getTimerValue() - pAnimFunInfo.loadTime : 0);
         var previousAnimInfo:AnimFunClipInfo = !!pAnimFunInfo.previousAnimFun ? this.getAnimClipInfo(pAnimFunInfo.previousAnimFun) : null;
         var animFun:AnimFun = pAnimFunInfo.animFun;
         if(previousAnimInfo)
         {
            previousSum = this.getAnimSum(pAnimFunInfo.previousAnimFun);
            currentSum = this.getAnimSum(pAnimFunInfo.animFun);
            if(previousSum + previousAnimInfo.duration > currentSum + delay)
            {
               animClipInfo = previousAnimInfo;
               delay = previousAnimInfo.duration - (previousSum + previousAnimInfo.duration - currentSum + delay);
               animFun = pAnimFunInfo.previousAnimFun;
               this._lastAnim = animFun;
            }
            else
            {
               animClipInfo = this.getAnimClipInfo(pAnimFunInfo.animFun);
            }
         }
         else
         {
            animClipInfo = this.getAnimClipInfo(pAnimFunInfo.animFun);
         }
         if(animClipInfo)
         {
            if(!this._firstAnim || this._firstAnim && delay < animClipInfo.duration)
            {
               this.playAnimFun(animFun,0);
            }
            else
            {
               this._firstAnim = false;
               this._animFunPlaying = false;
               this._animFunEntityId = 0;
            }
         }
         else
         {
            this._firstAnim = false;
            this._animFunPlaying = false;
            this._animFunEntityId = 0;
         }
      }
      
      private function getAnimClipInfo(pAnimFun:AnimFun) : AnimFunClipInfo
      {
         var animClass:Class = null;
         var s:* = null;
         var clip:TiphonAnimation = null;
         var entitySpr:TiphonSprite = DofusEntities.getEntity(pAnimFun.actorId) as TiphonSprite;
         var swl:Swl = Tiphon.skullLibrary.getResourceById(entitySpr.look.getBone(),pAnimFun.animName);
         var directions:Array = entitySpr.getAvaibleDirection(pAnimFun.animName,true);
         var finalDirection:uint = entitySpr.getDirection();
         if(!directions[finalDirection])
         {
            for(s in directions)
            {
               if(directions[s])
               {
                  finalDirection = uint(s);
                  break;
               }
            }
         }
         var className:String = pAnimFun.animName + "_" + finalDirection;
         if(swl.hasDefinition(className))
         {
            animClass = swl.getDefinition(className) as Class;
         }
         else
         {
            className = pAnimFun.animName + "_" + TiphonUtility.getFlipDirection(finalDirection);
            if(swl.hasDefinition(className))
            {
               animClass = swl.getDefinition(className) as Class;
            }
         }
         if(animClass)
         {
            clip = new animClass() as TiphonAnimation;
            clip.stop();
            return new AnimFunClipInfo(clip.totalFrames / swl.frameRate * 1000,clip.totalFrames);
         }
         return null;
      }
      
      private function hasFastAnims(pActorId:Number) : Boolean
      {
         var monster:Monster = null;
         var npc:Npc = null;
         var actorInfos:GameContextActorInformations = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(pActorId);
         if(actorInfos is GameRolePlayGroupMonsterInformations)
         {
            monster = Monster.getMonsterById((actorInfos as GameRolePlayGroupMonsterInformations).staticInfos.mainCreatureLightInfos.genericId);
            return monster.fastAnimsFun;
         }
         if(actorInfos is GameRolePlayNpcInformations)
         {
            npc = Npc.getNpcById((actorInfos as GameRolePlayNpcInformations).npcId);
            return npc.fastAnimsFun;
         }
         return false;
      }
      
      private function hasAnimsFun(pActorId:Number) : Boolean
      {
         var monster:Monster = null;
         var npc:Npc = null;
         var actorInfos:GameContextActorInformations = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(pActorId);
         if(actorInfos is GameRolePlayGroupMonsterInformations)
         {
            monster = Monster.getMonsterById((actorInfos as GameRolePlayGroupMonsterInformations).staticInfos.mainCreatureLightInfos.genericId);
            return monster && monster.animFunList.length != 0;
         }
         if(actorInfos is GameRolePlayNpcInformations)
         {
            npc = Npc.getNpcById((actorInfos as GameRolePlayNpcInformations).npcId);
            return npc && npc.animFunList.length != 0;
         }
         return false;
      }
   }
}

import com.ankamagames.dofus.logic.game.roleplay.types.AnimFun;

class AnimFunInfo
{
    
   
   public var animFun:AnimFun;
   
   public var previousAnimFun:AnimFun;
   
   public var elapsedTime:int;
   
   public var loadTime:int;
   
   public var previousAnimLoadTime:int;
   
   function AnimFunInfo(pAnimFun:AnimFun, pPreviousAnimFun:AnimFun, pElapsedTime:int, pLoadTime:int = 0)
   {
      super();
      this.animFun = pAnimFun;
      this.previousAnimFun = pPreviousAnimFun;
      this.elapsedTime = pElapsedTime;
      this.loadTime = pLoadTime;
   }
}

class AnimFunClipInfo
{
    
   
   public var duration:int;
   
   public var totalFrames:int;
   
   function AnimFunClipInfo(pDuration:int, pTotalFrames:int)
   {
      super();
      this.duration = pDuration;
      this.totalFrames = pTotalFrames;
   }
}
