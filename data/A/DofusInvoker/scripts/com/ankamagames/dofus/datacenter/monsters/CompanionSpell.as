package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class CompanionSpell implements IDataCenter
   {
      
      public static const MODULE:String = "CompanionSpells";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getCompanionSpellById,getCompanionSpells);
       
      
      public var id:int;
      
      public var spellId:int;
      
      public var companionId:int;
      
      public var gradeByLevel:String;
      
      public function CompanionSpell()
      {
         super();
      }
      
      public static function getCompanionSpellById(id:uint) : CompanionSpell
      {
         return GameData.getObject(MODULE,id) as CompanionSpell;
      }
      
      public static function getCompanionSpells() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
