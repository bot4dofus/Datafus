package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class AFKFightManager
   {
      
      private static var _self:AFKFightManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AFKFightManager));
       
      
      private var _enabled:Boolean;
      
      private var _confirm:Boolean;
      
      private var _afkSecurity:BenchmarkTimer;
      
      private var _securityTimerUp:Boolean;
      
      public var lastTurnSkip:int;
      
      public function AFKFightManager()
      {
         this._afkSecurity = new BenchmarkTimer(5000,0,"AFKFightManager._afkSecurity");
         super();
         this._enabled = false;
      }
      
      public static function getInstance() : AFKFightManager
      {
         if(!_self)
         {
            _self = new AFKFightManager();
         }
         return _self;
      }
      
      public function initialize() : void
      {
         this._confirm = false;
         this.enabled = true;
      }
      
      public function set enabled(e:Boolean) : void
      {
         if(e == this._enabled)
         {
            return;
         }
         if(!e)
         {
            this.confirm = false;
         }
         this._enabled = e;
         if(this._enabled)
         {
            _log.info("looking for mouse or keybord activity");
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
            StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onActivity);
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
            this._securityTimerUp = false;
            this._afkSecurity.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._afkSecurity.start();
         }
         else
         {
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onActivity);
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
            this._afkSecurity.stop();
            this._afkSecurity.removeEventListener(TimerEvent.TIMER,this.onTimer);
         }
      }
      
      public function set confirm(confirmed:Boolean) : void
      {
         this._afkSecurity.stop();
         this._afkSecurity.removeEventListener(TimerEvent.TIMER,this.onTimer);
         if(this.enabled || !confirmed)
         {
            if(this._confirm != confirmed)
            {
               if(confirmed && !this._securityTimerUp)
               {
                  this.enabled = false;
                  return;
               }
               if(confirmed)
               {
                  _log.info("AFK mode enabled");
               }
               else
               {
                  _log.info("AFK mode disabled");
               }
               KernelEventsManager.getInstance().processCallback(FightHookList.AfkModeChanged,confirmed);
            }
            this._confirm = confirmed;
         }
      }
      
      public function get isAfk() : Boolean
      {
         return this._enabled && this._confirm;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      private function onActivity(event:Event) : void
      {
         _log.info("Activity detected. Player is not AFK");
         this.confirm = false;
         this.enabled = false;
      }
      
      private function onTimer(event:Event) : void
      {
         this._securityTimerUp = true;
      }
   }
}
