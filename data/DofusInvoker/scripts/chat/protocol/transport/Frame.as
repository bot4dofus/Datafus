package chat.protocol.transport
{
   import chat.protocol.common.JsonifiedMessage;
   import pools.PoolableResponse;
   import pools.PoolsManager;
   
   public class Frame extends JsonifiedMessage
   {
       
      
      public var event:Payload;
      
      public var request:Request;
      
      public var response:Response;
      
      public function Frame()
      {
         super();
      }
      
      public static function createFromJson(json:String) : Frame
      {
         var response:PoolableResponse = null;
         var obj:Object = decodePooled(json,false);
         var frame:Frame = PoolsManager.getInstance().getChatFramePool().checkOut() as Frame;
         if(obj.hasOwnProperty("event"))
         {
            frame.event = Payload.createFromReceivedJsonObject(obj.event.id,obj.event.data);
         }
         if(obj.hasOwnProperty("response"))
         {
            response = PoolsManager.getInstance().getResponsePool().checkOut() as PoolableResponse;
            frame.response = response.renew(obj.response.correlationId,obj.response.status,obj.response.payload);
         }
         return frame;
      }
   }
}
