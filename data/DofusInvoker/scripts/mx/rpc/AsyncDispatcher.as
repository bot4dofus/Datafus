package mx.rpc
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   [ExcludeClass]
   public class AsyncDispatcher
   {
       
      
      private var _method:Function;
      
      private var _args:Array;
      
      private var _timer:Timer;
      
      public function AsyncDispatcher(method:Function, args:Array, delay:Number)
      {
         super();
         this._method = method;
         this._args = args;
         this._timer = new Timer(delay);
         this._timer.addEventListener(TimerEvent.TIMER,this.timerEventHandler);
         this._timer.start();
      }
      
      private function timerEventHandler(event:TimerEvent) : void
      {
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.timerEventHandler);
         this._method.apply(null,this._args);
      }
   }
}
