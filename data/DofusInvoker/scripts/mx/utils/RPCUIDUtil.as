package mx.utils
{
   import flash.utils.ByteArray;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class RPCUIDUtil
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static const ALPHA_CHAR_CODES:Array = [48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70];
      
      private static const DASH:int = 45;
      
      private static const UIDBuffer:ByteArray = new ByteArray();
       
      
      public function RPCUIDUtil()
      {
         super();
      }
      
      public static function createUID() : String
      {
         var i:int = 0;
         var j:int = 0;
         UIDBuffer.position = 0;
         for(i = 0; i < 8; i++)
         {
            UIDBuffer.writeByte(ALPHA_CHAR_CODES[int(Math.random() * 16)]);
         }
         for(i = 0; i < 3; i++)
         {
            UIDBuffer.writeByte(DASH);
            for(j = 0; j < 4; j++)
            {
               UIDBuffer.writeByte(ALPHA_CHAR_CODES[int(Math.random() * 16)]);
            }
         }
         UIDBuffer.writeByte(DASH);
         var time:uint = new Date().getTime();
         var timeString:String = time.toString(16).toUpperCase();
         for(i = 8; i > timeString.length; i--)
         {
            UIDBuffer.writeByte(48);
         }
         UIDBuffer.writeUTFBytes(timeString);
         for(i = 0; i < 4; i++)
         {
            UIDBuffer.writeByte(ALPHA_CHAR_CODES[int(Math.random() * 16)]);
         }
         return UIDBuffer.toString();
      }
      
      public static function fromByteArray(ba:ByteArray) : String
      {
         var index:uint = 0;
         var i:uint = 0;
         var b:int = 0;
         if(ba != null && ba.length >= 16 && ba.bytesAvailable >= 16)
         {
            UIDBuffer.position = 0;
            index = 0;
            for(i = 0; i < 16; i++)
            {
               if(i == 4 || i == 6 || i == 8 || i == 10)
               {
                  UIDBuffer.writeByte(DASH);
               }
               b = ba.readByte();
               UIDBuffer.writeByte(ALPHA_CHAR_CODES[(b & 240) >>> 4]);
               UIDBuffer.writeByte(ALPHA_CHAR_CODES[b & 15]);
            }
            return UIDBuffer.toString();
         }
         return null;
      }
      
      public static function isUID(uid:String) : Boolean
      {
         var i:uint = 0;
         var c:Number = NaN;
         if(uid != null && uid.length == 36)
         {
            for(i = 0; i < 36; i++)
            {
               c = uid.charCodeAt(i);
               if(i == 8 || i == 13 || i == 18 || i == 23)
               {
                  if(c != DASH)
                  {
                     return false;
                  }
               }
               else if(c < 48 || c > 70 || c > 57 && c < 65)
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      public static function toByteArray(uid:String) : ByteArray
      {
         var result:ByteArray = null;
         var i:uint = 0;
         var c:String = null;
         var h1:uint = 0;
         var h2:uint = 0;
         if(isUID(uid))
         {
            result = new ByteArray();
            for(i = 0; i < uid.length; i++)
            {
               c = uid.charAt(i);
               if(c != "-")
               {
                  h1 = getDigit(c);
                  i++;
                  h2 = getDigit(uid.charAt(i));
                  result.writeByte((h1 << 4 | h2) & 255);
               }
            }
            result.position = 0;
            return result;
         }
         return null;
      }
      
      private static function getDigit(hex:String) : uint
      {
         switch(hex)
         {
            case "A":
            case "a":
               return 10;
            case "B":
            case "b":
               return 11;
            case "C":
            case "c":
               return 12;
            case "D":
            case "d":
               return 13;
            case "E":
            case "e":
               return 14;
            case "F":
            case "f":
               return 15;
            default:
               return new uint(hex);
         }
      }
   }
}
