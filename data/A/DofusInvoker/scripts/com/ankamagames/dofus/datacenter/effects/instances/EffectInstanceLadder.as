package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceLadder extends EffectInstanceCreature implements IDataCenter
   {
       
      
      public var monsterCount:uint;
      
      public function EffectInstanceLadder()
      {
         super();
      }
      
      override public function clone() : EffectInstance
      {
         var o:EffectInstanceLadder = new EffectInstanceLadder();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.duration = duration;
         o.delay = delay;
         o.monsterFamilyId = monsterFamilyId;
         o.monsterCount = this.monsterCount;
         o.random = random;
         o.group = group;
         o.targetId = targetId;
         o.targetMask = targetMask;
         return o;
      }
      
      override public function get parameter0() : Object
      {
         return monsterFamilyId;
      }
      
      override public function get parameter2() : Object
      {
         return this.monsterCount;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void
      {
         switch(paramIndex)
         {
            case 0:
               monsterFamilyId = uint(value);
               break;
            case 2:
               this.monsterCount = uint(value);
         }
      }
   }
}
