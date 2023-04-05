package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceInteger extends EffectInstance implements IDataCenter
   {
       
      
      public var value:int;
      
      public function EffectInstanceInteger()
      {
         super();
      }
      
      override public function clone() : EffectInstance
      {
         var o:EffectInstanceInteger = new EffectInstanceInteger();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.order = order;
         o.duration = duration;
         o.delay = delay;
         o.value = this.value;
         o.random = random;
         o.group = group;
         o.visibleInTooltip = visibleInTooltip;
         o.visibleInBuffUi = visibleInBuffUi;
         o.visibleInFightLog = visibleInFightLog;
         o.visibleOnTerrain = visibleOnTerrain;
         o.targetId = targetId;
         o.targetMask = targetMask;
         o.forClientOnly = forClientOnly;
         o.dispellable = dispellable;
         return o;
      }
      
      override public function get parameter0() : Object
      {
         return this.value;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void
      {
         if(paramIndex == 2)
         {
            this.value = int(value);
         }
      }
      
      override public function add(term:*) : EffectInstance
      {
         if(term is EffectInstanceDice)
         {
            return term.add(this);
         }
         if(term is EffectInstanceInteger)
         {
            this.value += term.value;
            forceDescriptionRefresh();
         }
         else
         {
            _log.error(term + " cannot be added to EffectInstanceInteger.");
         }
         return this;
      }
   }
}
