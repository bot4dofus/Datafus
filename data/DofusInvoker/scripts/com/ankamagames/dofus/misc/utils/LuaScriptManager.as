package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.dofus.datacenter.misc.LuaFormula;
   import com.ankamagames.dofus.logic.common.managers.AbstractItemFilterManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import luaAlchemy.LuaAlchemy;
   
   public class LuaScriptManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractItemFilterManager));
      
      private static var _self:LuaScriptManager;
       
      
      private var _luaAlchemy:LuaAlchemy;
      
      public function LuaScriptManager()
      {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         this.init();
      }
      
      public static function getInstance() : LuaScriptManager
      {
         if(!_self)
         {
            _self = new LuaScriptManager();
         }
         return _self;
      }
      
      private function init() : void
      {
         this._luaAlchemy = new LuaAlchemy();
      }
      
      private function formatScriptToLuaFunction(scriptCode:String, functionName:String = "main") : String
      {
         return scriptCode + "\n" + "return " + functionName + "()\n";
      }
      
      public function executeScript(luaFunction:String, params:Dictionary) : Object
      {
         var luaResult:Array = null;
         var key:* = null;
         if(params != null)
         {
            for(key in params)
            {
               this._luaAlchemy.setGlobalLuaValue(key,params[key]);
            }
         }
         luaResult = this._luaAlchemy.doString(luaFunction);
         if(params != null)
         {
            for(key in params)
            {
               this._luaAlchemy.setGlobal(key,null);
            }
         }
         var success:Boolean = luaResult.shift();
         if(!success)
         {
            throw new Error(luaResult[0]);
         }
         return luaResult[0];
      }
      
      public function executeLuaFormula(luaFormulaId:uint, params:Dictionary) : Object
      {
         return this.executeScript(this.getLuaFunctionFromFormulaId(luaFormulaId),params);
      }
      
      public function getLuaFunctionFromFormulaId(luaFormulaId:uint) : String
      {
         var formula:LuaFormula = LuaFormula.getLuaFormulaById(luaFormulaId);
         return this.formatScriptToLuaFunction(formula.luaFormula);
      }
   }
}
