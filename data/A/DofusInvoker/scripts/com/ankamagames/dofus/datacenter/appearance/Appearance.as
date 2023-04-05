package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Appearance implements IDataCenter
   {
      
      public static const MODULE:String = "Appearances";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAppearanceById,null);
       
      
      public var id:uint;
      
      public var type:uint;
      
      public var data:String;
      
      public function Appearance()
      {
         super();
      }
      
      public static function getAppearanceById(id:uint) : Appearance
      {
         return GameData.getObject(MODULE,id) as Appearance;
      }
   }
}
