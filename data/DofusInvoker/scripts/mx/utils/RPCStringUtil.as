package mx.utils
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class RPCStringUtil
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      public function RPCStringUtil()
      {
         super();
      }
      
      public static function trim(str:String) : String
      {
         if(str == null)
         {
            return "";
         }
         var startIndex:int = 0;
         while(isWhitespace(str.charAt(startIndex)))
         {
            startIndex++;
         }
         var endIndex:int = str.length - 1;
         while(isWhitespace(str.charAt(endIndex)))
         {
            endIndex--;
         }
         if(endIndex >= startIndex)
         {
            return str.slice(startIndex,endIndex + 1);
         }
         return "";
      }
      
      public static function trimArrayElements(value:String, delimiter:String) : String
      {
         var items:Array = null;
         var len:int = 0;
         var i:int = 0;
         if(value != "" && value != null)
         {
            items = value.split(delimiter);
            len = items.length;
            for(i = 0; i < len; i++)
            {
               items[i] = trim(items[i]);
            }
            if(len > 0)
            {
               value = items.join(delimiter);
            }
         }
         return value;
      }
      
      public static function isWhitespace(character:String) : Boolean
      {
         switch(character)
         {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
            case " ":
            case " ":
            case " ":
               return true;
            default:
               return false;
         }
      }
      
      public static function substitute(str:String, ... rest) : String
      {
         var args:Array = null;
         if(str == null)
         {
            return "";
         }
         var len:uint = rest.length;
         if(len == 1 && rest[0] is Array)
         {
            args = rest[0] as Array;
            len = args.length;
         }
         else
         {
            args = rest;
         }
         for(var i:int = 0; i < len; i++)
         {
            str = str.replace(new RegExp("\\{" + i + "\\}","g"),args[i]);
         }
         return str;
      }
   }
}
