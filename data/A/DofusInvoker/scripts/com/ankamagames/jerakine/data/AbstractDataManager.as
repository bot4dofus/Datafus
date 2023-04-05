package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.impl.InfiniteCache;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractDataManager
   {
      
      static const DATA_KEY:String = "data";
       
      
      protected var _cacheSO:ICache;
      
      protected var _cacheKey:ICache;
      
      protected var _soPrefix:String = "";
      
      protected const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractDataManager));
      
      public function AbstractDataManager()
      {
         super();
      }
      
      public function getObject(key:uint) : Object
      {
         var v:* = undefined;
         var foo:* = undefined;
         var so:CustomSharedObject = null;
         var realKey:String = this._soPrefix + key;
         if(this._cacheKey.contains(realKey))
         {
            return this._cacheKey.peek(realKey);
         }
         var chunkLength:uint = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_FILES_INFO,this._soPrefix + "_chunkLength");
         var soName:String = this._soPrefix + Math.floor(key / chunkLength);
         if(this._cacheSO.contains(soName))
         {
            foo = this._cacheSO.peek(soName);
            v = CustomSharedObject(this._cacheSO.peek(soName)).data[DATA_KEY][key];
            this._cacheKey.store(realKey,v);
            return v;
         }
         so = CustomSharedObject.getLocal(soName);
         if(!so || !so.data[DATA_KEY])
         {
            return null;
         }
         this._cacheSO.store(soName,so);
         v = so.data[DATA_KEY][key];
         this._cacheKey.store(realKey,v);
         return v;
      }
      
      public function getObjects() : Array
      {
         var soName:String = null;
         var fileNum:uint = 0;
         var so:CustomSharedObject = null;
         var fileList:Array = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_FILES_INFO,this._soPrefix + "_filelist");
         if(!fileList)
         {
            return null;
         }
         var data:Array = new Array();
         for each(fileNum in fileList)
         {
            soName = this._soPrefix + fileNum;
            if(this._cacheSO.contains(soName))
            {
               data = data.concat(CustomSharedObject(this._cacheSO.peek(soName)).data[DATA_KEY]);
            }
            else
            {
               so = CustomSharedObject.getLocal(soName);
               if(!(!so || !so.data[DATA_KEY]))
               {
                  this._cacheSO.store(soName,so);
                  data = data.concat(so.data[DATA_KEY]);
               }
            }
         }
         return data;
      }
      
      function init(soCacheSize:uint, keyCacheSize:uint, soPrefix:String = "") : void
      {
         if(keyCacheSize == uint.MAX_VALUE)
         {
            this._cacheKey = new InfiniteCache();
         }
         else
         {
            this._cacheKey = Cache.create(keyCacheSize,new LruGarbageCollector(),getQualifiedClassName(this) + "_key");
         }
         this._cacheSO = Cache.create(soCacheSize,new LruGarbageCollector(),getQualifiedClassName(this) + "_so");
         this._soPrefix = soPrefix;
      }
   }
}
