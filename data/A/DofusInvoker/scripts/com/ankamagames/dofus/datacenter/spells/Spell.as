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
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var typeId:uint;
      
      public var order:uint;
      
      public var boundScriptUsageData:Vector.<BoundScriptUsageData>;
      
      public var criticalHitBoundScriptUsageData:Vector.<BoundScriptUsageData>;
      
      public var iconId:uint;
      
      public var spellLevels:Vector.<uint>;
      
      public var useParamCache:Boolean = true;
      
      public var verboseCast:Boolean;
      
      public var defaultPreviewZone:String;
      
      public var bypassSummoningLimit:Boolean;
      
      public var canAlwaysTriggerSpells:Boolean;
      
      public var adminName:String;
      
      public var hideCastConditions:Boolean;
      
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
      
      public function toString() : String
      {
         return this.name + " (" + this.id + ")";
      }
      
      public function getScriptConditions(index:uint, isCritical:Boolean) : BoundScriptUsageData
      {
         var resolvedConditions:Vector.<BoundScriptUsageData> = !!isCritical ? this.boundScriptUsageData : this.criticalHitBoundScriptUsageData;
         if(index > resolvedConditions.length - 1)
         {
            return null;
         }
         return resolvedConditions[index];
      }
      
      public function getScriptParam(scriptIndex:int, name:String, isCritical:Boolean = false) : *
      {
         var conditions:BoundScriptUsageData = this.getScriptConditions(scriptIndex,isCritical);
         var script:SpellScript = SpellScript.getSpellScriptById(conditions.scriptId);
         if(script === null)
         {
            return null;
         }
         return script.getStringParam(name);
      }
      
      public function getScriptTypeId(scriptIndex:int, isCritical:Boolean = false) : int
      {
         var conditions:BoundScriptUsageData = this.getScriptConditions(scriptIndex,isCritical);
         var script:SpellScript = conditions !== null ? SpellScript.getSpellScriptById(conditions.scriptId) : null;
         if(script === null)
         {
            return !!isCritical ? 1 : 0;
         }
         return script.typeId;
      }
   }
}
