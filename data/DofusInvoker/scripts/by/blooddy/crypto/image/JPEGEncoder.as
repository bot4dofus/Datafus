package by.blooddy.crypto.image
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import flash.display.BitmapData;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class JPEGEncoder
   {
       
      
      public function JPEGEncoder()
      {
      }
      
      public static function encode(param1:BitmapData, param2:uint = 60) : ByteArray
      {
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:* = 0;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc45_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc47_:Number = NaN;
         var _loc48_:Number = NaN;
         var _loc49_:Number = NaN;
         var _loc50_:Number = NaN;
         var _loc51_:int = 0;
         var _loc52_:* = 0;
         var _loc53_:* = 0;
         var _loc54_:int = 0;
         var _loc55_:* = 0;
         var _loc56_:int = 0;
         var _loc57_:int = 0;
         if(param1 == null)
         {
            Error.throwError(TypeError,2007,"image");
         }
         if(param2 > 100)
         {
            Error.throwError(RangeError,2006,"quality");
         }
         var _loc3_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc4_:uint = param1.width;
         var _loc5_:uint = param1.height;
         var _loc6_:ByteArray = new ByteArray();
         _loc6_.position = 1792;
         _loc6_.writeBytes(JPEGTable.getTable(param2));
         _loc6_.length += 680 + _loc4_ * _loc5_ * 3;
         if(_loc6_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc6_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc6_;
         si16(55551,201609);
         _loc7_ = 201611;
         si16(57599,_loc7_);
         si16(4096,_loc7_ + 2);
         si32(1179207242,_loc7_ + 4);
         si8(0,_loc7_ + 8);
         si16(257,_loc7_ + 9);
         si8(0,_loc7_ + 11);
         si32(16777472,_loc7_ + 12);
         si16(0,_loc7_ + 16);
         _loc7_ = 201629;
         si16(57855,_loc7_);
         si16(17920,_loc7_ + 2);
         si32(1718188101,_loc7_ + 4);
         si16(0,_loc7_ + 8);
         si32(2771273,_loc7_ + 10);
         si32(8,_loc7_ + 14);
         si16(1,_loc7_ + 18);
         si16(305,_loc7_ + 20);
         si16(2,_loc7_ + 22);
         si32(35,_loc7_ + 24);
         si32(26,_loc7_ + 28);
         si32(0,_loc7_ + 32);
         _loc6_.position = _loc7_ + 36;
         _loc6_.writeMultiByte("by.blooddy.crypto.image.JPEGEncoder","x-ascii");
         si8(0,_loc7_ + 71);
         _loc7_ = 201701;
         si16(56319,_loc7_);
         si16(33792,_loc7_ + 2);
         _loc6_.position = _loc7_ + 4;
         _loc6_.writeBytes(_loc6_,1792,130);
         si8(0,_loc7_ + 4);
         si8(1,_loc7_ + 69);
         _loc7_ = 201835;
         var _loc8_:uint = param1.width;
         _loc9_ = param1.height;
         si16(49407,_loc7_);
         si16(4352,_loc7_ + 2);
         si8(8,_loc7_ + 4);
         si16(_loc9_ >> 8 & 255 | (_loc9_ & 255) << 8,_loc7_ + 5);
         si16(_loc8_ >> 8 & 255 | (_loc8_ & 255) << 8,_loc7_ + 7);
         si8(3,_loc7_ + 9);
         si32(4353,_loc7_ + 10);
         si32(69890,_loc7_ + 13);
         si32(69891,_loc7_ + 16);
         _loc7_ = 201854;
         si16(50431,_loc7_);
         si16(41473,_loc7_ + 2);
         _loc6_.position = _loc7_ + 4;
         _loc6_.writeBytes(_loc6_,3010,416);
         si8(0,_loc7_ + 4);
         si8(16,_loc7_ + 33);
         si8(1,_loc7_ + 212);
         si8(17,_loc7_ + 241);
         _loc7_ = 202274;
         si16(56063,_loc7_);
         si16(3072,_loc7_ + 2);
         si8(3,_loc7_ + 4);
         si16(1,_loc7_ + 5);
         si16(4354,_loc7_ + 7);
         si16(4355,_loc7_ + 9);
         si32(16128,_loc7_ + 11);
         var _loc10_:* = 202288;
         var _loc11_:int = 7;
         var _loc12_:* = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         _loc8_ = 0;
         do
         {
            _loc7_ = 0;
            do
            {
               _loc9_ = 0;
               _loc16_ = _loc7_ + 8;
               _loc17_ = _loc8_ + 8;
               do
               {
                  do
                  {
                     _loc18_ = uint(param1.getPixel(_loc7_,_loc8_));
                     _loc19_ = _loc18_ >>> 16;
                     _loc20_ = _loc18_ >> 8 & 255;
                     _loc21_ = _loc18_ & 255;
                     sf64(Number(0.299 * _loc19_ + 0.587 * _loc20_) + 0.114 * _loc21_ - 128,256 + _loc9_);
                     sf64(Number(-0.16874 * _loc19_ - 0.33126 * _loc20_ + 0.5 * _loc21_),768 + _loc9_);
                     sf64(0.5 * _loc19_ - 0.41869 * _loc20_ - 0.08131 * _loc21_,1280 + _loc9_);
                     _loc9_ += 8;
                  }
                  while(++_loc7_ < _loc16_);
                  
                  _loc7_ -= 8;
               }
               while(++_loc8_ < _loc17_);
               
               _loc8_ -= 8;
               _loc9_ = 256;
               _loc22_ = int(_loc13_);
               _loc16_ = 3426;
               _loc17_ = 3462;
               _loc18_ = 0;
               do
               {
                  _loc23_ = lf64(_loc9_ + _loc18_);
                  _loc24_ = lf64(_loc9_ + _loc18_ + 8);
                  _loc25_ = lf64(_loc9_ + _loc18_ + 16);
                  _loc26_ = lf64(_loc9_ + _loc18_ + 24);
                  _loc27_ = lf64(_loc9_ + _loc18_ + 32);
                  _loc28_ = lf64(_loc9_ + _loc18_ + 40);
                  _loc29_ = lf64(_loc9_ + _loc18_ + 48);
                  _loc30_ = lf64(_loc9_ + _loc18_ + 56);
                  _loc31_ = Number(_loc23_ + _loc30_);
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = Number(_loc24_ + _loc29_);
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = Number(_loc25_ + _loc28_);
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = Number(_loc26_ + _loc27_);
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = Number(_loc31_ + _loc34_);
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = Number(_loc32_ + _loc33_);
                  _loc41_ = _loc32_ - _loc33_;
                  sf64(Number(_loc39_ + _loc40_),_loc9_ + _loc18_);
                  sf64(_loc39_ - _loc40_,_loc9_ + _loc18_ + 32);
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  sf64(Number(_loc42_ + _loc43_),_loc9_ + _loc18_ + 16);
                  sf64(_loc42_ - _loc43_,_loc9_ + _loc18_ + 48);
                  _loc39_ = Number(_loc35_ + _loc36_);
                  _loc40_ = Number(_loc36_ + _loc37_);
                  _loc41_ = Number(_loc37_ + _loc38_);
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = Number(0.5411961 * _loc39_ + _loc47_);
                  _loc46_ = Number(1.306562965 * _loc41_ + _loc47_);
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = Number(_loc38_ + _loc45_);
                  _loc49_ = _loc38_ - _loc45_;
                  sf64(Number(_loc49_ + _loc44_),_loc9_ + _loc18_ + 40);
                  sf64(_loc49_ - _loc44_,_loc9_ + _loc18_ + 24);
                  sf64(Number(_loc48_ + _loc46_),_loc9_ + _loc18_ + 8);
                  sf64(_loc48_ - _loc46_,_loc9_ + _loc18_ + 56);
                  _loc18_ += 64;
               }
               while(_loc18_ < 512);
               
               _loc18_ = 0;
               do
               {
                  _loc23_ = lf64(_loc9_ + _loc18_);
                  _loc24_ = lf64(_loc9_ + _loc18_ + 64);
                  _loc25_ = lf64(_loc9_ + _loc18_ + 128);
                  _loc26_ = lf64(_loc9_ + _loc18_ + 192);
                  _loc27_ = lf64(_loc9_ + _loc18_ + 256);
                  _loc28_ = lf64(_loc9_ + _loc18_ + 320);
                  _loc29_ = lf64(_loc9_ + _loc18_ + 384);
                  _loc30_ = lf64(_loc9_ + _loc18_ + 448);
                  _loc31_ = Number(_loc23_ + _loc30_);
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = Number(_loc24_ + _loc29_);
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = Number(_loc25_ + _loc28_);
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = Number(_loc26_ + _loc27_);
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = Number(_loc31_ + _loc34_);
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = Number(_loc32_ + _loc33_);
                  _loc41_ = _loc32_ - _loc33_;
                  sf64(Number(_loc39_ + _loc40_),_loc9_ + _loc18_);
                  sf64(_loc39_ - _loc40_,_loc9_ + _loc18_ + 256);
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  sf64(Number(_loc42_ + _loc43_),_loc9_ + _loc18_ + 128);
                  sf64(_loc42_ - _loc43_,_loc9_ + _loc18_ + 384);
                  _loc39_ = Number(_loc35_ + _loc36_);
                  _loc40_ = Number(_loc36_ + _loc37_);
                  _loc41_ = Number(_loc37_ + _loc38_);
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = Number(0.5411961 * _loc39_ + _loc47_);
                  _loc46_ = Number(1.306562965 * _loc41_ + _loc47_);
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = Number(_loc38_ + _loc45_);
                  _loc49_ = _loc38_ - _loc45_;
                  sf64(Number(_loc49_ + _loc44_),_loc9_ + _loc18_ + 320);
                  sf64(_loc49_ - _loc44_,_loc9_ + _loc18_ + 192);
                  sf64(Number(_loc48_ + _loc46_),_loc9_ + _loc18_ + 64);
                  sf64(_loc48_ - _loc46_,_loc9_ + _loc18_ + 448);
                  _loc18_ += 8;
               }
               while(_loc18_ < 64);
               
               _loc19_ = 0;
               do
               {
                  _loc50_ = lf64(_loc9_ + (_loc19_ << 3)) * lf64(1922 + (_loc19_ << 3));
                  si32(int(Number(_loc50_ + (_loc50_ > 0 ? 0.5 : -0.5))),li8(2946 + _loc19_) << 2);
               }
               while(++_loc19_ < 64);
               
               _loc51_ = li32(0);
               _loc52_ = _loc51_ - _loc22_;
               _loc22_ = int(_loc51_);
               if(_loc52_ == 0)
               {
                  _loc53_ = int(li8(_loc16_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc16_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
               }
               else
               {
                  _loc18_ = (32767 + _loc52_) * 3;
                  _loc19_ = _loc16_ + li8(5004 + _loc18_) * 3;
                  _loc53_ = int(li8(_loc19_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc19_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
                  _loc19_ = 5004 + _loc18_;
                  _loc53_ = int(li8(_loc19_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc19_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
               }
               _loc19_ = 63;
               while(_loc19_ > 0 && li32(_loc19_ << 2) == 0)
               {
                  _loc19_--;
               }
               if(_loc19_ != 0)
               {
                  _loc20_ = 1;
                  while(_loc20_ <= _loc19_)
                  {
                     _loc54_ = _loc20_;
                     while(_loc20_ <= _loc19_ && li32(_loc20_ << 2) == 0)
                     {
                        _loc20_++;
                     }
                     _loc55_ = _loc20_ - _loc54_;
                     if(_loc55_ >= 16)
                     {
                        _loc53_ = _loc55_ >> 4;
                        _loc56_ = 1;
                        while(_loc56_ <= _loc53_)
                        {
                           _loc21_ = _loc17_ + 720;
                           _loc57_ = li8(_loc21_);
                           while(true)
                           {
                              _loc57_--;
                              if(_loc57_ < 0)
                              {
                                 break;
                              }
                              if((li16(_loc21_ + 1) & 1 << _loc57_) != 0)
                              {
                                 _loc12_ |= 1 << _loc11_;
                              }
                              _loc11_--;
                              if(_loc11_ < 0)
                              {
                                 if(_loc12_ == 255)
                                 {
                                    si16(255,_loc10_);
                                    _loc10_ += 2;
                                 }
                                 else
                                 {
                                    si8(_loc12_,_loc10_);
                                    _loc10_++;
                                 }
                                 _loc11_ = 7;
                                 _loc12_ = 0;
                              }
                           }
                           _loc56_++;
                        }
                        _loc55_ &= 15;
                     }
                     _loc18_ = (32767 + li32(_loc20_ << 2)) * 3;
                     _loc21_ = _loc17_ + (_loc55_ << 4) * 3 + li8(5004 + _loc18_) * 3;
                     _loc57_ = li8(_loc21_);
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((li16(_loc21_ + 1) & 1 << _loc57_) != 0)
                        {
                           _loc12_ |= 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              si16(255,_loc10_);
                              _loc10_ += 2;
                           }
                           else
                           {
                              si8(_loc12_,_loc10_);
                              _loc10_++;
                           }
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                     _loc21_ = 5004 + _loc18_;
                     _loc57_ = li8(_loc21_);
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((li16(_loc21_ + 1) & 1 << _loc57_) != 0)
                        {
                           _loc12_ |= 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              si16(255,_loc10_);
                              _loc10_ += 2;
                           }
                           else
                           {
                              si8(_loc12_,_loc10_);
                              _loc10_++;
                           }
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                     _loc20_++;
                  }
               }
               if(_loc19_ != 63)
               {
                  _loc53_ = int(li8(_loc17_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc17_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
               }
               _loc13_ = _loc22_;
               _loc9_ = 768;
               _loc22_ = int(_loc14_);
               _loc16_ = 4215;
               _loc17_ = 4251;
               _loc18_ = 0;
               do
               {
                  _loc23_ = lf64(_loc9_ + _loc18_);
                  _loc24_ = lf64(_loc9_ + _loc18_ + 8);
                  _loc25_ = lf64(_loc9_ + _loc18_ + 16);
                  _loc26_ = lf64(_loc9_ + _loc18_ + 24);
                  _loc27_ = lf64(_loc9_ + _loc18_ + 32);
                  _loc28_ = lf64(_loc9_ + _loc18_ + 40);
                  _loc29_ = lf64(_loc9_ + _loc18_ + 48);
                  _loc30_ = lf64(_loc9_ + _loc18_ + 56);
                  _loc31_ = Number(_loc23_ + _loc30_);
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = Number(_loc24_ + _loc29_);
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = Number(_loc25_ + _loc28_);
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = Number(_loc26_ + _loc27_);
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = Number(_loc31_ + _loc34_);
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = Number(_loc32_ + _loc33_);
                  _loc41_ = _loc32_ - _loc33_;
                  sf64(Number(_loc39_ + _loc40_),_loc9_ + _loc18_);
                  sf64(_loc39_ - _loc40_,_loc9_ + _loc18_ + 32);
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  sf64(Number(_loc42_ + _loc43_),_loc9_ + _loc18_ + 16);
                  sf64(_loc42_ - _loc43_,_loc9_ + _loc18_ + 48);
                  _loc39_ = Number(_loc35_ + _loc36_);
                  _loc40_ = Number(_loc36_ + _loc37_);
                  _loc41_ = Number(_loc37_ + _loc38_);
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = Number(0.5411961 * _loc39_ + _loc47_);
                  _loc46_ = Number(1.306562965 * _loc41_ + _loc47_);
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = Number(_loc38_ + _loc45_);
                  _loc49_ = _loc38_ - _loc45_;
                  sf64(Number(_loc49_ + _loc44_),_loc9_ + _loc18_ + 40);
                  sf64(_loc49_ - _loc44_,_loc9_ + _loc18_ + 24);
                  sf64(Number(_loc48_ + _loc46_),_loc9_ + _loc18_ + 8);
                  sf64(_loc48_ - _loc46_,_loc9_ + _loc18_ + 56);
                  _loc18_ += 64;
               }
               while(_loc18_ < 512);
               
               _loc18_ = 0;
               do
               {
                  _loc23_ = lf64(_loc9_ + _loc18_);
                  _loc24_ = lf64(_loc9_ + _loc18_ + 64);
                  _loc25_ = lf64(_loc9_ + _loc18_ + 128);
                  _loc26_ = lf64(_loc9_ + _loc18_ + 192);
                  _loc27_ = lf64(_loc9_ + _loc18_ + 256);
                  _loc28_ = lf64(_loc9_ + _loc18_ + 320);
                  _loc29_ = lf64(_loc9_ + _loc18_ + 384);
                  _loc30_ = lf64(_loc9_ + _loc18_ + 448);
                  _loc31_ = Number(_loc23_ + _loc30_);
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = Number(_loc24_ + _loc29_);
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = Number(_loc25_ + _loc28_);
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = Number(_loc26_ + _loc27_);
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = Number(_loc31_ + _loc34_);
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = Number(_loc32_ + _loc33_);
                  _loc41_ = _loc32_ - _loc33_;
                  sf64(Number(_loc39_ + _loc40_),_loc9_ + _loc18_);
                  sf64(_loc39_ - _loc40_,_loc9_ + _loc18_ + 256);
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  sf64(Number(_loc42_ + _loc43_),_loc9_ + _loc18_ + 128);
                  sf64(_loc42_ - _loc43_,_loc9_ + _loc18_ + 384);
                  _loc39_ = Number(_loc35_ + _loc36_);
                  _loc40_ = Number(_loc36_ + _loc37_);
                  _loc41_ = Number(_loc37_ + _loc38_);
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = Number(0.5411961 * _loc39_ + _loc47_);
                  _loc46_ = Number(1.306562965 * _loc41_ + _loc47_);
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = Number(_loc38_ + _loc45_);
                  _loc49_ = _loc38_ - _loc45_;
                  sf64(Number(_loc49_ + _loc44_),_loc9_ + _loc18_ + 320);
                  sf64(_loc49_ - _loc44_,_loc9_ + _loc18_ + 192);
                  sf64(Number(_loc48_ + _loc46_),_loc9_ + _loc18_ + 64);
                  sf64(_loc48_ - _loc46_,_loc9_ + _loc18_ + 448);
                  _loc18_ += 8;
               }
               while(_loc18_ < 64);
               
               _loc19_ = 0;
               do
               {
                  _loc50_ = lf64(_loc9_ + (_loc19_ << 3)) * lf64(2434 + (_loc19_ << 3));
                  si32(int(Number(_loc50_ + (_loc50_ > 0 ? 0.5 : -0.5))),li8(2946 + _loc19_) << 2);
               }
               while(++_loc19_ < 64);
               
               _loc51_ = li32(0);
               _loc52_ = _loc51_ - _loc22_;
               _loc22_ = int(_loc51_);
               if(_loc52_ == 0)
               {
                  _loc53_ = int(li8(_loc16_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc16_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
               }
               else
               {
                  _loc18_ = (32767 + _loc52_) * 3;
                  _loc19_ = _loc16_ + li8(5004 + _loc18_) * 3;
                  _loc53_ = int(li8(_loc19_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc19_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
                  _loc19_ = 5004 + _loc18_;
                  _loc53_ = int(li8(_loc19_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc19_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
               }
               _loc19_ = 63;
               while(_loc19_ > 0 && li32(_loc19_ << 2) == 0)
               {
                  _loc19_--;
               }
               if(_loc19_ != 0)
               {
                  _loc20_ = 1;
                  while(_loc20_ <= _loc19_)
                  {
                     _loc54_ = _loc20_;
                     while(_loc20_ <= _loc19_ && li32(_loc20_ << 2) == 0)
                     {
                        _loc20_++;
                     }
                     _loc55_ = _loc20_ - _loc54_;
                     if(_loc55_ >= 16)
                     {
                        _loc53_ = _loc55_ >> 4;
                        _loc56_ = 1;
                        while(_loc56_ <= _loc53_)
                        {
                           _loc21_ = _loc17_ + 720;
                           _loc57_ = li8(_loc21_);
                           while(true)
                           {
                              _loc57_--;
                              if(_loc57_ < 0)
                              {
                                 break;
                              }
                              if((li16(_loc21_ + 1) & 1 << _loc57_) != 0)
                              {
                                 _loc12_ |= 1 << _loc11_;
                              }
                              _loc11_--;
                              if(_loc11_ < 0)
                              {
                                 if(_loc12_ == 255)
                                 {
                                    si16(255,_loc10_);
                                    _loc10_ += 2;
                                 }
                                 else
                                 {
                                    si8(_loc12_,_loc10_);
                                    _loc10_++;
                                 }
                                 _loc11_ = 7;
                                 _loc12_ = 0;
                              }
                           }
                           _loc56_++;
                        }
                        _loc55_ &= 15;
                     }
                     _loc18_ = (32767 + li32(_loc20_ << 2)) * 3;
                     _loc21_ = _loc17_ + (_loc55_ << 4) * 3 + li8(5004 + _loc18_) * 3;
                     _loc57_ = li8(_loc21_);
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((li16(_loc21_ + 1) & 1 << _loc57_) != 0)
                        {
                           _loc12_ |= 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              si16(255,_loc10_);
                              _loc10_ += 2;
                           }
                           else
                           {
                              si8(_loc12_,_loc10_);
                              _loc10_++;
                           }
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                     _loc21_ = 5004 + _loc18_;
                     _loc57_ = li8(_loc21_);
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((li16(_loc21_ + 1) & 1 << _loc57_) != 0)
                        {
                           _loc12_ |= 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              si16(255,_loc10_);
                              _loc10_ += 2;
                           }
                           else
                           {
                              si8(_loc12_,_loc10_);
                              _loc10_++;
                           }
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                     _loc20_++;
                  }
               }
               if(_loc19_ != 63)
               {
                  _loc53_ = int(li8(_loc17_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc17_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
               }
               _loc14_ = _loc22_;
               _loc9_ = 1280;
               _loc22_ = int(_loc15_);
               _loc16_ = 4215;
               _loc17_ = 4251;
               _loc18_ = 0;
               do
               {
                  _loc23_ = lf64(_loc9_ + _loc18_);
                  _loc24_ = lf64(_loc9_ + _loc18_ + 8);
                  _loc25_ = lf64(_loc9_ + _loc18_ + 16);
                  _loc26_ = lf64(_loc9_ + _loc18_ + 24);
                  _loc27_ = lf64(_loc9_ + _loc18_ + 32);
                  _loc28_ = lf64(_loc9_ + _loc18_ + 40);
                  _loc29_ = lf64(_loc9_ + _loc18_ + 48);
                  _loc30_ = lf64(_loc9_ + _loc18_ + 56);
                  _loc31_ = Number(_loc23_ + _loc30_);
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = Number(_loc24_ + _loc29_);
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = Number(_loc25_ + _loc28_);
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = Number(_loc26_ + _loc27_);
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = Number(_loc31_ + _loc34_);
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = Number(_loc32_ + _loc33_);
                  _loc41_ = _loc32_ - _loc33_;
                  sf64(Number(_loc39_ + _loc40_),_loc9_ + _loc18_);
                  sf64(_loc39_ - _loc40_,_loc9_ + _loc18_ + 32);
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  sf64(Number(_loc42_ + _loc43_),_loc9_ + _loc18_ + 16);
                  sf64(_loc42_ - _loc43_,_loc9_ + _loc18_ + 48);
                  _loc39_ = Number(_loc35_ + _loc36_);
                  _loc40_ = Number(_loc36_ + _loc37_);
                  _loc41_ = Number(_loc37_ + _loc38_);
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = Number(0.5411961 * _loc39_ + _loc47_);
                  _loc46_ = Number(1.306562965 * _loc41_ + _loc47_);
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = Number(_loc38_ + _loc45_);
                  _loc49_ = _loc38_ - _loc45_;
                  sf64(Number(_loc49_ + _loc44_),_loc9_ + _loc18_ + 40);
                  sf64(_loc49_ - _loc44_,_loc9_ + _loc18_ + 24);
                  sf64(Number(_loc48_ + _loc46_),_loc9_ + _loc18_ + 8);
                  sf64(_loc48_ - _loc46_,_loc9_ + _loc18_ + 56);
                  _loc18_ += 64;
               }
               while(_loc18_ < 512);
               
               _loc18_ = 0;
               do
               {
                  _loc23_ = lf64(_loc9_ + _loc18_);
                  _loc24_ = lf64(_loc9_ + _loc18_ + 64);
                  _loc25_ = lf64(_loc9_ + _loc18_ + 128);
                  _loc26_ = lf64(_loc9_ + _loc18_ + 192);
                  _loc27_ = lf64(_loc9_ + _loc18_ + 256);
                  _loc28_ = lf64(_loc9_ + _loc18_ + 320);
                  _loc29_ = lf64(_loc9_ + _loc18_ + 384);
                  _loc30_ = lf64(_loc9_ + _loc18_ + 448);
                  _loc31_ = Number(_loc23_ + _loc30_);
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = Number(_loc24_ + _loc29_);
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = Number(_loc25_ + _loc28_);
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = Number(_loc26_ + _loc27_);
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = Number(_loc31_ + _loc34_);
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = Number(_loc32_ + _loc33_);
                  _loc41_ = _loc32_ - _loc33_;
                  sf64(Number(_loc39_ + _loc40_),_loc9_ + _loc18_);
                  sf64(_loc39_ - _loc40_,_loc9_ + _loc18_ + 256);
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  sf64(Number(_loc42_ + _loc43_),_loc9_ + _loc18_ + 128);
                  sf64(_loc42_ - _loc43_,_loc9_ + _loc18_ + 384);
                  _loc39_ = Number(_loc35_ + _loc36_);
                  _loc40_ = Number(_loc36_ + _loc37_);
                  _loc41_ = Number(_loc37_ + _loc38_);
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = Number(0.5411961 * _loc39_ + _loc47_);
                  _loc46_ = Number(1.306562965 * _loc41_ + _loc47_);
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = Number(_loc38_ + _loc45_);
                  _loc49_ = _loc38_ - _loc45_;
                  sf64(Number(_loc49_ + _loc44_),_loc9_ + _loc18_ + 320);
                  sf64(_loc49_ - _loc44_,_loc9_ + _loc18_ + 192);
                  sf64(Number(_loc48_ + _loc46_),_loc9_ + _loc18_ + 64);
                  sf64(_loc48_ - _loc46_,_loc9_ + _loc18_ + 448);
                  _loc18_ += 8;
               }
               while(_loc18_ < 64);
               
               _loc19_ = 0;
               do
               {
                  _loc50_ = lf64(_loc9_ + (_loc19_ << 3)) * lf64(2434 + (_loc19_ << 3));
                  si32(int(Number(_loc50_ + (_loc50_ > 0 ? 0.5 : -0.5))),li8(2946 + _loc19_) << 2);
               }
               while(++_loc19_ < 64);
               
               _loc51_ = li32(0);
               _loc52_ = _loc51_ - _loc22_;
               _loc22_ = int(_loc51_);
               if(_loc52_ == 0)
               {
                  _loc53_ = int(li8(_loc16_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc16_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
               }
               else
               {
                  _loc18_ = (32767 + _loc52_) * 3;
                  _loc19_ = _loc16_ + li8(5004 + _loc18_) * 3;
                  _loc53_ = int(li8(_loc19_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc19_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
                  _loc19_ = 5004 + _loc18_;
                  _loc53_ = int(li8(_loc19_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc19_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
               }
               _loc19_ = 63;
               while(_loc19_ > 0 && li32(_loc19_ << 2) == 0)
               {
                  _loc19_--;
               }
               if(_loc19_ != 0)
               {
                  _loc20_ = 1;
                  while(_loc20_ <= _loc19_)
                  {
                     _loc54_ = _loc20_;
                     while(_loc20_ <= _loc19_ && li32(_loc20_ << 2) == 0)
                     {
                        _loc20_++;
                     }
                     _loc55_ = _loc20_ - _loc54_;
                     if(_loc55_ >= 16)
                     {
                        _loc53_ = _loc55_ >> 4;
                        _loc56_ = 1;
                        while(_loc56_ <= _loc53_)
                        {
                           _loc21_ = _loc17_ + 720;
                           _loc57_ = li8(_loc21_);
                           while(true)
                           {
                              _loc57_--;
                              if(_loc57_ < 0)
                              {
                                 break;
                              }
                              if((li16(_loc21_ + 1) & 1 << _loc57_) != 0)
                              {
                                 _loc12_ |= 1 << _loc11_;
                              }
                              _loc11_--;
                              if(_loc11_ < 0)
                              {
                                 if(_loc12_ == 255)
                                 {
                                    si16(255,_loc10_);
                                    _loc10_ += 2;
                                 }
                                 else
                                 {
                                    si8(_loc12_,_loc10_);
                                    _loc10_++;
                                 }
                                 _loc11_ = 7;
                                 _loc12_ = 0;
                              }
                           }
                           _loc56_++;
                        }
                        _loc55_ &= 15;
                     }
                     _loc18_ = (32767 + li32(_loc20_ << 2)) * 3;
                     _loc21_ = _loc17_ + (_loc55_ << 4) * 3 + li8(5004 + _loc18_) * 3;
                     _loc57_ = li8(_loc21_);
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((li16(_loc21_ + 1) & 1 << _loc57_) != 0)
                        {
                           _loc12_ |= 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              si16(255,_loc10_);
                              _loc10_ += 2;
                           }
                           else
                           {
                              si8(_loc12_,_loc10_);
                              _loc10_++;
                           }
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                     _loc21_ = 5004 + _loc18_;
                     _loc57_ = li8(_loc21_);
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((li16(_loc21_ + 1) & 1 << _loc57_) != 0)
                        {
                           _loc12_ |= 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              si16(255,_loc10_);
                              _loc10_ += 2;
                           }
                           else
                           {
                              si8(_loc12_,_loc10_);
                              _loc10_++;
                           }
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                     _loc20_++;
                  }
               }
               if(_loc19_ != 63)
               {
                  _loc53_ = int(li8(_loc17_));
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((li16(_loc17_ + 1) & 1 << _loc53_) != 0)
                     {
                        _loc12_ |= 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           si16(255,_loc10_);
                           _loc10_ += 2;
                        }
                        else
                        {
                           si8(_loc12_,_loc10_);
                           _loc10_++;
                        }
                        _loc11_ = 7;
                        _loc12_ = 0;
                     }
                  }
               }
               _loc15_ = _loc22_;
               _loc7_ += 8;
            }
            while(_loc7_ < _loc4_);
            
            _loc8_ += 8;
         }
         while(_loc8_ < _loc5_);
         
         if(_loc11_ >= 0)
         {
            _loc22_ = _loc11_ + 1;
            while(true)
            {
               _loc22_--;
               if(_loc22_ < 0)
               {
                  break;
               }
               if(((1 << _loc11_ + 1) - 1 & 1 << _loc22_) != 0)
               {
                  _loc12_ |= 1 << _loc11_;
               }
               _loc11_--;
               if(_loc11_ < 0)
               {
                  if(_loc12_ == 255)
                  {
                     si16(255,_loc10_);
                     _loc10_ += 2;
                  }
                  else
                  {
                     si8(_loc12_,_loc10_);
                     _loc10_++;
                  }
                  _loc11_ = 7;
                  _loc12_ = 0;
               }
            }
         }
         si16(55807,_loc10_);
         ApplicationDomain.currentDomain.domainMemory = _loc3_;
         var _loc58_:ByteArray = new ByteArray();
         _loc58_.writeBytes(_loc6_,201609,_loc10_ - 201609 + 2);
         _loc58_.position = 0;
         return _loc58_;
      }
   }
}
