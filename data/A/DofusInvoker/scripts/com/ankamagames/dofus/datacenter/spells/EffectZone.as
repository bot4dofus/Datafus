package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectZone implements IDataCenter
   {
      
      private static const _activationEffect:EffectInstance = new EffectInstance();
       
      
      private var _rawDisplayZone:String = null;
      
      private var _rawActivationZone:String = null;
      
      public var id:uint;
      
      public var isDefaultPreviewZoneHidden:Boolean = false;
      
      public var casterMask:String = null;
      
      public var activationMask:String = null;
      
      private var _activationZoneSize:uint;
      
      private var _activationZoneShape:uint;
      
      private var _activationZoneMinSize:uint;
      
      private var _activationZoneEfficiencyPercent:uint;
      
      private var _activationZoneMaxEfficiency:uint;
      
      private var _activationZoneStopAtTarget:uint;
      
      private var _displayEffect:EffectInstance = null;
      
      private var _displayZoneSize:uint;
      
      private var _displayZoneShape:uint;
      
      private var _displayZoneMinSize:uint;
      
      private var _displayZoneEfficiencyPercent:uint;
      
      private var _displayZoneMaxEfficiency:uint;
      
      private var _displayZoneStopAtTarget:uint;
      
      public function EffectZone()
      {
         super();
      }
      
      public function get rawDisplayZone() : String
      {
         return this._rawDisplayZone;
      }
      
      public function get rawActivationZone() : String
      {
         return this._rawActivationZone;
      }
      
      public function set rawDisplayZone(rawDisplayZone:String) : void
      {
         this._rawDisplayZone = rawDisplayZone;
         if(this._rawDisplayZone !== null)
         {
            this._displayEffect = new EffectInstance();
            this._displayEffect.rawZone = rawDisplayZone;
            this._displayZoneSize = uint(this._displayEffect.zoneSize);
            this._displayZoneShape = this._displayEffect.zoneShape;
            this._displayZoneMinSize = uint(this._displayEffect.zoneMinSize);
            this._displayZoneEfficiencyPercent = uint(this._displayEffect.zoneEfficiencyPercent);
            this._displayZoneMaxEfficiency = uint(this._displayEffect.zoneMaxEfficiency);
            this._displayZoneStopAtTarget = uint(this._displayEffect.zoneStopAtTarget);
         }
      }
      
      public function set rawActivationZone(rawActivationZone:String) : void
      {
         this._rawActivationZone = rawActivationZone;
         if(this._rawActivationZone !== null)
         {
            _activationEffect.rawZone = this._rawActivationZone;
            this._activationZoneSize = uint(_activationEffect.zoneSize);
            this._activationZoneShape = _activationEffect.zoneShape;
            this._activationZoneMinSize = uint(_activationEffect.zoneMinSize);
            this._activationZoneEfficiencyPercent = uint(_activationEffect.zoneEfficiencyPercent);
            this._activationZoneMaxEfficiency = uint(_activationEffect.zoneMaxEfficiency);
            this._activationZoneStopAtTarget = uint(_activationEffect.zoneStopAtTarget);
         }
      }
      
      public function get isDisplayZone() : Boolean
      {
         return this._displayEffect !== null;
      }
      
      public function get activationZoneSize() : uint
      {
         return this._activationZoneSize;
      }
      
      public function get activationZoneShape() : uint
      {
         return this._activationZoneShape;
      }
      
      public function get activationZoneMinSize() : uint
      {
         return this._activationZoneMinSize;
      }
      
      public function get activationZoneEfficiencyPercent() : uint
      {
         return this._activationZoneEfficiencyPercent;
      }
      
      public function get activationZoneMaxEfficiency() : uint
      {
         return this._activationZoneMaxEfficiency;
      }
      
      public function get activationZoneStopAtTarget() : uint
      {
         return this._activationZoneStopAtTarget;
      }
      
      public function get displayZoneSize() : uint
      {
         return this._displayZoneSize;
      }
      
      public function get displayZoneShape() : uint
      {
         return this._displayZoneShape;
      }
      
      public function get displayZoneMinSize() : uint
      {
         return this._displayZoneMinSize;
      }
      
      public function get displayZoneEfficiencyPercent() : uint
      {
         return this._displayZoneEfficiencyPercent;
      }
      
      public function get displayZoneMaxEfficiency() : uint
      {
         return this._displayZoneMaxEfficiency;
      }
      
      public function get displayZoneStopAtTarget() : uint
      {
         return this._displayZoneStopAtTarget;
      }
      
      public function set displayZoneMinSize(displayZoneMinSize:uint) : void
      {
         this._displayZoneMinSize = displayZoneMinSize;
      }
   }
}
