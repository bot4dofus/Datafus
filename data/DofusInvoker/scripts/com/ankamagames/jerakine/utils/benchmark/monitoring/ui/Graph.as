package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class Graph extends Sprite
   {
      
      private static const MENU_OUT_ALPHA:Number = 0.5;
       
      
      public var indice:String;
      
      public var points:Vector.<int>;
      
      public var color:uint;
      
      private var _isNewFrame:Boolean;
      
      public var startTime:int = 0;
      
      private var _menu:Sprite;
      
      private var _sprTooltip:Sprite;
      
      private var grapheIsVisible:Boolean = true;
      
      public function Graph(pName:String, pColor:uint = 16777215)
      {
         var tf:TextFormat = null;
         var _infoTf:TextField = null;
         super();
         this.indice = pName;
         this.color = pColor;
         this.points = new Vector.<int>();
         this._isNewFrame = true;
         if(!FpsManagerUtils.isSpecialGraph(this.indice))
         {
            this.grapheIsVisible = false;
            this._menu = new Sprite();
            this._menu.alpha = MENU_OUT_ALPHA;
            this._menu.buttonMode = true;
            this._menu.graphics.beginFill(this.color);
            this._menu.graphics.lineStyle(2,0);
            this._menu.graphics.drawRect(0,0,20,20);
            this._menu.graphics.endFill();
            this._menu.addEventListener(MouseEvent.CLICK,this.clickHandler);
            this._menu.addEventListener(MouseEvent.ROLL_OVER,this.mouseOverHandler);
            this._menu.addEventListener(MouseEvent.ROLL_OUT,this.mouseOutHandler);
            addChild(this._menu);
            tf = new TextFormat("Verdana",13);
            tf.color = this.color;
            _infoTf = new TextField();
            _infoTf.mouseEnabled = false;
            _infoTf.selectable = false;
            _infoTf.defaultTextFormat = tf;
            _infoTf.text = this.indice;
            _infoTf.x = (_infoTf.width - _infoTf.textWidth) / 2;
            this._sprTooltip = new Sprite();
            this._sprTooltip.graphics.beginFill(16777215);
            this._sprTooltip.graphics.lineStyle(1,0);
            this._sprTooltip.graphics.drawRoundRect(0,0,_infoTf.width,20,4,4);
            this._sprTooltip.addChild(_infoTf);
            this._sprTooltip.y = -30;
            this._sprTooltip.x = -10;
         }
      }
      
      private function clickHandler(pEvt:MouseEvent) : void
      {
         this.grapheIsVisible = !this.grapheIsVisible;
         this._menu.alpha = !!this.grapheIsVisible ? Number(1) : Number(MENU_OUT_ALPHA);
         if(this.grapheIsVisible)
         {
            dispatchEvent(new Event("showGraph"));
         }
         else
         {
            dispatchEvent(new Event("hideGraph"));
         }
      }
      
      private function mouseOverHandler(pEvt:MouseEvent) : void
      {
         if(!this.grapheIsVisible)
         {
            this._menu.alpha = 1;
         }
         this._menu.addChild(this._sprTooltip);
      }
      
      private function mouseOutHandler(pEvt:MouseEvent) : void
      {
         if(!this.grapheIsVisible)
         {
            this._menu.alpha = MENU_OUT_ALPHA;
         }
         this._menu.removeChild(this._sprTooltip);
      }
      
      public function insertNewValue(val:int) : void
      {
         if(this._isNewFrame)
         {
            this.addValue(val);
         }
         else
         {
            this.updateLastValue(val);
         }
      }
      
      private function addValue(val:int) : void
      {
         this._isNewFrame = false;
         this.points.push(val);
      }
      
      private function updateLastValue(val:int) : void
      {
         this.points[this.points.length - 1] += val;
      }
      
      public function setNewFrame() : void
      {
         if(!FpsManagerUtils.isSpecialGraph(this.indice))
         {
            this.startTime = 0;
         }
         this._isNewFrame = true;
      }
      
      public function get length() : int
      {
         return this.points.length;
      }
      
      public function setMenuPosition(pX:Number, pY:Number) : void
      {
         this._menu.x = pX;
         this._menu.y = pY;
      }
      
      public function get graphVisible() : Boolean
      {
         return this.grapheIsVisible;
      }
   }
}
