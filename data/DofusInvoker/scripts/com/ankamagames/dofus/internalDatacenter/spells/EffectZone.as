package com.ankamagames.dofus.internalDatacenter.spells
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   
   public class EffectZone
   {
      
      private static const _effect:EffectInstance = new EffectInstance();
       
      
      public var zoneSize:Object;
      
      public var zoneShape:uint;
      
      public var zoneMinSize:Object;
      
      public var zoneEfficiencyPercent:Object;
      
      public var zoneMaxEfficiency:Object;
      
      public var zoneStopAtTarget:Object;
      
      private var _targetMask:String;
      
      public function EffectZone(rawZone:String, targetMask:String)
      {
         super();
         _effect.rawZone = rawZone;
         this.zoneSize = _effect.zoneSize;
         this.zoneShape = _effect.zoneShape;
         this.zoneMinSize = _effect.zoneMinSize;
         this.zoneEfficiencyPercent = _effect.zoneEfficiencyPercent;
         this.zoneMaxEfficiency = _effect.zoneMaxEfficiency;
         this.zoneStopAtTarget = _effect.zoneStopAtTarget;
         this._targetMask = targetMask;
      }
      
      public function get targetMask() : String
      {
         return this._targetMask;
      }
   }
}
