package pools
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.pools.Pool;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.getQualifiedClassName;
   
   public class PoolsManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PoolsManager));
      
      private static var _self:PoolsManager;
       
      
      private var _chatFramePool:Pool;
      
      private var _payloadPool:Pool;
      
      private var _responsePool:Pool;
      
      private var _requestPool:Pool;
      
      public function PoolsManager()
      {
         super();
         if(_self)
         {
            throw new SingletonError("Direct initialization of singleton is forbidden. Please access PoolsManager using the getInstance method.");
         }
      }
      
      public static function getInstance() : PoolsManager
      {
         if(_self == null)
         {
            _self = new PoolsManager();
         }
         return _self;
      }
      
      public function getChatFramePool() : Pool
      {
         if(this._chatFramePool == null)
         {
            this._chatFramePool = new Pool(PoolableChatFrame,Spin2Constants.CHAT_FRAME_POOL_INITIAL_SIZE,Spin2Constants.CHAT_FRAME_POOL_GROW_SIZE,Spin2Constants.CHAT_FRAME_POOL_WARN_LIMIT);
         }
         return this._chatFramePool;
      }
      
      public function getPayloadPool() : Pool
      {
         if(this._payloadPool == null)
         {
            this._payloadPool = new Pool(PoolablePayload,Spin2Constants.PAYLOAD_POOL_INITIAL_SIZE,Spin2Constants.PAYLOAD_POOL_GROW_SIZE,Spin2Constants.PAYLOAD_POOL_WARN_LIMIT);
         }
         return this._payloadPool;
      }
      
      public function getRequestPool() : Pool
      {
         if(this._requestPool == null)
         {
            this._requestPool = new Pool(PoolableRequest,Spin2Constants.REQUEST_POOL_INITIAL_SIZE,Spin2Constants.REQUEST_POOL_GROW_SIZE,Spin2Constants.REQUEST_POOL_WARN_LIMIT);
         }
         return this._requestPool;
      }
      
      public function getResponsePool() : Pool
      {
         if(this._responsePool == null)
         {
            this._responsePool = new Pool(PoolableResponse,Spin2Constants.RESPONSE_POOL_INITIAL_SIZE,Spin2Constants.RESPONSE_POOL_GROW_SIZE,Spin2Constants.RESPONSE_POOL_WARN_LIMIT);
         }
         return this._responsePool;
      }
   }
}
