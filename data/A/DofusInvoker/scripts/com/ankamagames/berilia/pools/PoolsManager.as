package com.ankamagames.berilia.pools
{
   import com.ankamagames.jerakine.pools.Pool;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class PoolsManager
   {
      
      private static var _self:PoolsManager;
       
      
      private var _loadersPool:Pool;
      
      private var _xmlParsorPool:Pool;
      
      private var _uiRendererPool:Pool;
      
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
      
      public function getXmlParsorPool() : Pool
      {
         if(this._xmlParsorPool == null)
         {
            this._xmlParsorPool = new Pool(PoolableXmlParsor,10,5,25);
         }
         return this._xmlParsorPool;
      }
      
      public function getUiRendererPool() : Pool
      {
         if(this._uiRendererPool == null)
         {
            this._uiRendererPool = new Pool(PoolableUiRenderer,10,5,25);
         }
         return this._uiRendererPool;
      }
   }
}
