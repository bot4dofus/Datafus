package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   import tools.ActionIdHelper;
   
   public class StatBuff extends BasicBuff
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StatBuff));
       
      
      private var _statName:String;
      
      private var _isABoost:Boolean;
      
      public var isRecent:Boolean;
      
      public function StatBuff(effect:FightTemporaryBoostEffect = null, castingSpell:CastingSpell = null, actionId:int = 0, isRecent:Boolean = false)
      {
         if(effect)
         {
            super(effect,castingSpell,actionId,effect.delta,null,null);
            this._statName = ActionIdHelper.getActionIdStatName(actionId);
            this._isABoost = ActionIdHelper.isBuff(actionId);
            this.isRecent = isRecent;
         }
      }
      
      override public function get type() : String
      {
         return "StatBuff";
      }
      
      public function get statName() : String
      {
         return this._statName;
      }
      
      public function get delta() : int
      {
         if(_effect is EffectInstanceDice)
         {
            return !!this._isABoost ? int(EffectInstanceDice(_effect).diceNum) : int(-EffectInstanceDice(_effect).diceNum);
         }
         return 0;
      }
      
      override public function onReenable() : void
      {
         super.onReenable();
         var effect:Effect = Effect.getEffectById(actionId);
         if(effect !== null && effect.active)
         {
            onApplied();
         }
      }
      
      override public function clone(id:int = 0) : BasicBuff
      {
         var sb:StatBuff = new StatBuff();
         sb._statName = this._statName;
         sb._isABoost = this._isABoost;
         sb.id = uid;
         sb.uid = uid;
         sb.dataUid = dataUid;
         sb.actionId = actionId;
         sb.targetId = targetId;
         sb.castingSpell = castingSpell;
         sb.duration = duration;
         sb.dispelable = dispelable;
         sb.source = source;
         sb.aliveSource = aliveSource;
         sb.sourceJustReaffected = sourceJustReaffected;
         sb.parentBoostUid = parentBoostUid;
         sb.initParam(param1,param2,param3);
         return sb;
      }
   }
}
