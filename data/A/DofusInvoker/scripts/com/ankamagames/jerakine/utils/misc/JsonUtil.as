package com.ankamagames.jerakine.utils.misc
{
   import by.blooddy.crypto.serialization.JSON;
   
   public final class JsonUtil
   {
       
      
      public function JsonUtil()
      {
         super();
      }
      
      public static function toJson(src:Object) : String
      {
         return by.blooddy.crypto.serialization.JSON.encode(src);
      }
      
      public static function fromJson(json:String) : Object
      {
         return by.blooddy.crypto.serialization.JSON.decode(json);
      }
   }
}
