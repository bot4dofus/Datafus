package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   
   public class Square extends ZRectangle
   {
       
      
      public function Square(minRadius:uint, size:uint, isDiagonalFree:Boolean, dataMapProvider:IDataMapProvider)
      {
         super(minRadius,size,size,isDiagonalFree,dataMapProvider);
         if(isDiagonalFree)
         {
            _shape = SpellShapeEnum.W;
         }
         else
         {
            _shape = SpellShapeEnum.G;
         }
      }
      
      public function get length() : uint
      {
         return _width;
      }
   }
}
