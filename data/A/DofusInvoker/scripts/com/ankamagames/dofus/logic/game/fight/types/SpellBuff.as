package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellBoostEffect;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class SpellBuff extends BasicBuff
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellBuff));
       
      
      public var spellId:int;
      
      public var delta:int;
      
      public var modifType:int;
      
      public function SpellBuff(effect:FightTemporarySpellBoostEffect = null, castingSpell:SpellCastSequenceContext = null, actionId:int = 0)
      {
         if(effect)
         {
            super(effect,castingSpell,actionId,effect.boostedSpellId,null,effect.delta);
            this.spellId = effect.boostedSpellId;
            this.delta = effect.delta;
         }
      }
      
      override public function get type() : String
      {
         return "SpellBuff";
      }
      
      override public function clone(id:int = 0) : BasicBuff
      {
         var sb:SpellBuff = new SpellBuff();
         sb.spellId = this.spellId;
         sb.delta = this.delta;
         sb.modifType = this.modifType;
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
