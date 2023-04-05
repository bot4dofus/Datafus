package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PresetIcon implements IDataCenter
   {
      
      public static const MODULE:String = "PresetIcons";
       
      
      public var id:int;
      
      public var order:int;
      
      public function PresetIcon()
      {
         super();
      }
      
      public static function getPresetIconById(id:int) : PresetIcon
      {
         return GameData.getObject(MODULE,id) as PresetIcon;
      }
      
      public static function getPresetIcons() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
