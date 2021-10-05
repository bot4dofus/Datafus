package com.ankamagames.jerakine.types.zones
{
   public interface IZone
   {
       
      
      function get surface() : uint;
      
      function set minRadius(param1:uint) : void;
      
      function get minRadius() : uint;
      
      function set direction(param1:uint) : void;
      
      function get direction() : uint;
      
      function get radius() : uint;
      
      function set radius(param1:uint) : void;
      
      function getCells(param1:uint = 0) : Vector.<uint>;
   }
}
