package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastSequence;
   import com.ankamagames.dofus.scripts.SpellScriptContext;
   import com.ankamagames.dofus.scripts.SpellScriptManager;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.Callback;
   
   public class FightPlaySpellScriptStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _casterIds:Vector.<Number>;
      
      public function FightPlaySpellScriptStep(contexts:Vector.<SpellScriptContext>, spellCastSequence:ISpellCastSequence, spellRank:int)
      {
         var context:SpellScriptContext = null;
         super();
         this._casterIds = new Vector.<Number>();
         if(contexts.length === 0)
         {
            return;
         }
         for each(context in contexts)
         {
            this.handleFightContext(context,spellRank,spellCastSequence);
         }
      }
      
      private function handleFightContext(context:SpellScriptContext, spellRank:int, spellCastSequence:ISpellCastSequence) : void
      {
         if(this._casterIds.indexOf(context.casterId) === -1)
         {
            this._casterIds.push(context.casterId);
         }
         var spellData:Spell = Spell.getSpellById(context.spellId);
         var spellLevelData:SpellLevel = spellData !== null ? spellData.getSpellLevel(spellRank) : null;
         if(spellLevelData === null || !spellLevelData.playAnimation)
         {
            return;
         }
         SpellScriptManager.getInstance().run(context,spellCastSequence,new Callback(this.scriptEnd,true),new Callback(this.scriptEnd,false));
      }
      
      override public function start() : void
      {
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return this._casterIds;
      }
      
      public function get stepType() : String
      {
         return "spellCast";
      }
      
      private function scriptEnd(scriptSuccess:Boolean = false) : void
      {
         if(scriptSuccess)
         {
            return;
         }
         _log.warn("An error occurred with a spell script!");
      }
   }
}
