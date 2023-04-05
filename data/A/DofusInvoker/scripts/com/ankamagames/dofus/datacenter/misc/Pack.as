package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Pack implements IDataCenter
   {
      
      public static const MODULE:String = "Pack";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getPackById,getAllPacks);
       
      
      public var id:int;
      
      public var name:String;
      
      public var hasSubAreas:Boolean;
      
      public function Pack()
      {
         super();
      }
      
      public static function getPackById(id:int) : Pack
      {
         return GameData.getObject(MODULE,id) as Pack;
      }
      
      public static function getAllPacks() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
