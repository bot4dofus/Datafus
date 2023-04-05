package com.ankamagames.dofus.datacenter.optionalFeatures
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ForgettableSpell implements IDataCenter
   {
      
      public static const MODULE:String = "ForgettableSpells";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getForgettableSpellById,getForgettableSpells);
       
      
      public var id:int;
      
      public var pairId:int;
      
      public var itemId:int;
      
      public function ForgettableSpell()
      {
         super();
      }
      
      public static function getForgettableSpellById(id:int) : ForgettableSpell
      {
         return GameData.getObject(MODULE,id) as ForgettableSpell;
      }
      
      public static function getForgettableSpellByScrollId(scrollId:int) : ForgettableSpell
      {
         var forgettableSpell:ForgettableSpell = null;
         var forgettableSpells:Array = getForgettableSpells();
         for each(forgettableSpell in forgettableSpells)
         {
            if(forgettableSpell.itemId === scrollId)
            {
               return forgettableSpell;
            }
         }
         return null;
      }
      
      public static function getForgettableSpells() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
