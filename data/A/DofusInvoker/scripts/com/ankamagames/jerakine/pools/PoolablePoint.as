package com.ankamagames.jerakine.pools
{
   import flash.geom.Point;
   
   public class PoolablePoint extends Point implements Poolable
   {
       
      
      public function PoolablePoint(x:Number = 0, y:Number = 0)
      {
         super(x,y);
      }
      
      public function renew(x:Number = 0, y:Number = 0) : Point
      {
         this.x = x;
         this.y = y;
         return this;
      }
      
      public function free() : void
      {
         this.renew();
      }
   }
}
