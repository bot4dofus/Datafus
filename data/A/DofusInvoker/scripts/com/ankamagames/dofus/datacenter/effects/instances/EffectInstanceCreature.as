package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceCreature extends EffectInstance implements IDataCenter
   {
       
      
      public var monsterFamilyId:uint;
      
      public function EffectInstanceCreature()
      {
         super();
      }
      
      override public function clone() : EffectInstance
      {
         var o:EffectInstanceCreature = new EffectInstanceCreature();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.duration = duration;
         o.delay = delay;
         o.monsterFamilyId = this.monsterFamilyId;
         o.random = random;
         o.group = group;
         o.targetId = targetId;
         o.targetMask = targetMask;
         return o;
      }
      
      override public function get parameter0() : Object
      {
         return this.monsterFamilyId;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void
      {
         if(paramIndex == 0)
         {
            this.monsterFamilyId = uint(value);
         }
      }
   }
}
