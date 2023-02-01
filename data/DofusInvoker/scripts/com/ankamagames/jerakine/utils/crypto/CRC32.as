package com.ankamagames.jerakine.utils.crypto
{
   import flash.utils.ByteArray;
   
   public class CRC32
   {
      
      private static var CRCTable:Array = initCRCTable();
       
      
      private var _crc32:uint;
      
      public function CRC32()
      {
         super();
      }
      
      private static function initCRCTable() : Array
      {
         var crc:uint = 0;
         var j:int = 0;
         var crcTable:Array = new Array(256);
         for(var i:int = 0; i < 256; i++)
         {
            crc = i;
            for(j = 0; j < 8; j++)
            {
               crc = !!(crc & 1) ? uint(crc >>> 1 ^ 3988292384) : uint(crc >>> 1);
            }
            crcTable[i] = crc;
         }
         return crcTable;
      }
      
      public function update(buffer:ByteArray, offset:int = 0, length:int = 0) : void
      {
         length = length == 0 ? int(buffer.length) : int(length);
         var crc:uint = ~this._crc32;
         for(var i:int = offset; i < length; i++)
         {
            crc = CRCTable[(crc ^ buffer[i]) & 255] ^ crc >>> 8;
         }
         this._crc32 = ~crc;
      }
      
      public function getValue() : uint
      {
         return this._crc32 & 4294967295;
      }
      
      public function reset() : void
      {
         this._crc32 = 0;
      }
   }
}
