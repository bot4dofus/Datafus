package org.flintparticles.common.utils
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   import org.flintparticles.common.events.UpdateEvent;
   
   public class FrameUpdater extends EventDispatcher
   {
      
      private static var _instance:FrameUpdater;
       
      
      private var _shape:Shape;
      
      private var _time:Number;
      
      public function FrameUpdater()
      {
         super();
         this._shape = new Shape();
         this._shape.addEventListener(Event.ENTER_FRAME,this.frameUpdate,false,0,true);
         this._time = getTimer();
      }
      
      public static function get instance() : FrameUpdater
      {
         if(_instance == null)
         {
            _instance = new FrameUpdater();
         }
         return _instance;
      }
      
      private function frameUpdate(ev:Event) : void
      {
         var oldTime:int = this._time;
         this._time = getTimer();
         var frameTime:Number = (this._time - oldTime) * 0.001;
         dispatchEvent(new UpdateEvent(UpdateEvent.UPDATE,frameTime));
      }
   }
}
