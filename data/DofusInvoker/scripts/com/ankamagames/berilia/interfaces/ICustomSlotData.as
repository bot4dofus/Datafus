package com.ankamagames.berilia.interfaces
{
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public interface ICustomSlotData extends ISlotData
   {
       
      
      function get colorTransform() : ColorTransform;
      
      function get size() : Point;
   }
}
