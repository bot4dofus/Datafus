package mx.messaging.events
{
   import flash.events.Event;
   import mx.messaging.messages.AcknowledgeMessage;
   import mx.messaging.messages.IMessage;
   
   public class MessageAckEvent extends MessageEvent
   {
      
      public static const ACKNOWLEDGE:String = "acknowledge";
       
      
      public var correlation:IMessage;
      
      public function MessageAckEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, ack:AcknowledgeMessage = null, correlation:IMessage = null)
      {
         super(type,bubbles,cancelable,ack);
         this.correlation = correlation;
      }
      
      public static function createEvent(ack:AcknowledgeMessage = null, correlation:IMessage = null) : MessageAckEvent
      {
         return new MessageAckEvent(MessageAckEvent.ACKNOWLEDGE,false,false,ack,correlation);
      }
      
      public function get acknowledgeMessage() : AcknowledgeMessage
      {
         return message as AcknowledgeMessage;
      }
      
      public function get correlationId() : String
      {
         if(this.correlation != null)
         {
            return this.correlation.messageId;
         }
         return null;
      }
      
      override public function clone() : Event
      {
         return new MessageAckEvent(type,bubbles,cancelable,message as AcknowledgeMessage,this.correlation);
      }
      
      override public function toString() : String
      {
         return formatToString("MessageAckEvent","messageId","correlationId","type","bubbles","cancelable","eventPhase");
      }
   }
}
