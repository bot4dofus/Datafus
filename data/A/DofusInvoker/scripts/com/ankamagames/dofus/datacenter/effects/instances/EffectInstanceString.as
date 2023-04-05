package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceString extends EffectInstance implements IDataCenter
   {
       
      
      public var text:String;
      
      public function EffectInstanceString()
      {
         super();
      }
      
      override public function clone() : EffectInstance
      {
         var o:EffectInstanceString = new EffectInstanceString();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.duration = duration;
         o.delay = delay;
         o.text = this.text;
         o.random = random;
         o.group = group;
         o.targetId = targetId;
         o.targetMask = targetMask;
         return o;
      }
      
      override public function get parameter3() : Object
      {
         return this.text;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void
      {
         if(paramIndex == 3)
         {
            this.text = String(value);
         }
      }
   }
}
