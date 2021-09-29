package mapTools
{
   public class MapDirection
   {
      
      public static var INVALID_DIRECTION:int = -1;
      
      public static var DEFAULT_DIRECTION:int = 1;
      
      public static var MAP_ORTHOGONAL_DIRECTIONS_COUNT:int = 4;
      
      public static var MAP_CARDINAL_DIRECTIONS_COUNT:int = 4;
      
      public static var MAP_INTER_CARDINAL_DIRECTIONS_COUNT:int = 8;
      
      public static var MAP_INTER_CARDINAL_DIRECTIONS_HALF_COUNT:int = 4;
      
      public static var EAST:int = 0;
      
      public static var SOUTH_EAST:int = 1;
      
      public static var SOUTH:int = 2;
      
      public static var SOUTH_WEST:int = 3;
      
      public static var WEST:int = 4;
      
      public static var NORTH_WEST:int = 5;
      
      public static var NORTH:int = 6;
      
      public static var NORTH_EAST:int = 7;
      
      public static var MAP_CARDINAL_DIRECTIONS:Array = [0,2,4,6];
      
      public static var MAP_ORTHOGONAL_DIRECTIONS:Array = [1,3,5,7];
      
      public static var MAP_DIRECTIONS:Array = [0,1,2,3,4,5,6,7];
       
      
      public function MapDirection()
      {
      }
      
      public static function isValidDirection(param1:int) : Boolean
      {
         if(param1 >= 0)
         {
            return param1 <= 7;
         }
         return false;
      }
      
      public static function getOppositeDirection(param1:int) : int
      {
         return param1 ^ 4;
      }
      
      public static function isCardinal(param1:int) : Boolean
      {
         return (param1 & 1) == 0;
      }
      
      public static function isOrthogonal(param1:int) : Boolean
      {
         return (param1 & 1) == 1;
      }
   }
}
