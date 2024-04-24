package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   
   public class SpellCastSequence implements ISpellCastSequence
   {
       
      
      private var _context:SpellCastSequenceContext;
      
      private var _steps:Vector.<ISequencable>;
      
      public function SpellCastSequence(context:SpellCastSequenceContext, steps:Vector.<ISequencable> = null)
      {
         super();
         this._context = context;
         this._steps = steps !== null ? steps : new Vector.<ISequencable>();
      }
      
      public function get context() : SpellCastSequenceContext
      {
         return this._context;
      }
      
      public function set context(context:SpellCastSequenceContext) : void
      {
         this._context = context;
      }
      
      public function get steps() : Vector.<ISequencable>
      {
         return this._steps;
      }
      
      public function set steps(steps:Vector.<ISequencable>) : void
      {
         this._steps = steps;
      }
   }
}
