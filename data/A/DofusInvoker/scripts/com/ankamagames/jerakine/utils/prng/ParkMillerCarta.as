package com.ankamagames.jerakine.utils.prng
{
   public class ParkMillerCarta implements PRNG
   {
       
      
      private var _seed:uint;
      
      public function ParkMillerCarta(seedValue:uint = 0)
      {
         super();
         this.seed(seedValue);
      }
      
      public function seed(value:uint) : void
      {
         this._seed = value;
      }
      
      public function nextInt() : uint
      {
         return this.gen();
      }
      
      public function nextDouble() : Number
      {
         return this.gen() / 2147483647;
      }
      
      public function nextIntR(min:Number, max:Number) : uint
      {
         min -= 0.4999;
         max += 0.4999;
         return Math.round(min + (max - min) * this.nextDouble());
      }
      
      public function nextDoubleR(min:Number, max:Number) : Number
      {
         return min + (max - min) * this.nextDouble();
      }
      
      private function gen() : uint
      {
         var hi:uint = 16807 * (this._seed >> 16);
         var lo:uint = 16807 * (this._seed & 65535) + ((hi & 32767) << 16) + (hi >> 15);
         return this._seed = lo > 2147483647 ? uint(lo - 2147483647) : uint(lo);
      }
   }
}
