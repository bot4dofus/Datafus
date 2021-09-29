package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_time2sub extends Machine
   {
       
      
      public function FSM_time2sub()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:int = 0;
         var _loc14_:* = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 48;
         _loc1_ = 0;
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = li32(mstate.ebp + 8);
         si32(_loc1_,_loc2_);
         _loc1_ = int(li32(_loc3_));
         _loc4_ = int(li32(_loc3_ + 4));
         _loc5_ = int(li32(_loc3_ + 8));
         _loc6_ = int(li32(_loc3_ + 12));
         _loc7_ = int(li32(_loc3_ + 16));
         _loc8_ = int(li32(_loc3_ + 20));
         _loc9_ = li32(_loc3_ + 32);
         _loc10_ = int(li32(mstate.ebp + 16));
         if(_loc10_ == 0)
         {
            addr256:
            if(_loc4_ >= 0)
            {
               _loc10_ = int(_loc4_ / 60);
               _loc11_ = int(_loc4_ < -59 ? 1 : 0);
               _loc12_ = int(_loc5_ + _loc10_);
               _loc13_ = _loc12_;
            }
            else
            {
               _loc10_ = _loc4_ ^ -1;
               _loc11_ = int(_loc10_ / 60);
               _loc11_ ^= -1;
               _loc14_ = int(_loc10_ > -60 ? 1 : 0);
               _loc12_ = int(_loc5_ + _loc11_);
               _loc13_ = _loc12_;
               _loc10_ = int(_loc11_);
               _loc11_ = int(_loc14_);
            }
            _loc5_ = int(_loc12_ < _loc5_ ? 1 : 0);
            _loc10_ *= 60;
            _loc5_ ^= _loc11_;
            _loc4_ -= _loc10_;
            _loc5_ &= 1;
            if(_loc5_ == 0)
            {
               if(_loc13_ >= 0)
               {
                  _loc5_ = int(_loc13_ / 24);
                  _loc10_ = int(_loc13_ < -23 ? 1 : 0);
                  _loc11_ = int(_loc6_ + _loc5_);
                  _loc12_ = int(_loc11_);
               }
               else
               {
                  _loc5_ = _loc13_ ^ -1;
                  _loc10_ = int(_loc5_ / 24);
                  _loc10_ ^= -1;
                  _loc14_ = int(_loc5_ > -24 ? 1 : 0);
                  _loc11_ = int(_loc6_ + _loc10_);
                  _loc12_ = int(_loc11_);
                  _loc5_ = int(_loc10_);
                  _loc10_ = int(_loc14_);
               }
               _loc6_ = int(_loc11_ < _loc6_ ? 1 : 0);
               _loc5_ *= 24;
               _loc6_ ^= _loc10_;
               _loc5_ = int(_loc13_ - _loc5_);
               _loc6_ &= 1;
               if(_loc6_ == 0)
               {
                  if(_loc7_ >= 0)
                  {
                     _loc6_ = int(_loc7_ / 12);
                     _loc10_ = int(_loc7_ < -11 ? 1 : 0);
                     _loc11_ = int(_loc8_ + _loc6_);
                     _loc13_ = _loc11_;
                  }
                  else
                  {
                     _loc6_ = _loc7_ ^ -1;
                     _loc10_ = int(_loc6_ / 12);
                     _loc10_ ^= -1;
                     _loc14_ = int(_loc6_ > -12 ? 1 : 0);
                     _loc11_ = int(_loc8_ + _loc10_);
                     _loc13_ = _loc11_;
                     _loc6_ = int(_loc10_);
                     _loc10_ = int(_loc14_);
                  }
                  _loc8_ = int(_loc11_ < _loc8_ ? 1 : 0);
                  _loc6_ *= 12;
                  _loc8_ ^= _loc10_;
                  _loc6_ = int(_loc7_ - _loc6_);
                  _loc7_ = _loc8_ & 1;
                  if(_loc7_ == 0)
                  {
                     _loc7_ = int(_loc13_ + 1900);
                     if(_loc7_ >= _loc13_)
                     {
                        if(_loc12_ >= 1)
                        {
                           _loc13_ = _loc7_;
                           _loc7_ = int(_loc12_);
                        }
                        else
                        {
                           _loc8_ = int(_loc6_ > 1 ? 1 : 0);
                           _loc8_ &= 1;
                           _loc8_ += 1899;
                           _loc10_ = int(_loc7_);
                           _loc7_ = int(_loc12_);
                           loop0:
                           while(true)
                           {
                              _loc10_ += -1;
                              _loc12_ = int(_loc13_ + 1900);
                              if(_loc10_ < _loc12_)
                              {
                                 _loc12_ = int(_loc8_ + _loc13_);
                                 _loc11_ = _loc12_ & 3;
                                 if(_loc11_ == 0)
                                 {
                                    _loc11_ = int(_loc12_ / 100);
                                    _loc11_ *= 100;
                                    _loc11_ = int(_loc12_ - _loc11_);
                                    if(_loc11_ == 0)
                                    {
                                       _loc11_ = int(_loc12_ / 400);
                                       _loc11_ *= 400;
                                       _loc12_ -= _loc11_;
                                       if(_loc12_ != 0)
                                       {
                                          addr651:
                                          _loc12_ = 0;
                                       }
                                       else
                                       {
                                          addr629:
                                          _loc12_ = 1;
                                       }
                                       _loc11_ = int(_year_lengths);
                                       _loc12_ <<= 2;
                                       _loc12_ = int(_loc11_ + _loc12_);
                                       _loc12_ = int(li32(_loc12_));
                                       _loc13_ += -1;
                                       _loc7_ = int(_loc12_ + _loc7_);
                                       if(_loc7_ <= 0)
                                       {
                                          continue;
                                       }
                                       addr798:
                                       _loc13_ += 1900;
                                       _loc10_ = int(_loc13_);
                                       _loc13_ = 0;
                                       _loc8_ = int(_loc6_ > 1 ? 1 : 0);
                                       _loc8_ &= 1;
                                       _loc11_ = int(_loc10_ + _loc8_);
                                       _loc12_ = int(_loc10_);
                                       while(true)
                                       {
                                          _loc8_ = int(_loc13_);
                                          _loc13_ = _loc12_;
                                          if(_loc7_ <= 366)
                                          {
                                             _loc11_ = int(_loc10_ + _loc8_);
                                             _loc8_ += _loc10_;
                                             _loc10_ = int(_loc11_);
                                             loop2:
                                             while(true)
                                             {
                                                _loc11_ = int(_mon_lengths);
                                                _loc12_ = _loc6_ << 2;
                                                _loc11_ += _loc12_;
                                                _loc12_ = _loc8_ & 3;
                                                while(true)
                                                {
                                                   if(_loc12_ == 0)
                                                   {
                                                      _loc13_ = _loc8_ / 100;
                                                      _loc13_ *= 100;
                                                      _loc13_ = _loc8_ - _loc13_;
                                                      if(_loc13_ == 0)
                                                      {
                                                         _loc13_ = _loc8_ / 400;
                                                         _loc13_ *= 400;
                                                         _loc13_ = _loc8_ - _loc13_;
                                                         if(_loc13_ != 0)
                                                         {
                                                            addr915:
                                                            _loc13_ = 0;
                                                         }
                                                         else
                                                         {
                                                            addr893:
                                                            _loc13_ = 1;
                                                         }
                                                         _loc13_ *= 48;
                                                         _loc13_ = _loc11_ + _loc13_;
                                                         _loc13_ = li32(_loc13_);
                                                         if(_loc7_ <= _loc13_)
                                                         {
                                                            _loc10_ = int(_loc8_ + -1900);
                                                            if(_loc10_ >= 0)
                                                            {
                                                               if(_loc10_ < _loc8_)
                                                               {
                                                                  if(uint(_loc1_) <= uint(59))
                                                                  {
                                                                     _loc8_ = 31;
                                                                     _loc11_ = 0;
                                                                     _loc12_ = int(_loc11_);
                                                                     _loc13_ = _loc1_;
                                                                     _loc1_ = int(_loc11_);
                                                                     addr1015:
                                                                     _loc15_ = _loc1_;
                                                                     _loc1_ = int(_loc8_);
                                                                     _loc8_ = int(mstate.ebp + -48);
                                                                     mstate.esp -= 12;
                                                                     _loc11_ = 0;
                                                                     si32(_loc12_,mstate.esp);
                                                                     si32(_loc11_,mstate.esp + 4);
                                                                     si32(_loc8_,mstate.esp + 8);
                                                                     mstate.esp -= 4;
                                                                     FSM_localsub399.start();
                                                                     mstate.esp += 12;
                                                                     _loc8_ = int(li32(mstate.ebp + -28));
                                                                     if(_loc8_ != _loc10_)
                                                                     {
                                                                        _loc11_ = int(_loc10_);
                                                                        addr1345:
                                                                        _loc16_ = _loc8_;
                                                                        _loc17_ = _loc11_;
                                                                        if(_loc16_ != _loc17_)
                                                                        {
                                                                           _loc14_ = int(_loc12_);
                                                                           _loc11_ = int(_loc13_);
                                                                           _loc8_ = int(_loc15_);
                                                                           _loc13_ = _loc1_;
                                                                           _loc1_ = int(_loc16_);
                                                                           _loc12_ = int(_loc17_);
                                                                           addr1374:
                                                                           _loc15_ = _loc13_ + -1;
                                                                           _loc1_ -= _loc12_;
                                                                           if(_loc13_ >= 0)
                                                                           {
                                                                              if(_loc15_ <= -1)
                                                                              {
                                                                                 _loc1_ = int(_loc14_ + -1);
                                                                                 _loc12_ = int(_loc1_);
                                                                                 _loc13_ = _loc11_;
                                                                                 _loc1_ = int(_loc8_);
                                                                                 _loc8_ = int(_loc15_);
                                                                                 addr1014:
                                                                                 §§goto(addr1015);
                                                                              }
                                                                              _loc12_ = 1;
                                                                              _loc12_ <<= _loc15_;
                                                                              if(_loc1_ >= 1)
                                                                              {
                                                                                 _loc12_ = int(_loc14_ - _loc12_);
                                                                                 _loc13_ = _loc11_;
                                                                                 _loc1_ = int(_loc8_);
                                                                                 _loc8_ = int(_loc15_);
                                                                                 §§goto(addr1014);
                                                                              }
                                                                              _loc1_ = int(_loc14_ + _loc12_);
                                                                              _loc12_ = int(_loc1_);
                                                                              _loc13_ = _loc11_;
                                                                              _loc1_ = int(_loc8_);
                                                                              _loc8_ = int(_loc15_);
                                                                              §§goto(addr1014);
                                                                           }
                                                                           break loop0;
                                                                        }
                                                                        _loc1_ = int(_loc13_);
                                                                        _loc8_ = int(_loc15_);
                                                                        _loc11_ = int(_loc12_);
                                                                        if(_loc9_ > -1)
                                                                        {
                                                                           _loc12_ = int(mstate.ebp + -48);
                                                                           _loc13_ = li32(mstate.ebp + -16);
                                                                           _loc12_ += 32;
                                                                           if(_loc13_ != _loc9_)
                                                                           {
                                                                              _loc13_ = li32(_lclmem + 8);
                                                                              _loc14_ = int(_loc13_ + -1);
                                                                              if(_loc14_ >= 0)
                                                                              {
                                                                                 _loc14_ = int(mstate.ebp + -48);
                                                                                 _loc15_ = _lclmem;
                                                                                 _loc16_ = _loc13_ * 20;
                                                                                 _loc15_ += _loc16_;
                                                                                 _loc13_ += -1;
                                                                                 _loc16_ = _loc14_ + 4;
                                                                                 _loc17_ = _loc14_ + 8;
                                                                                 _loc18_ = _loc14_ + 12;
                                                                                 _loc19_ = _loc14_ + 16;
                                                                                 _loc20_ = _loc14_ + 20;
                                                                                 addr1661:
                                                                                 _loc21_ = li32(_loc15_ + 1852);
                                                                                 if(_loc21_ == _loc9_)
                                                                                 {
                                                                                    _loc21_ = li32(_lclmem + 8);
                                                                                    _loc22_ = _loc21_ + -1;
                                                                                    if(_loc22_ >= 0)
                                                                                    {
                                                                                       _loc22_ = _lclmem;
                                                                                       _loc23_ = _loc21_ * 20;
                                                                                       _loc22_ += _loc23_;
                                                                                       _loc21_ += -1;
                                                                                       _loc23_ = _loc15_ + 1848;
                                                                                       addr1714:
                                                                                       _loc24_ = li32(_loc22_ + 1852);
                                                                                       if(_loc24_ != _loc9_)
                                                                                       {
                                                                                          _loc24_ = mstate.ebp + -48;
                                                                                          _loc25_ = li32(_loc22_ + 1848);
                                                                                          _loc26_ = li32(_loc23_);
                                                                                          _loc25_ = _loc11_ + _loc25_;
                                                                                          mstate.esp -= 12;
                                                                                          _loc27_ = 0;
                                                                                          _loc25_ -= _loc26_;
                                                                                          si32(_loc25_,mstate.esp);
                                                                                          si32(_loc27_,mstate.esp + 4);
                                                                                          si32(_loc24_,mstate.esp + 8);
                                                                                          mstate.esp -= 4;
                                                                                          FSM_localsub399.start();
                                                                                          mstate.esp += 12;
                                                                                          _loc24_ = li32(_loc20_);
                                                                                          if(_loc24_ != _loc10_)
                                                                                          {
                                                                                             _loc26_ = _loc10_;
                                                                                             addr1866:
                                                                                             if(_loc24_ == _loc26_)
                                                                                             {
                                                                                                _loc24_ = li32(_loc12_);
                                                                                                if(_loc24_ != _loc9_)
                                                                                                {
                                                                                                   addr1884:
                                                                                                   _loc22_ += -20;
                                                                                                   _loc21_ += -1;
                                                                                                   if(_loc21_ >= 0)
                                                                                                   {
                                                                                                      §§goto(addr1714);
                                                                                                   }
                                                                                                   _loc15_ += -20;
                                                                                                   _loc13_ += -1;
                                                                                                   if(_loc13_ >= 0)
                                                                                                   {
                                                                                                      §§goto(addr1661);
                                                                                                   }
                                                                                                   break loop0;
                                                                                                }
                                                                                                _loc1_ = int(_loc25_);
                                                                                                addr1475:
                                                                                                _loc4_ = int(_loc1_ + _loc8_);
                                                                                                _loc1_ = int(_loc4_ < _loc1_ ? 1 : 0);
                                                                                                _loc5_ = int(_loc8_ < 0 ? 1 : 0);
                                                                                                _loc1_ ^= _loc5_;
                                                                                                _loc1_ &= 1;
                                                                                                if(_loc1_ == 0)
                                                                                                {
                                                                                                   _loc1_ = 0;
                                                                                                   mstate.esp -= 12;
                                                                                                   si32(_loc4_,mstate.esp);
                                                                                                   si32(_loc1_,mstate.esp + 4);
                                                                                                   si32(_loc3_,mstate.esp + 8);
                                                                                                   mstate.esp -= 4;
                                                                                                   FSM_localsub399.start();
                                                                                                   mstate.esp += 12;
                                                                                                   _loc1_ = 1;
                                                                                                   si32(_loc1_,_loc2_);
                                                                                                   mstate.eax = _loc4_;
                                                                                                   §§goto(addr1920);
                                                                                                }
                                                                                                break loop0;
                                                                                             }
                                                                                             §§goto(addr1884);
                                                                                          }
                                                                                          _loc24_ = li32(_loc19_);
                                                                                          if(_loc24_ != _loc6_)
                                                                                          {
                                                                                             _loc26_ = _loc6_;
                                                                                             §§goto(addr1866);
                                                                                          }
                                                                                          _loc24_ = li32(_loc18_);
                                                                                          if(_loc24_ != _loc7_)
                                                                                          {
                                                                                             _loc26_ = _loc7_;
                                                                                             §§goto(addr1866);
                                                                                          }
                                                                                          _loc24_ = li32(_loc17_);
                                                                                          if(_loc24_ != _loc5_)
                                                                                          {
                                                                                             _loc26_ = _loc5_;
                                                                                             §§goto(addr1866);
                                                                                          }
                                                                                          _loc24_ = li32(_loc16_);
                                                                                          if(_loc24_ != _loc4_)
                                                                                          {
                                                                                             _loc26_ = _loc4_;
                                                                                             §§goto(addr1866);
                                                                                          }
                                                                                          _loc24_ = li32(_loc14_);
                                                                                          _loc26_ = _loc1_;
                                                                                          §§goto(addr1866);
                                                                                       }
                                                                                       §§goto(addr1884);
                                                                                    }
                                                                                 }
                                                                                 §§goto(addr1884);
                                                                              }
                                                                              break loop0;
                                                                           }
                                                                           addr1469:
                                                                           _loc1_ = int(_loc11_);
                                                                           §§goto(addr1475);
                                                                        }
                                                                        §§goto(addr1469);
                                                                     }
                                                                     _loc8_ = int(li32(mstate.ebp + -32));
                                                                     if(_loc8_ != _loc6_)
                                                                     {
                                                                        _loc11_ = int(_loc6_);
                                                                        §§goto(addr1345);
                                                                     }
                                                                     _loc8_ = int(li32(mstate.ebp + -36));
                                                                     if(_loc8_ != _loc7_)
                                                                     {
                                                                        _loc11_ = int(_loc7_);
                                                                        §§goto(addr1345);
                                                                     }
                                                                     _loc8_ = int(li32(mstate.ebp + -40));
                                                                     if(_loc8_ != _loc5_)
                                                                     {
                                                                        _loc11_ = int(_loc5_);
                                                                        §§goto(addr1345);
                                                                     }
                                                                     _loc8_ = int(li32(mstate.ebp + -44));
                                                                     if(_loc8_ != _loc4_)
                                                                     {
                                                                        _loc11_ = int(_loc4_);
                                                                        §§goto(addr1345);
                                                                     }
                                                                     _loc8_ = int(li32(mstate.ebp + -48));
                                                                     _loc11_ = int(_loc13_);
                                                                     §§goto(addr1345);
                                                                  }
                                                                  else
                                                                  {
                                                                     if(_loc10_ < 70)
                                                                     {
                                                                        _loc8_ = int(_loc1_ + -59);
                                                                        if(_loc8_ < _loc1_)
                                                                        {
                                                                           _loc1_ = int(mstate.ebp + -48);
                                                                           mstate.esp -= 12;
                                                                           _loc12_ = 0;
                                                                           si32(_loc12_,mstate.esp);
                                                                           si32(_loc12_,mstate.esp + 4);
                                                                           si32(_loc1_,mstate.esp + 8);
                                                                           mstate.esp -= 4;
                                                                           FSM_localsub399.start();
                                                                           mstate.esp += 12;
                                                                           _loc1_ = int(li32(mstate.ebp + -28));
                                                                           if(_loc1_ != _loc10_)
                                                                           {
                                                                              _loc12_ = int(_loc10_);
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc1_ = int(li32(mstate.ebp + -32));
                                                                              if(_loc1_ != _loc6_)
                                                                              {
                                                                                 _loc12_ = int(_loc6_);
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc1_ = int(li32(mstate.ebp + -36));
                                                                                 if(_loc1_ != _loc7_)
                                                                                 {
                                                                                    _loc12_ = int(_loc7_);
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc1_ = int(li32(mstate.ebp + -40));
                                                                                    if(_loc1_ != _loc5_)
                                                                                    {
                                                                                       _loc12_ = int(_loc5_);
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc1_ = int(li32(mstate.ebp + -44));
                                                                                       if(_loc1_ != _loc4_)
                                                                                       {
                                                                                          _loc12_ = int(_loc4_);
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _loc12_ = 59;
                                                                                          _loc1_ = int(li32(mstate.ebp + -48));
                                                                                       }
                                                                                    }
                                                                                 }
                                                                              }
                                                                           }
                                                                           if(_loc1_ != _loc12_)
                                                                           {
                                                                              _loc13_ = 31;
                                                                              _loc11_ = 59;
                                                                              _loc14_ = 0;
                                                                              §§goto(addr1374);
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc1_ = 59;
                                                                              _loc12_ = 0;
                                                                           }
                                                                        }
                                                                        break loop0;
                                                                     }
                                                                     _loc8_ = 31;
                                                                     _loc13_ = 0;
                                                                     _loc12_ = int(_loc13_);
                                                                     §§goto(addr1014);
                                                                  }
                                                               }
                                                               break loop0;
                                                            }
                                                         }
                                                         _loc11_ += 4;
                                                         _loc6_ += 1;
                                                         _loc7_ -= _loc13_;
                                                         if(_loc6_ > 11)
                                                         {
                                                            _loc6_ = int(_loc8_ + 1);
                                                            _loc10_ += 1;
                                                            if(_loc10_ < _loc8_)
                                                            {
                                                               break loop0;
                                                            }
                                                         }
                                                         continue;
                                                         continue loop2;
                                                         break loop0;
                                                      }
                                                      §§goto(addr893);
                                                   }
                                                   §§goto(addr915);
                                                }
                                             }
                                          }
                                          else
                                          {
                                             _loc12_ = int(_loc11_ + _loc8_);
                                             _loc14_ = _loc12_ & 3;
                                             if(_loc14_ == 0)
                                             {
                                                _loc14_ = int(_loc12_ / 100);
                                                _loc14_ *= 100;
                                                _loc14_ = int(_loc12_ - _loc14_);
                                                if(_loc14_ == 0)
                                                {
                                                   _loc14_ = int(_loc12_ / 400);
                                                   _loc14_ *= 400;
                                                   _loc12_ -= _loc14_;
                                                   if(_loc12_ != 0)
                                                   {
                                                      addr743:
                                                      _loc12_ = 0;
                                                   }
                                                   else
                                                   {
                                                      addr721:
                                                      _loc12_ = 1;
                                                   }
                                                   _loc14_ = int(_year_lengths);
                                                   _loc12_ <<= 2;
                                                   _loc12_ = int(_loc14_ + _loc12_);
                                                   _loc12_ = int(li32(_loc12_));
                                                   _loc8_ += 1;
                                                   _loc14_ = int(_loc13_ + 1);
                                                   _loc7_ -= _loc12_;
                                                   _loc12_ = int(_loc10_ + _loc8_);
                                                   if(_loc12_ < _loc13_)
                                                   {
                                                      break loop0;
                                                   }
                                                   continue;
                                                }
                                                §§goto(addr721);
                                             }
                                             §§goto(addr743);
                                          }
                                       }
                                    }
                                    §§goto(addr629);
                                 }
                                 §§goto(addr651);
                              }
                              break;
                           }
                           §§goto(addr1914);
                        }
                        §§goto(addr798);
                     }
                  }
               }
            }
         }
         else
         {
            if(_loc1_ >= 0)
            {
               _loc10_ = int(_loc1_ / 60);
               _loc11_ = int(_loc1_ < -59 ? 1 : 0);
               _loc12_ = int(_loc4_ + _loc10_);
               _loc13_ = _loc12_;
            }
            else
            {
               _loc10_ = _loc1_ ^ -1;
               _loc11_ = int(_loc10_ / 60);
               _loc11_ ^= -1;
               _loc14_ = int(_loc10_ > -60 ? 1 : 0);
               _loc12_ = int(_loc4_ + _loc11_);
               _loc13_ = _loc12_;
               _loc10_ = int(_loc11_);
               _loc11_ = int(_loc14_);
            }
            _loc4_ = int(_loc12_ < _loc4_ ? 1 : 0);
            _loc10_ *= 60;
            _loc4_ ^= _loc11_;
            _loc1_ -= _loc10_;
            _loc4_ &= 1;
            if(_loc4_ == 0)
            {
               _loc4_ = int(_loc13_);
               §§goto(addr256);
            }
         }
         addr1914:
         _loc1_ = -1;
         mstate.eax = _loc1_;
         addr1920:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
