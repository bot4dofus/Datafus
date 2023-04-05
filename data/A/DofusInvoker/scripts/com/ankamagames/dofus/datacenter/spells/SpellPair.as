package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SpellPair implements IDataCenter
   {
      
      public static const MODULE:String = "SpellPairs";
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var iconId:uint;
      
      private var _name:String;
      
      private var _desc:String;
      
      public function SpellPair()
      {
         super();
      }
      
      public static function getSpellPairById(id:int) : SpellPair
      {
         return GameData.getObject(MODULE,id) as SpellPair;
      }
      
      public static function getSpellPairs() : Array
      {
         return GameData.getObjects(MODULE);
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
         if(!this._desc)
         {
            this._desc = I18n.getText(this.descriptionId);
         }
         return this._desc;
      }
   }
}
