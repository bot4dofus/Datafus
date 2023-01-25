package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.logic.game.fight.types.FighterStatus;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class FightersStateManager
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(FightersStateManager));
      
      private static var _self:FightersStateManager;
       
      
      private var _entityStates:Dictionary;
      
      public function FightersStateManager()
      {
         this._entityStates = new Dictionary();
         super();
      }
      
      public static function getInstance() : FightersStateManager
      {
         if(!_self)
         {
            _self = new FightersStateManager();
         }
         return _self;
      }
      
      public function addStateOnTarget(targetId:Number, stateId:int, delta:int = 1) : void
      {
         if(!this._entityStates[targetId])
         {
            this._entityStates[targetId] = new Dictionary();
         }
         if(!this._entityStates[targetId][stateId])
         {
            this._entityStates[targetId][stateId] = delta;
         }
         else
         {
            this._entityStates[targetId][stateId] += delta;
         }
      }
      
      public function removeStateOnTarget(targetId:Number, stateId:int, delta:int = 1) : void
      {
         if(!this._entityStates[targetId])
         {
            _log.error("Can\'t find state list for " + targetId + " to remove state");
            return;
         }
         if(this._entityStates[targetId][stateId])
         {
            this._entityStates[targetId][stateId] -= delta;
            if(this._entityStates[targetId][stateId] == 0)
            {
               delete this._entityStates[targetId][stateId];
            }
         }
      }
      
      public function hasState(targetId:Number, stateId:int) : Boolean
      {
         if(!this._entityStates[targetId] || !this._entityStates[targetId][stateId])
         {
            return false;
         }
         return this._entityStates[targetId][stateId] > 0;
      }
      
      public function getStates(targetId:Number) : Array
      {
         var stateId:* = undefined;
         var states:Array = new Array();
         if(!this._entityStates[targetId])
         {
            return states;
         }
         for(stateId in this._entityStates[targetId])
         {
            if(this._entityStates[targetId][stateId] > 0)
            {
               states.push(stateId);
            }
         }
         return states;
      }
      
      public function getStatus(targetId:Number) : FighterStatus
      {
         var stateId:* = undefined;
         var state:SpellState = null;
         var fighterstatus:FighterStatus = new FighterStatus();
         for(stateId in this._entityStates[targetId])
         {
            state = SpellState.getSpellStateById(stateId);
            if(state && this._entityStates[targetId][stateId] > 0)
            {
               if(state.preventsSpellCast)
               {
                  fighterstatus.cantUseSpells = true;
               }
               if(state.preventsFight)
               {
                  fighterstatus.cantUseCloseQuarterAttack = true;
               }
               if(state.cantDealDamage)
               {
                  fighterstatus.cantDealDamage = true;
               }
               if(state.invulnerable)
               {
                  fighterstatus.invulnerable = true;
               }
               if(state.incurable)
               {
                  fighterstatus.incurable = true;
               }
               if(state.cantBeMoved)
               {
                  fighterstatus.cantBeMoved = true;
               }
               if(state.cantBePushed)
               {
                  fighterstatus.cantBePushed = true;
               }
               if(state.cantSwitchPosition)
               {
                  fighterstatus.cantSwitchPosition = true;
               }
               if(state.invulnerableMelee)
               {
                  fighterstatus.invulnerableMelee = true;
               }
               if(state.invulnerableRange)
               {
                  fighterstatus.invulnerableRange = true;
               }
               if(state.cantTackle)
               {
                  fighterstatus.cantTackle = true;
               }
               if(state.cantBeTackled)
               {
                  fighterstatus.cantBeTackled = true;
               }
            }
         }
         return fighterstatus;
      }
      
      public function endFight() : void
      {
         this._entityStates = new Dictionary();
      }
   }
}
