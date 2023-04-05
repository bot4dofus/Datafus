package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SpellType implements IDataCenter
   {
      
      public static const MODULE:String = "SpellTypes";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSpellTypeById,null);
       
      
      public var id:int;
      
      public var longNameId:uint;
      
      public var shortNameId:uint;
      
      private var _longName:String;
      
      private var _shortName:String;
      
      public function SpellType()
      {
         super();
      }
      
      public static function getSpellTypeById(id:int) : SpellType
      {
         return GameData.getObject(MODULE,id) as SpellType;
      }
      
      public function get longName() : String
      {
         if(!this._longName)
         {
            this._longName = I18n.getText(this.longNameId);
         }
         return this._longName;
      }
      
      public function get shortName() : String
      {
         if(!this._shortName)
         {
            this._shortName = I18n.getText(this.shortNameId);
         }
         return this._shortName;
      }
   }
}
