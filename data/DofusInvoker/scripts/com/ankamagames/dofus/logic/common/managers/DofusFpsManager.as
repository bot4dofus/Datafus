package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.types.DofusOptions;
   import com.ankamagames.dofus.types.data.FpsLogWrapper;
   import com.ankamagames.jerakine.managers.PerformanceManager;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.tiphon.engine.TiphonDebugManager;
   import flash.desktop.NativeApplication;
   import flash.display.NativeWindow;
   import flash.display.NativeWindowDisplayState;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.NativeWindowDisplayStateEvent;
   import flash.utils.getTimer;
   
   public class DofusFpsManager
   {
      
      private static var _animFPS:int = 25;
      
      private static var _interval:int = 1000 / _animFPS;
      
      private static var _framePlayed:int = 0;
      
      private static var _frameNeeded:int = 0;
      
      public static var currentFps:Number;
      
      public static var allowSkipFrame:Boolean = true;
      
      private static var _elapsedTime:uint;
      
      private static var _lastTime:uint;
      
      private static var _frame:uint;
      
      private static var _logWrapped:FpsLogWrapper;
      
      private static var _logRamWrapped:FpsLogWrapper;
       
      
      public function DofusFpsManager()
      {
         super();
      }
      
      public static function init() : void
      {
         EnterFrameDispatcher.addEventListener(onEnterFrame,EnterFrameConst.DOFUS_FPS_MANAGER);
         StageShareManager.stage.addEventListener(Event.ACTIVATE,onActivate);
         StageShareManager.stage.addEventListener(Event.DEACTIVATE,onDesactivate);
         NativeApplication.nativeApplication.openedWindows[0].addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,onStateChange);
         _logWrapped = new FpsLogWrapper();
         _logRamWrapped = new FpsLogWrapper();
         if(BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG || BuildInfos.BUILD_TYPE == BuildTypeEnum.INTERNAL)
         {
            TiphonDebugManager.enable();
         }
      }
      
      public static function updateFocusList(focusList:Array, clientId:String) : void
      {
         var lastFocus:String = null;
         var lastTime:Number = NaN;
         var time:Number = NaN;
         var nativeWindow:NativeWindow = NativeApplication.nativeApplication.openedWindows[0];
         if(nativeWindow && nativeWindow["displayState"] == NativeWindowDisplayState.MINIMIZED)
         {
            setStageFrameRate(12);
            return;
         }
         var num:int = focusList.length;
         for(var i:int = 0; i < num; i += 2)
         {
            if(lastFocus == null)
            {
               lastFocus = focusList[i];
               lastTime = Number(focusList[i + 1]);
            }
            else
            {
               time = Number(focusList[i + 1]);
               if(lastTime < time)
               {
                  lastFocus = focusList[i];
                  lastTime = time;
               }
            }
         }
         if(clientId == lastFocus)
         {
            setStageFrameRate(PerformanceManager.BASE_FRAMERATE);
         }
         else if(!StageShareManager.isActive)
         {
            setStageFrameRate(12);
         }
      }
      
      private static function onActivate(e:Event) : void
      {
         setStageFrameRate(PerformanceManager.BASE_FRAMERATE);
         var options:DofusOptions = Dofus.getInstance().options;
         if(options && options.getOption("optimizeMultiAccount"))
         {
            InterClientManager.getInstance().gainFocus();
         }
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER,onStageRollOver);
      }
      
      private static function onDesactivate(e:Event) : void
      {
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OVER,onStageRollOver);
      }
      
      private static function onStageRollOver(e:Event) : void
      {
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER,onStageRollOver);
         setStageFrameRate(PerformanceManager.BASE_FRAMERATE);
      }
      
      private static function onStateChange(e:NativeWindowDisplayStateEvent) : void
      {
         var options:DofusOptions = Dofus.getInstance().options;
         if(options && options.getOption("optimizeMultiAccount"))
         {
            if(e.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
            {
               setStageFrameRate(12);
               InterClientManager.getInstance().resetFocus();
            }
            else
            {
               setStageFrameRate(PerformanceManager.BASE_FRAMERATE);
            }
         }
      }
      
      private static function onEnterFrame(e:Event) : void
      {
         var numFrame:int = 0;
         var i:int = 0;
         var time:int = getTimer();
         _elapsedTime += time - _lastTime;
         ++_frame;
         if(_elapsedTime > 1000)
         {
            currentFps = _frame / (_elapsedTime / 1000);
            _elapsedTime = 0;
            _frame = 0;
         }
         if(allowSkipFrame)
         {
            _frameNeeded = time / _interval;
            numFrame = _frameNeeded - _framePlayed;
            if(numFrame)
            {
               _framePlayed = _frameNeeded;
               for(i = 0; i < numFrame; i++)
               {
                  FpsControler.nextFrame();
               }
            }
         }
         else
         {
            _frameNeeded = 1;
            FpsControler.nextFrame();
         }
         _lastTime = time;
      }
      
      private static function setStageFrameRate(framerate:uint) : void
      {
         EnterFrameDispatcher.maxAllowedTime = Math.ceil(1000 / framerate);
         StageShareManager.stage.frameRate = framerate;
      }
   }
}
