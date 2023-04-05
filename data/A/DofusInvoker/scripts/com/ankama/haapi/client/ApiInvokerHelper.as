package com.ankama.haapi.client
{
   import flash.events.EventDispatcher;
   import org.openapitools.event.ApiClientEvent;
   
   public class ApiInvokerHelper extends EventDispatcher
   {
       
      
      private var _invokeFunction:Function;
      
      public function ApiInvokerHelper(invokeFunction:Function)
      {
         super();
         this._invokeFunction = invokeFunction;
      }
      
      public function onSuccess(callback:Function) : ApiInvokerHelper
      {
         addEventListener(ApiClientEvent.SUCCESS_EVENT,callback);
         return this;
      }
      
      public function onError(callback:Function) : ApiInvokerHelper
      {
         addEventListener(ApiClientEvent.FAILURE_EVENT,callback);
         return this;
      }
      
      public function call() : void
      {
         this._invokeFunction.apply(null,[this]);
      }
   }
}
