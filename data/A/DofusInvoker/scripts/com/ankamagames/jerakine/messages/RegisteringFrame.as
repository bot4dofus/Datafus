package com.ankamagames.jerakine.messages
{
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import flash.errors.IllegalOperationError;
   import flash.utils.Dictionary;
   
   public class RegisteringFrame implements Frame
   {
       
      
      private var _allowsRegistration:Boolean;
      
      private var _registeredTypes:Dictionary;
      
      protected var _priority:int = 1;
      
      public function RegisteringFrame()
      {
         super();
         this.initialize();
      }
      
      public function get priority() : int
      {
         return this._priority;
      }
      
      public function process(msg:Message) : Boolean
      {
         var handler:Function = this._registeredTypes[msg["constructor"]];
         if(handler != null)
         {
            return handler(msg);
         }
         return false;
      }
      
      protected function registerMessages() : void
      {
         throw new AbstractMethodCallError();
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      protected function register(type:Class, handler:Function) : void
      {
         if(!this._allowsRegistration || !type)
         {
            throw new IllegalOperationError();
         }
         if(this._registeredTypes[type])
         {
            throw new IllegalOperationError("Cannot register twice a message");
         }
         this._registeredTypes[type] = handler;
      }
      
      private function initialize() : void
      {
         this._registeredTypes = new Dictionary();
         this._allowsRegistration = true;
         this.registerMessages();
         this._allowsRegistration = false;
      }
   }
}
