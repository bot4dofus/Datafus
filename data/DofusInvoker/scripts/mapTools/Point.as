package mapTools
{
   import flash.geom.Point;
   
   public class Point
   {
       
      
      public var y:int;
      
      public var x:int;
      
      public function Point(param1:int, param2:int)
      {
         x = param1;
         y = param2;
      }
      
      public function toString() : String
      {
         return "Point(" + x + "," + y + ")";
      }
      
      public function toFlashPoint() : flash.geom.Point
      {
         return new flash.geom.Point(x,y);
      }
      
      public function toArray() : Array
      {
         return [x,y];
      }
   }
}
