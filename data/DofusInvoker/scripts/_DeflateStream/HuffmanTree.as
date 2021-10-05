package _DeflateStream
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class HuffmanTree
   {
      
      public static var scratchAddr:int;
       
      
      public function HuffmanTree()
      {
      }
      
      public static function fromWeightedAlphabet(param1:Array, param2:int) : Array
      {
         var _loc11_:int = 0;
         var _loc3_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc4_:int = HuffmanTree.scratchAddr;
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:Number = Number(Math.max(int(param1.length) * 4 * 2,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
         _loc5_.length = int(_loc6_);
         ApplicationDomain.currentDomain.domainMemory = _loc5_;
         var _loc7_:int = 0;
         var _loc8_:* = _loc7_ + int(param1.length) * 4;
         HuffmanTree.scratchAddr = _loc8_;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         while(_loc10_ < int(param1.length))
         {
            _loc11_ = param1[_loc10_];
            _loc10_++;
            si32(_loc11_,_loc7_ + _loc9_);
            _loc9_ += 4;
         }
         HuffmanTree.weightedAlphabetToCodes(_loc7_,_loc8_,param2);
         var _loc12_:Array = [];
         _loc9_ = int(_loc7_);
         while(_loc9_ < _loc8_)
         {
            _loc12_.push(li32(_loc9_));
            _loc9_ += 4;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc3_;
         HuffmanTree.scratchAddr = _loc4_;
         return _loc12_;
      }
      
      public static function weightedAlphabetToCodes(param1:int, param2:int, param3:int) : void
      {
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc16_:Number = NaN;
         var _loc4_:* = int(param2);
         var _loc5_:* = _loc4_ - param1 >> 2;
         var _loc6_:* = int(_loc5_);
         if(_loc6_ > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc8_ = int(_loc7_++);
               si32(_loc8_,HuffmanTree.scratchAddr + (_loc8_ << 2));
            }
            _loc7_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc9_ = int(_loc8_++);
               if(li32(param1 + (_loc9_ << 2)) == 0)
               {
                  _loc7_++;
               }
               else
               {
                  _loc10_ = int(li32(param1 + (_loc9_ << 2)));
                  si32(_loc10_,param1 + (_loc9_ - _loc7_ << 2));
                  _loc10_ = int(li32(HuffmanTree.scratchAddr + (_loc9_ << 2)));
                  si32(_loc10_,HuffmanTree.scratchAddr + (_loc9_ - _loc7_ << 2));
               }
            }
            _loc6_ -= _loc7_;
            _loc4_ = param1 + (_loc6_ << 2);
            _loc12_ = _loc4_ - param1;
            _loc8_ = 4;
            while(_loc8_ < _loc12_)
            {
               _loc10_ = int(li32(param1 + _loc8_));
               _loc11_ = int(li32(HuffmanTree.scratchAddr + _loc8_));
               _loc9_ = _loc8_ - 4;
               while(_loc9_ >= 0 && li32(param1 + _loc9_) > _loc10_)
               {
                  _loc13_ = int(li32(param1 + _loc9_));
                  si32(_loc13_,param1 + _loc9_ + 4);
                  _loc13_ = int(li32(HuffmanTree.scratchAddr + _loc9_));
                  si32(_loc13_,HuffmanTree.scratchAddr + _loc9_ + 4);
                  _loc9_ -= 4;
               }
               si32(_loc10_,param1 + _loc9_ + 4);
               si32(_loc11_,HuffmanTree.scratchAddr + _loc9_ + 4);
               _loc8_ += 4;
            }
         }
         if(_loc6_ != 0)
         {
            if(_loc6_ != 1)
            {
               _loc13_ = li32(param1) + li32(param1 + 4);
               si32(_loc13_,param1);
               _loc7_ = 0;
               _loc8_ = 2;
               _loc9_ = 1;
               while(_loc9_ < _loc6_ - 1)
               {
                  if(_loc8_ >= _loc6_ || li32(param1 + (_loc7_ << 2)) < li32(param1 + (_loc8_ << 2)))
                  {
                     _loc13_ = int(li32(param1 + (_loc7_ << 2)));
                     si32(_loc13_,param1 + (_loc9_ << 2));
                     _loc13_ = int(_loc7_++);
                     si32(_loc9_,param1 + (_loc13_ << 2));
                  }
                  else
                  {
                     _loc14_ = int(_loc8_++);
                     _loc13_ = int(li32(param1 + (_loc14_ << 2)));
                     si32(_loc13_,param1 + (_loc9_ << 2));
                  }
                  if(_loc8_ >= _loc6_ || _loc7_ < _loc9_ && li32(param1 + (_loc7_ << 2)) < li32(param1 + (_loc8_ << 2)))
                  {
                     _loc13_ = li32(param1 + (_loc9_ << 2)) + li32(param1 + (_loc7_ << 2));
                     si32(_loc13_,param1 + (_loc9_ << 2));
                     _loc13_ = int(_loc7_++);
                     si32(_loc9_,param1 + (_loc13_ << 2));
                  }
                  else
                  {
                     _loc14_ = int(_loc8_++);
                     _loc13_ = li32(param1 + (_loc9_ << 2)) + li32(param1 + (_loc14_ << 2));
                     si32(_loc13_,param1 + (_loc9_ << 2));
                  }
                  _loc9_++;
               }
               si32(0,param1 + (_loc6_ - 2 << 2));
               _loc9_ = _loc6_ - 3;
               while(_loc9_ >= 0)
               {
                  _loc14_ = int(li32(param1 + (_loc9_ << 2)));
                  _loc13_ = li32(param1 + (_loc14_ << 2)) + 1;
                  si32(_loc13_,param1 + (_loc9_ << 2));
                  _loc9_--;
               }
               _loc10_ = 1;
               _loc11_ = int(_loc12_ = 0);
               _loc7_ = _loc6_ - 2;
               _loc9_ = _loc6_ - 1;
               while(_loc10_ > 0)
               {
                  while(_loc7_ >= 0 && li32(param1 + (_loc7_ << 2)) == _loc12_)
                  {
                     _loc11_++;
                     _loc7_--;
                  }
                  while(_loc10_ > _loc11_)
                  {
                     _loc13_ = int(_loc9_--);
                     si32(_loc12_,param1 + (_loc13_ << 2));
                     _loc10_--;
                  }
                  _loc10_ = 2 * _loc11_;
                  _loc12_++;
                  _loc11_ = 0;
               }
            }
            else
            {
               si32(1,param1);
            }
         }
         var _loc15_:Boolean = false;
         _loc7_ = int(_loc4_ - param1 >>> 2);
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = int(_loc8_++);
            if(li32(param1 + (_loc9_ << 2)) > param3)
            {
               si32(param3,param1 + (_loc9_ << 2));
               _loc15_ = true;
            }
         }
         if(_loc15_)
         {
            _loc16_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc9_ = int(_loc8_++);
               _loc16_ += Number(Math.pow(2,-li32(param1 + (_loc9_ << 2))));
            }
            _loc8_ = 0;
            while(_loc16_ > 1 && _loc8_ < _loc7_)
            {
               while(li32(param1 + (_loc8_ << 2)) < param3 && _loc16_ > 1)
               {
                  _loc9_ = li32(param1 + (_loc8_ << 2)) + 1;
                  si32(_loc9_,param1 + (_loc8_ << 2));
                  _loc16_ -= Number(Math.pow(2,-li32(param1 + (_loc8_ << 2))));
               }
               _loc8_++;
            }
            _loc8_ = _loc7_ - 1;
            while(_loc8_ >= 0)
            {
               while(Number(_loc16_ + Number(Math.pow(2,-li32(param1 + (_loc8_ << 2))))) <= 1)
               {
                  _loc16_ += Number(Math.pow(2,-li32(param1 + (_loc8_ << 2))));
                  _loc9_ = li32(param1 + (_loc8_ << 2)) - 1;
                  si32(_loc9_,param1 + (_loc8_ << 2));
               }
               _loc8_--;
            }
         }
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = int(_loc7_++);
            _loc9_ = li32(HuffmanTree.scratchAddr + (_loc8_ << 2)) << 16 | li32(param1 + (_loc8_ << 2));
            si32(_loc9_,HuffmanTree.scratchAddr + (_loc8_ << 2));
         }
         _loc7_ = int(HuffmanTree.scratchAddr);
         _loc8_ = 4;
         while(_loc8_ < _loc4_ - param1)
         {
            _loc10_ = int(li32(_loc7_ + _loc8_));
            _loc12_ = int(_loc10_ >>> 16);
            _loc11_ = _loc10_ & 65535;
            _loc9_ = _loc8_ - 4;
            while(_loc9_ >= 0 && (_loc13_ == 0 ? li16(_loc7_ + _loc9_ + 2) < _loc12_ : _loc13_ < 0))
            {
               _loc13_ = int(li32(_loc7_ + _loc9_));
               si32(_loc13_,_loc7_ + _loc9_ + 4);
               _loc9_ -= 4;
            }
            si32(_loc10_,_loc7_ + _loc9_ + 4);
            _loc8_ += 4;
         }
         if(_loc6_ != _loc5_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc8_ = int(_loc7_++);
               si32(0,param1 + (_loc8_ << 2));
            }
         }
         _loc7_ = int(HuffmanTree.scratchAddr);
         if(_loc6_ != 0)
         {
            _loc8_ = _loc6_ - 1;
            _loc9_ = 0;
            _loc10_ = int(li16(_loc7_ + _loc8_ * 4));
            while(_loc8_ >= 0)
            {
               _loc11_ = int(li32(_loc7_ + _loc8_ * 4));
               _loc12_ = _loc11_ & 65535;
               _loc9_ <<= _loc12_ - _loc10_;
               _loc14_ = int(_loc9_);
               _loc14_ = _loc14_ >>> 1 & 1431655765 | (_loc14_ & 1431655765) << 1;
               _loc14_ = _loc14_ >>> 2 & 858993459 | (_loc14_ & 858993459) << 2;
               _loc14_ = _loc14_ >>> 4 & 252645135 | (_loc14_ & 252645135) << 4;
               _loc14_ = _loc14_ >>> 8 & 16711935 | (_loc14_ & 16711935) << 8;
               _loc13_ = (_loc14_ & 65535) >>> 16 - _loc12_ << 16 | _loc12_;
               si32(_loc13_,param1 + (_loc11_ >>> 16) * 4);
               _loc9_++;
               _loc10_ = int(_loc12_);
               if(_loc9_ >= 1 << _loc10_)
               {
                  _loc10_++;
               }
               _loc8_--;
            }
         }
      }
      
      public static function _weightedAlphabetToCodes(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc15_:Number = NaN;
         var _loc4_:* = param2 - param1 >> 2;
         var _loc5_:* = int(_loc4_);
         if(_loc5_ > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = int(_loc6_++);
               si32(_loc7_,HuffmanTree.scratchAddr + (_loc7_ << 2));
            }
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc8_ = int(_loc7_++);
               if(li32(param1 + (_loc8_ << 2)) == 0)
               {
                  _loc6_++;
               }
               else
               {
                  _loc9_ = int(li32(param1 + (_loc8_ << 2)));
                  si32(_loc9_,param1 + (_loc8_ - _loc6_ << 2));
                  _loc9_ = int(li32(HuffmanTree.scratchAddr + (_loc8_ << 2)));
                  si32(_loc9_,HuffmanTree.scratchAddr + (_loc8_ - _loc6_ << 2));
               }
            }
            _loc5_ -= _loc6_;
            param2 = param1 + (_loc5_ << 2);
            _loc11_ = param2 - param1;
            _loc7_ = 4;
            while(_loc7_ < _loc11_)
            {
               _loc9_ = int(li32(param1 + _loc7_));
               _loc10_ = int(li32(HuffmanTree.scratchAddr + _loc7_));
               _loc8_ = _loc7_ - 4;
               while(_loc8_ >= 0 && li32(param1 + _loc8_) > _loc9_)
               {
                  _loc12_ = int(li32(param1 + _loc8_));
                  si32(_loc12_,param1 + _loc8_ + 4);
                  _loc12_ = int(li32(HuffmanTree.scratchAddr + _loc8_));
                  si32(_loc12_,HuffmanTree.scratchAddr + _loc8_ + 4);
                  _loc8_ -= 4;
               }
               si32(_loc9_,param1 + _loc8_ + 4);
               si32(_loc10_,HuffmanTree.scratchAddr + _loc8_ + 4);
               _loc7_ += 4;
            }
         }
         if(_loc5_ != 0)
         {
            if(_loc5_ != 1)
            {
               _loc12_ = li32(param1) + li32(param1 + 4);
               si32(_loc12_,param1);
               _loc6_ = 0;
               _loc7_ = 2;
               _loc8_ = 1;
               while(_loc8_ < _loc5_ - 1)
               {
                  if(_loc7_ >= _loc5_ || li32(param1 + (_loc6_ << 2)) < li32(param1 + (_loc7_ << 2)))
                  {
                     _loc12_ = int(li32(param1 + (_loc6_ << 2)));
                     si32(_loc12_,param1 + (_loc8_ << 2));
                     _loc12_ = int(_loc6_++);
                     si32(_loc8_,param1 + (_loc12_ << 2));
                  }
                  else
                  {
                     _loc13_ = int(_loc7_++);
                     _loc12_ = int(li32(param1 + (_loc13_ << 2)));
                     si32(_loc12_,param1 + (_loc8_ << 2));
                  }
                  if(_loc7_ >= _loc5_ || _loc6_ < _loc8_ && li32(param1 + (_loc6_ << 2)) < li32(param1 + (_loc7_ << 2)))
                  {
                     _loc12_ = li32(param1 + (_loc8_ << 2)) + li32(param1 + (_loc6_ << 2));
                     si32(_loc12_,param1 + (_loc8_ << 2));
                     _loc12_ = int(_loc6_++);
                     si32(_loc8_,param1 + (_loc12_ << 2));
                  }
                  else
                  {
                     _loc13_ = int(_loc7_++);
                     _loc12_ = li32(param1 + (_loc8_ << 2)) + li32(param1 + (_loc13_ << 2));
                     si32(_loc12_,param1 + (_loc8_ << 2));
                  }
                  _loc8_++;
               }
               si32(0,param1 + (_loc5_ - 2 << 2));
               _loc8_ = _loc5_ - 3;
               while(_loc8_ >= 0)
               {
                  _loc13_ = int(li32(param1 + (_loc8_ << 2)));
                  _loc12_ = li32(param1 + (_loc13_ << 2)) + 1;
                  si32(_loc12_,param1 + (_loc8_ << 2));
                  _loc8_--;
               }
               _loc9_ = 1;
               _loc10_ = int(_loc11_ = 0);
               _loc6_ = _loc5_ - 2;
               _loc8_ = _loc5_ - 1;
               while(_loc9_ > 0)
               {
                  while(_loc6_ >= 0 && li32(param1 + (_loc6_ << 2)) == _loc11_)
                  {
                     _loc10_++;
                     _loc6_--;
                  }
                  while(_loc9_ > _loc10_)
                  {
                     _loc12_ = int(_loc8_--);
                     si32(_loc11_,param1 + (_loc12_ << 2));
                     _loc9_--;
                  }
                  _loc9_ = 2 * _loc10_;
                  _loc11_++;
                  _loc10_ = 0;
               }
            }
            else
            {
               si32(1,param1);
            }
         }
         var _loc14_:Boolean = false;
         _loc6_ = int(param2 - param1 >>> 2);
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = int(_loc7_++);
            if(li32(param1 + (_loc8_ << 2)) > param3)
            {
               si32(param3,param1 + (_loc8_ << 2));
               _loc14_ = true;
            }
         }
         if(_loc14_)
         {
            _loc15_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc8_ = int(_loc7_++);
               _loc15_ += Number(Math.pow(2,-li32(param1 + (_loc8_ << 2))));
            }
            _loc7_ = 0;
            while(_loc15_ > 1 && _loc7_ < _loc6_)
            {
               while(li32(param1 + (_loc7_ << 2)) < param3 && _loc15_ > 1)
               {
                  _loc8_ = li32(param1 + (_loc7_ << 2)) + 1;
                  si32(_loc8_,param1 + (_loc7_ << 2));
                  _loc15_ -= Number(Math.pow(2,-li32(param1 + (_loc7_ << 2))));
               }
               _loc7_++;
            }
            _loc7_ = _loc6_ - 1;
            while(_loc7_ >= 0)
            {
               while(Number(_loc15_ + Number(Math.pow(2,-li32(param1 + (_loc7_ << 2))))) <= 1)
               {
                  _loc15_ += Number(Math.pow(2,-li32(param1 + (_loc7_ << 2))));
                  _loc8_ = li32(param1 + (_loc7_ << 2)) - 1;
                  si32(_loc8_,param1 + (_loc7_ << 2));
               }
               _loc7_--;
            }
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = int(_loc6_++);
            _loc8_ = li32(HuffmanTree.scratchAddr + (_loc7_ << 2)) << 16 | li32(param1 + (_loc7_ << 2));
            si32(_loc8_,HuffmanTree.scratchAddr + (_loc7_ << 2));
         }
         _loc6_ = int(HuffmanTree.scratchAddr);
         _loc7_ = 4;
         while(_loc7_ < param2 - param1)
         {
            _loc9_ = int(li32(_loc6_ + _loc7_));
            _loc11_ = int(_loc9_ >>> 16);
            _loc10_ = _loc9_ & 65535;
            _loc8_ = _loc7_ - 4;
            while(_loc8_ >= 0 && (_loc12_ == 0 ? li16(_loc6_ + _loc8_ + 2) < _loc11_ : _loc12_ < 0))
            {
               _loc12_ = int(li32(_loc6_ + _loc8_));
               si32(_loc12_,_loc6_ + _loc8_ + 4);
               _loc8_ -= 4;
            }
            si32(_loc9_,_loc6_ + _loc8_ + 4);
            _loc7_ += 4;
         }
         if(_loc5_ != _loc4_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = int(_loc6_++);
               si32(0,param1 + (_loc7_ << 2));
            }
         }
         _loc6_ = int(HuffmanTree.scratchAddr);
         if(_loc5_ != 0)
         {
            _loc7_ = _loc5_ - 1;
            _loc8_ = 0;
            _loc9_ = int(li16(_loc6_ + _loc7_ * 4));
            while(_loc7_ >= 0)
            {
               _loc10_ = int(li32(_loc6_ + _loc7_ * 4));
               _loc11_ = _loc10_ & 65535;
               _loc8_ <<= _loc11_ - _loc9_;
               _loc13_ = int(_loc8_);
               _loc13_ = _loc13_ >>> 1 & 1431655765 | (_loc13_ & 1431655765) << 1;
               _loc13_ = _loc13_ >>> 2 & 858993459 | (_loc13_ & 858993459) << 2;
               _loc13_ = _loc13_ >>> 4 & 252645135 | (_loc13_ & 252645135) << 4;
               _loc13_ = _loc13_ >>> 8 & 16711935 | (_loc13_ & 16711935) << 8;
               _loc12_ = (_loc13_ & 65535) >>> 16 - _loc11_ << 16 | _loc11_;
               si32(_loc12_,param1 + (_loc10_ >>> 16) * 4);
               _loc8_++;
               _loc9_ = int(_loc11_);
               if(_loc8_ >= 1 << _loc9_)
               {
                  _loc9_++;
               }
               _loc7_--;
            }
         }
      }
      
      public static function sortByWeightNonDecreasing(param1:int, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = param2 - param1;
         var _loc3_:* = 4;
         while(_loc3_ < _loc7_)
         {
            _loc5_ = li32(param1 + _loc3_);
            _loc6_ = li32(HuffmanTree.scratchAddr + _loc3_);
            _loc4_ = _loc3_ - 4;
            while(_loc4_ >= 0 && li32(param1 + _loc4_) > _loc5_)
            {
               _loc8_ = li32(param1 + _loc4_);
               si32(_loc8_,param1 + _loc4_ + 4);
               _loc8_ = li32(HuffmanTree.scratchAddr + _loc4_);
               si32(_loc8_,HuffmanTree.scratchAddr + _loc4_ + 4);
               _loc4_ -= 4;
            }
            si32(_loc5_,param1 + _loc4_ + 4);
            si32(_loc6_,HuffmanTree.scratchAddr + _loc4_ + 4);
            _loc3_ += 4;
         }
      }
      
      public static function sortByCodeLengthAndSymbolDecreasing(param1:int, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:* = 4;
         while(_loc3_ < param2)
         {
            _loc5_ = li32(param1 + _loc3_);
            _loc7_ = _loc5_ >>> 16;
            _loc6_ = _loc5_ & 65535;
            _loc4_ = _loc3_ - 4;
            while(_loc4_ >= 0 && (_loc8_ == 0 ? li16(param1 + _loc4_ + 2) < _loc7_ : _loc8_ < 0))
            {
               _loc8_ = li32(param1 + _loc4_);
               si32(_loc8_,param1 + _loc4_ + 4);
               _loc4_ -= 4;
            }
            si32(_loc5_,param1 + _loc4_ + 4);
            _loc3_ += 4;
         }
      }
      
      public static function compareCodeLengthAndSymbolDecreasing(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:* = li16(param3 + param4) - param1;
         if(_loc5_ == 0)
         {
            return li16(param3 + param4 + 2) < param2;
         }
         return _loc5_ < 0;
      }
      
      public static function calculateOptimalCodeLengths(param1:int, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         if(param2 != 0)
         {
            if(param2 != 1)
            {
               _loc9_ = li32(param1) + li32(param1 + 4);
               si32(_loc9_,param1);
               _loc3_ = 0;
               _loc4_ = 2;
               _loc5_ = 1;
               while(_loc5_ < param2 - 1)
               {
                  if(_loc4_ >= param2 || li32(param1 + (_loc3_ << 2)) < li32(param1 + (_loc4_ << 2)))
                  {
                     _loc9_ = int(li32(param1 + (_loc3_ << 2)));
                     si32(_loc9_,param1 + (_loc5_ << 2));
                     _loc9_ = int(_loc3_++);
                     si32(_loc5_,param1 + (_loc9_ << 2));
                  }
                  else
                  {
                     _loc10_ = _loc4_++;
                     _loc9_ = int(li32(param1 + (_loc10_ << 2)));
                     si32(_loc9_,param1 + (_loc5_ << 2));
                  }
                  if(_loc4_ >= param2 || _loc3_ < _loc5_ && li32(param1 + (_loc3_ << 2)) < li32(param1 + (_loc4_ << 2)))
                  {
                     _loc9_ = li32(param1 + (_loc5_ << 2)) + li32(param1 + (_loc3_ << 2));
                     si32(_loc9_,param1 + (_loc5_ << 2));
                     _loc9_ = int(_loc3_++);
                     si32(_loc5_,param1 + (_loc9_ << 2));
                  }
                  else
                  {
                     _loc10_ = _loc4_++;
                     _loc9_ = li32(param1 + (_loc5_ << 2)) + li32(param1 + (_loc10_ << 2));
                     si32(_loc9_,param1 + (_loc5_ << 2));
                  }
                  _loc5_++;
               }
               si32(0,param1 + (param2 - 2 << 2));
               _loc5_ = param2 - 3;
               while(_loc5_ >= 0)
               {
                  _loc10_ = li32(param1 + (_loc5_ << 2));
                  _loc9_ = li32(param1 + (_loc10_ << 2)) + 1;
                  si32(_loc9_,param1 + (_loc5_ << 2));
                  _loc5_--;
               }
               _loc6_ = 1;
               _loc7_ = _loc8_ = 0;
               _loc3_ = param2 - 2;
               _loc5_ = param2 - 1;
               while(_loc6_ > 0)
               {
                  while(_loc3_ >= 0 && li32(param1 + (_loc3_ << 2)) == _loc8_)
                  {
                     _loc7_++;
                     _loc3_--;
                  }
                  while(_loc6_ > _loc7_)
                  {
                     _loc9_ = int(_loc5_--);
                     si32(_loc8_,param1 + (_loc9_ << 2));
                     _loc6_--;
                  }
                  _loc6_ = 2 * _loc7_;
                  _loc8_++;
                  _loc7_ = 0;
               }
            }
            else
            {
               si32(1,param1);
            }
         }
      }
      
      public static function get32(param1:int, param2:int) : int
      {
         return li32(param1 + (param2 << 2));
      }
      
      public static function set32(param1:int, param2:int, param3:int) : void
      {
         si32(param3,param1 + (param2 << 2));
      }
      
      public static function limitCodeLengths(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:int = param2 - param1 >>> 2;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = int(_loc6_++);
            if(li32(param1 + (_loc7_ << 2)) > param3)
            {
               si32(param3,param1 + (_loc7_ << 2));
               _loc4_ = true;
            }
         }
         if(_loc4_)
         {
            _loc8_ = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = int(_loc6_++);
               _loc8_ += Number(Math.pow(2,-li32(param1 + (_loc7_ << 2))));
            }
            _loc6_ = 0;
            while(_loc8_ > 1 && _loc6_ < _loc5_)
            {
               while(li32(param1 + (_loc6_ << 2)) < param3 && _loc8_ > 1)
               {
                  _loc7_ = li32(param1 + (_loc6_ << 2)) + 1;
                  si32(_loc7_,param1 + (_loc6_ << 2));
                  _loc8_ -= Number(Math.pow(2,-li32(param1 + (_loc6_ << 2))));
               }
               _loc6_++;
            }
            _loc6_ = _loc5_ - 1;
            while(_loc6_ >= 0)
            {
               while(Number(_loc8_ + Number(Math.pow(2,-li32(param1 + (_loc6_ << 2))))) <= 1)
               {
                  _loc8_ += Number(Math.pow(2,-li32(param1 + (_loc6_ << 2))));
                  _loc7_ = li32(param1 + (_loc6_ << 2)) - 1;
                  si32(_loc7_,param1 + (_loc6_ << 2));
               }
               _loc6_--;
            }
         }
      }
      
      public static function calculateCanonicalCodes(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         if(param2 != 0)
         {
            _loc4_ = param2 - 1;
            _loc5_ = 0;
            _loc6_ = li16(param1 + _loc4_ * 4);
            while(_loc4_ >= 0)
            {
               _loc7_ = li32(param1 + _loc4_ * 4);
               _loc8_ = _loc7_ & 65535;
               _loc5_ <<= _loc8_ - _loc6_;
               _loc10_ = int(_loc5_);
               _loc10_ = _loc10_ >>> 1 & 1431655765 | (_loc10_ & 1431655765) << 1;
               _loc10_ = _loc10_ >>> 2 & 858993459 | (_loc10_ & 858993459) << 2;
               _loc10_ = _loc10_ >>> 4 & 252645135 | (_loc10_ & 252645135) << 4;
               _loc10_ = _loc10_ >>> 8 & 16711935 | (_loc10_ & 16711935) << 8;
               _loc9_ = (_loc10_ & 65535) >>> 16 - _loc8_ << 16 | _loc8_;
               si32(_loc9_,param3 + (_loc7_ >>> 16) * 4);
               _loc5_++;
               _loc6_ = _loc8_;
               if(_loc5_ >= 1 << _loc6_)
               {
                  _loc6_++;
               }
               _loc4_--;
            }
         }
      }
      
      public static function reverseBits(param1:int, param2:int) : uint
      {
         param1 = param1 >>> 1 & 1431655765 | (param1 & 1431655765) << 1;
         param1 = param1 >>> 2 & 858993459 | (param1 & 858993459) << 2;
         param1 = param1 >>> 4 & 252645135 | (param1 & 252645135) << 4;
         param1 = param1 >>> 8 & 16711935 | (param1 & 16711935) << 8;
         return (param1 & 65535) >>> 16 - param2;
      }
   }
}
