package com.ankamagames.jerakine.pools
{
   import com.ankamagames.jerakine.json.JSONEncoder;
   
   public class PoolableJSONEncoder extends JSONEncoder implements Poolable
   {
       
      
      public function PoolableJSONEncoder(value:* = null, pMaxDepth:uint = 0, pShowObjectType:Boolean = false, processDictionaryKeys:Boolean = false)
      {
         super(value,pMaxDepth,pShowObjectType,processDictionaryKeys);
      }
      
      public function renew(value:*, pMaxDepth:uint = 0, pShowObjectType:Boolean = false, processDictionaryKeys:Boolean = false) : PoolableJSONEncoder
      {
         init(value,pMaxDepth,pShowObjectType,processDictionaryKeys);
         return this;
      }
      
      public function free() : void
      {
         this._depthLimit = 0;
         this._showObjectType = false;
         this._processDictionaryKeys = false;
         this.jsonString = null;
      }
   }
}
