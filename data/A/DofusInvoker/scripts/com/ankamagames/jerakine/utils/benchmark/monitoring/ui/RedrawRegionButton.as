package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   import flash.display.Sprite;
   
   public class RedrawRegionButton extends Sprite
   {
       
      
      public function RedrawRegionButton(pX:int, pY:int)
      {
         super();
         cacheAsBitmap = true;
         x = pX;
         y = pY;
         buttonMode = true;
         graphics.clear();
         graphics.beginFill(16777215,1);
         graphics.lineStyle(2,0);
         graphics.drawRoundRect(0,0,20,FpsManagerConst.BOX_HEIGHT,8,8);
         graphics.endFill();
      }
   }
}
