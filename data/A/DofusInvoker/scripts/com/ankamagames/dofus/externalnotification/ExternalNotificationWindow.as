package com.ankamagames.dofus.externalnotification
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.NativeWindow;
   import flash.display.NativeWindowInitOptions;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.utils.getQualifiedClassName;
   
   public class ExternalNotificationWindow extends NativeWindow
   {
      
      private static const DEBUG:Boolean = false;
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalNotificationWindow));
       
      
      private var _container:UiRootContainer;
      
      private var _notificationType:int;
      
      private var _id:String;
      
      private var _clientId:String;
      
      private var _playSound:Boolean;
      
      private var _soundId:String;
      
      private var _notify:Boolean;
      
      private var _contentWidth:Number;
      
      private var _contentHeight:Number;
      
      private var _hookName:String;
      
      private var _hookParams:Array;
      
      private var _duration:int = 0;
      
      public var timeoutId:uint;
      
      public function ExternalNotificationWindow(pExternalNotificationRequest:ExternalNotificationRequest, pWinOpts:NativeWindowInitOptions)
      {
         var mod:UiModule = UiModuleManager.getInstance().getModule("Ankama_GameUiCore");
         var notifCtr:Sprite = new Sprite();
         this._container = new UiRootContainer(stage,mod.uis[pExternalNotificationRequest.uiName],notifCtr);
         this._container.uiModule = mod;
         notifCtr.addChild(this._container);
         this._container.addEventListener(UiRenderEvent.UIRenderComplete,this.onUiLoaded);
         Berilia.getInstance().loadUiInside(this._container.uiData,pExternalNotificationRequest.instanceId,this._container,null,pExternalNotificationRequest.displayData);
         this._notificationType = pExternalNotificationRequest.notificationType;
         this._id = pExternalNotificationRequest.id;
         this._clientId = pExternalNotificationRequest.clientId;
         this._playSound = pExternalNotificationRequest.playSound;
         this._soundId = pExternalNotificationRequest.soundId;
         this._notify = pExternalNotificationRequest.notify;
         this._duration = pExternalNotificationRequest.duration;
         this._hookName = pExternalNotificationRequest.hookName;
         this._hookParams = pExternalNotificationRequest.hookParams;
         super(pWinOpts);
         visible = false;
         alwaysInFront = true;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         HumanInputHandler.getInstance().registerListeners(stage);
         stage.addChild(notifCtr);
      }
      
      private static function log(pMsg:Object) : void
      {
         if(DEBUG)
         {
            _log.debug(pMsg);
         }
      }
      
      public function get notificationType() : int
      {
         return this._notificationType;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get clientId() : String
      {
         return this._clientId;
      }
      
      public function get playSound() : Boolean
      {
         return this._playSound;
      }
      
      public function get soundId() : String
      {
         return this._soundId;
      }
      
      public function get notify() : Boolean
      {
         return this._notify;
      }
      
      public function get instanceId() : String
      {
         return this._clientId + "#" + this._id;
      }
      
      public function get contentWidth() : Number
      {
         return this._contentWidth;
      }
      
      public function get contentHeight() : Number
      {
         return this._contentHeight;
      }
      
      public function get hookName() : String
      {
         return this._hookName;
      }
      
      public function get hookParams() : Array
      {
         return this._hookParams;
      }
      
      public function get duration() : int
      {
         return this._duration;
      }
      
      private function onUiLoaded(pEvent:UiRenderEvent) : void
      {
         this._container.removeEventListener(UiRenderEvent.UIRenderComplete,this.onUiLoaded);
         this._contentWidth = this._container.contentWidth;
         this._contentHeight = this._container.contentHeight;
         ExternalNotificationManager.getInstance().addNotification(this);
      }
      
      public function show() : void
      {
         visible = true;
      }
      
      public function destroy() : void
      {
         this._container.removeEventListener(UiRenderEvent.UIRenderComplete,this.onUiLoaded);
         HumanInputHandler.getInstance().unregisterListeners(stage);
         visible = false;
         Berilia.getInstance().unloadUi(this.instanceId);
         stage.removeChildAt(0);
         close();
      }
   }
}
