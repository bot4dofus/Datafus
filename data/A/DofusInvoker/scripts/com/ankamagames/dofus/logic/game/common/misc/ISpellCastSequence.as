package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   
   public interface ISpellCastSequence
   {
       
      
      function set context(param1:SpellCastSequenceContext) : void;
      
      function get context() : SpellCastSequenceContext;
      
      function set steps(param1:Vector.<ISequencable>) : void;
      
      function get steps() : Vector.<ISequencable>;
   }
}
