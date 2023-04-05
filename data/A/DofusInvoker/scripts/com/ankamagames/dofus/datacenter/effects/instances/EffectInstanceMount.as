package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceMount extends EffectInstance implements IDataCenter
   {
       
      
      public var id:Number;
      
      public var expirationDate:Number;
      
      public var model:uint;
      
      public var name:String = "";
      
      public var owner:String = "";
      
      public var level:uint = 0;
      
      public var sex:Boolean = false;
      
      public var isRideable:Boolean = false;
      
      public var isFeconded:Boolean = false;
      
      public var isFecondationReady:Boolean = false;
      
      public var reproductionCount:int = 0;
      
      public var reproductionCountMax:uint = 0;
      
      public var effects:Vector.<EffectInstanceInteger>;
      
      public var capacities:Vector.<uint>;
      
      public function EffectInstanceMount()
      {
         this.effects = new Vector.<EffectInstanceInteger>();
         this.capacities = new Vector.<uint>();
         super();
      }
      
      override public function clone() : EffectInstance
      {
         var o:EffectInstanceMount = new EffectInstanceMount();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.duration = duration;
         o.delay = delay;
         o.random = random;
         o.group = group;
         o.targetId = targetId;
         o.targetMask = targetMask;
         o.id = this.id;
         o.expirationDate = this.expirationDate;
         o.model = this.model;
         o.name = this.name;
         o.owner = this.owner;
         o.level = this.level;
         o.sex = this.sex;
         o.isRideable = this.isRideable;
         o.isFeconded = this.isFeconded;
         o.isFecondationReady = this.isFecondationReady;
         o.reproductionCount = this.reproductionCount;
         o.reproductionCountMax = this.reproductionCountMax;
         o.effects = this.effects;
         o.capacities = this.capacities;
         return o;
      }
      
      override public function get parameter0() : Object
      {
         return this.id;
      }
      
      override public function get parameter1() : Object
      {
         return this.expirationDate;
      }
      
      override public function get parameter2() : Object
      {
         return this.model;
      }
      
      override public function get parameter3() : Object
      {
         return this.name;
      }
      
      override public function get parameter4() : Object
      {
         return this.owner;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void
      {
         switch(paramIndex)
         {
            case 0:
               this.id = Number(value);
               break;
            case 1:
               this.expirationDate = Number(value);
               break;
            case 2:
               this.model = uint(value);
               break;
            case 3:
               this.name = String(value);
               break;
            case 4:
               this.owner = String(value);
         }
      }
   }
}
