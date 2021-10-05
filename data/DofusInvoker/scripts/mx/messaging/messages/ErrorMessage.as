package mx.messaging.messages
{
   public class ErrorMessage extends AcknowledgeMessage
   {
      
      public static const MESSAGE_DELIVERY_IN_DOUBT:String = "Client.Error.DeliveryInDoubt";
      
      public static const RETRYABLE_HINT_HEADER:String = "DSRetryableErrorHint";
       
      
      public var faultCode:String;
      
      public var faultString:String;
      
      public var faultDetail:String;
      
      public var rootCause:Object;
      
      public var extendedData:Object;
      
      public function ErrorMessage()
      {
         super();
      }
      
      override public function getSmallMessage() : IMessage
      {
         return null;
      }
   }
}
