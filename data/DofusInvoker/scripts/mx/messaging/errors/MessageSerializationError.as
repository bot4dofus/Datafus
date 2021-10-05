package mx.messaging.errors
{
   import mx.messaging.messages.ErrorMessage;
   
   public class MessageSerializationError extends MessagingError
   {
       
      
      public var fault:ErrorMessage;
      
      public function MessageSerializationError(msg:String, fault:ErrorMessage)
      {
         super(msg);
         this.fault = fault;
      }
   }
}
