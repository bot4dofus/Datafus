package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceDuration extends EffectInstance implements IDataCenter
   {
       
      
      public var days:uint;
      
      public var hours:uint;
      
      public var minutes:uint;
      
      public function EffectInstanceDuration()
      {
         super();
      }
      
      override public function clone() : EffectInstance
      {
         var o:EffectInstanceDuration = new EffectInstanceDuration();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.duration = duration;
         o.delay = delay;
         o.days = this.days;
         o.hours = this.hours;
         o.minutes = this.minutes;
         o.random = random;
         o.group = group;
         o.targetId = targetId;
         o.targetMask = targetMask;
         return o;
      }
      
      override public function get parameter0() : Object
      {
         return this.days;
      }
      
      override public function get parameter1() : Object
      {
         return this.hours;
      }
      
      override public function get parameter2() : Object
      {
         return this.minutes;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void
      {
         switch(paramIndex)
         {
            case 0:
               this.days = uint(value);
               break;
            case 1:
               this.hours = uint(value);
               break;
            case 2:
               this.minutes = uint(value);
         }
      }
   }
}
