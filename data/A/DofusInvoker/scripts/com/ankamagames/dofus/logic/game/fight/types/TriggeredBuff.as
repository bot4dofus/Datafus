package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTriggeredEffect;
   
   public class TriggeredBuff extends BasicBuff
   {
       
      
      public var delay:int;
      
      public var triggerCount:uint;
      
      public function TriggeredBuff(effect:FightTriggeredEffect = null, castingSpell:SpellCastSequenceContext = null, actionId:uint = 0)
      {
         if(effect)
         {
            super(effect,castingSpell,actionId,effect.param1,effect.param2,effect.param3);
            this.initParam(effect.param1,effect.param2,effect.param3);
            this.delay = effect.delay;
            _effect.delay = this.delay;
            this.triggerCount = 0;
         }
      }
      
      override public function get param1() : *
      {
         return _effect.parameter0;
      }
      
      override public function get param2() : *
      {
         return _effect.parameter1;
      }
      
      override public function get param3() : *
      {
         return _effect.parameter2;
      }
      
      override public function initParam(p1:int, p2:int, p3:int) : void
      {
         var min:int = 0;
         var max:int = 0;
         super.initParam(p1,p2,p3);
         var e:Effect = Effect.getEffectById(actionId);
         if(e && e.forceMinMax && _effect is EffectInstanceDice)
         {
            min = p3 + p1;
            max = p1 * p2 + p3;
            if(min == max)
            {
               param1 = min;
               param2 = param3 = 0;
            }
            else if(min > max)
            {
               param1 = max;
               param2 = min;
               param3 = 0;
            }
            else
            {
               param1 = min;
               param2 = max;
               param3 = 0;
            }
         }
      }
      
      override public function clone(id:int = 0) : BasicBuff
      {
         var tb:TriggeredBuff = new TriggeredBuff();
         tb.id = uid;
         tb.uid = uid;
         tb.dataUid = dataUid;
         tb.actionId = actionId;
         tb.targetId = targetId;
         tb.castingSpell = castingSpell;
         tb.duration = duration;
         tb.dispelable = dispelable;
         tb.source = source;
         tb.aliveSource = aliveSource;
         tb.sourceJustReaffected = sourceJustReaffected;
         tb.parentBoostUid = parentBoostUid;
         tb.initParam(this.param1,this.param2,this.param3);
         tb.delay = this.delay;
         tb._effect.delay = this.delay;
         return tb;
      }
      
      override public function get active() : Boolean
      {
         return this.delay > 0 || super.active;
      }
      
      override public function get trigger() : Boolean
      {
         return true;
      }
      
      override public function incrementDuration(delta:int, dispellEffect:Boolean = false) : Boolean
      {
         if(this.delay > 0 && !dispellEffect)
         {
            if(this.delay + delta >= 0)
            {
               --this.delay;
               --effect.delay;
            }
            else
            {
               delta += this.delay;
               this.delay = 0;
               effect.delay = 0;
            }
         }
         if(delta != 0)
         {
            return super.incrementDuration(delta,dispellEffect);
         }
         return true;
      }
      
      override public function get unusableNextTurn() : Boolean
      {
         return this.delay <= 1 && super.unusableNextTurn;
      }
   }
}
