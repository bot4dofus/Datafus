package com.ankamagames.jerakine.pools
{
   import com.ankamagames.jerakine.json.JSONDecoder;
   
   public class PoolableJSONDecoder extends JSONDecoder implements Poolable
   {
       
      
      public function PoolableJSONDecoder(s:String = "", strict:Boolean = false)
      {
         super(s,strict);
      }
      
      public function renew(s:String, strict:Boolean) : PoolableJSONDecoder
      {
         init(s,strict);
         return this;
      }
      
      public function free() : void
      {
         this.strict = false;
         this.tokenizer = null;
         this.value = null;
         this.token = null;
      }
   }
}
