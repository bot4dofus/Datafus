package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceDice extends EffectInstanceInteger implements IDataCenter
   {
       
      
      public var diceNum:uint;
      
      public var diceSide:uint;
      
      public function EffectInstanceDice()
      {
         super();
      }
      
      override public function clone() : EffectInstance
      {
         var o:EffectInstanceDice = new EffectInstanceDice();
         o.rawZone = rawZone;
         o.effectUid = effectUid;
         o.effectId = effectId;
         o.baseEffectId = baseEffectId;
         o.order = order;
         o.duration = duration;
         o.delay = delay;
         o.diceNum = this.diceNum;
         o.diceSide = this.diceSide;
         o.value = value;
         o.random = random;
         o.group = group;
         o.visibleInTooltip = visibleInTooltip;
         o.visibleInBuffUi = visibleInBuffUi;
         o.visibleInFightLog = visibleInFightLog;
         o.visibleOnTerrain = visibleOnTerrain;
         o.targetId = targetId;
         o.targetMask = targetMask;
         o.delay = delay;
         o.triggers = triggers;
         o.effectElement = effectElement;
         o.spellId = spellId;
         o.forClientOnly = forClientOnly;
         o.dispellable = dispellable;
         return o;
      }
      
      override public function get parameter0() : Object
      {
         return this.diceNum != 0 ? this.diceNum : null;
      }
      
      override public function get parameter1() : Object
      {
         return this.diceSide != 0 ? this.diceSide : null;
      }
      
      override public function get parameter2() : Object
      {
         return value != 0 ? value : null;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void
      {
         switch(paramIndex)
         {
            case 0:
               this.diceNum = uint(value);
               break;
            case 1:
               this.diceSide = uint(value);
               break;
            case 2:
               this.value = int(value);
         }
      }
      
      override public function add(term:*) : EffectInstance
      {
         if(term is EffectInstanceDice)
         {
            if(this.diceSide == 0)
            {
               this.diceSide = this.diceNum;
            }
            this.diceNum += term.diceNum;
            this.diceSide += term.diceSide != 0 ? term.diceSide : term.diceNum;
            if(this.diceNum == this.diceSide)
            {
               this.diceSide = 0;
            }
            forceDescriptionRefresh();
         }
         else if(term is EffectInstanceInteger)
         {
            this.diceNum += term.value;
            this.diceSide = this.diceSide != 0 ? uint(this.diceSide + term.value) : uint(0);
            forceDescriptionRefresh();
         }
         else
         {
            _log.error(term + " cannot be added to EffectInstanceDice.");
         }
         return this;
      }
   }
}
