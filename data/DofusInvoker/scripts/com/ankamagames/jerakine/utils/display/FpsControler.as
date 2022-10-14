package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class FpsControler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FpsControler));
      
      private static var ScriptedAnimation:Class;
      
      private static var _clipList:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private static var _garbageTimer:BenchmarkTimer;
       
      
      public function FpsControler()
      {
         super();
      }
      
      public static function Init(scriptedAnimation:Class) : void
      {
         ScriptedAnimation = scriptedAnimation;
         if(!_garbageTimer)
         {
            _garbageTimer = new BenchmarkTimer(10000,0,"FpsControler._garbageTimer");
            _garbageTimer.addEventListener(TimerEvent.TIMER,onGarbageTimer);
            _garbageTimer.start();
         }
      }
      
      private static function onGarbageTimer(E:Event) : void
      {
         var movieClip:MovieClip = null;
         for(var i:int = 0; i < _clipList.length; i++)
         {
            movieClip = _clipList[i];
            if(!movieClip.stage)
            {
               uncontrolFps(movieClip,false);
            }
         }
      }
      
      public static function controlFps(clip:MovieClip, framerate:uint, forbidRecursivity:Boolean = false) : MovieClip
      {
         if(!MovieClipUtils.isSingleFrame(clip))
         {
            controlSingleClip(clip,framerate,forbidRecursivity);
         }
         return clip;
      }
      
      public static function controlFpsNoLoop(clip:MovieClip, framerate:uint) : void
      {
         if(!MovieClipUtils.isSingleFrame(clip))
         {
            controlSingleClip(clip,framerate,false,false,true);
         }
      }
      
      public static function uncontrolFps(displayObject:DisplayObjectContainer, group:Boolean = true) : void
      {
         var i:int = 0;
         var child:MovieClip = null;
         if(!displayObject)
         {
            return;
         }
         MovieClipUtils.stopMovieClip(displayObject);
         var movieClip:MovieClip = displayObject as MovieClip;
         if(group && movieClip)
         {
            if(_clipList.indexOf(movieClip) != -1)
            {
               for(i = 0; i < movieClip.numChildren; i++)
               {
                  child = movieClip.getChildAt(i) as MovieClip;
                  if(child)
                  {
                     uncontrolFps(child,group);
                  }
               }
            }
         }
         removeClip(movieClip);
      }
      
      public static function containsFps(clip:DisplayObjectContainer) : Boolean
      {
         if(clip is MovieClip)
         {
            return _clipList.indexOf(clip) != -1;
         }
         return false;
      }
      
      private static function removeClip(mc:MovieClip) : void
      {
         var index:int = _clipList.indexOf(mc);
         if(index != -1)
         {
            _clipList.splice(index,1);
         }
      }
      
      private static function controlSingleClip(clip:DisplayObjectContainer, framerate:uint, forbidRecursivity:Boolean = false, recursive:Boolean = false, noLoop:Boolean = false) : void
      {
         var movieClip:MovieClip = null;
         var i:int = 0;
         var numChildren:int = 0;
         var child:DisplayObjectContainer = null;
         if(clip && !forbidRecursivity)
         {
            i = -1;
            numChildren = clip.numChildren;
            while(++i < numChildren)
            {
               child = clip.getChildAt(i) as DisplayObjectContainer;
               if(child)
               {
                  controlSingleClip(child,framerate,true,true,noLoop);
               }
            }
         }
         if(recursive && clip is ScriptedAnimation)
         {
            return;
         }
         movieClip = clip as MovieClip;
         if(!movieClip || movieClip.totalFrames == 1 || _clipList.indexOf(movieClip) != -1)
         {
            return;
         }
         var startFrame:int = movieClip.currentFrame > 0 ? int(movieClip.currentFrame) : 1;
         movieClip.gotoAndStop(startFrame);
         if(movieClip is ScriptedAnimation)
         {
            movieClip.playEventAtFrame(startFrame);
         }
         if(noLoop)
         {
            movieClip.addFrameScript(movieClip.totalFrames - 1,function():void
            {
               FpsControler.uncontrolFps(movieClip);
            });
         }
         _clipList.push(movieClip);
      }
      
      public static function nextFrame() : void
      {
         var movieClip:MovieClip = null;
         var frame:int = 0;
         var diff:int = 0;
         var num:int = _clipList.length;
         var i:int = -1;
         while(++i < num)
         {
            movieClip = _clipList[i];
            frame = movieClip.currentFrame + 1;
            if(frame > movieClip.totalFrames)
            {
               frame = 1;
            }
            movieClip.gotoAndStop(frame);
            if(movieClip is ScriptedAnimation)
            {
               movieClip.playEventAtFrame(frame);
            }
            diff = num - _clipList.length;
            if(diff)
            {
               num -= diff;
               i -= diff;
               if(i < 0)
               {
                  i = 0;
               }
            }
         }
      }
   }
}
