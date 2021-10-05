package mx.messaging.events
{
   import flash.events.Event;
   import mx.messaging.messages.ErrorMessage;
   
   public class MessageFaultEvent extends Event
   {
      
      public static const FAULT:String = "fault";
       
      
      public var message:ErrorMessage;
      
      public function MessageFaultEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, message:ErrorMessage = null)
      {
         super(type,bubbles,cancelable);
         this.message = message;
      }
      
      public static function createEvent(msg:ErrorMessage) : MessageFaultEvent
      {
         return new MessageFaultEvent(MessageFaultEvent.FAULT,false,false,msg);
      }
      
      public function get faultCode() : String
      {
         return this.message.faultCode;
      }
      
      public function get faultDetail() : String
      {
         return this.message.faultDetail;
      }
      
      public function get faultString() : String
      {
         return this.message.faultString;
      }
      
      public function get rootCause() : Object
      {
         return this.message.rootCause;
      }
      
      override public function clone() : Event
      {
         return new MessageFaultEvent(type,bubbles,cancelable,this.message);
      }
      
      override public function toString() : String
      {
         return formatToString("MessageFaultEvent","faultCode","faultDetail","faultString","rootCause","type","bubbles","cancelable","eventPhase");
      }
   }
}
