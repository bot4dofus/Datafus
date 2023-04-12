package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.types.graphic.ExternalUi;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.desktop.NativeApplication;
   import flash.display.NativeWindow;
   import flash.events.Event;
   import flash.events.NativeWindowDisplayStateEvent;
   
   public class ExternalUiManager
   {
      
      private static var _instance:ExternalUiManager;
       
      
      public function ExternalUiManager()
      {
         super();
         NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,this.onWindowFocus,false,0,true);
         StageShareManager.stage.nativeWindow.addEventListener(Event.ACTIVATE,this.onWindowFocus,false,0,true);
         StageShareManager.stage.nativeWindow.addEventListener(Event.CLOSING,this.onMainWindowClose,false,0,true);
         StageShareManager.stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onWindowFocus,false,0,true);
      }
      
      public static function getInstance() : ExternalUiManager
      {
         if(!_instance)
         {
            _instance = new ExternalUiManager();
         }
         return _instance;
      }
      
      protected function onMainWindowClose(event:Event) : void
      {
         var w:NativeWindow = null;
         var windows:Array = NativeApplication.nativeApplication.openedWindows;
         for each(w in windows)
         {
            if(!w.closed)
            {
               w.close();
            }
         }
      }
      
      public function registerExternalUi(eui:ExternalUi) : void
      {
         eui.addEventListener(Event.ACTIVATE,this.onWindowFocus,false,0,true);
         eui.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onWindowFocus,false,0,true);
      }
      
      public function unregisterExternalUi(eui:ExternalUi) : void
      {
         eui.removeEventListener(Event.ACTIVATE,this.onWindowFocus);
         eui.removeEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onWindowFocus);
      }
      
      protected function onWindowFocus(event:Event) : void
      {
         var w:NativeWindow = null;
         var windows:Array = NativeApplication.nativeApplication.openedWindows;
         for each(w in windows)
         {
            if(w != StageShareManager.stage.nativeWindow)
            {
               w.orderInFrontOf(StageShareManager.stage.nativeWindow);
            }
         }
      }
   }
}
