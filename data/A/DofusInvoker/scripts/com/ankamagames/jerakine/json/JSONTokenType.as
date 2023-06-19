package com.ankamagames.jerakine.json
{
   public class JSONTokenType
   {
      
      public static const UNKNOWN:int = -1;
      
      public static const COMMA:int = 0;
      
      public static const LEFT_BRACE:int = 1;
      
      public static const RIGHT_BRACE:int = 2;
      
      public static const LEFT_BRACKET:int = 3;
      
      public static const RIGHT_BRACKET:int = 4;
      
      public static const COLON:int = 6;
      
      public static const TRUE:int = 7;
      
      public static const FALSE:int = 8;
      
      public static const NULL:int = 9;
      
      public static const STRING:int = 10;
      
      public static const NUMBER:int = 11;
      
      public static const NAN:int = 12;
       
      
      public function JSONTokenType()
      {
         super();
      }
   }
}
