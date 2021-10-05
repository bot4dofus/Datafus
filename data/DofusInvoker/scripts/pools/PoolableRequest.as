package pools
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.transport.Request;
   import com.ankamagames.jerakine.pools.Poolable;
   
   public class PoolableRequest extends Request implements Poolable
   {
       
      
      public function PoolableRequest(_correlationId:int = 0, _payload:JsonifiedMessage = null)
      {
         super(_correlationId,_payload);
      }
      
      public function renew(_correlationId:int, _payload:JsonifiedMessage) : PoolableRequest
      {
         init(_correlationId,_payload);
         return this;
      }
      
      public function free() : void
      {
         this.correlationId = 0;
         if(this.payload)
         {
            PoolsManager.getInstance().getPayloadPool().checkIn(this.payload as PoolablePayload);
         }
         this.payload = null;
      }
   }
}
