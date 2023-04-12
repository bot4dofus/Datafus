package com.ankamagames.jerakine.network.utils.types
{
   public class Binary64
   {
      
      static const CHAR_CODE_0:uint = "0".charCodeAt();
      
      static const CHAR_CODE_9:uint = "9".charCodeAt();
      
      static const CHAR_CODE_A:uint = "a".charCodeAt();
      
      static const CHAR_CODE_Z:uint = "z".charCodeAt();
       
      
      public var low:uint;
      
      var internalHigh:uint;
      
      public function Binary64(low:uint = 0, high:uint = 0)
      {
         super();
         this.low = low;
         this.internalHigh = high;
      }
      
      final function div(n:uint) : uint
      {
         var modHigh:uint = 0;
         modHigh = this.internalHigh % n;
         var mod:uint = (this.low % n + modHigh * 6) % n;
         this.internalHigh /= n;
         var newLow:Number = (modHigh * 4294967296 + this.low) / n;
         this.internalHigh += uint(newLow / 4294967296);
         this.low = newLow;
         return mod;
      }
      
      final function mul(n:uint) : void
      {
         var newLow:Number = Number(this.low) * n;
         this.internalHigh *= n;
         this.internalHigh += uint(newLow / 4294967296);
         this.low *= n;
      }
      
      final function add(n:uint) : void
      {
         var newLow:Number = Number(this.low) + n;
         this.internalHigh += uint(newLow / 4294967296);
         this.low = newLow;
      }
      
      final function bitwiseNot() : void
      {
         this.low = ~this.low;
         this.internalHigh = ~this.internalHigh;
      }
   }
}
