package com.ankamagames.jerakine.newCache.impl
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.CacheableResource;
   import com.ankamagames.jerakine.types.ASwf;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class DisplayObjectCache implements ICache
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DisplayObjectCache));
       
      
      private var _cache:Dictionary;
      
      private var _size:uint = 0;
      
      private var _bounds:uint;
      
      private var _useCount:Dictionary;
      
      public function DisplayObjectCache(bound:uint)
      {
         this._cache = new Dictionary(true);
         this._useCount = new Dictionary(true);
         super();
         this._bounds = bound;
      }
      
      public function get size() : uint
      {
         return this._size;
      }
      
      public function contains(ref:*) : Boolean
      {
         var d:CacheableResource = null;
         var a:Array = this._cache[ref];
         for each(d in a)
         {
            if(d.resource && (d.resource is ASwf || d.resource.hasOwnProperty("parent") && !d.resource.parent))
            {
               return true;
            }
         }
         return false;
      }
      
      public function extract(ref:*) : *
      {
         var foundRes:* = this.peek(ref);
         if(foundRes)
         {
            delete this._cache[ref];
            delete this._useCount[ref];
            --this._size;
         }
         return foundRes;
      }
      
      public function peek(ref:*) : *
      {
         var d:CacheableResource = null;
         var a:Array = this._cache[ref];
         for each(d in a)
         {
            if(d.resource && (d.resource is ASwf || d.resource.hasOwnProperty("parent") && !d.resource.parent))
            {
               ++this._useCount[ref];
               return d;
            }
         }
         return null;
      }
      
      public function store(ref:*, obj:*) : Boolean
      {
         if(!(obj is CacheableResource))
         {
            _log.error("Tried to store something which is not a CacheableResource... Caching file " + ref + " failed.");
            return false;
         }
         var bb:* = obj.resource is ASwf;
         if(!this._cache[ref])
         {
            this._cache[ref] = new Array();
            this._useCount[ref] = 0;
            ++this._size;
            if(this._size > this._bounds)
            {
               this.garbage();
            }
         }
         ++this._useCount[ref];
         this._cache[ref].push(obj);
         return true;
      }
      
      public function destroy() : void
      {
         this._cache = new Dictionary(true);
         this._size = 0;
         this._bounds = 0;
         this._useCount = new Dictionary(true);
      }
      
      private function garbage() : void
      {
         var resName:* = null;
         var bound:uint = 0;
         var l:uint = 0;
         var a:Array = null;
         var dontCollect:Boolean = false;
         var i:uint = 0;
         var ref:CacheableResource = null;
         var orderedUse:Array = new Array();
         for(resName in this._cache)
         {
            if(this._cache[resName] != null && this._useCount[resName])
            {
               orderedUse.push({
                  "ref":resName,
                  "useCount":this._useCount[resName]
               });
            }
         }
         orderedUse.sortOn("useCount",Array.NUMERIC);
         bound = this._bounds * 0.1;
         l = orderedUse.length;
         i = 0;
         while(i < l && this._size > bound)
         {
            dontCollect = false;
            a = this._cache[orderedUse[i].ref];
            for each(ref in a)
            {
               if(ref && ref.resource && (ref.resource is ASwf || ref.resource.hasOwnProperty("parent") && ref.resource.parent))
               {
                  dontCollect = true;
                  break;
               }
            }
            if(!dontCollect)
            {
               delete this._cache[orderedUse[i].ref];
               delete this._useCount[orderedUse[i].ref];
               --this._size;
            }
            i++;
         }
      }
   }
}
