package mx.messaging.events
{
   import flash.events.Event;
   import mx.messaging.messages.IMessage;
   
   public class MessageEvent extends Event
   {
      
      public static const MESSAGE:String = "message";
      
      public static const RESULT:String = "result";
       
      
      public var message:IMessage;
      
      public function MessageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, message:IMessage = null)
      {
         super(type,bubbles,cancelable);
         this.message = message;
      }
      
      public static function createEvent(type:String, msg:IMessage) : MessageEvent
      {
         return new MessageEvent(type,false,false,msg);
      }
      
      public function get messageId() : String
      {
         if(this.message != null)
         {
            return this.message.messageId;
         }
         return null;
      }
      
      override public function clone() : Event
      {
         return new MessageEvent(type,bubbles,cancelable,this.message);
      }
      
      override public function toString() : String
      {
         return formatToString("MessageEvent","messageId","type","bubbles","cancelable","eventPhase");
      }
   }
}
