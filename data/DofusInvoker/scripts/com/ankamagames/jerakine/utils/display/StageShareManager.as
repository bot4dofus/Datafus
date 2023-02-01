package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.benchmark.FileLoggerEnum;
   import com.ankamagames.jerakine.benchmark.LogInFile;
   import flash.display.DisplayObjectContainer;
   import flash.display.NativeWindow;
   import flash.display.NativeWindowDisplayState;
   import flash.display.Stage;
   import flash.display.StageDisplayState;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.NativeWindowDisplayStateEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class StageShareManager
   {
      
      private static const NOT_INITIALIZED:int = -77777;
      
      private static var _stage:Stage;
      
      private static var _startWidth:uint;
      
      private static var _startHeight:uint;
      
      private static var _rootContainer:DisplayObjectContainer;
      
      private static var _customMouseX:int = NOT_INITIALIZED;
      
      private static var _customMouseY:int = NOT_INITIALIZED;
      
      private static var _setQualityIsEnable:Boolean;
      
      private static var _chrome:Point = new Point();
      
      private static var _mouseOnStage:Boolean;
      
      private static var _isActive:Boolean;
      
      public static var shortcutUsedToExitFullScreen:Boolean = false;
      
      public static var stageLogicalBounds:Rectangle;
      
      private static const _stageVisibleBoundCache:Rectangle = new Rectangle();
      
      public static var isGoingFullScreen:Boolean = false;
       
      
      public function StageShareManager()
      {
         super();
      }
      
      public static function set rootContainer(d:DisplayObjectContainer) : void
      {
         _rootContainer = d;
      }
      
      public static function get rootContainer() : DisplayObjectContainer
      {
         return _rootContainer;
      }
      
      public static function get stage() : Stage
      {
         return _stage;
      }
      
      public static function get windowScale() : Number
      {
         var stageWidth:Number = NaN;
         var stageHeight:Number = NaN;
         var chromeX:Number = NaN;
         var chromeY:Number = NaN;
         var fullscreen:Boolean = isFullscreen;
         if(!stage.nativeWindow.closed)
         {
            chromeX = !!fullscreen ? Number(0) : Number(chrome.x);
            chromeY = !!fullscreen ? Number(0) : Number(chrome.y);
            stageWidth = (stage.nativeWindow.width - chromeX) / startWidth;
            stageHeight = (stage.nativeWindow.height - chromeY) / startHeight;
         }
         return Number(Math.min(stageWidth,stageHeight));
      }
      
      public static function get stageVisibleBounds() : Rectangle
      {
         var windowWidth:Number = NaN;
         var windowHeight:Number = NaN;
         var fullscreen:Boolean = isFullscreen;
         if(!stage.nativeWindow.closed)
         {
            windowWidth = stage.nativeWindow.width - (!!fullscreen ? 0 : chrome.x);
            windowHeight = stage.nativeWindow.height - (!!fullscreen ? 0 : chrome.y);
         }
         var stageWidthScale:Number = windowWidth / startWidth;
         var stageHeightScale:Number = windowHeight / startHeight;
         if(stageWidthScale > stageHeightScale)
         {
            _stageVisibleBoundCache.width = Math.max(windowWidth / stageHeightScale,startWidth);
            _stageVisibleBoundCache.height = startHeight;
            _stageVisibleBoundCache.x = (startWidth - _stageVisibleBoundCache.width) / 2;
            _stageVisibleBoundCache.y = 0;
         }
         else
         {
            _stageVisibleBoundCache.width = startWidth;
            _stageVisibleBoundCache.height = Math.max(windowHeight * stageWidthScale,startHeight);
            _stageVisibleBoundCache.x = 0;
            _stageVisibleBoundCache.y = (startHeight - _stageVisibleBoundCache.height) / 2;
         }
         if(_stageVisibleBoundCache.width > stageLogicalBounds.width)
         {
            _stageVisibleBoundCache.width = stageLogicalBounds.width;
         }
         var rightMargin:Number = -(stageLogicalBounds.width - _startWidth) / 2;
         if(_stageVisibleBoundCache.x < rightMargin)
         {
            _stageVisibleBoundCache.x = rightMargin;
         }
         return _stageVisibleBoundCache;
      }
      
      public static function set stage(value:Stage) : void
      {
         _stage = value;
         _startWidth = 1280;
         _startHeight = 1024;
         stageLogicalBounds = new Rectangle(0,0,_startWidth,_startHeight);
         if(!_stage.nativeWindow)
         {
            return;
         }
         _stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,displayStateChangeHandler);
         LogInFile.getInstance().logLine("StageShareManager _stage.addEventListener onStageMouseLeave",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("StageShareManager _stage.addEventListener onStageMouseMove",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("StageShareManager _stage.addEventListener onActivate",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("StageShareManager _stage.addEventListener onDeactivate",FileLoggerEnum.EVENTLISTENERS);
         _stage.addEventListener(Event.MOUSE_LEAVE,onStageMouseLeave);
         _stage.addEventListener(MouseEvent.MOUSE_MOVE,onStageMouseMove);
         _stage.addEventListener(Event.ACTIVATE,onActivate);
         _stage.addEventListener(Event.DEACTIVATE,onDeactivate);
      }
      
      public static function testQuality() : void
      {
         var oldQuality:String = _stage.quality;
         _stage.quality = StageQuality.MEDIUM;
         _setQualityIsEnable = _stage.quality.toLowerCase() == StageQuality.MEDIUM;
         _stage.quality = oldQuality;
      }
      
      public static function setFullScreen(enabled:Boolean, onlyMaximize:Boolean = false) : void
      {
         isGoingFullScreen = enabled && !onlyMaximize;
         if(enabled)
         {
            if(!onlyMaximize)
            {
               StageShareManager.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            }
            else
            {
               StageShareManager.stage.nativeWindow.maximize();
            }
         }
         else if(isFullscreen)
         {
            if(!onlyMaximize)
            {
               StageShareManager.stage.displayState = StageDisplayState.NORMAL;
            }
            else
            {
               StageShareManager.stage.nativeWindow.minimize();
            }
         }
      }
      
      public static function get startWidth() : uint
      {
         return _startWidth;
      }
      
      public static function get startHeight() : uint
      {
         return _startHeight;
      }
      
      public static function get setQualityIsEnable() : Boolean
      {
         return _setQualityIsEnable;
      }
      
      public static function get mouseX() : int
      {
         if(_customMouseX == NOT_INITIALIZED)
         {
            return _rootContainer.mouseX;
         }
         return _customMouseX;
      }
      
      public static function set mouseX(v:int) : void
      {
         _customMouseX = v;
      }
      
      public static function get mouseY() : int
      {
         if(_customMouseY == NOT_INITIALIZED)
         {
            return _rootContainer.mouseY;
         }
         return _customMouseY;
      }
      
      public static function set mouseY(v:int) : void
      {
         _customMouseY = v;
      }
      
      public static function get stageOffsetX() : int
      {
         return _rootContainer.x;
      }
      
      public static function get stageOffsetY() : int
      {
         return _rootContainer.y;
      }
      
      public static function get stageScaleX() : Number
      {
         return _rootContainer.scaleX;
      }
      
      public static function get stageScaleY() : Number
      {
         return _rootContainer.scaleY;
      }
      
      public static function get mouseOnStage() : Boolean
      {
         return _mouseOnStage;
      }
      
      public static function get chrome() : Point
      {
         return _chrome;
      }
      
      public static function set chrome(value:Point) : void
      {
         _chrome = value;
      }
      
      public static function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public static function get isFullscreen() : Boolean
      {
         return _stage.displayState.toLowerCase().indexOf("fullscreen") == 0;
      }
      
      private static function displayStateChangeHandler(event:NativeWindowDisplayStateEvent) : void
      {
         var nativeWindow:NativeWindow = null;
         if(event.beforeDisplayState == NativeWindowDisplayState.MINIMIZED)
         {
            nativeWindow = _stage.nativeWindow;
            if(event.afterDisplayState == NativeWindowDisplayState.NORMAL || event.afterDisplayState == NativeWindowDisplayState.MAXIMIZED)
            {
               --nativeWindow.width;
               nativeWindow.width += 1;
               if(event.afterDisplayState == NativeWindowDisplayState.MAXIMIZED)
               {
                  nativeWindow.maximize();
               }
            }
         }
      }
      
      private static function onStageMouseLeave(pEvent:Event) : void
      {
         LogInFile.getInstance().logLine("StageShareManager onStageMouseLeave",FileLoggerEnum.EVENTLISTENERS);
         _mouseOnStage = false;
      }
      
      private static function onStageMouseMove(pEvent:MouseEvent) : void
      {
         LogInFile.getInstance().logLine("StageShareManager onStageMouseMove",FileLoggerEnum.EVENTLISTENERS);
         _mouseOnStage = true;
      }
      
      private static function onActivate(event:Event) : void
      {
         LogInFile.getInstance().logLine("StageShareManager onActivate",FileLoggerEnum.EVENTLISTENERS);
         _isActive = true;
      }
      
      private static function onDeactivate(event:Event) : void
      {
         LogInFile.getInstance().logLine("StageShareManager onDeactivate",FileLoggerEnum.EVENTLISTENERS);
         _isActive = false;
      }
   }
}
