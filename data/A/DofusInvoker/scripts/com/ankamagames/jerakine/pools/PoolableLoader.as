package com.ankamagames.jerakine.pools
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.utils.getQualifiedClassName;
   
   public class PoolableLoader extends Loader implements Poolable
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PoolableLoader));
       
      
      public var loadCompleted:Boolean;
      
      public function PoolableLoader()
      {
         this.loadCompleted = false;
         super();
         uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,ErrorManager.onUncaughtError);
      }
      
      public function delayedCheckIn() : void
      {
         contentLoaderInfo.addEventListener(Event.COMPLETE,this.onDone);
         contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onDone);
      }
      
      public function free() : void
      {
         unload();
         this.loadCompleted = false;
      }
      
      protected function onDone(event:Event) : void
      {
         contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onDone);
         contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onDone);
         PoolsManager.getInstance().getLoadersPool().checkIn(this);
      }
   }
}
