package com.ankamagames.dofus.scripts
{
   import com.ankamagames.dofus.datacenter.spells.SpellScript;
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastSequence;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.dofus.scripts.spells.SpellScriptBase;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.script.ScriptErrorEnum;
   import com.ankamagames.jerakine.script.runners.IRunner;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import flash.utils.getQualifiedClassName;
   
   public class SpellScriptRunner implements IRunner
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellScriptRunner));
       
      
      private var _caster:IEntity;
      
      private var _targetedCellId:int;
      
      private var _scriptData:SpellScript;
      
      private var _castSequence:ISpellCastSequence;
      
      public function SpellScriptRunner(caster:IEntity, scriptId:int, targetedCellId:int, castSequence:ISpellCastSequence)
      {
         super();
         this._caster = caster;
         this._targetedCellId = targetedCellId;
         this._castSequence = castSequence;
         this._scriptData = SpellScript.getSpellScriptById(scriptId);
      }
      
      public function get caster() : IEntity
      {
         return this._caster;
      }
      
      public function get targetedCellId() : int
      {
         return this._targetedCellId;
      }
      
      public function get scriptData() : SpellScript
      {
         return this._scriptData;
      }
      
      public function get castSequenceContext() : SpellCastSequenceContext
      {
         return this._castSequence.context;
      }
      
      public function get steps() : Vector.<ISequencable>
      {
         return this._castSequence.steps;
      }
      
      public function run(spellScriptClass:Class) : uint
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
