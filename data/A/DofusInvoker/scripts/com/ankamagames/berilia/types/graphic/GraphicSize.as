package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.types.uiDefinition.SizeElement;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.geom.Point;
   
   public class GraphicSize extends Point implements IDataCenter
   {
      
      public static const SIZE_PIXEL:uint = 0;
      
      public static const SIZE_PRC:uint = 1;
       
      
      private var _nXUnit:uint;
      
      private var _nYUnit:uint;
      
      public function GraphicSize()
      {
         super();
         x = NaN;
         y = NaN;
      }
      
      public function setX(nX:Number, nType:uint) : void
      {
         x = nX;
         this._nXUnit = nType;
      }
      
      public function setY(nY:Number, nType:uint) : void
      {
         y = nY;
         this._nYUnit = nType;
      }
      
      public function get xUnit() : uint
      {
         return this._nXUnit;
      }
      
      public function get yUnit() : uint
      {
         return this._nYUnit;
      }
      
      public function toSizeElement() : SizeElement
      {
         var se:SizeElement = new SizeElement();
         if(!isNaN(x))
         {
            se.x = x;
            se.xUnit = this._nXUnit;
         }
         if(!isNaN(y))
         {
            se.y = y;
            se.yUnit = this._nYUnit;
         }
         return se;
      }
   }
}
