package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
   import com.ankamagames.dofus.scripts.SpellScriptManager;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.Callback;
   import flash.utils.getTimer;
   
   public class FightPlaySpellScriptStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _cellId:int;
      
      private var _spellId:int;
      
      private var _spellRank:uint;
      
      private var _portalIds:Vector.<int>;
      
      private var _fxScriptId:int;
      
      private var _scriptStarted:uint;
      
      private var _spellCastProvider:ISpellCastProvider;
      
      public function FightPlaySpellScriptStep(fxScriptId:int, fighterId:Number, cellId:int, spellId:int, spellRank:uint, spellCastProvider:ISpellCastProvider)
      {
         super();
         this._fxScriptId = fxScriptId;
         this._spellId = spellId;
         this._spellRank = spellRank;
         this._spellCastProvider = spellCastProvider;
         this._fighterId = fighterId;
         if(this._fxScriptId == 0)
         {
            return;
         }
         var s:Spell = Spell.getSpellById(this._spellId);
         if(!s)
         {
            return;
         }
         var sl:SpellLevel = s.getSpellLevel(this._spellRank);
         if(!sl || !sl.playAnimation)
         {
            return;
         }
         if(this._spellCastProvider.castingSpell.spell)
         {
            _log.info("Executing SpellScript" + this._fxScriptId + " for spell \'" + this._spellCastProvider.castingSpell.spell.name + "\' (" + this._spellCastProvider.castingSpell.spell.id + ")");
         }
         else
         {
            _log.info("Executing SpellScript" + this._fxScriptId + " for unknown spell");
         }
         this._scriptStarted = getTimer();
         SpellScriptManager.getInstance().runSpellScript(this._fxScriptId,this._spellCastProvider,new Callback(this.scriptEnd,true),new Callback(this.scriptEnd,false));
      }
      
      public function get stepType() : String
      {
         return "spellCast";
      }
      
      override public function start() : void
      {
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
      
      private function scriptEnd(scriptSuccess:Boolean = false) : void
      {
         var scriptTook:uint = getTimer() - this._scriptStarted;
         if(!scriptSuccess)
         {
            _log.warn("Script failed during a fight sequence, but still took " + scriptTook + "ms.");
         }
         else
         {
            _log.info("Script successfuly executed in " + scriptTook + "ms.");
         }
      }
   }
}
