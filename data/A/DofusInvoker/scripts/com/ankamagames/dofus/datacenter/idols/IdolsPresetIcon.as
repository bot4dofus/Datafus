package com.ankamagames.dofus.datacenter.idols
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   
   public class IdolsPresetIcon
   {
      
      public static const MODULE:String = "IdolsPresetIcons";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getIdolsPresetIconById,getIdolsPresetIcons);
       
      
      public var id:int;
      
      public var order:int;
      
      public function IdolsPresetIcon()
      {
         super();
      }
      
      public static function getIdolsPresetIconById(id:int) : IdolsPresetIcon
      {
         return GameData.getObject(MODULE,id) as IdolsPresetIcon;
      }
      
      public static function getIdolsPresetIcons() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
