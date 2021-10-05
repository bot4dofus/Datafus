package pools
{
   import chat.protocol.transport.Frame;
   import com.ankamagames.jerakine.pools.Poolable;
   
   public class PoolableChatFrame extends Frame implements Poolable
   {
       
      
      public function PoolableChatFrame()
      {
         super();
      }
      
      public function free() : void
      {
         if(this.event)
         {
            PoolsManager.getInstance().getPayloadPool().checkIn(this.event as PoolablePayload);
         }
         if(this.request)
         {
            PoolsManager.getInstance().getRequestPool().checkIn(this.request as PoolableRequest);
         }
         if(this.response)
         {
            PoolsManager.getInstance().getResponsePool().checkIn(this.response as PoolableResponse);
         }
         this.event = null;
         this.request = null;
         this.response = null;
      }
   }
}
