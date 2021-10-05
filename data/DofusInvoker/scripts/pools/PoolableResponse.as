package pools
{
   import chat.protocol.transport.Response;
   import com.ankamagames.jerakine.pools.Poolable;
   
   public class PoolableResponse extends Response implements Poolable
   {
       
      
      public function PoolableResponse(_id:int = 0, _status:String = null, _payload:Object = null)
      {
         super(_id,_status,_payload);
      }
      
      public function renew(_id:int, _status:String, _payload:Object) : PoolableResponse
      {
         init(_id,_status,_payload);
         return this;
      }
      
      public function free() : void
      {
         if(this.payload)
         {
            PoolsManager.getInstance().getPayloadPool().checkIn(this.payload as PoolablePayload);
         }
         this.correlationId = 0;
         this.status = null;
         this.payload = null;
      }
   }
}
