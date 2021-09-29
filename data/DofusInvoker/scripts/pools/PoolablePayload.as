package pools
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.transport.Payload;
   import com.ankamagames.jerakine.pools.Poolable;
   
   public class PoolablePayload extends Payload implements Poolable
   {
       
      
      public function PoolablePayload(payloadType:int = 0, payload:JsonifiedMessage = null)
      {
         super(payloadType,payload);
      }
      
      public function renew(payloadType:int, _data:JsonifiedMessage) : PoolablePayload
      {
         init(payloadType,_data);
         return this;
      }
      
      public function free() : void
      {
         this.id = 0;
         this.data = null;
      }
   }
}
