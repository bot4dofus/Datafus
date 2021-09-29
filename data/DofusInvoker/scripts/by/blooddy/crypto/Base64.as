package by.blooddy.crypto
{
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class Base64
   {
       
      
      public function Base64()
      {
      }
      
      public static function encode(param1:ByteArray, param2:Boolean = false) : String
      {
         var _loc11_:* = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = param1.length;
         var _loc4_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeUTFBytes("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/");
         _loc5_.writeBytes(param1);
         var _loc6_:uint = _loc3_ % 3;
         var _loc7_:uint = uint(64) + _loc3_ - _loc6_ - 1;
         var _loc8_:uint = (int(_loc3_ / 3) << 2) + (_loc6_ > 0 ? 4 : 0);
         _loc5_.length += _loc8_ + (!!param2 ? int(_loc8_ / 76) : 0);
         if(_loc5_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc5_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc5_;
         var _loc9_:uint = 63;
         var _loc10_:uint = uint(64) + _loc3_;
         while(_loc9_ < _loc7_)
         {
            _loc11_ = li8(++_loc9_) << 16 | li8(++_loc9_) << 8 | li8(++_loc9_);
            si32(li8(_loc11_ >>> 18) | li8(_loc11_ >>> 12 & 63) << 8 | li8(_loc11_ >>> 6 & 63) << 16 | li8(_loc11_ & 63) << 24,_loc10_);
            _loc10_ += 4;
            if(!!param2 && int((_loc9_ - uint(64) + 1) % 57) == 0)
            {
               _loc10_ = (_loc12_ = _loc10_) + 1;
               si8(10,_loc12_);
            }
         }
         switch(int(_loc6_))
         {
            case 1:
               _loc11_ = int(li8(++_loc9_));
               si32(li8(_loc11_ >>> 2) | li8((_loc11_ & 3) << 4) << 8 | 1027407872,_loc10_);
               break;
            case 2:
               _loc11_ = li8(++_loc9_) << 8 | li8(++_loc9_);
               si32(li8(_loc11_ >>> 10) | li8(_loc11_ >>> 4 & 63) << 8 | li8((_loc11_ & 15) << 2) << 16 | 1023410176,_loc10_);
         }
         _loc5_.position = uint(64) + _loc3_;
         var _loc13_:String = _loc5_.readUTFBytes(_loc5_.bytesAvailable);
         ApplicationDomain.currentDomain.domainMemory = _loc4_;
         return _loc13_;
      }
      
      public static function decode(param1:String) : ByteArray
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc2_:uint = int(param1.length * 0.75);
         var _loc3_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUTFBytes("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@>@@@?456789:;<=@@@@@@@\x00\x01\x02\x03\x04\x05\x06\x07\b\t\n\x0b\f\r\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19@@@@@@\x1a\x1b\x1c\x1d\x1e\x1f !\"#$%&\'()*+,-./0123@@@@@");
         _loc4_.writeUTFBytes(param1);
         var _loc5_:uint = _loc4_.length - 4 - 1;
         if(_loc4_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc4_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc4_;
         var _loc6_:* = li8(204) == 10;
         var _loc7_:uint = 127;
         var _loc8_:uint = 127;
         while(_loc7_ < _loc5_)
         {
            _loc13_ = li8(++_loc7_);
            if((_loc13_ & 128) != 0)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            _loc13_ = li8(_loc13_);
            if(_loc13_ == 64)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            _loc9_ = _loc13_;
            _loc13_ = li8(++_loc7_);
            if((_loc13_ & 128) != 0)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            _loc13_ = li8(_loc13_);
            if(_loc13_ == 64)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            _loc10_ = _loc13_;
            _loc13_ = li8(++_loc7_);
            if((_loc13_ & 128) != 0)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            _loc13_ = li8(_loc13_);
            if(_loc13_ == 64)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            _loc11_ = _loc13_;
            _loc13_ = li8(++_loc7_);
            if((_loc13_ & 128) != 0)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            _loc13_ = li8(_loc13_);
            if(_loc13_ == 64)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            _loc12_ = _loc13_;
            si8(_loc9_ << 2 | _loc10_ >> 4,++_loc8_);
            si8(_loc10_ << 4 | _loc11_ >> 2,++_loc8_);
            si8(_loc11_ << 6 | _loc12_,++_loc8_);
            if(!!_loc6_ && (int((_loc8_ - 128 + 1) % 57) == 0 && li8(++_loc7_) != 10))
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
         }
         if(_loc7_ != _loc5_)
         {
            ApplicationDomain.currentDomain.domainMemory = _loc3_;
            Error.throwError(VerifyError,1509);
         }
         _loc13_ = li8(++_loc7_);
         if((_loc13_ & 128) != 0)
         {
            ApplicationDomain.currentDomain.domainMemory = _loc3_;
            Error.throwError(VerifyError,1509);
         }
         _loc13_ = li8(_loc13_);
         if(_loc13_ == 64)
         {
            ApplicationDomain.currentDomain.domainMemory = _loc3_;
            Error.throwError(VerifyError,1509);
         }
         _loc9_ = _loc13_;
         _loc13_ = li8(++_loc7_);
         if((_loc13_ & 128) != 0)
         {
            ApplicationDomain.currentDomain.domainMemory = _loc3_;
            Error.throwError(VerifyError,1509);
         }
         _loc13_ = li8(_loc13_);
         if(_loc13_ == 64)
         {
            ApplicationDomain.currentDomain.domainMemory = _loc3_;
            Error.throwError(VerifyError,1509);
         }
         _loc10_ = _loc13_;
         si8(_loc9_ << 2 | _loc10_ >> 4,++_loc8_);
         _loc13_ = li8(++_loc7_);
         if((_loc13_ & 128) != 0)
         {
            ApplicationDomain.currentDomain.domainMemory = _loc3_;
            Error.throwError(VerifyError,1509);
         }
         if(_loc13_ == 61)
         {
            _loc13_ = -1;
         }
         else
         {
            _loc13_ = li8(_loc13_);
            if(_loc13_ == 64)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
         }
         _loc11_ = _loc13_;
         if(_loc11_ != -1)
         {
            si8(_loc10_ << 4 | _loc11_ >> 2,++_loc8_);
            _loc13_ = li8(++_loc7_);
            if((_loc13_ & 128) != 0)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            if(_loc13_ == 61)
            {
               _loc13_ = -1;
            }
            else
            {
               _loc13_ = li8(_loc13_);
               if(_loc13_ == 64)
               {
                  ApplicationDomain.currentDomain.domainMemory = _loc3_;
                  Error.throwError(VerifyError,1509);
               }
            }
            _loc12_ = _loc13_;
            if(_loc12_ != -1)
            {
               si8(_loc11_ << 6 | _loc12_,++_loc8_);
            }
         }
         else
         {
            _loc13_ = li8(++_loc7_);
            if((_loc13_ & 128) != 0)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
            if(_loc13_ == 61)
            {
               _loc13_ = -1;
            }
            else
            {
               _loc13_ = li8(_loc13_);
               if(_loc13_ == 64)
               {
                  ApplicationDomain.currentDomain.domainMemory = _loc3_;
                  Error.throwError(VerifyError,1509);
               }
            }
            if(_loc13_ != -1)
            {
               ApplicationDomain.currentDomain.domainMemory = _loc3_;
               Error.throwError(VerifyError,1509);
            }
         }
         ApplicationDomain.currentDomain.domainMemory = _loc3_;
         var _loc14_:ByteArray = new ByteArray();
         _loc14_.writeBytes(_loc4_,128,_loc8_ - 128 + 1);
         _loc14_.position = 0;
         return _loc14_;
      }
   }
}
