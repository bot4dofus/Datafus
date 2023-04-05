package com.ankamagames.dofus.scripts
{
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
   import com.ankamagames.dofus.scripts.spells.SpellScript1;
   import com.ankamagames.dofus.scripts.spells.SpellScript2;
   import com.ankamagames.dofus.scripts.spells.SpellScript3;
   import com.ankamagames.dofus.scripts.spells.SpellScript5;
   import com.ankamagames.dofus.scripts.spells.SpellScript6;
   import com.ankamagames.dofus.scripts.spells.SpellScript7;
   import com.ankamagames.dofus.scripts.spells.SpellScript8;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.script.ScriptErrorEnum;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class SpellScriptManager
   {
      
      private static var SPELL_SCRIPT_1:SpellScript1;
      
      private static var SPELL_SCRIPT_2:SpellScript2;
      
      private static var SPELL_SCRIPT_3:SpellScript3;
      
      private static var SPELL_SCRIPT_5:SpellScript5;
      
      private static var SPELL_SCRIPT_6:SpellScript6;
      
      private static var SPELL_SCRIPT_7:SpellScript7;
      
      private static var SPELL_SCRIPT_8:SpellScript8;
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(SpellScriptManager));
      
      private static var _self:SpellScriptManager;
       
      
      public function SpellScriptManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("SpellScriptManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : SpellScriptManager
      {
         if(_self == null)
         {
            _self = new SpellScriptManager();
         }
         return _self;
      }
      
      public function runSpellScript(spellScriptId:int, spellCastProvider:ISpellCastProvider, successCallback:Callback = null, errorCallback:Callback = null) : void
      {
         var returnCode:uint = 0;
         var scriptClass:Class = null;
         var scriptRunner:SpellFxRunner = null;
         try
         {
            scriptClass = getDefinitionByName("com.ankamagames.dofus.scripts.spells.SpellScript" + spellScriptId) as Class;
         }
         catch(error:Error)
         {
            _log.error("Can\'t find class SpellScript" + spellScriptId);
         }
         if(scriptClass)
         {
            scriptRunner = new SpellFxRunner(spellCastProvider);
            returnCode = scriptRunner.run(scriptClass);
         }
         else
         {
            returnCode = ScriptErrorEnum.SCRIPT_ERROR;
         }
         if(returnCode)
         {
            errorCallback.exec();
         }
         else
         {
            successCallback.exec();
         }
      }
   }
}
