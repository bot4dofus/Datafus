package com.ankamagames.jerakine.utils.prng
{
   public interface PRNG
   {
       
      
      function seed(param1:uint) : void;
      
      function nextInt() : uint;
      
      function nextDouble() : Number;
      
      function nextIntR(param1:Number, param2:Number) : uint;
      
      function nextDoubleR(param1:Number, param2:Number) : Number;
   }
}
