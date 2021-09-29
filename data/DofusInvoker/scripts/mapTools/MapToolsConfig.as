package mapTools
{
   public class MapToolsConfig
   {
      
      public static var DOFUS2_CONFIG:MapToolsConfig = new MapToolsConfig(14,20,0,33,-19,13);
       
      
      public var minYCoord:int;
      
      public var minXCoord:int;
      
      public var maxYCoord:int;
      
      public var maxXCoord:int;
      
      public var mapGridWidth:int;
      
      public var mapGridHeight:int;
      
      public function MapToolsConfig(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         mapGridWidth = param1;
         mapGridHeight = param2;
         minXCoord = param3;
         maxXCoord = param4;
         minYCoord = param5;
         maxYCoord = param6;
      }
   }
}
