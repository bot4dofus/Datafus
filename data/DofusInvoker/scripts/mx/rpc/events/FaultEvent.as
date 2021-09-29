package mx.rpc.events
{
   import flash.events.Event;
   import mx.core.mx_internal;
   import mx.messaging.events.MessageFaultEvent;
   import mx.messaging.messages.AbstractMessage;
   import mx.messaging.messages.IMessage;
   import mx.rpc.AsyncToken;
   import mx.rpc.Fault;
   
   use namespace mx_internal;
   
   public class FaultEvent extends AbstractEvent
   {
      
      public static const FAULT:String = "fault";
       
      
      private var _fault:Fault;
      
      private var _headers:Object;
      
      private var _statusCode:int;
      
      public function FaultEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, fault:Fault = null, token:AsyncToken = null, message:IMessage = null)
      {
         super(type,bubbles,cancelable,token,message);
         if(message != null && message.headers != null)
         {
            this._statusCode = message.headers[AbstractMessage.STATUS_CODE_HEADER] as int;
         }
         this._fault = fault;
      }
      
      public static function createEventFromMessageFault(value:MessageFaultEvent, token:AsyncToken = null) : FaultEvent
      {
         var fault:Fault = new Fault(value.faultCode,value.faultString,value.faultDetail);
         fault.rootCause = value.rootCause;
         return new FaultEvent(FaultEvent.FAULT,false,true,fault,token,value.message);
      }
      
      public static function createEvent(fault:Fault, token:AsyncToken = null, msg:IMessage = null) : FaultEvent
      {
         return new FaultEvent(FaultEvent.FAULT,false,true,fault,token,msg);
      }
      
      public function get fault() : Fault
      {
         return this._fault;
      }
      
      public function get headers() : Object
      {
         return this._headers;
      }
      
      public function set headers(value:Object) : void
      {
         this._headers = value;
      }
      
      public function get statusCode() : int
      {
         return this._statusCode;
      }
      
      override public function clone() : Event
      {
         return new FaultEvent(type,bubbles,cancelable,this.fault,token,message);
      }
      
      override public function toString() : String
      {
         return formatToString("FaultEvent","fault","messageId","type","bubbles","cancelable","eventPhase");
      }
      
      override mx_internal function callTokenResponders() : void
      {
         if(token != null)
         {
            token.applyFault(this);
         }
      }
   }
}
