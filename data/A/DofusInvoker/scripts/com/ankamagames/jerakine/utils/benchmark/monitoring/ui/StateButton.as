package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class StateButton extends Sprite
   {
      
      private static const OUT_COLOR:uint = 0;
      
      private static const OVER_COLOR:uint = 16777215;
       
      
      private var _bg:Shape;
      
      private var _triangle:Shape;
      
      public function StateButton(pX:int, pY:int)
      {
         super();
         x = pX;
         y = pY;
         buttonMode = true;
         cacheAsBitmap = true;
         this._bg = new Shape();
         addChild(this._bg);
         this._triangle = new Shape();
         addChild(this._triangle);
         this.draw(OUT_COLOR,OVER_COLOR);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
      }
      
      private function rollOutHandler(pEvt:MouseEvent) : void
      {
         this.draw(OUT_COLOR,OVER_COLOR);
      }
      
      private function rollOverHandler(pEvt:MouseEvent) : void
      {
         this.draw(OVER_COLOR,OUT_COLOR);
      }
      
      public function draw(bgColor:uint, arrowColor:uint) : void
      {
         this._bg.graphics.clear();
         this._bg.graphics.beginFill(bgColor,1);
         this._bg.graphics.lineStyle(2,0);
         this._bg.graphics.drawRoundRect(0,0,20,FpsManagerConst.BOX_HEIGHT,8,8);
         this._bg.graphics.endFill();
         this._triangle.graphics.clear();
         this._triangle.graphics.beginFill(arrowColor,1);
         this._triangle.graphics.drawTriangles(Vector.<Number>([6,20,16,30,6,40]));
         this._triangle.graphics.endFill();
      }
   }
}
