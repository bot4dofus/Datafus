package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class SpellVariant implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellVariant));
      
      public static const MODULE:String = "SpellVariants";
       
      
      public var id:int;
      
      public var breedId:uint;
      
      public var spellIds:Vector.<uint>;
      
      private var _spells:Array;
      
      public function SpellVariant()
      {
         super();
      }
      
      public static function getSpellVariantById(id:int) : SpellVariant
      {
         return GameData.getObject(MODULE,id) as SpellVariant;
      }
      
      public static function getSpellVariants() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get spells() : Array
      {
         var spellToCopy:Spell = null;
         var spellId:int = 0;
         if(!this._spells)
         {
            this._spells = new Array();
            for each(spellId in this.spellIds)
            {
               spellToCopy = Spell.getSpellById(spellId);
               if(spellToCopy)
               {
                  this._spells.push(spellToCopy);
               }
            }
         }
         return this._spells;
      }
      
      public function toString() : String
      {
         var result:String = "";
         result += "[Variante " + this.id + " : ";
         var name0:String = "???";
         var name1:String = "???";
         var id0:int = 0;
         var id1:int = 0;
         if(this.spells.length && this.spells[0])
         {
            name0 = this.spells[0].name;
         }
         if(this.spells.length > 1 && this.spells[1])
         {
            name1 = this.spells[1].name;
         }
         if(this.spellIds.length && this.spellIds[0])
         {
            id0 = this.spellIds[0];
         }
         if(this.spellIds.length > 1 && this.spellIds[1])
         {
            id1 = this.spellIds[1];
         }
         return result + (name0 + " (" + id0 + ")" + ", " + name1 + " (" + id1 + ")]");
      }
   }
}
