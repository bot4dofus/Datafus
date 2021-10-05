package flashx.textLayout.utils
{
   public final class CharacterUtil
   {
      
      private static var whiteSpaceObject:Object = createWhiteSpaceObject();
       
      
      public function CharacterUtil()
      {
         super();
      }
      
      public static function isHighSurrogate(charCode:int) : Boolean
      {
         return charCode >= 55296 && charCode <= 56319;
      }
      
      public static function isLowSurrogate(charCode:int) : Boolean
      {
         return charCode >= 56320 && charCode <= 57343;
      }
      
      private static function createWhiteSpaceObject() : Object
      {
         var rslt:Object = new Object();
         rslt[32] = true;
         rslt[5760] = true;
         rslt[6158] = true;
         rslt[8192] = true;
         rslt[8193] = true;
         rslt[8194] = true;
         rslt[8195] = true;
         rslt[8196] = true;
         rslt[8197] = true;
         rslt[8198] = true;
         rslt[8199] = true;
         rslt[8200] = true;
         rslt[8201] = true;
         rslt[8202] = true;
         rslt[8239] = true;
         rslt[8287] = true;
         rslt[12288] = true;
         rslt[8232] = true;
         rslt[8233] = true;
         rslt[9] = true;
         rslt[10] = true;
         rslt[11] = true;
         rslt[12] = true;
         rslt[13] = true;
         rslt[133] = true;
         rslt[160] = true;
         return rslt;
      }
      
      public static function isWhitespace(charCode:int) : Boolean
      {
         return whiteSpaceObject[charCode];
      }
   }
}
