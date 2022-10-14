package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import com.ankamagames.tiphon.types.DynamicSprite;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class TiphonFpsManager
   {
      
      private static var _tiphonGarbageCollectorTimer:BenchmarkTimer = new BenchmarkTimer(60000,0,"TiphonFpsManager._tiphonGarbageCollectorTimer");
      
      private static var _oldScriptedAnimation:Dictionary = new Dictionary(true);
       
      
      public function TiphonFpsManager()
      {
         super();
      }
      
      public static function init() : void
      {
      }
      
      public static function addOldScriptedAnimation(scriptedAnimation:ScriptedAnimation, destroyNow:Boolean = false) : void
      {
      }
      
      private static function onTiphonGarbageCollector(e:Event) : void
      {
         var object:* = null;
         var i:int = 0;
         var num:int = 0;
         var scriptedAnimation:ScriptedAnimation = null;
         var destroyedScriptedAnimation:Vector.<ScriptedAnimation> = new Vector.<ScriptedAnimation>();
         var time:int = getTimer();
         for(object in _oldScriptedAnimation)
         {
            scriptedAnimation = object as ScriptedAnimation;
            if(time - _oldScriptedAnimation[scriptedAnimation] > 300000)
            {
               destroyedScriptedAnimation.push(scriptedAnimation);
               destroyScriptedAnimation(scriptedAnimation);
            }
         }
         i = -1;
         num = destroyedScriptedAnimation.length;
         while(++i < num)
         {
            delete _oldScriptedAnimation[destroyedScriptedAnimation[i]];
         }
      }
      
      private static function destroyScriptedAnimation(scriptedAnimation:ScriptedAnimation) : void
      {
         if(scriptedAnimation && !scriptedAnimation.parent)
         {
            scriptedAnimation.destroyed = true;
            if(scriptedAnimation.parent)
            {
               scriptedAnimation.parent.removeChild(scriptedAnimation);
            }
            scriptedAnimation.spriteHandler = null;
            eraseMovieClip(scriptedAnimation);
         }
      }
      
      private static function eraseMovieClip(clip:MovieClip) : void
      {
         var frames:int = clip.totalFrames + 1;
         for(var i:int = 1; i < frames; i++)
         {
            clip.gotoAndStop(i);
            eraseFrame(clip);
         }
         clip.stop();
         if(FpsControler.containsFps(clip))
         {
            FpsControler.uncontrolFps(clip);
         }
      }
      
      private static function eraseFrame(clip:DisplayObjectContainer) : void
      {
         var lastChild:DisplayObject = null;
         var child:DisplayObject = null;
         var index:int = 0;
         while(clip.numChildren > index)
         {
            child = clip.removeChildAt(index);
            if(child == lastChild)
            {
               index++;
            }
            lastChild = child;
            if(!(child is DynamicSprite))
            {
               if(child is ScriptedAnimation)
               {
                  destroyScriptedAnimation(clip as ScriptedAnimation);
               }
               else if(child is MovieClip)
               {
                  eraseMovieClip(child as MovieClip);
               }
               else if(child is DisplayObjectContainer)
               {
                  eraseFrame(child as DisplayObjectContainer);
               }
               else if(child is Shape)
               {
                  (child as Shape).graphics.clear();
               }
            }
         }
      }
   }
}
