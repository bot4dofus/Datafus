package com.ankamagames.dofus.logic.game.fight.managers
{
   import flash.utils.Dictionary;
   
   public class SpellDamagesManager
   {
      
      private static var _self:SpellDamagesManager;
       
      
      private var _spellDamages:Dictionary;
      
      public function SpellDamagesManager()
      {
         this._spellDamages = new Dictionary();
         super();
      }
      
      public static function getInstance() : SpellDamagesManager
      {
         if(!_self)
         {
            _self = new SpellDamagesManager();
         }
         return _self;
      }
      
      public function removeSpellDamages(pEntityId:Number) : void
      {
         if(this._spellDamages[pEntityId])
         {
            this._spellDamages[pEntityId].length = 0;
         }
      }
      
      public function removeSpellDamageBySpellId(pEntityId:Number, pSpellId:uint) : void
      {
         var esd:EntitySpellDamage = null;
         if(this._spellDamages[pEntityId])
         {
            for each(esd in this._spellDamages[pEntityId])
            {
               if(esd.spellId == pSpellId)
               {
                  this._spellDamages[pEntityId].splice(this._spellDamages[pEntityId].indexOf(esd),1);
               }
            }
         }
      }
   }
}

import com.ankamagames.dofus.logic.game.fight.types.SpellDamage;

class EntitySpellDamage
{
    
   
   public var spellId:int;
   
   public var spellDamage:SpellDamage;
   
   public var interceptedDamage:Boolean;
   
   function EntitySpellDamage(pSpellId:int, pSpellDamage:SpellDamage, pInterceptedDamage:Boolean)
   {
      super();
      this.spellId = pSpellId;
      this.spellDamage = pSpellDamage;
      this.interceptedDamage = pInterceptedDamage;
   }
}
