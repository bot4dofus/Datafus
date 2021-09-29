package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   
   public class Square extends ZRectangle
   {
       
      
      public function Square(nMinRadius:uint, nRadius:uint, dataMapProvider:IDataMapProvider)
      {
         super(nMinRadius,nRadius,nRadius,dataMapProvider);
      }
      
      override public function get surface() : uint
      {
         return Math.pow(radius * 2 + 1,2);
      }
   }
}
