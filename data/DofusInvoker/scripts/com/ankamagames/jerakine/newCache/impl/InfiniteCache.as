package com.ankamagames.jerakine.newCache.impl
{
   import com.ankamagames.jerakine.newCache.ICache;
   import flash.utils.Dictionary;
   
   public class InfiniteCache implements ICache
   {
       
      
      protected var _cache:Dictionary;
      
      protected var _size:uint;
      
      public function InfiniteCache()
      {
         this._cache = new Dictionary(true);
         super();
      }
      
      public function get size() : uint
      {
         return this._size;
      }
      
      public function contains(ref:*) : Boolean
      {
         return this._cache[ref] != null;
      }
      
      public function extract(ref:*) : *
      {
         var obj:* = this._cache[ref];
         delete this._cache[ref];
         --this._size;
         return obj;
      }
      
      public function peek(ref:*) : *
      {
         return this._cache[ref];
      }
      
      public function store(ref:*, obj:*) : Boolean
      {
         this._cache[ref] = obj;
         ++this._size;
         return true;
      }
      
      public function destroy() : void
      {
         this._cache = new Dictionary(true);
         this._size = 0;
      }
   }
}
