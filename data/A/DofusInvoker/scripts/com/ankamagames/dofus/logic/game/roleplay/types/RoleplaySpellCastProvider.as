package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   
   public class RoleplaySpellCastProvider implements ISpellCastProvider
   {
       
      
      private var _stepsBuffer:Vector.<ISequencable>;
      
      private var _castingSpell:CastingSpell;
      
      public function RoleplaySpellCastProvider()
      {
         super();
         this._stepsBuffer = new Vector.<ISequencable>();
         this._castingSpell = new CastingSpell();
      }
      
      public function get castingSpell() : CastingSpell
      {
         return this._castingSpell;
      }
      
      public function get stepsBuffer() : Vector.<ISequencable>
      {
         return this._stepsBuffer;
      }
   }
}
