package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.types.data.OldMessage;
   import com.ankamagames.berilia.types.event.HookEvent;
   import com.ankamagames.berilia.types.event.HookLogEvent;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.events.EventDispatcher;
   
   public class KernelEventsManager extends GenericEventsManager
   {
      
      private static var _self:KernelEventsManager;
       
      
      private var _aLoadingUi:Array;
      
      private var _eventDispatcher:EventDispatcher;
      
      public function KernelEventsManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("KernelEventsManager is a singleton and should not be instanciated directly.");
         }
         this._eventDispatcher = new EventDispatcher();
         this._aLoadingUi = new Array();
         Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete,this.processOldMessage);
         Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderFailed,this.processOldMessage);
      }
      
      public static function getInstance() : KernelEventsManager
      {
         if(_self == null)
         {
            _self = new KernelEventsManager();
         }
         return _self;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function isRegisteredEvent(name:String) : Boolean
      {
         return _aEvent[name] != null;
      }
      
      public function processCallback(hookName:String, ... args) : void
      {
         var s:* = null;
         var e:GenericListener = null;
         if(!Hook.checkIfHookExists(hookName))
         {
            _log.error("Hook " + hookName + " does not exist !");
            return;
         }
         FpsManager.getInstance().startTracking("hook",7108545);
         if(!UiModuleManager.getInstance().ready)
         {
            _log.warn("Hook " + hookName + " discarded");
            return;
         }
         var num:int = 0;
         var loadingUi:Array = Berilia.getInstance().loadingUi;
         for(s in loadingUi)
         {
            num++;
            if(Berilia.getInstance().loadingUi[s])
            {
               if(this._aLoadingUi[s] == null)
               {
                  this._aLoadingUi[s] = new Array();
               }
               this._aLoadingUi[s].push(new OldMessage(hookName,args));
            }
         }
         _log.logDirectly(new HookLogEvent(hookName,[]));
         ModuleLogger.log(hookName,["hook"],args);
         if(!_aEvent[hookName])
         {
            return;
         }
         for each(e in _aEvent[hookName])
         {
            if(e)
            {
               if(e.listenerType == GenericListener.LISTENER_TYPE_UI && !Berilia.getInstance().getUi(e.listener))
               {
                  _log.info("L\'UI " + e.listener + " n\'existe plus pour recevoir le hook " + e.event);
               }
               else
               {
                  ErrorManager.tryFunction(e.callback,args,"Une erreur est survenue lors du traitement du hook " + hookName);
               }
            }
         }
         if(this._eventDispatcher.hasEventListener(HookEvent.DISPATCHED))
         {
            this._eventDispatcher.dispatchEvent(new HookEvent(HookEvent.DISPATCHED,hookName));
         }
         FpsManager.getInstance().stopTracking("hook");
      }
      
      private function processOldMessage(e:UiRenderEvent) : void
      {
         var hook:String = null;
         var args:Array = null;
         var s:* = null;
         var eGl:GenericListener = null;
         if(!this._aLoadingUi[e.uiTarget.name])
         {
            return;
         }
         if(e.type == UiRenderEvent.UIRenderFailed)
         {
            this._aLoadingUi[e.uiTarget.name] = null;
            return;
         }
         for(var i:uint = 0; i < this._aLoadingUi[e.uiTarget.name].length; i++)
         {
            hook = this._aLoadingUi[e.uiTarget.name][i].hook;
            args = this._aLoadingUi[e.uiTarget.name][i].args;
            for(s in _aEvent[hook])
            {
               if(_aEvent[hook][s])
               {
                  eGl = _aEvent[hook][s];
                  if(eGl.listener == e.uiTarget.name)
                  {
                     eGl.callback.apply(null,args);
                  }
                  if(_aEvent[hook] == null)
                  {
                     break;
                  }
               }
            }
         }
         delete this._aLoadingUi[e.uiTarget.name];
      }
   }
}
