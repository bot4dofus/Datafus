package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_imalloc extends Machine
   {
       
      
      public function FSM_imalloc()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = int(_loc1_ + 4096);
         if(uint(_loc2_) < uint(_loc1_))
         {
            addr91:
            _loc2_ = 0;
         }
         else if(uint(_loc1_) <= uint(2048))
         {
            _loc2_ = int(_loc1_ + -1);
            _loc2_ = int(uint(_loc1_) < uint(16) ? 15 : int(_loc2_));
            if(uint(_loc2_) >= uint(2))
            {
               _loc3_ = -1;
               do
               {
                  _loc3_ += 1;
                  _loc2_ >>= 1;
               }
               while(uint(_loc2_) >= uint(2));
               
               _loc2_ = int(_loc3_ + 2);
            }
            else
            {
               _loc2_ = 1;
            }
            _loc3_ = int(li32(_page_dir));
            _loc4_ = _loc2_ << 2;
            _loc4_ = int(_loc3_ + _loc4_);
            _loc4_ = int(li32(_loc4_));
            if(_loc4_ == 0)
            {
               _loc3_ = 4096;
               mstate.esp -= 4;
               si32(_loc3_,mstate.esp);
               mstate.esp -= 4;
               FSM_malloc_pages.start();
               _loc3_ = int(mstate.eax);
               mstate.esp += 4;
               if(_loc3_ != 0)
               {
                  _loc4_ = 4096;
                  _loc4_ >>>= _loc2_;
                  _loc5_ = int(_loc4_ + 31);
                  _loc5_ >>>= 3;
                  _loc6_ = 1;
                  _loc5_ &= 536870908;
                  _loc7_ = int(_loc5_ + 16);
                  _loc6_ <<= _loc2_;
                  _loc8_ = _loc7_ << 1;
                  if(_loc6_ <= _loc8_)
                  {
                     _loc8_ = int(_loc3_);
                     addr310:
                     si16(_loc6_,_loc8_ + 8);
                     si16(_loc2_,_loc8_ + 10);
                     si16(_loc4_,_loc8_ + 12);
                     si16(_loc4_,_loc8_ + 14);
                     si32(_loc3_,_loc8_ + 4);
                     _loc9_ = _loc4_ & 65535;
                     _loc10_ = _loc8_ + 14;
                     _loc11_ = _loc8_ + 12;
                     _loc12_ = _loc8_;
                     if(uint(_loc9_) <= uint(31))
                     {
                        _loc13_ = 0;
                     }
                     else
                     {
                        _loc13_ = 0;
                        _loc14_ = int(_loc9_);
                        _loc15_ = int(_loc13_);
                        do
                        {
                           _loc16_ = -1;
                           _loc17_ = _loc13_ & 134217727;
                           _loc17_ <<= 2;
                           _loc17_ = int(_loc12_ + _loc17_);
                           si32(_loc16_,_loc17_ + 16);
                           _loc14_ += -32;
                           _loc15_ += 32;
                           _loc13_ += 1;
                        }
                        while(uint(_loc14_) > uint(31));
                        
                        _loc13_ = int(_loc15_);
                     }
                     if(_loc13_ < _loc9_)
                     {
                        _loc14_ = 0;
                        _loc9_ -= _loc13_;
                        do
                        {
                           _loc15_ = 1;
                           _loc16_ = int(_loc13_ + _loc14_);
                           _loc17_ = _loc16_ & -32;
                           _loc17_ >>>= 3;
                           _loc16_ &= 31;
                           _loc17_ = int(_loc12_ + _loc17_);
                           _loc18_ = li32(_loc17_ + 16);
                           _loc15_ <<= _loc16_;
                           _loc15_ = _loc18_ | _loc15_;
                           si32(_loc15_,_loc17_ + 16);
                           _loc14_ += 1;
                        }
                        while(_loc14_ != _loc9_);
                        
                     }
                     if(_loc3_ == _loc8_)
                     {
                        if(_loc7_ >= 1)
                        {
                           _loc7_ = 0;
                           _loc5_ += 16;
                           do
                           {
                              _loc9_ = 1;
                              _loc13_ = _loc7_ & -32;
                              _loc14_ = _loc7_ & 31;
                              _loc13_ >>>= 3;
                              _loc9_ <<= _loc14_;
                              _loc13_ = int(_loc12_ + _loc13_);
                              _loc14_ = int(li32(_loc13_ + 16));
                              _loc9_ ^= -1;
                              _loc9_ = _loc14_ & _loc9_;
                              si32(_loc9_,_loc13_ + 16);
                              _loc9_ = int(li16(_loc10_));
                              _loc9_ += -1;
                              si16(_loc9_,_loc10_);
                              _loc5_ -= _loc6_;
                              _loc7_ += 1;
                           }
                           while(_loc5_ >= 1);
                           
                           _loc5_ = int(_loc7_ + -1);
                           _loc4_ -= _loc5_;
                           _loc4_ += -1;
                           si16(_loc4_,_loc11_);
                        }
                     }
                     _loc4_ = int(li32(_malloc_origo));
                     _loc3_ >>>= 12;
                     _loc3_ -= _loc4_;
                     _loc4_ = int(li32(_page_dir));
                     _loc3_ <<= 2;
                     _loc5_ = _loc2_ << 2;
                     _loc3_ = int(_loc4_ + _loc3_);
                     si32(_loc12_,_loc3_);
                     _loc3_ = int(_loc4_ + _loc5_);
                     _loc5_ = int(li32(_loc3_));
                     si32(_loc5_,_loc8_);
                     si32(_loc12_,_loc3_);
                     _loc3_ = int(li32(_loc12_ + 16));
                     _loc5_ = int(_loc12_ + 16);
                     if(_loc3_ != 0)
                     {
                        _loc3_ = int(_loc4_);
                        _loc4_ = int(_loc12_);
                     }
                     else
                     {
                        _loc3_ = int(_loc4_);
                        _loc4_ = int(_loc12_);
                        while(true)
                        {
                           _loc6_ = int(li32(_loc5_ + 4));
                           _loc5_ += 4;
                           _loc7_ = int(_loc5_);
                           if(_loc6_ != 0)
                           {
                              break;
                           }
                           _loc5_ = int(_loc7_);
                        }
                        addr727:
                     }
                     _loc7_ = int(li32(_loc5_));
                     _loc6_ = _loc7_ & 1;
                     if(_loc6_ != 0)
                     {
                        _loc8_ = 1;
                        _loc6_ = 0;
                     }
                     else
                     {
                        _loc8_ = 1;
                        _loc6_ = 0;
                        do
                        {
                           _loc6_ += 1;
                           _loc8_ <<= 1;
                           _loc9_ = _loc7_ & _loc8_;
                        }
                        while(_loc9_ == 0);
                        
                     }
                     _loc7_ ^= _loc8_;
                     si32(_loc7_,_loc5_);
                     _loc7_ = int(li16(_loc4_ + 12));
                     _loc7_ += -1;
                     si16(_loc7_,_loc4_ + 12);
                     _loc7_ &= 65535;
                     if(_loc7_ == 0)
                     {
                        _loc7_ = 0;
                        _loc2_ <<= 2;
                        _loc8_ = int(li32(_loc4_));
                        _loc2_ = int(_loc3_ + _loc2_);
                        si32(_loc8_,_loc2_);
                        si32(_loc7_,_loc4_);
                     }
                     _loc2_ = int(_loc4_ + 16);
                     _loc2_ = int(_loc5_ - _loc2_);
                     _loc2_ <<= 3;
                     _loc3_ = int(li8(_malloc_junk_2E_b));
                     _loc5_ = int(li16(_loc4_ + 10));
                     _loc2_ += _loc6_;
                     _loc3_ ^= 1;
                     _loc2_ <<= _loc5_;
                     _loc3_ &= 1;
                     if(_loc3_ == 0)
                     {
                        _loc3_ = -48;
                        _loc5_ = int(li16(_loc4_ + 8));
                        _loc6_ = int(li32(_loc4_ + 4));
                        _loc6_ += _loc2_;
                        memset(_loc6_,_loc3_,_loc5_);
                        _loc4_ = int(li32(_loc4_ + 4));
                        _loc2_ = int(_loc4_ + _loc2_);
                        addr957:
                        _loc3_ = int(li8(_malloc_zero_2E_b));
                        _loc3_ ^= 1;
                        if(_loc2_ != 0)
                        {
                           _loc3_ &= 1;
                           if(_loc3_ == 0)
                           {
                              _loc3_ = 0;
                              _loc4_ = int(_loc2_);
                              memset(_loc4_,_loc3_,_loc1_);
                           }
                        }
                     }
                     else
                     {
                        _loc3_ = int(li32(_loc4_ + 4));
                        _loc2_ = int(_loc3_ + _loc2_);
                        §§goto(addr957);
                     }
                     §§goto(addr957);
                  }
                  else
                  {
                     mstate.esp -= 4;
                     si32(_loc7_,mstate.esp);
                     mstate.esp -= 4;
                     FSM_imalloc.start();
                     _loc8_ = int(mstate.eax);
                     mstate.esp += 4;
                     if(_loc8_ != 0)
                     {
                        §§goto(addr310);
                     }
                     else
                     {
                        _loc2_ = 0;
                        mstate.esp -= 4;
                        si32(_loc3_,mstate.esp);
                        mstate.esp -= 4;
                        FSM_ifree.start();
                        mstate.esp += 4;
                     }
                  }
                  mstate.eax = _loc2_;
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  return;
               }
               §§goto(addr91);
               §§goto(addr957);
            }
            else
            {
               _loc5_ = int(li32(_loc4_ + 16));
               _loc6_ = int(_loc4_ + 16);
               if(_loc5_ != 0)
               {
                  _loc5_ = int(_loc6_);
               }
               else
               {
                  _loc5_ = int(_loc6_);
                  §§goto(addr727);
               }
               §§goto(addr727);
            }
         }
         else
         {
            mstate.esp -= 4;
            si32(_loc1_,mstate.esp);
            mstate.esp -= 4;
            FSM_malloc_pages.start();
            _loc2_ = int(mstate.eax);
            mstate.esp += 4;
         }
         §§goto(addr957);
      }
   }
}
