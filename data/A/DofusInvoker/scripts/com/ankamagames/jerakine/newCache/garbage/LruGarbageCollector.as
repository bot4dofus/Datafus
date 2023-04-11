package com.ankamagames.jerakine.newCache.garbage
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.newCache.ICacheGarbageCollector;
   import com.ankamagames.jerakine.pools.Pool;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class LruGarbageCollector implements ICacheGarbageCollector
   {
      
      private static var _pool:Pool;
       
      
      protected var _usageCount:Dictionary;
      
      private var _cache:ICache;
      
      public function LruGarbageCollector()
      {
         this._usageCount = new Dictionary(true);
         super();
         if(!_pool)
         {
            _pool = new Pool(UsageCountHelper,500,50);
         }
      }
      
      public function set cache(cache:ICache) : void
      {
         this._cache = cache;
      }
      
      public function used(ref:*) : void
      {
         if(this._usageCount[ref])
         {
            ++this._usageCount[ref];
         }
         else
         {
            this._usageCount[ref] = 1;
         }
      }
      
      public function purge(bounds:uint) : void
      {
         var obj:* = undefined;
         var el:UsageCountHelper = null;
         var poke:* = undefined;
         var elements:Array = new Array();
         for(obj in this._usageCount)
         {
            elements.push((_pool.checkOut() as UsageCountHelper).init(obj,this._usageCount[obj]));
         }
         elements.sortOn("count",Array.NUMERIC | Array.DESCENDING);
         for each(el in elements)
         {
            el.free();
            _pool.checkIn(el);
         }
         while(this._cache.size > bounds && elements.length)
         {
            poke = this._cache.extract(elements.pop().ref);
            if(poke is IDestroyable)
            {
               (poke as IDestroyable).destroy();
            }
            if(poke is BitmapData)
            {
               (poke as BitmapData).dispose();
            }
            if(poke is ByteArray)
            {
               (poke as ByteArray).clear();
            }
         }
      }
   }
}

import com.ankamagames.jerakine.pools.Poolable;

class UsageCountHelper implements Poolable
{
    
   
   public var ref:Object;
   
   public var count:uint;
   
   function UsageCountHelper()
   {
      super();
   }
   
   public function init(ref:Object, count:uint) : UsageCountHelper
   {
      this.ref = ref;
      this.count = count;
      return this;
   }
   
   public function free() : void
   {
      this.ref = null;
      this.count = 0;
   }
}
