package damageCalculation.spellManagement
{
   import damageCalculation.damageManagement.EffectOutput;
   import damageCalculation.fighterManagement.HaxeFighter;
   
   public class RunningEffect
   {
       
      
      public var triggeringOutput:EffectOutput;
      
      public var triggeringFighter:HaxeFighter;
      
      public var probability:Number;
      
      public var isTriggered:Boolean;
      
      public var isReflect:Boolean;
      
      public var forceCritical:Boolean;
      
      public var _spellEffect:HaxeSpellEffect;
      
      public var _spell:HaxeSpell;
      
      public var _parentEffect:RunningEffect;
      
      public var _caster:HaxeFighter;
      
      public var _canAlwaysTriggerSpells:Boolean;
      
      public function RunningEffect(param1:HaxeFighter, param2:HaxeSpell, param3:HaxeSpellEffect, param4:Number = 0, param5:Boolean = true)
      {
         forceCritical = false;
         isTriggered = false;
         isReflect = false;
         probability = 0;
         triggeringOutput = null;
         triggeringFighter = null;
         _parentEffect = null;
         _spell = param2;
         _spellEffect = param3;
         _caster = param1;
         _canAlwaysTriggerSpells = param5;
         probability = param4;
      }
      
      public function triggeredByEffectSetting(param1:RunningEffect) : void
      {
         _parentEffect = param1;
         triggeringFighter = param1.getCaster();
      }
      
      public function setParentEffect(param1:RunningEffect) : void
      {
         _parentEffect = param1;
         if(triggeringFighter == null && _parentEffect != null)
         {
            triggeringFighter = _parentEffect.triggeringFighter;
         }
      }
      
      public function overrideSpellEffect(param1:HaxeSpellEffect) : void
      {
         _spellEffect = param1;
      }
      
      public function overrideCaster(param1:HaxeFighter) : void
      {
         _caster = param1;
      }
      
      public function isTargetingAnAncestor(param1:HaxeFighter) : Boolean
      {
         var _loc2_:RunningEffect = this;
         while(_loc2_ != null)
         {
            if(_loc2_.getCaster().id == param1.id)
            {
               return true;
            }
            _loc2_ = _loc2_.getParentEffect();
         }
         return false;
      }
      
      public function getSpellEffect() : HaxeSpellEffect
      {
         return _spellEffect;
      }
      
      public function getSpell() : HaxeSpell
      {
         return _spell;
      }
      
      public function getParentEffect() : RunningEffect
      {
         return _parentEffect;
      }
      
      public function getFirstParentEffect() : RunningEffect
      {
         var _loc1_:RunningEffect = this;
         while(_loc1_._parentEffect != null)
         {
            _loc1_ = _loc1_._parentEffect;
         }
         return _loc1_;
      }
      
      public function getCaster() : HaxeFighter
      {
         return _caster;
      }
      
      public function copy() : RunningEffect
      {
         var _loc1_:RunningEffect = new RunningEffect(_caster,_spell,_spellEffect,probability,_canAlwaysTriggerSpells);
         _loc1_.setParentEffect(this);
         _loc1_.triggeringOutput = triggeringOutput;
         _loc1_.forceCritical = forceCritical;
         _loc1_.isTriggered = isTriggered;
         _loc1_.isReflect = isReflect;
         _loc1_.triggeringFighter = triggeringFighter;
         return _loc1_;
      }
      
      public function canAlwaysTriggerSpells() : Boolean
      {
         return _canAlwaysTriggerSpells;
      }
   }
}
