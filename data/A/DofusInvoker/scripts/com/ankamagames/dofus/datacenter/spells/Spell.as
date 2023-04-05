package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Spell implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Spell));
      
      public static const MODULE:String = "Spells";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSpellById,getSpells);
       
      
      private var _indexedParam:Array;
      
      private var _indexedCriticalParam:Array;
      
      public var id:int;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var typeId:uint;
      
      public var order:uint;
      
      public var scriptParams:String;
      
      public var scriptParamsCritical:String;
      
      public var scriptId:int;
      
      public var scriptIdCritical:int;
      
      public var iconId:uint;
      
      public var spellLevels:Vector.<uint>;
      
      public var useParamCache:Boolean = true;
      
      public var verboseCast:Boolean;
      
      public var defaultPreviewZone:String;
      
      public var bypassSummoningLimit:Boolean;
      
      public var canAlwaysTriggerSpells:Boolean;
      
      public var adminName:String;
      
      private var _effectZone:EffectZone = null;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _spellLevels:Array;
      
      private var _spellVariant:SpellVariant;
      
      public function Spell()
      {
         this._spellLevels = [];
         super();
      }
      
      public static function getSpellById(id:int) : Spell
      {
         return GameData.getObject(MODULE,id) as Spell;
      }
      
      public static function getSpells() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get effectZone() : EffectZone
      {
         if(this._effectZone === null)
         {
            this._effectZone = new EffectZone();
            this._effectZone.rawActivationZone = this.defaultPreviewZone;
         }
         return this._effectZone;
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get description() : String
      {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
      
      public function get type() : SpellType
      {
         return SpellType.getSpellTypeById(this.typeId);
      }
      
      public function get spellVariant() : SpellVariant
      {
         var allSpellVariants:Array = null;
         var variant:SpellVariant = null;
         if(!this._spellVariant)
         {
            allSpellVariants = SpellVariant.getSpellVariants();
            for each(variant in allSpellVariants)
            {
               if(variant.spellIds.indexOf(this.id) != -1)
               {
                  this._spellVariant = variant;
                  return this._spellVariant;
               }
            }
         }
         return this._spellVariant;
      }
      
      public function getSpellLevel(level:int) : SpellLevel
      {
         this.spellLevelsInfo;
         var index:int = 0;
         if(this.spellLevels.length >= level && level > 0)
         {
            index = level - 1;
         }
         return this._spellLevels[index];
      }
      
      public function get spellLevelsInfo() : Array
      {
         var levelCount:int = 0;
         var i:int = 0;
         if(!this._spellLevels || this._spellLevels.length != this.spellLevels.length)
         {
            levelCount = this.spellLevels.length;
            for(i = 0; i < levelCount; )
            {
               this._spellLevels[i] = SpellLevel.getLevelById(this.spellLevels[i]);
               i++;
            }
         }
         return this._spellLevels;
      }
      
      public function getScriptId(critical:Boolean = false) : int
      {
         if(critical && this.scriptIdCritical)
         {
            return this.scriptIdCritical;
         }
         return this.scriptId;
      }
      
      public function getParamByName(name:String, critical:Boolean = false) : *
      {
         var tmp:Array = null;
         var tmp2:Array = null;
         var param:String = null;
         if(critical && this.scriptParamsCritical && this.scriptParamsCritical != "null")
         {
            if(!this._indexedCriticalParam || !this.useParamCache)
            {
               this._indexedCriticalParam = new Array();
               if(this.scriptParamsCritical)
               {
                  tmp = this.scriptParamsCritical.split(",");
                  for each(param in tmp)
                  {
                     tmp2 = param.split(":");
                     this._indexedCriticalParam[tmp2[0]] = this.getValue(tmp2[1]);
                  }
               }
            }
            return this._indexedCriticalParam[name];
         }
         if(!this._indexedParam || !this.useParamCache)
         {
            this._indexedParam = new Array();
            if(this.scriptParams)
            {
               tmp = this.scriptParams.split(",");
               for each(param in tmp)
               {
                  tmp2 = param.split(":");
                  this._indexedParam[tmp2[0]] = this.getValue(tmp2[1]);
               }
            }
         }
         return this._indexedParam[name];
      }
      
      private function getValue(str:String) : *
      {
         var num:Number = NaN;
         var regNum:RegExp = /^[+-]?[0-9.]*$/;
         if(str.search(regNum) != -1)
         {
            num = parseFloat(str);
            return !!isNaN(num) ? 0 : num;
         }
         return str;
      }
      
      public function toString() : String
      {
         return this.name + " (" + this.id + ")";
      }
   }
}
