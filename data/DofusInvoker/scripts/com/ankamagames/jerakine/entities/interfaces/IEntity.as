package com.ankamagames.jerakine.entities.interfaces
{
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public interface IEntity
   {
       
      
      function get id() : Number;
      
      function set id(param1:Number) : void;
      
      function get position() : MapPoint;
      
      function set position(param1:MapPoint) : void;
   }
}
