package com.ankamagames.jerakine.network.utils.types
{
   public final class UInt64 extends Binary64
   {
       
      
      public function UInt64(low:uint = 0, high:uint = 0)
      {
         super(low,high);
      }
      
      public static function fromNumber(n:Number) : UInt64
      {
         return new UInt64(n,Math.floor(n / 4294967296));
      }
      
      public static function parseUInt64(str:String, radix:uint = 0) : UInt64
      {
         var digit:uint = 0;
         var i:uint = 0;
         if(radix == 0)
         {
            if(str.search(/^0x/) == 0)
            {
               radix = 16;
               i = 2;
            }
            else
            {
               radix = 10;
            }
         }
         if(radix < 2 || radix > 36)
         {
            throw new ArgumentError();
         }
         str = str.toLowerCase();
         for(var result:UInt64 = new UInt64(); i < str.length; )
         {
            digit = str.charCodeAt(i);
            if(digit >= CHAR_CODE_0 && digit <= CHAR_CODE_9)
            {
               digit -= CHAR_CODE_0;
            }
            else
            {
               if(!(digit >= CHAR_CODE_A && digit <= CHAR_CODE_Z))
               {
                  throw new ArgumentError();
               }
               digit -= CHAR_CODE_A;
               digit += 10;
            }
            if(digit >= radix)
            {
               throw new ArgumentError();
            }
            result.mul(radix);
            result.add(digit);
            i++;
         }
         return result;
      }
      
      public final function set high(value:uint) : void
      {
         internalHigh = value;
      }
      
      public final function get high() : uint
      {
         return internalHigh;
      }
      
      public final function toNumber() : Number
      {
         return this.high * 4294967296 + low;
      }
      
      public final function toString(radix:uint = 10) : String
      {
         var digit:uint = 0;
         if(radix < 2 || radix > 36)
         {
            throw new ArgumentError();
         }
         if(this.high == 0)
         {
            return low.toString(radix);
         }
         var digitChars:Array = [];
         var copyOfThis:UInt64 = new UInt64(low,this.high);
         do
         {
            digit = copyOfThis.div(radix);
            if(digit < 10)
            {
               digitChars.push(digit + CHAR_CODE_0);
            }
            else
            {
               digitChars.push(digit - 10 + CHAR_CODE_A);
            }
         }
         while(copyOfThis.high != 0);
         
         return copyOfThis.low.toString(radix) + String.fromCharCode.apply(String,digitChars.reverse());
      }
   }
}
