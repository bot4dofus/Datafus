package chat.protocol.transport
{
   public class Response
   {
       
      
      public var correlationId:int;
      
      public var status:String;
      
      public var payload:Payload;
      
      public function Response(_id:int, _status:String, _payload:Object)
      {
         super();
         this.init(_id,_status,_payload);
      }
      
      protected function init(_id:int, _status:String, _payload:Object) : void
      {
         this.correlationId = _id;
         this.status = _status;
         if(_payload != null)
         {
            this.payload = Payload.createFromReceivedJsonObject(_payload.id,_payload.data);
         }
      }
   }
}
