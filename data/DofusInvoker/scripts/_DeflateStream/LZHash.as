package _DeflateStream
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public class LZHash
   {
      
      public static var HASH_BITS:int = 16;
      
      public static var HASH_ENTRIES:int = 65536;
      
      public static var HASH_MASK:int = 65535;
      
      public static var SLOT_SIZE:int = 5;
      
      public static var HASH_SIZE:int = 327680;
      
      public static var MAX_ATTEMPTS:int = 5;
      
      public static var MAX_HASH_DEPTH:int = 8;
      
      public static var LOOKAHEADS:int = 1;
      
      public static var LOOKAHEAD_SIZE:int = 8;
      
      public static var LOOKAHEAD_MASK:int = 7;
      
      public static var HASH_SCRATCH_SIZE:int = 12;
      
      public static var SCRATCH_SIZE:int = 20;
      
      public static var GOOD_MATCH_LENGTH_THRESHOLD:int = 4;
      
      public static var MEMORY_SIZE:int = 327700;
      
      public static var MAX_LOOKAHEAD:int = 9;
      
      public static var MIN_MATCH_LENGTH:int = 4;
       
      
      public var windowSize:int;
      
      public var resultAddr:int;
      
      public var maxMatchLength:int;
      
      public var hashScratchAddr:int;
      
      public var baseResultAddr:int;
      
      public var avgMatchLength:int;
      
      public var addr:int;
      
      public function LZHash(param1:int, param2:int, param3:int)
      {
         addr = param1;
         maxMatchLength = param2;
         windowSize = param3;
         avgMatchLength = 12;
         baseResultAddr = resultAddr = param1 + 327700 - 20;
         hashScratchAddr = baseResultAddr + 8;
         clearTable();
      }
      
      public static function hash4(param1:int, param2:int) : int
      {
         var _loc3_:* = 775236557;
         var _loc4_:int = -862048943;
         var _loc5_:int = 461845907;
         var _loc6_:* = li32(param1) * _loc4_;
         _loc6_ = _loc6_ << 15 | _loc6_ >>> 17;
         _loc3_ ^= _loc6_ * _loc5_;
         _loc3_ = _loc3_ << 13 | _loc3_ >>> 19;
         _loc3_ = _loc3_ * 5 + -430675100;
         var _loc7_:* = _loc3_ ^ 4;
         _loc7_ ^= _loc7_ >>> 16;
         _loc7_ *= -2048144789;
         _loc7_ ^= _loc7_ >>> 13;
         _loc7_ *= -1028477387;
         return (_loc7_ ^ _loc7_ >>> 16) & param2;
      }
      
      public static function murmur_fmix(param1:int) : int
      {
         param1 ^= param1 >>> 16;
         param1 *= -2048144789;
         param1 ^= param1 >>> 13;
         param1 *= -1028477387;
         return param1 ^ param1 >>> 16;
      }
      
      public function update(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc4_:* = 775236557;
         var _loc5_:int = -862048943;
         _loc6_ = 461845907;
         _loc7_ = li32(param1) * _loc5_;
         _loc7_ = _loc7_ << 15 | _loc7_ >>> 17;
         _loc4_ ^= _loc7_ * _loc6_;
         _loc4_ = _loc4_ << 13 | _loc4_ >>> 19;
         _loc4_ = _loc4_ * 5 + -430675100;
         _loc8_ = _loc4_ ^ 4;
         _loc8_ ^= _loc8_ >>> 16;
         _loc8_ *= -2048144789;
         _loc8_ ^= _loc8_ >>> 13;
         _loc8_ *= -1028477387;
         var _loc3_:* = (_loc8_ ^ _loc8_ >>> 16) & 65535;
         var _loc2_:* = addr + _loc3_ * 5;
         _loc3_ = 4;
         _loc4_ = int(param1);
         if((_loc5_ = li8(_loc2_)) < 8 && _loc5_ >= 0)
         {
            _loc6_ = li32(_loc2_ + 1);
            si8(_loc3_,_loc2_);
            si32(_loc4_,_loc2_ + 1);
            _loc3_ = _loc5_ + 1;
            _loc4_ = int(_loc6_);
            _loc8_ = int(li32(_loc4_));
            si32(_loc8_,hashScratchAddr);
            _loc8_ = int(li32(_loc4_ + 4));
            si32(_loc8_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc3_);
            _loc8_ = 775236557;
            _loc9_ = -862048943;
            _loc10_ = 461845907;
            _loc11_ = li32(hashScratchAddr) * _loc9_;
            _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
            _loc8_ ^= _loc11_ * _loc10_;
            _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
            _loc8_ = _loc8_ * 5 + -430675100;
            _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
            _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
            _loc8_ ^= _loc11_ * _loc10_;
            _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
            _loc8_ = _loc8_ * 5 + -430675100;
            _loc12_ = _loc8_ ^ _loc3_;
            _loc12_ ^= _loc12_ >>> 16;
            _loc12_ *= -2048144789;
            _loc12_ ^= _loc12_ >>> 13;
            _loc12_ *= -1028477387;
            _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
            _loc2_ = addr + _loc7_ * 5;
            if((_loc5_ = li8(_loc2_)) < 8 && _loc5_ >= 0)
            {
               _loc6_ = li32(_loc2_ + 1);
               si8(_loc3_,_loc2_);
               si32(_loc4_,_loc2_ + 1);
               _loc3_ = _loc5_ + 1;
               _loc4_ = int(_loc6_);
               _loc8_ = int(li32(_loc4_));
               si32(_loc8_,hashScratchAddr);
               _loc8_ = int(li32(_loc4_ + 4));
               si32(_loc8_,hashScratchAddr + 4);
               si32(0,hashScratchAddr + _loc3_);
               _loc8_ = 775236557;
               _loc9_ = -862048943;
               _loc10_ = 461845907;
               _loc11_ = li32(hashScratchAddr) * _loc9_;
               _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
               _loc8_ ^= _loc11_ * _loc10_;
               _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
               _loc8_ = _loc8_ * 5 + -430675100;
               _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
               _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
               _loc8_ ^= _loc11_ * _loc10_;
               _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
               _loc8_ = _loc8_ * 5 + -430675100;
               _loc12_ = _loc8_ ^ _loc3_;
               _loc12_ ^= _loc12_ >>> 16;
               _loc12_ *= -2048144789;
               _loc12_ ^= _loc12_ >>> 13;
               _loc12_ *= -1028477387;
               _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
               _loc2_ = addr + _loc7_ * 5;
               if((_loc5_ = li8(_loc2_)) < 8 && _loc5_ >= 0)
               {
                  _loc6_ = li32(_loc2_ + 1);
                  si8(_loc3_,_loc2_);
                  si32(_loc4_,_loc2_ + 1);
                  _loc3_ = _loc5_ + 1;
                  _loc4_ = int(_loc6_);
                  _loc8_ = int(li32(_loc4_));
                  si32(_loc8_,hashScratchAddr);
                  _loc8_ = int(li32(_loc4_ + 4));
                  si32(_loc8_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc3_);
                  _loc8_ = 775236557;
                  _loc9_ = -862048943;
                  _loc10_ = 461845907;
                  _loc11_ = li32(hashScratchAddr) * _loc9_;
                  _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
                  _loc8_ ^= _loc11_ * _loc10_;
                  _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
                  _loc8_ = _loc8_ * 5 + -430675100;
                  _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
                  _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
                  _loc8_ ^= _loc11_ * _loc10_;
                  _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
                  _loc8_ = _loc8_ * 5 + -430675100;
                  _loc12_ = _loc8_ ^ _loc3_;
                  _loc12_ ^= _loc12_ >>> 16;
                  _loc12_ *= -2048144789;
                  _loc12_ ^= _loc12_ >>> 13;
                  _loc12_ *= -1028477387;
                  _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
                  _loc2_ = addr + _loc7_ * 5;
                  if((_loc5_ = li8(_loc2_)) < 8 && _loc5_ >= 0)
                  {
                     _loc6_ = li32(_loc2_ + 1);
                     si8(_loc3_,_loc2_);
                     si32(_loc4_,_loc2_ + 1);
                     _loc3_ = _loc5_ + 1;
                     _loc4_ = int(_loc6_);
                     _loc8_ = int(li32(_loc4_));
                     si32(_loc8_,hashScratchAddr);
                     _loc8_ = int(li32(_loc4_ + 4));
                     si32(_loc8_,hashScratchAddr + 4);
                     si32(0,hashScratchAddr + _loc3_);
                     _loc8_ = 775236557;
                     _loc9_ = -862048943;
                     _loc10_ = 461845907;
                     _loc11_ = li32(hashScratchAddr) * _loc9_;
                     _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
                     _loc8_ ^= _loc11_ * _loc10_;
                     _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
                     _loc8_ = _loc8_ * 5 + -430675100;
                     _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
                     _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
                     _loc8_ ^= _loc11_ * _loc10_;
                     _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
                     _loc8_ = _loc8_ * 5 + -430675100;
                     _loc12_ = _loc8_ ^ _loc3_;
                     _loc12_ ^= _loc12_ >>> 16;
                     _loc12_ *= -2048144789;
                     _loc12_ ^= _loc12_ >>> 13;
                     _loc12_ *= -1028477387;
                     _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
                     _loc2_ = addr + _loc7_ * 5;
                  }
               }
            }
         }
         si8(_loc3_,_loc2_);
         si32(_loc4_,_loc2_ + 1);
      }
      
      public function unsafeSearchAndUpdate(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         _loc5_ = 775236557;
         _loc6_ = -862048943;
         _loc7_ = 461845907;
         _loc8_ = li32(param1 + 1) * _loc6_;
         _loc8_ = _loc8_ << 15 | _loc8_ >>> 17;
         _loc5_ ^= _loc8_ * _loc7_;
         _loc5_ = _loc5_ << 13 | _loc5_ >>> 19;
         _loc5_ = _loc5_ * 5 + -430675100;
         _loc9_ = _loc5_ ^ 4;
         _loc9_ ^= _loc9_ >>> 16;
         _loc9_ *= -2048144789;
         _loc9_ ^= _loc9_ >>> 13;
         _loc9_ *= -1028477387;
         _loc4_ = (_loc9_ ^ _loc9_ >>> 16) & 65535;
         var _loc3_:* = addr + _loc4_ * 5;
         if(li16(baseResultAddr + (resultAddr - baseResultAddr + 4 & 7)) < avgMatchLength + 4)
         {
            _loc4_ = param1 + 1;
            _loc5_ = 3;
            _loc6_ = -1;
            _loc8_ = int(li32(_loc3_ + 1));
            if(_loc8_ >= 0 && li32(_loc4_) == li32(_loc8_) && _loc4_ - _loc8_ <= windowSize)
            {
               _loc9_ = _loc4_ + 4;
               _loc7_ = 4;
               _loc8_ += 4;
               while(li32(_loc8_) == li32(_loc9_) && _loc7_ + 4 <= maxMatchLength)
               {
                  _loc7_ += 4;
                  _loc8_ += 4;
                  _loc9_ += 4;
               }
               while(li8(_loc8_) == li8(_loc9_) && _loc7_ < maxMatchLength)
               {
                  _loc7_++;
                  _loc8_++;
                  _loc9_++;
               }
               _loc5_ = int(_loc7_);
               _loc6_ = int(_loc8_);
            }
            _loc10_ = 5;
            _loc11_ = 9;
            while(_loc10_ < _loc11_)
            {
               _loc12_ = int(_loc10_++);
               _loc15_ = int(li32(_loc4_));
               si32(_loc15_,hashScratchAddr);
               _loc15_ = int(li32(_loc4_ + 4));
               si32(_loc15_,hashScratchAddr + 4);
               si32(0,hashScratchAddr + _loc12_);
               _loc15_ = 775236557;
               _loc16_ = -862048943;
               _loc17_ = 461845907;
               _loc18_ = li32(hashScratchAddr) * _loc16_;
               _loc18_ = _loc18_ << 15 | _loc18_ >>> 17;
               _loc15_ ^= _loc18_ * _loc17_;
               _loc15_ = _loc15_ << 13 | _loc15_ >>> 19;
               _loc15_ = _loc15_ * 5 + -430675100;
               _loc18_ = li32(hashScratchAddr + 4) * _loc16_;
               _loc18_ = _loc18_ << 15 | _loc18_ >>> 17;
               _loc15_ ^= _loc18_ * _loc17_;
               _loc15_ = _loc15_ << 13 | _loc15_ >>> 19;
               _loc15_ = _loc15_ * 5 + -430675100;
               _loc19_ = _loc15_ ^ _loc12_;
               _loc19_ ^= _loc19_ >>> 16;
               _loc19_ *= -2048144789;
               _loc19_ ^= _loc19_ >>> 13;
               _loc19_ *= -1028477387;
               _loc14_ = (_loc19_ ^ _loc19_ >>> 16) & 65535;
               _loc13_ = addr + _loc14_ * 5 + 1;
               _loc8_ = int(li32(_loc13_));
               if(_loc8_ >= 0 && li32(_loc8_ + _loc5_ - 3) == li32(_loc4_ + _loc5_ - 3) && li32(_loc4_) == li32(_loc8_) && _loc4_ - _loc8_ <= windowSize)
               {
                  _loc9_ = _loc4_ + 4;
                  _loc7_ = 4;
                  _loc8_ += 4;
                  while(li32(_loc8_) == li32(_loc9_) && _loc7_ + 4 <= maxMatchLength)
                  {
                     _loc7_ += 4;
                     _loc8_ += 4;
                     _loc9_ += 4;
                  }
                  while(li8(_loc8_) == li8(_loc9_) && _loc7_ < maxMatchLength)
                  {
                     _loc7_++;
                     _loc8_++;
                     _loc9_++;
                  }
                  if(_loc7_ > _loc5_)
                  {
                     _loc5_ = int(_loc7_);
                     _loc6_ = int(_loc8_);
                  }
               }
            }
            si32(_loc4_ - (_loc6_ - _loc5_) << 16 | _loc5_,resultAddr);
         }
         else
         {
            si32(0,resultAddr);
         }
         _loc4_ = int(_loc3_);
         _loc5_ = 4;
         _loc6_ = param1 + 1;
         if((_loc7_ = int(li8(_loc4_))) < 8 && _loc7_ >= 0)
         {
            _loc8_ = int(li32(_loc4_ + 1));
            si8(_loc5_,_loc4_);
            si32(_loc6_,_loc4_ + 1);
            _loc5_ = _loc7_ + 1;
            _loc6_ = int(_loc8_);
            _loc10_ = int(li32(_loc6_));
            si32(_loc10_,hashScratchAddr);
            _loc10_ = int(li32(_loc6_ + 4));
            si32(_loc10_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc5_);
            _loc10_ = 775236557;
            _loc11_ = -862048943;
            _loc12_ = 461845907;
            _loc13_ = li32(hashScratchAddr) * _loc11_;
            _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
            _loc10_ ^= _loc13_ * _loc12_;
            _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
            _loc10_ = _loc10_ * 5 + -430675100;
            _loc13_ = li32(hashScratchAddr + 4) * _loc11_;
            _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
            _loc10_ ^= _loc13_ * _loc12_;
            _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
            _loc10_ = _loc10_ * 5 + -430675100;
            _loc14_ = _loc10_ ^ _loc5_;
            _loc14_ ^= _loc14_ >>> 16;
            _loc14_ *= -2048144789;
            _loc14_ ^= _loc14_ >>> 13;
            _loc14_ *= -1028477387;
            _loc9_ = (_loc14_ ^ _loc14_ >>> 16) & 65535;
            _loc4_ = addr + _loc9_ * 5;
            if((_loc7_ = int(li8(_loc4_))) < 8 && _loc7_ >= 0)
            {
               _loc8_ = int(li32(_loc4_ + 1));
               si8(_loc5_,_loc4_);
               si32(_loc6_,_loc4_ + 1);
               _loc5_ = _loc7_ + 1;
               _loc6_ = int(_loc8_);
               _loc10_ = int(li32(_loc6_));
               si32(_loc10_,hashScratchAddr);
               _loc10_ = int(li32(_loc6_ + 4));
               si32(_loc10_,hashScratchAddr + 4);
               si32(0,hashScratchAddr + _loc5_);
               _loc10_ = 775236557;
               _loc11_ = -862048943;
               _loc12_ = 461845907;
               _loc13_ = li32(hashScratchAddr) * _loc11_;
               _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
               _loc10_ ^= _loc13_ * _loc12_;
               _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
               _loc10_ = _loc10_ * 5 + -430675100;
               _loc13_ = li32(hashScratchAddr + 4) * _loc11_;
               _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
               _loc10_ ^= _loc13_ * _loc12_;
               _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
               _loc10_ = _loc10_ * 5 + -430675100;
               _loc14_ = _loc10_ ^ _loc5_;
               _loc14_ ^= _loc14_ >>> 16;
               _loc14_ *= -2048144789;
               _loc14_ ^= _loc14_ >>> 13;
               _loc14_ *= -1028477387;
               _loc9_ = (_loc14_ ^ _loc14_ >>> 16) & 65535;
               _loc4_ = addr + _loc9_ * 5;
               if((_loc7_ = int(li8(_loc4_))) < 8 && _loc7_ >= 0)
               {
                  _loc8_ = int(li32(_loc4_ + 1));
                  si8(_loc5_,_loc4_);
                  si32(_loc6_,_loc4_ + 1);
                  _loc5_ = _loc7_ + 1;
                  _loc6_ = int(_loc8_);
                  _loc10_ = int(li32(_loc6_));
                  si32(_loc10_,hashScratchAddr);
                  _loc10_ = int(li32(_loc6_ + 4));
                  si32(_loc10_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc5_);
                  _loc10_ = 775236557;
                  _loc11_ = -862048943;
                  _loc12_ = 461845907;
                  _loc13_ = li32(hashScratchAddr) * _loc11_;
                  _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
                  _loc10_ ^= _loc13_ * _loc12_;
                  _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
                  _loc10_ = _loc10_ * 5 + -430675100;
                  _loc13_ = li32(hashScratchAddr + 4) * _loc11_;
                  _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
                  _loc10_ ^= _loc13_ * _loc12_;
                  _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
                  _loc10_ = _loc10_ * 5 + -430675100;
                  _loc14_ = _loc10_ ^ _loc5_;
                  _loc14_ ^= _loc14_ >>> 16;
                  _loc14_ *= -2048144789;
                  _loc14_ ^= _loc14_ >>> 13;
                  _loc14_ *= -1028477387;
                  _loc9_ = (_loc14_ ^ _loc14_ >>> 16) & 65535;
                  _loc4_ = addr + _loc9_ * 5;
                  if((_loc7_ = int(li8(_loc4_))) < 8 && _loc7_ >= 0)
                  {
                     _loc8_ = int(li32(_loc4_ + 1));
                     si8(_loc5_,_loc4_);
                     si32(_loc6_,_loc4_ + 1);
                     _loc5_ = _loc7_ + 1;
                     _loc6_ = int(_loc8_);
                     _loc10_ = int(li32(_loc6_));
                     si32(_loc10_,hashScratchAddr);
                     _loc10_ = int(li32(_loc6_ + 4));
                     si32(_loc10_,hashScratchAddr + 4);
                     si32(0,hashScratchAddr + _loc5_);
                     _loc10_ = 775236557;
                     _loc11_ = -862048943;
                     _loc12_ = 461845907;
                     _loc13_ = li32(hashScratchAddr) * _loc11_;
                     _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
                     _loc10_ ^= _loc13_ * _loc12_;
                     _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
                     _loc10_ = _loc10_ * 5 + -430675100;
                     _loc13_ = li32(hashScratchAddr + 4) * _loc11_;
                     _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
                     _loc10_ ^= _loc13_ * _loc12_;
                     _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
                     _loc10_ = _loc10_ * 5 + -430675100;
                     _loc14_ = _loc10_ ^ _loc5_;
                     _loc14_ ^= _loc14_ >>> 16;
                     _loc14_ *= -2048144789;
                     _loc14_ ^= _loc14_ >>> 13;
                     _loc14_ *= -1028477387;
                     _loc9_ = (_loc14_ ^ _loc14_ >>> 16) & 65535;
                     _loc4_ = addr + _loc9_ * 5;
                  }
               }
            }
         }
         si8(_loc5_,_loc4_);
         si32(_loc6_,_loc4_ + 1);
         resultAddr = baseResultAddr + (resultAddr - baseResultAddr + 4 & 7);
         if(li16(resultAddr) >= 4)
         {
            _loc2_ = li16(resultAddr);
            if(li16(baseResultAddr + (resultAddr - baseResultAddr + 4 & 7)) > _loc2_)
            {
               si32(0,resultAddr);
            }
            else
            {
               avgMatchLength = (avgMatchLength << 1) + (avgMatchLength << 2) + (_loc2_ << 1) >>> 3;
               if(_loc2_ < avgMatchLength + 4)
               {
                  _loc4_ = param1 + 1 + 1;
                  _loc5_ = param1 + _loc2_;
                  while(_loc4_ < _loc5_)
                  {
                     _loc6_ = int(_loc4_++);
                     _loc7_ = 4;
                     _loc8_ = int(_loc6_);
                     _loc13_ = 775236557;
                     _loc14_ = -862048943;
                     _loc15_ = 461845907;
                     _loc16_ = li32(_loc6_) * _loc14_;
                     _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                     _loc13_ ^= _loc16_ * _loc15_;
                     _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                     _loc13_ = _loc13_ * 5 + -430675100;
                     _loc17_ = _loc13_ ^ 4;
                     _loc17_ ^= _loc17_ >>> 16;
                     _loc17_ *= -2048144789;
                     _loc17_ ^= _loc17_ >>> 13;
                     _loc17_ *= -1028477387;
                     _loc12_ = (_loc17_ ^ _loc17_ >>> 16) & 65535;
                     _loc11_ = addr + _loc12_ * 5;
                     if((_loc9_ = int(li8(_loc11_))) < 8 && _loc9_ >= 0)
                     {
                        _loc10_ = int(li32(_loc11_ + 1));
                        si8(_loc7_,_loc11_);
                        si32(_loc8_,_loc11_ + 1);
                        _loc7_ = _loc9_ + 1;
                        _loc8_ = int(_loc10_);
                        _loc13_ = int(li32(_loc8_));
                        si32(_loc13_,hashScratchAddr);
                        _loc13_ = int(li32(_loc8_ + 4));
                        si32(_loc13_,hashScratchAddr + 4);
                        si32(0,hashScratchAddr + _loc7_);
                        _loc13_ = 775236557;
                        _loc14_ = -862048943;
                        _loc15_ = 461845907;
                        _loc16_ = li32(hashScratchAddr) * _loc14_;
                        _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                        _loc13_ ^= _loc16_ * _loc15_;
                        _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                        _loc13_ = _loc13_ * 5 + -430675100;
                        _loc16_ = li32(hashScratchAddr + 4) * _loc14_;
                        _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                        _loc13_ ^= _loc16_ * _loc15_;
                        _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                        _loc13_ = _loc13_ * 5 + -430675100;
                        _loc17_ = _loc13_ ^ _loc7_;
                        _loc17_ ^= _loc17_ >>> 16;
                        _loc17_ *= -2048144789;
                        _loc17_ ^= _loc17_ >>> 13;
                        _loc17_ *= -1028477387;
                        _loc12_ = (_loc17_ ^ _loc17_ >>> 16) & 65535;
                        _loc11_ = addr + _loc12_ * 5;
                        if((_loc9_ = int(li8(_loc11_))) < 8 && _loc9_ >= 0)
                        {
                           _loc10_ = int(li32(_loc11_ + 1));
                           si8(_loc7_,_loc11_);
                           si32(_loc8_,_loc11_ + 1);
                           _loc7_ = _loc9_ + 1;
                           _loc8_ = int(_loc10_);
                           _loc13_ = int(li32(_loc8_));
                           si32(_loc13_,hashScratchAddr);
                           _loc13_ = int(li32(_loc8_ + 4));
                           si32(_loc13_,hashScratchAddr + 4);
                           si32(0,hashScratchAddr + _loc7_);
                           _loc13_ = 775236557;
                           _loc14_ = -862048943;
                           _loc15_ = 461845907;
                           _loc16_ = li32(hashScratchAddr) * _loc14_;
                           _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                           _loc13_ ^= _loc16_ * _loc15_;
                           _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                           _loc13_ = _loc13_ * 5 + -430675100;
                           _loc16_ = li32(hashScratchAddr + 4) * _loc14_;
                           _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                           _loc13_ ^= _loc16_ * _loc15_;
                           _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                           _loc13_ = _loc13_ * 5 + -430675100;
                           _loc17_ = _loc13_ ^ _loc7_;
                           _loc17_ ^= _loc17_ >>> 16;
                           _loc17_ *= -2048144789;
                           _loc17_ ^= _loc17_ >>> 13;
                           _loc17_ *= -1028477387;
                           _loc12_ = (_loc17_ ^ _loc17_ >>> 16) & 65535;
                           _loc11_ = addr + _loc12_ * 5;
                        }
                     }
                     si8(_loc7_,_loc11_);
                     si32(_loc8_,_loc11_ + 1);
                  }
               }
               resultAddr = baseResultAddr + (resultAddr - baseResultAddr + 4 & 7);
               _loc4_ = param1 + _loc2_;
               _loc7_ = 775236557;
               _loc8_ = -862048943;
               _loc9_ = 461845907;
               _loc10_ = li32(_loc4_) * _loc8_;
               _loc10_ = _loc10_ << 15 | _loc10_ >>> 17;
               _loc7_ ^= _loc10_ * _loc9_;
               _loc7_ = _loc7_ << 13 | _loc7_ >>> 19;
               _loc7_ = _loc7_ * 5 + -430675100;
               _loc11_ = _loc7_ ^ 4;
               _loc11_ ^= _loc11_ >>> 16;
               _loc11_ *= -2048144789;
               _loc11_ ^= _loc11_ >>> 13;
               _loc11_ *= -1028477387;
               _loc6_ = (_loc11_ ^ _loc11_ >>> 16) & 65535;
               _loc5_ = addr + _loc6_ * 5;
               _loc6_ = 3;
               _loc7_ = -1;
               _loc9_ = int(li32(_loc5_ + 1));
               if(_loc9_ >= 0 && li32(_loc4_) == li32(_loc9_) && _loc4_ - _loc9_ <= windowSize)
               {
                  _loc10_ = _loc4_ + 4;
                  _loc8_ = 4;
                  _loc9_ += 4;
                  while(li32(_loc9_) == li32(_loc10_) && _loc8_ + 4 <= maxMatchLength)
                  {
                     _loc8_ += 4;
                     _loc9_ += 4;
                     _loc10_ += 4;
                  }
                  while(li8(_loc9_) == li8(_loc10_) && _loc8_ < maxMatchLength)
                  {
                     _loc8_++;
                     _loc9_++;
                     _loc10_++;
                  }
                  _loc6_ = int(_loc8_);
                  _loc7_ = int(_loc9_);
               }
               _loc11_ = 5;
               _loc12_ = 9;
               while(_loc11_ < _loc12_)
               {
                  _loc13_ = int(_loc11_++);
                  _loc16_ = int(li32(_loc4_));
                  si32(_loc16_,hashScratchAddr);
                  _loc16_ = int(li32(_loc4_ + 4));
                  si32(_loc16_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc13_);
                  _loc16_ = 775236557;
                  _loc17_ = -862048943;
                  _loc18_ = 461845907;
                  _loc19_ = li32(hashScratchAddr) * _loc17_;
                  _loc19_ = _loc19_ << 15 | _loc19_ >>> 17;
                  _loc16_ ^= _loc19_ * _loc18_;
                  _loc16_ = _loc16_ << 13 | _loc16_ >>> 19;
                  _loc16_ = _loc16_ * 5 + -430675100;
                  _loc19_ = li32(hashScratchAddr + 4) * _loc17_;
                  _loc19_ = _loc19_ << 15 | _loc19_ >>> 17;
                  _loc16_ ^= _loc19_ * _loc18_;
                  _loc16_ = _loc16_ << 13 | _loc16_ >>> 19;
                  _loc16_ = _loc16_ * 5 + -430675100;
                  _loc20_ = _loc16_ ^ _loc13_;
                  _loc20_ ^= _loc20_ >>> 16;
                  _loc20_ *= -2048144789;
                  _loc20_ ^= _loc20_ >>> 13;
                  _loc20_ *= -1028477387;
                  _loc15_ = (_loc20_ ^ _loc20_ >>> 16) & 65535;
                  _loc14_ = addr + _loc15_ * 5 + 1;
                  _loc9_ = int(li32(_loc14_));
                  if(_loc9_ >= 0 && li32(_loc9_ + _loc6_ - 3) == li32(_loc4_ + _loc6_ - 3) && li32(_loc4_) == li32(_loc9_) && _loc4_ - _loc9_ <= windowSize)
                  {
                     _loc10_ = _loc4_ + 4;
                     _loc8_ = 4;
                     _loc9_ += 4;
                     while(li32(_loc9_) == li32(_loc10_) && _loc8_ + 4 <= maxMatchLength)
                     {
                        _loc8_ += 4;
                        _loc9_ += 4;
                        _loc10_ += 4;
                     }
                     while(li8(_loc9_) == li8(_loc10_) && _loc8_ < maxMatchLength)
                     {
                        _loc8_++;
                        _loc9_++;
                        _loc10_++;
                     }
                     if(_loc8_ > _loc6_)
                     {
                        _loc6_ = int(_loc8_);
                        _loc7_ = int(_loc9_);
                     }
                  }
               }
               si32(_loc4_ - (_loc7_ - _loc6_) << 16 | _loc6_,resultAddr);
               _loc6_ = int(_loc5_);
               _loc7_ = 4;
               _loc8_ = int(_loc4_);
               if((_loc9_ = int(li8(_loc6_))) < 8 && _loc9_ >= 0)
               {
                  _loc10_ = int(li32(_loc6_ + 1));
                  si8(_loc7_,_loc6_);
                  si32(_loc8_,_loc6_ + 1);
                  _loc7_ = _loc9_ + 1;
                  _loc8_ = int(_loc10_);
                  _loc12_ = int(li32(_loc8_));
                  si32(_loc12_,hashScratchAddr);
                  _loc12_ = int(li32(_loc8_ + 4));
                  si32(_loc12_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc7_);
                  _loc12_ = 775236557;
                  _loc13_ = -862048943;
                  _loc14_ = 461845907;
                  _loc15_ = li32(hashScratchAddr) * _loc13_;
                  _loc15_ = _loc15_ << 15 | _loc15_ >>> 17;
                  _loc12_ ^= _loc15_ * _loc14_;
                  _loc12_ = _loc12_ << 13 | _loc12_ >>> 19;
                  _loc12_ = _loc12_ * 5 + -430675100;
                  _loc15_ = li32(hashScratchAddr + 4) * _loc13_;
                  _loc15_ = _loc15_ << 15 | _loc15_ >>> 17;
                  _loc12_ ^= _loc15_ * _loc14_;
                  _loc12_ = _loc12_ << 13 | _loc12_ >>> 19;
                  _loc12_ = _loc12_ * 5 + -430675100;
                  _loc16_ = _loc12_ ^ _loc7_;
                  _loc16_ ^= _loc16_ >>> 16;
                  _loc16_ *= -2048144789;
                  _loc16_ ^= _loc16_ >>> 13;
                  _loc16_ *= -1028477387;
                  _loc11_ = (_loc16_ ^ _loc16_ >>> 16) & 65535;
                  _loc6_ = addr + _loc11_ * 5;
                  if((_loc9_ = int(li8(_loc6_))) < 8 && _loc9_ >= 0)
                  {
                     _loc10_ = int(li32(_loc6_ + 1));
                     si8(_loc7_,_loc6_);
                     si32(_loc8_,_loc6_ + 1);
                     _loc7_ = _loc9_ + 1;
                     _loc8_ = int(_loc10_);
                     _loc12_ = int(li32(_loc8_));
                     si32(_loc12_,hashScratchAddr);
                     _loc12_ = int(li32(_loc8_ + 4));
                     si32(_loc12_,hashScratchAddr + 4);
                     si32(0,hashScratchAddr + _loc7_);
                     _loc12_ = 775236557;
                     _loc13_ = -862048943;
                     _loc14_ = 461845907;
                     _loc15_ = li32(hashScratchAddr) * _loc13_;
                     _loc15_ = _loc15_ << 15 | _loc15_ >>> 17;
                     _loc12_ ^= _loc15_ * _loc14_;
                     _loc12_ = _loc12_ << 13 | _loc12_ >>> 19;
                     _loc12_ = _loc12_ * 5 + -430675100;
                     _loc15_ = li32(hashScratchAddr + 4) * _loc13_;
                     _loc15_ = _loc15_ << 15 | _loc15_ >>> 17;
                     _loc12_ ^= _loc15_ * _loc14_;
                     _loc12_ = _loc12_ << 13 | _loc12_ >>> 19;
                     _loc12_ = _loc12_ * 5 + -430675100;
                     _loc16_ = _loc12_ ^ _loc7_;
                     _loc16_ ^= _loc16_ >>> 16;
                     _loc16_ *= -2048144789;
                     _loc16_ ^= _loc16_ >>> 13;
                     _loc16_ *= -1028477387;
                     _loc11_ = (_loc16_ ^ _loc16_ >>> 16) & 65535;
                     _loc6_ = addr + _loc11_ * 5;
                     if((_loc9_ = int(li8(_loc6_))) < 8 && _loc9_ >= 0)
                     {
                        _loc10_ = int(li32(_loc6_ + 1));
                        si8(_loc7_,_loc6_);
                        si32(_loc8_,_loc6_ + 1);
                        _loc7_ = _loc9_ + 1;
                        _loc8_ = int(_loc10_);
                        _loc12_ = int(li32(_loc8_));
                        si32(_loc12_,hashScratchAddr);
                        _loc12_ = int(li32(_loc8_ + 4));
                        si32(_loc12_,hashScratchAddr + 4);
                        si32(0,hashScratchAddr + _loc7_);
                        _loc12_ = 775236557;
                        _loc13_ = -862048943;
                        _loc14_ = 461845907;
                        _loc15_ = li32(hashScratchAddr) * _loc13_;
                        _loc15_ = _loc15_ << 15 | _loc15_ >>> 17;
                        _loc12_ ^= _loc15_ * _loc14_;
                        _loc12_ = _loc12_ << 13 | _loc12_ >>> 19;
                        _loc12_ = _loc12_ * 5 + -430675100;
                        _loc15_ = li32(hashScratchAddr + 4) * _loc13_;
                        _loc15_ = _loc15_ << 15 | _loc15_ >>> 17;
                        _loc12_ ^= _loc15_ * _loc14_;
                        _loc12_ = _loc12_ << 13 | _loc12_ >>> 19;
                        _loc12_ = _loc12_ * 5 + -430675100;
                        _loc16_ = _loc12_ ^ _loc7_;
                        _loc16_ ^= _loc16_ >>> 16;
                        _loc16_ *= -2048144789;
                        _loc16_ ^= _loc16_ >>> 13;
                        _loc16_ *= -1028477387;
                        _loc11_ = (_loc16_ ^ _loc16_ >>> 16) & 65535;
                        _loc6_ = addr + _loc11_ * 5;
                        if((_loc9_ = int(li8(_loc6_))) < 8 && _loc9_ >= 0)
                        {
                           _loc10_ = int(li32(_loc6_ + 1));
                           si8(_loc7_,_loc6_);
                           si32(_loc8_,_loc6_ + 1);
                           _loc7_ = _loc9_ + 1;
                           _loc8_ = int(_loc10_);
                           _loc12_ = int(li32(_loc8_));
                           si32(_loc12_,hashScratchAddr);
                           _loc12_ = int(li32(_loc8_ + 4));
                           si32(_loc12_,hashScratchAddr + 4);
                           si32(0,hashScratchAddr + _loc7_);
                           _loc12_ = 775236557;
                           _loc13_ = -862048943;
                           _loc14_ = 461845907;
                           _loc15_ = li32(hashScratchAddr) * _loc13_;
                           _loc15_ = _loc15_ << 15 | _loc15_ >>> 17;
                           _loc12_ ^= _loc15_ * _loc14_;
                           _loc12_ = _loc12_ << 13 | _loc12_ >>> 19;
                           _loc12_ = _loc12_ * 5 + -430675100;
                           _loc15_ = li32(hashScratchAddr + 4) * _loc13_;
                           _loc15_ = _loc15_ << 15 | _loc15_ >>> 17;
                           _loc12_ ^= _loc15_ * _loc14_;
                           _loc12_ = _loc12_ << 13 | _loc12_ >>> 19;
                           _loc12_ = _loc12_ * 5 + -430675100;
                           _loc16_ = _loc12_ ^ _loc7_;
                           _loc16_ ^= _loc16_ >>> 16;
                           _loc16_ *= -2048144789;
                           _loc16_ ^= _loc16_ >>> 13;
                           _loc16_ *= -1028477387;
                           _loc11_ = (_loc16_ ^ _loc16_ >>> 16) & 65535;
                           _loc6_ = addr + _loc11_ * 5;
                        }
                     }
                  }
               }
               si8(_loc7_,_loc6_);
               si32(_loc8_,_loc6_ + 1);
               resultAddr = baseResultAddr + (resultAddr - baseResultAddr + 4 & 7);
            }
         }
      }
      
      public function unsafeInitLookahead(param1:int) : void
      {
         var _loc5_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc4_:* = 775236557;
         _loc5_ = -862048943;
         var _loc6_:* = 461845907;
         _loc7_ = li32(param1) * _loc5_;
         _loc7_ = _loc7_ << 15 | _loc7_ >>> 17;
         _loc4_ ^= _loc7_ * _loc6_;
         _loc4_ = _loc4_ << 13 | _loc4_ >>> 19;
         _loc4_ = _loc4_ * 5 + -430675100;
         _loc8_ = _loc4_ ^ 4;
         _loc8_ ^= _loc8_ >>> 16;
         _loc8_ *= -2048144789;
         _loc8_ ^= _loc8_ >>> 13;
         _loc8_ *= -1028477387;
         var _loc3_:* = (_loc8_ ^ _loc8_ >>> 16) & 65535;
         var _loc2_:* = addr + _loc3_ * 5;
         _loc3_ = 3;
         _loc4_ = -1;
         _loc6_ = int(li32(_loc2_ + 1));
         if(_loc6_ >= 0 && li32(param1) == li32(_loc6_) && param1 - _loc6_ <= windowSize)
         {
            _loc7_ = param1 + 4;
            _loc5_ = 4;
            _loc6_ += 4;
            while(li32(_loc6_) == li32(_loc7_) && _loc5_ + 4 <= maxMatchLength)
            {
               _loc5_ += 4;
               _loc6_ += 4;
               _loc7_ += 4;
            }
            while(li8(_loc6_) == li8(_loc7_) && _loc5_ < maxMatchLength)
            {
               _loc5_++;
               _loc6_++;
               _loc7_++;
            }
            _loc3_ = int(_loc5_);
            _loc4_ = int(_loc6_);
         }
         _loc8_ = 5;
         _loc9_ = 9;
         while(_loc8_ < _loc9_)
         {
            _loc10_ = _loc8_++;
            _loc13_ = int(li32(param1));
            si32(_loc13_,hashScratchAddr);
            _loc13_ = int(li32(param1 + 4));
            si32(_loc13_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc10_);
            _loc13_ = 775236557;
            _loc14_ = -862048943;
            _loc15_ = 461845907;
            _loc16_ = li32(hashScratchAddr) * _loc14_;
            _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
            _loc13_ ^= _loc16_ * _loc15_;
            _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
            _loc13_ = _loc13_ * 5 + -430675100;
            _loc16_ = li32(hashScratchAddr + 4) * _loc14_;
            _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
            _loc13_ ^= _loc16_ * _loc15_;
            _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
            _loc13_ = _loc13_ * 5 + -430675100;
            _loc17_ = _loc13_ ^ _loc10_;
            _loc17_ ^= _loc17_ >>> 16;
            _loc17_ *= -2048144789;
            _loc17_ ^= _loc17_ >>> 13;
            _loc17_ *= -1028477387;
            _loc12_ = (_loc17_ ^ _loc17_ >>> 16) & 65535;
            _loc11_ = addr + _loc12_ * 5 + 1;
            _loc6_ = int(li32(_loc11_));
            if(_loc6_ >= 0 && li32(_loc6_ + _loc3_ - 3) == li32(param1 + _loc3_ - 3) && li32(param1) == li32(_loc6_) && param1 - _loc6_ <= windowSize)
            {
               _loc7_ = param1 + 4;
               _loc5_ = 4;
               _loc6_ += 4;
               while(li32(_loc6_) == li32(_loc7_) && _loc5_ + 4 <= maxMatchLength)
               {
                  _loc5_ += 4;
                  _loc6_ += 4;
                  _loc7_ += 4;
               }
               while(li8(_loc6_) == li8(_loc7_) && _loc5_ < maxMatchLength)
               {
                  _loc5_++;
                  _loc6_++;
                  _loc7_++;
               }
               if(_loc5_ > _loc3_)
               {
                  _loc3_ = int(_loc5_);
                  _loc4_ = int(_loc6_);
               }
            }
         }
         si32(param1 - (_loc4_ - _loc3_) << 16 | _loc3_,resultAddr);
         _loc3_ = int(_loc2_);
         _loc4_ = 4;
         _loc5_ = int(param1);
         if((_loc6_ = int(li8(_loc3_))) < 8 && _loc6_ >= 0)
         {
            _loc7_ = int(li32(_loc3_ + 1));
            si8(_loc4_,_loc3_);
            si32(_loc5_,_loc3_ + 1);
            _loc4_ = _loc6_ + 1;
            _loc5_ = int(_loc7_);
            _loc9_ = int(li32(_loc5_));
            si32(_loc9_,hashScratchAddr);
            _loc9_ = int(li32(_loc5_ + 4));
            si32(_loc9_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc4_);
            _loc9_ = 775236557;
            _loc10_ = -862048943;
            _loc11_ = 461845907;
            _loc12_ = li32(hashScratchAddr) * _loc10_;
            _loc12_ = _loc12_ << 15 | _loc12_ >>> 17;
            _loc9_ ^= _loc12_ * _loc11_;
            _loc9_ = _loc9_ << 13 | _loc9_ >>> 19;
            _loc9_ = _loc9_ * 5 + -430675100;
            _loc12_ = li32(hashScratchAddr + 4) * _loc10_;
            _loc12_ = _loc12_ << 15 | _loc12_ >>> 17;
            _loc9_ ^= _loc12_ * _loc11_;
            _loc9_ = _loc9_ << 13 | _loc9_ >>> 19;
            _loc9_ = _loc9_ * 5 + -430675100;
            _loc13_ = _loc9_ ^ _loc4_;
            _loc13_ ^= _loc13_ >>> 16;
            _loc13_ *= -2048144789;
            _loc13_ ^= _loc13_ >>> 13;
            _loc13_ *= -1028477387;
            _loc8_ = (_loc13_ ^ _loc13_ >>> 16) & 65535;
            _loc3_ = addr + _loc8_ * 5;
            if((_loc6_ = int(li8(_loc3_))) < 8 && _loc6_ >= 0)
            {
               _loc7_ = int(li32(_loc3_ + 1));
               si8(_loc4_,_loc3_);
               si32(_loc5_,_loc3_ + 1);
               _loc4_ = _loc6_ + 1;
               _loc5_ = int(_loc7_);
               _loc9_ = int(li32(_loc5_));
               si32(_loc9_,hashScratchAddr);
               _loc9_ = int(li32(_loc5_ + 4));
               si32(_loc9_,hashScratchAddr + 4);
               si32(0,hashScratchAddr + _loc4_);
               _loc9_ = 775236557;
               _loc10_ = -862048943;
               _loc11_ = 461845907;
               _loc12_ = li32(hashScratchAddr) * _loc10_;
               _loc12_ = _loc12_ << 15 | _loc12_ >>> 17;
               _loc9_ ^= _loc12_ * _loc11_;
               _loc9_ = _loc9_ << 13 | _loc9_ >>> 19;
               _loc9_ = _loc9_ * 5 + -430675100;
               _loc12_ = li32(hashScratchAddr + 4) * _loc10_;
               _loc12_ = _loc12_ << 15 | _loc12_ >>> 17;
               _loc9_ ^= _loc12_ * _loc11_;
               _loc9_ = _loc9_ << 13 | _loc9_ >>> 19;
               _loc9_ = _loc9_ * 5 + -430675100;
               _loc13_ = _loc9_ ^ _loc4_;
               _loc13_ ^= _loc13_ >>> 16;
               _loc13_ *= -2048144789;
               _loc13_ ^= _loc13_ >>> 13;
               _loc13_ *= -1028477387;
               _loc8_ = (_loc13_ ^ _loc13_ >>> 16) & 65535;
               _loc3_ = addr + _loc8_ * 5;
               if((_loc6_ = int(li8(_loc3_))) < 8 && _loc6_ >= 0)
               {
                  _loc7_ = int(li32(_loc3_ + 1));
                  si8(_loc4_,_loc3_);
                  si32(_loc5_,_loc3_ + 1);
                  _loc4_ = _loc6_ + 1;
                  _loc5_ = int(_loc7_);
                  _loc9_ = int(li32(_loc5_));
                  si32(_loc9_,hashScratchAddr);
                  _loc9_ = int(li32(_loc5_ + 4));
                  si32(_loc9_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc4_);
                  _loc9_ = 775236557;
                  _loc10_ = -862048943;
                  _loc11_ = 461845907;
                  _loc12_ = li32(hashScratchAddr) * _loc10_;
                  _loc12_ = _loc12_ << 15 | _loc12_ >>> 17;
                  _loc9_ ^= _loc12_ * _loc11_;
                  _loc9_ = _loc9_ << 13 | _loc9_ >>> 19;
                  _loc9_ = _loc9_ * 5 + -430675100;
                  _loc12_ = li32(hashScratchAddr + 4) * _loc10_;
                  _loc12_ = _loc12_ << 15 | _loc12_ >>> 17;
                  _loc9_ ^= _loc12_ * _loc11_;
                  _loc9_ = _loc9_ << 13 | _loc9_ >>> 19;
                  _loc9_ = _loc9_ * 5 + -430675100;
                  _loc13_ = _loc9_ ^ _loc4_;
                  _loc13_ ^= _loc13_ >>> 16;
                  _loc13_ *= -2048144789;
                  _loc13_ ^= _loc13_ >>> 13;
                  _loc13_ *= -1028477387;
                  _loc8_ = (_loc13_ ^ _loc13_ >>> 16) & 65535;
                  _loc3_ = addr + _loc8_ * 5;
                  if((_loc6_ = int(li8(_loc3_))) < 8 && _loc6_ >= 0)
                  {
                     _loc7_ = int(li32(_loc3_ + 1));
                     si8(_loc4_,_loc3_);
                     si32(_loc5_,_loc3_ + 1);
                     _loc4_ = _loc6_ + 1;
                     _loc5_ = int(_loc7_);
                     _loc9_ = int(li32(_loc5_));
                     si32(_loc9_,hashScratchAddr);
                     _loc9_ = int(li32(_loc5_ + 4));
                     si32(_loc9_,hashScratchAddr + 4);
                     si32(0,hashScratchAddr + _loc4_);
                     _loc9_ = 775236557;
                     _loc10_ = -862048943;
                     _loc11_ = 461845907;
                     _loc12_ = li32(hashScratchAddr) * _loc10_;
                     _loc12_ = _loc12_ << 15 | _loc12_ >>> 17;
                     _loc9_ ^= _loc12_ * _loc11_;
                     _loc9_ = _loc9_ << 13 | _loc9_ >>> 19;
                     _loc9_ = _loc9_ * 5 + -430675100;
                     _loc12_ = li32(hashScratchAddr + 4) * _loc10_;
                     _loc12_ = _loc12_ << 15 | _loc12_ >>> 17;
                     _loc9_ ^= _loc12_ * _loc11_;
                     _loc9_ = _loc9_ << 13 | _loc9_ >>> 19;
                     _loc9_ = _loc9_ * 5 + -430675100;
                     _loc13_ = _loc9_ ^ _loc4_;
                     _loc13_ ^= _loc13_ >>> 16;
                     _loc13_ *= -2048144789;
                     _loc13_ ^= _loc13_ >>> 13;
                     _loc13_ *= -1028477387;
                     _loc8_ = (_loc13_ ^ _loc13_ >>> 16) & 65535;
                     _loc3_ = addr + _loc8_ * 5;
                  }
               }
            }
         }
         si8(_loc4_,_loc3_);
         si32(_loc5_,_loc3_ + 1);
         resultAddr = baseResultAddr + (resultAddr - baseResultAddr + 4 & 7);
      }
      
      public function setSearchResult(param1:int, param2:int, param3:int) : void
      {
         si32(param1 - (param3 - param2) << 16 | param2,resultAddr);
      }
      
      public function searchAndUpdate(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         _loc6_ = 775236557;
         _loc7_ = -862048943;
         _loc8_ = 461845907;
         _loc9_ = li32(param1 + 1) * _loc7_;
         _loc9_ = _loc9_ << 15 | _loc9_ >>> 17;
         _loc6_ ^= _loc9_ * _loc8_;
         _loc6_ = _loc6_ << 13 | _loc6_ >>> 19;
         _loc6_ = _loc6_ * 5 + -430675100;
         _loc10_ = _loc6_ ^ 4;
         _loc10_ ^= _loc10_ >>> 16;
         _loc10_ *= -2048144789;
         _loc10_ ^= _loc10_ >>> 13;
         _loc10_ *= -1028477387;
         _loc5_ = (_loc10_ ^ _loc10_ >>> 16) & 65535;
         var _loc4_:* = addr + _loc5_ * 5;
         if(li16(baseResultAddr + (resultAddr - baseResultAddr + 4 & 7)) < avgMatchLength + 4)
         {
            _loc5_ = param1 + 1;
            _loc6_ = 3;
            _loc7_ = -1;
            _loc9_ = int(li32(_loc4_ + 1));
            if(_loc9_ >= 0 && li32(_loc5_) == li32(_loc9_) && _loc5_ - _loc9_ <= windowSize)
            {
               _loc10_ = _loc5_ + 4;
               _loc8_ = 4;
               _loc9_ += 4;
               while(_loc10_ + 4 <= param2 && li32(_loc9_) == li32(_loc10_) && _loc8_ + 4 <= maxMatchLength)
               {
                  _loc8_ += 4;
                  _loc9_ += 4;
                  _loc10_ += 4;
               }
               while(_loc10_ < param2 && li8(_loc9_) == li8(_loc10_) && _loc8_ < maxMatchLength)
               {
                  _loc8_++;
                  _loc9_++;
                  _loc10_++;
               }
               _loc6_ = int(_loc8_);
               _loc7_ = int(_loc9_);
            }
            _loc11_ = 5;
            _loc12_ = 9;
            while(_loc11_ < _loc12_)
            {
               _loc13_ = int(_loc11_++);
               _loc16_ = int(li32(_loc5_));
               si32(_loc16_,hashScratchAddr);
               _loc16_ = int(li32(_loc5_ + 4));
               si32(_loc16_,hashScratchAddr + 4);
               si32(0,hashScratchAddr + _loc13_);
               _loc16_ = 775236557;
               _loc17_ = -862048943;
               _loc18_ = 461845907;
               _loc19_ = li32(hashScratchAddr) * _loc17_;
               _loc19_ = _loc19_ << 15 | _loc19_ >>> 17;
               _loc16_ ^= _loc19_ * _loc18_;
               _loc16_ = _loc16_ << 13 | _loc16_ >>> 19;
               _loc16_ = _loc16_ * 5 + -430675100;
               _loc19_ = li32(hashScratchAddr + 4) * _loc17_;
               _loc19_ = _loc19_ << 15 | _loc19_ >>> 17;
               _loc16_ ^= _loc19_ * _loc18_;
               _loc16_ = _loc16_ << 13 | _loc16_ >>> 19;
               _loc16_ = _loc16_ * 5 + -430675100;
               _loc20_ = _loc16_ ^ _loc13_;
               _loc20_ ^= _loc20_ >>> 16;
               _loc20_ *= -2048144789;
               _loc20_ ^= _loc20_ >>> 13;
               _loc20_ *= -1028477387;
               _loc15_ = (_loc20_ ^ _loc20_ >>> 16) & 65535;
               _loc14_ = addr + _loc15_ * 5 + 1;
               _loc9_ = int(li32(_loc14_));
               if(_loc9_ >= 0 && li32(_loc5_) == li32(_loc9_) && _loc5_ - _loc9_ <= windowSize)
               {
                  _loc10_ = _loc5_ + 4;
                  _loc8_ = 4;
                  _loc9_ += 4;
                  while(_loc10_ + 4 <= param2 && li32(_loc9_) == li32(_loc10_) && _loc8_ + 4 <= maxMatchLength)
                  {
                     _loc8_ += 4;
                     _loc9_ += 4;
                     _loc10_ += 4;
                  }
                  while(_loc10_ < param2 && li8(_loc9_) == li8(_loc10_) && _loc8_ < maxMatchLength)
                  {
                     _loc8_++;
                     _loc9_++;
                     _loc10_++;
                  }
                  if(_loc8_ > _loc6_)
                  {
                     _loc6_ = int(_loc8_);
                     _loc7_ = int(_loc9_);
                  }
               }
            }
            si32(_loc5_ - (_loc7_ - _loc6_) << 16 | _loc6_,resultAddr);
         }
         else
         {
            si32(0,resultAddr);
         }
         _loc5_ = int(_loc4_);
         _loc6_ = 4;
         _loc7_ = param1 + 1;
         if((_loc8_ = int(li8(_loc5_))) < 8 && _loc8_ >= 0)
         {
            _loc9_ = int(li32(_loc5_ + 1));
            si8(_loc6_,_loc5_);
            si32(_loc7_,_loc5_ + 1);
            _loc6_ = _loc8_ + 1;
            _loc7_ = int(_loc9_);
            _loc11_ = int(li32(_loc7_));
            si32(_loc11_,hashScratchAddr);
            _loc11_ = int(li32(_loc7_ + 4));
            si32(_loc11_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc6_);
            _loc11_ = 775236557;
            _loc12_ = -862048943;
            _loc13_ = 461845907;
            _loc14_ = li32(hashScratchAddr) * _loc12_;
            _loc14_ = _loc14_ << 15 | _loc14_ >>> 17;
            _loc11_ ^= _loc14_ * _loc13_;
            _loc11_ = _loc11_ << 13 | _loc11_ >>> 19;
            _loc11_ = _loc11_ * 5 + -430675100;
            _loc14_ = li32(hashScratchAddr + 4) * _loc12_;
            _loc14_ = _loc14_ << 15 | _loc14_ >>> 17;
            _loc11_ ^= _loc14_ * _loc13_;
            _loc11_ = _loc11_ << 13 | _loc11_ >>> 19;
            _loc11_ = _loc11_ * 5 + -430675100;
            _loc15_ = _loc11_ ^ _loc6_;
            _loc15_ ^= _loc15_ >>> 16;
            _loc15_ *= -2048144789;
            _loc15_ ^= _loc15_ >>> 13;
            _loc15_ *= -1028477387;
            _loc10_ = (_loc15_ ^ _loc15_ >>> 16) & 65535;
            _loc5_ = addr + _loc10_ * 5;
            if((_loc8_ = int(li8(_loc5_))) < 8 && _loc8_ >= 0)
            {
               _loc9_ = int(li32(_loc5_ + 1));
               si8(_loc6_,_loc5_);
               si32(_loc7_,_loc5_ + 1);
               _loc6_ = _loc8_ + 1;
               _loc7_ = int(_loc9_);
               _loc11_ = int(li32(_loc7_));
               si32(_loc11_,hashScratchAddr);
               _loc11_ = int(li32(_loc7_ + 4));
               si32(_loc11_,hashScratchAddr + 4);
               si32(0,hashScratchAddr + _loc6_);
               _loc11_ = 775236557;
               _loc12_ = -862048943;
               _loc13_ = 461845907;
               _loc14_ = li32(hashScratchAddr) * _loc12_;
               _loc14_ = _loc14_ << 15 | _loc14_ >>> 17;
               _loc11_ ^= _loc14_ * _loc13_;
               _loc11_ = _loc11_ << 13 | _loc11_ >>> 19;
               _loc11_ = _loc11_ * 5 + -430675100;
               _loc14_ = li32(hashScratchAddr + 4) * _loc12_;
               _loc14_ = _loc14_ << 15 | _loc14_ >>> 17;
               _loc11_ ^= _loc14_ * _loc13_;
               _loc11_ = _loc11_ << 13 | _loc11_ >>> 19;
               _loc11_ = _loc11_ * 5 + -430675100;
               _loc15_ = _loc11_ ^ _loc6_;
               _loc15_ ^= _loc15_ >>> 16;
               _loc15_ *= -2048144789;
               _loc15_ ^= _loc15_ >>> 13;
               _loc15_ *= -1028477387;
               _loc10_ = (_loc15_ ^ _loc15_ >>> 16) & 65535;
               _loc5_ = addr + _loc10_ * 5;
               if((_loc8_ = int(li8(_loc5_))) < 8 && _loc8_ >= 0)
               {
                  _loc9_ = int(li32(_loc5_ + 1));
                  si8(_loc6_,_loc5_);
                  si32(_loc7_,_loc5_ + 1);
                  _loc6_ = _loc8_ + 1;
                  _loc7_ = int(_loc9_);
                  _loc11_ = int(li32(_loc7_));
                  si32(_loc11_,hashScratchAddr);
                  _loc11_ = int(li32(_loc7_ + 4));
                  si32(_loc11_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc6_);
                  _loc11_ = 775236557;
                  _loc12_ = -862048943;
                  _loc13_ = 461845907;
                  _loc14_ = li32(hashScratchAddr) * _loc12_;
                  _loc14_ = _loc14_ << 15 | _loc14_ >>> 17;
                  _loc11_ ^= _loc14_ * _loc13_;
                  _loc11_ = _loc11_ << 13 | _loc11_ >>> 19;
                  _loc11_ = _loc11_ * 5 + -430675100;
                  _loc14_ = li32(hashScratchAddr + 4) * _loc12_;
                  _loc14_ = _loc14_ << 15 | _loc14_ >>> 17;
                  _loc11_ ^= _loc14_ * _loc13_;
                  _loc11_ = _loc11_ << 13 | _loc11_ >>> 19;
                  _loc11_ = _loc11_ * 5 + -430675100;
                  _loc15_ = _loc11_ ^ _loc6_;
                  _loc15_ ^= _loc15_ >>> 16;
                  _loc15_ *= -2048144789;
                  _loc15_ ^= _loc15_ >>> 13;
                  _loc15_ *= -1028477387;
                  _loc10_ = (_loc15_ ^ _loc15_ >>> 16) & 65535;
                  _loc5_ = addr + _loc10_ * 5;
                  if((_loc8_ = int(li8(_loc5_))) < 8 && _loc8_ >= 0)
                  {
                     _loc9_ = int(li32(_loc5_ + 1));
                     si8(_loc6_,_loc5_);
                     si32(_loc7_,_loc5_ + 1);
                     _loc6_ = _loc8_ + 1;
                     _loc7_ = int(_loc9_);
                     _loc11_ = int(li32(_loc7_));
                     si32(_loc11_,hashScratchAddr);
                     _loc11_ = int(li32(_loc7_ + 4));
                     si32(_loc11_,hashScratchAddr + 4);
                     si32(0,hashScratchAddr + _loc6_);
                     _loc11_ = 775236557;
                     _loc12_ = -862048943;
                     _loc13_ = 461845907;
                     _loc14_ = li32(hashScratchAddr) * _loc12_;
                     _loc14_ = _loc14_ << 15 | _loc14_ >>> 17;
                     _loc11_ ^= _loc14_ * _loc13_;
                     _loc11_ = _loc11_ << 13 | _loc11_ >>> 19;
                     _loc11_ = _loc11_ * 5 + -430675100;
                     _loc14_ = li32(hashScratchAddr + 4) * _loc12_;
                     _loc14_ = _loc14_ << 15 | _loc14_ >>> 17;
                     _loc11_ ^= _loc14_ * _loc13_;
                     _loc11_ = _loc11_ << 13 | _loc11_ >>> 19;
                     _loc11_ = _loc11_ * 5 + -430675100;
                     _loc15_ = _loc11_ ^ _loc6_;
                     _loc15_ ^= _loc15_ >>> 16;
                     _loc15_ *= -2048144789;
                     _loc15_ ^= _loc15_ >>> 13;
                     _loc15_ *= -1028477387;
                     _loc10_ = (_loc15_ ^ _loc15_ >>> 16) & 65535;
                     _loc5_ = addr + _loc10_ * 5;
                  }
               }
            }
         }
         si8(_loc6_,_loc5_);
         si32(_loc7_,_loc5_ + 1);
         resultAddr = baseResultAddr + (resultAddr - baseResultAddr + 4 & 7);
         if(li16(resultAddr) >= 4)
         {
            _loc3_ = li16(resultAddr);
            if(li16(baseResultAddr + (resultAddr - baseResultAddr + 4 & 7)) > _loc3_)
            {
               si32(0,resultAddr);
            }
            else if(param1 + _loc3_ + 9 < param2)
            {
               if(_loc3_ < avgMatchLength + 4)
               {
                  _loc5_ = param1 + 1 + 1;
                  _loc6_ = param1 + _loc3_;
                  while(_loc5_ < _loc6_)
                  {
                     _loc7_ = int(_loc5_++);
                     _loc8_ = 4;
                     _loc9_ = int(_loc7_);
                     _loc14_ = 775236557;
                     _loc15_ = -862048943;
                     _loc16_ = 461845907;
                     _loc17_ = li32(_loc7_) * _loc15_;
                     _loc17_ = _loc17_ << 15 | _loc17_ >>> 17;
                     _loc14_ ^= _loc17_ * _loc16_;
                     _loc14_ = _loc14_ << 13 | _loc14_ >>> 19;
                     _loc14_ = _loc14_ * 5 + -430675100;
                     _loc18_ = _loc14_ ^ 4;
                     _loc18_ ^= _loc18_ >>> 16;
                     _loc18_ *= -2048144789;
                     _loc18_ ^= _loc18_ >>> 13;
                     _loc18_ *= -1028477387;
                     _loc13_ = (_loc18_ ^ _loc18_ >>> 16) & 65535;
                     _loc12_ = addr + _loc13_ * 5;
                     if((_loc10_ = int(li8(_loc12_))) < 8 && _loc10_ >= 0)
                     {
                        _loc11_ = int(li32(_loc12_ + 1));
                        si8(_loc8_,_loc12_);
                        si32(_loc9_,_loc12_ + 1);
                        _loc8_ = _loc10_ + 1;
                        _loc9_ = int(_loc11_);
                        _loc14_ = int(li32(_loc9_));
                        si32(_loc14_,hashScratchAddr);
                        _loc14_ = int(li32(_loc9_ + 4));
                        si32(_loc14_,hashScratchAddr + 4);
                        si32(0,hashScratchAddr + _loc8_);
                        _loc14_ = 775236557;
                        _loc15_ = -862048943;
                        _loc16_ = 461845907;
                        _loc17_ = li32(hashScratchAddr) * _loc15_;
                        _loc17_ = _loc17_ << 15 | _loc17_ >>> 17;
                        _loc14_ ^= _loc17_ * _loc16_;
                        _loc14_ = _loc14_ << 13 | _loc14_ >>> 19;
                        _loc14_ = _loc14_ * 5 + -430675100;
                        _loc17_ = li32(hashScratchAddr + 4) * _loc15_;
                        _loc17_ = _loc17_ << 15 | _loc17_ >>> 17;
                        _loc14_ ^= _loc17_ * _loc16_;
                        _loc14_ = _loc14_ << 13 | _loc14_ >>> 19;
                        _loc14_ = _loc14_ * 5 + -430675100;
                        _loc18_ = _loc14_ ^ _loc8_;
                        _loc18_ ^= _loc18_ >>> 16;
                        _loc18_ *= -2048144789;
                        _loc18_ ^= _loc18_ >>> 13;
                        _loc18_ *= -1028477387;
                        _loc13_ = (_loc18_ ^ _loc18_ >>> 16) & 65535;
                        _loc12_ = addr + _loc13_ * 5;
                        if((_loc10_ = int(li8(_loc12_))) < 8 && _loc10_ >= 0)
                        {
                           _loc11_ = int(li32(_loc12_ + 1));
                           si8(_loc8_,_loc12_);
                           si32(_loc9_,_loc12_ + 1);
                           _loc8_ = _loc10_ + 1;
                           _loc9_ = int(_loc11_);
                           _loc14_ = int(li32(_loc9_));
                           si32(_loc14_,hashScratchAddr);
                           _loc14_ = int(li32(_loc9_ + 4));
                           si32(_loc14_,hashScratchAddr + 4);
                           si32(0,hashScratchAddr + _loc8_);
                           _loc14_ = 775236557;
                           _loc15_ = -862048943;
                           _loc16_ = 461845907;
                           _loc17_ = li32(hashScratchAddr) * _loc15_;
                           _loc17_ = _loc17_ << 15 | _loc17_ >>> 17;
                           _loc14_ ^= _loc17_ * _loc16_;
                           _loc14_ = _loc14_ << 13 | _loc14_ >>> 19;
                           _loc14_ = _loc14_ * 5 + -430675100;
                           _loc17_ = li32(hashScratchAddr + 4) * _loc15_;
                           _loc17_ = _loc17_ << 15 | _loc17_ >>> 17;
                           _loc14_ ^= _loc17_ * _loc16_;
                           _loc14_ = _loc14_ << 13 | _loc14_ >>> 19;
                           _loc14_ = _loc14_ * 5 + -430675100;
                           _loc18_ = _loc14_ ^ _loc8_;
                           _loc18_ ^= _loc18_ >>> 16;
                           _loc18_ *= -2048144789;
                           _loc18_ ^= _loc18_ >>> 13;
                           _loc18_ *= -1028477387;
                           _loc13_ = (_loc18_ ^ _loc18_ >>> 16) & 65535;
                           _loc12_ = addr + _loc13_ * 5;
                        }
                     }
                     si8(_loc8_,_loc12_);
                     si32(_loc9_,_loc12_ + 1);
                  }
               }
               resultAddr = baseResultAddr + (resultAddr - baseResultAddr + 4 & 7);
               _loc5_ = param1 + _loc3_;
               _loc8_ = 775236557;
               _loc9_ = -862048943;
               _loc10_ = 461845907;
               _loc11_ = li32(_loc5_) * _loc9_;
               _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
               _loc8_ ^= _loc11_ * _loc10_;
               _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
               _loc8_ = _loc8_ * 5 + -430675100;
               _loc12_ = _loc8_ ^ 4;
               _loc12_ ^= _loc12_ >>> 16;
               _loc12_ *= -2048144789;
               _loc12_ ^= _loc12_ >>> 13;
               _loc12_ *= -1028477387;
               _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
               _loc6_ = addr + _loc7_ * 5;
               _loc7_ = 3;
               _loc8_ = -1;
               _loc10_ = int(li32(_loc6_ + 1));
               if(_loc10_ >= 0 && li32(_loc5_) == li32(_loc10_) && _loc5_ - _loc10_ <= windowSize)
               {
                  _loc11_ = _loc5_ + 4;
                  _loc9_ = 4;
                  _loc10_ += 4;
                  while(_loc11_ + 4 <= param2 && li32(_loc10_) == li32(_loc11_) && _loc9_ + 4 <= maxMatchLength)
                  {
                     _loc9_ += 4;
                     _loc10_ += 4;
                     _loc11_ += 4;
                  }
                  while(_loc11_ < param2 && li8(_loc10_) == li8(_loc11_) && _loc9_ < maxMatchLength)
                  {
                     _loc9_++;
                     _loc10_++;
                     _loc11_++;
                  }
                  _loc7_ = int(_loc9_);
                  _loc8_ = int(_loc10_);
               }
               _loc12_ = 5;
               _loc13_ = 9;
               while(_loc12_ < _loc13_)
               {
                  _loc14_ = int(_loc12_++);
                  _loc17_ = int(li32(_loc5_));
                  si32(_loc17_,hashScratchAddr);
                  _loc17_ = int(li32(_loc5_ + 4));
                  si32(_loc17_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc14_);
                  _loc17_ = 775236557;
                  _loc18_ = -862048943;
                  _loc19_ = 461845907;
                  _loc20_ = li32(hashScratchAddr) * _loc18_;
                  _loc20_ = _loc20_ << 15 | _loc20_ >>> 17;
                  _loc17_ ^= _loc20_ * _loc19_;
                  _loc17_ = _loc17_ << 13 | _loc17_ >>> 19;
                  _loc17_ = _loc17_ * 5 + -430675100;
                  _loc20_ = li32(hashScratchAddr + 4) * _loc18_;
                  _loc20_ = _loc20_ << 15 | _loc20_ >>> 17;
                  _loc17_ ^= _loc20_ * _loc19_;
                  _loc17_ = _loc17_ << 13 | _loc17_ >>> 19;
                  _loc17_ = _loc17_ * 5 + -430675100;
                  _loc21_ = _loc17_ ^ _loc14_;
                  _loc21_ ^= _loc21_ >>> 16;
                  _loc21_ *= -2048144789;
                  _loc21_ ^= _loc21_ >>> 13;
                  _loc21_ *= -1028477387;
                  _loc16_ = (_loc21_ ^ _loc21_ >>> 16) & 65535;
                  _loc15_ = addr + _loc16_ * 5 + 1;
                  _loc10_ = int(li32(_loc15_));
                  if(_loc10_ >= 0 && li32(_loc5_) == li32(_loc10_) && _loc5_ - _loc10_ <= windowSize)
                  {
                     _loc11_ = _loc5_ + 4;
                     _loc9_ = 4;
                     _loc10_ += 4;
                     while(_loc11_ + 4 <= param2 && li32(_loc10_) == li32(_loc11_) && _loc9_ + 4 <= maxMatchLength)
                     {
                        _loc9_ += 4;
                        _loc10_ += 4;
                        _loc11_ += 4;
                     }
                     while(_loc11_ < param2 && li8(_loc10_) == li8(_loc11_) && _loc9_ < maxMatchLength)
                     {
                        _loc9_++;
                        _loc10_++;
                        _loc11_++;
                     }
                     if(_loc9_ > _loc7_)
                     {
                        _loc7_ = int(_loc9_);
                        _loc8_ = int(_loc10_);
                     }
                  }
               }
               si32(_loc5_ - (_loc8_ - _loc7_) << 16 | _loc7_,resultAddr);
               _loc7_ = int(_loc6_);
               _loc8_ = 4;
               _loc9_ = int(_loc5_);
               if((_loc10_ = int(li8(_loc7_))) < 8 && _loc10_ >= 0)
               {
                  _loc11_ = int(li32(_loc7_ + 1));
                  si8(_loc8_,_loc7_);
                  si32(_loc9_,_loc7_ + 1);
                  _loc8_ = _loc10_ + 1;
                  _loc9_ = int(_loc11_);
                  _loc13_ = int(li32(_loc9_));
                  si32(_loc13_,hashScratchAddr);
                  _loc13_ = int(li32(_loc9_ + 4));
                  si32(_loc13_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc8_);
                  _loc13_ = 775236557;
                  _loc14_ = -862048943;
                  _loc15_ = 461845907;
                  _loc16_ = li32(hashScratchAddr) * _loc14_;
                  _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                  _loc13_ ^= _loc16_ * _loc15_;
                  _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                  _loc13_ = _loc13_ * 5 + -430675100;
                  _loc16_ = li32(hashScratchAddr + 4) * _loc14_;
                  _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                  _loc13_ ^= _loc16_ * _loc15_;
                  _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                  _loc13_ = _loc13_ * 5 + -430675100;
                  _loc17_ = _loc13_ ^ _loc8_;
                  _loc17_ ^= _loc17_ >>> 16;
                  _loc17_ *= -2048144789;
                  _loc17_ ^= _loc17_ >>> 13;
                  _loc17_ *= -1028477387;
                  _loc12_ = (_loc17_ ^ _loc17_ >>> 16) & 65535;
                  _loc7_ = addr + _loc12_ * 5;
                  if((_loc10_ = int(li8(_loc7_))) < 8 && _loc10_ >= 0)
                  {
                     _loc11_ = int(li32(_loc7_ + 1));
                     si8(_loc8_,_loc7_);
                     si32(_loc9_,_loc7_ + 1);
                     _loc8_ = _loc10_ + 1;
                     _loc9_ = int(_loc11_);
                     _loc13_ = int(li32(_loc9_));
                     si32(_loc13_,hashScratchAddr);
                     _loc13_ = int(li32(_loc9_ + 4));
                     si32(_loc13_,hashScratchAddr + 4);
                     si32(0,hashScratchAddr + _loc8_);
                     _loc13_ = 775236557;
                     _loc14_ = -862048943;
                     _loc15_ = 461845907;
                     _loc16_ = li32(hashScratchAddr) * _loc14_;
                     _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                     _loc13_ ^= _loc16_ * _loc15_;
                     _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                     _loc13_ = _loc13_ * 5 + -430675100;
                     _loc16_ = li32(hashScratchAddr + 4) * _loc14_;
                     _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                     _loc13_ ^= _loc16_ * _loc15_;
                     _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                     _loc13_ = _loc13_ * 5 + -430675100;
                     _loc17_ = _loc13_ ^ _loc8_;
                     _loc17_ ^= _loc17_ >>> 16;
                     _loc17_ *= -2048144789;
                     _loc17_ ^= _loc17_ >>> 13;
                     _loc17_ *= -1028477387;
                     _loc12_ = (_loc17_ ^ _loc17_ >>> 16) & 65535;
                     _loc7_ = addr + _loc12_ * 5;
                     if((_loc10_ = int(li8(_loc7_))) < 8 && _loc10_ >= 0)
                     {
                        _loc11_ = int(li32(_loc7_ + 1));
                        si8(_loc8_,_loc7_);
                        si32(_loc9_,_loc7_ + 1);
                        _loc8_ = _loc10_ + 1;
                        _loc9_ = int(_loc11_);
                        _loc13_ = int(li32(_loc9_));
                        si32(_loc13_,hashScratchAddr);
                        _loc13_ = int(li32(_loc9_ + 4));
                        si32(_loc13_,hashScratchAddr + 4);
                        si32(0,hashScratchAddr + _loc8_);
                        _loc13_ = 775236557;
                        _loc14_ = -862048943;
                        _loc15_ = 461845907;
                        _loc16_ = li32(hashScratchAddr) * _loc14_;
                        _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                        _loc13_ ^= _loc16_ * _loc15_;
                        _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                        _loc13_ = _loc13_ * 5 + -430675100;
                        _loc16_ = li32(hashScratchAddr + 4) * _loc14_;
                        _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                        _loc13_ ^= _loc16_ * _loc15_;
                        _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                        _loc13_ = _loc13_ * 5 + -430675100;
                        _loc17_ = _loc13_ ^ _loc8_;
                        _loc17_ ^= _loc17_ >>> 16;
                        _loc17_ *= -2048144789;
                        _loc17_ ^= _loc17_ >>> 13;
                        _loc17_ *= -1028477387;
                        _loc12_ = (_loc17_ ^ _loc17_ >>> 16) & 65535;
                        _loc7_ = addr + _loc12_ * 5;
                        if((_loc10_ = int(li8(_loc7_))) < 8 && _loc10_ >= 0)
                        {
                           _loc11_ = int(li32(_loc7_ + 1));
                           si8(_loc8_,_loc7_);
                           si32(_loc9_,_loc7_ + 1);
                           _loc8_ = _loc10_ + 1;
                           _loc9_ = int(_loc11_);
                           _loc13_ = int(li32(_loc9_));
                           si32(_loc13_,hashScratchAddr);
                           _loc13_ = int(li32(_loc9_ + 4));
                           si32(_loc13_,hashScratchAddr + 4);
                           si32(0,hashScratchAddr + _loc8_);
                           _loc13_ = 775236557;
                           _loc14_ = -862048943;
                           _loc15_ = 461845907;
                           _loc16_ = li32(hashScratchAddr) * _loc14_;
                           _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                           _loc13_ ^= _loc16_ * _loc15_;
                           _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                           _loc13_ = _loc13_ * 5 + -430675100;
                           _loc16_ = li32(hashScratchAddr + 4) * _loc14_;
                           _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
                           _loc13_ ^= _loc16_ * _loc15_;
                           _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
                           _loc13_ = _loc13_ * 5 + -430675100;
                           _loc17_ = _loc13_ ^ _loc8_;
                           _loc17_ ^= _loc17_ >>> 16;
                           _loc17_ *= -2048144789;
                           _loc17_ ^= _loc17_ >>> 13;
                           _loc17_ *= -1028477387;
                           _loc12_ = (_loc17_ ^ _loc17_ >>> 16) & 65535;
                           _loc7_ = addr + _loc12_ * 5;
                        }
                     }
                  }
               }
               si8(_loc8_,_loc7_);
               si32(_loc9_,_loc7_ + 1);
               resultAddr = baseResultAddr + (resultAddr - baseResultAddr + 4 & 7);
            }
         }
      }
      
      public function nextResultAddr(param1:int) : int
      {
         return baseResultAddr + (param1 - baseResultAddr + 4 & 7);
      }
      
      public function initLookahead(param1:int, param2:int) : void
      {
         var _loc6_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc5_:* = 775236557;
         _loc6_ = -862048943;
         var _loc7_:* = 461845907;
         _loc8_ = li32(param1) * _loc6_;
         _loc8_ = _loc8_ << 15 | _loc8_ >>> 17;
         _loc5_ ^= _loc8_ * _loc7_;
         _loc5_ = _loc5_ << 13 | _loc5_ >>> 19;
         _loc5_ = _loc5_ * 5 + -430675100;
         _loc9_ = _loc5_ ^ 4;
         _loc9_ ^= _loc9_ >>> 16;
         _loc9_ *= -2048144789;
         _loc9_ ^= _loc9_ >>> 13;
         _loc9_ *= -1028477387;
         var _loc4_:* = (_loc9_ ^ _loc9_ >>> 16) & 65535;
         var _loc3_:* = addr + _loc4_ * 5;
         _loc4_ = 3;
         _loc5_ = -1;
         _loc7_ = int(li32(_loc3_ + 1));
         if(_loc7_ >= 0 && li32(param1) == li32(_loc7_) && param1 - _loc7_ <= windowSize)
         {
            _loc8_ = param1 + 4;
            _loc6_ = 4;
            _loc7_ += 4;
            while(_loc8_ + 4 <= param2 && li32(_loc7_) == li32(_loc8_) && _loc6_ + 4 <= maxMatchLength)
            {
               _loc6_ += 4;
               _loc7_ += 4;
               _loc8_ += 4;
            }
            while(_loc8_ < param2 && li8(_loc7_) == li8(_loc8_) && _loc6_ < maxMatchLength)
            {
               _loc6_++;
               _loc7_++;
               _loc8_++;
            }
            _loc4_ = int(_loc6_);
            _loc5_ = int(_loc7_);
         }
         _loc9_ = 5;
         _loc10_ = 9;
         while(_loc9_ < _loc10_)
         {
            _loc11_ = _loc9_++;
            _loc14_ = int(li32(param1));
            si32(_loc14_,hashScratchAddr);
            _loc14_ = int(li32(param1 + 4));
            si32(_loc14_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc11_);
            _loc14_ = 775236557;
            _loc15_ = -862048943;
            _loc16_ = 461845907;
            _loc17_ = li32(hashScratchAddr) * _loc15_;
            _loc17_ = _loc17_ << 15 | _loc17_ >>> 17;
            _loc14_ ^= _loc17_ * _loc16_;
            _loc14_ = _loc14_ << 13 | _loc14_ >>> 19;
            _loc14_ = _loc14_ * 5 + -430675100;
            _loc17_ = li32(hashScratchAddr + 4) * _loc15_;
            _loc17_ = _loc17_ << 15 | _loc17_ >>> 17;
            _loc14_ ^= _loc17_ * _loc16_;
            _loc14_ = _loc14_ << 13 | _loc14_ >>> 19;
            _loc14_ = _loc14_ * 5 + -430675100;
            _loc18_ = _loc14_ ^ _loc11_;
            _loc18_ ^= _loc18_ >>> 16;
            _loc18_ *= -2048144789;
            _loc18_ ^= _loc18_ >>> 13;
            _loc18_ *= -1028477387;
            _loc13_ = (_loc18_ ^ _loc18_ >>> 16) & 65535;
            _loc12_ = addr + _loc13_ * 5 + 1;
            _loc7_ = int(li32(_loc12_));
            if(_loc7_ >= 0 && li32(param1) == li32(_loc7_) && param1 - _loc7_ <= windowSize)
            {
               _loc8_ = param1 + 4;
               _loc6_ = 4;
               _loc7_ += 4;
               while(_loc8_ + 4 <= param2 && li32(_loc7_) == li32(_loc8_) && _loc6_ + 4 <= maxMatchLength)
               {
                  _loc6_ += 4;
                  _loc7_ += 4;
                  _loc8_ += 4;
               }
               while(_loc8_ < param2 && li8(_loc7_) == li8(_loc8_) && _loc6_ < maxMatchLength)
               {
                  _loc6_++;
                  _loc7_++;
                  _loc8_++;
               }
               if(_loc6_ > _loc4_)
               {
                  _loc4_ = int(_loc6_);
                  _loc5_ = int(_loc7_);
               }
            }
         }
         si32(param1 - (_loc5_ - _loc4_) << 16 | _loc4_,resultAddr);
         _loc4_ = int(_loc3_);
         _loc5_ = 4;
         _loc6_ = int(param1);
         if((_loc7_ = int(li8(_loc4_))) < 8 && _loc7_ >= 0)
         {
            _loc8_ = int(li32(_loc4_ + 1));
            si8(_loc5_,_loc4_);
            si32(_loc6_,_loc4_ + 1);
            _loc5_ = _loc7_ + 1;
            _loc6_ = int(_loc8_);
            _loc10_ = int(li32(_loc6_));
            si32(_loc10_,hashScratchAddr);
            _loc10_ = int(li32(_loc6_ + 4));
            si32(_loc10_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc5_);
            _loc10_ = 775236557;
            _loc11_ = -862048943;
            _loc12_ = 461845907;
            _loc13_ = li32(hashScratchAddr) * _loc11_;
            _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
            _loc10_ ^= _loc13_ * _loc12_;
            _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
            _loc10_ = _loc10_ * 5 + -430675100;
            _loc13_ = li32(hashScratchAddr + 4) * _loc11_;
            _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
            _loc10_ ^= _loc13_ * _loc12_;
            _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
            _loc10_ = _loc10_ * 5 + -430675100;
            _loc14_ = _loc10_ ^ _loc5_;
            _loc14_ ^= _loc14_ >>> 16;
            _loc14_ *= -2048144789;
            _loc14_ ^= _loc14_ >>> 13;
            _loc14_ *= -1028477387;
            _loc9_ = (_loc14_ ^ _loc14_ >>> 16) & 65535;
            _loc4_ = addr + _loc9_ * 5;
            if((_loc7_ = int(li8(_loc4_))) < 8 && _loc7_ >= 0)
            {
               _loc8_ = int(li32(_loc4_ + 1));
               si8(_loc5_,_loc4_);
               si32(_loc6_,_loc4_ + 1);
               _loc5_ = _loc7_ + 1;
               _loc6_ = int(_loc8_);
               _loc10_ = int(li32(_loc6_));
               si32(_loc10_,hashScratchAddr);
               _loc10_ = int(li32(_loc6_ + 4));
               si32(_loc10_,hashScratchAddr + 4);
               si32(0,hashScratchAddr + _loc5_);
               _loc10_ = 775236557;
               _loc11_ = -862048943;
               _loc12_ = 461845907;
               _loc13_ = li32(hashScratchAddr) * _loc11_;
               _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
               _loc10_ ^= _loc13_ * _loc12_;
               _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
               _loc10_ = _loc10_ * 5 + -430675100;
               _loc13_ = li32(hashScratchAddr + 4) * _loc11_;
               _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
               _loc10_ ^= _loc13_ * _loc12_;
               _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
               _loc10_ = _loc10_ * 5 + -430675100;
               _loc14_ = _loc10_ ^ _loc5_;
               _loc14_ ^= _loc14_ >>> 16;
               _loc14_ *= -2048144789;
               _loc14_ ^= _loc14_ >>> 13;
               _loc14_ *= -1028477387;
               _loc9_ = (_loc14_ ^ _loc14_ >>> 16) & 65535;
               _loc4_ = addr + _loc9_ * 5;
               if((_loc7_ = int(li8(_loc4_))) < 8 && _loc7_ >= 0)
               {
                  _loc8_ = int(li32(_loc4_ + 1));
                  si8(_loc5_,_loc4_);
                  si32(_loc6_,_loc4_ + 1);
                  _loc5_ = _loc7_ + 1;
                  _loc6_ = int(_loc8_);
                  _loc10_ = int(li32(_loc6_));
                  si32(_loc10_,hashScratchAddr);
                  _loc10_ = int(li32(_loc6_ + 4));
                  si32(_loc10_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc5_);
                  _loc10_ = 775236557;
                  _loc11_ = -862048943;
                  _loc12_ = 461845907;
                  _loc13_ = li32(hashScratchAddr) * _loc11_;
                  _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
                  _loc10_ ^= _loc13_ * _loc12_;
                  _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
                  _loc10_ = _loc10_ * 5 + -430675100;
                  _loc13_ = li32(hashScratchAddr + 4) * _loc11_;
                  _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
                  _loc10_ ^= _loc13_ * _loc12_;
                  _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
                  _loc10_ = _loc10_ * 5 + -430675100;
                  _loc14_ = _loc10_ ^ _loc5_;
                  _loc14_ ^= _loc14_ >>> 16;
                  _loc14_ *= -2048144789;
                  _loc14_ ^= _loc14_ >>> 13;
                  _loc14_ *= -1028477387;
                  _loc9_ = (_loc14_ ^ _loc14_ >>> 16) & 65535;
                  _loc4_ = addr + _loc9_ * 5;
                  if((_loc7_ = int(li8(_loc4_))) < 8 && _loc7_ >= 0)
                  {
                     _loc8_ = int(li32(_loc4_ + 1));
                     si8(_loc5_,_loc4_);
                     si32(_loc6_,_loc4_ + 1);
                     _loc5_ = _loc7_ + 1;
                     _loc6_ = int(_loc8_);
                     _loc10_ = int(li32(_loc6_));
                     si32(_loc10_,hashScratchAddr);
                     _loc10_ = int(li32(_loc6_ + 4));
                     si32(_loc10_,hashScratchAddr + 4);
                     si32(0,hashScratchAddr + _loc5_);
                     _loc10_ = 775236557;
                     _loc11_ = -862048943;
                     _loc12_ = 461845907;
                     _loc13_ = li32(hashScratchAddr) * _loc11_;
                     _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
                     _loc10_ ^= _loc13_ * _loc12_;
                     _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
                     _loc10_ = _loc10_ * 5 + -430675100;
                     _loc13_ = li32(hashScratchAddr + 4) * _loc11_;
                     _loc13_ = _loc13_ << 15 | _loc13_ >>> 17;
                     _loc10_ ^= _loc13_ * _loc12_;
                     _loc10_ = _loc10_ << 13 | _loc10_ >>> 19;
                     _loc10_ = _loc10_ * 5 + -430675100;
                     _loc14_ = _loc10_ ^ _loc5_;
                     _loc14_ ^= _loc14_ >>> 16;
                     _loc14_ *= -2048144789;
                     _loc14_ ^= _loc14_ >>> 13;
                     _loc14_ *= -1028477387;
                     _loc9_ = (_loc14_ ^ _loc14_ >>> 16) & 65535;
                     _loc4_ = addr + _loc9_ * 5;
                  }
               }
            }
         }
         si8(_loc5_,_loc4_);
         si32(_loc6_,_loc4_ + 1);
         resultAddr = baseResultAddr + (resultAddr - baseResultAddr + 4 & 7);
      }
      
      public function hash(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:* = int(li32(param1));
         si32(_loc4_,hashScratchAddr);
         _loc4_ = int(li32(param1 + 4));
         si32(_loc4_,hashScratchAddr + 4);
         si32(0,hashScratchAddr + param2);
         _loc4_ = 775236557;
         var _loc5_:int = -862048943;
         var _loc6_:int = 461845907;
         var _loc7_:* = li32(hashScratchAddr) * _loc5_;
         _loc7_ = _loc7_ << 15 | _loc7_ >>> 17;
         _loc4_ ^= _loc7_ * _loc6_;
         _loc4_ = _loc4_ << 13 | _loc4_ >>> 19;
         _loc4_ = _loc4_ * 5 + -430675100;
         _loc7_ = li32(hashScratchAddr + 4) * _loc5_;
         _loc7_ = _loc7_ << 15 | _loc7_ >>> 17;
         _loc4_ ^= _loc7_ * _loc6_;
         _loc4_ = _loc4_ << 13 | _loc4_ >>> 19;
         _loc4_ = _loc4_ * 5 + -430675100;
         var _loc8_:* = _loc4_ ^ param2;
         _loc8_ ^= _loc8_ >>> 16;
         _loc8_ *= -2048144789;
         _loc8_ ^= _loc8_ >>> 13;
         _loc8_ *= -1028477387;
         return (_loc8_ ^ _loc8_ >>> 16) & param3;
      }
      
      public function fastUpdate(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc2_:* = 4;
         var _loc3_:int = param1;
         _loc8_ = 775236557;
         _loc9_ = -862048943;
         _loc10_ = 461845907;
         _loc11_ = li32(param1) * _loc9_;
         _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
         _loc8_ ^= _loc11_ * _loc10_;
         _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
         _loc8_ = _loc8_ * 5 + -430675100;
         _loc12_ = _loc8_ ^ 4;
         _loc12_ ^= _loc12_ >>> 16;
         _loc12_ *= -2048144789;
         _loc12_ ^= _loc12_ >>> 13;
         _loc12_ *= -1028477387;
         _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
         var _loc6_:* = addr + _loc7_ * 5;
         var _loc4_:int;
         if((_loc4_ = li8(_loc6_)) < 8 && _loc4_ >= 0)
         {
            _loc5_ = li32(_loc6_ + 1);
            si8(_loc2_,_loc6_);
            si32(_loc3_,_loc6_ + 1);
            _loc2_ = _loc4_ + 1;
            _loc3_ = _loc5_;
            _loc8_ = int(li32(_loc3_));
            si32(_loc8_,hashScratchAddr);
            _loc8_ = int(li32(_loc3_ + 4));
            si32(_loc8_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc2_);
            _loc8_ = 775236557;
            _loc9_ = -862048943;
            _loc10_ = 461845907;
            _loc11_ = li32(hashScratchAddr) * _loc9_;
            _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
            _loc8_ ^= _loc11_ * _loc10_;
            _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
            _loc8_ = _loc8_ * 5 + -430675100;
            _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
            _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
            _loc8_ ^= _loc11_ * _loc10_;
            _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
            _loc8_ = _loc8_ * 5 + -430675100;
            _loc12_ = _loc8_ ^ _loc2_;
            _loc12_ ^= _loc12_ >>> 16;
            _loc12_ *= -2048144789;
            _loc12_ ^= _loc12_ >>> 13;
            _loc12_ *= -1028477387;
            _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
            _loc6_ = addr + _loc7_ * 5;
            if((_loc4_ = li8(_loc6_)) < 8 && _loc4_ >= 0)
            {
               _loc5_ = li32(_loc6_ + 1);
               si8(_loc2_,_loc6_);
               si32(_loc3_,_loc6_ + 1);
               _loc2_ = _loc4_ + 1;
               _loc3_ = _loc5_;
               _loc8_ = int(li32(_loc3_));
               si32(_loc8_,hashScratchAddr);
               _loc8_ = int(li32(_loc3_ + 4));
               si32(_loc8_,hashScratchAddr + 4);
               si32(0,hashScratchAddr + _loc2_);
               _loc8_ = 775236557;
               _loc9_ = -862048943;
               _loc10_ = 461845907;
               _loc11_ = li32(hashScratchAddr) * _loc9_;
               _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
               _loc8_ ^= _loc11_ * _loc10_;
               _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
               _loc8_ = _loc8_ * 5 + -430675100;
               _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
               _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
               _loc8_ ^= _loc11_ * _loc10_;
               _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
               _loc8_ = _loc8_ * 5 + -430675100;
               _loc12_ = _loc8_ ^ _loc2_;
               _loc12_ ^= _loc12_ >>> 16;
               _loc12_ *= -2048144789;
               _loc12_ ^= _loc12_ >>> 13;
               _loc12_ *= -1028477387;
               _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
               _loc6_ = addr + _loc7_ * 5;
            }
         }
         si8(_loc2_,_loc6_);
         si32(_loc3_,_loc6_ + 1);
      }
      
      public function clearTable() : void
      {
         var _loc1_:* = int(addr);
         var _loc2_:* = addr + 327680;
         while(_loc1_ < _loc2_)
         {
            si32(-1,_loc1_);
            si32(-1,_loc1_ + 4);
            si32(-1,_loc1_ + 8);
            si32(-1,_loc1_ + 12);
            si32(-1,_loc1_ + 16);
            si32(-1,_loc1_ + 20);
            si32(-1,_loc1_ + 24);
            si32(-1,_loc1_ + 28);
            _loc1_ += 32;
         }
      }
      
      public function calcHashOffset(param1:int) : int
      {
         return addr + param1 * 5;
      }
      
      public function _update(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc3_:* = 4;
         var _loc4_:int = param1;
         var _loc5_:int;
         if((_loc5_ = li8(param2)) < 8 && _loc5_ >= 0)
         {
            _loc6_ = li32(param2 + 1);
            si8(_loc3_,param2);
            si32(_loc4_,param2 + 1);
            _loc3_ = _loc5_ + 1;
            _loc4_ = _loc6_;
            _loc8_ = int(li32(_loc4_));
            si32(_loc8_,hashScratchAddr);
            _loc8_ = int(li32(_loc4_ + 4));
            si32(_loc8_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc3_);
            _loc8_ = 775236557;
            _loc9_ = -862048943;
            _loc10_ = 461845907;
            _loc11_ = li32(hashScratchAddr) * _loc9_;
            _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
            _loc8_ ^= _loc11_ * _loc10_;
            _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
            _loc8_ = _loc8_ * 5 + -430675100;
            _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
            _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
            _loc8_ ^= _loc11_ * _loc10_;
            _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
            _loc8_ = _loc8_ * 5 + -430675100;
            _loc12_ = _loc8_ ^ _loc3_;
            _loc12_ ^= _loc12_ >>> 16;
            _loc12_ *= -2048144789;
            _loc12_ ^= _loc12_ >>> 13;
            _loc12_ *= -1028477387;
            _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
            param2 = addr + _loc7_ * 5;
            if((_loc5_ = li8(param2)) < 8 && _loc5_ >= 0)
            {
               _loc6_ = li32(param2 + 1);
               si8(_loc3_,param2);
               si32(_loc4_,param2 + 1);
               _loc3_ = _loc5_ + 1;
               _loc4_ = _loc6_;
               _loc8_ = int(li32(_loc4_));
               si32(_loc8_,hashScratchAddr);
               _loc8_ = int(li32(_loc4_ + 4));
               si32(_loc8_,hashScratchAddr + 4);
               si32(0,hashScratchAddr + _loc3_);
               _loc8_ = 775236557;
               _loc9_ = -862048943;
               _loc10_ = 461845907;
               _loc11_ = li32(hashScratchAddr) * _loc9_;
               _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
               _loc8_ ^= _loc11_ * _loc10_;
               _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
               _loc8_ = _loc8_ * 5 + -430675100;
               _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
               _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
               _loc8_ ^= _loc11_ * _loc10_;
               _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
               _loc8_ = _loc8_ * 5 + -430675100;
               _loc12_ = _loc8_ ^ _loc3_;
               _loc12_ ^= _loc12_ >>> 16;
               _loc12_ *= -2048144789;
               _loc12_ ^= _loc12_ >>> 13;
               _loc12_ *= -1028477387;
               _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
               param2 = addr + _loc7_ * 5;
               if((_loc5_ = li8(param2)) < 8 && _loc5_ >= 0)
               {
                  _loc6_ = li32(param2 + 1);
                  si8(_loc3_,param2);
                  si32(_loc4_,param2 + 1);
                  _loc3_ = _loc5_ + 1;
                  _loc4_ = _loc6_;
                  _loc8_ = int(li32(_loc4_));
                  si32(_loc8_,hashScratchAddr);
                  _loc8_ = int(li32(_loc4_ + 4));
                  si32(_loc8_,hashScratchAddr + 4);
                  si32(0,hashScratchAddr + _loc3_);
                  _loc8_ = 775236557;
                  _loc9_ = -862048943;
                  _loc10_ = 461845907;
                  _loc11_ = li32(hashScratchAddr) * _loc9_;
                  _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
                  _loc8_ ^= _loc11_ * _loc10_;
                  _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
                  _loc8_ = _loc8_ * 5 + -430675100;
                  _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
                  _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
                  _loc8_ ^= _loc11_ * _loc10_;
                  _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
                  _loc8_ = _loc8_ * 5 + -430675100;
                  _loc12_ = _loc8_ ^ _loc3_;
                  _loc12_ ^= _loc12_ >>> 16;
                  _loc12_ *= -2048144789;
                  _loc12_ ^= _loc12_ >>> 13;
                  _loc12_ *= -1028477387;
                  _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
                  param2 = addr + _loc7_ * 5;
                  if((_loc5_ = li8(param2)) < 8 && _loc5_ >= 0)
                  {
                     _loc6_ = li32(param2 + 1);
                     si8(_loc3_,param2);
                     si32(_loc4_,param2 + 1);
                     _loc3_ = _loc5_ + 1;
                     _loc4_ = _loc6_;
                     _loc8_ = int(li32(_loc4_));
                     si32(_loc8_,hashScratchAddr);
                     _loc8_ = int(li32(_loc4_ + 4));
                     si32(_loc8_,hashScratchAddr + 4);
                     si32(0,hashScratchAddr + _loc3_);
                     _loc8_ = 775236557;
                     _loc9_ = -862048943;
                     _loc10_ = 461845907;
                     _loc11_ = li32(hashScratchAddr) * _loc9_;
                     _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
                     _loc8_ ^= _loc11_ * _loc10_;
                     _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
                     _loc8_ = _loc8_ * 5 + -430675100;
                     _loc11_ = li32(hashScratchAddr + 4) * _loc9_;
                     _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
                     _loc8_ ^= _loc11_ * _loc10_;
                     _loc8_ = _loc8_ << 13 | _loc8_ >>> 19;
                     _loc8_ = _loc8_ * 5 + -430675100;
                     _loc12_ = _loc8_ ^ _loc3_;
                     _loc12_ ^= _loc12_ >>> 16;
                     _loc12_ *= -2048144789;
                     _loc12_ ^= _loc12_ >>> 13;
                     _loc12_ *= -1028477387;
                     _loc7_ = (_loc12_ ^ _loc12_ >>> 16) & 65535;
                     param2 = addr + _loc7_ * 5;
                  }
               }
            }
         }
         si8(_loc3_,param2);
         si32(_loc4_,param2 + 1);
      }
      
      public function _unsafeSearch(param1:int, param2:int) : void
      {
         var _loc5_:* = 0;
         var _loc7_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc3_:int = 3;
         var _loc4_:int = -1;
         var _loc6_:* = int(li32(param2 + 1));
         if(_loc6_ >= 0 && li32(param1) == li32(_loc6_) && param1 - _loc6_ <= windowSize)
         {
            _loc7_ = param1 + 4;
            _loc5_ = 4;
            _loc6_ += 4;
            while(li32(_loc6_) == li32(_loc7_) && _loc5_ + 4 <= maxMatchLength)
            {
               _loc5_ += 4;
               _loc6_ += 4;
               _loc7_ += 4;
            }
            while(li8(_loc6_) == li8(_loc7_) && _loc5_ < maxMatchLength)
            {
               _loc5_++;
               _loc6_++;
               _loc7_++;
            }
            _loc3_ = _loc5_;
            _loc4_ = _loc6_;
         }
         var _loc8_:int = 5;
         var _loc9_:int = 9;
         while(_loc8_ < _loc9_)
         {
            _loc10_ = _loc8_++;
            _loc13_ = int(li32(param1));
            si32(_loc13_,hashScratchAddr);
            _loc13_ = int(li32(param1 + 4));
            si32(_loc13_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc10_);
            _loc13_ = 775236557;
            _loc14_ = -862048943;
            _loc15_ = 461845907;
            _loc16_ = li32(hashScratchAddr) * _loc14_;
            _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
            _loc13_ ^= _loc16_ * _loc15_;
            _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
            _loc13_ = _loc13_ * 5 + -430675100;
            _loc16_ = li32(hashScratchAddr + 4) * _loc14_;
            _loc16_ = _loc16_ << 15 | _loc16_ >>> 17;
            _loc13_ ^= _loc16_ * _loc15_;
            _loc13_ = _loc13_ << 13 | _loc13_ >>> 19;
            _loc13_ = _loc13_ * 5 + -430675100;
            _loc17_ = _loc13_ ^ _loc10_;
            _loc17_ ^= _loc17_ >>> 16;
            _loc17_ *= -2048144789;
            _loc17_ ^= _loc17_ >>> 13;
            _loc17_ *= -1028477387;
            _loc12_ = (_loc17_ ^ _loc17_ >>> 16) & 65535;
            _loc11_ = addr + _loc12_ * 5 + 1;
            _loc6_ = int(li32(_loc11_));
            if(_loc6_ >= 0 && li32(_loc6_ + _loc3_ - 3) == li32(param1 + _loc3_ - 3) && li32(param1) == li32(_loc6_) && param1 - _loc6_ <= windowSize)
            {
               _loc7_ = param1 + 4;
               _loc5_ = 4;
               _loc6_ += 4;
               while(li32(_loc6_) == li32(_loc7_) && _loc5_ + 4 <= maxMatchLength)
               {
                  _loc5_ += 4;
                  _loc6_ += 4;
                  _loc7_ += 4;
               }
               while(li8(_loc6_) == li8(_loc7_) && _loc5_ < maxMatchLength)
               {
                  _loc5_++;
                  _loc6_++;
                  _loc7_++;
               }
               if(_loc5_ > _loc3_)
               {
                  _loc3_ = _loc5_;
                  _loc4_ = _loc6_;
               }
            }
         }
         si32(param1 - (_loc4_ - _loc3_) << 16 | _loc3_,resultAddr);
      }
      
      public function _search(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:* = 0;
         var _loc8_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc4_:int = 3;
         var _loc5_:int = -1;
         var _loc7_:* = int(li32(param2 + 1));
         if(_loc7_ >= 0 && li32(param1) == li32(_loc7_) && param1 - _loc7_ <= windowSize)
         {
            _loc8_ = param1 + 4;
            _loc6_ = 4;
            _loc7_ += 4;
            while(_loc8_ + 4 <= param3 && li32(_loc7_) == li32(_loc8_) && _loc6_ + 4 <= maxMatchLength)
            {
               _loc6_ += 4;
               _loc7_ += 4;
               _loc8_ += 4;
            }
            while(_loc8_ < param3 && li8(_loc7_) == li8(_loc8_) && _loc6_ < maxMatchLength)
            {
               _loc6_++;
               _loc7_++;
               _loc8_++;
            }
            _loc4_ = _loc6_;
            _loc5_ = _loc7_;
         }
         var _loc9_:int = 5;
         var _loc10_:int = 9;
         while(_loc9_ < _loc10_)
         {
            _loc11_ = _loc9_++;
            _loc14_ = int(li32(param1));
            si32(_loc14_,hashScratchAddr);
            _loc14_ = int(li32(param1 + 4));
            si32(_loc14_,hashScratchAddr + 4);
            si32(0,hashScratchAddr + _loc11_);
            _loc14_ = 775236557;
            _loc15_ = -862048943;
            _loc16_ = 461845907;
            _loc17_ = li32(hashScratchAddr) * _loc15_;
            _loc17_ = _loc17_ << 15 | _loc17_ >>> 17;
            _loc14_ ^= _loc17_ * _loc16_;
            _loc14_ = _loc14_ << 13 | _loc14_ >>> 19;
            _loc14_ = _loc14_ * 5 + -430675100;
            _loc17_ = li32(hashScratchAddr + 4) * _loc15_;
            _loc17_ = _loc17_ << 15 | _loc17_ >>> 17;
            _loc14_ ^= _loc17_ * _loc16_;
            _loc14_ = _loc14_ << 13 | _loc14_ >>> 19;
            _loc14_ = _loc14_ * 5 + -430675100;
            _loc18_ = _loc14_ ^ _loc11_;
            _loc18_ ^= _loc18_ >>> 16;
            _loc18_ *= -2048144789;
            _loc18_ ^= _loc18_ >>> 13;
            _loc18_ *= -1028477387;
            _loc13_ = (_loc18_ ^ _loc18_ >>> 16) & 65535;
            _loc12_ = addr + _loc13_ * 5 + 1;
            _loc7_ = int(li32(_loc12_));
            if(_loc7_ >= 0 && li32(param1) == li32(_loc7_) && param1 - _loc7_ <= windowSize)
            {
               _loc8_ = param1 + 4;
               _loc6_ = 4;
               _loc7_ += 4;
               while(_loc8_ + 4 <= param3 && li32(_loc7_) == li32(_loc8_) && _loc6_ + 4 <= maxMatchLength)
               {
                  _loc6_ += 4;
                  _loc7_ += 4;
                  _loc8_ += 4;
               }
               while(_loc8_ < param3 && li8(_loc7_) == li8(_loc8_) && _loc6_ < maxMatchLength)
               {
                  _loc6_++;
                  _loc7_++;
                  _loc8_++;
               }
               if(_loc6_ > _loc4_)
               {
                  _loc4_ = _loc6_;
                  _loc5_ = _loc7_;
               }
            }
         }
         si32(param1 - (_loc5_ - _loc4_) << 16 | _loc4_,resultAddr);
      }
      
      public function _clearTable() : void
      {
         var _loc1_:* = int(addr);
         var _loc2_:* = addr + 327680;
         while(_loc1_ < _loc2_)
         {
            si32(-1,_loc1_);
            si32(-1,_loc1_ + 4);
            si32(-1,_loc1_ + 8);
            si32(-1,_loc1_ + 12);
            si32(-1,_loc1_ + 16);
            si32(-1,_loc1_ + 20);
            si32(-1,_loc1_ + 24);
            si32(-1,_loc1_ + 28);
            _loc1_ += 32;
         }
      }
   }
}
