package com.ankamagames.dofus.datacenter.breach
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class BreachWorldMapCoordinate implements IDataCenter
   {
      
      public static const MODULE:String = "BreachWorldMapCoordinates";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getBreachWorldMapCoordinatesByMapStage,getAllBreachWorldMapCoordinates);
       
      
      public var id:uint;
      
      public var mapStage:uint;
      
      public var mapCoordinateX:int;
      
      public var mapCoordinateY:int;
      
      public var unexploredMapIcon:int;
      
      public var exploredMapIcon:int;
      
      public function BreachWorldMapCoordinate()
      {
         super();
      }
      
      public static function getBreachWorldMapCoordinatesByMapStage(mapStage:int) : BreachWorldMapCoordinate
      {
         return GameData.getObject(MODULE,mapStage) as BreachWorldMapCoordinate;
      }
      
      public static function getAllBreachWorldMapCoordinates() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
