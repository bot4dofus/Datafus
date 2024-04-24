package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class SpellScript implements IDataCenter
   {
      
      public static const INVALID_ID:int = -1;
      
      public static const WEAPON_SCRIPT_ID:int = 0;
      
      public static const WEAPON_TYPE_SCRIPT_ID:int = 7;
      
      public static const FECA_GLYPH_SCRIPT_ID:int = 16288;
      
      public static const SRAM_TRAP_SCRIPT_ID:int = 16289;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellScript));
      
      public static const MODULE:String = "SpellScripts";
      
      private static var _weaponScriptData:SpellScript = null;
      
      private static var _fallbackScriptData:SpellScript = null;
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSpellScriptById,getSpellScripts);
       
      
      private var _params:Array;
      
      public var id:int;
      
      public var typeId:int;
      
      public var rawParams:String;
      
      public function SpellScript()
      {
         super();
      }
      
      public static function getSpellScriptById(id:int) : SpellScript
      {
         if(id === SpellScript.WEAPON_SCRIPT_ID)
         {
            if(_weaponScriptData === null)
            {
               _weaponScriptData = new SpellScript();
               _weaponScriptData.typeId = WEAPON_TYPE_SCRIPT_ID;
            }
            return _weaponScriptData;
         }
         var scriptData:SpellScript = GameData.getObject(MODULE,id) as SpellScript;
         if(scriptData === null)
         {
            if(_fallbackScriptData === null)
            {
               _fallbackScriptData = new SpellScript();
               _fallbackScriptData.typeId = -1;
            }
            scriptData = _fallbackScriptData;
         }
         return scriptData;
      }
      
      public static function getSpellScripts() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function hasParam(name:String) : Boolean
      {
         var value:* = this.getStringParam(name);
         return value !== null && value !== undefined && !isNaN(value);
      }
      
      public function getNumberParam(name:String) : Number
      {
         var rawNumber:String = this.getStringParam(name);
         if(!rawNumber)
         {
            return 0;
         }
         var number:Number = parseFloat(rawNumber);
         return !!isNaN(number) ? Number(0) : Number(number);
      }
      
      public function getBoolParam(name:String) : Boolean
      {
         return this.getNumberParam(name) !== 0;
      }
      
      public function getStringParam(name:String) : String
      {
         return this.getParam(name);
      }
      
      public function getParam(name:String) : *
      {
         var rawParam:String = null;
         var paramPair:Array = null;
         var key:String = null;
         var value:String = null;
         if(!this.rawParams)
         {
            return null;
         }
         if(this._params)
         {
            return this._params[name];
         }
         this._params = [];
         var splitRawParams:Array = this.rawParams.split(",");
         for each(rawParam in splitRawParams)
         {
            paramPair = rawParam.split(":");
            if(paramPair.length >= 2)
            {
               key = paramPair[0];
               value = paramPair[1];
               this._params[key] = value;
            }
         }
         return this._params[name];
      }
      
      public function toString() : String
      {
         return "SpellScript id: " + this.id + ", typeId: " + this.typeId;
      }
   }
}
