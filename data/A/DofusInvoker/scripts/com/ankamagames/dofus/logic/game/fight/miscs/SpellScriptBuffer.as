package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   
   public class SpellScriptBuffer implements ISpellCastProvider
   {
       
      
      private var _steps:Vector.<ISequencable>;
      
      private var _castingSpell:CastingSpell;
      
      public function SpellScriptBuffer(__castingSpell:CastingSpell)
      {
         this._steps = new Vector.<ISequencable>();
         super();
         this._castingSpell = __castingSpell;
      }
      
      public function get castingSpell() : CastingSpell
      {
         return this._castingSpell;
      }
      
      public function get stepsBuffer() : Vector.<ISequencable>
      {
         return this._steps;
      }
   }
}
