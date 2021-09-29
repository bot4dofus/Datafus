package chat.protocol.transport
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class Request extends JsonifiedMessage
   {
       
      
      public var correlationId:int;
      
      public var payload:JsonifiedMessage;
      
      public function Request(_correlationId:int, _payload:JsonifiedMessage)
      {
         super();
         this.init(_correlationId,_payload);
      }
      
      protected function init(_correlationId:int, _payload:JsonifiedMessage) : void
      {
         this.correlationId = _correlationId;
         this.payload = _payload;
      }
   }
}
