package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceMinMax extends EffectInstance implements IDataCenter
   {
       
      
      public var min:uint;
      
      public var max:uint;
      
      public function EffectInstanceMinMax()
      {
         super();
      }
      
      override public function clone() : EffectInstance
      {
         var o:EffectInstanceMinMax = new EffectInstanceMinMax();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.duration = duration;
         o.delay = delay;
         o.min = this.min;
         o.max = this.max;
         o.random = random;
         o.group = group;
         o.targetId = targetId;
         o.targetMask = targetMask;
         return o;
      }
      
      override public function get parameter0() : Object
      {
         return this.min;
      }
      
      override public function get parameter1() : Object
      {
         return this.min != this.max ? this.max : null;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void
      {
         switch(paramIndex)
         {
            case 0:
               this.min = uint(value);
               break;
            case 1:
               this.max = uint(value);
         }
      }
   }
}
