package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SpellBomb implements IDataCenter
   {
      
      public static const MODULE:String = "SpellBombs";
       
      
      public var id:int;
      
      public var chainReactionSpellId:int;
      
      public var explodSpellId:int;
      
      public var wallId:int;
      
      public var instantSpellId:int;
      
      public var comboCoeff:int;
      
      public function SpellBomb()
      {
         super();
      }
      
      public static function getSpellBombById(id:int) : SpellBomb
      {
         return GameData.getObject(MODULE,id) as SpellBomb;
      }
   }
}
