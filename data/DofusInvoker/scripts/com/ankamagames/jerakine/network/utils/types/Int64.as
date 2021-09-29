package com.ankamagames.jerakine.network.utils.types
{
   public final class Int64 extends Binary64
   {
       
      
      public function Int64(low:uint = 0, high:int = 0)
      {
         super(low,high);
      }
      
      public static function fromNumber(n:Number) : Int64
      {
         return new Int64(n,Math.floor(n / 4294967296));
      }
      
      public static function parseInt64(str:String, radix:uint = 0) : Int64
      {
         var digit:uint = 0;
         var negative:* = str.search(/^\-/) == 0;
         var i:uint = !!negative ? uint(1) : uint(0);
         if(radix == 0)
         {
            if(str.search(/^\-?0x/) == 0)
            {
               radix = 16;
               i += 2;
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
         for(var result:Int64 = new Int64(); i < str.length; )
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
         if(negative)
         {
            result.bitwiseNot();
            result.add(1);
         }
         return result;
      }
      
      public static function make(low:uint, high:uint) : Int64
      {
         return new Int64(low,high);
      }
      
      public static function shl(a:Int64, b:int) : Int64
      {
         var i:Int64 = null;
         b &= 63;
         if(b == 0)
         {
            i = a.copy();
         }
         else if(b < 32)
         {
            i = make(a.high << b | a.low >>> 32 - b,a.low << b);
         }
         else
         {
            i = make(a.low << b - 32,0);
         }
         return i;
      }
      
      public static function shr(a:Int64, b:int) : Int64
      {
         var i:Int64 = null;
         b &= 63;
         if(b == 0)
         {
            i = a.copy();
         }
         else if(b < 32)
         {
            i = make(a.high >> b,a.high << 32 - b | a.low >>> b);
         }
         else
         {
            i = make(a.high >> 31,a.high >> b - 32);
         }
         return i;
      }
      
      public static function ushr(a:Int64, b:int) : Int64
      {
         var i:Int64 = null;
         b &= 63;
         if(b == 0)
         {
            i = a.copy();
         }
         else if(b < 32)
         {
            i = make(a.high >>> b,a.high << 32 - b | a.low >>> b);
         }
         else
         {
            i = make(0,a.high >>> b - 32);
         }
         return i;
      }
      
      public static function xor(a:Int64, b:Int64) : Int64
      {
         return make(a.high ^ b.high,a.low ^ b.low);
      }
      
      public static function and(a:Int64, b:Int64) : Int64
      {
         return make(a.high & b.high,a.low & b.low);
      }
      
      public static function flip(a:Int64) : Int64
      {
         var i:Int64 = xor(a,Int64.fromNumber(-1));
         i.add(1);
         return i;
      }
      
      public final function set high(value:int) : void
      {
         internalHigh = value;
      }
      
      public final function get high() : int
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
         switch(this.high)
         {
            case 0:
               return low.toString(radix);
            case -1:
               if((low & 2147483648) == 0)
               {
                  return (int(low | 2147483648) - 2147483648).toString(radix);
               }
               return int(low).toString(radix);
               break;
            default:
               if(low == 0 && this.high == 0)
               {
                  return "0";
               }
               var digitChars:Array = [];
               var copyOfThis:UInt64 = new UInt64(low,this.high);
               if(this.high < 0)
               {
                  copyOfThis.bitwiseNot();
                  copyOfThis.add(1);
               }
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
               
               if(this.high < 0)
               {
                  return "-" + copyOfThis.low.toString(radix) + String.fromCharCode.apply(String,digitChars.reverse());
               }
               return copyOfThis.low.toString(radix) + String.fromCharCode.apply(String,digitChars.reverse());
         }
      }
      
      public final function copy() : Int64
      {
         return make(low,this.high);
      }
   }
}
