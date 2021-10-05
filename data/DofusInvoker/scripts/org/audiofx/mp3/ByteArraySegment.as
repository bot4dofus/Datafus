package org.audiofx.mp3
{
   import flash.utils.ByteArray;
   
   class ByteArraySegment
   {
       
      
      public var start:uint;
      
      public var length:uint;
      
      public var byteArray:ByteArray;
      
      function ByteArraySegment(ba:ByteArray, start:uint, length:uint)
      {
         super();
         this.byteArray = ba;
         this.start = start;
         this.length = length;
      }
   }
}
