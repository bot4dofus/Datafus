package mx.rpc.events
{
   import flash.events.Event;
   import mx.messaging.messages.IMessage;
   import mx.rpc.AsyncToken;
   
   public class InvokeEvent extends AbstractEvent
   {
      
      public static const INVOKE:String = "invoke";
       
      
      public function InvokeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, token:AsyncToken = null, message:IMessage = null)
      {
         super(type,bubbles,cancelable,token,message);
      }
      
      public static function createEvent(token:AsyncToken = null, message:IMessage = null) : InvokeEvent
      {
         return new InvokeEvent(InvokeEvent.INVOKE,false,false,token,message);
      }
      
      override public function clone() : Event
      {
         return new InvokeEvent(type,bubbles,cancelable,token,message);
      }
      
      override public function toString() : String
      {
         return formatToString("InvokeEvent","messageId","type","bubbles","cancelable","eventPhase");
      }
   }
}
