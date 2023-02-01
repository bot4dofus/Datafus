package com.ankamagames.tubul.interfaces
{
   import flash.geom.Point;
   
   public interface ILocalizedSound extends ISound
   {
       
      
      function get range() : Number;
      
      function set range(param1:Number) : void;
      
      function get saturationRange() : Number;
      
      function set saturationRange(param1:Number) : void;
      
      function get position() : Point;
      
      function set position(param1:Point) : void;
      
      function get pan() : Number;
      
      function set pan(param1:Number) : void;
      
      function get volumeMax() : Number;
      
      function set volumeMax(param1:Number) : void;
   }
}
