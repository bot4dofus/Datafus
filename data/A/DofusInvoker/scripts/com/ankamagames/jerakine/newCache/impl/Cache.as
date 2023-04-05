package com.ankamagames.jerakine.newCache.impl
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.newCache.ICacheGarbageCollector;
   
   public class Cache extends InfiniteCache implements ICache
   {
      
      private static var _namedCacheIndex:Array = new Array();
       
      
      private var _bounds:uint;
      
      private var _gc:ICacheGarbageCollector;
      
      private var _name:String;
      
      public function Cache(bounds:uint, gc:ICacheGarbageCollector)
      {
         super();
         this._bounds = bounds;
         this._gc = gc;
         this._gc.cache = this;
      }
      
      public static function create(bounds:uint, gc:ICacheGarbageCollector, name:String) : Cache
      {
         var cache:Cache = null;
         if(name && _namedCacheIndex[name])
         {
            return _namedCacheIndex[name];
         }
         cache = new Cache(bounds,gc);
         if(name)
         {
            _namedCacheIndex[name] = cache;
            cache._name = name;
         }
         return cache;
      }
      
      override public function destroy() : void
      {
         if(this._name)
         {
            delete _namedCacheIndex[this._name];
         }
         super.destroy();
      }
      
      override public function extract(ref:*) : *
      {
         this._gc.used(ref);
         return super.extract(ref);
      }
      
      override public function peek(ref:*) : *
      {
         this._gc.used(ref);
         return super.peek(ref);
      }
      
      override public function store(ref:*, obj:*) : Boolean
      {
         var bb:uint = 0;
         if(this._bounds && _size + 1 > this._bounds)
         {
            bb = this._bounds * 0.7 + 1 >> 0;
            this._gc.purge(bb);
         }
         super.store(ref,obj);
         this._gc.used(ref);
         return true;
      }
   }
}
