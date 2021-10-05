package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public interface Zone2D
   {
       
      
      function contains(param1:Number, param2:Number) : Boolean;
      
      function getLocation() : Point;
      
      function getArea() : Number;
   }
}
