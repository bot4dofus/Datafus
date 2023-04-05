package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.tiphon.types.TransformData;
   
   public class SkinPosition implements IDataCenter
   {
      
      private static const MODULE:String = "SkinPositions";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSkinPositionById,getAllSkinPositions);
       
      
      public var id:uint;
      
      public var transformation:Vector.<TransformData>;
      
      public var clip:Vector.<String>;
      
      public var skin:Vector.<uint>;
      
      public function SkinPosition()
      {
         super();
      }
      
      public static function getSkinPositionById(id:int) : SkinPosition
      {
         return GameData.getObject(MODULE,id) as SkinPosition;
      }
      
      public static function getAllSkinPositions() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
