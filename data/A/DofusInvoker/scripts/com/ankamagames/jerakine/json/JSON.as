package com.ankamagames.jerakine.json
{
   public class JSON
   {
       
      
      public function JSON()
      {
         super();
      }
      
      public static function encode(o:Object, pMaxDepth:uint = 0, pShowObjectType:Boolean = false, processDictionaryKeys:Boolean = false) : String
      {
         return new JSONEncoder(o,pMaxDepth,pShowObjectType,processDictionaryKeys).getString();
      }
      
      public static function decode(s:String, strict:Boolean = true) : *
      {
         return new JSONDecoder(s,strict).getValue();
      }
   }
}
