package com.ankamagames.jerakine.handlers.messages
{
   import com.ankamagames.jerakine.messages.DiscardableMessage;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.pools.Poolable;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   
   public class HumanInputMessage implements Message, DiscardableMessage, Poolable
   {
       
      
      protected var _target:InteractiveObject;
      
      protected var _nativeEvent:Event;
      
      private var _canceled:Boolean;
      
      public var bubbling:Boolean;
      
      public function HumanInputMessage()
      {
         super();
      }
      
      public static function create(target:InteractiveObject, nativeEvent:Event, instance:HumanInputMessage = null) : HumanInputMessage
      {
         if(!instance)
         {
            instance = new HumanInputMessage();
         }
         instance._target = target;
         instance._nativeEvent = nativeEvent;
         return instance;
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function get canceled() : Boolean
      {
         return this._canceled;
      }
      
      public function set canceled(value:Boolean) : void
      {
         if(this.bubbling)
         {
            throw new InvalidCancelError("Can\'t cancel a bubbling message.");
         }
         if(this._canceled && !value)
         {
            throw new InvalidCancelError("Can\'t uncancel a canceled message.");
         }
         this._canceled = value;
      }
      
      public function free() : void
      {
         this._target = null;
         this._nativeEvent = null;
      }
   }
}
