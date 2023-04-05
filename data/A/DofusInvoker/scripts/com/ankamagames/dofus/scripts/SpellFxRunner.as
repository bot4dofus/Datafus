package com.ankamagames.dofus.scripts
{
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.dofus.scripts.spells.SpellScriptBase;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.script.ScriptErrorEnum;
   import com.ankamagames.jerakine.script.runners.IRunner;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import flash.utils.getQualifiedClassName;
   
   public class SpellFxRunner extends FxRunner implements IRunner
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellFxRunner));
       
      
      private var _spellCastProvider:ISpellCastProvider;
      
      public function SpellFxRunner(spellCastProvider:ISpellCastProvider)
      {
         super(DofusEntities.getEntity(spellCastProvider.castingSpell.casterId),spellCastProvider.castingSpell.targetedCell);
         this._spellCastProvider = spellCastProvider;
      }
      
      public function get castingSpell() : CastingSpell
      {
         return this._spellCastProvider.castingSpell;
      }
      
      public function get stepsBuffer() : Vector.<ISequencable>
      {
         return this._spellCastProvider.stepsBuffer;
      }
      
      override public function run(spellScriptClass:Class) : uint
      {
         var script:SpellScriptBase = new spellScriptClass(this);
         if(script)
         {
            return ScriptErrorEnum.OK;
         }
         return ScriptErrorEnum.SCRIPT_ERROR;
      }
   }
}
