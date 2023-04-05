package com.ankamagames.jerakine.pools
{
   import flash.geom.Rectangle;
   
   public class PoolableRectangle extends Rectangle implements Poolable
   {
       
      
      public function PoolableRectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0)
      {
         super(x,y,width,height);
      }
      
      public function renew(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) : PoolableRectangle
      {
         this.x = x;
         this.y = y;
         this.width = width;
         this.height = height;
         return this;
      }
      
      public function free() : void
      {
      }
      
      public function extend(toUnion:Rectangle) : void
      {
         var tmp:Rectangle = this.union(toUnion);
         x = tmp.x;
         y = tmp.y;
         width = tmp.width;
         height = tmp.height;
      }
   }
}
