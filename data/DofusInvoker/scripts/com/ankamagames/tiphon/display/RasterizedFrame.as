package com.ankamagames.tiphon.display
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class RasterizedFrame
   {
       
      
      public var bitmapData:BitmapData;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public function RasterizedFrame(target:MovieClip, index:int)
      {
         var bmpd:BitmapData = null;
         var mtx:Matrix = null;
         var sX:Number = NaN;
         var sY:Number = NaN;
         var bmpW:Number = NaN;
         var bmpH:Number = NaN;
         var drawX:Number = NaN;
         var drawY:Number = NaN;
         super();
         target.gotoAndStop(index + 1);
         var bounds:Rectangle = target.getBounds(target);
         if(bounds.width + bounds.height)
         {
            mtx = new Matrix();
            sX = target.scaleX;
            sY = target.scaleY;
            bmpW = sX > 0 ? Number(bounds.width * sX) : Number(-bounds.width * sX);
            bmpH = sY > 0 ? Number(bounds.height * sY) : Number(-bounds.height * sY);
            drawX = sX > 0 ? Number(bounds.x * sX) : Number((bounds.x + bounds.width) * sX);
            drawY = sY > 0 ? Number(bounds.y * sY) : Number((bounds.y + bounds.height) * sY);
            mtx.scale(sX,sY);
            mtx.translate(-drawX,-drawY);
            this.x = drawX;
            this.y = drawY;
            bmpd = new BitmapData(bmpW,bmpH,true,16777215);
            bmpd.draw(target,mtx,null,null,null,true);
         }
         else
         {
            bmpd = new BitmapData(1,1,true,16777215);
         }
         this.bitmapData = bmpd;
         if(target.currentFrame == target.framesLoaded && target.parent)
         {
            target.parent.removeChild(target);
         }
      }
      
      public function toString() : String
      {
         return "[RasterizedFrame " + this.x + "," + this.y + ": " + this.bitmapData + " (" + this.bitmapData.width + "/" + this.bitmapData.height + ")]";
      }
   }
}
