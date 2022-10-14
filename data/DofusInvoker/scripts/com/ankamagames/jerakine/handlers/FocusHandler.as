package com.ankamagames.jerakine.handlers
{
   import com.ankamagames.jerakine.handlers.messages.FocusChangeMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Worker;
   import com.ankamagames.jerakine.pools.GenericPool;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.display.InteractiveObject;
   import flash.utils.getQualifiedClassName;
   
   public class FocusHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FocusHandler));
      
      private static var _self:FocusHandler;
      
      private static var _currentFocus:WeakReference;
       
      
      private var _handler:Worker;
      
      public function FocusHandler()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("FocusHandler constructor should not be called directly.");
         }
         StageShareManager.stage.stageFocusRect = false;
      }
      
      public static function getInstance() : FocusHandler
      {
         if(_self == null)
         {
            _self = new FocusHandler();
         }
         return _self;
      }
      
      public function get handler() : Worker
      {
         return this._handler;
      }
      
      public function set handler(value:Worker) : void
      {
         this._handler = value;
      }
      
      public function setFocus(target:InteractiveObject) : void
      {
         if(this._handler)
         {
            _currentFocus = new WeakReference(target);
            this._handler.processImmediately(GenericPool.get(FocusChangeMessage,!!_currentFocus ? _currentFocus.object as InteractiveObject : null));
         }
      }
      
      public function getFocus() : InteractiveObject
      {
         return !!_currentFocus ? _currentFocus.object as InteractiveObject : null;
      }
      
      public function hasFocus(io:InteractiveObject) : Boolean
      {
         if(_currentFocus)
         {
            return _currentFocus.object == io;
         }
         return false;
      }
   }
}
