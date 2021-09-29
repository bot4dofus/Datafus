package
{
   import _DeflateStream.HuffmanTree;
   import _DeflateStream.LZHash;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class DeflateStream
   {
      
      public static var MAX_SYMBOLS_IN_TREE:int = 286;
      
      public static var LENGTH_CODES:int = 29;
      
      public static var MIN_LENGTH:int = 3;
      
      public static var MAX_LENGTH:int = 258;
      
      public static var LENGTHS:int = 256;
      
      public static var SCRATCH_MEMORY_SIZE:int = 5576;
      
      public static var DISTANCE_OFFSET:int = 1144;
      
      public static var CODE_LENGTH_OFFSET:int = 1272;
      
      public static var HUFFMAN_SCRATCH_OFFSET:int = 1348;
      
      public static var LENGTH_EXTRA_BITS_OFFSET:int = 2492;
      
      public static var DIST_EXTRA_BITS_OFFSET:int = 3528;
      
      public static var OUTPUT_BYTES_BEFORE_NEW_BLOCK:int = 49152;
      
      public static var MAX_UNCOMPRESSED_BYTES_PER_BLOCK:uint = 65535;
      
      public static var ADLER_MAX:int = 65521;
      
      public static var MAX_CODE_LENGTH:int = 15;
      
      public static var MAX_CODE_LENGTH_CODE_LENGTH:int = 7;
      
      public static var EOB:int = 256;
      
      public static var HASH_SIZE_BITS:int = 16;
      
      public static var HASH_SIZE:int = 65536;
      
      public static var HASH_MASK:int = 65535;
      
      public static var WINDOW_SIZE:int = 32768;
      
      public static var NMAX:int = 5552;
       
      
      public var zlib:Boolean;
      
      public var startAddr:uint;
      
      public var scratchAddr:int;
      
      public var s2:uint;
      
      public var s1:uint;
      
      public var rangeResult:MemoryRange;
      
      public var literalLengthCodes:int;
      
      public var level:CompressionLevel;
      
      public var distanceCodes:int;
      
      public var currentAddr:int;
      
      public var blockStartAddr:int;
      
      public var blockInProgress:Boolean;
      
      public var bitOffset:int;
      
      public function DeflateStream(param1:CompressionLevel, param2:Boolean, param3:int, param4:int)
      {
         _new(param1,param2,param3,param4);
      }
      
      public static function create(param1:CompressionLevel, param2:Boolean = false) : DeflateStream
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         ApplicationDomain.currentDomain.domainMemory = _loc3_;
         return DeflateStream.createEx(param1,0,5576,param2);
      }
      
      public static function createEx(param1:CompressionLevel, param2:int, param3:int, param4:Boolean = false) : DeflateStream
      {
         return new DeflateStream(param1,param4,param2,param3);
      }
      
      public static function memcpy(param1:ByteArray, param2:int, param3:int = 0) : void
      {
         param1.readBytes(ApplicationDomain.currentDomain.domainMemory,param2,param3);
      }
      
      public function writeTemporaryBufferSymbol(param1:int) : int
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc6_:int = li16(param1);
         if((_loc6_ & 512) != 0)
         {
            _loc2_ = _loc6_ ^ 512;
            _loc4_ = li32(scratchAddr + 2492 + (_loc2_ << 2));
            _loc7_ = 0;
            _loc8_ = int(li32(scratchAddr + _loc7_ + (_loc4_ >>> 16) * 4));
            _loc9_ = int(li8(currentAddr));
            _loc9_ |= _loc8_ >>> 16 << bitOffset;
            si32(_loc9_,currentAddr);
            bitOffset += _loc8_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
            _loc7_ = int(li8(currentAddr));
            _loc7_ |= _loc2_ - (_loc4_ & 8191) << bitOffset;
            si32(_loc7_,currentAddr);
            bitOffset += (_loc4_ & 65280) >>> 13;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
            _loc3_ = li16(param1 + 2);
            _loc5_ = li32(scratchAddr + 3528 + ((_loc3_ <= 256 ? _loc3_ : 256 + (_loc3_ - 1 >>> 7)) << 2));
            _loc7_ = int(li32(scratchAddr + 1144 + (_loc5_ >>> 24) * 4));
            _loc8_ = int(li8(currentAddr));
            _loc8_ |= _loc7_ >>> 16 << bitOffset;
            si32(_loc8_,currentAddr);
            bitOffset += _loc7_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
            _loc7_ = int(li8(currentAddr));
            _loc7_ |= _loc3_ - (_loc5_ & 65535) << bitOffset;
            si32(_loc7_,currentAddr);
            bitOffset += (_loc5_ & 16711680) >>> 16;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         else
         {
            _loc7_ = 0;
            _loc8_ = int(li32(scratchAddr + _loc7_ + _loc6_ * 4));
            _loc9_ = int(li8(currentAddr));
            _loc9_ |= _loc8_ >>> 16 << bitOffset;
            si32(_loc9_,currentAddr);
            bitOffset += _loc8_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         return _loc6_;
      }
      
      public function writeSymbol(param1:int, param2:int = 0) : void
      {
         var _loc3_:int = li32(scratchAddr + param2 + param1 * 4);
         var _loc4_:* = int(li8(currentAddr));
         _loc4_ |= _loc3_ >>> 16 << bitOffset;
         si32(_loc4_,currentAddr);
         bitOffset += _loc3_ & 65535;
         currentAddr += bitOffset >>> 3;
         bitOffset &= 7;
      }
      
      public function writeShort(param1:int) : void
      {
         si16(param1,currentAddr);
         currentAddr += 2;
      }
      
      public function writeEmptyBlock(param1:Boolean) : void
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         if(blockInProgress)
         {
            if(level != CompressionLevel.UNCOMPRESSED)
            {
               _loc2_ = 0;
               _loc3_ = li32(scratchAddr + _loc2_ + 1024);
               _loc4_ = int(li8(currentAddr));
               _loc4_ |= _loc3_ >>> 16 << bitOffset;
               si32(_loc4_,currentAddr);
               bitOffset += _loc3_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
            blockInProgress = false;
         }
         var _loc5_:CompressionLevel = level;
         level = CompressionLevel.UNCOMPRESSED;
         blockInProgress = true;
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            if(bitOffset == 0)
            {
               si8(0,currentAddr);
            }
            _loc2_ = int(li8(currentAddr));
            _loc2_ |= (!!param1 ? 1 : 0) << bitOffset;
            si32(_loc2_,currentAddr);
            bitOffset += 3;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
            if(bitOffset > 0)
            {
               _loc2_ = int(li8(currentAddr));
               _loc2_ |= 0 << bitOffset;
               si32(_loc2_,currentAddr);
               bitOffset += 8 - bitOffset;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
         }
         else
         {
            _loc2_ = int(li8(currentAddr));
            _loc2_ |= (4 | (!!param1 ? 1 : 0)) << bitOffset;
            si32(_loc2_,currentAddr);
            bitOffset += 3;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         blockStartAddr = currentAddr;
         si16(0,currentAddr);
         currentAddr += 2;
         si16(-1,currentAddr);
         currentAddr += 2;
         if(level != CompressionLevel.UNCOMPRESSED)
         {
            _loc2_ = 0;
            _loc3_ = li32(scratchAddr + _loc2_ + 1024);
            _loc4_ = int(li8(currentAddr));
            _loc4_ |= _loc3_ >>> 16 << bitOffset;
            si32(_loc4_,currentAddr);
            bitOffset += _loc3_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         blockInProgress = false;
         level = _loc5_;
      }
      
      public function writeByte(param1:int) : void
      {
         si8(param1,currentAddr);
         currentAddr = currentAddr + 1;
      }
      
      public function writeBits(param1:int, param2:int) : void
      {
         var _loc3_:* = int(li8(currentAddr));
         _loc3_ |= param1 << bitOffset;
         si32(_loc3_,currentAddr);
         bitOffset += param2;
         currentAddr += bitOffset >>> 3;
         bitOffset &= 7;
      }
      
      public function write(param1:ByteArray) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = param1.bytesAvailable;
         var _loc6_:int = 1;
         var _loc7_:int = 0;
         §§push(currentAddr);
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            _loc5_ = 8;
            _loc4_ = Math.ceil(_loc3_ / 65535);
         }
         else
         {
            if(level == CompressionLevel.FAST)
            {
               _loc4_ = Math.ceil(_loc3_ * 2 / 49152);
            }
            else
            {
               _loc4_ = Math.ceil(_loc3_ / 98304);
               if(level == CompressionLevel.NORMAL)
               {
                  _loc7_ = 458752;
               }
               else if(level == CompressionLevel.GOOD)
               {
                  _loc7_ = 524308;
               }
            }
            _loc6_ = 2;
            _loc5_ = 300;
         }
         var _loc2_:* = §§pop() + (_loc3_ * _loc6_ + _loc5_ * (_loc4_ + 1) + _loc7_);
         var _loc8_:uint = uint(_loc2_ + param1.bytesAvailable);
         var _loc9_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc10_:uint = _loc8_;
         if(_loc9_.length < _loc10_)
         {
            _loc9_.length = _loc8_;
            ApplicationDomain.currentDomain.domainMemory = _loc9_;
         }
         _loc3_ = 0;
         param1.readBytes(ApplicationDomain.currentDomain.domainMemory,_loc2_,_loc3_);
         return fastWrite(_loc2_,_loc8_);
      }
      
      public function updateAdler32(param1:int, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         while(param1 + 5552 <= param2)
         {
            _loc3_ = int(param1);
            while(_loc3_ < param1 + 5552)
            {
               s2 += (s1 << 4) + li8(_loc3_) * 16 + li8(_loc3_ + 1) * 15 + li8(_loc3_ + 2) * 14 + li8(_loc3_ + 3) * 13 + li8(_loc3_ + 4) * 12 + li8(_loc3_ + 5) * 11 + li8(_loc3_ + 6) * 10 + li8(_loc3_ + 7) * 9 + li8(_loc3_ + 8) * 8 + li8(_loc3_ + 9) * 7 + li8(_loc3_ + 10) * 6 + li8(_loc3_ + 11) * 5 + li8(_loc3_ + 12) * 4 + li8(_loc3_ + 13) * 3 + li8(_loc3_ + 14) * 2 + li8(_loc3_ + 15);
               s1 += li8(_loc3_) + li8(_loc3_ + 1) + li8(_loc3_ + 2) + li8(_loc3_ + 3) + li8(_loc3_ + 4) + li8(_loc3_ + 5) + li8(_loc3_ + 6) + li8(_loc3_ + 7) + li8(_loc3_ + 8) + li8(_loc3_ + 9) + li8(_loc3_ + 10) + li8(_loc3_ + 11) + li8(_loc3_ + 12) + li8(_loc3_ + 13) + li8(_loc3_ + 14) + li8(_loc3_ + 15);
               _loc3_ += 16;
            }
            s1 %= 65521;
            s2 %= 65521;
            param1 += 5552;
         }
         if(param1 != param2)
         {
            _loc3_ = int(param1);
            while(_loc3_ < param2)
            {
               _loc4_ = _loc3_++;
               s1 += li8(_loc4_);
               s2 += s1;
            }
            s1 %= 65521;
            s2 %= 65521;
         }
      }
      
      public function setupStaticScratchMem() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         if(level == CompressionLevel.NORMAL || level == CompressionLevel.GOOD)
         {
            _loc1_ = scratchAddr + 2492;
            si32(16842755,_loc1_ + 12);
            si32(16908292,_loc1_ + 16);
            si32(16973829,_loc1_ + 20);
            si32(17039366,_loc1_ + 24);
            si32(17104903,_loc1_ + 28);
            si32(17170440,_loc1_ + 32);
            si32(17235977,_loc1_ + 36);
            si32(17301514,_loc1_ + 40);
            _loc2_ = 11;
            _loc3_ = 265;
            _loc4_ = 1;
            while(_loc4_ < 6)
            {
               _loc5_ = _loc4_++;
               _loc6_ = 0;
               while(_loc6_ < 4)
               {
                  _loc7_ = _loc6_++;
                  _loc8_ = _loc2_;
                  _loc9_ = _loc2_ + (1 << _loc5_);
                  while(_loc8_ < _loc9_)
                  {
                     _loc10_ = _loc8_++;
                     si32(_loc3_ << 16 | _loc5_ << 13 | _loc2_,_loc1_ + _loc10_ * 4);
                  }
                  _loc2_ += 1 << _loc5_;
                  _loc3_++;
               }
            }
            si32(18678018,_loc1_ + 1032);
            _loc1_ = scratchAddr + 3528;
            si32(1,_loc1_ + 4);
            si32(16777218,_loc1_ + 8);
            si32(33554435,_loc1_ + 12);
            si32(50331652,_loc1_ + 16);
            _loc2_ = 5;
            _loc3_ = 4;
            _loc4_ = 1;
            while(_loc4_ < 7)
            {
               _loc5_ = _loc4_++;
               _loc6_ = 0;
               while(_loc6_ < 2)
               {
                  _loc7_ = _loc6_++;
                  _loc8_ = _loc2_;
                  _loc9_ = _loc2_ + (1 << _loc5_);
                  while(_loc8_ < _loc9_)
                  {
                     _loc10_ = _loc8_++;
                     si32(_loc3_ << 24 | _loc5_ << 16 | _loc2_,_loc1_ + _loc10_ * 4);
                  }
                  _loc2_ += 1 << _loc5_;
                  _loc3_++;
               }
            }
            _loc1_ += 1024;
            _loc4_ = 7;
            while(_loc4_ < 14)
            {
               _loc5_ = _loc4_++;
               _loc6_ = 0;
               while(_loc6_ < 2)
               {
                  _loc7_ = _loc6_++;
                  _loc8_ = _loc2_ >>> 7;
                  _loc9_ = (_loc2_ >>> 7) + (1 << _loc5_ - 7);
                  while(_loc8_ < _loc9_)
                  {
                     _loc10_ = _loc8_++;
                     si32(_loc3_ << 24 | _loc5_ << 16 | _loc2_,_loc1_ + _loc10_ * 4);
                  }
                  _loc2_ += 1 << _loc5_;
                  _loc3_++;
               }
            }
         }
      }
      
      public function release() : void
      {
         var _loc1_:int = 0;
         if(bitOffset > 0)
         {
            _loc1_ = li8(currentAddr);
            si8(_loc1_,startAddr);
         }
         else
         {
            si8(0,startAddr);
         }
         blockStartAddr = uint(startAddr - (currentAddr - blockStartAddr));
         currentAddr = startAddr;
      }
      
      public function peek() : MemoryRange
      {
         rangeResult.offset = startAddr;
         rangeResult.end = currentAddr;
         return rangeResult;
      }
      
      public function maxOutputBufferSize(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 1;
         var _loc5_:int = 0;
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            _loc3_ = 8;
            _loc2_ = Math.ceil(param1 / 65535);
         }
         else
         {
            if(level == CompressionLevel.FAST)
            {
               _loc2_ = Math.ceil(param1 * 2 / 49152);
            }
            else
            {
               _loc2_ = Math.ceil(param1 / 98304);
               if(level == CompressionLevel.NORMAL)
               {
                  _loc5_ = 458752;
               }
               else if(level == CompressionLevel.GOOD)
               {
                  _loc5_ = 524308;
               }
            }
            _loc4_ = 2;
            _loc3_ = 300;
         }
         return param1 * _loc4_ + _loc3_ * (_loc2_ + 1) + _loc5_;
      }
      
      public function incSymbolFrequency(param1:int, param2:int = 0) : void
      {
         var _loc3_:* = scratchAddr + param2 + (param1 << 2);
         var _loc4_:* = li32(_loc3_) + 1;
         si32(_loc4_,_loc3_);
      }
      
      public function getDistanceInfo(param1:int) : int
      {
         return li32(scratchAddr + 3528 + ((param1 <= 256 ? param1 : 256 + (param1 - 1 >>> 7)) << 2));
      }
      
      public function finalize() : ByteArray
      {
         var _loc1_:MemoryRange = fastFinalize();
         var _loc2_:ByteArray = new ByteArray();
         if(zlib)
         {
            _loc2_.endian = Endian.BIG_ENDIAN;
         }
         else
         {
            _loc2_.endian = Endian.LITTLE_ENDIAN;
         }
         var _loc3_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         _loc3_.position = _loc1_.offset;
         _loc3_.readBytes(_loc2_,0,_loc1_.end - _loc1_.offset);
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public function fastWrite(param1:int, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc8_:* = null as ByteArray;
         var _loc9_:uint = 0;
         var _loc10_:* = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc35_:* = null as LZHash;
         var _loc36_:* = 0;
         var _loc37_:* = 0;
         var _loc38_:* = 0;
         var _loc39_:* = 0;
         var _loc40_:* = 0;
         var _loc41_:* = 0;
         var _loc42_:* = 0;
         var _loc43_:* = 0;
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            _loc3_ = int(param1);
            if(zlib)
            {
               _loc4_ = int(_loc3_);
               while(_loc4_ + 5552 <= param2)
               {
                  _loc5_ = int(_loc4_);
                  while(_loc5_ < _loc4_ + 5552)
                  {
                     s2 += (s1 << 4) + li8(_loc5_) * 16 + li8(_loc5_ + 1) * 15 + li8(_loc5_ + 2) * 14 + li8(_loc5_ + 3) * 13 + li8(_loc5_ + 4) * 12 + li8(_loc5_ + 5) * 11 + li8(_loc5_ + 6) * 10 + li8(_loc5_ + 7) * 9 + li8(_loc5_ + 8) * 8 + li8(_loc5_ + 9) * 7 + li8(_loc5_ + 10) * 6 + li8(_loc5_ + 11) * 5 + li8(_loc5_ + 12) * 4 + li8(_loc5_ + 13) * 3 + li8(_loc5_ + 14) * 2 + li8(_loc5_ + 15);
                     s1 += li8(_loc5_) + li8(_loc5_ + 1) + li8(_loc5_ + 2) + li8(_loc5_ + 3) + li8(_loc5_ + 4) + li8(_loc5_ + 5) + li8(_loc5_ + 6) + li8(_loc5_ + 7) + li8(_loc5_ + 8) + li8(_loc5_ + 9) + li8(_loc5_ + 10) + li8(_loc5_ + 11) + li8(_loc5_ + 12) + li8(_loc5_ + 13) + li8(_loc5_ + 14) + li8(_loc5_ + 15);
                     _loc5_ += 16;
                  }
                  s1 %= 65521;
                  s2 %= 65521;
                  _loc4_ += 5552;
               }
               if(_loc4_ != param2)
               {
                  _loc5_ = int(_loc4_);
                  while(_loc5_ < param2)
                  {
                     _loc6_ = int(_loc5_++);
                     s1 += li8(_loc6_);
                     s2 += s1;
                  }
                  s1 %= 65521;
                  s2 %= 65521;
               }
            }
            _loc4_ = 8;
            _loc5_ = param2 - _loc3_;
            _loc6_ = int(Math.ceil(_loc5_ / 65535));
            _loc7_ = _loc5_ + _loc4_ * _loc6_;
            _loc8_ = ApplicationDomain.currentDomain.domainMemory;
            _loc9_ = uint(_loc8_.length - currentAddr);
            if(_loc9_ < _loc7_)
            {
               _loc8_.length = uint(currentAddr + _loc7_);
               ApplicationDomain.currentDomain.domainMemory = _loc8_;
            }
            while(param2 - _loc3_ > 0)
            {
               _loc11_ = Number(Math.min(param2 - _loc3_,65535));
               _loc10_ = int(_loc11_);
               _loc12_ = false;
               blockInProgress = true;
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  if(bitOffset == 0)
                  {
                     si8(0,currentAddr);
                  }
                  _loc13_ = int(li8(currentAddr));
                  _loc13_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                  si32(_loc13_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  if(bitOffset > 0)
                  {
                     _loc13_ = int(li8(currentAddr));
                     _loc13_ |= 0 << bitOffset;
                     si32(_loc13_,currentAddr);
                     bitOffset += 8 - bitOffset;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
               }
               else
               {
                  _loc13_ = int(li8(currentAddr));
                  _loc13_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                  si32(_loc13_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockStartAddr = currentAddr;
               si16(_loc10_,currentAddr);
               currentAddr += 2;
               si16(~_loc10_,currentAddr);
               currentAddr += 2;
               _loc13_ = _loc3_ + _loc10_;
               _loc14_ = _loc3_ + (_loc10_ & -32);
               _loc15_ = int(_loc3_);
               while(_loc15_ < _loc14_)
               {
                  _loc16_ = int(li32(_loc15_));
                  si32(_loc16_,currentAddr);
                  _loc16_ = int(li32(_loc15_ + 4));
                  si32(_loc16_,currentAddr + 4);
                  _loc16_ = int(li32(_loc15_ + 8));
                  si32(_loc16_,currentAddr + 8);
                  _loc16_ = int(li32(_loc15_ + 12));
                  si32(_loc16_,currentAddr + 12);
                  _loc16_ = int(li32(_loc15_ + 16));
                  si32(_loc16_,currentAddr + 16);
                  _loc16_ = int(li32(_loc15_ + 20));
                  si32(_loc16_,currentAddr + 20);
                  _loc16_ = int(li32(_loc15_ + 24));
                  si32(_loc16_,currentAddr + 24);
                  _loc16_ = int(li32(_loc15_ + 28));
                  si32(_loc16_,currentAddr + 28);
                  currentAddr += 32;
                  _loc15_ += 32;
               }
               while(_loc15_ < _loc13_)
               {
                  _loc16_ = int(li8(_loc15_));
                  si8(_loc16_,currentAddr);
                  currentAddr = currentAddr + 1;
                  _loc15_++;
               }
               if(level != CompressionLevel.UNCOMPRESSED)
               {
                  _loc16_ = 0;
                  _loc17_ = int(li32(scratchAddr + _loc16_ + 1024));
                  _loc18_ = int(li8(currentAddr));
                  _loc18_ |= _loc17_ >>> 16 << bitOffset;
                  si32(_loc18_,currentAddr);
                  bitOffset += _loc17_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockInProgress = false;
               _loc3_ += _loc10_;
            }
         }
         else
         {
            _loc3_ = param2 - param1;
            _loc8_ = ApplicationDomain.currentDomain.domainMemory;
            _loc6_ = 1;
            _loc10_ = 0;
            if(level == CompressionLevel.UNCOMPRESSED)
            {
               _loc5_ = 8;
               _loc4_ = int(Math.ceil(_loc3_ / 65535));
            }
            else
            {
               if(level == CompressionLevel.FAST)
               {
                  _loc4_ = int(Math.ceil(_loc3_ * 2 / 49152));
               }
               else
               {
                  _loc4_ = int(Math.ceil(_loc3_ / 98304));
                  if(level == CompressionLevel.NORMAL)
                  {
                     _loc10_ = 458752;
                  }
                  else if(level == CompressionLevel.GOOD)
                  {
                     _loc10_ = 524308;
                  }
               }
               _loc6_ = 2;
               _loc5_ = 300;
            }
            _loc7_ = _loc3_ * _loc6_ + _loc5_ * (_loc4_ + 1) + _loc10_ + currentAddr;
            if(_loc7_ > _loc8_.length)
            {
               _loc6_ = 1;
               _loc10_ = 0;
               §§push(_loc8_);
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  _loc5_ = 8;
                  _loc4_ = int(Math.ceil(_loc3_ / 65535));
               }
               else
               {
                  if(level == CompressionLevel.FAST)
                  {
                     _loc4_ = int(Math.ceil(_loc3_ * 2 / 49152));
                  }
                  else
                  {
                     _loc4_ = int(Math.ceil(_loc3_ / 98304));
                     if(level == CompressionLevel.NORMAL)
                     {
                        _loc10_ = 458752;
                     }
                     else if(level == CompressionLevel.GOOD)
                     {
                        _loc10_ = 524308;
                     }
                  }
                  _loc6_ = 2;
                  _loc5_ = 300;
               }
               §§pop().length = _loc3_ * _loc6_ + _loc5_ * (_loc4_ + 1) + _loc10_ + currentAddr;
               ApplicationDomain.currentDomain.domainMemory = _loc8_;
            }
            if(zlib)
            {
               _loc4_ = int(param1);
               while(_loc4_ + 5552 <= param2)
               {
                  _loc5_ = int(_loc4_);
                  while(_loc5_ < _loc4_ + 5552)
                  {
                     s2 += (s1 << 4) + li8(_loc5_) * 16 + li8(_loc5_ + 1) * 15 + li8(_loc5_ + 2) * 14 + li8(_loc5_ + 3) * 13 + li8(_loc5_ + 4) * 12 + li8(_loc5_ + 5) * 11 + li8(_loc5_ + 6) * 10 + li8(_loc5_ + 7) * 9 + li8(_loc5_ + 8) * 8 + li8(_loc5_ + 9) * 7 + li8(_loc5_ + 10) * 6 + li8(_loc5_ + 11) * 5 + li8(_loc5_ + 12) * 4 + li8(_loc5_ + 13) * 3 + li8(_loc5_ + 14) * 2 + li8(_loc5_ + 15);
                     s1 += li8(_loc5_) + li8(_loc5_ + 1) + li8(_loc5_ + 2) + li8(_loc5_ + 3) + li8(_loc5_ + 4) + li8(_loc5_ + 5) + li8(_loc5_ + 6) + li8(_loc5_ + 7) + li8(_loc5_ + 8) + li8(_loc5_ + 9) + li8(_loc5_ + 10) + li8(_loc5_ + 11) + li8(_loc5_ + 12) + li8(_loc5_ + 13) + li8(_loc5_ + 14) + li8(_loc5_ + 15);
                     _loc5_ += 16;
                  }
                  s1 %= 65521;
                  s2 %= 65521;
                  _loc4_ += 5552;
               }
               if(_loc4_ != param2)
               {
                  _loc5_ = int(_loc4_);
                  while(_loc5_ < param2)
                  {
                     _loc6_ = int(_loc5_++);
                     s1 += li8(_loc6_);
                     s2 += s1;
                  }
                  s1 %= 65521;
                  s2 %= 65521;
               }
            }
            if(level == CompressionLevel.FAST)
            {
               _loc4_ = int(param1);
               _loc5_ = 2048;
               _loc6_ = int(_loc4_);
               while(param2 - _loc4_ > _loc5_)
               {
                  _loc10_ = _loc4_ + _loc5_;
                  if(!blockInProgress)
                  {
                     _loc12_ = false;
                     blockInProgress = true;
                     if(level == CompressionLevel.UNCOMPRESSED)
                     {
                        if(bitOffset == 0)
                        {
                           si8(0,currentAddr);
                        }
                        _loc13_ = int(li8(currentAddr));
                        _loc13_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                        si32(_loc13_,currentAddr);
                        bitOffset += 3;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        if(bitOffset > 0)
                        {
                           _loc13_ = int(li8(currentAddr));
                           _loc13_ |= 0 << bitOffset;
                           si32(_loc13_,currentAddr);
                           bitOffset += 8 - bitOffset;
                           currentAddr += bitOffset >>> 3;
                           bitOffset &= 7;
                        }
                     }
                     else
                     {
                        _loc13_ = int(li8(currentAddr));
                        _loc13_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                        si32(_loc13_,currentAddr);
                        bitOffset += 3;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     blockStartAddr = currentAddr;
                     _loc11_ = Number(Math.min(param2,_loc4_ + 98304));
                     createAndWriteHuffmanTrees(_loc4_,int(_loc11_));
                  }
                  while(_loc6_ < _loc10_)
                  {
                     _loc13_ = int(li8(_loc6_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                  }
                  _loc4_ += _loc5_;
                  if((!!blockInProgress ? currentAddr - blockStartAddr : 0) > 49152)
                  {
                     if(level != CompressionLevel.UNCOMPRESSED)
                     {
                        _loc13_ = 0;
                        _loc14_ = int(li32(scratchAddr + _loc13_ + 1024));
                        _loc15_ = int(li8(currentAddr));
                        _loc15_ |= _loc14_ >>> 16 << bitOffset;
                        si32(_loc15_,currentAddr);
                        bitOffset += _loc14_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     blockInProgress = false;
                  }
               }
               if(_loc6_ < param2)
               {
                  if(!blockInProgress)
                  {
                     _loc12_ = false;
                     blockInProgress = true;
                     if(level == CompressionLevel.UNCOMPRESSED)
                     {
                        if(bitOffset == 0)
                        {
                           si8(0,currentAddr);
                        }
                        _loc13_ = int(li8(currentAddr));
                        _loc13_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                        si32(_loc13_,currentAddr);
                        bitOffset += 3;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        if(bitOffset > 0)
                        {
                           _loc13_ = int(li8(currentAddr));
                           _loc13_ |= 0 << bitOffset;
                           si32(_loc13_,currentAddr);
                           bitOffset += 8 - bitOffset;
                           currentAddr += bitOffset >>> 3;
                           bitOffset &= 7;
                        }
                     }
                     else
                     {
                        _loc13_ = int(li8(currentAddr));
                        _loc13_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                        si32(_loc13_,currentAddr);
                        bitOffset += 3;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     blockStartAddr = currentAddr;
                     createAndWriteHuffmanTrees(_loc4_,param2);
                  }
                  while(_loc6_ < param2)
                  {
                     _loc13_ = int(li8(_loc6_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                  }
                  if((!!blockInProgress ? currentAddr - blockStartAddr : 0) > 49152)
                  {
                     if(level != CompressionLevel.UNCOMPRESSED)
                     {
                        _loc13_ = 0;
                        _loc14_ = int(li32(scratchAddr + _loc13_ + 1024));
                        _loc15_ = int(li8(currentAddr));
                        _loc15_ |= _loc14_ >>> 16 << bitOffset;
                        si32(_loc15_,currentAddr);
                        bitOffset += _loc14_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     blockInProgress = false;
                  }
               }
            }
            else if(level == CompressionLevel.NORMAL)
            {
               _loc4_ = int(param1);
               _loc22_ = param2 - _loc4_;
               _loc25_ = 1;
               _loc26_ = 0;
               §§push(currentAddr);
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  _loc24_ = 8;
                  _loc23_ = int(Math.ceil(_loc22_ / 65535));
               }
               else
               {
                  if(level == CompressionLevel.FAST)
                  {
                     _loc23_ = int(Math.ceil(_loc22_ * 2 / 49152));
                  }
                  else
                  {
                     _loc23_ = int(Math.ceil(_loc22_ / 98304));
                     if(level == CompressionLevel.NORMAL)
                     {
                        _loc26_ = 458752;
                     }
                     else if(level == CompressionLevel.GOOD)
                     {
                        _loc26_ = 524308;
                     }
                  }
                  _loc25_ = 2;
                  _loc24_ = 300;
               }
               _loc21_ = §§pop() + (_loc22_ * _loc25_ + _loc24_ * (_loc23_ + 1) + _loc26_) - 262144;
               _loc22_ = _loc21_ - 196608;
               _loc17_ = _loc21_ + 262144 - 32;
               while(_loc17_ >= _loc21_)
               {
                  si32(-1,_loc17_);
                  si32(-1,_loc17_ + 4);
                  si32(-1,_loc17_ + 8);
                  si32(-1,_loc17_ + 12);
                  si32(-1,_loc17_ + 16);
                  si32(-1,_loc17_ + 20);
                  si32(-1,_loc17_ + 24);
                  si32(-1,_loc17_ + 28);
                  _loc17_ -= 32;
               }
               while(param2 - _loc4_ > 0)
               {
                  _loc11_ = Number(Math.min(param2,_loc4_ + 98304));
                  _loc5_ = int(_loc11_);
                  _loc6_ = _loc5_ - 4;
                  _loc24_ = 0;
                  while(_loc24_ < 286)
                  {
                     _loc25_ = int(_loc24_++);
                     si32(0,scratchAddr + (_loc25_ << 2));
                  }
                  _loc24_ = 0;
                  while(_loc24_ < 30)
                  {
                     _loc25_ = int(_loc24_++);
                     si32(0,scratchAddr + 1144 + (_loc25_ << 2));
                  }
                  _loc23_ = int(_loc22_);
                  _loc17_ = int(_loc4_);
                  while(_loc17_ < _loc6_)
                  {
                     _loc24_ = 775236557;
                     _loc25_ = -862048943;
                     _loc26_ = 461845907;
                     _loc27_ = li32(_loc17_) * _loc25_;
                     _loc27_ = _loc27_ << 15 | _loc27_ >>> 17;
                     _loc24_ ^= _loc27_ * _loc26_;
                     _loc24_ = _loc24_ << 13 | _loc24_ >>> 19;
                     _loc24_ = _loc24_ * 5 + -430675100;
                     _loc28_ = _loc24_ ^ 4;
                     _loc28_ ^= _loc28_ >>> 16;
                     _loc28_ *= -2048144789;
                     _loc28_ ^= _loc28_ >>> 13;
                     _loc28_ *= -1028477387;
                     _loc16_ = ((_loc28_ ^ _loc28_ >>> 16) & 65535) << 2;
                     _loc18_ = int(li32(_loc21_ + _loc16_));
                     if(_loc18_ >= 0 && li32(_loc18_) == li32(_loc17_))
                     {
                        _loc13_ = 4;
                        _loc18_ += 4;
                        _loc20_ = _loc17_ + 4;
                        while(_loc20_ < _loc5_ && li8(_loc18_) == li8(_loc20_) && _loc13_ < 258)
                        {
                           _loc18_++;
                           _loc20_++;
                           _loc13_++;
                        }
                        si32(_loc17_,_loc21_ + _loc16_);
                        _loc14_ = _loc20_ - _loc18_;
                        if(_loc14_ <= 32768)
                        {
                           _loc24_ = int(li16(scratchAddr + 2492 + (_loc13_ << 2) + 2));
                           _loc25_ = 0;
                           _loc26_ = scratchAddr + _loc25_ + (_loc24_ << 2);
                           _loc27_ = li32(_loc26_) + 1;
                           si32(_loc27_,_loc26_);
                           _loc15_ = int(li32(scratchAddr + 3528 + ((_loc14_ <= 256 ? _loc14_ : 256 + (_loc14_ - 1 >>> 7)) << 2)));
                           _loc24_ = scratchAddr + 1144 + (_loc15_ >>> 24 << 2);
                           _loc25_ = li32(_loc24_) + 1;
                           si32(_loc25_,_loc24_);
                           si32(_loc13_ | 512 | _loc14_ << 16,_loc23_);
                           _loc23_ += 4;
                           _loc17_ += _loc13_;
                           if(_loc17_ < _loc6_)
                           {
                              _loc25_ = 775236557;
                              _loc26_ = -862048943;
                              _loc27_ = 461845907;
                              _loc28_ = li32(_loc17_ - 1) * _loc26_;
                              _loc28_ = _loc28_ << 15 | _loc28_ >>> 17;
                              _loc25_ ^= _loc28_ * _loc27_;
                              _loc25_ = _loc25_ << 13 | _loc25_ >>> 19;
                              _loc25_ = _loc25_ * 5 + -430675100;
                              _loc29_ = _loc25_ ^ 4;
                              _loc29_ ^= _loc29_ >>> 16;
                              _loc29_ *= -2048144789;
                              _loc29_ ^= _loc29_ >>> 13;
                              _loc29_ *= -1028477387;
                              _loc24_ = _loc21_ + (((_loc29_ ^ _loc29_ >>> 16) & 65535) << 2);
                              si32(_loc17_ - 1,_loc24_);
                           }
                        }
                        else
                        {
                           _loc10_ = int(li8(_loc17_));
                           si16(_loc10_,_loc23_);
                           _loc24_ = 0;
                           _loc25_ = scratchAddr + _loc24_ + (_loc10_ << 2);
                           _loc26_ = li32(_loc25_) + 1;
                           si32(_loc26_,_loc25_);
                           _loc23_ += 2;
                           _loc17_++;
                        }
                     }
                     else
                     {
                        _loc10_ = int(li8(_loc17_));
                        si16(_loc10_,_loc23_);
                        _loc24_ = 0;
                        _loc25_ = scratchAddr + _loc24_ + (_loc10_ << 2);
                        _loc26_ = li32(_loc25_) + 1;
                        si32(_loc26_,_loc25_);
                        si32(_loc17_,_loc21_ + _loc16_);
                        _loc23_ += 2;
                        _loc17_++;
                     }
                  }
                  while(_loc17_ < _loc5_)
                  {
                     _loc10_ = int(li8(_loc17_));
                     si16(_loc10_,_loc23_);
                     _loc24_ = 0;
                     _loc25_ = scratchAddr + _loc24_ + (_loc10_ << 2);
                     _loc26_ = li32(_loc25_) + 1;
                     si32(_loc26_,_loc25_);
                     _loc23_ += 2;
                     _loc17_++;
                  }
                  _loc12_ = false;
                  blockInProgress = true;
                  if(level == CompressionLevel.UNCOMPRESSED)
                  {
                     if(bitOffset == 0)
                     {
                        si8(0,currentAddr);
                     }
                     _loc24_ = int(li8(currentAddr));
                     _loc24_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                     si32(_loc24_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     if(bitOffset > 0)
                     {
                        _loc24_ = int(li8(currentAddr));
                        _loc24_ |= 0 << bitOffset;
                        si32(_loc24_,currentAddr);
                        bitOffset += 8 - bitOffset;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                  }
                  else
                  {
                     _loc24_ = int(li8(currentAddr));
                     _loc24_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                     si32(_loc24_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockStartAddr = currentAddr;
                  createAndWriteHuffmanTrees(_loc4_,_loc5_);
                  _loc17_ = int(_loc22_);
                  while(_loc17_ + 64 <= _loc23_)
                  {
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                  }
                  while(_loc17_ < _loc23_)
                  {
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                  }
                  if(level != CompressionLevel.UNCOMPRESSED)
                  {
                     _loc24_ = 0;
                     _loc25_ = int(li32(scratchAddr + _loc24_ + 1024));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockInProgress = false;
                  _loc4_ = int(_loc5_);
               }
            }
            else
            {
               if(level != CompressionLevel.GOOD)
               {
                  throw new Error("Compression level not supported");
               }
               _loc4_ = int(param1);
               _loc18_ = param2 - _loc4_;
               _loc22_ = 1;
               _loc23_ = 0;
               §§push(currentAddr);
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  _loc21_ = 8;
                  _loc20_ = int(Math.ceil(_loc18_ / 65535));
               }
               else
               {
                  if(level == CompressionLevel.FAST)
                  {
                     _loc20_ = int(Math.ceil(_loc18_ * 2 / 49152));
                  }
                  else
                  {
                     _loc20_ = int(Math.ceil(_loc18_ / 98304));
                     if(level == CompressionLevel.NORMAL)
                     {
                        _loc23_ = 458752;
                     }
                     else if(level == CompressionLevel.GOOD)
                     {
                        _loc23_ = 524308;
                     }
                  }
                  _loc22_ = 2;
                  _loc21_ = 300;
               }
               _loc17_ = §§pop() + (_loc18_ * _loc22_ + _loc21_ * (_loc20_ + 1) + _loc23_) - 327700;
               _loc18_ = _loc17_ - 196608;
               _loc35_ = new LZHash(_loc17_,258,32768);
               while(param2 - _loc4_ > 0)
               {
                  _loc11_ = Number(Math.min(param2,_loc4_ + 98304));
                  _loc5_ = int(_loc11_);
                  _loc10_ = _loc5_ - 9;
                  _loc6_ = _loc10_ - 516 - 1;
                  _loc21_ = 0;
                  while(_loc21_ < 286)
                  {
                     _loc22_ = int(_loc21_++);
                     si32(0,scratchAddr + (_loc22_ << 2));
                  }
                  _loc21_ = 0;
                  while(_loc21_ < 30)
                  {
                     _loc22_ = int(_loc21_++);
                     si32(0,scratchAddr + 1144 + (_loc22_ << 2));
                  }
                  _loc20_ = int(_loc18_);
                  _loc16_ = int(_loc4_);
                  if(_loc16_ < _loc6_)
                  {
                     _loc23_ = 775236557;
                     _loc24_ = -862048943;
                     _loc25_ = 461845907;
                     _loc26_ = li32(_loc4_) * _loc24_;
                     _loc26_ = _loc26_ << 15 | _loc26_ >>> 17;
                     _loc23_ ^= _loc26_ * _loc25_;
                     _loc23_ = _loc23_ << 13 | _loc23_ >>> 19;
                     _loc23_ = _loc23_ * 5 + -430675100;
                     _loc27_ = _loc23_ ^ 4;
                     _loc27_ ^= _loc27_ >>> 16;
                     _loc27_ *= -2048144789;
                     _loc27_ ^= _loc27_ >>> 13;
                     _loc27_ *= -1028477387;
                     _loc22_ = (_loc27_ ^ _loc27_ >>> 16) & 65535;
                     _loc21_ = _loc35_.addr + _loc22_ * 5;
                     _loc22_ = 3;
                     _loc23_ = -1;
                     _loc25_ = int(li32(_loc21_ + 1));
                     if(_loc25_ >= 0 && li32(_loc4_) == li32(_loc25_) && _loc4_ - _loc25_ <= _loc35_.windowSize)
                     {
                        _loc26_ = _loc4_ + 4;
                        _loc24_ = 4;
                        _loc25_ += 4;
                        while(li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc35_.maxMatchLength)
                        {
                           _loc24_ += 4;
                           _loc25_ += 4;
                           _loc26_ += 4;
                        }
                        while(li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc35_.maxMatchLength)
                        {
                           _loc24_++;
                           _loc25_++;
                           _loc26_++;
                        }
                        _loc22_ = int(_loc24_);
                        _loc23_ = int(_loc25_);
                     }
                     _loc27_ = 5;
                     _loc28_ = 9;
                     while(_loc27_ < _loc28_)
                     {
                        _loc29_ = int(_loc27_++);
                        _loc36_ = int(li32(_loc4_));
                        si32(_loc36_,_loc35_.hashScratchAddr);
                        _loc36_ = int(li32(_loc4_ + 4));
                        si32(_loc36_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc29_);
                        _loc36_ = 775236557;
                        _loc37_ = -862048943;
                        _loc38_ = 461845907;
                        _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                        _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                        _loc36_ ^= _loc39_ * _loc38_;
                        _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                        _loc36_ = _loc36_ * 5 + -430675100;
                        _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                        _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                        _loc36_ ^= _loc39_ * _loc38_;
                        _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                        _loc36_ = _loc36_ * 5 + -430675100;
                        _loc40_ = _loc36_ ^ _loc29_;
                        _loc40_ ^= _loc40_ >>> 16;
                        _loc40_ *= -2048144789;
                        _loc40_ ^= _loc40_ >>> 13;
                        _loc40_ *= -1028477387;
                        _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                        _loc30_ = _loc35_.addr + _loc31_ * 5 + 1;
                        _loc25_ = int(li32(_loc30_));
                        if(_loc25_ >= 0 && li32(_loc25_ + _loc22_ - 3) == li32(_loc4_ + _loc22_ - 3) && li32(_loc4_) == li32(_loc25_) && _loc4_ - _loc25_ <= _loc35_.windowSize)
                        {
                           _loc26_ = _loc4_ + 4;
                           _loc24_ = 4;
                           _loc25_ += 4;
                           while(li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc35_.maxMatchLength)
                           {
                              _loc24_ += 4;
                              _loc25_ += 4;
                              _loc26_ += 4;
                           }
                           while(li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc35_.maxMatchLength)
                           {
                              _loc24_++;
                              _loc25_++;
                              _loc26_++;
                           }
                           if(_loc24_ > _loc22_)
                           {
                              _loc22_ = int(_loc24_);
                              _loc23_ = int(_loc25_);
                           }
                        }
                     }
                     si32(_loc4_ - (_loc23_ - _loc22_) << 16 | _loc22_,_loc35_.resultAddr);
                     _loc22_ = int(_loc21_);
                     _loc23_ = 4;
                     _loc24_ = int(_loc4_);
                     if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                     {
                        _loc26_ = int(li32(_loc22_ + 1));
                        si8(_loc23_,_loc22_);
                        si32(_loc24_,_loc22_ + 1);
                        _loc23_ = _loc25_ + 1;
                        _loc24_ = int(_loc26_);
                        _loc28_ = int(li32(_loc24_));
                        si32(_loc28_,_loc35_.hashScratchAddr);
                        _loc28_ = int(li32(_loc24_ + 4));
                        si32(_loc28_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc23_);
                        _loc28_ = 775236557;
                        _loc29_ = -862048943;
                        _loc30_ = 461845907;
                        _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                        _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                        _loc28_ ^= _loc31_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                        _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                        _loc28_ ^= _loc31_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc36_ = _loc28_ ^ _loc23_;
                        _loc36_ ^= _loc36_ >>> 16;
                        _loc36_ *= -2048144789;
                        _loc36_ ^= _loc36_ >>> 13;
                        _loc36_ *= -1028477387;
                        _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                        _loc22_ = _loc35_.addr + _loc27_ * 5;
                        if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                        {
                           _loc26_ = int(li32(_loc22_ + 1));
                           si8(_loc23_,_loc22_);
                           si32(_loc24_,_loc22_ + 1);
                           _loc23_ = _loc25_ + 1;
                           _loc24_ = int(_loc26_);
                           _loc28_ = int(li32(_loc24_));
                           si32(_loc28_,_loc35_.hashScratchAddr);
                           _loc28_ = int(li32(_loc24_ + 4));
                           si32(_loc28_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc23_);
                           _loc28_ = 775236557;
                           _loc29_ = -862048943;
                           _loc30_ = 461845907;
                           _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                           _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                           _loc28_ ^= _loc31_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                           _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                           _loc28_ ^= _loc31_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc36_ = _loc28_ ^ _loc23_;
                           _loc36_ ^= _loc36_ >>> 16;
                           _loc36_ *= -2048144789;
                           _loc36_ ^= _loc36_ >>> 13;
                           _loc36_ *= -1028477387;
                           _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                           _loc22_ = _loc35_.addr + _loc27_ * 5;
                           if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                           {
                              _loc26_ = int(li32(_loc22_ + 1));
                              si8(_loc23_,_loc22_);
                              si32(_loc24_,_loc22_ + 1);
                              _loc23_ = _loc25_ + 1;
                              _loc24_ = int(_loc26_);
                              _loc28_ = int(li32(_loc24_));
                              si32(_loc28_,_loc35_.hashScratchAddr);
                              _loc28_ = int(li32(_loc24_ + 4));
                              si32(_loc28_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc23_);
                              _loc28_ = 775236557;
                              _loc29_ = -862048943;
                              _loc30_ = 461845907;
                              _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                              _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                              _loc28_ ^= _loc31_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                              _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                              _loc28_ ^= _loc31_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc36_ = _loc28_ ^ _loc23_;
                              _loc36_ ^= _loc36_ >>> 16;
                              _loc36_ *= -2048144789;
                              _loc36_ ^= _loc36_ >>> 13;
                              _loc36_ *= -1028477387;
                              _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                              _loc22_ = _loc35_.addr + _loc27_ * 5;
                              if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                              {
                                 _loc26_ = int(li32(_loc22_ + 1));
                                 si8(_loc23_,_loc22_);
                                 si32(_loc24_,_loc22_ + 1);
                                 _loc23_ = _loc25_ + 1;
                                 _loc24_ = int(_loc26_);
                                 _loc28_ = int(li32(_loc24_));
                                 si32(_loc28_,_loc35_.hashScratchAddr);
                                 _loc28_ = int(li32(_loc24_ + 4));
                                 si32(_loc28_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc23_);
                                 _loc28_ = 775236557;
                                 _loc29_ = -862048943;
                                 _loc30_ = 461845907;
                                 _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                                 _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                                 _loc28_ ^= _loc31_ * _loc30_;
                                 _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                                 _loc28_ = _loc28_ * 5 + -430675100;
                                 _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                                 _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                                 _loc28_ ^= _loc31_ * _loc30_;
                                 _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                                 _loc28_ = _loc28_ * 5 + -430675100;
                                 _loc36_ = _loc28_ ^ _loc23_;
                                 _loc36_ ^= _loc36_ >>> 16;
                                 _loc36_ *= -2048144789;
                                 _loc36_ ^= _loc36_ >>> 13;
                                 _loc36_ *= -1028477387;
                                 _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                                 _loc22_ = _loc35_.addr + _loc27_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc23_,_loc22_);
                     si32(_loc24_,_loc22_ + 1);
                     _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                  }
                  else if(_loc16_ < _loc10_)
                  {
                     _loc23_ = 775236557;
                     _loc24_ = -862048943;
                     _loc25_ = 461845907;
                     _loc26_ = li32(_loc4_) * _loc24_;
                     _loc26_ = _loc26_ << 15 | _loc26_ >>> 17;
                     _loc23_ ^= _loc26_ * _loc25_;
                     _loc23_ = _loc23_ << 13 | _loc23_ >>> 19;
                     _loc23_ = _loc23_ * 5 + -430675100;
                     _loc27_ = _loc23_ ^ 4;
                     _loc27_ ^= _loc27_ >>> 16;
                     _loc27_ *= -2048144789;
                     _loc27_ ^= _loc27_ >>> 13;
                     _loc27_ *= -1028477387;
                     _loc22_ = (_loc27_ ^ _loc27_ >>> 16) & 65535;
                     _loc21_ = _loc35_.addr + _loc22_ * 5;
                     _loc22_ = 3;
                     _loc23_ = -1;
                     _loc25_ = int(li32(_loc21_ + 1));
                     if(_loc25_ >= 0 && li32(_loc4_) == li32(_loc25_) && _loc4_ - _loc25_ <= _loc35_.windowSize)
                     {
                        _loc26_ = _loc4_ + 4;
                        _loc24_ = 4;
                        _loc25_ += 4;
                        while(_loc26_ + 4 <= _loc5_ && li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc35_.maxMatchLength)
                        {
                           _loc24_ += 4;
                           _loc25_ += 4;
                           _loc26_ += 4;
                        }
                        while(_loc26_ < _loc5_ && li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc35_.maxMatchLength)
                        {
                           _loc24_++;
                           _loc25_++;
                           _loc26_++;
                        }
                        _loc22_ = int(_loc24_);
                        _loc23_ = int(_loc25_);
                     }
                     _loc27_ = 5;
                     _loc28_ = 9;
                     while(_loc27_ < _loc28_)
                     {
                        _loc29_ = int(_loc27_++);
                        _loc36_ = int(li32(_loc4_));
                        si32(_loc36_,_loc35_.hashScratchAddr);
                        _loc36_ = int(li32(_loc4_ + 4));
                        si32(_loc36_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc29_);
                        _loc36_ = 775236557;
                        _loc37_ = -862048943;
                        _loc38_ = 461845907;
                        _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                        _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                        _loc36_ ^= _loc39_ * _loc38_;
                        _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                        _loc36_ = _loc36_ * 5 + -430675100;
                        _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                        _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                        _loc36_ ^= _loc39_ * _loc38_;
                        _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                        _loc36_ = _loc36_ * 5 + -430675100;
                        _loc40_ = _loc36_ ^ _loc29_;
                        _loc40_ ^= _loc40_ >>> 16;
                        _loc40_ *= -2048144789;
                        _loc40_ ^= _loc40_ >>> 13;
                        _loc40_ *= -1028477387;
                        _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                        _loc30_ = _loc35_.addr + _loc31_ * 5 + 1;
                        _loc25_ = int(li32(_loc30_));
                        if(_loc25_ >= 0 && li32(_loc4_) == li32(_loc25_) && _loc4_ - _loc25_ <= _loc35_.windowSize)
                        {
                           _loc26_ = _loc4_ + 4;
                           _loc24_ = 4;
                           _loc25_ += 4;
                           while(_loc26_ + 4 <= _loc5_ && li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc35_.maxMatchLength)
                           {
                              _loc24_ += 4;
                              _loc25_ += 4;
                              _loc26_ += 4;
                           }
                           while(_loc26_ < _loc5_ && li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc35_.maxMatchLength)
                           {
                              _loc24_++;
                              _loc25_++;
                              _loc26_++;
                           }
                           if(_loc24_ > _loc22_)
                           {
                              _loc22_ = int(_loc24_);
                              _loc23_ = int(_loc25_);
                           }
                        }
                     }
                     si32(_loc4_ - (_loc23_ - _loc22_) << 16 | _loc22_,_loc35_.resultAddr);
                     _loc22_ = int(_loc21_);
                     _loc23_ = 4;
                     _loc24_ = int(_loc4_);
                     if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                     {
                        _loc26_ = int(li32(_loc22_ + 1));
                        si8(_loc23_,_loc22_);
                        si32(_loc24_,_loc22_ + 1);
                        _loc23_ = _loc25_ + 1;
                        _loc24_ = int(_loc26_);
                        _loc28_ = int(li32(_loc24_));
                        si32(_loc28_,_loc35_.hashScratchAddr);
                        _loc28_ = int(li32(_loc24_ + 4));
                        si32(_loc28_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc23_);
                        _loc28_ = 775236557;
                        _loc29_ = -862048943;
                        _loc30_ = 461845907;
                        _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                        _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                        _loc28_ ^= _loc31_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                        _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                        _loc28_ ^= _loc31_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc36_ = _loc28_ ^ _loc23_;
                        _loc36_ ^= _loc36_ >>> 16;
                        _loc36_ *= -2048144789;
                        _loc36_ ^= _loc36_ >>> 13;
                        _loc36_ *= -1028477387;
                        _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                        _loc22_ = _loc35_.addr + _loc27_ * 5;
                        if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                        {
                           _loc26_ = int(li32(_loc22_ + 1));
                           si8(_loc23_,_loc22_);
                           si32(_loc24_,_loc22_ + 1);
                           _loc23_ = _loc25_ + 1;
                           _loc24_ = int(_loc26_);
                           _loc28_ = int(li32(_loc24_));
                           si32(_loc28_,_loc35_.hashScratchAddr);
                           _loc28_ = int(li32(_loc24_ + 4));
                           si32(_loc28_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc23_);
                           _loc28_ = 775236557;
                           _loc29_ = -862048943;
                           _loc30_ = 461845907;
                           _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                           _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                           _loc28_ ^= _loc31_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                           _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                           _loc28_ ^= _loc31_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc36_ = _loc28_ ^ _loc23_;
                           _loc36_ ^= _loc36_ >>> 16;
                           _loc36_ *= -2048144789;
                           _loc36_ ^= _loc36_ >>> 13;
                           _loc36_ *= -1028477387;
                           _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                           _loc22_ = _loc35_.addr + _loc27_ * 5;
                           if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                           {
                              _loc26_ = int(li32(_loc22_ + 1));
                              si8(_loc23_,_loc22_);
                              si32(_loc24_,_loc22_ + 1);
                              _loc23_ = _loc25_ + 1;
                              _loc24_ = int(_loc26_);
                              _loc28_ = int(li32(_loc24_));
                              si32(_loc28_,_loc35_.hashScratchAddr);
                              _loc28_ = int(li32(_loc24_ + 4));
                              si32(_loc28_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc23_);
                              _loc28_ = 775236557;
                              _loc29_ = -862048943;
                              _loc30_ = 461845907;
                              _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                              _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                              _loc28_ ^= _loc31_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                              _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                              _loc28_ ^= _loc31_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc36_ = _loc28_ ^ _loc23_;
                              _loc36_ ^= _loc36_ >>> 16;
                              _loc36_ *= -2048144789;
                              _loc36_ ^= _loc36_ >>> 13;
                              _loc36_ *= -1028477387;
                              _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                              _loc22_ = _loc35_.addr + _loc27_ * 5;
                              if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                              {
                                 _loc26_ = int(li32(_loc22_ + 1));
                                 si8(_loc23_,_loc22_);
                                 si32(_loc24_,_loc22_ + 1);
                                 _loc23_ = _loc25_ + 1;
                                 _loc24_ = int(_loc26_);
                                 _loc28_ = int(li32(_loc24_));
                                 si32(_loc28_,_loc35_.hashScratchAddr);
                                 _loc28_ = int(li32(_loc24_ + 4));
                                 si32(_loc28_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc23_);
                                 _loc28_ = 775236557;
                                 _loc29_ = -862048943;
                                 _loc30_ = 461845907;
                                 _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                                 _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                                 _loc28_ ^= _loc31_ * _loc30_;
                                 _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                                 _loc28_ = _loc28_ * 5 + -430675100;
                                 _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                                 _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                                 _loc28_ ^= _loc31_ * _loc30_;
                                 _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                                 _loc28_ = _loc28_ * 5 + -430675100;
                                 _loc36_ = _loc28_ ^ _loc23_;
                                 _loc36_ ^= _loc36_ >>> 16;
                                 _loc36_ *= -2048144789;
                                 _loc36_ ^= _loc36_ >>> 13;
                                 _loc36_ *= -1028477387;
                                 _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                                 _loc22_ = _loc35_.addr + _loc27_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc23_,_loc22_);
                     si32(_loc24_,_loc22_ + 1);
                     _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                  }
                  while(_loc16_ < _loc6_)
                  {
                     _loc24_ = 775236557;
                     _loc25_ = -862048943;
                     _loc26_ = 461845907;
                     _loc27_ = li32(_loc16_ + 1) * _loc25_;
                     _loc27_ = _loc27_ << 15 | _loc27_ >>> 17;
                     _loc24_ ^= _loc27_ * _loc26_;
                     _loc24_ = _loc24_ << 13 | _loc24_ >>> 19;
                     _loc24_ = _loc24_ * 5 + -430675100;
                     _loc28_ = _loc24_ ^ 4;
                     _loc28_ ^= _loc28_ >>> 16;
                     _loc28_ *= -2048144789;
                     _loc28_ ^= _loc28_ >>> 13;
                     _loc28_ *= -1028477387;
                     _loc23_ = (_loc28_ ^ _loc28_ >>> 16) & 65535;
                     _loc22_ = _loc35_.addr + _loc23_ * 5;
                     if(li16(_loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7)) < _loc35_.avgMatchLength + 4)
                     {
                        _loc23_ = _loc16_ + 1;
                        _loc24_ = 3;
                        _loc25_ = -1;
                        _loc27_ = int(li32(_loc22_ + 1));
                        if(_loc27_ >= 0 && li32(_loc23_) == li32(_loc27_) && _loc23_ - _loc27_ <= _loc35_.windowSize)
                        {
                           _loc28_ = _loc23_ + 4;
                           _loc26_ = 4;
                           _loc27_ += 4;
                           while(li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc35_.maxMatchLength)
                           {
                              _loc26_ += 4;
                              _loc27_ += 4;
                              _loc28_ += 4;
                           }
                           while(li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc35_.maxMatchLength)
                           {
                              _loc26_++;
                              _loc27_++;
                              _loc28_++;
                           }
                           _loc24_ = int(_loc26_);
                           _loc25_ = int(_loc27_);
                        }
                        _loc29_ = 5;
                        _loc30_ = 9;
                        while(_loc29_ < _loc30_)
                        {
                           _loc31_ = int(_loc29_++);
                           _loc38_ = int(li32(_loc23_));
                           si32(_loc38_,_loc35_.hashScratchAddr);
                           _loc38_ = int(li32(_loc23_ + 4));
                           si32(_loc38_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc31_);
                           _loc38_ = 775236557;
                           _loc39_ = -862048943;
                           _loc40_ = 461845907;
                           _loc41_ = li32(_loc35_.hashScratchAddr) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc41_ = li32(_loc35_.hashScratchAddr + 4) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc42_ = _loc38_ ^ _loc31_;
                           _loc42_ ^= _loc42_ >>> 16;
                           _loc42_ *= -2048144789;
                           _loc42_ ^= _loc42_ >>> 13;
                           _loc42_ *= -1028477387;
                           _loc37_ = (_loc42_ ^ _loc42_ >>> 16) & 65535;
                           _loc36_ = _loc35_.addr + _loc37_ * 5 + 1;
                           _loc27_ = int(li32(_loc36_));
                           if(_loc27_ >= 0 && li32(_loc27_ + _loc24_ - 3) == li32(_loc23_ + _loc24_ - 3) && li32(_loc23_) == li32(_loc27_) && _loc23_ - _loc27_ <= _loc35_.windowSize)
                           {
                              _loc28_ = _loc23_ + 4;
                              _loc26_ = 4;
                              _loc27_ += 4;
                              while(li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc35_.maxMatchLength)
                              {
                                 _loc26_ += 4;
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                              }
                              while(li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc35_.maxMatchLength)
                              {
                                 _loc26_++;
                                 _loc27_++;
                                 _loc28_++;
                              }
                              if(_loc26_ > _loc24_)
                              {
                                 _loc24_ = int(_loc26_);
                                 _loc25_ = int(_loc27_);
                              }
                           }
                        }
                        si32(_loc23_ - (_loc25_ - _loc24_) << 16 | _loc24_,_loc35_.resultAddr);
                     }
                     else
                     {
                        si32(0,_loc35_.resultAddr);
                     }
                     _loc23_ = int(_loc22_);
                     _loc24_ = 4;
                     _loc25_ = _loc16_ + 1;
                     if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                     {
                        _loc27_ = int(li32(_loc23_ + 1));
                        si8(_loc24_,_loc23_);
                        si32(_loc25_,_loc23_ + 1);
                        _loc24_ = _loc26_ + 1;
                        _loc25_ = int(_loc27_);
                        _loc29_ = int(li32(_loc25_));
                        si32(_loc29_,_loc35_.hashScratchAddr);
                        _loc29_ = int(li32(_loc25_ + 4));
                        si32(_loc29_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc24_);
                        _loc29_ = 775236557;
                        _loc30_ = -862048943;
                        _loc31_ = 461845907;
                        _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc29_ ^= _loc36_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc29_ ^= _loc36_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc37_ = _loc29_ ^ _loc24_;
                        _loc37_ ^= _loc37_ >>> 16;
                        _loc37_ *= -2048144789;
                        _loc37_ ^= _loc37_ >>> 13;
                        _loc37_ *= -1028477387;
                        _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                        _loc23_ = _loc35_.addr + _loc28_ * 5;
                        if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                        {
                           _loc27_ = int(li32(_loc23_ + 1));
                           si8(_loc24_,_loc23_);
                           si32(_loc25_,_loc23_ + 1);
                           _loc24_ = _loc26_ + 1;
                           _loc25_ = int(_loc27_);
                           _loc29_ = int(li32(_loc25_));
                           si32(_loc29_,_loc35_.hashScratchAddr);
                           _loc29_ = int(li32(_loc25_ + 4));
                           si32(_loc29_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc24_);
                           _loc29_ = 775236557;
                           _loc30_ = -862048943;
                           _loc31_ = 461845907;
                           _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                           _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                           _loc29_ ^= _loc36_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                           _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                           _loc29_ ^= _loc36_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc37_ = _loc29_ ^ _loc24_;
                           _loc37_ ^= _loc37_ >>> 16;
                           _loc37_ *= -2048144789;
                           _loc37_ ^= _loc37_ >>> 13;
                           _loc37_ *= -1028477387;
                           _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                           _loc23_ = _loc35_.addr + _loc28_ * 5;
                           if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                           {
                              _loc27_ = int(li32(_loc23_ + 1));
                              si8(_loc24_,_loc23_);
                              si32(_loc25_,_loc23_ + 1);
                              _loc24_ = _loc26_ + 1;
                              _loc25_ = int(_loc27_);
                              _loc29_ = int(li32(_loc25_));
                              si32(_loc29_,_loc35_.hashScratchAddr);
                              _loc29_ = int(li32(_loc25_ + 4));
                              si32(_loc29_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc24_);
                              _loc29_ = 775236557;
                              _loc30_ = -862048943;
                              _loc31_ = 461845907;
                              _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                              _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                              _loc29_ ^= _loc36_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                              _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                              _loc29_ ^= _loc36_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc37_ = _loc29_ ^ _loc24_;
                              _loc37_ ^= _loc37_ >>> 16;
                              _loc37_ *= -2048144789;
                              _loc37_ ^= _loc37_ >>> 13;
                              _loc37_ *= -1028477387;
                              _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                              _loc23_ = _loc35_.addr + _loc28_ * 5;
                              if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                              {
                                 _loc27_ = int(li32(_loc23_ + 1));
                                 si8(_loc24_,_loc23_);
                                 si32(_loc25_,_loc23_ + 1);
                                 _loc24_ = _loc26_ + 1;
                                 _loc25_ = int(_loc27_);
                                 _loc29_ = int(li32(_loc25_));
                                 si32(_loc29_,_loc35_.hashScratchAddr);
                                 _loc29_ = int(li32(_loc25_ + 4));
                                 si32(_loc29_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc24_);
                                 _loc29_ = 775236557;
                                 _loc30_ = -862048943;
                                 _loc31_ = 461845907;
                                 _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                                 _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                                 _loc29_ ^= _loc36_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                                 _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                                 _loc29_ ^= _loc36_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc37_ = _loc29_ ^ _loc24_;
                                 _loc37_ ^= _loc37_ >>> 16;
                                 _loc37_ *= -2048144789;
                                 _loc37_ ^= _loc37_ >>> 13;
                                 _loc37_ *= -1028477387;
                                 _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                                 _loc23_ = _loc35_.addr + _loc28_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc24_,_loc23_);
                     si32(_loc25_,_loc23_ + 1);
                     _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                     if(li16(_loc35_.resultAddr) >= 4)
                     {
                        _loc21_ = int(li16(_loc35_.resultAddr));
                        if(li16(_loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7)) > _loc21_)
                        {
                           si32(0,_loc35_.resultAddr);
                        }
                        else
                        {
                           _loc35_.avgMatchLength = (_loc35_.avgMatchLength << 1) + (_loc35_.avgMatchLength << 2) + (_loc21_ << 1) >>> 3;
                           if(_loc21_ < _loc35_.avgMatchLength + 4)
                           {
                              _loc23_ = _loc16_ + 1 + 1;
                              _loc24_ = _loc16_ + _loc21_;
                              while(_loc23_ < _loc24_)
                              {
                                 _loc25_ = int(_loc23_++);
                                 _loc26_ = 4;
                                 _loc27_ = int(_loc25_);
                                 _loc36_ = 775236557;
                                 _loc37_ = -862048943;
                                 _loc38_ = 461845907;
                                 _loc39_ = li32(_loc25_) * _loc37_;
                                 _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                 _loc36_ ^= _loc39_ * _loc38_;
                                 _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                 _loc36_ = _loc36_ * 5 + -430675100;
                                 _loc40_ = _loc36_ ^ 4;
                                 _loc40_ ^= _loc40_ >>> 16;
                                 _loc40_ *= -2048144789;
                                 _loc40_ ^= _loc40_ >>> 13;
                                 _loc40_ *= -1028477387;
                                 _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                 _loc30_ = _loc35_.addr + _loc31_ * 5;
                                 if((_loc28_ = int(li8(_loc30_))) < 8 && _loc28_ >= 0)
                                 {
                                    _loc29_ = int(li32(_loc30_ + 1));
                                    si8(_loc26_,_loc30_);
                                    si32(_loc27_,_loc30_ + 1);
                                    _loc26_ = _loc28_ + 1;
                                    _loc27_ = int(_loc29_);
                                    _loc36_ = int(li32(_loc27_));
                                    si32(_loc36_,_loc35_.hashScratchAddr);
                                    _loc36_ = int(li32(_loc27_ + 4));
                                    si32(_loc36_,_loc35_.hashScratchAddr + 4);
                                    si32(0,_loc35_.hashScratchAddr + _loc26_);
                                    _loc36_ = 775236557;
                                    _loc37_ = -862048943;
                                    _loc38_ = 461845907;
                                    _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                                    _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                    _loc36_ ^= _loc39_ * _loc38_;
                                    _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                    _loc36_ = _loc36_ * 5 + -430675100;
                                    _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                                    _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                    _loc36_ ^= _loc39_ * _loc38_;
                                    _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                    _loc36_ = _loc36_ * 5 + -430675100;
                                    _loc40_ = _loc36_ ^ _loc26_;
                                    _loc40_ ^= _loc40_ >>> 16;
                                    _loc40_ *= -2048144789;
                                    _loc40_ ^= _loc40_ >>> 13;
                                    _loc40_ *= -1028477387;
                                    _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                    _loc30_ = _loc35_.addr + _loc31_ * 5;
                                    if((_loc28_ = int(li8(_loc30_))) < 8 && _loc28_ >= 0)
                                    {
                                       _loc29_ = int(li32(_loc30_ + 1));
                                       si8(_loc26_,_loc30_);
                                       si32(_loc27_,_loc30_ + 1);
                                       _loc26_ = _loc28_ + 1;
                                       _loc27_ = int(_loc29_);
                                       _loc36_ = int(li32(_loc27_));
                                       si32(_loc36_,_loc35_.hashScratchAddr);
                                       _loc36_ = int(li32(_loc27_ + 4));
                                       si32(_loc36_,_loc35_.hashScratchAddr + 4);
                                       si32(0,_loc35_.hashScratchAddr + _loc26_);
                                       _loc36_ = 775236557;
                                       _loc37_ = -862048943;
                                       _loc38_ = 461845907;
                                       _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                                       _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                       _loc36_ ^= _loc39_ * _loc38_;
                                       _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                       _loc36_ = _loc36_ * 5 + -430675100;
                                       _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                                       _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                       _loc36_ ^= _loc39_ * _loc38_;
                                       _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                       _loc36_ = _loc36_ * 5 + -430675100;
                                       _loc40_ = _loc36_ ^ _loc26_;
                                       _loc40_ ^= _loc40_ >>> 16;
                                       _loc40_ *= -2048144789;
                                       _loc40_ ^= _loc40_ >>> 13;
                                       _loc40_ *= -1028477387;
                                       _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                       _loc30_ = _loc35_.addr + _loc31_ * 5;
                                    }
                                 }
                                 si8(_loc26_,_loc30_);
                                 si32(_loc27_,_loc30_ + 1);
                              }
                           }
                           _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                           _loc23_ = _loc16_ + _loc21_;
                           _loc26_ = 775236557;
                           _loc27_ = -862048943;
                           _loc28_ = 461845907;
                           _loc29_ = li32(_loc23_) * _loc27_;
                           _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                           _loc26_ ^= _loc29_ * _loc28_;
                           _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                           _loc26_ = _loc26_ * 5 + -430675100;
                           _loc30_ = _loc26_ ^ 4;
                           _loc30_ ^= _loc30_ >>> 16;
                           _loc30_ *= -2048144789;
                           _loc30_ ^= _loc30_ >>> 13;
                           _loc30_ *= -1028477387;
                           _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                           _loc24_ = _loc35_.addr + _loc25_ * 5;
                           _loc25_ = 3;
                           _loc26_ = -1;
                           _loc28_ = int(li32(_loc24_ + 1));
                           if(_loc28_ >= 0 && li32(_loc23_) == li32(_loc28_) && _loc23_ - _loc28_ <= _loc35_.windowSize)
                           {
                              _loc29_ = _loc23_ + 4;
                              _loc27_ = 4;
                              _loc28_ += 4;
                              while(li32(_loc28_) == li32(_loc29_) && _loc27_ + 4 <= _loc35_.maxMatchLength)
                              {
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                                 _loc29_ += 4;
                              }
                              while(li8(_loc28_) == li8(_loc29_) && _loc27_ < _loc35_.maxMatchLength)
                              {
                                 _loc27_++;
                                 _loc28_++;
                                 _loc29_++;
                              }
                              _loc25_ = int(_loc27_);
                              _loc26_ = int(_loc28_);
                           }
                           _loc30_ = 5;
                           _loc31_ = 9;
                           while(_loc30_ < _loc31_)
                           {
                              _loc36_ = int(_loc30_++);
                              _loc39_ = int(li32(_loc23_));
                              si32(_loc39_,_loc35_.hashScratchAddr);
                              _loc39_ = int(li32(_loc23_ + 4));
                              si32(_loc39_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc36_);
                              _loc39_ = 775236557;
                              _loc40_ = -862048943;
                              _loc41_ = 461845907;
                              _loc42_ = li32(_loc35_.hashScratchAddr) * _loc40_;
                              _loc42_ = _loc42_ << 15 | _loc42_ >>> 17;
                              _loc39_ ^= _loc42_ * _loc41_;
                              _loc39_ = _loc39_ << 13 | _loc39_ >>> 19;
                              _loc39_ = _loc39_ * 5 + -430675100;
                              _loc42_ = li32(_loc35_.hashScratchAddr + 4) * _loc40_;
                              _loc42_ = _loc42_ << 15 | _loc42_ >>> 17;
                              _loc39_ ^= _loc42_ * _loc41_;
                              _loc39_ = _loc39_ << 13 | _loc39_ >>> 19;
                              _loc39_ = _loc39_ * 5 + -430675100;
                              _loc43_ = _loc39_ ^ _loc36_;
                              _loc43_ ^= _loc43_ >>> 16;
                              _loc43_ *= -2048144789;
                              _loc43_ ^= _loc43_ >>> 13;
                              _loc43_ *= -1028477387;
                              _loc38_ = (_loc43_ ^ _loc43_ >>> 16) & 65535;
                              _loc37_ = _loc35_.addr + _loc38_ * 5 + 1;
                              _loc28_ = int(li32(_loc37_));
                              if(_loc28_ >= 0 && li32(_loc28_ + _loc25_ - 3) == li32(_loc23_ + _loc25_ - 3) && li32(_loc23_) == li32(_loc28_) && _loc23_ - _loc28_ <= _loc35_.windowSize)
                              {
                                 _loc29_ = _loc23_ + 4;
                                 _loc27_ = 4;
                                 _loc28_ += 4;
                                 while(li32(_loc28_) == li32(_loc29_) && _loc27_ + 4 <= _loc35_.maxMatchLength)
                                 {
                                    _loc27_ += 4;
                                    _loc28_ += 4;
                                    _loc29_ += 4;
                                 }
                                 while(li8(_loc28_) == li8(_loc29_) && _loc27_ < _loc35_.maxMatchLength)
                                 {
                                    _loc27_++;
                                    _loc28_++;
                                    _loc29_++;
                                 }
                                 if(_loc27_ > _loc25_)
                                 {
                                    _loc25_ = int(_loc27_);
                                    _loc26_ = int(_loc28_);
                                 }
                              }
                           }
                           si32(_loc23_ - (_loc26_ - _loc25_) << 16 | _loc25_,_loc35_.resultAddr);
                           _loc25_ = int(_loc24_);
                           _loc26_ = 4;
                           _loc27_ = int(_loc23_);
                           if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                           {
                              _loc29_ = int(li32(_loc25_ + 1));
                              si8(_loc26_,_loc25_);
                              si32(_loc27_,_loc25_ + 1);
                              _loc26_ = _loc28_ + 1;
                              _loc27_ = int(_loc29_);
                              _loc31_ = int(li32(_loc27_));
                              si32(_loc31_,_loc35_.hashScratchAddr);
                              _loc31_ = int(li32(_loc27_ + 4));
                              si32(_loc31_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc26_);
                              _loc31_ = 775236557;
                              _loc36_ = -862048943;
                              _loc37_ = 461845907;
                              _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc31_ ^= _loc38_ * _loc37_;
                              _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                              _loc31_ = _loc31_ * 5 + -430675100;
                              _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc31_ ^= _loc38_ * _loc37_;
                              _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                              _loc31_ = _loc31_ * 5 + -430675100;
                              _loc39_ = _loc31_ ^ _loc26_;
                              _loc39_ ^= _loc39_ >>> 16;
                              _loc39_ *= -2048144789;
                              _loc39_ ^= _loc39_ >>> 13;
                              _loc39_ *= -1028477387;
                              _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                              _loc25_ = _loc35_.addr + _loc30_ * 5;
                              if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                              {
                                 _loc29_ = int(li32(_loc25_ + 1));
                                 si8(_loc26_,_loc25_);
                                 si32(_loc27_,_loc25_ + 1);
                                 _loc26_ = _loc28_ + 1;
                                 _loc27_ = int(_loc29_);
                                 _loc31_ = int(li32(_loc27_));
                                 si32(_loc31_,_loc35_.hashScratchAddr);
                                 _loc31_ = int(li32(_loc27_ + 4));
                                 si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc26_);
                                 _loc31_ = 775236557;
                                 _loc36_ = -862048943;
                                 _loc37_ = 461845907;
                                 _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc31_ ^= _loc38_ * _loc37_;
                                 _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                 _loc31_ = _loc31_ * 5 + -430675100;
                                 _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc31_ ^= _loc38_ * _loc37_;
                                 _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                 _loc31_ = _loc31_ * 5 + -430675100;
                                 _loc39_ = _loc31_ ^ _loc26_;
                                 _loc39_ ^= _loc39_ >>> 16;
                                 _loc39_ *= -2048144789;
                                 _loc39_ ^= _loc39_ >>> 13;
                                 _loc39_ *= -1028477387;
                                 _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                 _loc25_ = _loc35_.addr + _loc30_ * 5;
                                 if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                                 {
                                    _loc29_ = int(li32(_loc25_ + 1));
                                    si8(_loc26_,_loc25_);
                                    si32(_loc27_,_loc25_ + 1);
                                    _loc26_ = _loc28_ + 1;
                                    _loc27_ = int(_loc29_);
                                    _loc31_ = int(li32(_loc27_));
                                    si32(_loc31_,_loc35_.hashScratchAddr);
                                    _loc31_ = int(li32(_loc27_ + 4));
                                    si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                    si32(0,_loc35_.hashScratchAddr + _loc26_);
                                    _loc31_ = 775236557;
                                    _loc36_ = -862048943;
                                    _loc37_ = 461845907;
                                    _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc31_ ^= _loc38_ * _loc37_;
                                    _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                    _loc31_ = _loc31_ * 5 + -430675100;
                                    _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc31_ ^= _loc38_ * _loc37_;
                                    _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                    _loc31_ = _loc31_ * 5 + -430675100;
                                    _loc39_ = _loc31_ ^ _loc26_;
                                    _loc39_ ^= _loc39_ >>> 16;
                                    _loc39_ *= -2048144789;
                                    _loc39_ ^= _loc39_ >>> 13;
                                    _loc39_ *= -1028477387;
                                    _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                    _loc25_ = _loc35_.addr + _loc30_ * 5;
                                    if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                                    {
                                       _loc29_ = int(li32(_loc25_ + 1));
                                       si8(_loc26_,_loc25_);
                                       si32(_loc27_,_loc25_ + 1);
                                       _loc26_ = _loc28_ + 1;
                                       _loc27_ = int(_loc29_);
                                       _loc31_ = int(li32(_loc27_));
                                       si32(_loc31_,_loc35_.hashScratchAddr);
                                       _loc31_ = int(li32(_loc27_ + 4));
                                       si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                       si32(0,_loc35_.hashScratchAddr + _loc26_);
                                       _loc31_ = 775236557;
                                       _loc36_ = -862048943;
                                       _loc37_ = 461845907;
                                       _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                       _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                       _loc31_ ^= _loc38_ * _loc37_;
                                       _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                       _loc31_ = _loc31_ * 5 + -430675100;
                                       _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                       _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                       _loc31_ ^= _loc38_ * _loc37_;
                                       _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                       _loc31_ = _loc31_ * 5 + -430675100;
                                       _loc39_ = _loc31_ ^ _loc26_;
                                       _loc39_ ^= _loc39_ >>> 16;
                                       _loc39_ *= -2048144789;
                                       _loc39_ ^= _loc39_ >>> 13;
                                       _loc39_ *= -1028477387;
                                       _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                       _loc25_ = _loc35_.addr + _loc30_ * 5;
                                    }
                                 }
                              }
                           }
                           si8(_loc26_,_loc25_);
                           si32(_loc27_,_loc25_ + 1);
                           _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                        }
                     }
                     if(li16(_loc35_.resultAddr) >= 4)
                     {
                        _loc14_ = int(li16(_loc35_.resultAddr));
                        _loc21_ = int(li16(scratchAddr + 2492 + (_loc14_ << 2) + 2));
                        _loc22_ = 0;
                        _loc23_ = scratchAddr + _loc22_ + (_loc21_ << 2);
                        _loc24_ = li32(_loc23_) + 1;
                        si32(_loc24_,_loc23_);
                        _loc21_ = int(li16(_loc35_.resultAddr + 2));
                        _loc15_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                        _loc21_ = scratchAddr + 1144 + (_loc15_ >>> 24 << 2);
                        _loc22_ = li32(_loc21_) + 1;
                        si32(_loc22_,_loc21_);
                        _loc21_ = li32(_loc35_.resultAddr) | 512;
                        si32(_loc21_,_loc20_);
                        _loc20_ += 4;
                        _loc16_ += _loc14_;
                     }
                     else
                     {
                        _loc13_ = int(li8(_loc16_));
                        si16(_loc13_,_loc20_);
                        _loc21_ = 0;
                        _loc22_ = scratchAddr + _loc21_ + (_loc13_ << 2);
                        _loc23_ = li32(_loc22_) + 1;
                        si32(_loc23_,_loc22_);
                        _loc20_ += 2;
                        _loc16_++;
                     }
                  }
                  while(_loc16_ < _loc10_)
                  {
                     _loc24_ = 775236557;
                     _loc25_ = -862048943;
                     _loc26_ = 461845907;
                     _loc27_ = li32(_loc16_ + 1) * _loc25_;
                     _loc27_ = _loc27_ << 15 | _loc27_ >>> 17;
                     _loc24_ ^= _loc27_ * _loc26_;
                     _loc24_ = _loc24_ << 13 | _loc24_ >>> 19;
                     _loc24_ = _loc24_ * 5 + -430675100;
                     _loc28_ = _loc24_ ^ 4;
                     _loc28_ ^= _loc28_ >>> 16;
                     _loc28_ *= -2048144789;
                     _loc28_ ^= _loc28_ >>> 13;
                     _loc28_ *= -1028477387;
                     _loc23_ = (_loc28_ ^ _loc28_ >>> 16) & 65535;
                     _loc22_ = _loc35_.addr + _loc23_ * 5;
                     if(li16(_loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7)) < _loc35_.avgMatchLength + 4)
                     {
                        _loc23_ = _loc16_ + 1;
                        _loc24_ = 3;
                        _loc25_ = -1;
                        _loc27_ = int(li32(_loc22_ + 1));
                        if(_loc27_ >= 0 && li32(_loc23_) == li32(_loc27_) && _loc23_ - _loc27_ <= _loc35_.windowSize)
                        {
                           _loc28_ = _loc23_ + 4;
                           _loc26_ = 4;
                           _loc27_ += 4;
                           while(_loc28_ + 4 <= _loc5_ && li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc35_.maxMatchLength)
                           {
                              _loc26_ += 4;
                              _loc27_ += 4;
                              _loc28_ += 4;
                           }
                           while(_loc28_ < _loc5_ && li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc35_.maxMatchLength)
                           {
                              _loc26_++;
                              _loc27_++;
                              _loc28_++;
                           }
                           _loc24_ = int(_loc26_);
                           _loc25_ = int(_loc27_);
                        }
                        _loc29_ = 5;
                        _loc30_ = 9;
                        while(_loc29_ < _loc30_)
                        {
                           _loc31_ = int(_loc29_++);
                           _loc38_ = int(li32(_loc23_));
                           si32(_loc38_,_loc35_.hashScratchAddr);
                           _loc38_ = int(li32(_loc23_ + 4));
                           si32(_loc38_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc31_);
                           _loc38_ = 775236557;
                           _loc39_ = -862048943;
                           _loc40_ = 461845907;
                           _loc41_ = li32(_loc35_.hashScratchAddr) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc41_ = li32(_loc35_.hashScratchAddr + 4) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc42_ = _loc38_ ^ _loc31_;
                           _loc42_ ^= _loc42_ >>> 16;
                           _loc42_ *= -2048144789;
                           _loc42_ ^= _loc42_ >>> 13;
                           _loc42_ *= -1028477387;
                           _loc37_ = (_loc42_ ^ _loc42_ >>> 16) & 65535;
                           _loc36_ = _loc35_.addr + _loc37_ * 5 + 1;
                           _loc27_ = int(li32(_loc36_));
                           if(_loc27_ >= 0 && li32(_loc23_) == li32(_loc27_) && _loc23_ - _loc27_ <= _loc35_.windowSize)
                           {
                              _loc28_ = _loc23_ + 4;
                              _loc26_ = 4;
                              _loc27_ += 4;
                              while(_loc28_ + 4 <= _loc5_ && li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc35_.maxMatchLength)
                              {
                                 _loc26_ += 4;
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                              }
                              while(_loc28_ < _loc5_ && li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc35_.maxMatchLength)
                              {
                                 _loc26_++;
                                 _loc27_++;
                                 _loc28_++;
                              }
                              if(_loc26_ > _loc24_)
                              {
                                 _loc24_ = int(_loc26_);
                                 _loc25_ = int(_loc27_);
                              }
                           }
                        }
                        si32(_loc23_ - (_loc25_ - _loc24_) << 16 | _loc24_,_loc35_.resultAddr);
                     }
                     else
                     {
                        si32(0,_loc35_.resultAddr);
                     }
                     _loc23_ = int(_loc22_);
                     _loc24_ = 4;
                     _loc25_ = _loc16_ + 1;
                     if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                     {
                        _loc27_ = int(li32(_loc23_ + 1));
                        si8(_loc24_,_loc23_);
                        si32(_loc25_,_loc23_ + 1);
                        _loc24_ = _loc26_ + 1;
                        _loc25_ = int(_loc27_);
                        _loc29_ = int(li32(_loc25_));
                        si32(_loc29_,_loc35_.hashScratchAddr);
                        _loc29_ = int(li32(_loc25_ + 4));
                        si32(_loc29_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc24_);
                        _loc29_ = 775236557;
                        _loc30_ = -862048943;
                        _loc31_ = 461845907;
                        _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc29_ ^= _loc36_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc29_ ^= _loc36_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc37_ = _loc29_ ^ _loc24_;
                        _loc37_ ^= _loc37_ >>> 16;
                        _loc37_ *= -2048144789;
                        _loc37_ ^= _loc37_ >>> 13;
                        _loc37_ *= -1028477387;
                        _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                        _loc23_ = _loc35_.addr + _loc28_ * 5;
                        if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                        {
                           _loc27_ = int(li32(_loc23_ + 1));
                           si8(_loc24_,_loc23_);
                           si32(_loc25_,_loc23_ + 1);
                           _loc24_ = _loc26_ + 1;
                           _loc25_ = int(_loc27_);
                           _loc29_ = int(li32(_loc25_));
                           si32(_loc29_,_loc35_.hashScratchAddr);
                           _loc29_ = int(li32(_loc25_ + 4));
                           si32(_loc29_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc24_);
                           _loc29_ = 775236557;
                           _loc30_ = -862048943;
                           _loc31_ = 461845907;
                           _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                           _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                           _loc29_ ^= _loc36_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                           _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                           _loc29_ ^= _loc36_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc37_ = _loc29_ ^ _loc24_;
                           _loc37_ ^= _loc37_ >>> 16;
                           _loc37_ *= -2048144789;
                           _loc37_ ^= _loc37_ >>> 13;
                           _loc37_ *= -1028477387;
                           _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                           _loc23_ = _loc35_.addr + _loc28_ * 5;
                           if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                           {
                              _loc27_ = int(li32(_loc23_ + 1));
                              si8(_loc24_,_loc23_);
                              si32(_loc25_,_loc23_ + 1);
                              _loc24_ = _loc26_ + 1;
                              _loc25_ = int(_loc27_);
                              _loc29_ = int(li32(_loc25_));
                              si32(_loc29_,_loc35_.hashScratchAddr);
                              _loc29_ = int(li32(_loc25_ + 4));
                              si32(_loc29_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc24_);
                              _loc29_ = 775236557;
                              _loc30_ = -862048943;
                              _loc31_ = 461845907;
                              _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                              _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                              _loc29_ ^= _loc36_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                              _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                              _loc29_ ^= _loc36_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc37_ = _loc29_ ^ _loc24_;
                              _loc37_ ^= _loc37_ >>> 16;
                              _loc37_ *= -2048144789;
                              _loc37_ ^= _loc37_ >>> 13;
                              _loc37_ *= -1028477387;
                              _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                              _loc23_ = _loc35_.addr + _loc28_ * 5;
                              if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                              {
                                 _loc27_ = int(li32(_loc23_ + 1));
                                 si8(_loc24_,_loc23_);
                                 si32(_loc25_,_loc23_ + 1);
                                 _loc24_ = _loc26_ + 1;
                                 _loc25_ = int(_loc27_);
                                 _loc29_ = int(li32(_loc25_));
                                 si32(_loc29_,_loc35_.hashScratchAddr);
                                 _loc29_ = int(li32(_loc25_ + 4));
                                 si32(_loc29_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc24_);
                                 _loc29_ = 775236557;
                                 _loc30_ = -862048943;
                                 _loc31_ = 461845907;
                                 _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                                 _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                                 _loc29_ ^= _loc36_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                                 _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                                 _loc29_ ^= _loc36_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc37_ = _loc29_ ^ _loc24_;
                                 _loc37_ ^= _loc37_ >>> 16;
                                 _loc37_ *= -2048144789;
                                 _loc37_ ^= _loc37_ >>> 13;
                                 _loc37_ *= -1028477387;
                                 _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                                 _loc23_ = _loc35_.addr + _loc28_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc24_,_loc23_);
                     si32(_loc25_,_loc23_ + 1);
                     _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                     if(li16(_loc35_.resultAddr) >= 4)
                     {
                        _loc21_ = int(li16(_loc35_.resultAddr));
                        if(li16(_loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7)) > _loc21_)
                        {
                           si32(0,_loc35_.resultAddr);
                        }
                        else if(_loc16_ + _loc21_ + 9 < _loc5_)
                        {
                           if(_loc21_ < _loc35_.avgMatchLength + 4)
                           {
                              _loc23_ = _loc16_ + 1 + 1;
                              _loc24_ = _loc16_ + _loc21_;
                              while(_loc23_ < _loc24_)
                              {
                                 _loc25_ = int(_loc23_++);
                                 _loc26_ = 4;
                                 _loc27_ = int(_loc25_);
                                 _loc36_ = 775236557;
                                 _loc37_ = -862048943;
                                 _loc38_ = 461845907;
                                 _loc39_ = li32(_loc25_) * _loc37_;
                                 _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                 _loc36_ ^= _loc39_ * _loc38_;
                                 _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                 _loc36_ = _loc36_ * 5 + -430675100;
                                 _loc40_ = _loc36_ ^ 4;
                                 _loc40_ ^= _loc40_ >>> 16;
                                 _loc40_ *= -2048144789;
                                 _loc40_ ^= _loc40_ >>> 13;
                                 _loc40_ *= -1028477387;
                                 _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                 _loc30_ = _loc35_.addr + _loc31_ * 5;
                                 if((_loc28_ = int(li8(_loc30_))) < 8 && _loc28_ >= 0)
                                 {
                                    _loc29_ = int(li32(_loc30_ + 1));
                                    si8(_loc26_,_loc30_);
                                    si32(_loc27_,_loc30_ + 1);
                                    _loc26_ = _loc28_ + 1;
                                    _loc27_ = int(_loc29_);
                                    _loc36_ = int(li32(_loc27_));
                                    si32(_loc36_,_loc35_.hashScratchAddr);
                                    _loc36_ = int(li32(_loc27_ + 4));
                                    si32(_loc36_,_loc35_.hashScratchAddr + 4);
                                    si32(0,_loc35_.hashScratchAddr + _loc26_);
                                    _loc36_ = 775236557;
                                    _loc37_ = -862048943;
                                    _loc38_ = 461845907;
                                    _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                                    _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                    _loc36_ ^= _loc39_ * _loc38_;
                                    _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                    _loc36_ = _loc36_ * 5 + -430675100;
                                    _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                                    _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                    _loc36_ ^= _loc39_ * _loc38_;
                                    _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                    _loc36_ = _loc36_ * 5 + -430675100;
                                    _loc40_ = _loc36_ ^ _loc26_;
                                    _loc40_ ^= _loc40_ >>> 16;
                                    _loc40_ *= -2048144789;
                                    _loc40_ ^= _loc40_ >>> 13;
                                    _loc40_ *= -1028477387;
                                    _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                    _loc30_ = _loc35_.addr + _loc31_ * 5;
                                    if((_loc28_ = int(li8(_loc30_))) < 8 && _loc28_ >= 0)
                                    {
                                       _loc29_ = int(li32(_loc30_ + 1));
                                       si8(_loc26_,_loc30_);
                                       si32(_loc27_,_loc30_ + 1);
                                       _loc26_ = _loc28_ + 1;
                                       _loc27_ = int(_loc29_);
                                       _loc36_ = int(li32(_loc27_));
                                       si32(_loc36_,_loc35_.hashScratchAddr);
                                       _loc36_ = int(li32(_loc27_ + 4));
                                       si32(_loc36_,_loc35_.hashScratchAddr + 4);
                                       si32(0,_loc35_.hashScratchAddr + _loc26_);
                                       _loc36_ = 775236557;
                                       _loc37_ = -862048943;
                                       _loc38_ = 461845907;
                                       _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                                       _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                       _loc36_ ^= _loc39_ * _loc38_;
                                       _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                       _loc36_ = _loc36_ * 5 + -430675100;
                                       _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                                       _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                       _loc36_ ^= _loc39_ * _loc38_;
                                       _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                       _loc36_ = _loc36_ * 5 + -430675100;
                                       _loc40_ = _loc36_ ^ _loc26_;
                                       _loc40_ ^= _loc40_ >>> 16;
                                       _loc40_ *= -2048144789;
                                       _loc40_ ^= _loc40_ >>> 13;
                                       _loc40_ *= -1028477387;
                                       _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                       _loc30_ = _loc35_.addr + _loc31_ * 5;
                                    }
                                 }
                                 si8(_loc26_,_loc30_);
                                 si32(_loc27_,_loc30_ + 1);
                              }
                           }
                           _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                           _loc23_ = _loc16_ + _loc21_;
                           _loc26_ = 775236557;
                           _loc27_ = -862048943;
                           _loc28_ = 461845907;
                           _loc29_ = li32(_loc23_) * _loc27_;
                           _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                           _loc26_ ^= _loc29_ * _loc28_;
                           _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                           _loc26_ = _loc26_ * 5 + -430675100;
                           _loc30_ = _loc26_ ^ 4;
                           _loc30_ ^= _loc30_ >>> 16;
                           _loc30_ *= -2048144789;
                           _loc30_ ^= _loc30_ >>> 13;
                           _loc30_ *= -1028477387;
                           _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                           _loc24_ = _loc35_.addr + _loc25_ * 5;
                           _loc25_ = 3;
                           _loc26_ = -1;
                           _loc28_ = int(li32(_loc24_ + 1));
                           if(_loc28_ >= 0 && li32(_loc23_) == li32(_loc28_) && _loc23_ - _loc28_ <= _loc35_.windowSize)
                           {
                              _loc29_ = _loc23_ + 4;
                              _loc27_ = 4;
                              _loc28_ += 4;
                              while(_loc29_ + 4 <= _loc5_ && li32(_loc28_) == li32(_loc29_) && _loc27_ + 4 <= _loc35_.maxMatchLength)
                              {
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                                 _loc29_ += 4;
                              }
                              while(_loc29_ < _loc5_ && li8(_loc28_) == li8(_loc29_) && _loc27_ < _loc35_.maxMatchLength)
                              {
                                 _loc27_++;
                                 _loc28_++;
                                 _loc29_++;
                              }
                              _loc25_ = int(_loc27_);
                              _loc26_ = int(_loc28_);
                           }
                           _loc30_ = 5;
                           _loc31_ = 9;
                           while(_loc30_ < _loc31_)
                           {
                              _loc36_ = int(_loc30_++);
                              _loc39_ = int(li32(_loc23_));
                              si32(_loc39_,_loc35_.hashScratchAddr);
                              _loc39_ = int(li32(_loc23_ + 4));
                              si32(_loc39_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc36_);
                              _loc39_ = 775236557;
                              _loc40_ = -862048943;
                              _loc41_ = 461845907;
                              _loc42_ = li32(_loc35_.hashScratchAddr) * _loc40_;
                              _loc42_ = _loc42_ << 15 | _loc42_ >>> 17;
                              _loc39_ ^= _loc42_ * _loc41_;
                              _loc39_ = _loc39_ << 13 | _loc39_ >>> 19;
                              _loc39_ = _loc39_ * 5 + -430675100;
                              _loc42_ = li32(_loc35_.hashScratchAddr + 4) * _loc40_;
                              _loc42_ = _loc42_ << 15 | _loc42_ >>> 17;
                              _loc39_ ^= _loc42_ * _loc41_;
                              _loc39_ = _loc39_ << 13 | _loc39_ >>> 19;
                              _loc39_ = _loc39_ * 5 + -430675100;
                              _loc43_ = _loc39_ ^ _loc36_;
                              _loc43_ ^= _loc43_ >>> 16;
                              _loc43_ *= -2048144789;
                              _loc43_ ^= _loc43_ >>> 13;
                              _loc43_ *= -1028477387;
                              _loc38_ = (_loc43_ ^ _loc43_ >>> 16) & 65535;
                              _loc37_ = _loc35_.addr + _loc38_ * 5 + 1;
                              _loc28_ = int(li32(_loc37_));
                              if(_loc28_ >= 0 && li32(_loc23_) == li32(_loc28_) && _loc23_ - _loc28_ <= _loc35_.windowSize)
                              {
                                 _loc29_ = _loc23_ + 4;
                                 _loc27_ = 4;
                                 _loc28_ += 4;
                                 while(_loc29_ + 4 <= _loc5_ && li32(_loc28_) == li32(_loc29_) && _loc27_ + 4 <= _loc35_.maxMatchLength)
                                 {
                                    _loc27_ += 4;
                                    _loc28_ += 4;
                                    _loc29_ += 4;
                                 }
                                 while(_loc29_ < _loc5_ && li8(_loc28_) == li8(_loc29_) && _loc27_ < _loc35_.maxMatchLength)
                                 {
                                    _loc27_++;
                                    _loc28_++;
                                    _loc29_++;
                                 }
                                 if(_loc27_ > _loc25_)
                                 {
                                    _loc25_ = int(_loc27_);
                                    _loc26_ = int(_loc28_);
                                 }
                              }
                           }
                           si32(_loc23_ - (_loc26_ - _loc25_) << 16 | _loc25_,_loc35_.resultAddr);
                           _loc25_ = int(_loc24_);
                           _loc26_ = 4;
                           _loc27_ = int(_loc23_);
                           if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                           {
                              _loc29_ = int(li32(_loc25_ + 1));
                              si8(_loc26_,_loc25_);
                              si32(_loc27_,_loc25_ + 1);
                              _loc26_ = _loc28_ + 1;
                              _loc27_ = int(_loc29_);
                              _loc31_ = int(li32(_loc27_));
                              si32(_loc31_,_loc35_.hashScratchAddr);
                              _loc31_ = int(li32(_loc27_ + 4));
                              si32(_loc31_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc26_);
                              _loc31_ = 775236557;
                              _loc36_ = -862048943;
                              _loc37_ = 461845907;
                              _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc31_ ^= _loc38_ * _loc37_;
                              _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                              _loc31_ = _loc31_ * 5 + -430675100;
                              _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc31_ ^= _loc38_ * _loc37_;
                              _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                              _loc31_ = _loc31_ * 5 + -430675100;
                              _loc39_ = _loc31_ ^ _loc26_;
                              _loc39_ ^= _loc39_ >>> 16;
                              _loc39_ *= -2048144789;
                              _loc39_ ^= _loc39_ >>> 13;
                              _loc39_ *= -1028477387;
                              _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                              _loc25_ = _loc35_.addr + _loc30_ * 5;
                              if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                              {
                                 _loc29_ = int(li32(_loc25_ + 1));
                                 si8(_loc26_,_loc25_);
                                 si32(_loc27_,_loc25_ + 1);
                                 _loc26_ = _loc28_ + 1;
                                 _loc27_ = int(_loc29_);
                                 _loc31_ = int(li32(_loc27_));
                                 si32(_loc31_,_loc35_.hashScratchAddr);
                                 _loc31_ = int(li32(_loc27_ + 4));
                                 si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc26_);
                                 _loc31_ = 775236557;
                                 _loc36_ = -862048943;
                                 _loc37_ = 461845907;
                                 _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc31_ ^= _loc38_ * _loc37_;
                                 _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                 _loc31_ = _loc31_ * 5 + -430675100;
                                 _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc31_ ^= _loc38_ * _loc37_;
                                 _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                 _loc31_ = _loc31_ * 5 + -430675100;
                                 _loc39_ = _loc31_ ^ _loc26_;
                                 _loc39_ ^= _loc39_ >>> 16;
                                 _loc39_ *= -2048144789;
                                 _loc39_ ^= _loc39_ >>> 13;
                                 _loc39_ *= -1028477387;
                                 _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                 _loc25_ = _loc35_.addr + _loc30_ * 5;
                                 if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                                 {
                                    _loc29_ = int(li32(_loc25_ + 1));
                                    si8(_loc26_,_loc25_);
                                    si32(_loc27_,_loc25_ + 1);
                                    _loc26_ = _loc28_ + 1;
                                    _loc27_ = int(_loc29_);
                                    _loc31_ = int(li32(_loc27_));
                                    si32(_loc31_,_loc35_.hashScratchAddr);
                                    _loc31_ = int(li32(_loc27_ + 4));
                                    si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                    si32(0,_loc35_.hashScratchAddr + _loc26_);
                                    _loc31_ = 775236557;
                                    _loc36_ = -862048943;
                                    _loc37_ = 461845907;
                                    _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc31_ ^= _loc38_ * _loc37_;
                                    _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                    _loc31_ = _loc31_ * 5 + -430675100;
                                    _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc31_ ^= _loc38_ * _loc37_;
                                    _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                    _loc31_ = _loc31_ * 5 + -430675100;
                                    _loc39_ = _loc31_ ^ _loc26_;
                                    _loc39_ ^= _loc39_ >>> 16;
                                    _loc39_ *= -2048144789;
                                    _loc39_ ^= _loc39_ >>> 13;
                                    _loc39_ *= -1028477387;
                                    _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                    _loc25_ = _loc35_.addr + _loc30_ * 5;
                                    if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                                    {
                                       _loc29_ = int(li32(_loc25_ + 1));
                                       si8(_loc26_,_loc25_);
                                       si32(_loc27_,_loc25_ + 1);
                                       _loc26_ = _loc28_ + 1;
                                       _loc27_ = int(_loc29_);
                                       _loc31_ = int(li32(_loc27_));
                                       si32(_loc31_,_loc35_.hashScratchAddr);
                                       _loc31_ = int(li32(_loc27_ + 4));
                                       si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                       si32(0,_loc35_.hashScratchAddr + _loc26_);
                                       _loc31_ = 775236557;
                                       _loc36_ = -862048943;
                                       _loc37_ = 461845907;
                                       _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                       _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                       _loc31_ ^= _loc38_ * _loc37_;
                                       _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                       _loc31_ = _loc31_ * 5 + -430675100;
                                       _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                       _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                       _loc31_ ^= _loc38_ * _loc37_;
                                       _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                       _loc31_ = _loc31_ * 5 + -430675100;
                                       _loc39_ = _loc31_ ^ _loc26_;
                                       _loc39_ ^= _loc39_ >>> 16;
                                       _loc39_ *= -2048144789;
                                       _loc39_ ^= _loc39_ >>> 13;
                                       _loc39_ *= -1028477387;
                                       _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                       _loc25_ = _loc35_.addr + _loc30_ * 5;
                                    }
                                 }
                              }
                           }
                           si8(_loc26_,_loc25_);
                           si32(_loc27_,_loc25_ + 1);
                           _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                        }
                     }
                     if(li16(_loc35_.resultAddr) >= 4)
                     {
                        _loc14_ = int(li16(_loc35_.resultAddr));
                        _loc21_ = int(li16(scratchAddr + 2492 + (_loc14_ << 2) + 2));
                        _loc22_ = 0;
                        _loc23_ = scratchAddr + _loc22_ + (_loc21_ << 2);
                        _loc24_ = li32(_loc23_) + 1;
                        si32(_loc24_,_loc23_);
                        _loc21_ = int(li16(_loc35_.resultAddr + 2));
                        _loc15_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                        _loc21_ = scratchAddr + 1144 + (_loc15_ >>> 24 << 2);
                        _loc22_ = li32(_loc21_) + 1;
                        si32(_loc22_,_loc21_);
                        _loc21_ = li32(_loc35_.resultAddr) | 512;
                        si32(_loc21_,_loc20_);
                        _loc20_ += 4;
                        _loc16_ += _loc14_;
                     }
                     else
                     {
                        _loc13_ = int(li8(_loc16_));
                        si16(_loc13_,_loc20_);
                        _loc21_ = 0;
                        _loc22_ = scratchAddr + _loc21_ + (_loc13_ << 2);
                        _loc23_ = li32(_loc22_) + 1;
                        si32(_loc23_,_loc22_);
                        _loc20_ += 2;
                        _loc16_++;
                     }
                  }
                  while(_loc16_ < _loc5_)
                  {
                     _loc13_ = int(li8(_loc16_));
                     si16(_loc13_,_loc20_);
                     _loc21_ = 0;
                     _loc22_ = scratchAddr + _loc21_ + (_loc13_ << 2);
                     _loc23_ = li32(_loc22_) + 1;
                     si32(_loc23_,_loc22_);
                     _loc20_ += 2;
                     _loc16_++;
                  }
                  _loc12_ = false;
                  blockInProgress = true;
                  if(level == CompressionLevel.UNCOMPRESSED)
                  {
                     if(bitOffset == 0)
                     {
                        si8(0,currentAddr);
                     }
                     _loc21_ = int(li8(currentAddr));
                     _loc21_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                     si32(_loc21_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     if(bitOffset > 0)
                     {
                        _loc21_ = int(li8(currentAddr));
                        _loc21_ |= 0 << bitOffset;
                        si32(_loc21_,currentAddr);
                        bitOffset += 8 - bitOffset;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                  }
                  else
                  {
                     _loc21_ = int(li8(currentAddr));
                     _loc21_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                     si32(_loc21_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockStartAddr = currentAddr;
                  createAndWriteHuffmanTrees(_loc4_,_loc5_);
                  _loc16_ = int(_loc18_);
                  while(_loc16_ + 64 <= _loc20_)
                  {
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                  }
                  while(_loc16_ < _loc20_)
                  {
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                  }
                  if(level != CompressionLevel.UNCOMPRESSED)
                  {
                     _loc21_ = 0;
                     _loc22_ = int(li32(scratchAddr + _loc21_ + 1024));
                     _loc23_ = int(li8(currentAddr));
                     _loc23_ |= _loc22_ >>> 16 << bitOffset;
                     si32(_loc23_,currentAddr);
                     bitOffset += _loc22_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockInProgress = false;
                  _loc4_ = int(_loc5_);
               }
            }
         }
      }
      
      public function fastNew(param1:CompressionLevel, param2:Boolean, param3:int, param4:int) : void
      {
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = 0;
         var _loc16_:int = 0;
         level = param1;
         zlib = param2;
         scratchAddr = param3;
         startAddr = param4;
         currentAddr = param4;
         rangeResult = new MemoryRange(0,0);
         HuffmanTree.scratchAddr = param3 + 1348;
         var _loc5_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc6_:uint = param4 + 15;
         if(_loc5_.length < _loc6_)
         {
            _loc5_.length = _loc6_;
            ApplicationDomain.currentDomain.domainMemory = _loc5_;
         }
         distanceCodes = -1;
         blockInProgress = false;
         blockStartAddr = currentAddr;
         bitOffset = 0;
         s1 = 1;
         s2 = 0;
         if(zlib)
         {
            si8(120,currentAddr);
            currentAddr = currentAddr + 1;
            si8(156,currentAddr);
            currentAddr = currentAddr + 1;
         }
         if(level == CompressionLevel.NORMAL || level == CompressionLevel.GOOD)
         {
            _loc7_ = scratchAddr + 2492;
            si32(16842755,_loc7_ + 12);
            si32(16908292,_loc7_ + 16);
            si32(16973829,_loc7_ + 20);
            si32(17039366,_loc7_ + 24);
            si32(17104903,_loc7_ + 28);
            si32(17170440,_loc7_ + 32);
            si32(17235977,_loc7_ + 36);
            si32(17301514,_loc7_ + 40);
            _loc8_ = 11;
            _loc9_ = 265;
            _loc10_ = 1;
            while(_loc10_ < 6)
            {
               _loc11_ = _loc10_++;
               _loc12_ = 0;
               while(_loc12_ < 4)
               {
                  _loc13_ = _loc12_++;
                  _loc14_ = _loc8_;
                  _loc15_ = _loc8_ + (1 << _loc11_);
                  while(_loc14_ < _loc15_)
                  {
                     _loc16_ = _loc14_++;
                     si32(_loc9_ << 16 | _loc11_ << 13 | _loc8_,_loc7_ + _loc16_ * 4);
                  }
                  _loc8_ += 1 << _loc11_;
                  _loc9_++;
               }
            }
            si32(18678018,_loc7_ + 1032);
            _loc7_ = scratchAddr + 3528;
            si32(1,_loc7_ + 4);
            si32(16777218,_loc7_ + 8);
            si32(33554435,_loc7_ + 12);
            si32(50331652,_loc7_ + 16);
            _loc8_ = 5;
            _loc9_ = 4;
            _loc10_ = 1;
            while(_loc10_ < 7)
            {
               _loc11_ = _loc10_++;
               _loc12_ = 0;
               while(_loc12_ < 2)
               {
                  _loc13_ = _loc12_++;
                  _loc14_ = _loc8_;
                  _loc15_ = _loc8_ + (1 << _loc11_);
                  while(_loc14_ < _loc15_)
                  {
                     _loc16_ = _loc14_++;
                     si32(_loc9_ << 24 | _loc11_ << 16 | _loc8_,_loc7_ + _loc16_ * 4);
                  }
                  _loc8_ += 1 << _loc11_;
                  _loc9_++;
               }
            }
            _loc7_ += 1024;
            _loc10_ = 7;
            while(_loc10_ < 14)
            {
               _loc11_ = _loc10_++;
               _loc12_ = 0;
               while(_loc12_ < 2)
               {
                  _loc13_ = _loc12_++;
                  _loc14_ = _loc8_ >>> 7;
                  _loc15_ = (_loc8_ >>> 7) + (1 << _loc11_ - 7);
                  while(_loc14_ < _loc15_)
                  {
                     _loc16_ = _loc14_++;
                     si32(_loc9_ << 24 | _loc11_ << 16 | _loc8_,_loc7_ + _loc16_ * 4);
                  }
                  _loc8_ += 1 << _loc11_;
                  _loc9_++;
               }
            }
         }
         si8(0,currentAddr);
      }
      
      public function fastFinalize() : MemoryRange
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         if(blockInProgress)
         {
            if(level != CompressionLevel.UNCOMPRESSED)
            {
               _loc1_ = 0;
               _loc2_ = li32(scratchAddr + _loc1_ + 1024);
               _loc3_ = int(li8(currentAddr));
               _loc3_ |= _loc2_ >>> 16 << bitOffset;
               si32(_loc3_,currentAddr);
               bitOffset += _loc2_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
            blockInProgress = false;
         }
         if(blockInProgress)
         {
            if(level != CompressionLevel.UNCOMPRESSED)
            {
               _loc1_ = 0;
               _loc2_ = li32(scratchAddr + _loc1_ + 1024);
               _loc3_ = int(li8(currentAddr));
               _loc3_ |= _loc2_ >>> 16 << bitOffset;
               si32(_loc3_,currentAddr);
               bitOffset += _loc2_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
            blockInProgress = false;
         }
         var _loc4_:CompressionLevel = level;
         level = CompressionLevel.UNCOMPRESSED;
         blockInProgress = true;
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            if(bitOffset == 0)
            {
               si8(0,currentAddr);
            }
            _loc1_ = int(li8(currentAddr));
            _loc1_ |= 1 << bitOffset;
            si32(_loc1_,currentAddr);
            bitOffset += 3;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
            if(bitOffset > 0)
            {
               _loc1_ = int(li8(currentAddr));
               _loc1_ |= 0 << bitOffset;
               si32(_loc1_,currentAddr);
               bitOffset += 8 - bitOffset;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
         }
         else
         {
            _loc1_ = int(li8(currentAddr));
            _loc1_ |= 5 << bitOffset;
            si32(_loc1_,currentAddr);
            bitOffset += 3;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         blockStartAddr = currentAddr;
         si16(0,currentAddr);
         currentAddr += 2;
         si16(-1,currentAddr);
         currentAddr += 2;
         if(level != CompressionLevel.UNCOMPRESSED)
         {
            _loc1_ = 0;
            _loc2_ = li32(scratchAddr + _loc1_ + 1024);
            _loc3_ = int(li8(currentAddr));
            _loc3_ |= _loc2_ >>> 16 << bitOffset;
            si32(_loc3_,currentAddr);
            bitOffset += _loc2_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         blockInProgress = false;
         level = _loc4_;
         if(bitOffset > 0)
         {
            currentAddr = currentAddr + 1;
         }
         if(zlib)
         {
            si8(s2 >>> 8,currentAddr);
            currentAddr = currentAddr + 1;
            si8(s2,currentAddr);
            currentAddr = currentAddr + 1;
            si8(s1 >>> 8,currentAddr);
            currentAddr = currentAddr + 1;
            si8(s1,currentAddr);
            currentAddr = currentAddr + 1;
         }
         rangeResult.offset = startAddr;
         rangeResult.end = currentAddr;
         return rangeResult;
      }
      
      public function endBlock() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         if(level != CompressionLevel.UNCOMPRESSED)
         {
            _loc1_ = 0;
            _loc2_ = li32(scratchAddr + _loc1_ + 1024);
            _loc3_ = int(li8(currentAddr));
            _loc3_ |= _loc2_ >>> 16 << bitOffset;
            si32(_loc3_,currentAddr);
            bitOffset += _loc2_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         blockInProgress = false;
      }
      
      public function do16Adler(param1:int, param2:int) : void
      {
         while(param1 < param2)
         {
            s2 += (s1 << 4) + li8(param1) * 16 + li8(param1 + 1) * 15 + li8(param1 + 2) * 14 + li8(param1 + 3) * 13 + li8(param1 + 4) * 12 + li8(param1 + 5) * 11 + li8(param1 + 6) * 10 + li8(param1 + 7) * 9 + li8(param1 + 8) * 8 + li8(param1 + 9) * 7 + li8(param1 + 10) * 6 + li8(param1 + 11) * 5 + li8(param1 + 12) * 4 + li8(param1 + 13) * 3 + li8(param1 + 14) * 2 + li8(param1 + 15);
            s1 += li8(param1) + li8(param1 + 1) + li8(param1 + 2) + li8(param1 + 3) + li8(param1 + 4) + li8(param1 + 5) + li8(param1 + 6) + li8(param1 + 7) + li8(param1 + 8) + li8(param1 + 9) + li8(param1 + 10) + li8(param1 + 11) + li8(param1 + 12) + li8(param1 + 13) + li8(param1 + 14) + li8(param1 + 15);
            param1 += 16;
         }
      }
      
      public function currentBlockLength() : int
      {
         if(blockInProgress)
         {
            return currentAddr - blockStartAddr;
         }
         return 0;
      }
      
      public function createLiteralLengthTree(param1:int, param2:int) : int
      {
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc3_:* = 0;
         if(level == CompressionLevel.FAST)
         {
            _loc3_ = 257;
            _loc4_ = 0;
            while(_loc4_ < 256)
            {
               _loc5_ = _loc4_++;
               si32(10,scratchAddr + _loc5_ * 4);
            }
            si32(1,scratchAddr + 1024);
            _loc4_ = param2 - param1;
            if(_loc4_ <= 16384)
            {
               _loc5_ = 1;
            }
            else if(_loc4_ <= 102400)
            {
               _loc5_ = 5;
            }
            else
            {
               _loc5_ = 11;
            }
            _loc7_ = _loc4_ / _loc5_;
            _loc8_ = _loc7_ & -16;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc6_ = int(li8(param1 + _loc9_ * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 1) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 2) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 3) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 4) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 5) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 6) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 7) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 8) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 9) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 10) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 11) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 12) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 13) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 14) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 15) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc9_ += 16;
            }
            while(_loc9_ < _loc7_)
            {
               _loc6_ = int(li8(param1 + _loc9_ * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc9_++;
            }
         }
         else if(level == CompressionLevel.NORMAL || level == CompressionLevel.GOOD)
         {
            _loc3_ = 257;
            _loc4_ = 257;
            while(_loc4_ < 286)
            {
               _loc5_ = _loc4_++;
               if(li32(scratchAddr + _loc5_ * 4) > 0)
               {
                  _loc3_ = _loc5_ + 1;
               }
            }
            si32(1,scratchAddr + 1024);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = _loc4_++;
               if(_loc5_ != 256 && li32(scratchAddr + _loc5_ * 4) > 0)
               {
                  _loc6_ = li32(scratchAddr + _loc5_ * 4) + 2;
                  si32(_loc6_,scratchAddr + _loc5_ * 4);
               }
            }
         }
         HuffmanTree.weightedAlphabetToCodes(scratchAddr,scratchAddr + _loc3_ * 4,15);
         return _loc3_;
      }
      
      public function createDistanceTree(param1:int, param2:int) : int
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = scratchAddr + 1144;
         var _loc4_:* = 0;
         if(level == CompressionLevel.NORMAL || level == CompressionLevel.GOOD)
         {
            _loc5_ = 0;
            while(_loc5_ < 30)
            {
               _loc6_ = _loc5_++;
               if(li32(_loc3_ + _loc6_ * 4) > 0)
               {
                  _loc4_ = _loc6_ + 1;
               }
            }
         }
         HuffmanTree.weightedAlphabetToCodes(_loc3_,_loc3_ + _loc4_ * 4,15);
         return _loc4_;
      }
      
      public function createCodeLengthTree(param1:int, param2:int) : int
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < 19)
         {
            _loc4_ = int(_loc3_++);
            si32(1,scratchAddr + 1272 + _loc4_ * 4);
         }
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc5_ = _loc4_++;
            _loc3_ = scratchAddr + 1272 + li16(scratchAddr + _loc5_ * 4) * 4;
            _loc6_ = li32(_loc3_) + 1;
            si32(_loc6_,_loc3_);
         }
         _loc4_ = 0;
         while(_loc4_ < param2)
         {
            _loc5_ = _loc4_++;
            _loc3_ = scratchAddr + 1272 + li16(scratchAddr + 1144 + _loc5_ * 4) * 4;
            _loc6_ = li32(_loc3_) + 1;
            si32(_loc6_,_loc3_);
         }
         _loc4_ = scratchAddr + 1272;
         HuffmanTree.weightedAlphabetToCodes(_loc4_,_loc4_ + 76,7);
         return 19;
      }
      
      public function createAndWriteHuffmanTrees(param1:int, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc3_:* = 0;
         if(level == CompressionLevel.FAST)
         {
            _loc3_ = 257;
            _loc4_ = 0;
            while(_loc4_ < 256)
            {
               _loc5_ = int(_loc4_++);
               si32(10,scratchAddr + _loc5_ * 4);
            }
            si32(1,scratchAddr + 1024);
            _loc4_ = param2 - param1;
            if(_loc4_ <= 16384)
            {
               _loc5_ = 1;
            }
            else if(_loc4_ <= 102400)
            {
               _loc5_ = 5;
            }
            else
            {
               _loc5_ = 11;
            }
            _loc7_ = int(_loc4_ / _loc5_);
            _loc8_ = _loc7_ & -16;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc6_ = int(li8(param1 + _loc9_ * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 1) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 2) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 3) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 4) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 5) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 6) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 7) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 8) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 9) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 10) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 11) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 12) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 13) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 14) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 15) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc9_ += 16;
            }
            while(_loc9_ < _loc7_)
            {
               _loc6_ = int(li8(param1 + _loc9_ * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc9_++;
            }
         }
         else if(level == CompressionLevel.NORMAL || level == CompressionLevel.GOOD)
         {
            _loc3_ = 257;
            _loc4_ = 257;
            while(_loc4_ < 286)
            {
               _loc5_ = int(_loc4_++);
               if(li32(scratchAddr + _loc5_ * 4) > 0)
               {
                  _loc3_ = _loc5_ + 1;
               }
            }
            si32(1,scratchAddr + 1024);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = int(_loc4_++);
               if(_loc5_ != 256 && li32(scratchAddr + _loc5_ * 4) > 0)
               {
                  _loc6_ = li32(scratchAddr + _loc5_ * 4) + 2;
                  si32(_loc6_,scratchAddr + _loc5_ * 4);
               }
            }
         }
         HuffmanTree.weightedAlphabetToCodes(scratchAddr,scratchAddr + _loc3_ * 4,15);
         literalLengthCodes = _loc3_;
         _loc3_ = scratchAddr + 1144;
         _loc4_ = 0;
         if(level == CompressionLevel.NORMAL || level == CompressionLevel.GOOD)
         {
            _loc5_ = 0;
            while(_loc5_ < 30)
            {
               _loc6_ = int(_loc5_++);
               if(li32(_loc3_ + _loc6_ * 4) > 0)
               {
                  _loc4_ = _loc6_ + 1;
               }
            }
         }
         HuffmanTree.weightedAlphabetToCodes(_loc3_,_loc3_ + _loc4_ * 4,15);
         distanceCodes = _loc4_;
         _loc4_ = 0;
         while(_loc4_ < 19)
         {
            _loc5_ = int(_loc4_++);
            si32(1,scratchAddr + 1272 + _loc5_ * 4);
         }
         _loc5_ = 0;
         while(_loc5_ < literalLengthCodes)
         {
            _loc6_ = int(_loc5_++);
            _loc4_ = scratchAddr + 1272 + li16(scratchAddr + _loc6_ * 4) * 4;
            _loc7_ = li32(_loc4_) + 1;
            si32(_loc7_,_loc4_);
         }
         _loc5_ = 0;
         while(_loc5_ < distanceCodes)
         {
            _loc6_ = int(_loc5_++);
            _loc4_ = scratchAddr + 1272 + li16(scratchAddr + 1144 + _loc6_ * 4) * 4;
            _loc7_ = li32(_loc4_) + 1;
            si32(_loc7_,_loc4_);
         }
         _loc5_ = scratchAddr + 1272;
         HuffmanTree.weightedAlphabetToCodes(_loc5_,_loc5_ + 76,7);
         _loc3_ = 19;
         _loc4_ = int(li8(currentAddr));
         _loc4_ |= literalLengthCodes - 257 << bitOffset;
         si32(_loc4_,currentAddr);
         bitOffset += 5;
         currentAddr += bitOffset >>> 3;
         bitOffset &= 7;
         if(distanceCodes == 0)
         {
            _loc4_ = int(li8(currentAddr));
            _loc4_ |= 0 << bitOffset;
            si32(_loc4_,currentAddr);
            bitOffset += 5;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         else
         {
            _loc4_ = int(li8(currentAddr));
            _loc4_ |= distanceCodes - 1 << bitOffset;
            si32(_loc4_,currentAddr);
            bitOffset += 5;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         _loc4_ = int(li8(currentAddr));
         _loc4_ |= _loc3_ - 4 << bitOffset;
         si32(_loc4_,currentAddr);
         bitOffset += 4;
         currentAddr += bitOffset >>> 3;
         bitOffset &= 7;
         _loc4_ = 0;
         var _loc11_:Array = [16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15];
         while(_loc4_ < int(_loc11_.length))
         {
            _loc5_ = int(_loc11_[_loc4_]);
            _loc4_++;
            _loc6_ = int(li16(scratchAddr + 1272 + _loc5_ * 4));
            _loc7_ = int(li8(currentAddr));
            _loc7_ |= _loc6_ << bitOffset;
            si32(_loc7_,currentAddr);
            bitOffset += 3;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         _loc4_ = 0;
         _loc5_ = int(literalLengthCodes);
         while(_loc4_ < _loc5_)
         {
            _loc6_ = int(_loc4_++);
            _loc7_ = int(li16(scratchAddr + _loc6_ * 4));
            _loc8_ = int(li32(scratchAddr + 1272 + _loc7_ * 4));
            _loc9_ = int(li8(currentAddr));
            _loc9_ |= _loc8_ >>> 16 << bitOffset;
            si32(_loc9_,currentAddr);
            bitOffset += _loc8_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         if(distanceCodes == 0)
         {
            _loc4_ = int(li32(scratchAddr + 1272));
            _loc5_ = int(li8(currentAddr));
            _loc5_ |= _loc4_ >>> 16 << bitOffset;
            si32(_loc5_,currentAddr);
            bitOffset += _loc4_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         else
         {
            _loc4_ = 0;
            _loc5_ = int(distanceCodes);
            while(_loc4_ < _loc5_)
            {
               _loc6_ = int(_loc4_++);
               _loc7_ = int(li16(scratchAddr + 1144 + _loc6_ * 4));
               _loc8_ = int(li32(scratchAddr + 1272 + _loc7_ * 4));
               _loc9_ = int(li8(currentAddr));
               _loc9_ |= _loc8_ >>> 16 << bitOffset;
               si32(_loc9_,currentAddr);
               bitOffset += _loc8_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
         }
      }
      
      public function clearSymbolFrequencies() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 286)
         {
            _loc2_ = _loc1_++;
            si32(0,scratchAddr + (_loc2_ << 2));
         }
         _loc1_ = 0;
         while(_loc1_ < 30)
         {
            _loc2_ = _loc1_++;
            si32(0,scratchAddr + 1144 + (_loc2_ << 2));
         }
      }
      
      public function beginBlock(param1:Boolean = false) : void
      {
         var _loc2_:* = 0;
         blockInProgress = true;
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            if(bitOffset == 0)
            {
               si8(0,currentAddr);
            }
            _loc2_ = int(li8(currentAddr));
            _loc2_ |= (!!param1 ? 1 : 0) << bitOffset;
            si32(_loc2_,currentAddr);
            bitOffset += 3;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
            if(bitOffset > 0)
            {
               _loc2_ = int(li8(currentAddr));
               _loc2_ |= 0 << bitOffset;
               si32(_loc2_,currentAddr);
               bitOffset += 8 - bitOffset;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
         }
         else
         {
            _loc2_ = int(li8(currentAddr));
            _loc2_ |= (4 | (!!param1 ? 1 : 0)) << bitOffset;
            si32(_loc2_,currentAddr);
            bitOffset += 3;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         blockStartAddr = currentAddr;
      }
      
      public function _new(param1:CompressionLevel, param2:Boolean, param3:int, param4:int) : void
      {
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = 0;
         var _loc16_:int = 0;
         level = param1;
         zlib = param2;
         scratchAddr = param3;
         startAddr = param4;
         currentAddr = param4;
         rangeResult = new MemoryRange(0,0);
         HuffmanTree.scratchAddr = param3 + 1348;
         var _loc5_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc6_:uint = param4 + 15;
         if(_loc5_.length < _loc6_)
         {
            _loc5_.length = _loc6_;
            ApplicationDomain.currentDomain.domainMemory = _loc5_;
         }
         distanceCodes = -1;
         blockInProgress = false;
         blockStartAddr = currentAddr;
         bitOffset = 0;
         s1 = 1;
         s2 = 0;
         if(zlib)
         {
            si8(120,currentAddr);
            currentAddr = currentAddr + 1;
            si8(156,currentAddr);
            currentAddr = currentAddr + 1;
         }
         if(level == CompressionLevel.NORMAL || level == CompressionLevel.GOOD)
         {
            _loc7_ = scratchAddr + 2492;
            si32(16842755,_loc7_ + 12);
            si32(16908292,_loc7_ + 16);
            si32(16973829,_loc7_ + 20);
            si32(17039366,_loc7_ + 24);
            si32(17104903,_loc7_ + 28);
            si32(17170440,_loc7_ + 32);
            si32(17235977,_loc7_ + 36);
            si32(17301514,_loc7_ + 40);
            _loc8_ = 11;
            _loc9_ = 265;
            _loc10_ = 1;
            while(_loc10_ < 6)
            {
               _loc11_ = _loc10_++;
               _loc12_ = 0;
               while(_loc12_ < 4)
               {
                  _loc13_ = _loc12_++;
                  _loc14_ = _loc8_;
                  _loc15_ = _loc8_ + (1 << _loc11_);
                  while(_loc14_ < _loc15_)
                  {
                     _loc16_ = _loc14_++;
                     si32(_loc9_ << 16 | _loc11_ << 13 | _loc8_,_loc7_ + _loc16_ * 4);
                  }
                  _loc8_ += 1 << _loc11_;
                  _loc9_++;
               }
            }
            si32(18678018,_loc7_ + 1032);
            _loc7_ = scratchAddr + 3528;
            si32(1,_loc7_ + 4);
            si32(16777218,_loc7_ + 8);
            si32(33554435,_loc7_ + 12);
            si32(50331652,_loc7_ + 16);
            _loc8_ = 5;
            _loc9_ = 4;
            _loc10_ = 1;
            while(_loc10_ < 7)
            {
               _loc11_ = _loc10_++;
               _loc12_ = 0;
               while(_loc12_ < 2)
               {
                  _loc13_ = _loc12_++;
                  _loc14_ = _loc8_;
                  _loc15_ = _loc8_ + (1 << _loc11_);
                  while(_loc14_ < _loc15_)
                  {
                     _loc16_ = _loc14_++;
                     si32(_loc9_ << 24 | _loc11_ << 16 | _loc8_,_loc7_ + _loc16_ * 4);
                  }
                  _loc8_ += 1 << _loc11_;
                  _loc9_++;
               }
            }
            _loc7_ += 1024;
            _loc10_ = 7;
            while(_loc10_ < 14)
            {
               _loc11_ = _loc10_++;
               _loc12_ = 0;
               while(_loc12_ < 2)
               {
                  _loc13_ = _loc12_++;
                  _loc14_ = _loc8_ >>> 7;
                  _loc15_ = (_loc8_ >>> 7) + (1 << _loc11_ - 7);
                  while(_loc14_ < _loc15_)
                  {
                     _loc16_ = _loc14_++;
                     si32(_loc9_ << 24 | _loc11_ << 16 | _loc8_,_loc7_ + _loc16_ * 4);
                  }
                  _loc8_ += 1 << _loc11_;
                  _loc9_++;
               }
            }
         }
         si8(0,currentAddr);
      }
      
      public function _maxOutputBufferSize(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 1;
         var _loc5_:int = 0;
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            _loc3_ = 8;
            _loc2_ = Math.ceil(param1 / 65535);
         }
         else
         {
            if(level == CompressionLevel.FAST)
            {
               _loc2_ = Math.ceil(param1 * 2 / 49152);
            }
            else
            {
               _loc2_ = Math.ceil(param1 / 98304);
               if(level == CompressionLevel.NORMAL)
               {
                  _loc5_ = 458752;
               }
               else if(level == CompressionLevel.GOOD)
               {
                  _loc5_ = 524308;
               }
            }
            _loc4_ = 2;
            _loc3_ = 300;
         }
         return param1 * _loc4_ + _loc3_ * (_loc2_ + 1) + _loc5_;
      }
      
      public function _fastWriteUncompressed(param1:int, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:* = 0;
         if(zlib)
         {
            _loc3_ = int(param1);
            while(_loc3_ + 5552 <= param2)
            {
               _loc4_ = int(_loc3_);
               while(_loc4_ < _loc3_ + 5552)
               {
                  s2 += (s1 << 4) + li8(_loc4_) * 16 + li8(_loc4_ + 1) * 15 + li8(_loc4_ + 2) * 14 + li8(_loc4_ + 3) * 13 + li8(_loc4_ + 4) * 12 + li8(_loc4_ + 5) * 11 + li8(_loc4_ + 6) * 10 + li8(_loc4_ + 7) * 9 + li8(_loc4_ + 8) * 8 + li8(_loc4_ + 9) * 7 + li8(_loc4_ + 10) * 6 + li8(_loc4_ + 11) * 5 + li8(_loc4_ + 12) * 4 + li8(_loc4_ + 13) * 3 + li8(_loc4_ + 14) * 2 + li8(_loc4_ + 15);
                  s1 += li8(_loc4_) + li8(_loc4_ + 1) + li8(_loc4_ + 2) + li8(_loc4_ + 3) + li8(_loc4_ + 4) + li8(_loc4_ + 5) + li8(_loc4_ + 6) + li8(_loc4_ + 7) + li8(_loc4_ + 8) + li8(_loc4_ + 9) + li8(_loc4_ + 10) + li8(_loc4_ + 11) + li8(_loc4_ + 12) + li8(_loc4_ + 13) + li8(_loc4_ + 14) + li8(_loc4_ + 15);
                  _loc4_ += 16;
               }
               s1 %= 65521;
               s2 %= 65521;
               _loc3_ += 5552;
            }
            if(_loc3_ != param2)
            {
               _loc4_ = int(_loc3_);
               while(_loc4_ < param2)
               {
                  _loc5_ = _loc4_++;
                  s1 += li8(_loc5_);
                  s2 += s1;
               }
               s1 %= 65521;
               s2 %= 65521;
            }
         }
         _loc3_ = 8;
         _loc4_ = param2 - param1;
         _loc5_ = Math.ceil(_loc4_ / 65535);
         var _loc6_:uint = _loc4_ + _loc3_ * _loc5_;
         var _loc7_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc8_:uint = uint(_loc7_.length - currentAddr);
         if(_loc8_ < _loc6_)
         {
            _loc7_.length = uint(currentAddr + _loc6_);
            ApplicationDomain.currentDomain.domainMemory = _loc7_;
         }
         while(param2 - param1 > 0)
         {
            _loc10_ = Number(Math.min(param2 - param1,65535));
            _loc9_ = _loc10_;
            _loc11_ = false;
            blockInProgress = true;
            if(level == CompressionLevel.UNCOMPRESSED)
            {
               if(bitOffset == 0)
               {
                  si8(0,currentAddr);
               }
               _loc12_ = int(li8(currentAddr));
               _loc12_ |= (!!_loc11_ ? 1 : 0) << bitOffset;
               si32(_loc12_,currentAddr);
               bitOffset += 3;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               if(bitOffset > 0)
               {
                  _loc12_ = int(li8(currentAddr));
                  _loc12_ |= 0 << bitOffset;
                  si32(_loc12_,currentAddr);
                  bitOffset += 8 - bitOffset;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
            }
            else
            {
               _loc12_ = int(li8(currentAddr));
               _loc12_ |= (4 | (!!_loc11_ ? 1 : 0)) << bitOffset;
               si32(_loc12_,currentAddr);
               bitOffset += 3;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
            blockStartAddr = currentAddr;
            si16(_loc9_,currentAddr);
            currentAddr += 2;
            si16(~_loc9_,currentAddr);
            currentAddr += 2;
            _loc12_ = param1 + _loc9_;
            _loc13_ = param1 + (_loc9_ & -32);
            _loc14_ = int(param1);
            while(_loc14_ < _loc13_)
            {
               _loc15_ = li32(_loc14_);
               si32(_loc15_,currentAddr);
               _loc15_ = li32(_loc14_ + 4);
               si32(_loc15_,currentAddr + 4);
               _loc15_ = li32(_loc14_ + 8);
               si32(_loc15_,currentAddr + 8);
               _loc15_ = li32(_loc14_ + 12);
               si32(_loc15_,currentAddr + 12);
               _loc15_ = li32(_loc14_ + 16);
               si32(_loc15_,currentAddr + 16);
               _loc15_ = li32(_loc14_ + 20);
               si32(_loc15_,currentAddr + 20);
               _loc15_ = li32(_loc14_ + 24);
               si32(_loc15_,currentAddr + 24);
               _loc15_ = li32(_loc14_ + 28);
               si32(_loc15_,currentAddr + 28);
               currentAddr += 32;
               _loc14_ += 32;
            }
            while(_loc14_ < _loc12_)
            {
               _loc15_ = li8(_loc14_);
               si8(_loc15_,currentAddr);
               currentAddr = currentAddr + 1;
               _loc14_++;
            }
            if(level != CompressionLevel.UNCOMPRESSED)
            {
               _loc15_ = 0;
               _loc16_ = li32(scratchAddr + _loc15_ + 1024);
               _loc17_ = int(li8(currentAddr));
               _loc17_ |= _loc16_ >>> 16 << bitOffset;
               si32(_loc17_,currentAddr);
               bitOffset += _loc16_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
            blockInProgress = false;
            param1 += _loc9_;
         }
      }
      
      public function _fastWriteNormal(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = 0;
         var _loc20_:Number = NaN;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:Boolean = false;
         var _loc25_:* = 0;
         var _loc26_:* = 0;
         var _loc15_:* = param2 - param1;
         _loc18_ = 1;
         _loc19_ = 0;
         §§push(currentAddr);
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            _loc17_ = 8;
            _loc16_ = int(Math.ceil(_loc15_ / 65535));
         }
         else
         {
            if(level == CompressionLevel.FAST)
            {
               _loc16_ = int(Math.ceil(_loc15_ * 2 / 49152));
            }
            else
            {
               _loc16_ = int(Math.ceil(_loc15_ / 98304));
               if(level == CompressionLevel.NORMAL)
               {
                  _loc19_ = 458752;
               }
               else if(level == CompressionLevel.GOOD)
               {
                  _loc19_ = 524308;
               }
            }
            _loc18_ = 2;
            _loc17_ = 300;
         }
         var _loc14_:* = §§pop() + (_loc15_ * _loc18_ + _loc17_ * (_loc16_ + 1) + _loc19_) - 262144;
         _loc15_ = _loc14_ - 196608;
         var _loc11_:* = _loc14_ + 262144 - 32;
         while(_loc11_ >= _loc14_)
         {
            si32(-1,_loc11_);
            si32(-1,_loc11_ + 4);
            si32(-1,_loc11_ + 8);
            si32(-1,_loc11_ + 12);
            si32(-1,_loc11_ + 16);
            si32(-1,_loc11_ + 20);
            si32(-1,_loc11_ + 24);
            si32(-1,_loc11_ + 28);
            _loc11_ -= 32;
         }
         while(param2 - param1 > 0)
         {
            _loc20_ = Number(Math.min(param2,param1 + 98304));
            _loc3_ = _loc20_;
            _loc4_ = _loc3_ - 4;
            _loc17_ = 0;
            while(_loc17_ < 286)
            {
               _loc18_ = int(_loc17_++);
               si32(0,scratchAddr + (_loc18_ << 2));
            }
            _loc17_ = 0;
            while(_loc17_ < 30)
            {
               _loc18_ = int(_loc17_++);
               si32(0,scratchAddr + 1144 + (_loc18_ << 2));
            }
            _loc16_ = int(_loc15_);
            _loc11_ = int(param1);
            while(_loc11_ < _loc4_)
            {
               _loc17_ = 775236557;
               _loc18_ = -862048943;
               _loc19_ = 461845907;
               _loc21_ = li32(_loc11_) * _loc18_;
               _loc21_ = _loc21_ << 15 | _loc21_ >>> 17;
               _loc17_ ^= _loc21_ * _loc19_;
               _loc17_ = _loc17_ << 13 | _loc17_ >>> 19;
               _loc17_ = _loc17_ * 5 + -430675100;
               _loc22_ = _loc17_ ^ 4;
               _loc22_ ^= _loc22_ >>> 16;
               _loc22_ *= -2048144789;
               _loc22_ ^= _loc22_ >>> 13;
               _loc22_ *= -1028477387;
               _loc10_ = ((_loc22_ ^ _loc22_ >>> 16) & 65535) << 2;
               _loc12_ = int(li32(_loc14_ + _loc10_));
               if(_loc12_ >= 0 && li32(_loc12_) == li32(_loc11_))
               {
                  _loc6_ = 4;
                  _loc12_ += 4;
                  _loc13_ = _loc11_ + 4;
                  while(_loc13_ < _loc3_ && li8(_loc12_) == li8(_loc13_) && _loc6_ < 258)
                  {
                     _loc12_++;
                     _loc13_++;
                     _loc6_++;
                  }
                  si32(_loc11_,_loc14_ + _loc10_);
                  _loc8_ = _loc13_ - _loc12_;
                  if(_loc8_ <= 32768)
                  {
                     _loc17_ = int(li16(scratchAddr + 2492 + (_loc6_ << 2) + 2));
                     _loc18_ = 0;
                     _loc19_ = scratchAddr + _loc18_ + (_loc17_ << 2);
                     _loc21_ = li32(_loc19_) + 1;
                     si32(_loc21_,_loc19_);
                     _loc9_ = li32(scratchAddr + 3528 + ((_loc8_ <= 256 ? _loc8_ : 256 + (_loc8_ - 1 >>> 7)) << 2));
                     _loc17_ = scratchAddr + 1144 + (_loc9_ >>> 24 << 2);
                     _loc18_ = li32(_loc17_) + 1;
                     si32(_loc18_,_loc17_);
                     si32(_loc6_ | 512 | _loc8_ << 16,_loc16_);
                     _loc16_ += 4;
                     _loc11_ += _loc6_;
                     if(_loc11_ < _loc4_)
                     {
                        _loc18_ = 775236557;
                        _loc19_ = -862048943;
                        _loc21_ = 461845907;
                        _loc22_ = li32(_loc11_ - 1) * _loc19_;
                        _loc22_ = _loc22_ << 15 | _loc22_ >>> 17;
                        _loc18_ ^= _loc22_ * _loc21_;
                        _loc18_ = _loc18_ << 13 | _loc18_ >>> 19;
                        _loc18_ = _loc18_ * 5 + -430675100;
                        _loc23_ = _loc18_ ^ 4;
                        _loc23_ ^= _loc23_ >>> 16;
                        _loc23_ *= -2048144789;
                        _loc23_ ^= _loc23_ >>> 13;
                        _loc23_ *= -1028477387;
                        _loc17_ = _loc14_ + (((_loc23_ ^ _loc23_ >>> 16) & 65535) << 2);
                        si32(_loc11_ - 1,_loc17_);
                     }
                  }
                  else
                  {
                     _loc5_ = li8(_loc11_);
                     si16(_loc5_,_loc16_);
                     _loc17_ = 0;
                     _loc18_ = scratchAddr + _loc17_ + (_loc5_ << 2);
                     _loc19_ = li32(_loc18_) + 1;
                     si32(_loc19_,_loc18_);
                     _loc16_ += 2;
                     _loc11_++;
                  }
               }
               else
               {
                  _loc5_ = li8(_loc11_);
                  si16(_loc5_,_loc16_);
                  _loc17_ = 0;
                  _loc18_ = scratchAddr + _loc17_ + (_loc5_ << 2);
                  _loc19_ = li32(_loc18_) + 1;
                  si32(_loc19_,_loc18_);
                  si32(_loc11_,_loc14_ + _loc10_);
                  _loc16_ += 2;
                  _loc11_++;
               }
            }
            while(_loc11_ < _loc3_)
            {
               _loc5_ = li8(_loc11_);
               si16(_loc5_,_loc16_);
               _loc17_ = 0;
               _loc18_ = scratchAddr + _loc17_ + (_loc5_ << 2);
               _loc19_ = li32(_loc18_) + 1;
               si32(_loc19_,_loc18_);
               _loc16_ += 2;
               _loc11_++;
            }
            _loc24_ = false;
            blockInProgress = true;
            if(level == CompressionLevel.UNCOMPRESSED)
            {
               if(bitOffset == 0)
               {
                  si8(0,currentAddr);
               }
               _loc17_ = int(li8(currentAddr));
               _loc17_ |= (!!_loc24_ ? 1 : 0) << bitOffset;
               si32(_loc17_,currentAddr);
               bitOffset += 3;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               if(bitOffset > 0)
               {
                  _loc17_ = int(li8(currentAddr));
                  _loc17_ |= 0 << bitOffset;
                  si32(_loc17_,currentAddr);
                  bitOffset += 8 - bitOffset;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
            }
            else
            {
               _loc17_ = int(li8(currentAddr));
               _loc17_ |= (4 | (!!_loc24_ ? 1 : 0)) << bitOffset;
               si32(_loc17_,currentAddr);
               bitOffset += 3;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
            blockStartAddr = currentAddr;
            createAndWriteHuffmanTrees(param1,_loc3_);
            _loc11_ = int(_loc15_);
            while(_loc11_ + 64 <= _loc16_)
            {
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
            }
            while(_loc11_ < _loc16_)
            {
               _loc22_ = int(li16(_loc11_));
               if((_loc22_ & 512) != 0)
               {
                  _loc17_ = _loc22_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc21_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc23_ = int(li32(scratchAddr + 1144 + (_loc21_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc23_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc23_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= _loc18_ - (_loc21_ & 65535) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += (_loc21_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc23_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc23_ + _loc22_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc5_ = _loc22_;
               _loc11_ += 2 + ((_loc5_ & 512) >>> 8);
            }
            if(level != CompressionLevel.UNCOMPRESSED)
            {
               _loc17_ = 0;
               _loc18_ = int(li32(scratchAddr + _loc17_ + 1024));
               _loc19_ = int(li8(currentAddr));
               _loc19_ |= _loc18_ >>> 16 << bitOffset;
               si32(_loc19_,currentAddr);
               bitOffset += _loc18_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
            blockInProgress = false;
            param1 = _loc3_;
         }
      }
      
      public function _fastWriteGood(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = 0;
         var _loc21_:Number = NaN;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc32_:* = 0;
         var _loc33_:* = 0;
         var _loc34_:* = 0;
         var _loc35_:* = 0;
         var _loc36_:* = 0;
         var _loc37_:* = 0;
         var _loc38_:Boolean = false;
         var _loc15_:* = param2 - param1;
         _loc18_ = 1;
         _loc19_ = 0;
         §§push(currentAddr);
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            _loc17_ = 8;
            _loc16_ = int(Math.ceil(_loc15_ / 65535));
         }
         else
         {
            if(level == CompressionLevel.FAST)
            {
               _loc16_ = int(Math.ceil(_loc15_ * 2 / 49152));
            }
            else
            {
               _loc16_ = int(Math.ceil(_loc15_ / 98304));
               if(level == CompressionLevel.NORMAL)
               {
                  _loc19_ = 458752;
               }
               else if(level == CompressionLevel.GOOD)
               {
                  _loc19_ = 524308;
               }
            }
            _loc18_ = 2;
            _loc17_ = 300;
         }
         var _loc14_:* = §§pop() + (_loc15_ * _loc18_ + _loc17_ * (_loc16_ + 1) + _loc19_) - 327700;
         _loc15_ = _loc14_ - 196608;
         var _loc20_:LZHash = new LZHash(_loc14_,258,32768);
         while(param2 - param1 > 0)
         {
            _loc21_ = Number(Math.min(param2,param1 + 98304));
            _loc3_ = _loc21_;
            _loc5_ = _loc3_ - 9;
            _loc4_ = _loc5_ - 516 - 1;
            _loc17_ = 0;
            while(_loc17_ < 286)
            {
               _loc18_ = int(_loc17_++);
               si32(0,scratchAddr + (_loc18_ << 2));
            }
            _loc17_ = 0;
            while(_loc17_ < 30)
            {
               _loc18_ = int(_loc17_++);
               si32(0,scratchAddr + 1144 + (_loc18_ << 2));
            }
            _loc16_ = int(_loc15_);
            _loc11_ = int(param1);
            if(_loc11_ < _loc4_)
            {
               _loc19_ = 775236557;
               _loc22_ = -862048943;
               _loc23_ = 461845907;
               _loc24_ = li32(param1) * _loc22_;
               _loc24_ = _loc24_ << 15 | _loc24_ >>> 17;
               _loc19_ ^= _loc24_ * _loc23_;
               _loc19_ = _loc19_ << 13 | _loc19_ >>> 19;
               _loc19_ = _loc19_ * 5 + -430675100;
               _loc25_ = _loc19_ ^ 4;
               _loc25_ ^= _loc25_ >>> 16;
               _loc25_ *= -2048144789;
               _loc25_ ^= _loc25_ >>> 13;
               _loc25_ *= -1028477387;
               _loc18_ = (_loc25_ ^ _loc25_ >>> 16) & 65535;
               _loc17_ = _loc20_.addr + _loc18_ * 5;
               _loc18_ = 3;
               _loc19_ = -1;
               _loc23_ = int(li32(_loc17_ + 1));
               if(_loc23_ >= 0 && li32(param1) == li32(_loc23_) && param1 - _loc23_ <= _loc20_.windowSize)
               {
                  _loc24_ = param1 + 4;
                  _loc22_ = 4;
                  _loc23_ += 4;
                  while(li32(_loc23_) == li32(_loc24_) && _loc22_ + 4 <= _loc20_.maxMatchLength)
                  {
                     _loc22_ += 4;
                     _loc23_ += 4;
                     _loc24_ += 4;
                  }
                  while(li8(_loc23_) == li8(_loc24_) && _loc22_ < _loc20_.maxMatchLength)
                  {
                     _loc22_++;
                     _loc23_++;
                     _loc24_++;
                  }
                  _loc18_ = int(_loc22_);
                  _loc19_ = int(_loc23_);
               }
               _loc25_ = 5;
               _loc26_ = 9;
               while(_loc25_ < _loc26_)
               {
                  _loc27_ = int(_loc25_++);
                  _loc30_ = int(li32(param1));
                  si32(_loc30_,_loc20_.hashScratchAddr);
                  _loc30_ = int(li32(param1 + 4));
                  si32(_loc30_,_loc20_.hashScratchAddr + 4);
                  si32(0,_loc20_.hashScratchAddr + _loc27_);
                  _loc30_ = 775236557;
                  _loc31_ = -862048943;
                  _loc32_ = 461845907;
                  _loc33_ = li32(_loc20_.hashScratchAddr) * _loc31_;
                  _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                  _loc30_ ^= _loc33_ * _loc32_;
                  _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                  _loc30_ = _loc30_ * 5 + -430675100;
                  _loc33_ = li32(_loc20_.hashScratchAddr + 4) * _loc31_;
                  _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                  _loc30_ ^= _loc33_ * _loc32_;
                  _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                  _loc30_ = _loc30_ * 5 + -430675100;
                  _loc34_ = _loc30_ ^ _loc27_;
                  _loc34_ ^= _loc34_ >>> 16;
                  _loc34_ *= -2048144789;
                  _loc34_ ^= _loc34_ >>> 13;
                  _loc34_ *= -1028477387;
                  _loc29_ = (_loc34_ ^ _loc34_ >>> 16) & 65535;
                  _loc28_ = _loc20_.addr + _loc29_ * 5 + 1;
                  _loc23_ = int(li32(_loc28_));
                  if(_loc23_ >= 0 && li32(_loc23_ + _loc18_ - 3) == li32(param1 + _loc18_ - 3) && li32(param1) == li32(_loc23_) && param1 - _loc23_ <= _loc20_.windowSize)
                  {
                     _loc24_ = param1 + 4;
                     _loc22_ = 4;
                     _loc23_ += 4;
                     while(li32(_loc23_) == li32(_loc24_) && _loc22_ + 4 <= _loc20_.maxMatchLength)
                     {
                        _loc22_ += 4;
                        _loc23_ += 4;
                        _loc24_ += 4;
                     }
                     while(li8(_loc23_) == li8(_loc24_) && _loc22_ < _loc20_.maxMatchLength)
                     {
                        _loc22_++;
                        _loc23_++;
                        _loc24_++;
                     }
                     if(_loc22_ > _loc18_)
                     {
                        _loc18_ = int(_loc22_);
                        _loc19_ = int(_loc23_);
                     }
                  }
               }
               si32(param1 - (_loc19_ - _loc18_) << 16 | _loc18_,_loc20_.resultAddr);
               _loc18_ = int(_loc17_);
               _loc19_ = 4;
               _loc22_ = int(param1);
               if((_loc23_ = int(li8(_loc18_))) < 8 && _loc23_ >= 0)
               {
                  _loc24_ = int(li32(_loc18_ + 1));
                  si8(_loc19_,_loc18_);
                  si32(_loc22_,_loc18_ + 1);
                  _loc19_ = _loc23_ + 1;
                  _loc22_ = int(_loc24_);
                  _loc26_ = int(li32(_loc22_));
                  si32(_loc26_,_loc20_.hashScratchAddr);
                  _loc26_ = int(li32(_loc22_ + 4));
                  si32(_loc26_,_loc20_.hashScratchAddr + 4);
                  si32(0,_loc20_.hashScratchAddr + _loc19_);
                  _loc26_ = 775236557;
                  _loc27_ = -862048943;
                  _loc28_ = 461845907;
                  _loc29_ = li32(_loc20_.hashScratchAddr) * _loc27_;
                  _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                  _loc26_ ^= _loc29_ * _loc28_;
                  _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                  _loc26_ = _loc26_ * 5 + -430675100;
                  _loc29_ = li32(_loc20_.hashScratchAddr + 4) * _loc27_;
                  _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                  _loc26_ ^= _loc29_ * _loc28_;
                  _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                  _loc26_ = _loc26_ * 5 + -430675100;
                  _loc30_ = _loc26_ ^ _loc19_;
                  _loc30_ ^= _loc30_ >>> 16;
                  _loc30_ *= -2048144789;
                  _loc30_ ^= _loc30_ >>> 13;
                  _loc30_ *= -1028477387;
                  _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                  _loc18_ = _loc20_.addr + _loc25_ * 5;
                  if((_loc23_ = int(li8(_loc18_))) < 8 && _loc23_ >= 0)
                  {
                     _loc24_ = int(li32(_loc18_ + 1));
                     si8(_loc19_,_loc18_);
                     si32(_loc22_,_loc18_ + 1);
                     _loc19_ = _loc23_ + 1;
                     _loc22_ = int(_loc24_);
                     _loc26_ = int(li32(_loc22_));
                     si32(_loc26_,_loc20_.hashScratchAddr);
                     _loc26_ = int(li32(_loc22_ + 4));
                     si32(_loc26_,_loc20_.hashScratchAddr + 4);
                     si32(0,_loc20_.hashScratchAddr + _loc19_);
                     _loc26_ = 775236557;
                     _loc27_ = -862048943;
                     _loc28_ = 461845907;
                     _loc29_ = li32(_loc20_.hashScratchAddr) * _loc27_;
                     _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                     _loc26_ ^= _loc29_ * _loc28_;
                     _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                     _loc26_ = _loc26_ * 5 + -430675100;
                     _loc29_ = li32(_loc20_.hashScratchAddr + 4) * _loc27_;
                     _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                     _loc26_ ^= _loc29_ * _loc28_;
                     _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                     _loc26_ = _loc26_ * 5 + -430675100;
                     _loc30_ = _loc26_ ^ _loc19_;
                     _loc30_ ^= _loc30_ >>> 16;
                     _loc30_ *= -2048144789;
                     _loc30_ ^= _loc30_ >>> 13;
                     _loc30_ *= -1028477387;
                     _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                     _loc18_ = _loc20_.addr + _loc25_ * 5;
                     if((_loc23_ = int(li8(_loc18_))) < 8 && _loc23_ >= 0)
                     {
                        _loc24_ = int(li32(_loc18_ + 1));
                        si8(_loc19_,_loc18_);
                        si32(_loc22_,_loc18_ + 1);
                        _loc19_ = _loc23_ + 1;
                        _loc22_ = int(_loc24_);
                        _loc26_ = int(li32(_loc22_));
                        si32(_loc26_,_loc20_.hashScratchAddr);
                        _loc26_ = int(li32(_loc22_ + 4));
                        si32(_loc26_,_loc20_.hashScratchAddr + 4);
                        si32(0,_loc20_.hashScratchAddr + _loc19_);
                        _loc26_ = 775236557;
                        _loc27_ = -862048943;
                        _loc28_ = 461845907;
                        _loc29_ = li32(_loc20_.hashScratchAddr) * _loc27_;
                        _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                        _loc26_ ^= _loc29_ * _loc28_;
                        _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                        _loc26_ = _loc26_ * 5 + -430675100;
                        _loc29_ = li32(_loc20_.hashScratchAddr + 4) * _loc27_;
                        _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                        _loc26_ ^= _loc29_ * _loc28_;
                        _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                        _loc26_ = _loc26_ * 5 + -430675100;
                        _loc30_ = _loc26_ ^ _loc19_;
                        _loc30_ ^= _loc30_ >>> 16;
                        _loc30_ *= -2048144789;
                        _loc30_ ^= _loc30_ >>> 13;
                        _loc30_ *= -1028477387;
                        _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                        _loc18_ = _loc20_.addr + _loc25_ * 5;
                        if((_loc23_ = int(li8(_loc18_))) < 8 && _loc23_ >= 0)
                        {
                           _loc24_ = int(li32(_loc18_ + 1));
                           si8(_loc19_,_loc18_);
                           si32(_loc22_,_loc18_ + 1);
                           _loc19_ = _loc23_ + 1;
                           _loc22_ = int(_loc24_);
                           _loc26_ = int(li32(_loc22_));
                           si32(_loc26_,_loc20_.hashScratchAddr);
                           _loc26_ = int(li32(_loc22_ + 4));
                           si32(_loc26_,_loc20_.hashScratchAddr + 4);
                           si32(0,_loc20_.hashScratchAddr + _loc19_);
                           _loc26_ = 775236557;
                           _loc27_ = -862048943;
                           _loc28_ = 461845907;
                           _loc29_ = li32(_loc20_.hashScratchAddr) * _loc27_;
                           _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                           _loc26_ ^= _loc29_ * _loc28_;
                           _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                           _loc26_ = _loc26_ * 5 + -430675100;
                           _loc29_ = li32(_loc20_.hashScratchAddr + 4) * _loc27_;
                           _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                           _loc26_ ^= _loc29_ * _loc28_;
                           _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                           _loc26_ = _loc26_ * 5 + -430675100;
                           _loc30_ = _loc26_ ^ _loc19_;
                           _loc30_ ^= _loc30_ >>> 16;
                           _loc30_ *= -2048144789;
                           _loc30_ ^= _loc30_ >>> 13;
                           _loc30_ *= -1028477387;
                           _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                           _loc18_ = _loc20_.addr + _loc25_ * 5;
                        }
                     }
                  }
               }
               si8(_loc19_,_loc18_);
               si32(_loc22_,_loc18_ + 1);
               _loc20_.resultAddr = _loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7);
            }
            else if(_loc11_ < _loc5_)
            {
               _loc19_ = 775236557;
               _loc22_ = -862048943;
               _loc23_ = 461845907;
               _loc24_ = li32(param1) * _loc22_;
               _loc24_ = _loc24_ << 15 | _loc24_ >>> 17;
               _loc19_ ^= _loc24_ * _loc23_;
               _loc19_ = _loc19_ << 13 | _loc19_ >>> 19;
               _loc19_ = _loc19_ * 5 + -430675100;
               _loc25_ = _loc19_ ^ 4;
               _loc25_ ^= _loc25_ >>> 16;
               _loc25_ *= -2048144789;
               _loc25_ ^= _loc25_ >>> 13;
               _loc25_ *= -1028477387;
               _loc18_ = (_loc25_ ^ _loc25_ >>> 16) & 65535;
               _loc17_ = _loc20_.addr + _loc18_ * 5;
               _loc18_ = 3;
               _loc19_ = -1;
               _loc23_ = int(li32(_loc17_ + 1));
               if(_loc23_ >= 0 && li32(param1) == li32(_loc23_) && param1 - _loc23_ <= _loc20_.windowSize)
               {
                  _loc24_ = param1 + 4;
                  _loc22_ = 4;
                  _loc23_ += 4;
                  while(_loc24_ + 4 <= _loc3_ && li32(_loc23_) == li32(_loc24_) && _loc22_ + 4 <= _loc20_.maxMatchLength)
                  {
                     _loc22_ += 4;
                     _loc23_ += 4;
                     _loc24_ += 4;
                  }
                  while(_loc24_ < _loc3_ && li8(_loc23_) == li8(_loc24_) && _loc22_ < _loc20_.maxMatchLength)
                  {
                     _loc22_++;
                     _loc23_++;
                     _loc24_++;
                  }
                  _loc18_ = int(_loc22_);
                  _loc19_ = int(_loc23_);
               }
               _loc25_ = 5;
               _loc26_ = 9;
               while(_loc25_ < _loc26_)
               {
                  _loc27_ = int(_loc25_++);
                  _loc30_ = int(li32(param1));
                  si32(_loc30_,_loc20_.hashScratchAddr);
                  _loc30_ = int(li32(param1 + 4));
                  si32(_loc30_,_loc20_.hashScratchAddr + 4);
                  si32(0,_loc20_.hashScratchAddr + _loc27_);
                  _loc30_ = 775236557;
                  _loc31_ = -862048943;
                  _loc32_ = 461845907;
                  _loc33_ = li32(_loc20_.hashScratchAddr) * _loc31_;
                  _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                  _loc30_ ^= _loc33_ * _loc32_;
                  _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                  _loc30_ = _loc30_ * 5 + -430675100;
                  _loc33_ = li32(_loc20_.hashScratchAddr + 4) * _loc31_;
                  _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                  _loc30_ ^= _loc33_ * _loc32_;
                  _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                  _loc30_ = _loc30_ * 5 + -430675100;
                  _loc34_ = _loc30_ ^ _loc27_;
                  _loc34_ ^= _loc34_ >>> 16;
                  _loc34_ *= -2048144789;
                  _loc34_ ^= _loc34_ >>> 13;
                  _loc34_ *= -1028477387;
                  _loc29_ = (_loc34_ ^ _loc34_ >>> 16) & 65535;
                  _loc28_ = _loc20_.addr + _loc29_ * 5 + 1;
                  _loc23_ = int(li32(_loc28_));
                  if(_loc23_ >= 0 && li32(param1) == li32(_loc23_) && param1 - _loc23_ <= _loc20_.windowSize)
                  {
                     _loc24_ = param1 + 4;
                     _loc22_ = 4;
                     _loc23_ += 4;
                     while(_loc24_ + 4 <= _loc3_ && li32(_loc23_) == li32(_loc24_) && _loc22_ + 4 <= _loc20_.maxMatchLength)
                     {
                        _loc22_ += 4;
                        _loc23_ += 4;
                        _loc24_ += 4;
                     }
                     while(_loc24_ < _loc3_ && li8(_loc23_) == li8(_loc24_) && _loc22_ < _loc20_.maxMatchLength)
                     {
                        _loc22_++;
                        _loc23_++;
                        _loc24_++;
                     }
                     if(_loc22_ > _loc18_)
                     {
                        _loc18_ = int(_loc22_);
                        _loc19_ = int(_loc23_);
                     }
                  }
               }
               si32(param1 - (_loc19_ - _loc18_) << 16 | _loc18_,_loc20_.resultAddr);
               _loc18_ = int(_loc17_);
               _loc19_ = 4;
               _loc22_ = int(param1);
               if((_loc23_ = int(li8(_loc18_))) < 8 && _loc23_ >= 0)
               {
                  _loc24_ = int(li32(_loc18_ + 1));
                  si8(_loc19_,_loc18_);
                  si32(_loc22_,_loc18_ + 1);
                  _loc19_ = _loc23_ + 1;
                  _loc22_ = int(_loc24_);
                  _loc26_ = int(li32(_loc22_));
                  si32(_loc26_,_loc20_.hashScratchAddr);
                  _loc26_ = int(li32(_loc22_ + 4));
                  si32(_loc26_,_loc20_.hashScratchAddr + 4);
                  si32(0,_loc20_.hashScratchAddr + _loc19_);
                  _loc26_ = 775236557;
                  _loc27_ = -862048943;
                  _loc28_ = 461845907;
                  _loc29_ = li32(_loc20_.hashScratchAddr) * _loc27_;
                  _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                  _loc26_ ^= _loc29_ * _loc28_;
                  _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                  _loc26_ = _loc26_ * 5 + -430675100;
                  _loc29_ = li32(_loc20_.hashScratchAddr + 4) * _loc27_;
                  _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                  _loc26_ ^= _loc29_ * _loc28_;
                  _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                  _loc26_ = _loc26_ * 5 + -430675100;
                  _loc30_ = _loc26_ ^ _loc19_;
                  _loc30_ ^= _loc30_ >>> 16;
                  _loc30_ *= -2048144789;
                  _loc30_ ^= _loc30_ >>> 13;
                  _loc30_ *= -1028477387;
                  _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                  _loc18_ = _loc20_.addr + _loc25_ * 5;
                  if((_loc23_ = int(li8(_loc18_))) < 8 && _loc23_ >= 0)
                  {
                     _loc24_ = int(li32(_loc18_ + 1));
                     si8(_loc19_,_loc18_);
                     si32(_loc22_,_loc18_ + 1);
                     _loc19_ = _loc23_ + 1;
                     _loc22_ = int(_loc24_);
                     _loc26_ = int(li32(_loc22_));
                     si32(_loc26_,_loc20_.hashScratchAddr);
                     _loc26_ = int(li32(_loc22_ + 4));
                     si32(_loc26_,_loc20_.hashScratchAddr + 4);
                     si32(0,_loc20_.hashScratchAddr + _loc19_);
                     _loc26_ = 775236557;
                     _loc27_ = -862048943;
                     _loc28_ = 461845907;
                     _loc29_ = li32(_loc20_.hashScratchAddr) * _loc27_;
                     _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                     _loc26_ ^= _loc29_ * _loc28_;
                     _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                     _loc26_ = _loc26_ * 5 + -430675100;
                     _loc29_ = li32(_loc20_.hashScratchAddr + 4) * _loc27_;
                     _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                     _loc26_ ^= _loc29_ * _loc28_;
                     _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                     _loc26_ = _loc26_ * 5 + -430675100;
                     _loc30_ = _loc26_ ^ _loc19_;
                     _loc30_ ^= _loc30_ >>> 16;
                     _loc30_ *= -2048144789;
                     _loc30_ ^= _loc30_ >>> 13;
                     _loc30_ *= -1028477387;
                     _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                     _loc18_ = _loc20_.addr + _loc25_ * 5;
                     if((_loc23_ = int(li8(_loc18_))) < 8 && _loc23_ >= 0)
                     {
                        _loc24_ = int(li32(_loc18_ + 1));
                        si8(_loc19_,_loc18_);
                        si32(_loc22_,_loc18_ + 1);
                        _loc19_ = _loc23_ + 1;
                        _loc22_ = int(_loc24_);
                        _loc26_ = int(li32(_loc22_));
                        si32(_loc26_,_loc20_.hashScratchAddr);
                        _loc26_ = int(li32(_loc22_ + 4));
                        si32(_loc26_,_loc20_.hashScratchAddr + 4);
                        si32(0,_loc20_.hashScratchAddr + _loc19_);
                        _loc26_ = 775236557;
                        _loc27_ = -862048943;
                        _loc28_ = 461845907;
                        _loc29_ = li32(_loc20_.hashScratchAddr) * _loc27_;
                        _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                        _loc26_ ^= _loc29_ * _loc28_;
                        _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                        _loc26_ = _loc26_ * 5 + -430675100;
                        _loc29_ = li32(_loc20_.hashScratchAddr + 4) * _loc27_;
                        _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                        _loc26_ ^= _loc29_ * _loc28_;
                        _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                        _loc26_ = _loc26_ * 5 + -430675100;
                        _loc30_ = _loc26_ ^ _loc19_;
                        _loc30_ ^= _loc30_ >>> 16;
                        _loc30_ *= -2048144789;
                        _loc30_ ^= _loc30_ >>> 13;
                        _loc30_ *= -1028477387;
                        _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                        _loc18_ = _loc20_.addr + _loc25_ * 5;
                        if((_loc23_ = int(li8(_loc18_))) < 8 && _loc23_ >= 0)
                        {
                           _loc24_ = int(li32(_loc18_ + 1));
                           si8(_loc19_,_loc18_);
                           si32(_loc22_,_loc18_ + 1);
                           _loc19_ = _loc23_ + 1;
                           _loc22_ = int(_loc24_);
                           _loc26_ = int(li32(_loc22_));
                           si32(_loc26_,_loc20_.hashScratchAddr);
                           _loc26_ = int(li32(_loc22_ + 4));
                           si32(_loc26_,_loc20_.hashScratchAddr + 4);
                           si32(0,_loc20_.hashScratchAddr + _loc19_);
                           _loc26_ = 775236557;
                           _loc27_ = -862048943;
                           _loc28_ = 461845907;
                           _loc29_ = li32(_loc20_.hashScratchAddr) * _loc27_;
                           _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                           _loc26_ ^= _loc29_ * _loc28_;
                           _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                           _loc26_ = _loc26_ * 5 + -430675100;
                           _loc29_ = li32(_loc20_.hashScratchAddr + 4) * _loc27_;
                           _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                           _loc26_ ^= _loc29_ * _loc28_;
                           _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                           _loc26_ = _loc26_ * 5 + -430675100;
                           _loc30_ = _loc26_ ^ _loc19_;
                           _loc30_ ^= _loc30_ >>> 16;
                           _loc30_ *= -2048144789;
                           _loc30_ ^= _loc30_ >>> 13;
                           _loc30_ *= -1028477387;
                           _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                           _loc18_ = _loc20_.addr + _loc25_ * 5;
                        }
                     }
                  }
               }
               si8(_loc19_,_loc18_);
               si32(_loc22_,_loc18_ + 1);
               _loc20_.resultAddr = _loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7);
            }
            while(_loc11_ < _loc4_)
            {
               _loc22_ = 775236557;
               _loc23_ = -862048943;
               _loc24_ = 461845907;
               _loc25_ = li32(_loc11_ + 1) * _loc23_;
               _loc25_ = _loc25_ << 15 | _loc25_ >>> 17;
               _loc22_ ^= _loc25_ * _loc24_;
               _loc22_ = _loc22_ << 13 | _loc22_ >>> 19;
               _loc22_ = _loc22_ * 5 + -430675100;
               _loc26_ = _loc22_ ^ 4;
               _loc26_ ^= _loc26_ >>> 16;
               _loc26_ *= -2048144789;
               _loc26_ ^= _loc26_ >>> 13;
               _loc26_ *= -1028477387;
               _loc19_ = (_loc26_ ^ _loc26_ >>> 16) & 65535;
               _loc18_ = _loc20_.addr + _loc19_ * 5;
               if(li16(_loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7)) < _loc20_.avgMatchLength + 4)
               {
                  _loc19_ = _loc11_ + 1;
                  _loc22_ = 3;
                  _loc23_ = -1;
                  _loc25_ = int(li32(_loc18_ + 1));
                  if(_loc25_ >= 0 && li32(_loc19_) == li32(_loc25_) && _loc19_ - _loc25_ <= _loc20_.windowSize)
                  {
                     _loc26_ = _loc19_ + 4;
                     _loc24_ = 4;
                     _loc25_ += 4;
                     while(li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc20_.maxMatchLength)
                     {
                        _loc24_ += 4;
                        _loc25_ += 4;
                        _loc26_ += 4;
                     }
                     while(li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc20_.maxMatchLength)
                     {
                        _loc24_++;
                        _loc25_++;
                        _loc26_++;
                     }
                     _loc22_ = int(_loc24_);
                     _loc23_ = int(_loc25_);
                  }
                  _loc27_ = 5;
                  _loc28_ = 9;
                  while(_loc27_ < _loc28_)
                  {
                     _loc29_ = int(_loc27_++);
                     _loc32_ = int(li32(_loc19_));
                     si32(_loc32_,_loc20_.hashScratchAddr);
                     _loc32_ = int(li32(_loc19_ + 4));
                     si32(_loc32_,_loc20_.hashScratchAddr + 4);
                     si32(0,_loc20_.hashScratchAddr + _loc29_);
                     _loc32_ = 775236557;
                     _loc33_ = -862048943;
                     _loc34_ = 461845907;
                     _loc35_ = li32(_loc20_.hashScratchAddr) * _loc33_;
                     _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                     _loc32_ ^= _loc35_ * _loc34_;
                     _loc32_ = _loc32_ << 13 | _loc32_ >>> 19;
                     _loc32_ = _loc32_ * 5 + -430675100;
                     _loc35_ = li32(_loc20_.hashScratchAddr + 4) * _loc33_;
                     _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                     _loc32_ ^= _loc35_ * _loc34_;
                     _loc32_ = _loc32_ << 13 | _loc32_ >>> 19;
                     _loc32_ = _loc32_ * 5 + -430675100;
                     _loc36_ = _loc32_ ^ _loc29_;
                     _loc36_ ^= _loc36_ >>> 16;
                     _loc36_ *= -2048144789;
                     _loc36_ ^= _loc36_ >>> 13;
                     _loc36_ *= -1028477387;
                     _loc31_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                     _loc30_ = _loc20_.addr + _loc31_ * 5 + 1;
                     _loc25_ = int(li32(_loc30_));
                     if(_loc25_ >= 0 && li32(_loc25_ + _loc22_ - 3) == li32(_loc19_ + _loc22_ - 3) && li32(_loc19_) == li32(_loc25_) && _loc19_ - _loc25_ <= _loc20_.windowSize)
                     {
                        _loc26_ = _loc19_ + 4;
                        _loc24_ = 4;
                        _loc25_ += 4;
                        while(li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc20_.maxMatchLength)
                        {
                           _loc24_ += 4;
                           _loc25_ += 4;
                           _loc26_ += 4;
                        }
                        while(li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc20_.maxMatchLength)
                        {
                           _loc24_++;
                           _loc25_++;
                           _loc26_++;
                        }
                        if(_loc24_ > _loc22_)
                        {
                           _loc22_ = int(_loc24_);
                           _loc23_ = int(_loc25_);
                        }
                     }
                  }
                  si32(_loc19_ - (_loc23_ - _loc22_) << 16 | _loc22_,_loc20_.resultAddr);
               }
               else
               {
                  si32(0,_loc20_.resultAddr);
               }
               _loc19_ = int(_loc18_);
               _loc22_ = 4;
               _loc23_ = _loc11_ + 1;
               if((_loc24_ = int(li8(_loc19_))) < 8 && _loc24_ >= 0)
               {
                  _loc25_ = int(li32(_loc19_ + 1));
                  si8(_loc22_,_loc19_);
                  si32(_loc23_,_loc19_ + 1);
                  _loc22_ = _loc24_ + 1;
                  _loc23_ = int(_loc25_);
                  _loc27_ = int(li32(_loc23_));
                  si32(_loc27_,_loc20_.hashScratchAddr);
                  _loc27_ = int(li32(_loc23_ + 4));
                  si32(_loc27_,_loc20_.hashScratchAddr + 4);
                  si32(0,_loc20_.hashScratchAddr + _loc22_);
                  _loc27_ = 775236557;
                  _loc28_ = -862048943;
                  _loc29_ = 461845907;
                  _loc30_ = li32(_loc20_.hashScratchAddr) * _loc28_;
                  _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                  _loc27_ ^= _loc30_ * _loc29_;
                  _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                  _loc27_ = _loc27_ * 5 + -430675100;
                  _loc30_ = li32(_loc20_.hashScratchAddr + 4) * _loc28_;
                  _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                  _loc27_ ^= _loc30_ * _loc29_;
                  _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                  _loc27_ = _loc27_ * 5 + -430675100;
                  _loc31_ = _loc27_ ^ _loc22_;
                  _loc31_ ^= _loc31_ >>> 16;
                  _loc31_ *= -2048144789;
                  _loc31_ ^= _loc31_ >>> 13;
                  _loc31_ *= -1028477387;
                  _loc26_ = (_loc31_ ^ _loc31_ >>> 16) & 65535;
                  _loc19_ = _loc20_.addr + _loc26_ * 5;
                  if((_loc24_ = int(li8(_loc19_))) < 8 && _loc24_ >= 0)
                  {
                     _loc25_ = int(li32(_loc19_ + 1));
                     si8(_loc22_,_loc19_);
                     si32(_loc23_,_loc19_ + 1);
                     _loc22_ = _loc24_ + 1;
                     _loc23_ = int(_loc25_);
                     _loc27_ = int(li32(_loc23_));
                     si32(_loc27_,_loc20_.hashScratchAddr);
                     _loc27_ = int(li32(_loc23_ + 4));
                     si32(_loc27_,_loc20_.hashScratchAddr + 4);
                     si32(0,_loc20_.hashScratchAddr + _loc22_);
                     _loc27_ = 775236557;
                     _loc28_ = -862048943;
                     _loc29_ = 461845907;
                     _loc30_ = li32(_loc20_.hashScratchAddr) * _loc28_;
                     _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                     _loc27_ ^= _loc30_ * _loc29_;
                     _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                     _loc27_ = _loc27_ * 5 + -430675100;
                     _loc30_ = li32(_loc20_.hashScratchAddr + 4) * _loc28_;
                     _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                     _loc27_ ^= _loc30_ * _loc29_;
                     _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                     _loc27_ = _loc27_ * 5 + -430675100;
                     _loc31_ = _loc27_ ^ _loc22_;
                     _loc31_ ^= _loc31_ >>> 16;
                     _loc31_ *= -2048144789;
                     _loc31_ ^= _loc31_ >>> 13;
                     _loc31_ *= -1028477387;
                     _loc26_ = (_loc31_ ^ _loc31_ >>> 16) & 65535;
                     _loc19_ = _loc20_.addr + _loc26_ * 5;
                     if((_loc24_ = int(li8(_loc19_))) < 8 && _loc24_ >= 0)
                     {
                        _loc25_ = int(li32(_loc19_ + 1));
                        si8(_loc22_,_loc19_);
                        si32(_loc23_,_loc19_ + 1);
                        _loc22_ = _loc24_ + 1;
                        _loc23_ = int(_loc25_);
                        _loc27_ = int(li32(_loc23_));
                        si32(_loc27_,_loc20_.hashScratchAddr);
                        _loc27_ = int(li32(_loc23_ + 4));
                        si32(_loc27_,_loc20_.hashScratchAddr + 4);
                        si32(0,_loc20_.hashScratchAddr + _loc22_);
                        _loc27_ = 775236557;
                        _loc28_ = -862048943;
                        _loc29_ = 461845907;
                        _loc30_ = li32(_loc20_.hashScratchAddr) * _loc28_;
                        _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                        _loc27_ ^= _loc30_ * _loc29_;
                        _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                        _loc27_ = _loc27_ * 5 + -430675100;
                        _loc30_ = li32(_loc20_.hashScratchAddr + 4) * _loc28_;
                        _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                        _loc27_ ^= _loc30_ * _loc29_;
                        _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                        _loc27_ = _loc27_ * 5 + -430675100;
                        _loc31_ = _loc27_ ^ _loc22_;
                        _loc31_ ^= _loc31_ >>> 16;
                        _loc31_ *= -2048144789;
                        _loc31_ ^= _loc31_ >>> 13;
                        _loc31_ *= -1028477387;
                        _loc26_ = (_loc31_ ^ _loc31_ >>> 16) & 65535;
                        _loc19_ = _loc20_.addr + _loc26_ * 5;
                        if((_loc24_ = int(li8(_loc19_))) < 8 && _loc24_ >= 0)
                        {
                           _loc25_ = int(li32(_loc19_ + 1));
                           si8(_loc22_,_loc19_);
                           si32(_loc23_,_loc19_ + 1);
                           _loc22_ = _loc24_ + 1;
                           _loc23_ = int(_loc25_);
                           _loc27_ = int(li32(_loc23_));
                           si32(_loc27_,_loc20_.hashScratchAddr);
                           _loc27_ = int(li32(_loc23_ + 4));
                           si32(_loc27_,_loc20_.hashScratchAddr + 4);
                           si32(0,_loc20_.hashScratchAddr + _loc22_);
                           _loc27_ = 775236557;
                           _loc28_ = -862048943;
                           _loc29_ = 461845907;
                           _loc30_ = li32(_loc20_.hashScratchAddr) * _loc28_;
                           _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                           _loc27_ ^= _loc30_ * _loc29_;
                           _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                           _loc27_ = _loc27_ * 5 + -430675100;
                           _loc30_ = li32(_loc20_.hashScratchAddr + 4) * _loc28_;
                           _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                           _loc27_ ^= _loc30_ * _loc29_;
                           _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                           _loc27_ = _loc27_ * 5 + -430675100;
                           _loc31_ = _loc27_ ^ _loc22_;
                           _loc31_ ^= _loc31_ >>> 16;
                           _loc31_ *= -2048144789;
                           _loc31_ ^= _loc31_ >>> 13;
                           _loc31_ *= -1028477387;
                           _loc26_ = (_loc31_ ^ _loc31_ >>> 16) & 65535;
                           _loc19_ = _loc20_.addr + _loc26_ * 5;
                        }
                     }
                  }
               }
               si8(_loc22_,_loc19_);
               si32(_loc23_,_loc19_ + 1);
               _loc20_.resultAddr = _loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7);
               if(li16(_loc20_.resultAddr) >= 4)
               {
                  _loc17_ = int(li16(_loc20_.resultAddr));
                  if(li16(_loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7)) > _loc17_)
                  {
                     si32(0,_loc20_.resultAddr);
                  }
                  else
                  {
                     _loc20_.avgMatchLength = (_loc20_.avgMatchLength << 1) + (_loc20_.avgMatchLength << 2) + (_loc17_ << 1) >>> 3;
                     if(_loc17_ < _loc20_.avgMatchLength + 4)
                     {
                        _loc19_ = _loc11_ + 1 + 1;
                        _loc22_ = _loc11_ + _loc17_;
                        while(_loc19_ < _loc22_)
                        {
                           _loc23_ = int(_loc19_++);
                           _loc24_ = 4;
                           _loc25_ = int(_loc23_);
                           _loc30_ = 775236557;
                           _loc31_ = -862048943;
                           _loc32_ = 461845907;
                           _loc33_ = li32(_loc23_) * _loc31_;
                           _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                           _loc30_ ^= _loc33_ * _loc32_;
                           _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                           _loc30_ = _loc30_ * 5 + -430675100;
                           _loc34_ = _loc30_ ^ 4;
                           _loc34_ ^= _loc34_ >>> 16;
                           _loc34_ *= -2048144789;
                           _loc34_ ^= _loc34_ >>> 13;
                           _loc34_ *= -1028477387;
                           _loc29_ = (_loc34_ ^ _loc34_ >>> 16) & 65535;
                           _loc28_ = _loc20_.addr + _loc29_ * 5;
                           if((_loc26_ = int(li8(_loc28_))) < 8 && _loc26_ >= 0)
                           {
                              _loc27_ = int(li32(_loc28_ + 1));
                              si8(_loc24_,_loc28_);
                              si32(_loc25_,_loc28_ + 1);
                              _loc24_ = _loc26_ + 1;
                              _loc25_ = int(_loc27_);
                              _loc30_ = int(li32(_loc25_));
                              si32(_loc30_,_loc20_.hashScratchAddr);
                              _loc30_ = int(li32(_loc25_ + 4));
                              si32(_loc30_,_loc20_.hashScratchAddr + 4);
                              si32(0,_loc20_.hashScratchAddr + _loc24_);
                              _loc30_ = 775236557;
                              _loc31_ = -862048943;
                              _loc32_ = 461845907;
                              _loc33_ = li32(_loc20_.hashScratchAddr) * _loc31_;
                              _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                              _loc30_ ^= _loc33_ * _loc32_;
                              _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                              _loc30_ = _loc30_ * 5 + -430675100;
                              _loc33_ = li32(_loc20_.hashScratchAddr + 4) * _loc31_;
                              _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                              _loc30_ ^= _loc33_ * _loc32_;
                              _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                              _loc30_ = _loc30_ * 5 + -430675100;
                              _loc34_ = _loc30_ ^ _loc24_;
                              _loc34_ ^= _loc34_ >>> 16;
                              _loc34_ *= -2048144789;
                              _loc34_ ^= _loc34_ >>> 13;
                              _loc34_ *= -1028477387;
                              _loc29_ = (_loc34_ ^ _loc34_ >>> 16) & 65535;
                              _loc28_ = _loc20_.addr + _loc29_ * 5;
                              if((_loc26_ = int(li8(_loc28_))) < 8 && _loc26_ >= 0)
                              {
                                 _loc27_ = int(li32(_loc28_ + 1));
                                 si8(_loc24_,_loc28_);
                                 si32(_loc25_,_loc28_ + 1);
                                 _loc24_ = _loc26_ + 1;
                                 _loc25_ = int(_loc27_);
                                 _loc30_ = int(li32(_loc25_));
                                 si32(_loc30_,_loc20_.hashScratchAddr);
                                 _loc30_ = int(li32(_loc25_ + 4));
                                 si32(_loc30_,_loc20_.hashScratchAddr + 4);
                                 si32(0,_loc20_.hashScratchAddr + _loc24_);
                                 _loc30_ = 775236557;
                                 _loc31_ = -862048943;
                                 _loc32_ = 461845907;
                                 _loc33_ = li32(_loc20_.hashScratchAddr) * _loc31_;
                                 _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                                 _loc30_ ^= _loc33_ * _loc32_;
                                 _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                 _loc30_ = _loc30_ * 5 + -430675100;
                                 _loc33_ = li32(_loc20_.hashScratchAddr + 4) * _loc31_;
                                 _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                                 _loc30_ ^= _loc33_ * _loc32_;
                                 _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                 _loc30_ = _loc30_ * 5 + -430675100;
                                 _loc34_ = _loc30_ ^ _loc24_;
                                 _loc34_ ^= _loc34_ >>> 16;
                                 _loc34_ *= -2048144789;
                                 _loc34_ ^= _loc34_ >>> 13;
                                 _loc34_ *= -1028477387;
                                 _loc29_ = (_loc34_ ^ _loc34_ >>> 16) & 65535;
                                 _loc28_ = _loc20_.addr + _loc29_ * 5;
                              }
                           }
                           si8(_loc24_,_loc28_);
                           si32(_loc25_,_loc28_ + 1);
                        }
                     }
                     _loc20_.resultAddr = _loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7);
                     _loc19_ = _loc11_ + _loc17_;
                     _loc24_ = 775236557;
                     _loc25_ = -862048943;
                     _loc26_ = 461845907;
                     _loc27_ = li32(_loc19_) * _loc25_;
                     _loc27_ = _loc27_ << 15 | _loc27_ >>> 17;
                     _loc24_ ^= _loc27_ * _loc26_;
                     _loc24_ = _loc24_ << 13 | _loc24_ >>> 19;
                     _loc24_ = _loc24_ * 5 + -430675100;
                     _loc28_ = _loc24_ ^ 4;
                     _loc28_ ^= _loc28_ >>> 16;
                     _loc28_ *= -2048144789;
                     _loc28_ ^= _loc28_ >>> 13;
                     _loc28_ *= -1028477387;
                     _loc23_ = (_loc28_ ^ _loc28_ >>> 16) & 65535;
                     _loc22_ = _loc20_.addr + _loc23_ * 5;
                     _loc23_ = 3;
                     _loc24_ = -1;
                     _loc26_ = int(li32(_loc22_ + 1));
                     if(_loc26_ >= 0 && li32(_loc19_) == li32(_loc26_) && _loc19_ - _loc26_ <= _loc20_.windowSize)
                     {
                        _loc27_ = _loc19_ + 4;
                        _loc25_ = 4;
                        _loc26_ += 4;
                        while(li32(_loc26_) == li32(_loc27_) && _loc25_ + 4 <= _loc20_.maxMatchLength)
                        {
                           _loc25_ += 4;
                           _loc26_ += 4;
                           _loc27_ += 4;
                        }
                        while(li8(_loc26_) == li8(_loc27_) && _loc25_ < _loc20_.maxMatchLength)
                        {
                           _loc25_++;
                           _loc26_++;
                           _loc27_++;
                        }
                        _loc23_ = int(_loc25_);
                        _loc24_ = int(_loc26_);
                     }
                     _loc28_ = 5;
                     _loc29_ = 9;
                     while(_loc28_ < _loc29_)
                     {
                        _loc30_ = int(_loc28_++);
                        _loc33_ = int(li32(_loc19_));
                        si32(_loc33_,_loc20_.hashScratchAddr);
                        _loc33_ = int(li32(_loc19_ + 4));
                        si32(_loc33_,_loc20_.hashScratchAddr + 4);
                        si32(0,_loc20_.hashScratchAddr + _loc30_);
                        _loc33_ = 775236557;
                        _loc34_ = -862048943;
                        _loc35_ = 461845907;
                        _loc36_ = li32(_loc20_.hashScratchAddr) * _loc34_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc33_ ^= _loc36_ * _loc35_;
                        _loc33_ = _loc33_ << 13 | _loc33_ >>> 19;
                        _loc33_ = _loc33_ * 5 + -430675100;
                        _loc36_ = li32(_loc20_.hashScratchAddr + 4) * _loc34_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc33_ ^= _loc36_ * _loc35_;
                        _loc33_ = _loc33_ << 13 | _loc33_ >>> 19;
                        _loc33_ = _loc33_ * 5 + -430675100;
                        _loc37_ = _loc33_ ^ _loc30_;
                        _loc37_ ^= _loc37_ >>> 16;
                        _loc37_ *= -2048144789;
                        _loc37_ ^= _loc37_ >>> 13;
                        _loc37_ *= -1028477387;
                        _loc32_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                        _loc31_ = _loc20_.addr + _loc32_ * 5 + 1;
                        _loc26_ = int(li32(_loc31_));
                        if(_loc26_ >= 0 && li32(_loc26_ + _loc23_ - 3) == li32(_loc19_ + _loc23_ - 3) && li32(_loc19_) == li32(_loc26_) && _loc19_ - _loc26_ <= _loc20_.windowSize)
                        {
                           _loc27_ = _loc19_ + 4;
                           _loc25_ = 4;
                           _loc26_ += 4;
                           while(li32(_loc26_) == li32(_loc27_) && _loc25_ + 4 <= _loc20_.maxMatchLength)
                           {
                              _loc25_ += 4;
                              _loc26_ += 4;
                              _loc27_ += 4;
                           }
                           while(li8(_loc26_) == li8(_loc27_) && _loc25_ < _loc20_.maxMatchLength)
                           {
                              _loc25_++;
                              _loc26_++;
                              _loc27_++;
                           }
                           if(_loc25_ > _loc23_)
                           {
                              _loc23_ = int(_loc25_);
                              _loc24_ = int(_loc26_);
                           }
                        }
                     }
                     si32(_loc19_ - (_loc24_ - _loc23_) << 16 | _loc23_,_loc20_.resultAddr);
                     _loc23_ = int(_loc22_);
                     _loc24_ = 4;
                     _loc25_ = int(_loc19_);
                     if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                     {
                        _loc27_ = int(li32(_loc23_ + 1));
                        si8(_loc24_,_loc23_);
                        si32(_loc25_,_loc23_ + 1);
                        _loc24_ = _loc26_ + 1;
                        _loc25_ = int(_loc27_);
                        _loc29_ = int(li32(_loc25_));
                        si32(_loc29_,_loc20_.hashScratchAddr);
                        _loc29_ = int(li32(_loc25_ + 4));
                        si32(_loc29_,_loc20_.hashScratchAddr + 4);
                        si32(0,_loc20_.hashScratchAddr + _loc24_);
                        _loc29_ = 775236557;
                        _loc30_ = -862048943;
                        _loc31_ = 461845907;
                        _loc32_ = li32(_loc20_.hashScratchAddr) * _loc30_;
                        _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                        _loc29_ ^= _loc32_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc32_ = li32(_loc20_.hashScratchAddr + 4) * _loc30_;
                        _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                        _loc29_ ^= _loc32_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc33_ = _loc29_ ^ _loc24_;
                        _loc33_ ^= _loc33_ >>> 16;
                        _loc33_ *= -2048144789;
                        _loc33_ ^= _loc33_ >>> 13;
                        _loc33_ *= -1028477387;
                        _loc28_ = (_loc33_ ^ _loc33_ >>> 16) & 65535;
                        _loc23_ = _loc20_.addr + _loc28_ * 5;
                        if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                        {
                           _loc27_ = int(li32(_loc23_ + 1));
                           si8(_loc24_,_loc23_);
                           si32(_loc25_,_loc23_ + 1);
                           _loc24_ = _loc26_ + 1;
                           _loc25_ = int(_loc27_);
                           _loc29_ = int(li32(_loc25_));
                           si32(_loc29_,_loc20_.hashScratchAddr);
                           _loc29_ = int(li32(_loc25_ + 4));
                           si32(_loc29_,_loc20_.hashScratchAddr + 4);
                           si32(0,_loc20_.hashScratchAddr + _loc24_);
                           _loc29_ = 775236557;
                           _loc30_ = -862048943;
                           _loc31_ = 461845907;
                           _loc32_ = li32(_loc20_.hashScratchAddr) * _loc30_;
                           _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                           _loc29_ ^= _loc32_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc32_ = li32(_loc20_.hashScratchAddr + 4) * _loc30_;
                           _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                           _loc29_ ^= _loc32_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc33_ = _loc29_ ^ _loc24_;
                           _loc33_ ^= _loc33_ >>> 16;
                           _loc33_ *= -2048144789;
                           _loc33_ ^= _loc33_ >>> 13;
                           _loc33_ *= -1028477387;
                           _loc28_ = (_loc33_ ^ _loc33_ >>> 16) & 65535;
                           _loc23_ = _loc20_.addr + _loc28_ * 5;
                           if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                           {
                              _loc27_ = int(li32(_loc23_ + 1));
                              si8(_loc24_,_loc23_);
                              si32(_loc25_,_loc23_ + 1);
                              _loc24_ = _loc26_ + 1;
                              _loc25_ = int(_loc27_);
                              _loc29_ = int(li32(_loc25_));
                              si32(_loc29_,_loc20_.hashScratchAddr);
                              _loc29_ = int(li32(_loc25_ + 4));
                              si32(_loc29_,_loc20_.hashScratchAddr + 4);
                              si32(0,_loc20_.hashScratchAddr + _loc24_);
                              _loc29_ = 775236557;
                              _loc30_ = -862048943;
                              _loc31_ = 461845907;
                              _loc32_ = li32(_loc20_.hashScratchAddr) * _loc30_;
                              _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                              _loc29_ ^= _loc32_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc32_ = li32(_loc20_.hashScratchAddr + 4) * _loc30_;
                              _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                              _loc29_ ^= _loc32_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc33_ = _loc29_ ^ _loc24_;
                              _loc33_ ^= _loc33_ >>> 16;
                              _loc33_ *= -2048144789;
                              _loc33_ ^= _loc33_ >>> 13;
                              _loc33_ *= -1028477387;
                              _loc28_ = (_loc33_ ^ _loc33_ >>> 16) & 65535;
                              _loc23_ = _loc20_.addr + _loc28_ * 5;
                              if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                              {
                                 _loc27_ = int(li32(_loc23_ + 1));
                                 si8(_loc24_,_loc23_);
                                 si32(_loc25_,_loc23_ + 1);
                                 _loc24_ = _loc26_ + 1;
                                 _loc25_ = int(_loc27_);
                                 _loc29_ = int(li32(_loc25_));
                                 si32(_loc29_,_loc20_.hashScratchAddr);
                                 _loc29_ = int(li32(_loc25_ + 4));
                                 si32(_loc29_,_loc20_.hashScratchAddr + 4);
                                 si32(0,_loc20_.hashScratchAddr + _loc24_);
                                 _loc29_ = 775236557;
                                 _loc30_ = -862048943;
                                 _loc31_ = 461845907;
                                 _loc32_ = li32(_loc20_.hashScratchAddr) * _loc30_;
                                 _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                                 _loc29_ ^= _loc32_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc32_ = li32(_loc20_.hashScratchAddr + 4) * _loc30_;
                                 _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                                 _loc29_ ^= _loc32_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc33_ = _loc29_ ^ _loc24_;
                                 _loc33_ ^= _loc33_ >>> 16;
                                 _loc33_ *= -2048144789;
                                 _loc33_ ^= _loc33_ >>> 13;
                                 _loc33_ *= -1028477387;
                                 _loc28_ = (_loc33_ ^ _loc33_ >>> 16) & 65535;
                                 _loc23_ = _loc20_.addr + _loc28_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc24_,_loc23_);
                     si32(_loc25_,_loc23_ + 1);
                     _loc20_.resultAddr = _loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7);
                  }
               }
               if(li16(_loc20_.resultAddr) >= 4)
               {
                  _loc7_ = li16(_loc20_.resultAddr);
                  _loc17_ = int(li16(scratchAddr + 2492 + (_loc7_ << 2) + 2));
                  _loc18_ = 0;
                  _loc19_ = scratchAddr + _loc18_ + (_loc17_ << 2);
                  _loc22_ = li32(_loc19_) + 1;
                  si32(_loc22_,_loc19_);
                  _loc17_ = int(li16(_loc20_.resultAddr + 2));
                  _loc9_ = li32(scratchAddr + 3528 + ((_loc17_ <= 256 ? _loc17_ : 256 + (_loc17_ - 1 >>> 7)) << 2));
                  _loc17_ = scratchAddr + 1144 + (_loc9_ >>> 24 << 2);
                  _loc18_ = li32(_loc17_) + 1;
                  si32(_loc18_,_loc17_);
                  _loc17_ = li32(_loc20_.resultAddr) | 512;
                  si32(_loc17_,_loc16_);
                  _loc16_ += 4;
                  _loc11_ += _loc7_;
               }
               else
               {
                  _loc6_ = li8(_loc11_);
                  si16(_loc6_,_loc16_);
                  _loc17_ = 0;
                  _loc18_ = scratchAddr + _loc17_ + (_loc6_ << 2);
                  _loc19_ = li32(_loc18_) + 1;
                  si32(_loc19_,_loc18_);
                  _loc16_ += 2;
                  _loc11_++;
               }
            }
            while(_loc11_ < _loc5_)
            {
               _loc22_ = 775236557;
               _loc23_ = -862048943;
               _loc24_ = 461845907;
               _loc25_ = li32(_loc11_ + 1) * _loc23_;
               _loc25_ = _loc25_ << 15 | _loc25_ >>> 17;
               _loc22_ ^= _loc25_ * _loc24_;
               _loc22_ = _loc22_ << 13 | _loc22_ >>> 19;
               _loc22_ = _loc22_ * 5 + -430675100;
               _loc26_ = _loc22_ ^ 4;
               _loc26_ ^= _loc26_ >>> 16;
               _loc26_ *= -2048144789;
               _loc26_ ^= _loc26_ >>> 13;
               _loc26_ *= -1028477387;
               _loc19_ = (_loc26_ ^ _loc26_ >>> 16) & 65535;
               _loc18_ = _loc20_.addr + _loc19_ * 5;
               if(li16(_loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7)) < _loc20_.avgMatchLength + 4)
               {
                  _loc19_ = _loc11_ + 1;
                  _loc22_ = 3;
                  _loc23_ = -1;
                  _loc25_ = int(li32(_loc18_ + 1));
                  if(_loc25_ >= 0 && li32(_loc19_) == li32(_loc25_) && _loc19_ - _loc25_ <= _loc20_.windowSize)
                  {
                     _loc26_ = _loc19_ + 4;
                     _loc24_ = 4;
                     _loc25_ += 4;
                     while(_loc26_ + 4 <= _loc3_ && li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc20_.maxMatchLength)
                     {
                        _loc24_ += 4;
                        _loc25_ += 4;
                        _loc26_ += 4;
                     }
                     while(_loc26_ < _loc3_ && li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc20_.maxMatchLength)
                     {
                        _loc24_++;
                        _loc25_++;
                        _loc26_++;
                     }
                     _loc22_ = int(_loc24_);
                     _loc23_ = int(_loc25_);
                  }
                  _loc27_ = 5;
                  _loc28_ = 9;
                  while(_loc27_ < _loc28_)
                  {
                     _loc29_ = int(_loc27_++);
                     _loc32_ = int(li32(_loc19_));
                     si32(_loc32_,_loc20_.hashScratchAddr);
                     _loc32_ = int(li32(_loc19_ + 4));
                     si32(_loc32_,_loc20_.hashScratchAddr + 4);
                     si32(0,_loc20_.hashScratchAddr + _loc29_);
                     _loc32_ = 775236557;
                     _loc33_ = -862048943;
                     _loc34_ = 461845907;
                     _loc35_ = li32(_loc20_.hashScratchAddr) * _loc33_;
                     _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                     _loc32_ ^= _loc35_ * _loc34_;
                     _loc32_ = _loc32_ << 13 | _loc32_ >>> 19;
                     _loc32_ = _loc32_ * 5 + -430675100;
                     _loc35_ = li32(_loc20_.hashScratchAddr + 4) * _loc33_;
                     _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                     _loc32_ ^= _loc35_ * _loc34_;
                     _loc32_ = _loc32_ << 13 | _loc32_ >>> 19;
                     _loc32_ = _loc32_ * 5 + -430675100;
                     _loc36_ = _loc32_ ^ _loc29_;
                     _loc36_ ^= _loc36_ >>> 16;
                     _loc36_ *= -2048144789;
                     _loc36_ ^= _loc36_ >>> 13;
                     _loc36_ *= -1028477387;
                     _loc31_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                     _loc30_ = _loc20_.addr + _loc31_ * 5 + 1;
                     _loc25_ = int(li32(_loc30_));
                     if(_loc25_ >= 0 && li32(_loc19_) == li32(_loc25_) && _loc19_ - _loc25_ <= _loc20_.windowSize)
                     {
                        _loc26_ = _loc19_ + 4;
                        _loc24_ = 4;
                        _loc25_ += 4;
                        while(_loc26_ + 4 <= _loc3_ && li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc20_.maxMatchLength)
                        {
                           _loc24_ += 4;
                           _loc25_ += 4;
                           _loc26_ += 4;
                        }
                        while(_loc26_ < _loc3_ && li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc20_.maxMatchLength)
                        {
                           _loc24_++;
                           _loc25_++;
                           _loc26_++;
                        }
                        if(_loc24_ > _loc22_)
                        {
                           _loc22_ = int(_loc24_);
                           _loc23_ = int(_loc25_);
                        }
                     }
                  }
                  si32(_loc19_ - (_loc23_ - _loc22_) << 16 | _loc22_,_loc20_.resultAddr);
               }
               else
               {
                  si32(0,_loc20_.resultAddr);
               }
               _loc19_ = int(_loc18_);
               _loc22_ = 4;
               _loc23_ = _loc11_ + 1;
               if((_loc24_ = int(li8(_loc19_))) < 8 && _loc24_ >= 0)
               {
                  _loc25_ = int(li32(_loc19_ + 1));
                  si8(_loc22_,_loc19_);
                  si32(_loc23_,_loc19_ + 1);
                  _loc22_ = _loc24_ + 1;
                  _loc23_ = int(_loc25_);
                  _loc27_ = int(li32(_loc23_));
                  si32(_loc27_,_loc20_.hashScratchAddr);
                  _loc27_ = int(li32(_loc23_ + 4));
                  si32(_loc27_,_loc20_.hashScratchAddr + 4);
                  si32(0,_loc20_.hashScratchAddr + _loc22_);
                  _loc27_ = 775236557;
                  _loc28_ = -862048943;
                  _loc29_ = 461845907;
                  _loc30_ = li32(_loc20_.hashScratchAddr) * _loc28_;
                  _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                  _loc27_ ^= _loc30_ * _loc29_;
                  _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                  _loc27_ = _loc27_ * 5 + -430675100;
                  _loc30_ = li32(_loc20_.hashScratchAddr + 4) * _loc28_;
                  _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                  _loc27_ ^= _loc30_ * _loc29_;
                  _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                  _loc27_ = _loc27_ * 5 + -430675100;
                  _loc31_ = _loc27_ ^ _loc22_;
                  _loc31_ ^= _loc31_ >>> 16;
                  _loc31_ *= -2048144789;
                  _loc31_ ^= _loc31_ >>> 13;
                  _loc31_ *= -1028477387;
                  _loc26_ = (_loc31_ ^ _loc31_ >>> 16) & 65535;
                  _loc19_ = _loc20_.addr + _loc26_ * 5;
                  if((_loc24_ = int(li8(_loc19_))) < 8 && _loc24_ >= 0)
                  {
                     _loc25_ = int(li32(_loc19_ + 1));
                     si8(_loc22_,_loc19_);
                     si32(_loc23_,_loc19_ + 1);
                     _loc22_ = _loc24_ + 1;
                     _loc23_ = int(_loc25_);
                     _loc27_ = int(li32(_loc23_));
                     si32(_loc27_,_loc20_.hashScratchAddr);
                     _loc27_ = int(li32(_loc23_ + 4));
                     si32(_loc27_,_loc20_.hashScratchAddr + 4);
                     si32(0,_loc20_.hashScratchAddr + _loc22_);
                     _loc27_ = 775236557;
                     _loc28_ = -862048943;
                     _loc29_ = 461845907;
                     _loc30_ = li32(_loc20_.hashScratchAddr) * _loc28_;
                     _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                     _loc27_ ^= _loc30_ * _loc29_;
                     _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                     _loc27_ = _loc27_ * 5 + -430675100;
                     _loc30_ = li32(_loc20_.hashScratchAddr + 4) * _loc28_;
                     _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                     _loc27_ ^= _loc30_ * _loc29_;
                     _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                     _loc27_ = _loc27_ * 5 + -430675100;
                     _loc31_ = _loc27_ ^ _loc22_;
                     _loc31_ ^= _loc31_ >>> 16;
                     _loc31_ *= -2048144789;
                     _loc31_ ^= _loc31_ >>> 13;
                     _loc31_ *= -1028477387;
                     _loc26_ = (_loc31_ ^ _loc31_ >>> 16) & 65535;
                     _loc19_ = _loc20_.addr + _loc26_ * 5;
                     if((_loc24_ = int(li8(_loc19_))) < 8 && _loc24_ >= 0)
                     {
                        _loc25_ = int(li32(_loc19_ + 1));
                        si8(_loc22_,_loc19_);
                        si32(_loc23_,_loc19_ + 1);
                        _loc22_ = _loc24_ + 1;
                        _loc23_ = int(_loc25_);
                        _loc27_ = int(li32(_loc23_));
                        si32(_loc27_,_loc20_.hashScratchAddr);
                        _loc27_ = int(li32(_loc23_ + 4));
                        si32(_loc27_,_loc20_.hashScratchAddr + 4);
                        si32(0,_loc20_.hashScratchAddr + _loc22_);
                        _loc27_ = 775236557;
                        _loc28_ = -862048943;
                        _loc29_ = 461845907;
                        _loc30_ = li32(_loc20_.hashScratchAddr) * _loc28_;
                        _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                        _loc27_ ^= _loc30_ * _loc29_;
                        _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                        _loc27_ = _loc27_ * 5 + -430675100;
                        _loc30_ = li32(_loc20_.hashScratchAddr + 4) * _loc28_;
                        _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                        _loc27_ ^= _loc30_ * _loc29_;
                        _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                        _loc27_ = _loc27_ * 5 + -430675100;
                        _loc31_ = _loc27_ ^ _loc22_;
                        _loc31_ ^= _loc31_ >>> 16;
                        _loc31_ *= -2048144789;
                        _loc31_ ^= _loc31_ >>> 13;
                        _loc31_ *= -1028477387;
                        _loc26_ = (_loc31_ ^ _loc31_ >>> 16) & 65535;
                        _loc19_ = _loc20_.addr + _loc26_ * 5;
                        if((_loc24_ = int(li8(_loc19_))) < 8 && _loc24_ >= 0)
                        {
                           _loc25_ = int(li32(_loc19_ + 1));
                           si8(_loc22_,_loc19_);
                           si32(_loc23_,_loc19_ + 1);
                           _loc22_ = _loc24_ + 1;
                           _loc23_ = int(_loc25_);
                           _loc27_ = int(li32(_loc23_));
                           si32(_loc27_,_loc20_.hashScratchAddr);
                           _loc27_ = int(li32(_loc23_ + 4));
                           si32(_loc27_,_loc20_.hashScratchAddr + 4);
                           si32(0,_loc20_.hashScratchAddr + _loc22_);
                           _loc27_ = 775236557;
                           _loc28_ = -862048943;
                           _loc29_ = 461845907;
                           _loc30_ = li32(_loc20_.hashScratchAddr) * _loc28_;
                           _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                           _loc27_ ^= _loc30_ * _loc29_;
                           _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                           _loc27_ = _loc27_ * 5 + -430675100;
                           _loc30_ = li32(_loc20_.hashScratchAddr + 4) * _loc28_;
                           _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                           _loc27_ ^= _loc30_ * _loc29_;
                           _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                           _loc27_ = _loc27_ * 5 + -430675100;
                           _loc31_ = _loc27_ ^ _loc22_;
                           _loc31_ ^= _loc31_ >>> 16;
                           _loc31_ *= -2048144789;
                           _loc31_ ^= _loc31_ >>> 13;
                           _loc31_ *= -1028477387;
                           _loc26_ = (_loc31_ ^ _loc31_ >>> 16) & 65535;
                           _loc19_ = _loc20_.addr + _loc26_ * 5;
                        }
                     }
                  }
               }
               si8(_loc22_,_loc19_);
               si32(_loc23_,_loc19_ + 1);
               _loc20_.resultAddr = _loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7);
               if(li16(_loc20_.resultAddr) >= 4)
               {
                  _loc17_ = int(li16(_loc20_.resultAddr));
                  if(li16(_loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7)) > _loc17_)
                  {
                     si32(0,_loc20_.resultAddr);
                  }
                  else if(_loc11_ + _loc17_ + 9 < _loc3_)
                  {
                     if(_loc17_ < _loc20_.avgMatchLength + 4)
                     {
                        _loc19_ = _loc11_ + 1 + 1;
                        _loc22_ = _loc11_ + _loc17_;
                        while(_loc19_ < _loc22_)
                        {
                           _loc23_ = int(_loc19_++);
                           _loc24_ = 4;
                           _loc25_ = int(_loc23_);
                           _loc30_ = 775236557;
                           _loc31_ = -862048943;
                           _loc32_ = 461845907;
                           _loc33_ = li32(_loc23_) * _loc31_;
                           _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                           _loc30_ ^= _loc33_ * _loc32_;
                           _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                           _loc30_ = _loc30_ * 5 + -430675100;
                           _loc34_ = _loc30_ ^ 4;
                           _loc34_ ^= _loc34_ >>> 16;
                           _loc34_ *= -2048144789;
                           _loc34_ ^= _loc34_ >>> 13;
                           _loc34_ *= -1028477387;
                           _loc29_ = (_loc34_ ^ _loc34_ >>> 16) & 65535;
                           _loc28_ = _loc20_.addr + _loc29_ * 5;
                           if((_loc26_ = int(li8(_loc28_))) < 8 && _loc26_ >= 0)
                           {
                              _loc27_ = int(li32(_loc28_ + 1));
                              si8(_loc24_,_loc28_);
                              si32(_loc25_,_loc28_ + 1);
                              _loc24_ = _loc26_ + 1;
                              _loc25_ = int(_loc27_);
                              _loc30_ = int(li32(_loc25_));
                              si32(_loc30_,_loc20_.hashScratchAddr);
                              _loc30_ = int(li32(_loc25_ + 4));
                              si32(_loc30_,_loc20_.hashScratchAddr + 4);
                              si32(0,_loc20_.hashScratchAddr + _loc24_);
                              _loc30_ = 775236557;
                              _loc31_ = -862048943;
                              _loc32_ = 461845907;
                              _loc33_ = li32(_loc20_.hashScratchAddr) * _loc31_;
                              _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                              _loc30_ ^= _loc33_ * _loc32_;
                              _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                              _loc30_ = _loc30_ * 5 + -430675100;
                              _loc33_ = li32(_loc20_.hashScratchAddr + 4) * _loc31_;
                              _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                              _loc30_ ^= _loc33_ * _loc32_;
                              _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                              _loc30_ = _loc30_ * 5 + -430675100;
                              _loc34_ = _loc30_ ^ _loc24_;
                              _loc34_ ^= _loc34_ >>> 16;
                              _loc34_ *= -2048144789;
                              _loc34_ ^= _loc34_ >>> 13;
                              _loc34_ *= -1028477387;
                              _loc29_ = (_loc34_ ^ _loc34_ >>> 16) & 65535;
                              _loc28_ = _loc20_.addr + _loc29_ * 5;
                              if((_loc26_ = int(li8(_loc28_))) < 8 && _loc26_ >= 0)
                              {
                                 _loc27_ = int(li32(_loc28_ + 1));
                                 si8(_loc24_,_loc28_);
                                 si32(_loc25_,_loc28_ + 1);
                                 _loc24_ = _loc26_ + 1;
                                 _loc25_ = int(_loc27_);
                                 _loc30_ = int(li32(_loc25_));
                                 si32(_loc30_,_loc20_.hashScratchAddr);
                                 _loc30_ = int(li32(_loc25_ + 4));
                                 si32(_loc30_,_loc20_.hashScratchAddr + 4);
                                 si32(0,_loc20_.hashScratchAddr + _loc24_);
                                 _loc30_ = 775236557;
                                 _loc31_ = -862048943;
                                 _loc32_ = 461845907;
                                 _loc33_ = li32(_loc20_.hashScratchAddr) * _loc31_;
                                 _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                                 _loc30_ ^= _loc33_ * _loc32_;
                                 _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                 _loc30_ = _loc30_ * 5 + -430675100;
                                 _loc33_ = li32(_loc20_.hashScratchAddr + 4) * _loc31_;
                                 _loc33_ = _loc33_ << 15 | _loc33_ >>> 17;
                                 _loc30_ ^= _loc33_ * _loc32_;
                                 _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                 _loc30_ = _loc30_ * 5 + -430675100;
                                 _loc34_ = _loc30_ ^ _loc24_;
                                 _loc34_ ^= _loc34_ >>> 16;
                                 _loc34_ *= -2048144789;
                                 _loc34_ ^= _loc34_ >>> 13;
                                 _loc34_ *= -1028477387;
                                 _loc29_ = (_loc34_ ^ _loc34_ >>> 16) & 65535;
                                 _loc28_ = _loc20_.addr + _loc29_ * 5;
                              }
                           }
                           si8(_loc24_,_loc28_);
                           si32(_loc25_,_loc28_ + 1);
                        }
                     }
                     _loc20_.resultAddr = _loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7);
                     _loc19_ = _loc11_ + _loc17_;
                     _loc24_ = 775236557;
                     _loc25_ = -862048943;
                     _loc26_ = 461845907;
                     _loc27_ = li32(_loc19_) * _loc25_;
                     _loc27_ = _loc27_ << 15 | _loc27_ >>> 17;
                     _loc24_ ^= _loc27_ * _loc26_;
                     _loc24_ = _loc24_ << 13 | _loc24_ >>> 19;
                     _loc24_ = _loc24_ * 5 + -430675100;
                     _loc28_ = _loc24_ ^ 4;
                     _loc28_ ^= _loc28_ >>> 16;
                     _loc28_ *= -2048144789;
                     _loc28_ ^= _loc28_ >>> 13;
                     _loc28_ *= -1028477387;
                     _loc23_ = (_loc28_ ^ _loc28_ >>> 16) & 65535;
                     _loc22_ = _loc20_.addr + _loc23_ * 5;
                     _loc23_ = 3;
                     _loc24_ = -1;
                     _loc26_ = int(li32(_loc22_ + 1));
                     if(_loc26_ >= 0 && li32(_loc19_) == li32(_loc26_) && _loc19_ - _loc26_ <= _loc20_.windowSize)
                     {
                        _loc27_ = _loc19_ + 4;
                        _loc25_ = 4;
                        _loc26_ += 4;
                        while(_loc27_ + 4 <= _loc3_ && li32(_loc26_) == li32(_loc27_) && _loc25_ + 4 <= _loc20_.maxMatchLength)
                        {
                           _loc25_ += 4;
                           _loc26_ += 4;
                           _loc27_ += 4;
                        }
                        while(_loc27_ < _loc3_ && li8(_loc26_) == li8(_loc27_) && _loc25_ < _loc20_.maxMatchLength)
                        {
                           _loc25_++;
                           _loc26_++;
                           _loc27_++;
                        }
                        _loc23_ = int(_loc25_);
                        _loc24_ = int(_loc26_);
                     }
                     _loc28_ = 5;
                     _loc29_ = 9;
                     while(_loc28_ < _loc29_)
                     {
                        _loc30_ = int(_loc28_++);
                        _loc33_ = int(li32(_loc19_));
                        si32(_loc33_,_loc20_.hashScratchAddr);
                        _loc33_ = int(li32(_loc19_ + 4));
                        si32(_loc33_,_loc20_.hashScratchAddr + 4);
                        si32(0,_loc20_.hashScratchAddr + _loc30_);
                        _loc33_ = 775236557;
                        _loc34_ = -862048943;
                        _loc35_ = 461845907;
                        _loc36_ = li32(_loc20_.hashScratchAddr) * _loc34_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc33_ ^= _loc36_ * _loc35_;
                        _loc33_ = _loc33_ << 13 | _loc33_ >>> 19;
                        _loc33_ = _loc33_ * 5 + -430675100;
                        _loc36_ = li32(_loc20_.hashScratchAddr + 4) * _loc34_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc33_ ^= _loc36_ * _loc35_;
                        _loc33_ = _loc33_ << 13 | _loc33_ >>> 19;
                        _loc33_ = _loc33_ * 5 + -430675100;
                        _loc37_ = _loc33_ ^ _loc30_;
                        _loc37_ ^= _loc37_ >>> 16;
                        _loc37_ *= -2048144789;
                        _loc37_ ^= _loc37_ >>> 13;
                        _loc37_ *= -1028477387;
                        _loc32_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                        _loc31_ = _loc20_.addr + _loc32_ * 5 + 1;
                        _loc26_ = int(li32(_loc31_));
                        if(_loc26_ >= 0 && li32(_loc19_) == li32(_loc26_) && _loc19_ - _loc26_ <= _loc20_.windowSize)
                        {
                           _loc27_ = _loc19_ + 4;
                           _loc25_ = 4;
                           _loc26_ += 4;
                           while(_loc27_ + 4 <= _loc3_ && li32(_loc26_) == li32(_loc27_) && _loc25_ + 4 <= _loc20_.maxMatchLength)
                           {
                              _loc25_ += 4;
                              _loc26_ += 4;
                              _loc27_ += 4;
                           }
                           while(_loc27_ < _loc3_ && li8(_loc26_) == li8(_loc27_) && _loc25_ < _loc20_.maxMatchLength)
                           {
                              _loc25_++;
                              _loc26_++;
                              _loc27_++;
                           }
                           if(_loc25_ > _loc23_)
                           {
                              _loc23_ = int(_loc25_);
                              _loc24_ = int(_loc26_);
                           }
                        }
                     }
                     si32(_loc19_ - (_loc24_ - _loc23_) << 16 | _loc23_,_loc20_.resultAddr);
                     _loc23_ = int(_loc22_);
                     _loc24_ = 4;
                     _loc25_ = int(_loc19_);
                     if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                     {
                        _loc27_ = int(li32(_loc23_ + 1));
                        si8(_loc24_,_loc23_);
                        si32(_loc25_,_loc23_ + 1);
                        _loc24_ = _loc26_ + 1;
                        _loc25_ = int(_loc27_);
                        _loc29_ = int(li32(_loc25_));
                        si32(_loc29_,_loc20_.hashScratchAddr);
                        _loc29_ = int(li32(_loc25_ + 4));
                        si32(_loc29_,_loc20_.hashScratchAddr + 4);
                        si32(0,_loc20_.hashScratchAddr + _loc24_);
                        _loc29_ = 775236557;
                        _loc30_ = -862048943;
                        _loc31_ = 461845907;
                        _loc32_ = li32(_loc20_.hashScratchAddr) * _loc30_;
                        _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                        _loc29_ ^= _loc32_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc32_ = li32(_loc20_.hashScratchAddr + 4) * _loc30_;
                        _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                        _loc29_ ^= _loc32_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc33_ = _loc29_ ^ _loc24_;
                        _loc33_ ^= _loc33_ >>> 16;
                        _loc33_ *= -2048144789;
                        _loc33_ ^= _loc33_ >>> 13;
                        _loc33_ *= -1028477387;
                        _loc28_ = (_loc33_ ^ _loc33_ >>> 16) & 65535;
                        _loc23_ = _loc20_.addr + _loc28_ * 5;
                        if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                        {
                           _loc27_ = int(li32(_loc23_ + 1));
                           si8(_loc24_,_loc23_);
                           si32(_loc25_,_loc23_ + 1);
                           _loc24_ = _loc26_ + 1;
                           _loc25_ = int(_loc27_);
                           _loc29_ = int(li32(_loc25_));
                           si32(_loc29_,_loc20_.hashScratchAddr);
                           _loc29_ = int(li32(_loc25_ + 4));
                           si32(_loc29_,_loc20_.hashScratchAddr + 4);
                           si32(0,_loc20_.hashScratchAddr + _loc24_);
                           _loc29_ = 775236557;
                           _loc30_ = -862048943;
                           _loc31_ = 461845907;
                           _loc32_ = li32(_loc20_.hashScratchAddr) * _loc30_;
                           _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                           _loc29_ ^= _loc32_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc32_ = li32(_loc20_.hashScratchAddr + 4) * _loc30_;
                           _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                           _loc29_ ^= _loc32_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc33_ = _loc29_ ^ _loc24_;
                           _loc33_ ^= _loc33_ >>> 16;
                           _loc33_ *= -2048144789;
                           _loc33_ ^= _loc33_ >>> 13;
                           _loc33_ *= -1028477387;
                           _loc28_ = (_loc33_ ^ _loc33_ >>> 16) & 65535;
                           _loc23_ = _loc20_.addr + _loc28_ * 5;
                           if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                           {
                              _loc27_ = int(li32(_loc23_ + 1));
                              si8(_loc24_,_loc23_);
                              si32(_loc25_,_loc23_ + 1);
                              _loc24_ = _loc26_ + 1;
                              _loc25_ = int(_loc27_);
                              _loc29_ = int(li32(_loc25_));
                              si32(_loc29_,_loc20_.hashScratchAddr);
                              _loc29_ = int(li32(_loc25_ + 4));
                              si32(_loc29_,_loc20_.hashScratchAddr + 4);
                              si32(0,_loc20_.hashScratchAddr + _loc24_);
                              _loc29_ = 775236557;
                              _loc30_ = -862048943;
                              _loc31_ = 461845907;
                              _loc32_ = li32(_loc20_.hashScratchAddr) * _loc30_;
                              _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                              _loc29_ ^= _loc32_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc32_ = li32(_loc20_.hashScratchAddr + 4) * _loc30_;
                              _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                              _loc29_ ^= _loc32_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc33_ = _loc29_ ^ _loc24_;
                              _loc33_ ^= _loc33_ >>> 16;
                              _loc33_ *= -2048144789;
                              _loc33_ ^= _loc33_ >>> 13;
                              _loc33_ *= -1028477387;
                              _loc28_ = (_loc33_ ^ _loc33_ >>> 16) & 65535;
                              _loc23_ = _loc20_.addr + _loc28_ * 5;
                              if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                              {
                                 _loc27_ = int(li32(_loc23_ + 1));
                                 si8(_loc24_,_loc23_);
                                 si32(_loc25_,_loc23_ + 1);
                                 _loc24_ = _loc26_ + 1;
                                 _loc25_ = int(_loc27_);
                                 _loc29_ = int(li32(_loc25_));
                                 si32(_loc29_,_loc20_.hashScratchAddr);
                                 _loc29_ = int(li32(_loc25_ + 4));
                                 si32(_loc29_,_loc20_.hashScratchAddr + 4);
                                 si32(0,_loc20_.hashScratchAddr + _loc24_);
                                 _loc29_ = 775236557;
                                 _loc30_ = -862048943;
                                 _loc31_ = 461845907;
                                 _loc32_ = li32(_loc20_.hashScratchAddr) * _loc30_;
                                 _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                                 _loc29_ ^= _loc32_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc32_ = li32(_loc20_.hashScratchAddr + 4) * _loc30_;
                                 _loc32_ = _loc32_ << 15 | _loc32_ >>> 17;
                                 _loc29_ ^= _loc32_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc33_ = _loc29_ ^ _loc24_;
                                 _loc33_ ^= _loc33_ >>> 16;
                                 _loc33_ *= -2048144789;
                                 _loc33_ ^= _loc33_ >>> 13;
                                 _loc33_ *= -1028477387;
                                 _loc28_ = (_loc33_ ^ _loc33_ >>> 16) & 65535;
                                 _loc23_ = _loc20_.addr + _loc28_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc24_,_loc23_);
                     si32(_loc25_,_loc23_ + 1);
                     _loc20_.resultAddr = _loc20_.baseResultAddr + (_loc20_.resultAddr - _loc20_.baseResultAddr + 4 & 7);
                  }
               }
               if(li16(_loc20_.resultAddr) >= 4)
               {
                  _loc7_ = li16(_loc20_.resultAddr);
                  _loc17_ = int(li16(scratchAddr + 2492 + (_loc7_ << 2) + 2));
                  _loc18_ = 0;
                  _loc19_ = scratchAddr + _loc18_ + (_loc17_ << 2);
                  _loc22_ = li32(_loc19_) + 1;
                  si32(_loc22_,_loc19_);
                  _loc17_ = int(li16(_loc20_.resultAddr + 2));
                  _loc9_ = li32(scratchAddr + 3528 + ((_loc17_ <= 256 ? _loc17_ : 256 + (_loc17_ - 1 >>> 7)) << 2));
                  _loc17_ = scratchAddr + 1144 + (_loc9_ >>> 24 << 2);
                  _loc18_ = li32(_loc17_) + 1;
                  si32(_loc18_,_loc17_);
                  _loc17_ = li32(_loc20_.resultAddr) | 512;
                  si32(_loc17_,_loc16_);
                  _loc16_ += 4;
                  _loc11_ += _loc7_;
               }
               else
               {
                  _loc6_ = li8(_loc11_);
                  si16(_loc6_,_loc16_);
                  _loc17_ = 0;
                  _loc18_ = scratchAddr + _loc17_ + (_loc6_ << 2);
                  _loc19_ = li32(_loc18_) + 1;
                  si32(_loc19_,_loc18_);
                  _loc16_ += 2;
                  _loc11_++;
               }
            }
            while(_loc11_ < _loc3_)
            {
               _loc6_ = li8(_loc11_);
               si16(_loc6_,_loc16_);
               _loc17_ = 0;
               _loc18_ = scratchAddr + _loc17_ + (_loc6_ << 2);
               _loc19_ = li32(_loc18_) + 1;
               si32(_loc19_,_loc18_);
               _loc16_ += 2;
               _loc11_++;
            }
            _loc38_ = false;
            blockInProgress = true;
            if(level == CompressionLevel.UNCOMPRESSED)
            {
               if(bitOffset == 0)
               {
                  si8(0,currentAddr);
               }
               _loc17_ = int(li8(currentAddr));
               _loc17_ |= (!!_loc38_ ? 1 : 0) << bitOffset;
               si32(_loc17_,currentAddr);
               bitOffset += 3;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               if(bitOffset > 0)
               {
                  _loc17_ = int(li8(currentAddr));
                  _loc17_ |= 0 << bitOffset;
                  si32(_loc17_,currentAddr);
                  bitOffset += 8 - bitOffset;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
            }
            else
            {
               _loc17_ = int(li8(currentAddr));
               _loc17_ |= (4 | (!!_loc38_ ? 1 : 0)) << bitOffset;
               si32(_loc17_,currentAddr);
               bitOffset += 3;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
            blockStartAddr = currentAddr;
            createAndWriteHuffmanTrees(param1,_loc3_);
            _loc11_ = int(_loc15_);
            while(_loc11_ + 64 <= _loc16_)
            {
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
            }
            while(_loc11_ < _loc16_)
            {
               _loc23_ = int(li16(_loc11_));
               if((_loc23_ & 512) != 0)
               {
                  _loc17_ = _loc23_ ^ 512;
                  _loc19_ = int(li32(scratchAddr + 2492 + (_loc17_ << 2)));
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + (_loc19_ >>> 16) * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc17_ - (_loc19_ & 8191) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc19_ & 65280) >>> 13;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc18_ = int(li16(_loc11_ + 2));
                  _loc22_ = int(li32(scratchAddr + 3528 + ((_loc18_ <= 256 ? _loc18_ : 256 + (_loc18_ - 1 >>> 7)) << 2)));
                  _loc24_ = int(li32(scratchAddr + 1144 + (_loc22_ >>> 24) * 4));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc24_ = int(li8(currentAddr));
                  _loc24_ |= _loc18_ - (_loc22_ & 65535) << bitOffset;
                  si32(_loc24_,currentAddr);
                  bitOffset += (_loc22_ & 16711680) >>> 16;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               else
               {
                  _loc24_ = 0;
                  _loc25_ = int(li32(scratchAddr + _loc24_ + _loc23_ * 4));
                  _loc26_ = int(li8(currentAddr));
                  _loc26_ |= _loc25_ >>> 16 << bitOffset;
                  si32(_loc26_,currentAddr);
                  bitOffset += _loc25_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               _loc6_ = _loc23_;
               _loc11_ += 2 + ((_loc6_ & 512) >>> 8);
            }
            if(level != CompressionLevel.UNCOMPRESSED)
            {
               _loc17_ = 0;
               _loc18_ = int(li32(scratchAddr + _loc17_ + 1024));
               _loc19_ = int(li8(currentAddr));
               _loc19_ |= _loc18_ >>> 16 << bitOffset;
               si32(_loc19_,currentAddr);
               bitOffset += _loc18_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
            blockInProgress = false;
            param1 = _loc3_;
         }
      }
      
      public function _fastWriteFast(param1:int, param2:int) : void
      {
         var _loc5_:* = 0;
         var _loc6_:Boolean = false;
         var _loc7_:* = 0;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc3_:int = 2048;
         var _loc4_:int = param1;
         while(param2 - param1 > _loc3_)
         {
            _loc5_ = param1 + _loc3_;
            if(!blockInProgress)
            {
               _loc6_ = false;
               blockInProgress = true;
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  if(bitOffset == 0)
                  {
                     si8(0,currentAddr);
                  }
                  _loc7_ = int(li8(currentAddr));
                  _loc7_ |= (!!_loc6_ ? 1 : 0) << bitOffset;
                  si32(_loc7_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  if(bitOffset > 0)
                  {
                     _loc7_ = int(li8(currentAddr));
                     _loc7_ |= 0 << bitOffset;
                     si32(_loc7_,currentAddr);
                     bitOffset += 8 - bitOffset;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
               }
               else
               {
                  _loc7_ = int(li8(currentAddr));
                  _loc7_ |= (4 | (!!_loc6_ ? 1 : 0)) << bitOffset;
                  si32(_loc7_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockStartAddr = currentAddr;
               _loc8_ = Number(Math.min(param2,param1 + 98304));
               createAndWriteHuffmanTrees(param1,int(_loc8_));
            }
            while(_loc4_ < _loc5_)
            {
               _loc7_ = int(li8(_loc4_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
               _loc9_ = _loc4_;
               _loc7_ = int(li8(_loc9_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
            }
            param1 += _loc3_;
            if((!!blockInProgress ? currentAddr - blockStartAddr : 0) > 49152)
            {
               if(level != CompressionLevel.UNCOMPRESSED)
               {
                  _loc7_ = 0;
                  _loc9_ = li32(scratchAddr + _loc7_ + 1024);
                  _loc10_ = int(li8(currentAddr));
                  _loc10_ |= _loc9_ >>> 16 << bitOffset;
                  si32(_loc10_,currentAddr);
                  bitOffset += _loc9_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockInProgress = false;
            }
         }
         if(_loc4_ < param2)
         {
            if(!blockInProgress)
            {
               _loc6_ = false;
               blockInProgress = true;
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  if(bitOffset == 0)
                  {
                     si8(0,currentAddr);
                  }
                  _loc7_ = int(li8(currentAddr));
                  _loc7_ |= (!!_loc6_ ? 1 : 0) << bitOffset;
                  si32(_loc7_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  if(bitOffset > 0)
                  {
                     _loc7_ = int(li8(currentAddr));
                     _loc7_ |= 0 << bitOffset;
                     si32(_loc7_,currentAddr);
                     bitOffset += 8 - bitOffset;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
               }
               else
               {
                  _loc7_ = int(li8(currentAddr));
                  _loc7_ |= (4 | (!!_loc6_ ? 1 : 0)) << bitOffset;
                  si32(_loc7_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockStartAddr = currentAddr;
               createAndWriteHuffmanTrees(param1,param2);
            }
            while(_loc4_ < param2)
            {
               _loc7_ = int(li8(_loc4_));
               _loc9_ = 0;
               _loc10_ = int(li32(scratchAddr + _loc9_ + _loc7_ * 4));
               _loc11_ = int(li8(currentAddr));
               _loc11_ |= _loc10_ >>> 16 << bitOffset;
               si32(_loc11_,currentAddr);
               bitOffset += _loc10_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
               _loc4_++;
            }
            if((!!blockInProgress ? currentAddr - blockStartAddr : 0) > 49152)
            {
               if(level != CompressionLevel.UNCOMPRESSED)
               {
                  _loc7_ = 0;
                  _loc9_ = li32(scratchAddr + _loc7_ + 1024);
                  _loc10_ = int(li8(currentAddr));
                  _loc10_ |= _loc9_ >>> 16 << bitOffset;
                  si32(_loc10_,currentAddr);
                  bitOffset += _loc9_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockInProgress = false;
            }
         }
      }
      
      public function _fastWriteCompressed(param1:int, param2:int) : void
      {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:Boolean = false;
         var _loc11_:* = 0;
         var _loc12_:Number = NaN;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc30_:* = 0;
         var _loc34_:* = null as LZHash;
         var _loc35_:* = 0;
         var _loc36_:* = 0;
         var _loc37_:* = 0;
         var _loc38_:* = 0;
         var _loc39_:* = 0;
         var _loc40_:* = 0;
         var _loc41_:* = 0;
         var _loc42_:* = 0;
         var _loc3_:* = param2 - param1;
         var _loc4_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         _loc8_ = 1;
         _loc9_ = 0;
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            _loc7_ = 8;
            _loc6_ = int(Math.ceil(_loc3_ / 65535));
         }
         else
         {
            if(level == CompressionLevel.FAST)
            {
               _loc6_ = int(Math.ceil(_loc3_ * 2 / 49152));
            }
            else
            {
               _loc6_ = int(Math.ceil(_loc3_ / 98304));
               if(level == CompressionLevel.NORMAL)
               {
                  _loc9_ = 458752;
               }
               else if(level == CompressionLevel.GOOD)
               {
                  _loc9_ = 524308;
               }
            }
            _loc8_ = 2;
            _loc7_ = 300;
         }
         var _loc5_:uint = _loc3_ * _loc8_ + _loc7_ * (_loc6_ + 1) + _loc9_ + currentAddr;
         if(_loc5_ > _loc4_.length)
         {
            _loc8_ = 1;
            _loc9_ = 0;
            §§push(_loc4_);
            if(level == CompressionLevel.UNCOMPRESSED)
            {
               _loc7_ = 8;
               _loc6_ = int(Math.ceil(_loc3_ / 65535));
            }
            else
            {
               if(level == CompressionLevel.FAST)
               {
                  _loc6_ = int(Math.ceil(_loc3_ * 2 / 49152));
               }
               else
               {
                  _loc6_ = int(Math.ceil(_loc3_ / 98304));
                  if(level == CompressionLevel.NORMAL)
                  {
                     _loc9_ = 458752;
                  }
                  else if(level == CompressionLevel.GOOD)
                  {
                     _loc9_ = 524308;
                  }
               }
               _loc8_ = 2;
               _loc7_ = 300;
            }
            §§pop().length = _loc3_ * _loc8_ + _loc7_ * (_loc6_ + 1) + _loc9_ + currentAddr;
            ApplicationDomain.currentDomain.domainMemory = _loc4_;
         }
         if(zlib)
         {
            _loc6_ = int(param1);
            while(_loc6_ + 5552 <= param2)
            {
               _loc7_ = int(_loc6_);
               while(_loc7_ < _loc6_ + 5552)
               {
                  s2 += (s1 << 4) + li8(_loc7_) * 16 + li8(_loc7_ + 1) * 15 + li8(_loc7_ + 2) * 14 + li8(_loc7_ + 3) * 13 + li8(_loc7_ + 4) * 12 + li8(_loc7_ + 5) * 11 + li8(_loc7_ + 6) * 10 + li8(_loc7_ + 7) * 9 + li8(_loc7_ + 8) * 8 + li8(_loc7_ + 9) * 7 + li8(_loc7_ + 10) * 6 + li8(_loc7_ + 11) * 5 + li8(_loc7_ + 12) * 4 + li8(_loc7_ + 13) * 3 + li8(_loc7_ + 14) * 2 + li8(_loc7_ + 15);
                  s1 += li8(_loc7_) + li8(_loc7_ + 1) + li8(_loc7_ + 2) + li8(_loc7_ + 3) + li8(_loc7_ + 4) + li8(_loc7_ + 5) + li8(_loc7_ + 6) + li8(_loc7_ + 7) + li8(_loc7_ + 8) + li8(_loc7_ + 9) + li8(_loc7_ + 10) + li8(_loc7_ + 11) + li8(_loc7_ + 12) + li8(_loc7_ + 13) + li8(_loc7_ + 14) + li8(_loc7_ + 15);
                  _loc7_ += 16;
               }
               s1 %= 65521;
               s2 %= 65521;
               _loc6_ += 5552;
            }
            if(_loc6_ != param2)
            {
               _loc7_ = int(_loc6_);
               while(_loc7_ < param2)
               {
                  _loc8_ = int(_loc7_++);
                  s1 += li8(_loc8_);
                  s2 += s1;
               }
               s1 %= 65521;
               s2 %= 65521;
            }
         }
         if(level == CompressionLevel.FAST)
         {
            _loc6_ = int(param1);
            _loc7_ = 2048;
            _loc8_ = int(_loc6_);
            while(param2 - _loc6_ > _loc7_)
            {
               _loc9_ = _loc6_ + _loc7_;
               if(!blockInProgress)
               {
                  _loc10_ = false;
                  blockInProgress = true;
                  if(level == CompressionLevel.UNCOMPRESSED)
                  {
                     if(bitOffset == 0)
                     {
                        si8(0,currentAddr);
                     }
                     _loc11_ = int(li8(currentAddr));
                     _loc11_ |= (!!_loc10_ ? 1 : 0) << bitOffset;
                     si32(_loc11_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     if(bitOffset > 0)
                     {
                        _loc11_ = int(li8(currentAddr));
                        _loc11_ |= 0 << bitOffset;
                        si32(_loc11_,currentAddr);
                        bitOffset += 8 - bitOffset;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                  }
                  else
                  {
                     _loc11_ = int(li8(currentAddr));
                     _loc11_ |= (4 | (!!_loc10_ ? 1 : 0)) << bitOffset;
                     si32(_loc11_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockStartAddr = currentAddr;
                  _loc12_ = Number(Math.min(param2,_loc6_ + 98304));
                  createAndWriteHuffmanTrees(_loc6_,int(_loc12_));
               }
               while(_loc8_ < _loc9_)
               {
                  _loc11_ = int(li8(_loc8_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
                  _loc13_ = int(_loc8_);
                  _loc11_ = int(li8(_loc13_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
               }
               _loc6_ += _loc7_;
               if((!!blockInProgress ? currentAddr - blockStartAddr : 0) > 49152)
               {
                  if(level != CompressionLevel.UNCOMPRESSED)
                  {
                     _loc11_ = 0;
                     _loc13_ = int(li32(scratchAddr + _loc11_ + 1024));
                     _loc14_ = int(li8(currentAddr));
                     _loc14_ |= _loc13_ >>> 16 << bitOffset;
                     si32(_loc14_,currentAddr);
                     bitOffset += _loc13_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockInProgress = false;
               }
            }
            if(_loc8_ < param2)
            {
               if(!blockInProgress)
               {
                  _loc10_ = false;
                  blockInProgress = true;
                  if(level == CompressionLevel.UNCOMPRESSED)
                  {
                     if(bitOffset == 0)
                     {
                        si8(0,currentAddr);
                     }
                     _loc11_ = int(li8(currentAddr));
                     _loc11_ |= (!!_loc10_ ? 1 : 0) << bitOffset;
                     si32(_loc11_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     if(bitOffset > 0)
                     {
                        _loc11_ = int(li8(currentAddr));
                        _loc11_ |= 0 << bitOffset;
                        si32(_loc11_,currentAddr);
                        bitOffset += 8 - bitOffset;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                  }
                  else
                  {
                     _loc11_ = int(li8(currentAddr));
                     _loc11_ |= (4 | (!!_loc10_ ? 1 : 0)) << bitOffset;
                     si32(_loc11_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockStartAddr = currentAddr;
                  createAndWriteHuffmanTrees(_loc6_,param2);
               }
               while(_loc8_ < param2)
               {
                  _loc11_ = int(li8(_loc8_));
                  _loc13_ = 0;
                  _loc14_ = int(li32(scratchAddr + _loc13_ + _loc11_ * 4));
                  _loc15_ = int(li8(currentAddr));
                  _loc15_ |= _loc14_ >>> 16 << bitOffset;
                  si32(_loc15_,currentAddr);
                  bitOffset += _loc14_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  _loc8_++;
               }
               if((!!blockInProgress ? currentAddr - blockStartAddr : 0) > 49152)
               {
                  if(level != CompressionLevel.UNCOMPRESSED)
                  {
                     _loc11_ = 0;
                     _loc13_ = int(li32(scratchAddr + _loc11_ + 1024));
                     _loc14_ = int(li8(currentAddr));
                     _loc14_ |= _loc13_ >>> 16 << bitOffset;
                     si32(_loc14_,currentAddr);
                     bitOffset += _loc13_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockInProgress = false;
               }
            }
         }
         else if(level == CompressionLevel.NORMAL)
         {
            _loc6_ = int(param1);
            _loc21_ = param2 - _loc6_;
            _loc24_ = 1;
            _loc25_ = 0;
            §§push(currentAddr);
            if(level == CompressionLevel.UNCOMPRESSED)
            {
               _loc23_ = 8;
               _loc22_ = int(Math.ceil(_loc21_ / 65535));
            }
            else
            {
               if(level == CompressionLevel.FAST)
               {
                  _loc22_ = int(Math.ceil(_loc21_ * 2 / 49152));
               }
               else
               {
                  _loc22_ = int(Math.ceil(_loc21_ / 98304));
                  if(level == CompressionLevel.NORMAL)
                  {
                     _loc25_ = 458752;
                  }
                  else if(level == CompressionLevel.GOOD)
                  {
                     _loc25_ = 524308;
                  }
               }
               _loc24_ = 2;
               _loc23_ = 300;
            }
            _loc20_ = §§pop() + (_loc21_ * _loc24_ + _loc23_ * (_loc22_ + 1) + _loc25_) - 262144;
            _loc21_ = _loc20_ - 196608;
            _loc17_ = _loc20_ + 262144 - 32;
            while(_loc17_ >= _loc20_)
            {
               si32(-1,_loc17_);
               si32(-1,_loc17_ + 4);
               si32(-1,_loc17_ + 8);
               si32(-1,_loc17_ + 12);
               si32(-1,_loc17_ + 16);
               si32(-1,_loc17_ + 20);
               si32(-1,_loc17_ + 24);
               si32(-1,_loc17_ + 28);
               _loc17_ -= 32;
            }
            while(param2 - _loc6_ > 0)
            {
               _loc12_ = Number(Math.min(param2,_loc6_ + 98304));
               _loc7_ = int(_loc12_);
               _loc8_ = _loc7_ - 4;
               _loc23_ = 0;
               while(_loc23_ < 286)
               {
                  _loc24_ = int(_loc23_++);
                  si32(0,scratchAddr + (_loc24_ << 2));
               }
               _loc23_ = 0;
               while(_loc23_ < 30)
               {
                  _loc24_ = int(_loc23_++);
                  si32(0,scratchAddr + 1144 + (_loc24_ << 2));
               }
               _loc22_ = int(_loc21_);
               _loc17_ = int(_loc6_);
               while(_loc17_ < _loc8_)
               {
                  _loc23_ = 775236557;
                  _loc24_ = -862048943;
                  _loc25_ = 461845907;
                  _loc26_ = li32(_loc17_) * _loc24_;
                  _loc26_ = _loc26_ << 15 | _loc26_ >>> 17;
                  _loc23_ ^= _loc26_ * _loc25_;
                  _loc23_ = _loc23_ << 13 | _loc23_ >>> 19;
                  _loc23_ = _loc23_ * 5 + -430675100;
                  _loc27_ = _loc23_ ^ 4;
                  _loc27_ ^= _loc27_ >>> 16;
                  _loc27_ *= -2048144789;
                  _loc27_ ^= _loc27_ >>> 13;
                  _loc27_ *= -1028477387;
                  _loc15_ = ((_loc27_ ^ _loc27_ >>> 16) & 65535) << 2;
                  _loc18_ = int(li32(_loc20_ + _loc15_));
                  if(_loc18_ >= 0 && li32(_loc18_) == li32(_loc17_))
                  {
                     _loc11_ = 4;
                     _loc18_ += 4;
                     _loc19_ = _loc17_ + 4;
                     while(_loc19_ < _loc7_ && li8(_loc18_) == li8(_loc19_) && _loc11_ < 258)
                     {
                        _loc18_++;
                        _loc19_++;
                        _loc11_++;
                     }
                     si32(_loc17_,_loc20_ + _loc15_);
                     _loc13_ = _loc19_ - _loc18_;
                     if(_loc13_ <= 32768)
                     {
                        _loc23_ = int(li16(scratchAddr + 2492 + (_loc11_ << 2) + 2));
                        _loc24_ = 0;
                        _loc25_ = scratchAddr + _loc24_ + (_loc23_ << 2);
                        _loc26_ = li32(_loc25_) + 1;
                        si32(_loc26_,_loc25_);
                        _loc14_ = int(li32(scratchAddr + 3528 + ((_loc13_ <= 256 ? _loc13_ : 256 + (_loc13_ - 1 >>> 7)) << 2)));
                        _loc23_ = scratchAddr + 1144 + (_loc14_ >>> 24 << 2);
                        _loc24_ = li32(_loc23_) + 1;
                        si32(_loc24_,_loc23_);
                        si32(_loc11_ | 512 | _loc13_ << 16,_loc22_);
                        _loc22_ += 4;
                        _loc17_ += _loc11_;
                        if(_loc17_ < _loc8_)
                        {
                           _loc24_ = 775236557;
                           _loc25_ = -862048943;
                           _loc26_ = 461845907;
                           _loc27_ = li32(_loc17_ - 1) * _loc25_;
                           _loc27_ = _loc27_ << 15 | _loc27_ >>> 17;
                           _loc24_ ^= _loc27_ * _loc26_;
                           _loc24_ = _loc24_ << 13 | _loc24_ >>> 19;
                           _loc24_ = _loc24_ * 5 + -430675100;
                           _loc28_ = _loc24_ ^ 4;
                           _loc28_ ^= _loc28_ >>> 16;
                           _loc28_ *= -2048144789;
                           _loc28_ ^= _loc28_ >>> 13;
                           _loc28_ *= -1028477387;
                           _loc23_ = _loc20_ + (((_loc28_ ^ _loc28_ >>> 16) & 65535) << 2);
                           si32(_loc17_ - 1,_loc23_);
                        }
                     }
                     else
                     {
                        _loc9_ = int(li8(_loc17_));
                        si16(_loc9_,_loc22_);
                        _loc23_ = 0;
                        _loc24_ = scratchAddr + _loc23_ + (_loc9_ << 2);
                        _loc25_ = li32(_loc24_) + 1;
                        si32(_loc25_,_loc24_);
                        _loc22_ += 2;
                        _loc17_++;
                     }
                  }
                  else
                  {
                     _loc9_ = int(li8(_loc17_));
                     si16(_loc9_,_loc22_);
                     _loc23_ = 0;
                     _loc24_ = scratchAddr + _loc23_ + (_loc9_ << 2);
                     _loc25_ = li32(_loc24_) + 1;
                     si32(_loc25_,_loc24_);
                     si32(_loc17_,_loc20_ + _loc15_);
                     _loc22_ += 2;
                     _loc17_++;
                  }
               }
               while(_loc17_ < _loc7_)
               {
                  _loc9_ = int(li8(_loc17_));
                  si16(_loc9_,_loc22_);
                  _loc23_ = 0;
                  _loc24_ = scratchAddr + _loc23_ + (_loc9_ << 2);
                  _loc25_ = li32(_loc24_) + 1;
                  si32(_loc25_,_loc24_);
                  _loc22_ += 2;
                  _loc17_++;
               }
               _loc10_ = false;
               blockInProgress = true;
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  if(bitOffset == 0)
                  {
                     si8(0,currentAddr);
                  }
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= (!!_loc10_ ? 1 : 0) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  if(bitOffset > 0)
                  {
                     _loc23_ = int(li8(currentAddr));
                     _loc23_ |= 0 << bitOffset;
                     si32(_loc23_,currentAddr);
                     bitOffset += 8 - bitOffset;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
               }
               else
               {
                  _loc23_ = int(li8(currentAddr));
                  _loc23_ |= (4 | (!!_loc10_ ? 1 : 0)) << bitOffset;
                  si32(_loc23_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockStartAddr = currentAddr;
               createAndWriteHuffmanTrees(_loc6_,_loc7_);
               _loc17_ = int(_loc21_);
               while(_loc17_ + 64 <= _loc22_)
               {
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
               }
               while(_loc17_ < _loc22_)
               {
                  _loc27_ = int(li16(_loc17_));
                  if((_loc27_ & 512) != 0)
                  {
                     _loc23_ = _loc27_ ^ 512;
                     _loc25_ = int(li32(scratchAddr + 2492 + (_loc23_ << 2)));
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + (_loc25_ >>> 16) * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc23_ - (_loc25_ & 8191) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc25_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc24_ = int(li16(_loc17_ + 2));
                     _loc26_ = int(li32(scratchAddr + 3528 + ((_loc24_ <= 256 ? _loc24_ : 256 + (_loc24_ - 1 >>> 7)) << 2)));
                     _loc28_ = int(li32(scratchAddr + 1144 + (_loc26_ >>> 24) * 4));
                     _loc29_ = int(li8(currentAddr));
                     _loc29_ |= _loc28_ >>> 16 << bitOffset;
                     si32(_loc29_,currentAddr);
                     bitOffset += _loc28_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc28_ = int(li8(currentAddr));
                     _loc28_ |= _loc24_ - (_loc26_ & 65535) << bitOffset;
                     si32(_loc28_,currentAddr);
                     bitOffset += (_loc26_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc28_ = 0;
                     _loc29_ = int(li32(scratchAddr + _loc28_ + _loc27_ * 4));
                     _loc30_ = int(li8(currentAddr));
                     _loc30_ |= _loc29_ >>> 16 << bitOffset;
                     si32(_loc30_,currentAddr);
                     bitOffset += _loc29_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc9_ = int(_loc27_);
                  _loc17_ += 2 + ((_loc9_ & 512) >>> 8);
               }
               if(level != CompressionLevel.UNCOMPRESSED)
               {
                  _loc23_ = 0;
                  _loc24_ = int(li32(scratchAddr + _loc23_ + 1024));
                  _loc25_ = int(li8(currentAddr));
                  _loc25_ |= _loc24_ >>> 16 << bitOffset;
                  si32(_loc25_,currentAddr);
                  bitOffset += _loc24_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockInProgress = false;
               _loc6_ = int(_loc7_);
            }
         }
         else
         {
            if(level != CompressionLevel.GOOD)
            {
               throw new Error("Compression level not supported");
            }
            _loc6_ = int(param1);
            _loc18_ = param2 - _loc6_;
            _loc21_ = 1;
            _loc22_ = 0;
            §§push(currentAddr);
            if(level == CompressionLevel.UNCOMPRESSED)
            {
               _loc20_ = 8;
               _loc19_ = int(Math.ceil(_loc18_ / 65535));
            }
            else
            {
               if(level == CompressionLevel.FAST)
               {
                  _loc19_ = int(Math.ceil(_loc18_ * 2 / 49152));
               }
               else
               {
                  _loc19_ = int(Math.ceil(_loc18_ / 98304));
                  if(level == CompressionLevel.NORMAL)
                  {
                     _loc22_ = 458752;
                  }
                  else if(level == CompressionLevel.GOOD)
                  {
                     _loc22_ = 524308;
                  }
               }
               _loc21_ = 2;
               _loc20_ = 300;
            }
            _loc17_ = §§pop() + (_loc18_ * _loc21_ + _loc20_ * (_loc19_ + 1) + _loc22_) - 327700;
            _loc18_ = _loc17_ - 196608;
            _loc34_ = new LZHash(_loc17_,258,32768);
            while(param2 - _loc6_ > 0)
            {
               _loc12_ = Number(Math.min(param2,_loc6_ + 98304));
               _loc7_ = int(_loc12_);
               _loc9_ = _loc7_ - 9;
               _loc8_ = _loc9_ - 516 - 1;
               _loc20_ = 0;
               while(_loc20_ < 286)
               {
                  _loc21_ = int(_loc20_++);
                  si32(0,scratchAddr + (_loc21_ << 2));
               }
               _loc20_ = 0;
               while(_loc20_ < 30)
               {
                  _loc21_ = int(_loc20_++);
                  si32(0,scratchAddr + 1144 + (_loc21_ << 2));
               }
               _loc19_ = int(_loc18_);
               _loc15_ = int(_loc6_);
               if(_loc15_ < _loc8_)
               {
                  _loc22_ = 775236557;
                  _loc23_ = -862048943;
                  _loc24_ = 461845907;
                  _loc25_ = li32(_loc6_) * _loc23_;
                  _loc25_ = _loc25_ << 15 | _loc25_ >>> 17;
                  _loc22_ ^= _loc25_ * _loc24_;
                  _loc22_ = _loc22_ << 13 | _loc22_ >>> 19;
                  _loc22_ = _loc22_ * 5 + -430675100;
                  _loc26_ = _loc22_ ^ 4;
                  _loc26_ ^= _loc26_ >>> 16;
                  _loc26_ *= -2048144789;
                  _loc26_ ^= _loc26_ >>> 13;
                  _loc26_ *= -1028477387;
                  _loc21_ = (_loc26_ ^ _loc26_ >>> 16) & 65535;
                  _loc20_ = _loc34_.addr + _loc21_ * 5;
                  _loc21_ = 3;
                  _loc22_ = -1;
                  _loc24_ = int(li32(_loc20_ + 1));
                  if(_loc24_ >= 0 && li32(_loc6_) == li32(_loc24_) && _loc6_ - _loc24_ <= _loc34_.windowSize)
                  {
                     _loc25_ = _loc6_ + 4;
                     _loc23_ = 4;
                     _loc24_ += 4;
                     while(li32(_loc24_) == li32(_loc25_) && _loc23_ + 4 <= _loc34_.maxMatchLength)
                     {
                        _loc23_ += 4;
                        _loc24_ += 4;
                        _loc25_ += 4;
                     }
                     while(li8(_loc24_) == li8(_loc25_) && _loc23_ < _loc34_.maxMatchLength)
                     {
                        _loc23_++;
                        _loc24_++;
                        _loc25_++;
                     }
                     _loc21_ = int(_loc23_);
                     _loc22_ = int(_loc24_);
                  }
                  _loc26_ = 5;
                  _loc27_ = 9;
                  while(_loc26_ < _loc27_)
                  {
                     _loc28_ = int(_loc26_++);
                     _loc35_ = int(li32(_loc6_));
                     si32(_loc35_,_loc34_.hashScratchAddr);
                     _loc35_ = int(li32(_loc6_ + 4));
                     si32(_loc35_,_loc34_.hashScratchAddr + 4);
                     si32(0,_loc34_.hashScratchAddr + _loc28_);
                     _loc35_ = 775236557;
                     _loc36_ = -862048943;
                     _loc37_ = 461845907;
                     _loc38_ = li32(_loc34_.hashScratchAddr) * _loc36_;
                     _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                     _loc35_ ^= _loc38_ * _loc37_;
                     _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                     _loc35_ = _loc35_ * 5 + -430675100;
                     _loc38_ = li32(_loc34_.hashScratchAddr + 4) * _loc36_;
                     _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                     _loc35_ ^= _loc38_ * _loc37_;
                     _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                     _loc35_ = _loc35_ * 5 + -430675100;
                     _loc39_ = _loc35_ ^ _loc28_;
                     _loc39_ ^= _loc39_ >>> 16;
                     _loc39_ *= -2048144789;
                     _loc39_ ^= _loc39_ >>> 13;
                     _loc39_ *= -1028477387;
                     _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                     _loc29_ = _loc34_.addr + _loc30_ * 5 + 1;
                     _loc24_ = int(li32(_loc29_));
                     if(_loc24_ >= 0 && li32(_loc24_ + _loc21_ - 3) == li32(_loc6_ + _loc21_ - 3) && li32(_loc6_) == li32(_loc24_) && _loc6_ - _loc24_ <= _loc34_.windowSize)
                     {
                        _loc25_ = _loc6_ + 4;
                        _loc23_ = 4;
                        _loc24_ += 4;
                        while(li32(_loc24_) == li32(_loc25_) && _loc23_ + 4 <= _loc34_.maxMatchLength)
                        {
                           _loc23_ += 4;
                           _loc24_ += 4;
                           _loc25_ += 4;
                        }
                        while(li8(_loc24_) == li8(_loc25_) && _loc23_ < _loc34_.maxMatchLength)
                        {
                           _loc23_++;
                           _loc24_++;
                           _loc25_++;
                        }
                        if(_loc23_ > _loc21_)
                        {
                           _loc21_ = int(_loc23_);
                           _loc22_ = int(_loc24_);
                        }
                     }
                  }
                  si32(_loc6_ - (_loc22_ - _loc21_) << 16 | _loc21_,_loc34_.resultAddr);
                  _loc21_ = int(_loc20_);
                  _loc22_ = 4;
                  _loc23_ = int(_loc6_);
                  if((_loc24_ = int(li8(_loc21_))) < 8 && _loc24_ >= 0)
                  {
                     _loc25_ = int(li32(_loc21_ + 1));
                     si8(_loc22_,_loc21_);
                     si32(_loc23_,_loc21_ + 1);
                     _loc22_ = _loc24_ + 1;
                     _loc23_ = int(_loc25_);
                     _loc27_ = int(li32(_loc23_));
                     si32(_loc27_,_loc34_.hashScratchAddr);
                     _loc27_ = int(li32(_loc23_ + 4));
                     si32(_loc27_,_loc34_.hashScratchAddr + 4);
                     si32(0,_loc34_.hashScratchAddr + _loc22_);
                     _loc27_ = 775236557;
                     _loc28_ = -862048943;
                     _loc29_ = 461845907;
                     _loc30_ = li32(_loc34_.hashScratchAddr) * _loc28_;
                     _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                     _loc27_ ^= _loc30_ * _loc29_;
                     _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                     _loc27_ = _loc27_ * 5 + -430675100;
                     _loc30_ = li32(_loc34_.hashScratchAddr + 4) * _loc28_;
                     _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                     _loc27_ ^= _loc30_ * _loc29_;
                     _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                     _loc27_ = _loc27_ * 5 + -430675100;
                     _loc35_ = _loc27_ ^ _loc22_;
                     _loc35_ ^= _loc35_ >>> 16;
                     _loc35_ *= -2048144789;
                     _loc35_ ^= _loc35_ >>> 13;
                     _loc35_ *= -1028477387;
                     _loc26_ = (_loc35_ ^ _loc35_ >>> 16) & 65535;
                     _loc21_ = _loc34_.addr + _loc26_ * 5;
                     if((_loc24_ = int(li8(_loc21_))) < 8 && _loc24_ >= 0)
                     {
                        _loc25_ = int(li32(_loc21_ + 1));
                        si8(_loc22_,_loc21_);
                        si32(_loc23_,_loc21_ + 1);
                        _loc22_ = _loc24_ + 1;
                        _loc23_ = int(_loc25_);
                        _loc27_ = int(li32(_loc23_));
                        si32(_loc27_,_loc34_.hashScratchAddr);
                        _loc27_ = int(li32(_loc23_ + 4));
                        si32(_loc27_,_loc34_.hashScratchAddr + 4);
                        si32(0,_loc34_.hashScratchAddr + _loc22_);
                        _loc27_ = 775236557;
                        _loc28_ = -862048943;
                        _loc29_ = 461845907;
                        _loc30_ = li32(_loc34_.hashScratchAddr) * _loc28_;
                        _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                        _loc27_ ^= _loc30_ * _loc29_;
                        _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                        _loc27_ = _loc27_ * 5 + -430675100;
                        _loc30_ = li32(_loc34_.hashScratchAddr + 4) * _loc28_;
                        _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                        _loc27_ ^= _loc30_ * _loc29_;
                        _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                        _loc27_ = _loc27_ * 5 + -430675100;
                        _loc35_ = _loc27_ ^ _loc22_;
                        _loc35_ ^= _loc35_ >>> 16;
                        _loc35_ *= -2048144789;
                        _loc35_ ^= _loc35_ >>> 13;
                        _loc35_ *= -1028477387;
                        _loc26_ = (_loc35_ ^ _loc35_ >>> 16) & 65535;
                        _loc21_ = _loc34_.addr + _loc26_ * 5;
                        if((_loc24_ = int(li8(_loc21_))) < 8 && _loc24_ >= 0)
                        {
                           _loc25_ = int(li32(_loc21_ + 1));
                           si8(_loc22_,_loc21_);
                           si32(_loc23_,_loc21_ + 1);
                           _loc22_ = _loc24_ + 1;
                           _loc23_ = int(_loc25_);
                           _loc27_ = int(li32(_loc23_));
                           si32(_loc27_,_loc34_.hashScratchAddr);
                           _loc27_ = int(li32(_loc23_ + 4));
                           si32(_loc27_,_loc34_.hashScratchAddr + 4);
                           si32(0,_loc34_.hashScratchAddr + _loc22_);
                           _loc27_ = 775236557;
                           _loc28_ = -862048943;
                           _loc29_ = 461845907;
                           _loc30_ = li32(_loc34_.hashScratchAddr) * _loc28_;
                           _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                           _loc27_ ^= _loc30_ * _loc29_;
                           _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                           _loc27_ = _loc27_ * 5 + -430675100;
                           _loc30_ = li32(_loc34_.hashScratchAddr + 4) * _loc28_;
                           _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                           _loc27_ ^= _loc30_ * _loc29_;
                           _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                           _loc27_ = _loc27_ * 5 + -430675100;
                           _loc35_ = _loc27_ ^ _loc22_;
                           _loc35_ ^= _loc35_ >>> 16;
                           _loc35_ *= -2048144789;
                           _loc35_ ^= _loc35_ >>> 13;
                           _loc35_ *= -1028477387;
                           _loc26_ = (_loc35_ ^ _loc35_ >>> 16) & 65535;
                           _loc21_ = _loc34_.addr + _loc26_ * 5;
                           if((_loc24_ = int(li8(_loc21_))) < 8 && _loc24_ >= 0)
                           {
                              _loc25_ = int(li32(_loc21_ + 1));
                              si8(_loc22_,_loc21_);
                              si32(_loc23_,_loc21_ + 1);
                              _loc22_ = _loc24_ + 1;
                              _loc23_ = int(_loc25_);
                              _loc27_ = int(li32(_loc23_));
                              si32(_loc27_,_loc34_.hashScratchAddr);
                              _loc27_ = int(li32(_loc23_ + 4));
                              si32(_loc27_,_loc34_.hashScratchAddr + 4);
                              si32(0,_loc34_.hashScratchAddr + _loc22_);
                              _loc27_ = 775236557;
                              _loc28_ = -862048943;
                              _loc29_ = 461845907;
                              _loc30_ = li32(_loc34_.hashScratchAddr) * _loc28_;
                              _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                              _loc27_ ^= _loc30_ * _loc29_;
                              _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                              _loc27_ = _loc27_ * 5 + -430675100;
                              _loc30_ = li32(_loc34_.hashScratchAddr + 4) * _loc28_;
                              _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                              _loc27_ ^= _loc30_ * _loc29_;
                              _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                              _loc27_ = _loc27_ * 5 + -430675100;
                              _loc35_ = _loc27_ ^ _loc22_;
                              _loc35_ ^= _loc35_ >>> 16;
                              _loc35_ *= -2048144789;
                              _loc35_ ^= _loc35_ >>> 13;
                              _loc35_ *= -1028477387;
                              _loc26_ = (_loc35_ ^ _loc35_ >>> 16) & 65535;
                              _loc21_ = _loc34_.addr + _loc26_ * 5;
                           }
                        }
                     }
                  }
                  si8(_loc22_,_loc21_);
                  si32(_loc23_,_loc21_ + 1);
                  _loc34_.resultAddr = _loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7);
               }
               else if(_loc15_ < _loc9_)
               {
                  _loc22_ = 775236557;
                  _loc23_ = -862048943;
                  _loc24_ = 461845907;
                  _loc25_ = li32(_loc6_) * _loc23_;
                  _loc25_ = _loc25_ << 15 | _loc25_ >>> 17;
                  _loc22_ ^= _loc25_ * _loc24_;
                  _loc22_ = _loc22_ << 13 | _loc22_ >>> 19;
                  _loc22_ = _loc22_ * 5 + -430675100;
                  _loc26_ = _loc22_ ^ 4;
                  _loc26_ ^= _loc26_ >>> 16;
                  _loc26_ *= -2048144789;
                  _loc26_ ^= _loc26_ >>> 13;
                  _loc26_ *= -1028477387;
                  _loc21_ = (_loc26_ ^ _loc26_ >>> 16) & 65535;
                  _loc20_ = _loc34_.addr + _loc21_ * 5;
                  _loc21_ = 3;
                  _loc22_ = -1;
                  _loc24_ = int(li32(_loc20_ + 1));
                  if(_loc24_ >= 0 && li32(_loc6_) == li32(_loc24_) && _loc6_ - _loc24_ <= _loc34_.windowSize)
                  {
                     _loc25_ = _loc6_ + 4;
                     _loc23_ = 4;
                     _loc24_ += 4;
                     while(_loc25_ + 4 <= _loc7_ && li32(_loc24_) == li32(_loc25_) && _loc23_ + 4 <= _loc34_.maxMatchLength)
                     {
                        _loc23_ += 4;
                        _loc24_ += 4;
                        _loc25_ += 4;
                     }
                     while(_loc25_ < _loc7_ && li8(_loc24_) == li8(_loc25_) && _loc23_ < _loc34_.maxMatchLength)
                     {
                        _loc23_++;
                        _loc24_++;
                        _loc25_++;
                     }
                     _loc21_ = int(_loc23_);
                     _loc22_ = int(_loc24_);
                  }
                  _loc26_ = 5;
                  _loc27_ = 9;
                  while(_loc26_ < _loc27_)
                  {
                     _loc28_ = int(_loc26_++);
                     _loc35_ = int(li32(_loc6_));
                     si32(_loc35_,_loc34_.hashScratchAddr);
                     _loc35_ = int(li32(_loc6_ + 4));
                     si32(_loc35_,_loc34_.hashScratchAddr + 4);
                     si32(0,_loc34_.hashScratchAddr + _loc28_);
                     _loc35_ = 775236557;
                     _loc36_ = -862048943;
                     _loc37_ = 461845907;
                     _loc38_ = li32(_loc34_.hashScratchAddr) * _loc36_;
                     _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                     _loc35_ ^= _loc38_ * _loc37_;
                     _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                     _loc35_ = _loc35_ * 5 + -430675100;
                     _loc38_ = li32(_loc34_.hashScratchAddr + 4) * _loc36_;
                     _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                     _loc35_ ^= _loc38_ * _loc37_;
                     _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                     _loc35_ = _loc35_ * 5 + -430675100;
                     _loc39_ = _loc35_ ^ _loc28_;
                     _loc39_ ^= _loc39_ >>> 16;
                     _loc39_ *= -2048144789;
                     _loc39_ ^= _loc39_ >>> 13;
                     _loc39_ *= -1028477387;
                     _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                     _loc29_ = _loc34_.addr + _loc30_ * 5 + 1;
                     _loc24_ = int(li32(_loc29_));
                     if(_loc24_ >= 0 && li32(_loc6_) == li32(_loc24_) && _loc6_ - _loc24_ <= _loc34_.windowSize)
                     {
                        _loc25_ = _loc6_ + 4;
                        _loc23_ = 4;
                        _loc24_ += 4;
                        while(_loc25_ + 4 <= _loc7_ && li32(_loc24_) == li32(_loc25_) && _loc23_ + 4 <= _loc34_.maxMatchLength)
                        {
                           _loc23_ += 4;
                           _loc24_ += 4;
                           _loc25_ += 4;
                        }
                        while(_loc25_ < _loc7_ && li8(_loc24_) == li8(_loc25_) && _loc23_ < _loc34_.maxMatchLength)
                        {
                           _loc23_++;
                           _loc24_++;
                           _loc25_++;
                        }
                        if(_loc23_ > _loc21_)
                        {
                           _loc21_ = int(_loc23_);
                           _loc22_ = int(_loc24_);
                        }
                     }
                  }
                  si32(_loc6_ - (_loc22_ - _loc21_) << 16 | _loc21_,_loc34_.resultAddr);
                  _loc21_ = int(_loc20_);
                  _loc22_ = 4;
                  _loc23_ = int(_loc6_);
                  if((_loc24_ = int(li8(_loc21_))) < 8 && _loc24_ >= 0)
                  {
                     _loc25_ = int(li32(_loc21_ + 1));
                     si8(_loc22_,_loc21_);
                     si32(_loc23_,_loc21_ + 1);
                     _loc22_ = _loc24_ + 1;
                     _loc23_ = int(_loc25_);
                     _loc27_ = int(li32(_loc23_));
                     si32(_loc27_,_loc34_.hashScratchAddr);
                     _loc27_ = int(li32(_loc23_ + 4));
                     si32(_loc27_,_loc34_.hashScratchAddr + 4);
                     si32(0,_loc34_.hashScratchAddr + _loc22_);
                     _loc27_ = 775236557;
                     _loc28_ = -862048943;
                     _loc29_ = 461845907;
                     _loc30_ = li32(_loc34_.hashScratchAddr) * _loc28_;
                     _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                     _loc27_ ^= _loc30_ * _loc29_;
                     _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                     _loc27_ = _loc27_ * 5 + -430675100;
                     _loc30_ = li32(_loc34_.hashScratchAddr + 4) * _loc28_;
                     _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                     _loc27_ ^= _loc30_ * _loc29_;
                     _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                     _loc27_ = _loc27_ * 5 + -430675100;
                     _loc35_ = _loc27_ ^ _loc22_;
                     _loc35_ ^= _loc35_ >>> 16;
                     _loc35_ *= -2048144789;
                     _loc35_ ^= _loc35_ >>> 13;
                     _loc35_ *= -1028477387;
                     _loc26_ = (_loc35_ ^ _loc35_ >>> 16) & 65535;
                     _loc21_ = _loc34_.addr + _loc26_ * 5;
                     if((_loc24_ = int(li8(_loc21_))) < 8 && _loc24_ >= 0)
                     {
                        _loc25_ = int(li32(_loc21_ + 1));
                        si8(_loc22_,_loc21_);
                        si32(_loc23_,_loc21_ + 1);
                        _loc22_ = _loc24_ + 1;
                        _loc23_ = int(_loc25_);
                        _loc27_ = int(li32(_loc23_));
                        si32(_loc27_,_loc34_.hashScratchAddr);
                        _loc27_ = int(li32(_loc23_ + 4));
                        si32(_loc27_,_loc34_.hashScratchAddr + 4);
                        si32(0,_loc34_.hashScratchAddr + _loc22_);
                        _loc27_ = 775236557;
                        _loc28_ = -862048943;
                        _loc29_ = 461845907;
                        _loc30_ = li32(_loc34_.hashScratchAddr) * _loc28_;
                        _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                        _loc27_ ^= _loc30_ * _loc29_;
                        _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                        _loc27_ = _loc27_ * 5 + -430675100;
                        _loc30_ = li32(_loc34_.hashScratchAddr + 4) * _loc28_;
                        _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                        _loc27_ ^= _loc30_ * _loc29_;
                        _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                        _loc27_ = _loc27_ * 5 + -430675100;
                        _loc35_ = _loc27_ ^ _loc22_;
                        _loc35_ ^= _loc35_ >>> 16;
                        _loc35_ *= -2048144789;
                        _loc35_ ^= _loc35_ >>> 13;
                        _loc35_ *= -1028477387;
                        _loc26_ = (_loc35_ ^ _loc35_ >>> 16) & 65535;
                        _loc21_ = _loc34_.addr + _loc26_ * 5;
                        if((_loc24_ = int(li8(_loc21_))) < 8 && _loc24_ >= 0)
                        {
                           _loc25_ = int(li32(_loc21_ + 1));
                           si8(_loc22_,_loc21_);
                           si32(_loc23_,_loc21_ + 1);
                           _loc22_ = _loc24_ + 1;
                           _loc23_ = int(_loc25_);
                           _loc27_ = int(li32(_loc23_));
                           si32(_loc27_,_loc34_.hashScratchAddr);
                           _loc27_ = int(li32(_loc23_ + 4));
                           si32(_loc27_,_loc34_.hashScratchAddr + 4);
                           si32(0,_loc34_.hashScratchAddr + _loc22_);
                           _loc27_ = 775236557;
                           _loc28_ = -862048943;
                           _loc29_ = 461845907;
                           _loc30_ = li32(_loc34_.hashScratchAddr) * _loc28_;
                           _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                           _loc27_ ^= _loc30_ * _loc29_;
                           _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                           _loc27_ = _loc27_ * 5 + -430675100;
                           _loc30_ = li32(_loc34_.hashScratchAddr + 4) * _loc28_;
                           _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                           _loc27_ ^= _loc30_ * _loc29_;
                           _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                           _loc27_ = _loc27_ * 5 + -430675100;
                           _loc35_ = _loc27_ ^ _loc22_;
                           _loc35_ ^= _loc35_ >>> 16;
                           _loc35_ *= -2048144789;
                           _loc35_ ^= _loc35_ >>> 13;
                           _loc35_ *= -1028477387;
                           _loc26_ = (_loc35_ ^ _loc35_ >>> 16) & 65535;
                           _loc21_ = _loc34_.addr + _loc26_ * 5;
                           if((_loc24_ = int(li8(_loc21_))) < 8 && _loc24_ >= 0)
                           {
                              _loc25_ = int(li32(_loc21_ + 1));
                              si8(_loc22_,_loc21_);
                              si32(_loc23_,_loc21_ + 1);
                              _loc22_ = _loc24_ + 1;
                              _loc23_ = int(_loc25_);
                              _loc27_ = int(li32(_loc23_));
                              si32(_loc27_,_loc34_.hashScratchAddr);
                              _loc27_ = int(li32(_loc23_ + 4));
                              si32(_loc27_,_loc34_.hashScratchAddr + 4);
                              si32(0,_loc34_.hashScratchAddr + _loc22_);
                              _loc27_ = 775236557;
                              _loc28_ = -862048943;
                              _loc29_ = 461845907;
                              _loc30_ = li32(_loc34_.hashScratchAddr) * _loc28_;
                              _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                              _loc27_ ^= _loc30_ * _loc29_;
                              _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                              _loc27_ = _loc27_ * 5 + -430675100;
                              _loc30_ = li32(_loc34_.hashScratchAddr + 4) * _loc28_;
                              _loc30_ = _loc30_ << 15 | _loc30_ >>> 17;
                              _loc27_ ^= _loc30_ * _loc29_;
                              _loc27_ = _loc27_ << 13 | _loc27_ >>> 19;
                              _loc27_ = _loc27_ * 5 + -430675100;
                              _loc35_ = _loc27_ ^ _loc22_;
                              _loc35_ ^= _loc35_ >>> 16;
                              _loc35_ *= -2048144789;
                              _loc35_ ^= _loc35_ >>> 13;
                              _loc35_ *= -1028477387;
                              _loc26_ = (_loc35_ ^ _loc35_ >>> 16) & 65535;
                              _loc21_ = _loc34_.addr + _loc26_ * 5;
                           }
                        }
                     }
                  }
                  si8(_loc22_,_loc21_);
                  si32(_loc23_,_loc21_ + 1);
                  _loc34_.resultAddr = _loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7);
               }
               while(_loc15_ < _loc8_)
               {
                  _loc23_ = 775236557;
                  _loc24_ = -862048943;
                  _loc25_ = 461845907;
                  _loc26_ = li32(_loc15_ + 1) * _loc24_;
                  _loc26_ = _loc26_ << 15 | _loc26_ >>> 17;
                  _loc23_ ^= _loc26_ * _loc25_;
                  _loc23_ = _loc23_ << 13 | _loc23_ >>> 19;
                  _loc23_ = _loc23_ * 5 + -430675100;
                  _loc27_ = _loc23_ ^ 4;
                  _loc27_ ^= _loc27_ >>> 16;
                  _loc27_ *= -2048144789;
                  _loc27_ ^= _loc27_ >>> 13;
                  _loc27_ *= -1028477387;
                  _loc22_ = (_loc27_ ^ _loc27_ >>> 16) & 65535;
                  _loc21_ = _loc34_.addr + _loc22_ * 5;
                  if(li16(_loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7)) < _loc34_.avgMatchLength + 4)
                  {
                     _loc22_ = _loc15_ + 1;
                     _loc23_ = 3;
                     _loc24_ = -1;
                     _loc26_ = int(li32(_loc21_ + 1));
                     if(_loc26_ >= 0 && li32(_loc22_) == li32(_loc26_) && _loc22_ - _loc26_ <= _loc34_.windowSize)
                     {
                        _loc27_ = _loc22_ + 4;
                        _loc25_ = 4;
                        _loc26_ += 4;
                        while(li32(_loc26_) == li32(_loc27_) && _loc25_ + 4 <= _loc34_.maxMatchLength)
                        {
                           _loc25_ += 4;
                           _loc26_ += 4;
                           _loc27_ += 4;
                        }
                        while(li8(_loc26_) == li8(_loc27_) && _loc25_ < _loc34_.maxMatchLength)
                        {
                           _loc25_++;
                           _loc26_++;
                           _loc27_++;
                        }
                        _loc23_ = int(_loc25_);
                        _loc24_ = int(_loc26_);
                     }
                     _loc28_ = 5;
                     _loc29_ = 9;
                     while(_loc28_ < _loc29_)
                     {
                        _loc30_ = int(_loc28_++);
                        _loc37_ = int(li32(_loc22_));
                        si32(_loc37_,_loc34_.hashScratchAddr);
                        _loc37_ = int(li32(_loc22_ + 4));
                        si32(_loc37_,_loc34_.hashScratchAddr + 4);
                        si32(0,_loc34_.hashScratchAddr + _loc30_);
                        _loc37_ = 775236557;
                        _loc38_ = -862048943;
                        _loc39_ = 461845907;
                        _loc40_ = li32(_loc34_.hashScratchAddr) * _loc38_;
                        _loc40_ = _loc40_ << 15 | _loc40_ >>> 17;
                        _loc37_ ^= _loc40_ * _loc39_;
                        _loc37_ = _loc37_ << 13 | _loc37_ >>> 19;
                        _loc37_ = _loc37_ * 5 + -430675100;
                        _loc40_ = li32(_loc34_.hashScratchAddr + 4) * _loc38_;
                        _loc40_ = _loc40_ << 15 | _loc40_ >>> 17;
                        _loc37_ ^= _loc40_ * _loc39_;
                        _loc37_ = _loc37_ << 13 | _loc37_ >>> 19;
                        _loc37_ = _loc37_ * 5 + -430675100;
                        _loc41_ = _loc37_ ^ _loc30_;
                        _loc41_ ^= _loc41_ >>> 16;
                        _loc41_ *= -2048144789;
                        _loc41_ ^= _loc41_ >>> 13;
                        _loc41_ *= -1028477387;
                        _loc36_ = (_loc41_ ^ _loc41_ >>> 16) & 65535;
                        _loc35_ = _loc34_.addr + _loc36_ * 5 + 1;
                        _loc26_ = int(li32(_loc35_));
                        if(_loc26_ >= 0 && li32(_loc26_ + _loc23_ - 3) == li32(_loc22_ + _loc23_ - 3) && li32(_loc22_) == li32(_loc26_) && _loc22_ - _loc26_ <= _loc34_.windowSize)
                        {
                           _loc27_ = _loc22_ + 4;
                           _loc25_ = 4;
                           _loc26_ += 4;
                           while(li32(_loc26_) == li32(_loc27_) && _loc25_ + 4 <= _loc34_.maxMatchLength)
                           {
                              _loc25_ += 4;
                              _loc26_ += 4;
                              _loc27_ += 4;
                           }
                           while(li8(_loc26_) == li8(_loc27_) && _loc25_ < _loc34_.maxMatchLength)
                           {
                              _loc25_++;
                              _loc26_++;
                              _loc27_++;
                           }
                           if(_loc25_ > _loc23_)
                           {
                              _loc23_ = int(_loc25_);
                              _loc24_ = int(_loc26_);
                           }
                        }
                     }
                     si32(_loc22_ - (_loc24_ - _loc23_) << 16 | _loc23_,_loc34_.resultAddr);
                  }
                  else
                  {
                     si32(0,_loc34_.resultAddr);
                  }
                  _loc22_ = int(_loc21_);
                  _loc23_ = 4;
                  _loc24_ = _loc15_ + 1;
                  if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                  {
                     _loc26_ = int(li32(_loc22_ + 1));
                     si8(_loc23_,_loc22_);
                     si32(_loc24_,_loc22_ + 1);
                     _loc23_ = _loc25_ + 1;
                     _loc24_ = int(_loc26_);
                     _loc28_ = int(li32(_loc24_));
                     si32(_loc28_,_loc34_.hashScratchAddr);
                     _loc28_ = int(li32(_loc24_ + 4));
                     si32(_loc28_,_loc34_.hashScratchAddr + 4);
                     si32(0,_loc34_.hashScratchAddr + _loc23_);
                     _loc28_ = 775236557;
                     _loc29_ = -862048943;
                     _loc30_ = 461845907;
                     _loc35_ = li32(_loc34_.hashScratchAddr) * _loc29_;
                     _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                     _loc28_ ^= _loc35_ * _loc30_;
                     _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                     _loc28_ = _loc28_ * 5 + -430675100;
                     _loc35_ = li32(_loc34_.hashScratchAddr + 4) * _loc29_;
                     _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                     _loc28_ ^= _loc35_ * _loc30_;
                     _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                     _loc28_ = _loc28_ * 5 + -430675100;
                     _loc36_ = _loc28_ ^ _loc23_;
                     _loc36_ ^= _loc36_ >>> 16;
                     _loc36_ *= -2048144789;
                     _loc36_ ^= _loc36_ >>> 13;
                     _loc36_ *= -1028477387;
                     _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                     _loc22_ = _loc34_.addr + _loc27_ * 5;
                     if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                     {
                        _loc26_ = int(li32(_loc22_ + 1));
                        si8(_loc23_,_loc22_);
                        si32(_loc24_,_loc22_ + 1);
                        _loc23_ = _loc25_ + 1;
                        _loc24_ = int(_loc26_);
                        _loc28_ = int(li32(_loc24_));
                        si32(_loc28_,_loc34_.hashScratchAddr);
                        _loc28_ = int(li32(_loc24_ + 4));
                        si32(_loc28_,_loc34_.hashScratchAddr + 4);
                        si32(0,_loc34_.hashScratchAddr + _loc23_);
                        _loc28_ = 775236557;
                        _loc29_ = -862048943;
                        _loc30_ = 461845907;
                        _loc35_ = li32(_loc34_.hashScratchAddr) * _loc29_;
                        _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                        _loc28_ ^= _loc35_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc35_ = li32(_loc34_.hashScratchAddr + 4) * _loc29_;
                        _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                        _loc28_ ^= _loc35_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc36_ = _loc28_ ^ _loc23_;
                        _loc36_ ^= _loc36_ >>> 16;
                        _loc36_ *= -2048144789;
                        _loc36_ ^= _loc36_ >>> 13;
                        _loc36_ *= -1028477387;
                        _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                        _loc22_ = _loc34_.addr + _loc27_ * 5;
                        if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                        {
                           _loc26_ = int(li32(_loc22_ + 1));
                           si8(_loc23_,_loc22_);
                           si32(_loc24_,_loc22_ + 1);
                           _loc23_ = _loc25_ + 1;
                           _loc24_ = int(_loc26_);
                           _loc28_ = int(li32(_loc24_));
                           si32(_loc28_,_loc34_.hashScratchAddr);
                           _loc28_ = int(li32(_loc24_ + 4));
                           si32(_loc28_,_loc34_.hashScratchAddr + 4);
                           si32(0,_loc34_.hashScratchAddr + _loc23_);
                           _loc28_ = 775236557;
                           _loc29_ = -862048943;
                           _loc30_ = 461845907;
                           _loc35_ = li32(_loc34_.hashScratchAddr) * _loc29_;
                           _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                           _loc28_ ^= _loc35_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc35_ = li32(_loc34_.hashScratchAddr + 4) * _loc29_;
                           _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                           _loc28_ ^= _loc35_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc36_ = _loc28_ ^ _loc23_;
                           _loc36_ ^= _loc36_ >>> 16;
                           _loc36_ *= -2048144789;
                           _loc36_ ^= _loc36_ >>> 13;
                           _loc36_ *= -1028477387;
                           _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                           _loc22_ = _loc34_.addr + _loc27_ * 5;
                           if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                           {
                              _loc26_ = int(li32(_loc22_ + 1));
                              si8(_loc23_,_loc22_);
                              si32(_loc24_,_loc22_ + 1);
                              _loc23_ = _loc25_ + 1;
                              _loc24_ = int(_loc26_);
                              _loc28_ = int(li32(_loc24_));
                              si32(_loc28_,_loc34_.hashScratchAddr);
                              _loc28_ = int(li32(_loc24_ + 4));
                              si32(_loc28_,_loc34_.hashScratchAddr + 4);
                              si32(0,_loc34_.hashScratchAddr + _loc23_);
                              _loc28_ = 775236557;
                              _loc29_ = -862048943;
                              _loc30_ = 461845907;
                              _loc35_ = li32(_loc34_.hashScratchAddr) * _loc29_;
                              _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                              _loc28_ ^= _loc35_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc35_ = li32(_loc34_.hashScratchAddr + 4) * _loc29_;
                              _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                              _loc28_ ^= _loc35_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc36_ = _loc28_ ^ _loc23_;
                              _loc36_ ^= _loc36_ >>> 16;
                              _loc36_ *= -2048144789;
                              _loc36_ ^= _loc36_ >>> 13;
                              _loc36_ *= -1028477387;
                              _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                              _loc22_ = _loc34_.addr + _loc27_ * 5;
                           }
                        }
                     }
                  }
                  si8(_loc23_,_loc22_);
                  si32(_loc24_,_loc22_ + 1);
                  _loc34_.resultAddr = _loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7);
                  if(li16(_loc34_.resultAddr) >= 4)
                  {
                     _loc20_ = int(li16(_loc34_.resultAddr));
                     if(li16(_loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7)) > _loc20_)
                     {
                        si32(0,_loc34_.resultAddr);
                     }
                     else
                     {
                        _loc34_.avgMatchLength = (_loc34_.avgMatchLength << 1) + (_loc34_.avgMatchLength << 2) + (_loc20_ << 1) >>> 3;
                        if(_loc20_ < _loc34_.avgMatchLength + 4)
                        {
                           _loc22_ = _loc15_ + 1 + 1;
                           _loc23_ = _loc15_ + _loc20_;
                           while(_loc22_ < _loc23_)
                           {
                              _loc24_ = int(_loc22_++);
                              _loc25_ = 4;
                              _loc26_ = int(_loc24_);
                              _loc35_ = 775236557;
                              _loc36_ = -862048943;
                              _loc37_ = 461845907;
                              _loc38_ = li32(_loc24_) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc35_ ^= _loc38_ * _loc37_;
                              _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                              _loc35_ = _loc35_ * 5 + -430675100;
                              _loc39_ = _loc35_ ^ 4;
                              _loc39_ ^= _loc39_ >>> 16;
                              _loc39_ *= -2048144789;
                              _loc39_ ^= _loc39_ >>> 13;
                              _loc39_ *= -1028477387;
                              _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                              _loc29_ = _loc34_.addr + _loc30_ * 5;
                              if((_loc27_ = int(li8(_loc29_))) < 8 && _loc27_ >= 0)
                              {
                                 _loc28_ = int(li32(_loc29_ + 1));
                                 si8(_loc25_,_loc29_);
                                 si32(_loc26_,_loc29_ + 1);
                                 _loc25_ = _loc27_ + 1;
                                 _loc26_ = int(_loc28_);
                                 _loc35_ = int(li32(_loc26_));
                                 si32(_loc35_,_loc34_.hashScratchAddr);
                                 _loc35_ = int(li32(_loc26_ + 4));
                                 si32(_loc35_,_loc34_.hashScratchAddr + 4);
                                 si32(0,_loc34_.hashScratchAddr + _loc25_);
                                 _loc35_ = 775236557;
                                 _loc36_ = -862048943;
                                 _loc37_ = 461845907;
                                 _loc38_ = li32(_loc34_.hashScratchAddr) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc35_ ^= _loc38_ * _loc37_;
                                 _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                                 _loc35_ = _loc35_ * 5 + -430675100;
                                 _loc38_ = li32(_loc34_.hashScratchAddr + 4) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc35_ ^= _loc38_ * _loc37_;
                                 _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                                 _loc35_ = _loc35_ * 5 + -430675100;
                                 _loc39_ = _loc35_ ^ _loc25_;
                                 _loc39_ ^= _loc39_ >>> 16;
                                 _loc39_ *= -2048144789;
                                 _loc39_ ^= _loc39_ >>> 13;
                                 _loc39_ *= -1028477387;
                                 _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                 _loc29_ = _loc34_.addr + _loc30_ * 5;
                                 if((_loc27_ = int(li8(_loc29_))) < 8 && _loc27_ >= 0)
                                 {
                                    _loc28_ = int(li32(_loc29_ + 1));
                                    si8(_loc25_,_loc29_);
                                    si32(_loc26_,_loc29_ + 1);
                                    _loc25_ = _loc27_ + 1;
                                    _loc26_ = int(_loc28_);
                                    _loc35_ = int(li32(_loc26_));
                                    si32(_loc35_,_loc34_.hashScratchAddr);
                                    _loc35_ = int(li32(_loc26_ + 4));
                                    si32(_loc35_,_loc34_.hashScratchAddr + 4);
                                    si32(0,_loc34_.hashScratchAddr + _loc25_);
                                    _loc35_ = 775236557;
                                    _loc36_ = -862048943;
                                    _loc37_ = 461845907;
                                    _loc38_ = li32(_loc34_.hashScratchAddr) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc35_ ^= _loc38_ * _loc37_;
                                    _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                                    _loc35_ = _loc35_ * 5 + -430675100;
                                    _loc38_ = li32(_loc34_.hashScratchAddr + 4) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc35_ ^= _loc38_ * _loc37_;
                                    _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                                    _loc35_ = _loc35_ * 5 + -430675100;
                                    _loc39_ = _loc35_ ^ _loc25_;
                                    _loc39_ ^= _loc39_ >>> 16;
                                    _loc39_ *= -2048144789;
                                    _loc39_ ^= _loc39_ >>> 13;
                                    _loc39_ *= -1028477387;
                                    _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                    _loc29_ = _loc34_.addr + _loc30_ * 5;
                                 }
                              }
                              si8(_loc25_,_loc29_);
                              si32(_loc26_,_loc29_ + 1);
                           }
                        }
                        _loc34_.resultAddr = _loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7);
                        _loc22_ = _loc15_ + _loc20_;
                        _loc25_ = 775236557;
                        _loc26_ = -862048943;
                        _loc27_ = 461845907;
                        _loc28_ = li32(_loc22_) * _loc26_;
                        _loc28_ = _loc28_ << 15 | _loc28_ >>> 17;
                        _loc25_ ^= _loc28_ * _loc27_;
                        _loc25_ = _loc25_ << 13 | _loc25_ >>> 19;
                        _loc25_ = _loc25_ * 5 + -430675100;
                        _loc29_ = _loc25_ ^ 4;
                        _loc29_ ^= _loc29_ >>> 16;
                        _loc29_ *= -2048144789;
                        _loc29_ ^= _loc29_ >>> 13;
                        _loc29_ *= -1028477387;
                        _loc24_ = (_loc29_ ^ _loc29_ >>> 16) & 65535;
                        _loc23_ = _loc34_.addr + _loc24_ * 5;
                        _loc24_ = 3;
                        _loc25_ = -1;
                        _loc27_ = int(li32(_loc23_ + 1));
                        if(_loc27_ >= 0 && li32(_loc22_) == li32(_loc27_) && _loc22_ - _loc27_ <= _loc34_.windowSize)
                        {
                           _loc28_ = _loc22_ + 4;
                           _loc26_ = 4;
                           _loc27_ += 4;
                           while(li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc34_.maxMatchLength)
                           {
                              _loc26_ += 4;
                              _loc27_ += 4;
                              _loc28_ += 4;
                           }
                           while(li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc34_.maxMatchLength)
                           {
                              _loc26_++;
                              _loc27_++;
                              _loc28_++;
                           }
                           _loc24_ = int(_loc26_);
                           _loc25_ = int(_loc27_);
                        }
                        _loc29_ = 5;
                        _loc30_ = 9;
                        while(_loc29_ < _loc30_)
                        {
                           _loc35_ = int(_loc29_++);
                           _loc38_ = int(li32(_loc22_));
                           si32(_loc38_,_loc34_.hashScratchAddr);
                           _loc38_ = int(li32(_loc22_ + 4));
                           si32(_loc38_,_loc34_.hashScratchAddr + 4);
                           si32(0,_loc34_.hashScratchAddr + _loc35_);
                           _loc38_ = 775236557;
                           _loc39_ = -862048943;
                           _loc40_ = 461845907;
                           _loc41_ = li32(_loc34_.hashScratchAddr) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc41_ = li32(_loc34_.hashScratchAddr + 4) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc42_ = _loc38_ ^ _loc35_;
                           _loc42_ ^= _loc42_ >>> 16;
                           _loc42_ *= -2048144789;
                           _loc42_ ^= _loc42_ >>> 13;
                           _loc42_ *= -1028477387;
                           _loc37_ = (_loc42_ ^ _loc42_ >>> 16) & 65535;
                           _loc36_ = _loc34_.addr + _loc37_ * 5 + 1;
                           _loc27_ = int(li32(_loc36_));
                           if(_loc27_ >= 0 && li32(_loc27_ + _loc24_ - 3) == li32(_loc22_ + _loc24_ - 3) && li32(_loc22_) == li32(_loc27_) && _loc22_ - _loc27_ <= _loc34_.windowSize)
                           {
                              _loc28_ = _loc22_ + 4;
                              _loc26_ = 4;
                              _loc27_ += 4;
                              while(li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc34_.maxMatchLength)
                              {
                                 _loc26_ += 4;
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                              }
                              while(li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc34_.maxMatchLength)
                              {
                                 _loc26_++;
                                 _loc27_++;
                                 _loc28_++;
                              }
                              if(_loc26_ > _loc24_)
                              {
                                 _loc24_ = int(_loc26_);
                                 _loc25_ = int(_loc27_);
                              }
                           }
                        }
                        si32(_loc22_ - (_loc25_ - _loc24_) << 16 | _loc24_,_loc34_.resultAddr);
                        _loc24_ = int(_loc23_);
                        _loc25_ = 4;
                        _loc26_ = int(_loc22_);
                        if((_loc27_ = int(li8(_loc24_))) < 8 && _loc27_ >= 0)
                        {
                           _loc28_ = int(li32(_loc24_ + 1));
                           si8(_loc25_,_loc24_);
                           si32(_loc26_,_loc24_ + 1);
                           _loc25_ = _loc27_ + 1;
                           _loc26_ = int(_loc28_);
                           _loc30_ = int(li32(_loc26_));
                           si32(_loc30_,_loc34_.hashScratchAddr);
                           _loc30_ = int(li32(_loc26_ + 4));
                           si32(_loc30_,_loc34_.hashScratchAddr + 4);
                           si32(0,_loc34_.hashScratchAddr + _loc25_);
                           _loc30_ = 775236557;
                           _loc35_ = -862048943;
                           _loc36_ = 461845907;
                           _loc37_ = li32(_loc34_.hashScratchAddr) * _loc35_;
                           _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                           _loc30_ ^= _loc37_ * _loc36_;
                           _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                           _loc30_ = _loc30_ * 5 + -430675100;
                           _loc37_ = li32(_loc34_.hashScratchAddr + 4) * _loc35_;
                           _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                           _loc30_ ^= _loc37_ * _loc36_;
                           _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                           _loc30_ = _loc30_ * 5 + -430675100;
                           _loc38_ = _loc30_ ^ _loc25_;
                           _loc38_ ^= _loc38_ >>> 16;
                           _loc38_ *= -2048144789;
                           _loc38_ ^= _loc38_ >>> 13;
                           _loc38_ *= -1028477387;
                           _loc29_ = (_loc38_ ^ _loc38_ >>> 16) & 65535;
                           _loc24_ = _loc34_.addr + _loc29_ * 5;
                           if((_loc27_ = int(li8(_loc24_))) < 8 && _loc27_ >= 0)
                           {
                              _loc28_ = int(li32(_loc24_ + 1));
                              si8(_loc25_,_loc24_);
                              si32(_loc26_,_loc24_ + 1);
                              _loc25_ = _loc27_ + 1;
                              _loc26_ = int(_loc28_);
                              _loc30_ = int(li32(_loc26_));
                              si32(_loc30_,_loc34_.hashScratchAddr);
                              _loc30_ = int(li32(_loc26_ + 4));
                              si32(_loc30_,_loc34_.hashScratchAddr + 4);
                              si32(0,_loc34_.hashScratchAddr + _loc25_);
                              _loc30_ = 775236557;
                              _loc35_ = -862048943;
                              _loc36_ = 461845907;
                              _loc37_ = li32(_loc34_.hashScratchAddr) * _loc35_;
                              _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                              _loc30_ ^= _loc37_ * _loc36_;
                              _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                              _loc30_ = _loc30_ * 5 + -430675100;
                              _loc37_ = li32(_loc34_.hashScratchAddr + 4) * _loc35_;
                              _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                              _loc30_ ^= _loc37_ * _loc36_;
                              _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                              _loc30_ = _loc30_ * 5 + -430675100;
                              _loc38_ = _loc30_ ^ _loc25_;
                              _loc38_ ^= _loc38_ >>> 16;
                              _loc38_ *= -2048144789;
                              _loc38_ ^= _loc38_ >>> 13;
                              _loc38_ *= -1028477387;
                              _loc29_ = (_loc38_ ^ _loc38_ >>> 16) & 65535;
                              _loc24_ = _loc34_.addr + _loc29_ * 5;
                              if((_loc27_ = int(li8(_loc24_))) < 8 && _loc27_ >= 0)
                              {
                                 _loc28_ = int(li32(_loc24_ + 1));
                                 si8(_loc25_,_loc24_);
                                 si32(_loc26_,_loc24_ + 1);
                                 _loc25_ = _loc27_ + 1;
                                 _loc26_ = int(_loc28_);
                                 _loc30_ = int(li32(_loc26_));
                                 si32(_loc30_,_loc34_.hashScratchAddr);
                                 _loc30_ = int(li32(_loc26_ + 4));
                                 si32(_loc30_,_loc34_.hashScratchAddr + 4);
                                 si32(0,_loc34_.hashScratchAddr + _loc25_);
                                 _loc30_ = 775236557;
                                 _loc35_ = -862048943;
                                 _loc36_ = 461845907;
                                 _loc37_ = li32(_loc34_.hashScratchAddr) * _loc35_;
                                 _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                                 _loc30_ ^= _loc37_ * _loc36_;
                                 _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                 _loc30_ = _loc30_ * 5 + -430675100;
                                 _loc37_ = li32(_loc34_.hashScratchAddr + 4) * _loc35_;
                                 _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                                 _loc30_ ^= _loc37_ * _loc36_;
                                 _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                 _loc30_ = _loc30_ * 5 + -430675100;
                                 _loc38_ = _loc30_ ^ _loc25_;
                                 _loc38_ ^= _loc38_ >>> 16;
                                 _loc38_ *= -2048144789;
                                 _loc38_ ^= _loc38_ >>> 13;
                                 _loc38_ *= -1028477387;
                                 _loc29_ = (_loc38_ ^ _loc38_ >>> 16) & 65535;
                                 _loc24_ = _loc34_.addr + _loc29_ * 5;
                                 if((_loc27_ = int(li8(_loc24_))) < 8 && _loc27_ >= 0)
                                 {
                                    _loc28_ = int(li32(_loc24_ + 1));
                                    si8(_loc25_,_loc24_);
                                    si32(_loc26_,_loc24_ + 1);
                                    _loc25_ = _loc27_ + 1;
                                    _loc26_ = int(_loc28_);
                                    _loc30_ = int(li32(_loc26_));
                                    si32(_loc30_,_loc34_.hashScratchAddr);
                                    _loc30_ = int(li32(_loc26_ + 4));
                                    si32(_loc30_,_loc34_.hashScratchAddr + 4);
                                    si32(0,_loc34_.hashScratchAddr + _loc25_);
                                    _loc30_ = 775236557;
                                    _loc35_ = -862048943;
                                    _loc36_ = 461845907;
                                    _loc37_ = li32(_loc34_.hashScratchAddr) * _loc35_;
                                    _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                                    _loc30_ ^= _loc37_ * _loc36_;
                                    _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                    _loc30_ = _loc30_ * 5 + -430675100;
                                    _loc37_ = li32(_loc34_.hashScratchAddr + 4) * _loc35_;
                                    _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                                    _loc30_ ^= _loc37_ * _loc36_;
                                    _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                    _loc30_ = _loc30_ * 5 + -430675100;
                                    _loc38_ = _loc30_ ^ _loc25_;
                                    _loc38_ ^= _loc38_ >>> 16;
                                    _loc38_ *= -2048144789;
                                    _loc38_ ^= _loc38_ >>> 13;
                                    _loc38_ *= -1028477387;
                                    _loc29_ = (_loc38_ ^ _loc38_ >>> 16) & 65535;
                                    _loc24_ = _loc34_.addr + _loc29_ * 5;
                                 }
                              }
                           }
                        }
                        si8(_loc25_,_loc24_);
                        si32(_loc26_,_loc24_ + 1);
                        _loc34_.resultAddr = _loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7);
                     }
                  }
                  if(li16(_loc34_.resultAddr) >= 4)
                  {
                     _loc13_ = int(li16(_loc34_.resultAddr));
                     _loc20_ = int(li16(scratchAddr + 2492 + (_loc13_ << 2) + 2));
                     _loc21_ = 0;
                     _loc22_ = scratchAddr + _loc21_ + (_loc20_ << 2);
                     _loc23_ = li32(_loc22_) + 1;
                     si32(_loc23_,_loc22_);
                     _loc20_ = int(li16(_loc34_.resultAddr + 2));
                     _loc14_ = int(li32(scratchAddr + 3528 + ((_loc20_ <= 256 ? _loc20_ : 256 + (_loc20_ - 1 >>> 7)) << 2)));
                     _loc20_ = scratchAddr + 1144 + (_loc14_ >>> 24 << 2);
                     _loc21_ = li32(_loc20_) + 1;
                     si32(_loc21_,_loc20_);
                     _loc20_ = li32(_loc34_.resultAddr) | 512;
                     si32(_loc20_,_loc19_);
                     _loc19_ += 4;
                     _loc15_ += _loc13_;
                  }
                  else
                  {
                     _loc11_ = int(li8(_loc15_));
                     si16(_loc11_,_loc19_);
                     _loc20_ = 0;
                     _loc21_ = scratchAddr + _loc20_ + (_loc11_ << 2);
                     _loc22_ = li32(_loc21_) + 1;
                     si32(_loc22_,_loc21_);
                     _loc19_ += 2;
                     _loc15_++;
                  }
               }
               while(_loc15_ < _loc9_)
               {
                  _loc23_ = 775236557;
                  _loc24_ = -862048943;
                  _loc25_ = 461845907;
                  _loc26_ = li32(_loc15_ + 1) * _loc24_;
                  _loc26_ = _loc26_ << 15 | _loc26_ >>> 17;
                  _loc23_ ^= _loc26_ * _loc25_;
                  _loc23_ = _loc23_ << 13 | _loc23_ >>> 19;
                  _loc23_ = _loc23_ * 5 + -430675100;
                  _loc27_ = _loc23_ ^ 4;
                  _loc27_ ^= _loc27_ >>> 16;
                  _loc27_ *= -2048144789;
                  _loc27_ ^= _loc27_ >>> 13;
                  _loc27_ *= -1028477387;
                  _loc22_ = (_loc27_ ^ _loc27_ >>> 16) & 65535;
                  _loc21_ = _loc34_.addr + _loc22_ * 5;
                  if(li16(_loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7)) < _loc34_.avgMatchLength + 4)
                  {
                     _loc22_ = _loc15_ + 1;
                     _loc23_ = 3;
                     _loc24_ = -1;
                     _loc26_ = int(li32(_loc21_ + 1));
                     if(_loc26_ >= 0 && li32(_loc22_) == li32(_loc26_) && _loc22_ - _loc26_ <= _loc34_.windowSize)
                     {
                        _loc27_ = _loc22_ + 4;
                        _loc25_ = 4;
                        _loc26_ += 4;
                        while(_loc27_ + 4 <= _loc7_ && li32(_loc26_) == li32(_loc27_) && _loc25_ + 4 <= _loc34_.maxMatchLength)
                        {
                           _loc25_ += 4;
                           _loc26_ += 4;
                           _loc27_ += 4;
                        }
                        while(_loc27_ < _loc7_ && li8(_loc26_) == li8(_loc27_) && _loc25_ < _loc34_.maxMatchLength)
                        {
                           _loc25_++;
                           _loc26_++;
                           _loc27_++;
                        }
                        _loc23_ = int(_loc25_);
                        _loc24_ = int(_loc26_);
                     }
                     _loc28_ = 5;
                     _loc29_ = 9;
                     while(_loc28_ < _loc29_)
                     {
                        _loc30_ = int(_loc28_++);
                        _loc37_ = int(li32(_loc22_));
                        si32(_loc37_,_loc34_.hashScratchAddr);
                        _loc37_ = int(li32(_loc22_ + 4));
                        si32(_loc37_,_loc34_.hashScratchAddr + 4);
                        si32(0,_loc34_.hashScratchAddr + _loc30_);
                        _loc37_ = 775236557;
                        _loc38_ = -862048943;
                        _loc39_ = 461845907;
                        _loc40_ = li32(_loc34_.hashScratchAddr) * _loc38_;
                        _loc40_ = _loc40_ << 15 | _loc40_ >>> 17;
                        _loc37_ ^= _loc40_ * _loc39_;
                        _loc37_ = _loc37_ << 13 | _loc37_ >>> 19;
                        _loc37_ = _loc37_ * 5 + -430675100;
                        _loc40_ = li32(_loc34_.hashScratchAddr + 4) * _loc38_;
                        _loc40_ = _loc40_ << 15 | _loc40_ >>> 17;
                        _loc37_ ^= _loc40_ * _loc39_;
                        _loc37_ = _loc37_ << 13 | _loc37_ >>> 19;
                        _loc37_ = _loc37_ * 5 + -430675100;
                        _loc41_ = _loc37_ ^ _loc30_;
                        _loc41_ ^= _loc41_ >>> 16;
                        _loc41_ *= -2048144789;
                        _loc41_ ^= _loc41_ >>> 13;
                        _loc41_ *= -1028477387;
                        _loc36_ = (_loc41_ ^ _loc41_ >>> 16) & 65535;
                        _loc35_ = _loc34_.addr + _loc36_ * 5 + 1;
                        _loc26_ = int(li32(_loc35_));
                        if(_loc26_ >= 0 && li32(_loc22_) == li32(_loc26_) && _loc22_ - _loc26_ <= _loc34_.windowSize)
                        {
                           _loc27_ = _loc22_ + 4;
                           _loc25_ = 4;
                           _loc26_ += 4;
                           while(_loc27_ + 4 <= _loc7_ && li32(_loc26_) == li32(_loc27_) && _loc25_ + 4 <= _loc34_.maxMatchLength)
                           {
                              _loc25_ += 4;
                              _loc26_ += 4;
                              _loc27_ += 4;
                           }
                           while(_loc27_ < _loc7_ && li8(_loc26_) == li8(_loc27_) && _loc25_ < _loc34_.maxMatchLength)
                           {
                              _loc25_++;
                              _loc26_++;
                              _loc27_++;
                           }
                           if(_loc25_ > _loc23_)
                           {
                              _loc23_ = int(_loc25_);
                              _loc24_ = int(_loc26_);
                           }
                        }
                     }
                     si32(_loc22_ - (_loc24_ - _loc23_) << 16 | _loc23_,_loc34_.resultAddr);
                  }
                  else
                  {
                     si32(0,_loc34_.resultAddr);
                  }
                  _loc22_ = int(_loc21_);
                  _loc23_ = 4;
                  _loc24_ = _loc15_ + 1;
                  if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                  {
                     _loc26_ = int(li32(_loc22_ + 1));
                     si8(_loc23_,_loc22_);
                     si32(_loc24_,_loc22_ + 1);
                     _loc23_ = _loc25_ + 1;
                     _loc24_ = int(_loc26_);
                     _loc28_ = int(li32(_loc24_));
                     si32(_loc28_,_loc34_.hashScratchAddr);
                     _loc28_ = int(li32(_loc24_ + 4));
                     si32(_loc28_,_loc34_.hashScratchAddr + 4);
                     si32(0,_loc34_.hashScratchAddr + _loc23_);
                     _loc28_ = 775236557;
                     _loc29_ = -862048943;
                     _loc30_ = 461845907;
                     _loc35_ = li32(_loc34_.hashScratchAddr) * _loc29_;
                     _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                     _loc28_ ^= _loc35_ * _loc30_;
                     _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                     _loc28_ = _loc28_ * 5 + -430675100;
                     _loc35_ = li32(_loc34_.hashScratchAddr + 4) * _loc29_;
                     _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                     _loc28_ ^= _loc35_ * _loc30_;
                     _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                     _loc28_ = _loc28_ * 5 + -430675100;
                     _loc36_ = _loc28_ ^ _loc23_;
                     _loc36_ ^= _loc36_ >>> 16;
                     _loc36_ *= -2048144789;
                     _loc36_ ^= _loc36_ >>> 13;
                     _loc36_ *= -1028477387;
                     _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                     _loc22_ = _loc34_.addr + _loc27_ * 5;
                     if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                     {
                        _loc26_ = int(li32(_loc22_ + 1));
                        si8(_loc23_,_loc22_);
                        si32(_loc24_,_loc22_ + 1);
                        _loc23_ = _loc25_ + 1;
                        _loc24_ = int(_loc26_);
                        _loc28_ = int(li32(_loc24_));
                        si32(_loc28_,_loc34_.hashScratchAddr);
                        _loc28_ = int(li32(_loc24_ + 4));
                        si32(_loc28_,_loc34_.hashScratchAddr + 4);
                        si32(0,_loc34_.hashScratchAddr + _loc23_);
                        _loc28_ = 775236557;
                        _loc29_ = -862048943;
                        _loc30_ = 461845907;
                        _loc35_ = li32(_loc34_.hashScratchAddr) * _loc29_;
                        _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                        _loc28_ ^= _loc35_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc35_ = li32(_loc34_.hashScratchAddr + 4) * _loc29_;
                        _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                        _loc28_ ^= _loc35_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc36_ = _loc28_ ^ _loc23_;
                        _loc36_ ^= _loc36_ >>> 16;
                        _loc36_ *= -2048144789;
                        _loc36_ ^= _loc36_ >>> 13;
                        _loc36_ *= -1028477387;
                        _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                        _loc22_ = _loc34_.addr + _loc27_ * 5;
                        if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                        {
                           _loc26_ = int(li32(_loc22_ + 1));
                           si8(_loc23_,_loc22_);
                           si32(_loc24_,_loc22_ + 1);
                           _loc23_ = _loc25_ + 1;
                           _loc24_ = int(_loc26_);
                           _loc28_ = int(li32(_loc24_));
                           si32(_loc28_,_loc34_.hashScratchAddr);
                           _loc28_ = int(li32(_loc24_ + 4));
                           si32(_loc28_,_loc34_.hashScratchAddr + 4);
                           si32(0,_loc34_.hashScratchAddr + _loc23_);
                           _loc28_ = 775236557;
                           _loc29_ = -862048943;
                           _loc30_ = 461845907;
                           _loc35_ = li32(_loc34_.hashScratchAddr) * _loc29_;
                           _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                           _loc28_ ^= _loc35_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc35_ = li32(_loc34_.hashScratchAddr + 4) * _loc29_;
                           _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                           _loc28_ ^= _loc35_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc36_ = _loc28_ ^ _loc23_;
                           _loc36_ ^= _loc36_ >>> 16;
                           _loc36_ *= -2048144789;
                           _loc36_ ^= _loc36_ >>> 13;
                           _loc36_ *= -1028477387;
                           _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                           _loc22_ = _loc34_.addr + _loc27_ * 5;
                           if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                           {
                              _loc26_ = int(li32(_loc22_ + 1));
                              si8(_loc23_,_loc22_);
                              si32(_loc24_,_loc22_ + 1);
                              _loc23_ = _loc25_ + 1;
                              _loc24_ = int(_loc26_);
                              _loc28_ = int(li32(_loc24_));
                              si32(_loc28_,_loc34_.hashScratchAddr);
                              _loc28_ = int(li32(_loc24_ + 4));
                              si32(_loc28_,_loc34_.hashScratchAddr + 4);
                              si32(0,_loc34_.hashScratchAddr + _loc23_);
                              _loc28_ = 775236557;
                              _loc29_ = -862048943;
                              _loc30_ = 461845907;
                              _loc35_ = li32(_loc34_.hashScratchAddr) * _loc29_;
                              _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                              _loc28_ ^= _loc35_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc35_ = li32(_loc34_.hashScratchAddr + 4) * _loc29_;
                              _loc35_ = _loc35_ << 15 | _loc35_ >>> 17;
                              _loc28_ ^= _loc35_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc36_ = _loc28_ ^ _loc23_;
                              _loc36_ ^= _loc36_ >>> 16;
                              _loc36_ *= -2048144789;
                              _loc36_ ^= _loc36_ >>> 13;
                              _loc36_ *= -1028477387;
                              _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                              _loc22_ = _loc34_.addr + _loc27_ * 5;
                           }
                        }
                     }
                  }
                  si8(_loc23_,_loc22_);
                  si32(_loc24_,_loc22_ + 1);
                  _loc34_.resultAddr = _loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7);
                  if(li16(_loc34_.resultAddr) >= 4)
                  {
                     _loc20_ = int(li16(_loc34_.resultAddr));
                     if(li16(_loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7)) > _loc20_)
                     {
                        si32(0,_loc34_.resultAddr);
                     }
                     else if(_loc15_ + _loc20_ + 9 < _loc7_)
                     {
                        if(_loc20_ < _loc34_.avgMatchLength + 4)
                        {
                           _loc22_ = _loc15_ + 1 + 1;
                           _loc23_ = _loc15_ + _loc20_;
                           while(_loc22_ < _loc23_)
                           {
                              _loc24_ = int(_loc22_++);
                              _loc25_ = 4;
                              _loc26_ = int(_loc24_);
                              _loc35_ = 775236557;
                              _loc36_ = -862048943;
                              _loc37_ = 461845907;
                              _loc38_ = li32(_loc24_) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc35_ ^= _loc38_ * _loc37_;
                              _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                              _loc35_ = _loc35_ * 5 + -430675100;
                              _loc39_ = _loc35_ ^ 4;
                              _loc39_ ^= _loc39_ >>> 16;
                              _loc39_ *= -2048144789;
                              _loc39_ ^= _loc39_ >>> 13;
                              _loc39_ *= -1028477387;
                              _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                              _loc29_ = _loc34_.addr + _loc30_ * 5;
                              if((_loc27_ = int(li8(_loc29_))) < 8 && _loc27_ >= 0)
                              {
                                 _loc28_ = int(li32(_loc29_ + 1));
                                 si8(_loc25_,_loc29_);
                                 si32(_loc26_,_loc29_ + 1);
                                 _loc25_ = _loc27_ + 1;
                                 _loc26_ = int(_loc28_);
                                 _loc35_ = int(li32(_loc26_));
                                 si32(_loc35_,_loc34_.hashScratchAddr);
                                 _loc35_ = int(li32(_loc26_ + 4));
                                 si32(_loc35_,_loc34_.hashScratchAddr + 4);
                                 si32(0,_loc34_.hashScratchAddr + _loc25_);
                                 _loc35_ = 775236557;
                                 _loc36_ = -862048943;
                                 _loc37_ = 461845907;
                                 _loc38_ = li32(_loc34_.hashScratchAddr) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc35_ ^= _loc38_ * _loc37_;
                                 _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                                 _loc35_ = _loc35_ * 5 + -430675100;
                                 _loc38_ = li32(_loc34_.hashScratchAddr + 4) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc35_ ^= _loc38_ * _loc37_;
                                 _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                                 _loc35_ = _loc35_ * 5 + -430675100;
                                 _loc39_ = _loc35_ ^ _loc25_;
                                 _loc39_ ^= _loc39_ >>> 16;
                                 _loc39_ *= -2048144789;
                                 _loc39_ ^= _loc39_ >>> 13;
                                 _loc39_ *= -1028477387;
                                 _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                 _loc29_ = _loc34_.addr + _loc30_ * 5;
                                 if((_loc27_ = int(li8(_loc29_))) < 8 && _loc27_ >= 0)
                                 {
                                    _loc28_ = int(li32(_loc29_ + 1));
                                    si8(_loc25_,_loc29_);
                                    si32(_loc26_,_loc29_ + 1);
                                    _loc25_ = _loc27_ + 1;
                                    _loc26_ = int(_loc28_);
                                    _loc35_ = int(li32(_loc26_));
                                    si32(_loc35_,_loc34_.hashScratchAddr);
                                    _loc35_ = int(li32(_loc26_ + 4));
                                    si32(_loc35_,_loc34_.hashScratchAddr + 4);
                                    si32(0,_loc34_.hashScratchAddr + _loc25_);
                                    _loc35_ = 775236557;
                                    _loc36_ = -862048943;
                                    _loc37_ = 461845907;
                                    _loc38_ = li32(_loc34_.hashScratchAddr) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc35_ ^= _loc38_ * _loc37_;
                                    _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                                    _loc35_ = _loc35_ * 5 + -430675100;
                                    _loc38_ = li32(_loc34_.hashScratchAddr + 4) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc35_ ^= _loc38_ * _loc37_;
                                    _loc35_ = _loc35_ << 13 | _loc35_ >>> 19;
                                    _loc35_ = _loc35_ * 5 + -430675100;
                                    _loc39_ = _loc35_ ^ _loc25_;
                                    _loc39_ ^= _loc39_ >>> 16;
                                    _loc39_ *= -2048144789;
                                    _loc39_ ^= _loc39_ >>> 13;
                                    _loc39_ *= -1028477387;
                                    _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                    _loc29_ = _loc34_.addr + _loc30_ * 5;
                                 }
                              }
                              si8(_loc25_,_loc29_);
                              si32(_loc26_,_loc29_ + 1);
                           }
                        }
                        _loc34_.resultAddr = _loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7);
                        _loc22_ = _loc15_ + _loc20_;
                        _loc25_ = 775236557;
                        _loc26_ = -862048943;
                        _loc27_ = 461845907;
                        _loc28_ = li32(_loc22_) * _loc26_;
                        _loc28_ = _loc28_ << 15 | _loc28_ >>> 17;
                        _loc25_ ^= _loc28_ * _loc27_;
                        _loc25_ = _loc25_ << 13 | _loc25_ >>> 19;
                        _loc25_ = _loc25_ * 5 + -430675100;
                        _loc29_ = _loc25_ ^ 4;
                        _loc29_ ^= _loc29_ >>> 16;
                        _loc29_ *= -2048144789;
                        _loc29_ ^= _loc29_ >>> 13;
                        _loc29_ *= -1028477387;
                        _loc24_ = (_loc29_ ^ _loc29_ >>> 16) & 65535;
                        _loc23_ = _loc34_.addr + _loc24_ * 5;
                        _loc24_ = 3;
                        _loc25_ = -1;
                        _loc27_ = int(li32(_loc23_ + 1));
                        if(_loc27_ >= 0 && li32(_loc22_) == li32(_loc27_) && _loc22_ - _loc27_ <= _loc34_.windowSize)
                        {
                           _loc28_ = _loc22_ + 4;
                           _loc26_ = 4;
                           _loc27_ += 4;
                           while(_loc28_ + 4 <= _loc7_ && li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc34_.maxMatchLength)
                           {
                              _loc26_ += 4;
                              _loc27_ += 4;
                              _loc28_ += 4;
                           }
                           while(_loc28_ < _loc7_ && li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc34_.maxMatchLength)
                           {
                              _loc26_++;
                              _loc27_++;
                              _loc28_++;
                           }
                           _loc24_ = int(_loc26_);
                           _loc25_ = int(_loc27_);
                        }
                        _loc29_ = 5;
                        _loc30_ = 9;
                        while(_loc29_ < _loc30_)
                        {
                           _loc35_ = int(_loc29_++);
                           _loc38_ = int(li32(_loc22_));
                           si32(_loc38_,_loc34_.hashScratchAddr);
                           _loc38_ = int(li32(_loc22_ + 4));
                           si32(_loc38_,_loc34_.hashScratchAddr + 4);
                           si32(0,_loc34_.hashScratchAddr + _loc35_);
                           _loc38_ = 775236557;
                           _loc39_ = -862048943;
                           _loc40_ = 461845907;
                           _loc41_ = li32(_loc34_.hashScratchAddr) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc41_ = li32(_loc34_.hashScratchAddr + 4) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc42_ = _loc38_ ^ _loc35_;
                           _loc42_ ^= _loc42_ >>> 16;
                           _loc42_ *= -2048144789;
                           _loc42_ ^= _loc42_ >>> 13;
                           _loc42_ *= -1028477387;
                           _loc37_ = (_loc42_ ^ _loc42_ >>> 16) & 65535;
                           _loc36_ = _loc34_.addr + _loc37_ * 5 + 1;
                           _loc27_ = int(li32(_loc36_));
                           if(_loc27_ >= 0 && li32(_loc22_) == li32(_loc27_) && _loc22_ - _loc27_ <= _loc34_.windowSize)
                           {
                              _loc28_ = _loc22_ + 4;
                              _loc26_ = 4;
                              _loc27_ += 4;
                              while(_loc28_ + 4 <= _loc7_ && li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc34_.maxMatchLength)
                              {
                                 _loc26_ += 4;
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                              }
                              while(_loc28_ < _loc7_ && li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc34_.maxMatchLength)
                              {
                                 _loc26_++;
                                 _loc27_++;
                                 _loc28_++;
                              }
                              if(_loc26_ > _loc24_)
                              {
                                 _loc24_ = int(_loc26_);
                                 _loc25_ = int(_loc27_);
                              }
                           }
                        }
                        si32(_loc22_ - (_loc25_ - _loc24_) << 16 | _loc24_,_loc34_.resultAddr);
                        _loc24_ = int(_loc23_);
                        _loc25_ = 4;
                        _loc26_ = int(_loc22_);
                        if((_loc27_ = int(li8(_loc24_))) < 8 && _loc27_ >= 0)
                        {
                           _loc28_ = int(li32(_loc24_ + 1));
                           si8(_loc25_,_loc24_);
                           si32(_loc26_,_loc24_ + 1);
                           _loc25_ = _loc27_ + 1;
                           _loc26_ = int(_loc28_);
                           _loc30_ = int(li32(_loc26_));
                           si32(_loc30_,_loc34_.hashScratchAddr);
                           _loc30_ = int(li32(_loc26_ + 4));
                           si32(_loc30_,_loc34_.hashScratchAddr + 4);
                           si32(0,_loc34_.hashScratchAddr + _loc25_);
                           _loc30_ = 775236557;
                           _loc35_ = -862048943;
                           _loc36_ = 461845907;
                           _loc37_ = li32(_loc34_.hashScratchAddr) * _loc35_;
                           _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                           _loc30_ ^= _loc37_ * _loc36_;
                           _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                           _loc30_ = _loc30_ * 5 + -430675100;
                           _loc37_ = li32(_loc34_.hashScratchAddr + 4) * _loc35_;
                           _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                           _loc30_ ^= _loc37_ * _loc36_;
                           _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                           _loc30_ = _loc30_ * 5 + -430675100;
                           _loc38_ = _loc30_ ^ _loc25_;
                           _loc38_ ^= _loc38_ >>> 16;
                           _loc38_ *= -2048144789;
                           _loc38_ ^= _loc38_ >>> 13;
                           _loc38_ *= -1028477387;
                           _loc29_ = (_loc38_ ^ _loc38_ >>> 16) & 65535;
                           _loc24_ = _loc34_.addr + _loc29_ * 5;
                           if((_loc27_ = int(li8(_loc24_))) < 8 && _loc27_ >= 0)
                           {
                              _loc28_ = int(li32(_loc24_ + 1));
                              si8(_loc25_,_loc24_);
                              si32(_loc26_,_loc24_ + 1);
                              _loc25_ = _loc27_ + 1;
                              _loc26_ = int(_loc28_);
                              _loc30_ = int(li32(_loc26_));
                              si32(_loc30_,_loc34_.hashScratchAddr);
                              _loc30_ = int(li32(_loc26_ + 4));
                              si32(_loc30_,_loc34_.hashScratchAddr + 4);
                              si32(0,_loc34_.hashScratchAddr + _loc25_);
                              _loc30_ = 775236557;
                              _loc35_ = -862048943;
                              _loc36_ = 461845907;
                              _loc37_ = li32(_loc34_.hashScratchAddr) * _loc35_;
                              _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                              _loc30_ ^= _loc37_ * _loc36_;
                              _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                              _loc30_ = _loc30_ * 5 + -430675100;
                              _loc37_ = li32(_loc34_.hashScratchAddr + 4) * _loc35_;
                              _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                              _loc30_ ^= _loc37_ * _loc36_;
                              _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                              _loc30_ = _loc30_ * 5 + -430675100;
                              _loc38_ = _loc30_ ^ _loc25_;
                              _loc38_ ^= _loc38_ >>> 16;
                              _loc38_ *= -2048144789;
                              _loc38_ ^= _loc38_ >>> 13;
                              _loc38_ *= -1028477387;
                              _loc29_ = (_loc38_ ^ _loc38_ >>> 16) & 65535;
                              _loc24_ = _loc34_.addr + _loc29_ * 5;
                              if((_loc27_ = int(li8(_loc24_))) < 8 && _loc27_ >= 0)
                              {
                                 _loc28_ = int(li32(_loc24_ + 1));
                                 si8(_loc25_,_loc24_);
                                 si32(_loc26_,_loc24_ + 1);
                                 _loc25_ = _loc27_ + 1;
                                 _loc26_ = int(_loc28_);
                                 _loc30_ = int(li32(_loc26_));
                                 si32(_loc30_,_loc34_.hashScratchAddr);
                                 _loc30_ = int(li32(_loc26_ + 4));
                                 si32(_loc30_,_loc34_.hashScratchAddr + 4);
                                 si32(0,_loc34_.hashScratchAddr + _loc25_);
                                 _loc30_ = 775236557;
                                 _loc35_ = -862048943;
                                 _loc36_ = 461845907;
                                 _loc37_ = li32(_loc34_.hashScratchAddr) * _loc35_;
                                 _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                                 _loc30_ ^= _loc37_ * _loc36_;
                                 _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                 _loc30_ = _loc30_ * 5 + -430675100;
                                 _loc37_ = li32(_loc34_.hashScratchAddr + 4) * _loc35_;
                                 _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                                 _loc30_ ^= _loc37_ * _loc36_;
                                 _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                 _loc30_ = _loc30_ * 5 + -430675100;
                                 _loc38_ = _loc30_ ^ _loc25_;
                                 _loc38_ ^= _loc38_ >>> 16;
                                 _loc38_ *= -2048144789;
                                 _loc38_ ^= _loc38_ >>> 13;
                                 _loc38_ *= -1028477387;
                                 _loc29_ = (_loc38_ ^ _loc38_ >>> 16) & 65535;
                                 _loc24_ = _loc34_.addr + _loc29_ * 5;
                                 if((_loc27_ = int(li8(_loc24_))) < 8 && _loc27_ >= 0)
                                 {
                                    _loc28_ = int(li32(_loc24_ + 1));
                                    si8(_loc25_,_loc24_);
                                    si32(_loc26_,_loc24_ + 1);
                                    _loc25_ = _loc27_ + 1;
                                    _loc26_ = int(_loc28_);
                                    _loc30_ = int(li32(_loc26_));
                                    si32(_loc30_,_loc34_.hashScratchAddr);
                                    _loc30_ = int(li32(_loc26_ + 4));
                                    si32(_loc30_,_loc34_.hashScratchAddr + 4);
                                    si32(0,_loc34_.hashScratchAddr + _loc25_);
                                    _loc30_ = 775236557;
                                    _loc35_ = -862048943;
                                    _loc36_ = 461845907;
                                    _loc37_ = li32(_loc34_.hashScratchAddr) * _loc35_;
                                    _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                                    _loc30_ ^= _loc37_ * _loc36_;
                                    _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                    _loc30_ = _loc30_ * 5 + -430675100;
                                    _loc37_ = li32(_loc34_.hashScratchAddr + 4) * _loc35_;
                                    _loc37_ = _loc37_ << 15 | _loc37_ >>> 17;
                                    _loc30_ ^= _loc37_ * _loc36_;
                                    _loc30_ = _loc30_ << 13 | _loc30_ >>> 19;
                                    _loc30_ = _loc30_ * 5 + -430675100;
                                    _loc38_ = _loc30_ ^ _loc25_;
                                    _loc38_ ^= _loc38_ >>> 16;
                                    _loc38_ *= -2048144789;
                                    _loc38_ ^= _loc38_ >>> 13;
                                    _loc38_ *= -1028477387;
                                    _loc29_ = (_loc38_ ^ _loc38_ >>> 16) & 65535;
                                    _loc24_ = _loc34_.addr + _loc29_ * 5;
                                 }
                              }
                           }
                        }
                        si8(_loc25_,_loc24_);
                        si32(_loc26_,_loc24_ + 1);
                        _loc34_.resultAddr = _loc34_.baseResultAddr + (_loc34_.resultAddr - _loc34_.baseResultAddr + 4 & 7);
                     }
                  }
                  if(li16(_loc34_.resultAddr) >= 4)
                  {
                     _loc13_ = int(li16(_loc34_.resultAddr));
                     _loc20_ = int(li16(scratchAddr + 2492 + (_loc13_ << 2) + 2));
                     _loc21_ = 0;
                     _loc22_ = scratchAddr + _loc21_ + (_loc20_ << 2);
                     _loc23_ = li32(_loc22_) + 1;
                     si32(_loc23_,_loc22_);
                     _loc20_ = int(li16(_loc34_.resultAddr + 2));
                     _loc14_ = int(li32(scratchAddr + 3528 + ((_loc20_ <= 256 ? _loc20_ : 256 + (_loc20_ - 1 >>> 7)) << 2)));
                     _loc20_ = scratchAddr + 1144 + (_loc14_ >>> 24 << 2);
                     _loc21_ = li32(_loc20_) + 1;
                     si32(_loc21_,_loc20_);
                     _loc20_ = li32(_loc34_.resultAddr) | 512;
                     si32(_loc20_,_loc19_);
                     _loc19_ += 4;
                     _loc15_ += _loc13_;
                  }
                  else
                  {
                     _loc11_ = int(li8(_loc15_));
                     si16(_loc11_,_loc19_);
                     _loc20_ = 0;
                     _loc21_ = scratchAddr + _loc20_ + (_loc11_ << 2);
                     _loc22_ = li32(_loc21_) + 1;
                     si32(_loc22_,_loc21_);
                     _loc19_ += 2;
                     _loc15_++;
                  }
               }
               while(_loc15_ < _loc7_)
               {
                  _loc11_ = int(li8(_loc15_));
                  si16(_loc11_,_loc19_);
                  _loc20_ = 0;
                  _loc21_ = scratchAddr + _loc20_ + (_loc11_ << 2);
                  _loc22_ = li32(_loc21_) + 1;
                  si32(_loc22_,_loc21_);
                  _loc19_ += 2;
                  _loc15_++;
               }
               _loc10_ = false;
               blockInProgress = true;
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  if(bitOffset == 0)
                  {
                     si8(0,currentAddr);
                  }
                  _loc20_ = int(li8(currentAddr));
                  _loc20_ |= (!!_loc10_ ? 1 : 0) << bitOffset;
                  si32(_loc20_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  if(bitOffset > 0)
                  {
                     _loc20_ = int(li8(currentAddr));
                     _loc20_ |= 0 << bitOffset;
                     si32(_loc20_,currentAddr);
                     bitOffset += 8 - bitOffset;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
               }
               else
               {
                  _loc20_ = int(li8(currentAddr));
                  _loc20_ |= (4 | (!!_loc10_ ? 1 : 0)) << bitOffset;
                  si32(_loc20_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockStartAddr = currentAddr;
               createAndWriteHuffmanTrees(_loc6_,_loc7_);
               _loc15_ = int(_loc18_);
               while(_loc15_ + 64 <= _loc19_)
               {
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
               }
               while(_loc15_ < _loc19_)
               {
                  _loc24_ = int(li16(_loc15_));
                  if((_loc24_ & 512) != 0)
                  {
                     _loc20_ = _loc24_ ^ 512;
                     _loc22_ = int(li32(scratchAddr + 2492 + (_loc20_ << 2)));
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + (_loc22_ >>> 16) * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc20_ - (_loc22_ & 8191) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc22_ & 65280) >>> 13;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc21_ = int(li16(_loc15_ + 2));
                     _loc23_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                     _loc25_ = int(li32(scratchAddr + 1144 + (_loc23_ >>> 24) * 4));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc25_ = int(li8(currentAddr));
                     _loc25_ |= _loc21_ - (_loc23_ & 65535) << bitOffset;
                     si32(_loc25_,currentAddr);
                     bitOffset += (_loc23_ & 16711680) >>> 16;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  else
                  {
                     _loc25_ = 0;
                     _loc26_ = int(li32(scratchAddr + _loc25_ + _loc24_ * 4));
                     _loc27_ = int(li8(currentAddr));
                     _loc27_ |= _loc26_ >>> 16 << bitOffset;
                     si32(_loc27_,currentAddr);
                     bitOffset += _loc26_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  _loc11_ = int(_loc24_);
                  _loc15_ += 2 + ((_loc11_ & 512) >>> 8);
               }
               if(level != CompressionLevel.UNCOMPRESSED)
               {
                  _loc20_ = 0;
                  _loc21_ = int(li32(scratchAddr + _loc20_ + 1024));
                  _loc22_ = int(li8(currentAddr));
                  _loc22_ |= _loc21_ >>> 16 << bitOffset;
                  si32(_loc22_,currentAddr);
                  bitOffset += _loc21_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockInProgress = false;
               _loc6_ = int(_loc7_);
            }
         }
      }
      
      public function _fastWrite(param1:int, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc8_:* = null as ByteArray;
         var _loc9_:uint = 0;
         var _loc10_:* = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc35_:* = null as LZHash;
         var _loc36_:* = 0;
         var _loc37_:* = 0;
         var _loc38_:* = 0;
         var _loc39_:* = 0;
         var _loc40_:* = 0;
         var _loc41_:* = 0;
         var _loc42_:* = 0;
         var _loc43_:* = 0;
         if(level == CompressionLevel.UNCOMPRESSED)
         {
            _loc3_ = int(param1);
            if(zlib)
            {
               _loc4_ = int(_loc3_);
               while(_loc4_ + 5552 <= param2)
               {
                  _loc5_ = int(_loc4_);
                  while(_loc5_ < _loc4_ + 5552)
                  {
                     s2 += (s1 << 4) + li8(_loc5_) * 16 + li8(_loc5_ + 1) * 15 + li8(_loc5_ + 2) * 14 + li8(_loc5_ + 3) * 13 + li8(_loc5_ + 4) * 12 + li8(_loc5_ + 5) * 11 + li8(_loc5_ + 6) * 10 + li8(_loc5_ + 7) * 9 + li8(_loc5_ + 8) * 8 + li8(_loc5_ + 9) * 7 + li8(_loc5_ + 10) * 6 + li8(_loc5_ + 11) * 5 + li8(_loc5_ + 12) * 4 + li8(_loc5_ + 13) * 3 + li8(_loc5_ + 14) * 2 + li8(_loc5_ + 15);
                     s1 += li8(_loc5_) + li8(_loc5_ + 1) + li8(_loc5_ + 2) + li8(_loc5_ + 3) + li8(_loc5_ + 4) + li8(_loc5_ + 5) + li8(_loc5_ + 6) + li8(_loc5_ + 7) + li8(_loc5_ + 8) + li8(_loc5_ + 9) + li8(_loc5_ + 10) + li8(_loc5_ + 11) + li8(_loc5_ + 12) + li8(_loc5_ + 13) + li8(_loc5_ + 14) + li8(_loc5_ + 15);
                     _loc5_ += 16;
                  }
                  s1 %= 65521;
                  s2 %= 65521;
                  _loc4_ += 5552;
               }
               if(_loc4_ != param2)
               {
                  _loc5_ = int(_loc4_);
                  while(_loc5_ < param2)
                  {
                     _loc6_ = int(_loc5_++);
                     s1 += li8(_loc6_);
                     s2 += s1;
                  }
                  s1 %= 65521;
                  s2 %= 65521;
               }
            }
            _loc4_ = 8;
            _loc5_ = param2 - _loc3_;
            _loc6_ = int(Math.ceil(_loc5_ / 65535));
            _loc7_ = _loc5_ + _loc4_ * _loc6_;
            _loc8_ = ApplicationDomain.currentDomain.domainMemory;
            _loc9_ = uint(_loc8_.length - currentAddr);
            if(_loc9_ < _loc7_)
            {
               _loc8_.length = uint(currentAddr + _loc7_);
               ApplicationDomain.currentDomain.domainMemory = _loc8_;
            }
            while(param2 - _loc3_ > 0)
            {
               _loc11_ = Number(Math.min(param2 - _loc3_,65535));
               _loc10_ = int(_loc11_);
               _loc12_ = false;
               blockInProgress = true;
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  if(bitOffset == 0)
                  {
                     si8(0,currentAddr);
                  }
                  _loc13_ = int(li8(currentAddr));
                  _loc13_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                  si32(_loc13_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
                  if(bitOffset > 0)
                  {
                     _loc13_ = int(li8(currentAddr));
                     _loc13_ |= 0 << bitOffset;
                     si32(_loc13_,currentAddr);
                     bitOffset += 8 - bitOffset;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
               }
               else
               {
                  _loc13_ = int(li8(currentAddr));
                  _loc13_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                  si32(_loc13_,currentAddr);
                  bitOffset += 3;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockStartAddr = currentAddr;
               si16(_loc10_,currentAddr);
               currentAddr += 2;
               si16(~_loc10_,currentAddr);
               currentAddr += 2;
               _loc13_ = _loc3_ + _loc10_;
               _loc14_ = _loc3_ + (_loc10_ & -32);
               _loc15_ = int(_loc3_);
               while(_loc15_ < _loc14_)
               {
                  _loc16_ = int(li32(_loc15_));
                  si32(_loc16_,currentAddr);
                  _loc16_ = int(li32(_loc15_ + 4));
                  si32(_loc16_,currentAddr + 4);
                  _loc16_ = int(li32(_loc15_ + 8));
                  si32(_loc16_,currentAddr + 8);
                  _loc16_ = int(li32(_loc15_ + 12));
                  si32(_loc16_,currentAddr + 12);
                  _loc16_ = int(li32(_loc15_ + 16));
                  si32(_loc16_,currentAddr + 16);
                  _loc16_ = int(li32(_loc15_ + 20));
                  si32(_loc16_,currentAddr + 20);
                  _loc16_ = int(li32(_loc15_ + 24));
                  si32(_loc16_,currentAddr + 24);
                  _loc16_ = int(li32(_loc15_ + 28));
                  si32(_loc16_,currentAddr + 28);
                  currentAddr += 32;
                  _loc15_ += 32;
               }
               while(_loc15_ < _loc13_)
               {
                  _loc16_ = int(li8(_loc15_));
                  si8(_loc16_,currentAddr);
                  currentAddr = currentAddr + 1;
                  _loc15_++;
               }
               if(level != CompressionLevel.UNCOMPRESSED)
               {
                  _loc16_ = 0;
                  _loc17_ = int(li32(scratchAddr + _loc16_ + 1024));
                  _loc18_ = int(li8(currentAddr));
                  _loc18_ |= _loc17_ >>> 16 << bitOffset;
                  si32(_loc18_,currentAddr);
                  bitOffset += _loc17_ & 65535;
                  currentAddr += bitOffset >>> 3;
                  bitOffset &= 7;
               }
               blockInProgress = false;
               _loc3_ += _loc10_;
            }
         }
         else
         {
            _loc3_ = param2 - param1;
            _loc8_ = ApplicationDomain.currentDomain.domainMemory;
            _loc6_ = 1;
            _loc10_ = 0;
            if(level == CompressionLevel.UNCOMPRESSED)
            {
               _loc5_ = 8;
               _loc4_ = int(Math.ceil(_loc3_ / 65535));
            }
            else
            {
               if(level == CompressionLevel.FAST)
               {
                  _loc4_ = int(Math.ceil(_loc3_ * 2 / 49152));
               }
               else
               {
                  _loc4_ = int(Math.ceil(_loc3_ / 98304));
                  if(level == CompressionLevel.NORMAL)
                  {
                     _loc10_ = 458752;
                  }
                  else if(level == CompressionLevel.GOOD)
                  {
                     _loc10_ = 524308;
                  }
               }
               _loc6_ = 2;
               _loc5_ = 300;
            }
            _loc7_ = _loc3_ * _loc6_ + _loc5_ * (_loc4_ + 1) + _loc10_ + currentAddr;
            if(_loc7_ > _loc8_.length)
            {
               _loc6_ = 1;
               _loc10_ = 0;
               §§push(_loc8_);
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  _loc5_ = 8;
                  _loc4_ = int(Math.ceil(_loc3_ / 65535));
               }
               else
               {
                  if(level == CompressionLevel.FAST)
                  {
                     _loc4_ = int(Math.ceil(_loc3_ * 2 / 49152));
                  }
                  else
                  {
                     _loc4_ = int(Math.ceil(_loc3_ / 98304));
                     if(level == CompressionLevel.NORMAL)
                     {
                        _loc10_ = 458752;
                     }
                     else if(level == CompressionLevel.GOOD)
                     {
                        _loc10_ = 524308;
                     }
                  }
                  _loc6_ = 2;
                  _loc5_ = 300;
               }
               §§pop().length = _loc3_ * _loc6_ + _loc5_ * (_loc4_ + 1) + _loc10_ + currentAddr;
               ApplicationDomain.currentDomain.domainMemory = _loc8_;
            }
            if(zlib)
            {
               _loc4_ = int(param1);
               while(_loc4_ + 5552 <= param2)
               {
                  _loc5_ = int(_loc4_);
                  while(_loc5_ < _loc4_ + 5552)
                  {
                     s2 += (s1 << 4) + li8(_loc5_) * 16 + li8(_loc5_ + 1) * 15 + li8(_loc5_ + 2) * 14 + li8(_loc5_ + 3) * 13 + li8(_loc5_ + 4) * 12 + li8(_loc5_ + 5) * 11 + li8(_loc5_ + 6) * 10 + li8(_loc5_ + 7) * 9 + li8(_loc5_ + 8) * 8 + li8(_loc5_ + 9) * 7 + li8(_loc5_ + 10) * 6 + li8(_loc5_ + 11) * 5 + li8(_loc5_ + 12) * 4 + li8(_loc5_ + 13) * 3 + li8(_loc5_ + 14) * 2 + li8(_loc5_ + 15);
                     s1 += li8(_loc5_) + li8(_loc5_ + 1) + li8(_loc5_ + 2) + li8(_loc5_ + 3) + li8(_loc5_ + 4) + li8(_loc5_ + 5) + li8(_loc5_ + 6) + li8(_loc5_ + 7) + li8(_loc5_ + 8) + li8(_loc5_ + 9) + li8(_loc5_ + 10) + li8(_loc5_ + 11) + li8(_loc5_ + 12) + li8(_loc5_ + 13) + li8(_loc5_ + 14) + li8(_loc5_ + 15);
                     _loc5_ += 16;
                  }
                  s1 %= 65521;
                  s2 %= 65521;
                  _loc4_ += 5552;
               }
               if(_loc4_ != param2)
               {
                  _loc5_ = int(_loc4_);
                  while(_loc5_ < param2)
                  {
                     _loc6_ = int(_loc5_++);
                     s1 += li8(_loc6_);
                     s2 += s1;
                  }
                  s1 %= 65521;
                  s2 %= 65521;
               }
            }
            if(level == CompressionLevel.FAST)
            {
               _loc4_ = int(param1);
               _loc5_ = 2048;
               _loc6_ = int(_loc4_);
               while(param2 - _loc4_ > _loc5_)
               {
                  _loc10_ = _loc4_ + _loc5_;
                  if(!blockInProgress)
                  {
                     _loc12_ = false;
                     blockInProgress = true;
                     if(level == CompressionLevel.UNCOMPRESSED)
                     {
                        if(bitOffset == 0)
                        {
                           si8(0,currentAddr);
                        }
                        _loc13_ = int(li8(currentAddr));
                        _loc13_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                        si32(_loc13_,currentAddr);
                        bitOffset += 3;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        if(bitOffset > 0)
                        {
                           _loc13_ = int(li8(currentAddr));
                           _loc13_ |= 0 << bitOffset;
                           si32(_loc13_,currentAddr);
                           bitOffset += 8 - bitOffset;
                           currentAddr += bitOffset >>> 3;
                           bitOffset &= 7;
                        }
                     }
                     else
                     {
                        _loc13_ = int(li8(currentAddr));
                        _loc13_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                        si32(_loc13_,currentAddr);
                        bitOffset += 3;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     blockStartAddr = currentAddr;
                     _loc11_ = Number(Math.min(param2,_loc4_ + 98304));
                     createAndWriteHuffmanTrees(_loc4_,int(_loc11_));
                  }
                  while(_loc6_ < _loc10_)
                  {
                     _loc13_ = int(li8(_loc6_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                     _loc14_ = int(_loc6_);
                     _loc13_ = int(li8(_loc14_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                  }
                  _loc4_ += _loc5_;
                  if((!!blockInProgress ? currentAddr - blockStartAddr : 0) > 49152)
                  {
                     if(level != CompressionLevel.UNCOMPRESSED)
                     {
                        _loc13_ = 0;
                        _loc14_ = int(li32(scratchAddr + _loc13_ + 1024));
                        _loc15_ = int(li8(currentAddr));
                        _loc15_ |= _loc14_ >>> 16 << bitOffset;
                        si32(_loc15_,currentAddr);
                        bitOffset += _loc14_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     blockInProgress = false;
                  }
               }
               if(_loc6_ < param2)
               {
                  if(!blockInProgress)
                  {
                     _loc12_ = false;
                     blockInProgress = true;
                     if(level == CompressionLevel.UNCOMPRESSED)
                     {
                        if(bitOffset == 0)
                        {
                           si8(0,currentAddr);
                        }
                        _loc13_ = int(li8(currentAddr));
                        _loc13_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                        si32(_loc13_,currentAddr);
                        bitOffset += 3;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        if(bitOffset > 0)
                        {
                           _loc13_ = int(li8(currentAddr));
                           _loc13_ |= 0 << bitOffset;
                           si32(_loc13_,currentAddr);
                           bitOffset += 8 - bitOffset;
                           currentAddr += bitOffset >>> 3;
                           bitOffset &= 7;
                        }
                     }
                     else
                     {
                        _loc13_ = int(li8(currentAddr));
                        _loc13_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                        si32(_loc13_,currentAddr);
                        bitOffset += 3;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     blockStartAddr = currentAddr;
                     createAndWriteHuffmanTrees(_loc4_,param2);
                  }
                  while(_loc6_ < param2)
                  {
                     _loc13_ = int(li8(_loc6_));
                     _loc14_ = 0;
                     _loc15_ = int(li32(scratchAddr + _loc14_ + _loc13_ * 4));
                     _loc16_ = int(li8(currentAddr));
                     _loc16_ |= _loc15_ >>> 16 << bitOffset;
                     si32(_loc16_,currentAddr);
                     bitOffset += _loc15_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     _loc6_++;
                  }
                  if((!!blockInProgress ? currentAddr - blockStartAddr : 0) > 49152)
                  {
                     if(level != CompressionLevel.UNCOMPRESSED)
                     {
                        _loc13_ = 0;
                        _loc14_ = int(li32(scratchAddr + _loc13_ + 1024));
                        _loc15_ = int(li8(currentAddr));
                        _loc15_ |= _loc14_ >>> 16 << bitOffset;
                        si32(_loc15_,currentAddr);
                        bitOffset += _loc14_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     blockInProgress = false;
                  }
               }
            }
            else if(level == CompressionLevel.NORMAL)
            {
               _loc4_ = int(param1);
               _loc22_ = param2 - _loc4_;
               _loc25_ = 1;
               _loc26_ = 0;
               §§push(currentAddr);
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  _loc24_ = 8;
                  _loc23_ = int(Math.ceil(_loc22_ / 65535));
               }
               else
               {
                  if(level == CompressionLevel.FAST)
                  {
                     _loc23_ = int(Math.ceil(_loc22_ * 2 / 49152));
                  }
                  else
                  {
                     _loc23_ = int(Math.ceil(_loc22_ / 98304));
                     if(level == CompressionLevel.NORMAL)
                     {
                        _loc26_ = 458752;
                     }
                     else if(level == CompressionLevel.GOOD)
                     {
                        _loc26_ = 524308;
                     }
                  }
                  _loc25_ = 2;
                  _loc24_ = 300;
               }
               _loc21_ = §§pop() + (_loc22_ * _loc25_ + _loc24_ * (_loc23_ + 1) + _loc26_) - 262144;
               _loc22_ = _loc21_ - 196608;
               _loc17_ = _loc21_ + 262144 - 32;
               while(_loc17_ >= _loc21_)
               {
                  si32(-1,_loc17_);
                  si32(-1,_loc17_ + 4);
                  si32(-1,_loc17_ + 8);
                  si32(-1,_loc17_ + 12);
                  si32(-1,_loc17_ + 16);
                  si32(-1,_loc17_ + 20);
                  si32(-1,_loc17_ + 24);
                  si32(-1,_loc17_ + 28);
                  _loc17_ -= 32;
               }
               while(param2 - _loc4_ > 0)
               {
                  _loc11_ = Number(Math.min(param2,_loc4_ + 98304));
                  _loc5_ = int(_loc11_);
                  _loc6_ = _loc5_ - 4;
                  _loc24_ = 0;
                  while(_loc24_ < 286)
                  {
                     _loc25_ = int(_loc24_++);
                     si32(0,scratchAddr + (_loc25_ << 2));
                  }
                  _loc24_ = 0;
                  while(_loc24_ < 30)
                  {
                     _loc25_ = int(_loc24_++);
                     si32(0,scratchAddr + 1144 + (_loc25_ << 2));
                  }
                  _loc23_ = int(_loc22_);
                  _loc17_ = int(_loc4_);
                  while(_loc17_ < _loc6_)
                  {
                     _loc24_ = 775236557;
                     _loc25_ = -862048943;
                     _loc26_ = 461845907;
                     _loc27_ = li32(_loc17_) * _loc25_;
                     _loc27_ = _loc27_ << 15 | _loc27_ >>> 17;
                     _loc24_ ^= _loc27_ * _loc26_;
                     _loc24_ = _loc24_ << 13 | _loc24_ >>> 19;
                     _loc24_ = _loc24_ * 5 + -430675100;
                     _loc28_ = _loc24_ ^ 4;
                     _loc28_ ^= _loc28_ >>> 16;
                     _loc28_ *= -2048144789;
                     _loc28_ ^= _loc28_ >>> 13;
                     _loc28_ *= -1028477387;
                     _loc16_ = ((_loc28_ ^ _loc28_ >>> 16) & 65535) << 2;
                     _loc18_ = int(li32(_loc21_ + _loc16_));
                     if(_loc18_ >= 0 && li32(_loc18_) == li32(_loc17_))
                     {
                        _loc13_ = 4;
                        _loc18_ += 4;
                        _loc20_ = _loc17_ + 4;
                        while(_loc20_ < _loc5_ && li8(_loc18_) == li8(_loc20_) && _loc13_ < 258)
                        {
                           _loc18_++;
                           _loc20_++;
                           _loc13_++;
                        }
                        si32(_loc17_,_loc21_ + _loc16_);
                        _loc14_ = _loc20_ - _loc18_;
                        if(_loc14_ <= 32768)
                        {
                           _loc24_ = int(li16(scratchAddr + 2492 + (_loc13_ << 2) + 2));
                           _loc25_ = 0;
                           _loc26_ = scratchAddr + _loc25_ + (_loc24_ << 2);
                           _loc27_ = li32(_loc26_) + 1;
                           si32(_loc27_,_loc26_);
                           _loc15_ = int(li32(scratchAddr + 3528 + ((_loc14_ <= 256 ? _loc14_ : 256 + (_loc14_ - 1 >>> 7)) << 2)));
                           _loc24_ = scratchAddr + 1144 + (_loc15_ >>> 24 << 2);
                           _loc25_ = li32(_loc24_) + 1;
                           si32(_loc25_,_loc24_);
                           si32(_loc13_ | 512 | _loc14_ << 16,_loc23_);
                           _loc23_ += 4;
                           _loc17_ += _loc13_;
                           if(_loc17_ < _loc6_)
                           {
                              _loc25_ = 775236557;
                              _loc26_ = -862048943;
                              _loc27_ = 461845907;
                              _loc28_ = li32(_loc17_ - 1) * _loc26_;
                              _loc28_ = _loc28_ << 15 | _loc28_ >>> 17;
                              _loc25_ ^= _loc28_ * _loc27_;
                              _loc25_ = _loc25_ << 13 | _loc25_ >>> 19;
                              _loc25_ = _loc25_ * 5 + -430675100;
                              _loc29_ = _loc25_ ^ 4;
                              _loc29_ ^= _loc29_ >>> 16;
                              _loc29_ *= -2048144789;
                              _loc29_ ^= _loc29_ >>> 13;
                              _loc29_ *= -1028477387;
                              _loc24_ = _loc21_ + (((_loc29_ ^ _loc29_ >>> 16) & 65535) << 2);
                              si32(_loc17_ - 1,_loc24_);
                           }
                        }
                        else
                        {
                           _loc10_ = int(li8(_loc17_));
                           si16(_loc10_,_loc23_);
                           _loc24_ = 0;
                           _loc25_ = scratchAddr + _loc24_ + (_loc10_ << 2);
                           _loc26_ = li32(_loc25_) + 1;
                           si32(_loc26_,_loc25_);
                           _loc23_ += 2;
                           _loc17_++;
                        }
                     }
                     else
                     {
                        _loc10_ = int(li8(_loc17_));
                        si16(_loc10_,_loc23_);
                        _loc24_ = 0;
                        _loc25_ = scratchAddr + _loc24_ + (_loc10_ << 2);
                        _loc26_ = li32(_loc25_) + 1;
                        si32(_loc26_,_loc25_);
                        si32(_loc17_,_loc21_ + _loc16_);
                        _loc23_ += 2;
                        _loc17_++;
                     }
                  }
                  while(_loc17_ < _loc5_)
                  {
                     _loc10_ = int(li8(_loc17_));
                     si16(_loc10_,_loc23_);
                     _loc24_ = 0;
                     _loc25_ = scratchAddr + _loc24_ + (_loc10_ << 2);
                     _loc26_ = li32(_loc25_) + 1;
                     si32(_loc26_,_loc25_);
                     _loc23_ += 2;
                     _loc17_++;
                  }
                  _loc12_ = false;
                  blockInProgress = true;
                  if(level == CompressionLevel.UNCOMPRESSED)
                  {
                     if(bitOffset == 0)
                     {
                        si8(0,currentAddr);
                     }
                     _loc24_ = int(li8(currentAddr));
                     _loc24_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                     si32(_loc24_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     if(bitOffset > 0)
                     {
                        _loc24_ = int(li8(currentAddr));
                        _loc24_ |= 0 << bitOffset;
                        si32(_loc24_,currentAddr);
                        bitOffset += 8 - bitOffset;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                  }
                  else
                  {
                     _loc24_ = int(li8(currentAddr));
                     _loc24_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                     si32(_loc24_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockStartAddr = currentAddr;
                  createAndWriteHuffmanTrees(_loc4_,_loc5_);
                  _loc17_ = int(_loc22_);
                  while(_loc17_ + 64 <= _loc23_)
                  {
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                  }
                  while(_loc17_ < _loc23_)
                  {
                     _loc28_ = int(li16(_loc17_));
                     if((_loc28_ & 512) != 0)
                     {
                        _loc24_ = _loc28_ ^ 512;
                        _loc26_ = int(li32(scratchAddr + 2492 + (_loc24_ << 2)));
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + (_loc26_ >>> 16) * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc24_ - (_loc26_ & 8191) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc26_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc25_ = int(li16(_loc17_ + 2));
                        _loc27_ = int(li32(scratchAddr + 3528 + ((_loc25_ <= 256 ? _loc25_ : 256 + (_loc25_ - 1 >>> 7)) << 2)));
                        _loc29_ = int(li32(scratchAddr + 1144 + (_loc27_ >>> 24) * 4));
                        _loc30_ = int(li8(currentAddr));
                        _loc30_ |= _loc29_ >>> 16 << bitOffset;
                        si32(_loc30_,currentAddr);
                        bitOffset += _loc29_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc29_ = int(li8(currentAddr));
                        _loc29_ |= _loc25_ - (_loc27_ & 65535) << bitOffset;
                        si32(_loc29_,currentAddr);
                        bitOffset += (_loc27_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc29_ = 0;
                        _loc30_ = int(li32(scratchAddr + _loc29_ + _loc28_ * 4));
                        _loc31_ = int(li8(currentAddr));
                        _loc31_ |= _loc30_ >>> 16 << bitOffset;
                        si32(_loc31_,currentAddr);
                        bitOffset += _loc30_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc10_ = int(_loc28_);
                     _loc17_ += 2 + ((_loc10_ & 512) >>> 8);
                  }
                  if(level != CompressionLevel.UNCOMPRESSED)
                  {
                     _loc24_ = 0;
                     _loc25_ = int(li32(scratchAddr + _loc24_ + 1024));
                     _loc26_ = int(li8(currentAddr));
                     _loc26_ |= _loc25_ >>> 16 << bitOffset;
                     si32(_loc26_,currentAddr);
                     bitOffset += _loc25_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockInProgress = false;
                  _loc4_ = int(_loc5_);
               }
            }
            else
            {
               if(level != CompressionLevel.GOOD)
               {
                  throw new Error("Compression level not supported");
               }
               _loc4_ = int(param1);
               _loc18_ = param2 - _loc4_;
               _loc22_ = 1;
               _loc23_ = 0;
               §§push(currentAddr);
               if(level == CompressionLevel.UNCOMPRESSED)
               {
                  _loc21_ = 8;
                  _loc20_ = int(Math.ceil(_loc18_ / 65535));
               }
               else
               {
                  if(level == CompressionLevel.FAST)
                  {
                     _loc20_ = int(Math.ceil(_loc18_ * 2 / 49152));
                  }
                  else
                  {
                     _loc20_ = int(Math.ceil(_loc18_ / 98304));
                     if(level == CompressionLevel.NORMAL)
                     {
                        _loc23_ = 458752;
                     }
                     else if(level == CompressionLevel.GOOD)
                     {
                        _loc23_ = 524308;
                     }
                  }
                  _loc22_ = 2;
                  _loc21_ = 300;
               }
               _loc17_ = §§pop() + (_loc18_ * _loc22_ + _loc21_ * (_loc20_ + 1) + _loc23_) - 327700;
               _loc18_ = _loc17_ - 196608;
               _loc35_ = new LZHash(_loc17_,258,32768);
               while(param2 - _loc4_ > 0)
               {
                  _loc11_ = Number(Math.min(param2,_loc4_ + 98304));
                  _loc5_ = int(_loc11_);
                  _loc10_ = _loc5_ - 9;
                  _loc6_ = _loc10_ - 516 - 1;
                  _loc21_ = 0;
                  while(_loc21_ < 286)
                  {
                     _loc22_ = int(_loc21_++);
                     si32(0,scratchAddr + (_loc22_ << 2));
                  }
                  _loc21_ = 0;
                  while(_loc21_ < 30)
                  {
                     _loc22_ = int(_loc21_++);
                     si32(0,scratchAddr + 1144 + (_loc22_ << 2));
                  }
                  _loc20_ = int(_loc18_);
                  _loc16_ = int(_loc4_);
                  if(_loc16_ < _loc6_)
                  {
                     _loc23_ = 775236557;
                     _loc24_ = -862048943;
                     _loc25_ = 461845907;
                     _loc26_ = li32(_loc4_) * _loc24_;
                     _loc26_ = _loc26_ << 15 | _loc26_ >>> 17;
                     _loc23_ ^= _loc26_ * _loc25_;
                     _loc23_ = _loc23_ << 13 | _loc23_ >>> 19;
                     _loc23_ = _loc23_ * 5 + -430675100;
                     _loc27_ = _loc23_ ^ 4;
                     _loc27_ ^= _loc27_ >>> 16;
                     _loc27_ *= -2048144789;
                     _loc27_ ^= _loc27_ >>> 13;
                     _loc27_ *= -1028477387;
                     _loc22_ = (_loc27_ ^ _loc27_ >>> 16) & 65535;
                     _loc21_ = _loc35_.addr + _loc22_ * 5;
                     _loc22_ = 3;
                     _loc23_ = -1;
                     _loc25_ = int(li32(_loc21_ + 1));
                     if(_loc25_ >= 0 && li32(_loc4_) == li32(_loc25_) && _loc4_ - _loc25_ <= _loc35_.windowSize)
                     {
                        _loc26_ = _loc4_ + 4;
                        _loc24_ = 4;
                        _loc25_ += 4;
                        while(li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc35_.maxMatchLength)
                        {
                           _loc24_ += 4;
                           _loc25_ += 4;
                           _loc26_ += 4;
                        }
                        while(li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc35_.maxMatchLength)
                        {
                           _loc24_++;
                           _loc25_++;
                           _loc26_++;
                        }
                        _loc22_ = int(_loc24_);
                        _loc23_ = int(_loc25_);
                     }
                     _loc27_ = 5;
                     _loc28_ = 9;
                     while(_loc27_ < _loc28_)
                     {
                        _loc29_ = int(_loc27_++);
                        _loc36_ = int(li32(_loc4_));
                        si32(_loc36_,_loc35_.hashScratchAddr);
                        _loc36_ = int(li32(_loc4_ + 4));
                        si32(_loc36_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc29_);
                        _loc36_ = 775236557;
                        _loc37_ = -862048943;
                        _loc38_ = 461845907;
                        _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                        _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                        _loc36_ ^= _loc39_ * _loc38_;
                        _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                        _loc36_ = _loc36_ * 5 + -430675100;
                        _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                        _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                        _loc36_ ^= _loc39_ * _loc38_;
                        _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                        _loc36_ = _loc36_ * 5 + -430675100;
                        _loc40_ = _loc36_ ^ _loc29_;
                        _loc40_ ^= _loc40_ >>> 16;
                        _loc40_ *= -2048144789;
                        _loc40_ ^= _loc40_ >>> 13;
                        _loc40_ *= -1028477387;
                        _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                        _loc30_ = _loc35_.addr + _loc31_ * 5 + 1;
                        _loc25_ = int(li32(_loc30_));
                        if(_loc25_ >= 0 && li32(_loc25_ + _loc22_ - 3) == li32(_loc4_ + _loc22_ - 3) && li32(_loc4_) == li32(_loc25_) && _loc4_ - _loc25_ <= _loc35_.windowSize)
                        {
                           _loc26_ = _loc4_ + 4;
                           _loc24_ = 4;
                           _loc25_ += 4;
                           while(li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc35_.maxMatchLength)
                           {
                              _loc24_ += 4;
                              _loc25_ += 4;
                              _loc26_ += 4;
                           }
                           while(li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc35_.maxMatchLength)
                           {
                              _loc24_++;
                              _loc25_++;
                              _loc26_++;
                           }
                           if(_loc24_ > _loc22_)
                           {
                              _loc22_ = int(_loc24_);
                              _loc23_ = int(_loc25_);
                           }
                        }
                     }
                     si32(_loc4_ - (_loc23_ - _loc22_) << 16 | _loc22_,_loc35_.resultAddr);
                     _loc22_ = int(_loc21_);
                     _loc23_ = 4;
                     _loc24_ = int(_loc4_);
                     if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                     {
                        _loc26_ = int(li32(_loc22_ + 1));
                        si8(_loc23_,_loc22_);
                        si32(_loc24_,_loc22_ + 1);
                        _loc23_ = _loc25_ + 1;
                        _loc24_ = int(_loc26_);
                        _loc28_ = int(li32(_loc24_));
                        si32(_loc28_,_loc35_.hashScratchAddr);
                        _loc28_ = int(li32(_loc24_ + 4));
                        si32(_loc28_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc23_);
                        _loc28_ = 775236557;
                        _loc29_ = -862048943;
                        _loc30_ = 461845907;
                        _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                        _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                        _loc28_ ^= _loc31_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                        _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                        _loc28_ ^= _loc31_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc36_ = _loc28_ ^ _loc23_;
                        _loc36_ ^= _loc36_ >>> 16;
                        _loc36_ *= -2048144789;
                        _loc36_ ^= _loc36_ >>> 13;
                        _loc36_ *= -1028477387;
                        _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                        _loc22_ = _loc35_.addr + _loc27_ * 5;
                        if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                        {
                           _loc26_ = int(li32(_loc22_ + 1));
                           si8(_loc23_,_loc22_);
                           si32(_loc24_,_loc22_ + 1);
                           _loc23_ = _loc25_ + 1;
                           _loc24_ = int(_loc26_);
                           _loc28_ = int(li32(_loc24_));
                           si32(_loc28_,_loc35_.hashScratchAddr);
                           _loc28_ = int(li32(_loc24_ + 4));
                           si32(_loc28_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc23_);
                           _loc28_ = 775236557;
                           _loc29_ = -862048943;
                           _loc30_ = 461845907;
                           _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                           _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                           _loc28_ ^= _loc31_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                           _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                           _loc28_ ^= _loc31_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc36_ = _loc28_ ^ _loc23_;
                           _loc36_ ^= _loc36_ >>> 16;
                           _loc36_ *= -2048144789;
                           _loc36_ ^= _loc36_ >>> 13;
                           _loc36_ *= -1028477387;
                           _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                           _loc22_ = _loc35_.addr + _loc27_ * 5;
                           if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                           {
                              _loc26_ = int(li32(_loc22_ + 1));
                              si8(_loc23_,_loc22_);
                              si32(_loc24_,_loc22_ + 1);
                              _loc23_ = _loc25_ + 1;
                              _loc24_ = int(_loc26_);
                              _loc28_ = int(li32(_loc24_));
                              si32(_loc28_,_loc35_.hashScratchAddr);
                              _loc28_ = int(li32(_loc24_ + 4));
                              si32(_loc28_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc23_);
                              _loc28_ = 775236557;
                              _loc29_ = -862048943;
                              _loc30_ = 461845907;
                              _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                              _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                              _loc28_ ^= _loc31_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                              _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                              _loc28_ ^= _loc31_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc36_ = _loc28_ ^ _loc23_;
                              _loc36_ ^= _loc36_ >>> 16;
                              _loc36_ *= -2048144789;
                              _loc36_ ^= _loc36_ >>> 13;
                              _loc36_ *= -1028477387;
                              _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                              _loc22_ = _loc35_.addr + _loc27_ * 5;
                              if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                              {
                                 _loc26_ = int(li32(_loc22_ + 1));
                                 si8(_loc23_,_loc22_);
                                 si32(_loc24_,_loc22_ + 1);
                                 _loc23_ = _loc25_ + 1;
                                 _loc24_ = int(_loc26_);
                                 _loc28_ = int(li32(_loc24_));
                                 si32(_loc28_,_loc35_.hashScratchAddr);
                                 _loc28_ = int(li32(_loc24_ + 4));
                                 si32(_loc28_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc23_);
                                 _loc28_ = 775236557;
                                 _loc29_ = -862048943;
                                 _loc30_ = 461845907;
                                 _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                                 _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                                 _loc28_ ^= _loc31_ * _loc30_;
                                 _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                                 _loc28_ = _loc28_ * 5 + -430675100;
                                 _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                                 _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                                 _loc28_ ^= _loc31_ * _loc30_;
                                 _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                                 _loc28_ = _loc28_ * 5 + -430675100;
                                 _loc36_ = _loc28_ ^ _loc23_;
                                 _loc36_ ^= _loc36_ >>> 16;
                                 _loc36_ *= -2048144789;
                                 _loc36_ ^= _loc36_ >>> 13;
                                 _loc36_ *= -1028477387;
                                 _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                                 _loc22_ = _loc35_.addr + _loc27_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc23_,_loc22_);
                     si32(_loc24_,_loc22_ + 1);
                     _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                  }
                  else if(_loc16_ < _loc10_)
                  {
                     _loc23_ = 775236557;
                     _loc24_ = -862048943;
                     _loc25_ = 461845907;
                     _loc26_ = li32(_loc4_) * _loc24_;
                     _loc26_ = _loc26_ << 15 | _loc26_ >>> 17;
                     _loc23_ ^= _loc26_ * _loc25_;
                     _loc23_ = _loc23_ << 13 | _loc23_ >>> 19;
                     _loc23_ = _loc23_ * 5 + -430675100;
                     _loc27_ = _loc23_ ^ 4;
                     _loc27_ ^= _loc27_ >>> 16;
                     _loc27_ *= -2048144789;
                     _loc27_ ^= _loc27_ >>> 13;
                     _loc27_ *= -1028477387;
                     _loc22_ = (_loc27_ ^ _loc27_ >>> 16) & 65535;
                     _loc21_ = _loc35_.addr + _loc22_ * 5;
                     _loc22_ = 3;
                     _loc23_ = -1;
                     _loc25_ = int(li32(_loc21_ + 1));
                     if(_loc25_ >= 0 && li32(_loc4_) == li32(_loc25_) && _loc4_ - _loc25_ <= _loc35_.windowSize)
                     {
                        _loc26_ = _loc4_ + 4;
                        _loc24_ = 4;
                        _loc25_ += 4;
                        while(_loc26_ + 4 <= _loc5_ && li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc35_.maxMatchLength)
                        {
                           _loc24_ += 4;
                           _loc25_ += 4;
                           _loc26_ += 4;
                        }
                        while(_loc26_ < _loc5_ && li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc35_.maxMatchLength)
                        {
                           _loc24_++;
                           _loc25_++;
                           _loc26_++;
                        }
                        _loc22_ = int(_loc24_);
                        _loc23_ = int(_loc25_);
                     }
                     _loc27_ = 5;
                     _loc28_ = 9;
                     while(_loc27_ < _loc28_)
                     {
                        _loc29_ = int(_loc27_++);
                        _loc36_ = int(li32(_loc4_));
                        si32(_loc36_,_loc35_.hashScratchAddr);
                        _loc36_ = int(li32(_loc4_ + 4));
                        si32(_loc36_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc29_);
                        _loc36_ = 775236557;
                        _loc37_ = -862048943;
                        _loc38_ = 461845907;
                        _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                        _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                        _loc36_ ^= _loc39_ * _loc38_;
                        _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                        _loc36_ = _loc36_ * 5 + -430675100;
                        _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                        _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                        _loc36_ ^= _loc39_ * _loc38_;
                        _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                        _loc36_ = _loc36_ * 5 + -430675100;
                        _loc40_ = _loc36_ ^ _loc29_;
                        _loc40_ ^= _loc40_ >>> 16;
                        _loc40_ *= -2048144789;
                        _loc40_ ^= _loc40_ >>> 13;
                        _loc40_ *= -1028477387;
                        _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                        _loc30_ = _loc35_.addr + _loc31_ * 5 + 1;
                        _loc25_ = int(li32(_loc30_));
                        if(_loc25_ >= 0 && li32(_loc4_) == li32(_loc25_) && _loc4_ - _loc25_ <= _loc35_.windowSize)
                        {
                           _loc26_ = _loc4_ + 4;
                           _loc24_ = 4;
                           _loc25_ += 4;
                           while(_loc26_ + 4 <= _loc5_ && li32(_loc25_) == li32(_loc26_) && _loc24_ + 4 <= _loc35_.maxMatchLength)
                           {
                              _loc24_ += 4;
                              _loc25_ += 4;
                              _loc26_ += 4;
                           }
                           while(_loc26_ < _loc5_ && li8(_loc25_) == li8(_loc26_) && _loc24_ < _loc35_.maxMatchLength)
                           {
                              _loc24_++;
                              _loc25_++;
                              _loc26_++;
                           }
                           if(_loc24_ > _loc22_)
                           {
                              _loc22_ = int(_loc24_);
                              _loc23_ = int(_loc25_);
                           }
                        }
                     }
                     si32(_loc4_ - (_loc23_ - _loc22_) << 16 | _loc22_,_loc35_.resultAddr);
                     _loc22_ = int(_loc21_);
                     _loc23_ = 4;
                     _loc24_ = int(_loc4_);
                     if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                     {
                        _loc26_ = int(li32(_loc22_ + 1));
                        si8(_loc23_,_loc22_);
                        si32(_loc24_,_loc22_ + 1);
                        _loc23_ = _loc25_ + 1;
                        _loc24_ = int(_loc26_);
                        _loc28_ = int(li32(_loc24_));
                        si32(_loc28_,_loc35_.hashScratchAddr);
                        _loc28_ = int(li32(_loc24_ + 4));
                        si32(_loc28_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc23_);
                        _loc28_ = 775236557;
                        _loc29_ = -862048943;
                        _loc30_ = 461845907;
                        _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                        _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                        _loc28_ ^= _loc31_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                        _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                        _loc28_ ^= _loc31_ * _loc30_;
                        _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                        _loc28_ = _loc28_ * 5 + -430675100;
                        _loc36_ = _loc28_ ^ _loc23_;
                        _loc36_ ^= _loc36_ >>> 16;
                        _loc36_ *= -2048144789;
                        _loc36_ ^= _loc36_ >>> 13;
                        _loc36_ *= -1028477387;
                        _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                        _loc22_ = _loc35_.addr + _loc27_ * 5;
                        if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                        {
                           _loc26_ = int(li32(_loc22_ + 1));
                           si8(_loc23_,_loc22_);
                           si32(_loc24_,_loc22_ + 1);
                           _loc23_ = _loc25_ + 1;
                           _loc24_ = int(_loc26_);
                           _loc28_ = int(li32(_loc24_));
                           si32(_loc28_,_loc35_.hashScratchAddr);
                           _loc28_ = int(li32(_loc24_ + 4));
                           si32(_loc28_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc23_);
                           _loc28_ = 775236557;
                           _loc29_ = -862048943;
                           _loc30_ = 461845907;
                           _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                           _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                           _loc28_ ^= _loc31_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                           _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                           _loc28_ ^= _loc31_ * _loc30_;
                           _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                           _loc28_ = _loc28_ * 5 + -430675100;
                           _loc36_ = _loc28_ ^ _loc23_;
                           _loc36_ ^= _loc36_ >>> 16;
                           _loc36_ *= -2048144789;
                           _loc36_ ^= _loc36_ >>> 13;
                           _loc36_ *= -1028477387;
                           _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                           _loc22_ = _loc35_.addr + _loc27_ * 5;
                           if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                           {
                              _loc26_ = int(li32(_loc22_ + 1));
                              si8(_loc23_,_loc22_);
                              si32(_loc24_,_loc22_ + 1);
                              _loc23_ = _loc25_ + 1;
                              _loc24_ = int(_loc26_);
                              _loc28_ = int(li32(_loc24_));
                              si32(_loc28_,_loc35_.hashScratchAddr);
                              _loc28_ = int(li32(_loc24_ + 4));
                              si32(_loc28_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc23_);
                              _loc28_ = 775236557;
                              _loc29_ = -862048943;
                              _loc30_ = 461845907;
                              _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                              _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                              _loc28_ ^= _loc31_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                              _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                              _loc28_ ^= _loc31_ * _loc30_;
                              _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                              _loc28_ = _loc28_ * 5 + -430675100;
                              _loc36_ = _loc28_ ^ _loc23_;
                              _loc36_ ^= _loc36_ >>> 16;
                              _loc36_ *= -2048144789;
                              _loc36_ ^= _loc36_ >>> 13;
                              _loc36_ *= -1028477387;
                              _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                              _loc22_ = _loc35_.addr + _loc27_ * 5;
                              if((_loc25_ = int(li8(_loc22_))) < 8 && _loc25_ >= 0)
                              {
                                 _loc26_ = int(li32(_loc22_ + 1));
                                 si8(_loc23_,_loc22_);
                                 si32(_loc24_,_loc22_ + 1);
                                 _loc23_ = _loc25_ + 1;
                                 _loc24_ = int(_loc26_);
                                 _loc28_ = int(li32(_loc24_));
                                 si32(_loc28_,_loc35_.hashScratchAddr);
                                 _loc28_ = int(li32(_loc24_ + 4));
                                 si32(_loc28_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc23_);
                                 _loc28_ = 775236557;
                                 _loc29_ = -862048943;
                                 _loc30_ = 461845907;
                                 _loc31_ = li32(_loc35_.hashScratchAddr) * _loc29_;
                                 _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                                 _loc28_ ^= _loc31_ * _loc30_;
                                 _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                                 _loc28_ = _loc28_ * 5 + -430675100;
                                 _loc31_ = li32(_loc35_.hashScratchAddr + 4) * _loc29_;
                                 _loc31_ = _loc31_ << 15 | _loc31_ >>> 17;
                                 _loc28_ ^= _loc31_ * _loc30_;
                                 _loc28_ = _loc28_ << 13 | _loc28_ >>> 19;
                                 _loc28_ = _loc28_ * 5 + -430675100;
                                 _loc36_ = _loc28_ ^ _loc23_;
                                 _loc36_ ^= _loc36_ >>> 16;
                                 _loc36_ *= -2048144789;
                                 _loc36_ ^= _loc36_ >>> 13;
                                 _loc36_ *= -1028477387;
                                 _loc27_ = (_loc36_ ^ _loc36_ >>> 16) & 65535;
                                 _loc22_ = _loc35_.addr + _loc27_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc23_,_loc22_);
                     si32(_loc24_,_loc22_ + 1);
                     _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                  }
                  while(_loc16_ < _loc6_)
                  {
                     _loc24_ = 775236557;
                     _loc25_ = -862048943;
                     _loc26_ = 461845907;
                     _loc27_ = li32(_loc16_ + 1) * _loc25_;
                     _loc27_ = _loc27_ << 15 | _loc27_ >>> 17;
                     _loc24_ ^= _loc27_ * _loc26_;
                     _loc24_ = _loc24_ << 13 | _loc24_ >>> 19;
                     _loc24_ = _loc24_ * 5 + -430675100;
                     _loc28_ = _loc24_ ^ 4;
                     _loc28_ ^= _loc28_ >>> 16;
                     _loc28_ *= -2048144789;
                     _loc28_ ^= _loc28_ >>> 13;
                     _loc28_ *= -1028477387;
                     _loc23_ = (_loc28_ ^ _loc28_ >>> 16) & 65535;
                     _loc22_ = _loc35_.addr + _loc23_ * 5;
                     if(li16(_loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7)) < _loc35_.avgMatchLength + 4)
                     {
                        _loc23_ = _loc16_ + 1;
                        _loc24_ = 3;
                        _loc25_ = -1;
                        _loc27_ = int(li32(_loc22_ + 1));
                        if(_loc27_ >= 0 && li32(_loc23_) == li32(_loc27_) && _loc23_ - _loc27_ <= _loc35_.windowSize)
                        {
                           _loc28_ = _loc23_ + 4;
                           _loc26_ = 4;
                           _loc27_ += 4;
                           while(li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc35_.maxMatchLength)
                           {
                              _loc26_ += 4;
                              _loc27_ += 4;
                              _loc28_ += 4;
                           }
                           while(li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc35_.maxMatchLength)
                           {
                              _loc26_++;
                              _loc27_++;
                              _loc28_++;
                           }
                           _loc24_ = int(_loc26_);
                           _loc25_ = int(_loc27_);
                        }
                        _loc29_ = 5;
                        _loc30_ = 9;
                        while(_loc29_ < _loc30_)
                        {
                           _loc31_ = int(_loc29_++);
                           _loc38_ = int(li32(_loc23_));
                           si32(_loc38_,_loc35_.hashScratchAddr);
                           _loc38_ = int(li32(_loc23_ + 4));
                           si32(_loc38_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc31_);
                           _loc38_ = 775236557;
                           _loc39_ = -862048943;
                           _loc40_ = 461845907;
                           _loc41_ = li32(_loc35_.hashScratchAddr) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc41_ = li32(_loc35_.hashScratchAddr + 4) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc42_ = _loc38_ ^ _loc31_;
                           _loc42_ ^= _loc42_ >>> 16;
                           _loc42_ *= -2048144789;
                           _loc42_ ^= _loc42_ >>> 13;
                           _loc42_ *= -1028477387;
                           _loc37_ = (_loc42_ ^ _loc42_ >>> 16) & 65535;
                           _loc36_ = _loc35_.addr + _loc37_ * 5 + 1;
                           _loc27_ = int(li32(_loc36_));
                           if(_loc27_ >= 0 && li32(_loc27_ + _loc24_ - 3) == li32(_loc23_ + _loc24_ - 3) && li32(_loc23_) == li32(_loc27_) && _loc23_ - _loc27_ <= _loc35_.windowSize)
                           {
                              _loc28_ = _loc23_ + 4;
                              _loc26_ = 4;
                              _loc27_ += 4;
                              while(li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc35_.maxMatchLength)
                              {
                                 _loc26_ += 4;
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                              }
                              while(li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc35_.maxMatchLength)
                              {
                                 _loc26_++;
                                 _loc27_++;
                                 _loc28_++;
                              }
                              if(_loc26_ > _loc24_)
                              {
                                 _loc24_ = int(_loc26_);
                                 _loc25_ = int(_loc27_);
                              }
                           }
                        }
                        si32(_loc23_ - (_loc25_ - _loc24_) << 16 | _loc24_,_loc35_.resultAddr);
                     }
                     else
                     {
                        si32(0,_loc35_.resultAddr);
                     }
                     _loc23_ = int(_loc22_);
                     _loc24_ = 4;
                     _loc25_ = _loc16_ + 1;
                     if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                     {
                        _loc27_ = int(li32(_loc23_ + 1));
                        si8(_loc24_,_loc23_);
                        si32(_loc25_,_loc23_ + 1);
                        _loc24_ = _loc26_ + 1;
                        _loc25_ = int(_loc27_);
                        _loc29_ = int(li32(_loc25_));
                        si32(_loc29_,_loc35_.hashScratchAddr);
                        _loc29_ = int(li32(_loc25_ + 4));
                        si32(_loc29_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc24_);
                        _loc29_ = 775236557;
                        _loc30_ = -862048943;
                        _loc31_ = 461845907;
                        _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc29_ ^= _loc36_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc29_ ^= _loc36_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc37_ = _loc29_ ^ _loc24_;
                        _loc37_ ^= _loc37_ >>> 16;
                        _loc37_ *= -2048144789;
                        _loc37_ ^= _loc37_ >>> 13;
                        _loc37_ *= -1028477387;
                        _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                        _loc23_ = _loc35_.addr + _loc28_ * 5;
                        if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                        {
                           _loc27_ = int(li32(_loc23_ + 1));
                           si8(_loc24_,_loc23_);
                           si32(_loc25_,_loc23_ + 1);
                           _loc24_ = _loc26_ + 1;
                           _loc25_ = int(_loc27_);
                           _loc29_ = int(li32(_loc25_));
                           si32(_loc29_,_loc35_.hashScratchAddr);
                           _loc29_ = int(li32(_loc25_ + 4));
                           si32(_loc29_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc24_);
                           _loc29_ = 775236557;
                           _loc30_ = -862048943;
                           _loc31_ = 461845907;
                           _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                           _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                           _loc29_ ^= _loc36_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                           _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                           _loc29_ ^= _loc36_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc37_ = _loc29_ ^ _loc24_;
                           _loc37_ ^= _loc37_ >>> 16;
                           _loc37_ *= -2048144789;
                           _loc37_ ^= _loc37_ >>> 13;
                           _loc37_ *= -1028477387;
                           _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                           _loc23_ = _loc35_.addr + _loc28_ * 5;
                           if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                           {
                              _loc27_ = int(li32(_loc23_ + 1));
                              si8(_loc24_,_loc23_);
                              si32(_loc25_,_loc23_ + 1);
                              _loc24_ = _loc26_ + 1;
                              _loc25_ = int(_loc27_);
                              _loc29_ = int(li32(_loc25_));
                              si32(_loc29_,_loc35_.hashScratchAddr);
                              _loc29_ = int(li32(_loc25_ + 4));
                              si32(_loc29_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc24_);
                              _loc29_ = 775236557;
                              _loc30_ = -862048943;
                              _loc31_ = 461845907;
                              _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                              _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                              _loc29_ ^= _loc36_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                              _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                              _loc29_ ^= _loc36_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc37_ = _loc29_ ^ _loc24_;
                              _loc37_ ^= _loc37_ >>> 16;
                              _loc37_ *= -2048144789;
                              _loc37_ ^= _loc37_ >>> 13;
                              _loc37_ *= -1028477387;
                              _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                              _loc23_ = _loc35_.addr + _loc28_ * 5;
                              if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                              {
                                 _loc27_ = int(li32(_loc23_ + 1));
                                 si8(_loc24_,_loc23_);
                                 si32(_loc25_,_loc23_ + 1);
                                 _loc24_ = _loc26_ + 1;
                                 _loc25_ = int(_loc27_);
                                 _loc29_ = int(li32(_loc25_));
                                 si32(_loc29_,_loc35_.hashScratchAddr);
                                 _loc29_ = int(li32(_loc25_ + 4));
                                 si32(_loc29_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc24_);
                                 _loc29_ = 775236557;
                                 _loc30_ = -862048943;
                                 _loc31_ = 461845907;
                                 _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                                 _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                                 _loc29_ ^= _loc36_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                                 _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                                 _loc29_ ^= _loc36_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc37_ = _loc29_ ^ _loc24_;
                                 _loc37_ ^= _loc37_ >>> 16;
                                 _loc37_ *= -2048144789;
                                 _loc37_ ^= _loc37_ >>> 13;
                                 _loc37_ *= -1028477387;
                                 _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                                 _loc23_ = _loc35_.addr + _loc28_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc24_,_loc23_);
                     si32(_loc25_,_loc23_ + 1);
                     _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                     if(li16(_loc35_.resultAddr) >= 4)
                     {
                        _loc21_ = int(li16(_loc35_.resultAddr));
                        if(li16(_loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7)) > _loc21_)
                        {
                           si32(0,_loc35_.resultAddr);
                        }
                        else
                        {
                           _loc35_.avgMatchLength = (_loc35_.avgMatchLength << 1) + (_loc35_.avgMatchLength << 2) + (_loc21_ << 1) >>> 3;
                           if(_loc21_ < _loc35_.avgMatchLength + 4)
                           {
                              _loc23_ = _loc16_ + 1 + 1;
                              _loc24_ = _loc16_ + _loc21_;
                              while(_loc23_ < _loc24_)
                              {
                                 _loc25_ = int(_loc23_++);
                                 _loc26_ = 4;
                                 _loc27_ = int(_loc25_);
                                 _loc36_ = 775236557;
                                 _loc37_ = -862048943;
                                 _loc38_ = 461845907;
                                 _loc39_ = li32(_loc25_) * _loc37_;
                                 _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                 _loc36_ ^= _loc39_ * _loc38_;
                                 _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                 _loc36_ = _loc36_ * 5 + -430675100;
                                 _loc40_ = _loc36_ ^ 4;
                                 _loc40_ ^= _loc40_ >>> 16;
                                 _loc40_ *= -2048144789;
                                 _loc40_ ^= _loc40_ >>> 13;
                                 _loc40_ *= -1028477387;
                                 _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                 _loc30_ = _loc35_.addr + _loc31_ * 5;
                                 if((_loc28_ = int(li8(_loc30_))) < 8 && _loc28_ >= 0)
                                 {
                                    _loc29_ = int(li32(_loc30_ + 1));
                                    si8(_loc26_,_loc30_);
                                    si32(_loc27_,_loc30_ + 1);
                                    _loc26_ = _loc28_ + 1;
                                    _loc27_ = int(_loc29_);
                                    _loc36_ = int(li32(_loc27_));
                                    si32(_loc36_,_loc35_.hashScratchAddr);
                                    _loc36_ = int(li32(_loc27_ + 4));
                                    si32(_loc36_,_loc35_.hashScratchAddr + 4);
                                    si32(0,_loc35_.hashScratchAddr + _loc26_);
                                    _loc36_ = 775236557;
                                    _loc37_ = -862048943;
                                    _loc38_ = 461845907;
                                    _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                                    _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                    _loc36_ ^= _loc39_ * _loc38_;
                                    _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                    _loc36_ = _loc36_ * 5 + -430675100;
                                    _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                                    _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                    _loc36_ ^= _loc39_ * _loc38_;
                                    _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                    _loc36_ = _loc36_ * 5 + -430675100;
                                    _loc40_ = _loc36_ ^ _loc26_;
                                    _loc40_ ^= _loc40_ >>> 16;
                                    _loc40_ *= -2048144789;
                                    _loc40_ ^= _loc40_ >>> 13;
                                    _loc40_ *= -1028477387;
                                    _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                    _loc30_ = _loc35_.addr + _loc31_ * 5;
                                    if((_loc28_ = int(li8(_loc30_))) < 8 && _loc28_ >= 0)
                                    {
                                       _loc29_ = int(li32(_loc30_ + 1));
                                       si8(_loc26_,_loc30_);
                                       si32(_loc27_,_loc30_ + 1);
                                       _loc26_ = _loc28_ + 1;
                                       _loc27_ = int(_loc29_);
                                       _loc36_ = int(li32(_loc27_));
                                       si32(_loc36_,_loc35_.hashScratchAddr);
                                       _loc36_ = int(li32(_loc27_ + 4));
                                       si32(_loc36_,_loc35_.hashScratchAddr + 4);
                                       si32(0,_loc35_.hashScratchAddr + _loc26_);
                                       _loc36_ = 775236557;
                                       _loc37_ = -862048943;
                                       _loc38_ = 461845907;
                                       _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                                       _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                       _loc36_ ^= _loc39_ * _loc38_;
                                       _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                       _loc36_ = _loc36_ * 5 + -430675100;
                                       _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                                       _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                       _loc36_ ^= _loc39_ * _loc38_;
                                       _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                       _loc36_ = _loc36_ * 5 + -430675100;
                                       _loc40_ = _loc36_ ^ _loc26_;
                                       _loc40_ ^= _loc40_ >>> 16;
                                       _loc40_ *= -2048144789;
                                       _loc40_ ^= _loc40_ >>> 13;
                                       _loc40_ *= -1028477387;
                                       _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                       _loc30_ = _loc35_.addr + _loc31_ * 5;
                                    }
                                 }
                                 si8(_loc26_,_loc30_);
                                 si32(_loc27_,_loc30_ + 1);
                              }
                           }
                           _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                           _loc23_ = _loc16_ + _loc21_;
                           _loc26_ = 775236557;
                           _loc27_ = -862048943;
                           _loc28_ = 461845907;
                           _loc29_ = li32(_loc23_) * _loc27_;
                           _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                           _loc26_ ^= _loc29_ * _loc28_;
                           _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                           _loc26_ = _loc26_ * 5 + -430675100;
                           _loc30_ = _loc26_ ^ 4;
                           _loc30_ ^= _loc30_ >>> 16;
                           _loc30_ *= -2048144789;
                           _loc30_ ^= _loc30_ >>> 13;
                           _loc30_ *= -1028477387;
                           _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                           _loc24_ = _loc35_.addr + _loc25_ * 5;
                           _loc25_ = 3;
                           _loc26_ = -1;
                           _loc28_ = int(li32(_loc24_ + 1));
                           if(_loc28_ >= 0 && li32(_loc23_) == li32(_loc28_) && _loc23_ - _loc28_ <= _loc35_.windowSize)
                           {
                              _loc29_ = _loc23_ + 4;
                              _loc27_ = 4;
                              _loc28_ += 4;
                              while(li32(_loc28_) == li32(_loc29_) && _loc27_ + 4 <= _loc35_.maxMatchLength)
                              {
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                                 _loc29_ += 4;
                              }
                              while(li8(_loc28_) == li8(_loc29_) && _loc27_ < _loc35_.maxMatchLength)
                              {
                                 _loc27_++;
                                 _loc28_++;
                                 _loc29_++;
                              }
                              _loc25_ = int(_loc27_);
                              _loc26_ = int(_loc28_);
                           }
                           _loc30_ = 5;
                           _loc31_ = 9;
                           while(_loc30_ < _loc31_)
                           {
                              _loc36_ = int(_loc30_++);
                              _loc39_ = int(li32(_loc23_));
                              si32(_loc39_,_loc35_.hashScratchAddr);
                              _loc39_ = int(li32(_loc23_ + 4));
                              si32(_loc39_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc36_);
                              _loc39_ = 775236557;
                              _loc40_ = -862048943;
                              _loc41_ = 461845907;
                              _loc42_ = li32(_loc35_.hashScratchAddr) * _loc40_;
                              _loc42_ = _loc42_ << 15 | _loc42_ >>> 17;
                              _loc39_ ^= _loc42_ * _loc41_;
                              _loc39_ = _loc39_ << 13 | _loc39_ >>> 19;
                              _loc39_ = _loc39_ * 5 + -430675100;
                              _loc42_ = li32(_loc35_.hashScratchAddr + 4) * _loc40_;
                              _loc42_ = _loc42_ << 15 | _loc42_ >>> 17;
                              _loc39_ ^= _loc42_ * _loc41_;
                              _loc39_ = _loc39_ << 13 | _loc39_ >>> 19;
                              _loc39_ = _loc39_ * 5 + -430675100;
                              _loc43_ = _loc39_ ^ _loc36_;
                              _loc43_ ^= _loc43_ >>> 16;
                              _loc43_ *= -2048144789;
                              _loc43_ ^= _loc43_ >>> 13;
                              _loc43_ *= -1028477387;
                              _loc38_ = (_loc43_ ^ _loc43_ >>> 16) & 65535;
                              _loc37_ = _loc35_.addr + _loc38_ * 5 + 1;
                              _loc28_ = int(li32(_loc37_));
                              if(_loc28_ >= 0 && li32(_loc28_ + _loc25_ - 3) == li32(_loc23_ + _loc25_ - 3) && li32(_loc23_) == li32(_loc28_) && _loc23_ - _loc28_ <= _loc35_.windowSize)
                              {
                                 _loc29_ = _loc23_ + 4;
                                 _loc27_ = 4;
                                 _loc28_ += 4;
                                 while(li32(_loc28_) == li32(_loc29_) && _loc27_ + 4 <= _loc35_.maxMatchLength)
                                 {
                                    _loc27_ += 4;
                                    _loc28_ += 4;
                                    _loc29_ += 4;
                                 }
                                 while(li8(_loc28_) == li8(_loc29_) && _loc27_ < _loc35_.maxMatchLength)
                                 {
                                    _loc27_++;
                                    _loc28_++;
                                    _loc29_++;
                                 }
                                 if(_loc27_ > _loc25_)
                                 {
                                    _loc25_ = int(_loc27_);
                                    _loc26_ = int(_loc28_);
                                 }
                              }
                           }
                           si32(_loc23_ - (_loc26_ - _loc25_) << 16 | _loc25_,_loc35_.resultAddr);
                           _loc25_ = int(_loc24_);
                           _loc26_ = 4;
                           _loc27_ = int(_loc23_);
                           if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                           {
                              _loc29_ = int(li32(_loc25_ + 1));
                              si8(_loc26_,_loc25_);
                              si32(_loc27_,_loc25_ + 1);
                              _loc26_ = _loc28_ + 1;
                              _loc27_ = int(_loc29_);
                              _loc31_ = int(li32(_loc27_));
                              si32(_loc31_,_loc35_.hashScratchAddr);
                              _loc31_ = int(li32(_loc27_ + 4));
                              si32(_loc31_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc26_);
                              _loc31_ = 775236557;
                              _loc36_ = -862048943;
                              _loc37_ = 461845907;
                              _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc31_ ^= _loc38_ * _loc37_;
                              _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                              _loc31_ = _loc31_ * 5 + -430675100;
                              _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc31_ ^= _loc38_ * _loc37_;
                              _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                              _loc31_ = _loc31_ * 5 + -430675100;
                              _loc39_ = _loc31_ ^ _loc26_;
                              _loc39_ ^= _loc39_ >>> 16;
                              _loc39_ *= -2048144789;
                              _loc39_ ^= _loc39_ >>> 13;
                              _loc39_ *= -1028477387;
                              _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                              _loc25_ = _loc35_.addr + _loc30_ * 5;
                              if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                              {
                                 _loc29_ = int(li32(_loc25_ + 1));
                                 si8(_loc26_,_loc25_);
                                 si32(_loc27_,_loc25_ + 1);
                                 _loc26_ = _loc28_ + 1;
                                 _loc27_ = int(_loc29_);
                                 _loc31_ = int(li32(_loc27_));
                                 si32(_loc31_,_loc35_.hashScratchAddr);
                                 _loc31_ = int(li32(_loc27_ + 4));
                                 si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc26_);
                                 _loc31_ = 775236557;
                                 _loc36_ = -862048943;
                                 _loc37_ = 461845907;
                                 _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc31_ ^= _loc38_ * _loc37_;
                                 _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                 _loc31_ = _loc31_ * 5 + -430675100;
                                 _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc31_ ^= _loc38_ * _loc37_;
                                 _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                 _loc31_ = _loc31_ * 5 + -430675100;
                                 _loc39_ = _loc31_ ^ _loc26_;
                                 _loc39_ ^= _loc39_ >>> 16;
                                 _loc39_ *= -2048144789;
                                 _loc39_ ^= _loc39_ >>> 13;
                                 _loc39_ *= -1028477387;
                                 _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                 _loc25_ = _loc35_.addr + _loc30_ * 5;
                                 if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                                 {
                                    _loc29_ = int(li32(_loc25_ + 1));
                                    si8(_loc26_,_loc25_);
                                    si32(_loc27_,_loc25_ + 1);
                                    _loc26_ = _loc28_ + 1;
                                    _loc27_ = int(_loc29_);
                                    _loc31_ = int(li32(_loc27_));
                                    si32(_loc31_,_loc35_.hashScratchAddr);
                                    _loc31_ = int(li32(_loc27_ + 4));
                                    si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                    si32(0,_loc35_.hashScratchAddr + _loc26_);
                                    _loc31_ = 775236557;
                                    _loc36_ = -862048943;
                                    _loc37_ = 461845907;
                                    _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc31_ ^= _loc38_ * _loc37_;
                                    _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                    _loc31_ = _loc31_ * 5 + -430675100;
                                    _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc31_ ^= _loc38_ * _loc37_;
                                    _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                    _loc31_ = _loc31_ * 5 + -430675100;
                                    _loc39_ = _loc31_ ^ _loc26_;
                                    _loc39_ ^= _loc39_ >>> 16;
                                    _loc39_ *= -2048144789;
                                    _loc39_ ^= _loc39_ >>> 13;
                                    _loc39_ *= -1028477387;
                                    _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                    _loc25_ = _loc35_.addr + _loc30_ * 5;
                                    if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                                    {
                                       _loc29_ = int(li32(_loc25_ + 1));
                                       si8(_loc26_,_loc25_);
                                       si32(_loc27_,_loc25_ + 1);
                                       _loc26_ = _loc28_ + 1;
                                       _loc27_ = int(_loc29_);
                                       _loc31_ = int(li32(_loc27_));
                                       si32(_loc31_,_loc35_.hashScratchAddr);
                                       _loc31_ = int(li32(_loc27_ + 4));
                                       si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                       si32(0,_loc35_.hashScratchAddr + _loc26_);
                                       _loc31_ = 775236557;
                                       _loc36_ = -862048943;
                                       _loc37_ = 461845907;
                                       _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                       _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                       _loc31_ ^= _loc38_ * _loc37_;
                                       _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                       _loc31_ = _loc31_ * 5 + -430675100;
                                       _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                       _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                       _loc31_ ^= _loc38_ * _loc37_;
                                       _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                       _loc31_ = _loc31_ * 5 + -430675100;
                                       _loc39_ = _loc31_ ^ _loc26_;
                                       _loc39_ ^= _loc39_ >>> 16;
                                       _loc39_ *= -2048144789;
                                       _loc39_ ^= _loc39_ >>> 13;
                                       _loc39_ *= -1028477387;
                                       _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                       _loc25_ = _loc35_.addr + _loc30_ * 5;
                                    }
                                 }
                              }
                           }
                           si8(_loc26_,_loc25_);
                           si32(_loc27_,_loc25_ + 1);
                           _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                        }
                     }
                     if(li16(_loc35_.resultAddr) >= 4)
                     {
                        _loc14_ = int(li16(_loc35_.resultAddr));
                        _loc21_ = int(li16(scratchAddr + 2492 + (_loc14_ << 2) + 2));
                        _loc22_ = 0;
                        _loc23_ = scratchAddr + _loc22_ + (_loc21_ << 2);
                        _loc24_ = li32(_loc23_) + 1;
                        si32(_loc24_,_loc23_);
                        _loc21_ = int(li16(_loc35_.resultAddr + 2));
                        _loc15_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                        _loc21_ = scratchAddr + 1144 + (_loc15_ >>> 24 << 2);
                        _loc22_ = li32(_loc21_) + 1;
                        si32(_loc22_,_loc21_);
                        _loc21_ = li32(_loc35_.resultAddr) | 512;
                        si32(_loc21_,_loc20_);
                        _loc20_ += 4;
                        _loc16_ += _loc14_;
                     }
                     else
                     {
                        _loc13_ = int(li8(_loc16_));
                        si16(_loc13_,_loc20_);
                        _loc21_ = 0;
                        _loc22_ = scratchAddr + _loc21_ + (_loc13_ << 2);
                        _loc23_ = li32(_loc22_) + 1;
                        si32(_loc23_,_loc22_);
                        _loc20_ += 2;
                        _loc16_++;
                     }
                  }
                  while(_loc16_ < _loc10_)
                  {
                     _loc24_ = 775236557;
                     _loc25_ = -862048943;
                     _loc26_ = 461845907;
                     _loc27_ = li32(_loc16_ + 1) * _loc25_;
                     _loc27_ = _loc27_ << 15 | _loc27_ >>> 17;
                     _loc24_ ^= _loc27_ * _loc26_;
                     _loc24_ = _loc24_ << 13 | _loc24_ >>> 19;
                     _loc24_ = _loc24_ * 5 + -430675100;
                     _loc28_ = _loc24_ ^ 4;
                     _loc28_ ^= _loc28_ >>> 16;
                     _loc28_ *= -2048144789;
                     _loc28_ ^= _loc28_ >>> 13;
                     _loc28_ *= -1028477387;
                     _loc23_ = (_loc28_ ^ _loc28_ >>> 16) & 65535;
                     _loc22_ = _loc35_.addr + _loc23_ * 5;
                     if(li16(_loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7)) < _loc35_.avgMatchLength + 4)
                     {
                        _loc23_ = _loc16_ + 1;
                        _loc24_ = 3;
                        _loc25_ = -1;
                        _loc27_ = int(li32(_loc22_ + 1));
                        if(_loc27_ >= 0 && li32(_loc23_) == li32(_loc27_) && _loc23_ - _loc27_ <= _loc35_.windowSize)
                        {
                           _loc28_ = _loc23_ + 4;
                           _loc26_ = 4;
                           _loc27_ += 4;
                           while(_loc28_ + 4 <= _loc5_ && li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc35_.maxMatchLength)
                           {
                              _loc26_ += 4;
                              _loc27_ += 4;
                              _loc28_ += 4;
                           }
                           while(_loc28_ < _loc5_ && li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc35_.maxMatchLength)
                           {
                              _loc26_++;
                              _loc27_++;
                              _loc28_++;
                           }
                           _loc24_ = int(_loc26_);
                           _loc25_ = int(_loc27_);
                        }
                        _loc29_ = 5;
                        _loc30_ = 9;
                        while(_loc29_ < _loc30_)
                        {
                           _loc31_ = int(_loc29_++);
                           _loc38_ = int(li32(_loc23_));
                           si32(_loc38_,_loc35_.hashScratchAddr);
                           _loc38_ = int(li32(_loc23_ + 4));
                           si32(_loc38_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc31_);
                           _loc38_ = 775236557;
                           _loc39_ = -862048943;
                           _loc40_ = 461845907;
                           _loc41_ = li32(_loc35_.hashScratchAddr) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc41_ = li32(_loc35_.hashScratchAddr + 4) * _loc39_;
                           _loc41_ = _loc41_ << 15 | _loc41_ >>> 17;
                           _loc38_ ^= _loc41_ * _loc40_;
                           _loc38_ = _loc38_ << 13 | _loc38_ >>> 19;
                           _loc38_ = _loc38_ * 5 + -430675100;
                           _loc42_ = _loc38_ ^ _loc31_;
                           _loc42_ ^= _loc42_ >>> 16;
                           _loc42_ *= -2048144789;
                           _loc42_ ^= _loc42_ >>> 13;
                           _loc42_ *= -1028477387;
                           _loc37_ = (_loc42_ ^ _loc42_ >>> 16) & 65535;
                           _loc36_ = _loc35_.addr + _loc37_ * 5 + 1;
                           _loc27_ = int(li32(_loc36_));
                           if(_loc27_ >= 0 && li32(_loc23_) == li32(_loc27_) && _loc23_ - _loc27_ <= _loc35_.windowSize)
                           {
                              _loc28_ = _loc23_ + 4;
                              _loc26_ = 4;
                              _loc27_ += 4;
                              while(_loc28_ + 4 <= _loc5_ && li32(_loc27_) == li32(_loc28_) && _loc26_ + 4 <= _loc35_.maxMatchLength)
                              {
                                 _loc26_ += 4;
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                              }
                              while(_loc28_ < _loc5_ && li8(_loc27_) == li8(_loc28_) && _loc26_ < _loc35_.maxMatchLength)
                              {
                                 _loc26_++;
                                 _loc27_++;
                                 _loc28_++;
                              }
                              if(_loc26_ > _loc24_)
                              {
                                 _loc24_ = int(_loc26_);
                                 _loc25_ = int(_loc27_);
                              }
                           }
                        }
                        si32(_loc23_ - (_loc25_ - _loc24_) << 16 | _loc24_,_loc35_.resultAddr);
                     }
                     else
                     {
                        si32(0,_loc35_.resultAddr);
                     }
                     _loc23_ = int(_loc22_);
                     _loc24_ = 4;
                     _loc25_ = _loc16_ + 1;
                     if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                     {
                        _loc27_ = int(li32(_loc23_ + 1));
                        si8(_loc24_,_loc23_);
                        si32(_loc25_,_loc23_ + 1);
                        _loc24_ = _loc26_ + 1;
                        _loc25_ = int(_loc27_);
                        _loc29_ = int(li32(_loc25_));
                        si32(_loc29_,_loc35_.hashScratchAddr);
                        _loc29_ = int(li32(_loc25_ + 4));
                        si32(_loc29_,_loc35_.hashScratchAddr + 4);
                        si32(0,_loc35_.hashScratchAddr + _loc24_);
                        _loc29_ = 775236557;
                        _loc30_ = -862048943;
                        _loc31_ = 461845907;
                        _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc29_ ^= _loc36_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                        _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                        _loc29_ ^= _loc36_ * _loc31_;
                        _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                        _loc29_ = _loc29_ * 5 + -430675100;
                        _loc37_ = _loc29_ ^ _loc24_;
                        _loc37_ ^= _loc37_ >>> 16;
                        _loc37_ *= -2048144789;
                        _loc37_ ^= _loc37_ >>> 13;
                        _loc37_ *= -1028477387;
                        _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                        _loc23_ = _loc35_.addr + _loc28_ * 5;
                        if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                        {
                           _loc27_ = int(li32(_loc23_ + 1));
                           si8(_loc24_,_loc23_);
                           si32(_loc25_,_loc23_ + 1);
                           _loc24_ = _loc26_ + 1;
                           _loc25_ = int(_loc27_);
                           _loc29_ = int(li32(_loc25_));
                           si32(_loc29_,_loc35_.hashScratchAddr);
                           _loc29_ = int(li32(_loc25_ + 4));
                           si32(_loc29_,_loc35_.hashScratchAddr + 4);
                           si32(0,_loc35_.hashScratchAddr + _loc24_);
                           _loc29_ = 775236557;
                           _loc30_ = -862048943;
                           _loc31_ = 461845907;
                           _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                           _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                           _loc29_ ^= _loc36_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                           _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                           _loc29_ ^= _loc36_ * _loc31_;
                           _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                           _loc29_ = _loc29_ * 5 + -430675100;
                           _loc37_ = _loc29_ ^ _loc24_;
                           _loc37_ ^= _loc37_ >>> 16;
                           _loc37_ *= -2048144789;
                           _loc37_ ^= _loc37_ >>> 13;
                           _loc37_ *= -1028477387;
                           _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                           _loc23_ = _loc35_.addr + _loc28_ * 5;
                           if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                           {
                              _loc27_ = int(li32(_loc23_ + 1));
                              si8(_loc24_,_loc23_);
                              si32(_loc25_,_loc23_ + 1);
                              _loc24_ = _loc26_ + 1;
                              _loc25_ = int(_loc27_);
                              _loc29_ = int(li32(_loc25_));
                              si32(_loc29_,_loc35_.hashScratchAddr);
                              _loc29_ = int(li32(_loc25_ + 4));
                              si32(_loc29_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc24_);
                              _loc29_ = 775236557;
                              _loc30_ = -862048943;
                              _loc31_ = 461845907;
                              _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                              _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                              _loc29_ ^= _loc36_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                              _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                              _loc29_ ^= _loc36_ * _loc31_;
                              _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                              _loc29_ = _loc29_ * 5 + -430675100;
                              _loc37_ = _loc29_ ^ _loc24_;
                              _loc37_ ^= _loc37_ >>> 16;
                              _loc37_ *= -2048144789;
                              _loc37_ ^= _loc37_ >>> 13;
                              _loc37_ *= -1028477387;
                              _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                              _loc23_ = _loc35_.addr + _loc28_ * 5;
                              if((_loc26_ = int(li8(_loc23_))) < 8 && _loc26_ >= 0)
                              {
                                 _loc27_ = int(li32(_loc23_ + 1));
                                 si8(_loc24_,_loc23_);
                                 si32(_loc25_,_loc23_ + 1);
                                 _loc24_ = _loc26_ + 1;
                                 _loc25_ = int(_loc27_);
                                 _loc29_ = int(li32(_loc25_));
                                 si32(_loc29_,_loc35_.hashScratchAddr);
                                 _loc29_ = int(li32(_loc25_ + 4));
                                 si32(_loc29_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc24_);
                                 _loc29_ = 775236557;
                                 _loc30_ = -862048943;
                                 _loc31_ = 461845907;
                                 _loc36_ = li32(_loc35_.hashScratchAddr) * _loc30_;
                                 _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                                 _loc29_ ^= _loc36_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc36_ = li32(_loc35_.hashScratchAddr + 4) * _loc30_;
                                 _loc36_ = _loc36_ << 15 | _loc36_ >>> 17;
                                 _loc29_ ^= _loc36_ * _loc31_;
                                 _loc29_ = _loc29_ << 13 | _loc29_ >>> 19;
                                 _loc29_ = _loc29_ * 5 + -430675100;
                                 _loc37_ = _loc29_ ^ _loc24_;
                                 _loc37_ ^= _loc37_ >>> 16;
                                 _loc37_ *= -2048144789;
                                 _loc37_ ^= _loc37_ >>> 13;
                                 _loc37_ *= -1028477387;
                                 _loc28_ = (_loc37_ ^ _loc37_ >>> 16) & 65535;
                                 _loc23_ = _loc35_.addr + _loc28_ * 5;
                              }
                           }
                        }
                     }
                     si8(_loc24_,_loc23_);
                     si32(_loc25_,_loc23_ + 1);
                     _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                     if(li16(_loc35_.resultAddr) >= 4)
                     {
                        _loc21_ = int(li16(_loc35_.resultAddr));
                        if(li16(_loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7)) > _loc21_)
                        {
                           si32(0,_loc35_.resultAddr);
                        }
                        else if(_loc16_ + _loc21_ + 9 < _loc5_)
                        {
                           if(_loc21_ < _loc35_.avgMatchLength + 4)
                           {
                              _loc23_ = _loc16_ + 1 + 1;
                              _loc24_ = _loc16_ + _loc21_;
                              while(_loc23_ < _loc24_)
                              {
                                 _loc25_ = int(_loc23_++);
                                 _loc26_ = 4;
                                 _loc27_ = int(_loc25_);
                                 _loc36_ = 775236557;
                                 _loc37_ = -862048943;
                                 _loc38_ = 461845907;
                                 _loc39_ = li32(_loc25_) * _loc37_;
                                 _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                 _loc36_ ^= _loc39_ * _loc38_;
                                 _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                 _loc36_ = _loc36_ * 5 + -430675100;
                                 _loc40_ = _loc36_ ^ 4;
                                 _loc40_ ^= _loc40_ >>> 16;
                                 _loc40_ *= -2048144789;
                                 _loc40_ ^= _loc40_ >>> 13;
                                 _loc40_ *= -1028477387;
                                 _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                 _loc30_ = _loc35_.addr + _loc31_ * 5;
                                 if((_loc28_ = int(li8(_loc30_))) < 8 && _loc28_ >= 0)
                                 {
                                    _loc29_ = int(li32(_loc30_ + 1));
                                    si8(_loc26_,_loc30_);
                                    si32(_loc27_,_loc30_ + 1);
                                    _loc26_ = _loc28_ + 1;
                                    _loc27_ = int(_loc29_);
                                    _loc36_ = int(li32(_loc27_));
                                    si32(_loc36_,_loc35_.hashScratchAddr);
                                    _loc36_ = int(li32(_loc27_ + 4));
                                    si32(_loc36_,_loc35_.hashScratchAddr + 4);
                                    si32(0,_loc35_.hashScratchAddr + _loc26_);
                                    _loc36_ = 775236557;
                                    _loc37_ = -862048943;
                                    _loc38_ = 461845907;
                                    _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                                    _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                    _loc36_ ^= _loc39_ * _loc38_;
                                    _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                    _loc36_ = _loc36_ * 5 + -430675100;
                                    _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                                    _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                    _loc36_ ^= _loc39_ * _loc38_;
                                    _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                    _loc36_ = _loc36_ * 5 + -430675100;
                                    _loc40_ = _loc36_ ^ _loc26_;
                                    _loc40_ ^= _loc40_ >>> 16;
                                    _loc40_ *= -2048144789;
                                    _loc40_ ^= _loc40_ >>> 13;
                                    _loc40_ *= -1028477387;
                                    _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                    _loc30_ = _loc35_.addr + _loc31_ * 5;
                                    if((_loc28_ = int(li8(_loc30_))) < 8 && _loc28_ >= 0)
                                    {
                                       _loc29_ = int(li32(_loc30_ + 1));
                                       si8(_loc26_,_loc30_);
                                       si32(_loc27_,_loc30_ + 1);
                                       _loc26_ = _loc28_ + 1;
                                       _loc27_ = int(_loc29_);
                                       _loc36_ = int(li32(_loc27_));
                                       si32(_loc36_,_loc35_.hashScratchAddr);
                                       _loc36_ = int(li32(_loc27_ + 4));
                                       si32(_loc36_,_loc35_.hashScratchAddr + 4);
                                       si32(0,_loc35_.hashScratchAddr + _loc26_);
                                       _loc36_ = 775236557;
                                       _loc37_ = -862048943;
                                       _loc38_ = 461845907;
                                       _loc39_ = li32(_loc35_.hashScratchAddr) * _loc37_;
                                       _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                       _loc36_ ^= _loc39_ * _loc38_;
                                       _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                       _loc36_ = _loc36_ * 5 + -430675100;
                                       _loc39_ = li32(_loc35_.hashScratchAddr + 4) * _loc37_;
                                       _loc39_ = _loc39_ << 15 | _loc39_ >>> 17;
                                       _loc36_ ^= _loc39_ * _loc38_;
                                       _loc36_ = _loc36_ << 13 | _loc36_ >>> 19;
                                       _loc36_ = _loc36_ * 5 + -430675100;
                                       _loc40_ = _loc36_ ^ _loc26_;
                                       _loc40_ ^= _loc40_ >>> 16;
                                       _loc40_ *= -2048144789;
                                       _loc40_ ^= _loc40_ >>> 13;
                                       _loc40_ *= -1028477387;
                                       _loc31_ = (_loc40_ ^ _loc40_ >>> 16) & 65535;
                                       _loc30_ = _loc35_.addr + _loc31_ * 5;
                                    }
                                 }
                                 si8(_loc26_,_loc30_);
                                 si32(_loc27_,_loc30_ + 1);
                              }
                           }
                           _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                           _loc23_ = _loc16_ + _loc21_;
                           _loc26_ = 775236557;
                           _loc27_ = -862048943;
                           _loc28_ = 461845907;
                           _loc29_ = li32(_loc23_) * _loc27_;
                           _loc29_ = _loc29_ << 15 | _loc29_ >>> 17;
                           _loc26_ ^= _loc29_ * _loc28_;
                           _loc26_ = _loc26_ << 13 | _loc26_ >>> 19;
                           _loc26_ = _loc26_ * 5 + -430675100;
                           _loc30_ = _loc26_ ^ 4;
                           _loc30_ ^= _loc30_ >>> 16;
                           _loc30_ *= -2048144789;
                           _loc30_ ^= _loc30_ >>> 13;
                           _loc30_ *= -1028477387;
                           _loc25_ = (_loc30_ ^ _loc30_ >>> 16) & 65535;
                           _loc24_ = _loc35_.addr + _loc25_ * 5;
                           _loc25_ = 3;
                           _loc26_ = -1;
                           _loc28_ = int(li32(_loc24_ + 1));
                           if(_loc28_ >= 0 && li32(_loc23_) == li32(_loc28_) && _loc23_ - _loc28_ <= _loc35_.windowSize)
                           {
                              _loc29_ = _loc23_ + 4;
                              _loc27_ = 4;
                              _loc28_ += 4;
                              while(_loc29_ + 4 <= _loc5_ && li32(_loc28_) == li32(_loc29_) && _loc27_ + 4 <= _loc35_.maxMatchLength)
                              {
                                 _loc27_ += 4;
                                 _loc28_ += 4;
                                 _loc29_ += 4;
                              }
                              while(_loc29_ < _loc5_ && li8(_loc28_) == li8(_loc29_) && _loc27_ < _loc35_.maxMatchLength)
                              {
                                 _loc27_++;
                                 _loc28_++;
                                 _loc29_++;
                              }
                              _loc25_ = int(_loc27_);
                              _loc26_ = int(_loc28_);
                           }
                           _loc30_ = 5;
                           _loc31_ = 9;
                           while(_loc30_ < _loc31_)
                           {
                              _loc36_ = int(_loc30_++);
                              _loc39_ = int(li32(_loc23_));
                              si32(_loc39_,_loc35_.hashScratchAddr);
                              _loc39_ = int(li32(_loc23_ + 4));
                              si32(_loc39_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc36_);
                              _loc39_ = 775236557;
                              _loc40_ = -862048943;
                              _loc41_ = 461845907;
                              _loc42_ = li32(_loc35_.hashScratchAddr) * _loc40_;
                              _loc42_ = _loc42_ << 15 | _loc42_ >>> 17;
                              _loc39_ ^= _loc42_ * _loc41_;
                              _loc39_ = _loc39_ << 13 | _loc39_ >>> 19;
                              _loc39_ = _loc39_ * 5 + -430675100;
                              _loc42_ = li32(_loc35_.hashScratchAddr + 4) * _loc40_;
                              _loc42_ = _loc42_ << 15 | _loc42_ >>> 17;
                              _loc39_ ^= _loc42_ * _loc41_;
                              _loc39_ = _loc39_ << 13 | _loc39_ >>> 19;
                              _loc39_ = _loc39_ * 5 + -430675100;
                              _loc43_ = _loc39_ ^ _loc36_;
                              _loc43_ ^= _loc43_ >>> 16;
                              _loc43_ *= -2048144789;
                              _loc43_ ^= _loc43_ >>> 13;
                              _loc43_ *= -1028477387;
                              _loc38_ = (_loc43_ ^ _loc43_ >>> 16) & 65535;
                              _loc37_ = _loc35_.addr + _loc38_ * 5 + 1;
                              _loc28_ = int(li32(_loc37_));
                              if(_loc28_ >= 0 && li32(_loc23_) == li32(_loc28_) && _loc23_ - _loc28_ <= _loc35_.windowSize)
                              {
                                 _loc29_ = _loc23_ + 4;
                                 _loc27_ = 4;
                                 _loc28_ += 4;
                                 while(_loc29_ + 4 <= _loc5_ && li32(_loc28_) == li32(_loc29_) && _loc27_ + 4 <= _loc35_.maxMatchLength)
                                 {
                                    _loc27_ += 4;
                                    _loc28_ += 4;
                                    _loc29_ += 4;
                                 }
                                 while(_loc29_ < _loc5_ && li8(_loc28_) == li8(_loc29_) && _loc27_ < _loc35_.maxMatchLength)
                                 {
                                    _loc27_++;
                                    _loc28_++;
                                    _loc29_++;
                                 }
                                 if(_loc27_ > _loc25_)
                                 {
                                    _loc25_ = int(_loc27_);
                                    _loc26_ = int(_loc28_);
                                 }
                              }
                           }
                           si32(_loc23_ - (_loc26_ - _loc25_) << 16 | _loc25_,_loc35_.resultAddr);
                           _loc25_ = int(_loc24_);
                           _loc26_ = 4;
                           _loc27_ = int(_loc23_);
                           if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                           {
                              _loc29_ = int(li32(_loc25_ + 1));
                              si8(_loc26_,_loc25_);
                              si32(_loc27_,_loc25_ + 1);
                              _loc26_ = _loc28_ + 1;
                              _loc27_ = int(_loc29_);
                              _loc31_ = int(li32(_loc27_));
                              si32(_loc31_,_loc35_.hashScratchAddr);
                              _loc31_ = int(li32(_loc27_ + 4));
                              si32(_loc31_,_loc35_.hashScratchAddr + 4);
                              si32(0,_loc35_.hashScratchAddr + _loc26_);
                              _loc31_ = 775236557;
                              _loc36_ = -862048943;
                              _loc37_ = 461845907;
                              _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc31_ ^= _loc38_ * _loc37_;
                              _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                              _loc31_ = _loc31_ * 5 + -430675100;
                              _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                              _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                              _loc31_ ^= _loc38_ * _loc37_;
                              _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                              _loc31_ = _loc31_ * 5 + -430675100;
                              _loc39_ = _loc31_ ^ _loc26_;
                              _loc39_ ^= _loc39_ >>> 16;
                              _loc39_ *= -2048144789;
                              _loc39_ ^= _loc39_ >>> 13;
                              _loc39_ *= -1028477387;
                              _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                              _loc25_ = _loc35_.addr + _loc30_ * 5;
                              if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                              {
                                 _loc29_ = int(li32(_loc25_ + 1));
                                 si8(_loc26_,_loc25_);
                                 si32(_loc27_,_loc25_ + 1);
                                 _loc26_ = _loc28_ + 1;
                                 _loc27_ = int(_loc29_);
                                 _loc31_ = int(li32(_loc27_));
                                 si32(_loc31_,_loc35_.hashScratchAddr);
                                 _loc31_ = int(li32(_loc27_ + 4));
                                 si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                 si32(0,_loc35_.hashScratchAddr + _loc26_);
                                 _loc31_ = 775236557;
                                 _loc36_ = -862048943;
                                 _loc37_ = 461845907;
                                 _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc31_ ^= _loc38_ * _loc37_;
                                 _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                 _loc31_ = _loc31_ * 5 + -430675100;
                                 _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                 _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                 _loc31_ ^= _loc38_ * _loc37_;
                                 _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                 _loc31_ = _loc31_ * 5 + -430675100;
                                 _loc39_ = _loc31_ ^ _loc26_;
                                 _loc39_ ^= _loc39_ >>> 16;
                                 _loc39_ *= -2048144789;
                                 _loc39_ ^= _loc39_ >>> 13;
                                 _loc39_ *= -1028477387;
                                 _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                 _loc25_ = _loc35_.addr + _loc30_ * 5;
                                 if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                                 {
                                    _loc29_ = int(li32(_loc25_ + 1));
                                    si8(_loc26_,_loc25_);
                                    si32(_loc27_,_loc25_ + 1);
                                    _loc26_ = _loc28_ + 1;
                                    _loc27_ = int(_loc29_);
                                    _loc31_ = int(li32(_loc27_));
                                    si32(_loc31_,_loc35_.hashScratchAddr);
                                    _loc31_ = int(li32(_loc27_ + 4));
                                    si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                    si32(0,_loc35_.hashScratchAddr + _loc26_);
                                    _loc31_ = 775236557;
                                    _loc36_ = -862048943;
                                    _loc37_ = 461845907;
                                    _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc31_ ^= _loc38_ * _loc37_;
                                    _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                    _loc31_ = _loc31_ * 5 + -430675100;
                                    _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                    _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                    _loc31_ ^= _loc38_ * _loc37_;
                                    _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                    _loc31_ = _loc31_ * 5 + -430675100;
                                    _loc39_ = _loc31_ ^ _loc26_;
                                    _loc39_ ^= _loc39_ >>> 16;
                                    _loc39_ *= -2048144789;
                                    _loc39_ ^= _loc39_ >>> 13;
                                    _loc39_ *= -1028477387;
                                    _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                    _loc25_ = _loc35_.addr + _loc30_ * 5;
                                    if((_loc28_ = int(li8(_loc25_))) < 8 && _loc28_ >= 0)
                                    {
                                       _loc29_ = int(li32(_loc25_ + 1));
                                       si8(_loc26_,_loc25_);
                                       si32(_loc27_,_loc25_ + 1);
                                       _loc26_ = _loc28_ + 1;
                                       _loc27_ = int(_loc29_);
                                       _loc31_ = int(li32(_loc27_));
                                       si32(_loc31_,_loc35_.hashScratchAddr);
                                       _loc31_ = int(li32(_loc27_ + 4));
                                       si32(_loc31_,_loc35_.hashScratchAddr + 4);
                                       si32(0,_loc35_.hashScratchAddr + _loc26_);
                                       _loc31_ = 775236557;
                                       _loc36_ = -862048943;
                                       _loc37_ = 461845907;
                                       _loc38_ = li32(_loc35_.hashScratchAddr) * _loc36_;
                                       _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                       _loc31_ ^= _loc38_ * _loc37_;
                                       _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                       _loc31_ = _loc31_ * 5 + -430675100;
                                       _loc38_ = li32(_loc35_.hashScratchAddr + 4) * _loc36_;
                                       _loc38_ = _loc38_ << 15 | _loc38_ >>> 17;
                                       _loc31_ ^= _loc38_ * _loc37_;
                                       _loc31_ = _loc31_ << 13 | _loc31_ >>> 19;
                                       _loc31_ = _loc31_ * 5 + -430675100;
                                       _loc39_ = _loc31_ ^ _loc26_;
                                       _loc39_ ^= _loc39_ >>> 16;
                                       _loc39_ *= -2048144789;
                                       _loc39_ ^= _loc39_ >>> 13;
                                       _loc39_ *= -1028477387;
                                       _loc30_ = (_loc39_ ^ _loc39_ >>> 16) & 65535;
                                       _loc25_ = _loc35_.addr + _loc30_ * 5;
                                    }
                                 }
                              }
                           }
                           si8(_loc26_,_loc25_);
                           si32(_loc27_,_loc25_ + 1);
                           _loc35_.resultAddr = _loc35_.baseResultAddr + (_loc35_.resultAddr - _loc35_.baseResultAddr + 4 & 7);
                        }
                     }
                     if(li16(_loc35_.resultAddr) >= 4)
                     {
                        _loc14_ = int(li16(_loc35_.resultAddr));
                        _loc21_ = int(li16(scratchAddr + 2492 + (_loc14_ << 2) + 2));
                        _loc22_ = 0;
                        _loc23_ = scratchAddr + _loc22_ + (_loc21_ << 2);
                        _loc24_ = li32(_loc23_) + 1;
                        si32(_loc24_,_loc23_);
                        _loc21_ = int(li16(_loc35_.resultAddr + 2));
                        _loc15_ = int(li32(scratchAddr + 3528 + ((_loc21_ <= 256 ? _loc21_ : 256 + (_loc21_ - 1 >>> 7)) << 2)));
                        _loc21_ = scratchAddr + 1144 + (_loc15_ >>> 24 << 2);
                        _loc22_ = li32(_loc21_) + 1;
                        si32(_loc22_,_loc21_);
                        _loc21_ = li32(_loc35_.resultAddr) | 512;
                        si32(_loc21_,_loc20_);
                        _loc20_ += 4;
                        _loc16_ += _loc14_;
                     }
                     else
                     {
                        _loc13_ = int(li8(_loc16_));
                        si16(_loc13_,_loc20_);
                        _loc21_ = 0;
                        _loc22_ = scratchAddr + _loc21_ + (_loc13_ << 2);
                        _loc23_ = li32(_loc22_) + 1;
                        si32(_loc23_,_loc22_);
                        _loc20_ += 2;
                        _loc16_++;
                     }
                  }
                  while(_loc16_ < _loc5_)
                  {
                     _loc13_ = int(li8(_loc16_));
                     si16(_loc13_,_loc20_);
                     _loc21_ = 0;
                     _loc22_ = scratchAddr + _loc21_ + (_loc13_ << 2);
                     _loc23_ = li32(_loc22_) + 1;
                     si32(_loc23_,_loc22_);
                     _loc20_ += 2;
                     _loc16_++;
                  }
                  _loc12_ = false;
                  blockInProgress = true;
                  if(level == CompressionLevel.UNCOMPRESSED)
                  {
                     if(bitOffset == 0)
                     {
                        si8(0,currentAddr);
                     }
                     _loc21_ = int(li8(currentAddr));
                     _loc21_ |= (!!_loc12_ ? 1 : 0) << bitOffset;
                     si32(_loc21_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                     if(bitOffset > 0)
                     {
                        _loc21_ = int(li8(currentAddr));
                        _loc21_ |= 0 << bitOffset;
                        si32(_loc21_,currentAddr);
                        bitOffset += 8 - bitOffset;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                  }
                  else
                  {
                     _loc21_ = int(li8(currentAddr));
                     _loc21_ |= (4 | (!!_loc12_ ? 1 : 0)) << bitOffset;
                     si32(_loc21_,currentAddr);
                     bitOffset += 3;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockStartAddr = currentAddr;
                  createAndWriteHuffmanTrees(_loc4_,_loc5_);
                  _loc16_ = int(_loc18_);
                  while(_loc16_ + 64 <= _loc20_)
                  {
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                  }
                  while(_loc16_ < _loc20_)
                  {
                     _loc25_ = int(li16(_loc16_));
                     if((_loc25_ & 512) != 0)
                     {
                        _loc21_ = _loc25_ ^ 512;
                        _loc23_ = int(li32(scratchAddr + 2492 + (_loc21_ << 2)));
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + (_loc23_ >>> 16) * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc21_ - (_loc23_ & 8191) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc23_ & 65280) >>> 13;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc22_ = int(li16(_loc16_ + 2));
                        _loc24_ = int(li32(scratchAddr + 3528 + ((_loc22_ <= 256 ? _loc22_ : 256 + (_loc22_ - 1 >>> 7)) << 2)));
                        _loc26_ = int(li32(scratchAddr + 1144 + (_loc24_ >>> 24) * 4));
                        _loc27_ = int(li8(currentAddr));
                        _loc27_ |= _loc26_ >>> 16 << bitOffset;
                        si32(_loc27_,currentAddr);
                        bitOffset += _loc26_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                        _loc26_ = int(li8(currentAddr));
                        _loc26_ |= _loc22_ - (_loc24_ & 65535) << bitOffset;
                        si32(_loc26_,currentAddr);
                        bitOffset += (_loc24_ & 16711680) >>> 16;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     else
                     {
                        _loc26_ = 0;
                        _loc27_ = int(li32(scratchAddr + _loc26_ + _loc25_ * 4));
                        _loc28_ = int(li8(currentAddr));
                        _loc28_ |= _loc27_ >>> 16 << bitOffset;
                        si32(_loc28_,currentAddr);
                        bitOffset += _loc27_ & 65535;
                        currentAddr += bitOffset >>> 3;
                        bitOffset &= 7;
                     }
                     _loc13_ = int(_loc25_);
                     _loc16_ += 2 + ((_loc13_ & 512) >>> 8);
                  }
                  if(level != CompressionLevel.UNCOMPRESSED)
                  {
                     _loc21_ = 0;
                     _loc22_ = int(li32(scratchAddr + _loc21_ + 1024));
                     _loc23_ = int(li8(currentAddr));
                     _loc23_ |= _loc22_ >>> 16 << bitOffset;
                     si32(_loc23_,currentAddr);
                     bitOffset += _loc22_ & 65535;
                     currentAddr += bitOffset >>> 3;
                     bitOffset &= 7;
                  }
                  blockInProgress = false;
                  _loc4_ = int(_loc5_);
               }
            }
         }
      }
      
      public function _createAndWriteHuffmanTrees(param1:int, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc3_:* = 0;
         if(level == CompressionLevel.FAST)
         {
            _loc3_ = 257;
            _loc4_ = 0;
            while(_loc4_ < 256)
            {
               _loc5_ = int(_loc4_++);
               si32(10,scratchAddr + _loc5_ * 4);
            }
            si32(1,scratchAddr + 1024);
            _loc4_ = param2 - param1;
            if(_loc4_ <= 16384)
            {
               _loc5_ = 1;
            }
            else if(_loc4_ <= 102400)
            {
               _loc5_ = 5;
            }
            else
            {
               _loc5_ = 11;
            }
            _loc7_ = int(_loc4_ / _loc5_);
            _loc8_ = _loc7_ & -16;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc6_ = int(li8(param1 + _loc9_ * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 1) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 2) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 3) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 4) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 5) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 6) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 7) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 8) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 9) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 10) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 11) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 12) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 13) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 14) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc6_ = int(li8(param1 + (_loc9_ + 15) * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc9_ += 16;
            }
            while(_loc9_ < _loc7_)
            {
               _loc6_ = int(li8(param1 + _loc9_ * _loc5_));
               _loc10_ = li32(scratchAddr + _loc6_ * 4) + 1;
               si32(_loc10_,scratchAddr + _loc6_ * 4);
               _loc9_++;
            }
         }
         else if(level == CompressionLevel.NORMAL || level == CompressionLevel.GOOD)
         {
            _loc3_ = 257;
            _loc4_ = 257;
            while(_loc4_ < 286)
            {
               _loc5_ = int(_loc4_++);
               if(li32(scratchAddr + _loc5_ * 4) > 0)
               {
                  _loc3_ = _loc5_ + 1;
               }
            }
            si32(1,scratchAddr + 1024);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = int(_loc4_++);
               if(_loc5_ != 256 && li32(scratchAddr + _loc5_ * 4) > 0)
               {
                  _loc6_ = li32(scratchAddr + _loc5_ * 4) + 2;
                  si32(_loc6_,scratchAddr + _loc5_ * 4);
               }
            }
         }
         HuffmanTree.weightedAlphabetToCodes(scratchAddr,scratchAddr + _loc3_ * 4,15);
         literalLengthCodes = _loc3_;
         _loc3_ = scratchAddr + 1144;
         _loc4_ = 0;
         if(level == CompressionLevel.NORMAL || level == CompressionLevel.GOOD)
         {
            _loc5_ = 0;
            while(_loc5_ < 30)
            {
               _loc6_ = int(_loc5_++);
               if(li32(_loc3_ + _loc6_ * 4) > 0)
               {
                  _loc4_ = _loc6_ + 1;
               }
            }
         }
         HuffmanTree.weightedAlphabetToCodes(_loc3_,_loc3_ + _loc4_ * 4,15);
         distanceCodes = _loc4_;
         _loc4_ = 0;
         while(_loc4_ < 19)
         {
            _loc5_ = int(_loc4_++);
            si32(1,scratchAddr + 1272 + _loc5_ * 4);
         }
         _loc5_ = 0;
         while(_loc5_ < literalLengthCodes)
         {
            _loc6_ = int(_loc5_++);
            _loc4_ = scratchAddr + 1272 + li16(scratchAddr + _loc6_ * 4) * 4;
            _loc7_ = li32(_loc4_) + 1;
            si32(_loc7_,_loc4_);
         }
         _loc5_ = 0;
         while(_loc5_ < distanceCodes)
         {
            _loc6_ = int(_loc5_++);
            _loc4_ = scratchAddr + 1272 + li16(scratchAddr + 1144 + _loc6_ * 4) * 4;
            _loc7_ = li32(_loc4_) + 1;
            si32(_loc7_,_loc4_);
         }
         _loc5_ = scratchAddr + 1272;
         HuffmanTree.weightedAlphabetToCodes(_loc5_,_loc5_ + 76,7);
         _loc3_ = 19;
         _loc4_ = int(li8(currentAddr));
         _loc4_ |= literalLengthCodes - 257 << bitOffset;
         si32(_loc4_,currentAddr);
         bitOffset += 5;
         currentAddr += bitOffset >>> 3;
         bitOffset &= 7;
         if(distanceCodes == 0)
         {
            _loc4_ = int(li8(currentAddr));
            _loc4_ |= 0 << bitOffset;
            si32(_loc4_,currentAddr);
            bitOffset += 5;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         else
         {
            _loc4_ = int(li8(currentAddr));
            _loc4_ |= distanceCodes - 1 << bitOffset;
            si32(_loc4_,currentAddr);
            bitOffset += 5;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         _loc4_ = int(li8(currentAddr));
         _loc4_ |= _loc3_ - 4 << bitOffset;
         si32(_loc4_,currentAddr);
         bitOffset += 4;
         currentAddr += bitOffset >>> 3;
         bitOffset &= 7;
         _loc4_ = 0;
         var _loc11_:Array = [16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15];
         while(_loc4_ < int(_loc11_.length))
         {
            _loc5_ = int(_loc11_[_loc4_]);
            _loc4_++;
            _loc6_ = int(li16(scratchAddr + 1272 + _loc5_ * 4));
            _loc7_ = int(li8(currentAddr));
            _loc7_ |= _loc6_ << bitOffset;
            si32(_loc7_,currentAddr);
            bitOffset += 3;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         _loc4_ = 0;
         _loc5_ = int(literalLengthCodes);
         while(_loc4_ < _loc5_)
         {
            _loc6_ = int(_loc4_++);
            _loc7_ = int(li16(scratchAddr + _loc6_ * 4));
            _loc8_ = int(li32(scratchAddr + 1272 + _loc7_ * 4));
            _loc9_ = int(li8(currentAddr));
            _loc9_ |= _loc8_ >>> 16 << bitOffset;
            si32(_loc9_,currentAddr);
            bitOffset += _loc8_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         if(distanceCodes == 0)
         {
            _loc4_ = int(li32(scratchAddr + 1272));
            _loc5_ = int(li8(currentAddr));
            _loc5_ |= _loc4_ >>> 16 << bitOffset;
            si32(_loc5_,currentAddr);
            bitOffset += _loc4_ & 65535;
            currentAddr += bitOffset >>> 3;
            bitOffset &= 7;
         }
         else
         {
            _loc4_ = 0;
            _loc5_ = int(distanceCodes);
            while(_loc4_ < _loc5_)
            {
               _loc6_ = int(_loc4_++);
               _loc7_ = int(li16(scratchAddr + 1144 + _loc6_ * 4));
               _loc8_ = int(li32(scratchAddr + 1272 + _loc7_ * 4));
               _loc9_ = int(li8(currentAddr));
               _loc9_ |= _loc8_ >>> 16 << bitOffset;
               si32(_loc9_,currentAddr);
               bitOffset += _loc8_ & 65535;
               currentAddr += bitOffset >>> 3;
               bitOffset &= 7;
            }
         }
      }
   }
}
