package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public final class TiphonDebugManager
   {
      
      private static var _enabled:Boolean = false;
      
      private static var _textList:Vector.<Object> = new Vector.<Object>();
       
      
      public function TiphonDebugManager()
      {
         super();
      }
      
      public static function enable() : void
      {
         _enabled = true;
      }
      
      public static function disable() : void
      {
         _enabled = false;
      }
      
      public static function displayDofusScriptError(text:String, tiphonSprite:TiphonSprite) : void
      {
         var textField:TextField = null;
         var timer:BenchmarkTimer = null;
         var pos:Point = null;
         if(_enabled && tiphonSprite)
         {
            textField = new TextField();
            textField.defaultTextFormat = new TextFormat("Verdana",14,16777215,true,null,null,null,null,"center");
            textField.filters = new Array(new GlowFilter(16711680,1,3,3,3,3));
            textField.text = text + "\n" + (!!tiphonSprite.look ? tiphonSprite.look.toString() : "");
            textField.autoSize = TextFieldAutoSize.LEFT;
            textField.mouseEnabled = false;
            timer = new BenchmarkTimer(10000,1,"TiphonDebugManager.timer");
            timer.addEventListener(TimerEvent.TIMER,onTimer);
            timer.start();
            _textList.push(timer,textField);
            StageShareManager.stage.addChild(textField);
            pos = tiphonSprite.localToGlobal(new Point(0,0));
            textField.x = pos.x - textField.width / 2;
            textField.y = pos.y - tiphonSprite.height / 2 + (20 - Math.random() * 40);
         }
      }
      
      private static function onTimer(e:TimerEvent) : void
      {
         var textField:TextField = null;
         var timer:BenchmarkTimer = e.currentTarget as BenchmarkTimer;
         var num:int = _textList.length;
         for(var i:int = 0; i < num; i += 2)
         {
            if(timer == _textList[i])
            {
               textField = _textList[i + 1] as TextField;
               if(textField.parent)
               {
                  textField.parent.removeChild(textField);
               }
               _textList.splice(i,2);
               timer.reset();
               timer.removeEventListener(TimerEvent.TIMER,onTimer);
               return;
            }
         }
      }
   }
}
