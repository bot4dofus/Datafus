package com.ankamagames.jerakine.interfaces
{
   import flash.geom.Point;
   
   public interface IRectangle
   {
       
      
      function get x() : Number;
      
      function set x(param1:Number) : void;
      
      function get y() : Number;
      
      function set y(param1:Number) : void;
      
      function get width() : Number;
      
      function set width(param1:Number) : void;
      
      function get height() : Number;
      
      function set height(param1:Number) : void;
      
      function localToGlobal(param1:Point) : Point;
      
      function globalToLocal(param1:Point) : Point;
   }
}
