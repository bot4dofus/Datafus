package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.net.ConnectionType;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class InactivityManager
   {
      
      private static var _self:InactivityManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InactivityManager));
      
      private static const SERVER_INACTIVITY_DELAY:int = 10 * 60 * 1000;
      
      private static const SERVER_INACTIVITY_SPEED_PING_DELAY:int = 5 * 1000;
      
      private static const INACTIVITY_DELAY:int = 60 * 60 * 1000;
       
      
      private var _isAfk:Boolean;
      
      private var _activityTimer:BenchmarkTimer;
      
      private var _serverActivityTimer:BenchmarkTimer;
      
      private var _hasActivity:Boolean = false;
      
      public function InactivityManager()
      {
         super();
         this._activityTimer = new BenchmarkTimer(INACTIVITY_DELAY,0,"InactivityManager._activityTimer");
         this._serverActivityTimer = new BenchmarkTimer(SERVER_INACTIVITY_DELAY,0,"InactivityManager._serverActivityTimer");
         this.resetActivity();
         this.resetServerActivity();
      }
      
      public static function getInstance() : InactivityManager
      {
         if(!_self)
         {
            _self = new InactivityManager();
         }
         return _self;
      }
      
      private static function serverNotification() : void
      {
         var msg:BasicPingMessage = null;
         if(ConnectionsHandler.getConnection().connected)
         {
            msg = new BasicPingMessage();
            msg.initBasicPingMessage(true);
            ConnectionsHandler.getConnection().send(msg,ConnectionType.TO_ALL_SERVERS);
         }
      }
      
      public function get inactivityDelay() : Number
      {
         return this._activityTimer.delay;
      }
      
      public function set inactivityDelay(t:Number) : void
      {
         this._activityTimer.delay = t;
         this.resetActivity();
      }
      
      public function start() : void
      {
         this.resetActivity();
         this.resetServerActivity();
         StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
         StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onActivity);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
         this._isAfk = false;
      }
      
      public function stop() : void
      {
         this._activityTimer.stop();
         this._activityTimer.removeEventListener(TimerEvent.TIMER,this.onActivityTimerUp);
         this._serverActivityTimer.stop();
         this._serverActivityTimer.removeEventListener(TimerEvent.TIMER,this.onServerActivityTimerUp);
         StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
         StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onActivity);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
      }
      
      public function resetActivity() : void
      {
         this._activityTimer.reset();
         this._activityTimer.start();
         this._activityTimer.addEventListener(TimerEvent.TIMER,this.onActivityTimerUp);
      }
      
      public function resetServerActivity() : void
      {
         this._serverActivityTimer.reset();
         this._serverActivityTimer.start();
         this._serverActivityTimer.addEventListener(TimerEvent.TIMER,this.onServerActivityTimerUp);
      }
      
      public function updateServerInactivityDelay() : void
      {
         var serverInactivityDelay:int = SERVER_INACTIVITY_DELAY;
         var featureManager:FeatureManager = FeatureManager.getInstance();
         if(featureManager && featureManager.isFeatureWithKeywordEnabled("system.fastPing"))
         {
            serverInactivityDelay = SERVER_INACTIVITY_SPEED_PING_DELAY;
         }
         this._serverActivityTimer.stop();
         this._serverActivityTimer.removeEventListener(TimerEvent.TIMER,this.onServerActivityTimerUp);
         this._serverActivityTimer = new BenchmarkTimer(serverInactivityDelay,0,"InactivityManager._serverActivityTimer (updateServerinactivityDelay)");
         this.resetServerActivity();
      }
      
      public function activity() : void
      {
         this.resetActivity();
         this._hasActivity = true;
         if(this._isAfk)
         {
            this._isAfk = false;
            KernelEventsManager.getInstance().processCallback(HookList.InactivityNotification,false);
         }
      }
      
      private function onActivity(event:Event) : void
      {
         this.activity();
      }
      
      private function onActivityTimerUp(event:Event) : void
      {
         this._isAfk = true;
         KernelEventsManager.getInstance().processCallback(HookList.InactivityNotification,true);
      }
      
      private function onServerActivityTimerUp(event:Event) : void
      {
         if(this._hasActivity)
         {
            this._hasActivity = false;
            serverNotification();
         }
         this.resetServerActivity();
      }
   }
}
