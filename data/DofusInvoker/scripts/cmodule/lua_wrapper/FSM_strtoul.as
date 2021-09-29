package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_strtoul extends Machine
   {
       
      
      public function FSM_strtoul()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = 0;
         _loc2_ = int(li32(__CurrentRuneLocale));
         _loc3_ = li32(mstate.ebp + 8);
         _loc4_ = li32(mstate.ebp + 12);
         _loc5_ = int(li32(mstate.ebp + 16));
         _loc6_ = int(_loc3_);
         do
         {
            _loc7_ = int(_loc6_ + _loc1_);
            _loc7_ = int(li8(_loc7_));
            _loc8_ = _loc7_ << 2;
            _loc8_ = int(_loc2_ + _loc8_);
            _loc8_ = int(li32(_loc8_ + 52));
            _loc1_ += 1;
            _loc8_ &= 16384;
         }
         while(_loc8_ != 0);
         
         _loc2_ = int(_loc3_ + _loc1_);
         _loc6_ = _loc7_ & 255;
         if(_loc6_ != 43)
         {
            _loc6_ = _loc7_ & 255;
            if(_loc6_ != 45)
            {
               _loc1_ = int(_loc7_);
               addr210:
               _loc7_ = int(_loc2_);
               if(_loc5_ != 0)
               {
                  if(_loc5_ == 16)
                  {
                     addr222:
                     _loc6_ = 0;
                     _loc2_ = int(_loc1_);
                     _loc1_ = int(_loc7_);
                     _loc7_ = _loc2_ & 255;
                     if(_loc7_ != 48)
                     {
                        addr241:
                     }
                     else
                     {
                        _loc7_ = int(li8(_loc1_));
                        if(_loc7_ != 88)
                        {
                           _loc7_ &= 255;
                           if(_loc7_ == 120)
                           {
                              addr259:
                              _loc7_ = int(li8(_loc1_ + 1));
                              _loc8_ = int(_loc7_ + -48);
                              _loc8_ &= 255;
                              if(uint(_loc8_) >= uint(10))
                              {
                                 _loc8_ = int(_loc7_ + -65);
                                 _loc8_ &= 255;
                                 if(uint(_loc8_) >= uint(6))
                                 {
                                    _loc8_ = int(_loc7_ + -97);
                                    _loc8_ &= 255;
                                    if(uint(_loc8_) > uint(5))
                                    {
                                       addr240:
                                       §§goto(addr241);
                                    }
                                    addr328:
                                    if(_loc5_ == 0)
                                    {
                                       _loc5_ = _loc2_ & 255;
                                       if(_loc5_ == 48)
                                       {
                                          _loc5_ = 8;
                                       }
                                       else
                                       {
                                          _loc5_ = 10;
                                       }
                                    }
                                    _loc7_ = int(_loc5_ + -2);
                                    if(uint(_loc7_) >= uint(35))
                                    {
                                       _loc2_ = 0;
                                       _loc5_ = int(_loc2_);
                                       addr644:
                                       _loc6_ = int(_loc2_);
                                       _loc2_ = 22;
                                       si32(_loc2_,_val_2E_1440);
                                       if(_loc4_ != 0)
                                       {
                                          _loc2_ = int(_loc5_);
                                          _loc5_ = int(_loc6_);
                                          addr692:
                                          if(_loc2_ != 0)
                                          {
                                             _loc1_ += -1;
                                             si32(_loc1_,_loc4_);
                                          }
                                          else
                                          {
                                             si32(_loc3_,_loc4_);
                                          }
                                          mstate.eax = _loc5_;
                                       }
                                       else
                                       {
                                          _loc1_ = int(_loc6_);
                                          addr718:
                                          mstate.eax = _loc1_;
                                       }
                                       §§goto(addr722);
                                    }
                                    else
                                    {
                                       _loc7_ = 0;
                                       _loc8_ = int(uint(-1) % uint(_loc5_));
                                       _loc9_ = uint(-1) / uint(_loc5_);
                                       _loc10_ = int(_loc7_);
                                       loop1:
                                       while(true)
                                       {
                                          _loc11_ = int(_loc2_ + -48);
                                          _loc11_ &= 255;
                                          if(uint(_loc11_) >= uint(10))
                                          {
                                             loop2:
                                             while(true)
                                             {
                                                _loc11_ = int(_loc2_ + -65);
                                                _loc11_ &= 255;
                                                if(uint(_loc11_) > uint(25))
                                                {
                                                   _loc11_ = int(_loc2_ + -97);
                                                   _loc11_ &= 255;
                                                   if(uint(_loc11_) <= uint(25))
                                                   {
                                                      _loc2_ += -87;
                                                      _loc11_ = _loc2_ << 24;
                                                      _loc11_ >>= 24;
                                                      if(_loc11_ < _loc5_)
                                                      {
                                                         loop3:
                                                         while(uint(_loc7_) <= uint(_loc9_))
                                                         {
                                                            if(_loc10_ < 0)
                                                            {
                                                               break;
                                                            }
                                                            if(_loc7_ == _loc9_)
                                                            {
                                                               _loc10_ = _loc2_ << 24;
                                                               _loc10_ >>= 24;
                                                               if(_loc10_ > _loc8_)
                                                               {
                                                                  break;
                                                               }
                                                            }
                                                            _loc2_ <<= 24;
                                                            _loc2_ >>= 24;
                                                            _loc7_ *= _loc5_;
                                                            _loc10_ = int(li8(_loc1_));
                                                            _loc1_ += 1;
                                                            _loc7_ += _loc2_;
                                                            _loc2_ = int(_loc10_ + -48);
                                                            _loc2_ &= 255;
                                                            if(uint(_loc2_) >= uint(10))
                                                            {
                                                               continue loop2;
                                                            }
                                                            addr463:
                                                            _loc11_ = 1;
                                                            _loc2_ = int(_loc10_);
                                                            _loc10_ = int(_loc11_);
                                                            while(true)
                                                            {
                                                               _loc2_ += -48;
                                                               _loc11_ = _loc2_ << 24;
                                                               _loc11_ >>= 24;
                                                               if(_loc11_ < _loc5_)
                                                               {
                                                                  continue loop3;
                                                               }
                                                               _loc2_ = int(_loc10_);
                                                               if(_loc2_ <= -1)
                                                               {
                                                                  _loc5_ = 34;
                                                                  si32(_loc5_,_val_2E_1440);
                                                                  if(_loc4_ != 0)
                                                                  {
                                                                     _loc5_ = -1;
                                                                     §§goto(addr692);
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc1_ = -1;
                                                                     §§goto(addr718);
                                                                  }
                                                                  mstate.esp += 4;
                                                                  mstate.esp += 4;
                                                                  return;
                                                               }
                                                               if(_loc2_ == 0)
                                                               {
                                                                  _loc5_ = int(_loc2_);
                                                                  _loc2_ = int(_loc7_);
                                                                  §§goto(addr644);
                                                               }
                                                               else
                                                               {
                                                                  _loc5_ = _loc6_ & 1;
                                                                  _loc6_ = int(0 - _loc7_);
                                                                  _loc5_ = int(_loc5_ != 0 ? int(_loc6_) : int(_loc7_));
                                                                  if(_loc4_ != 0)
                                                                  {
                                                                     §§goto(addr692);
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc1_ = int(_loc5_);
                                                                     §§goto(addr718);
                                                                  }
                                                               }
                                                               §§goto(addr718);
                                                               §§goto(addr718);
                                                            }
                                                         }
                                                         continue loop1;
                                                         addr539:
                                                      }
                                                   }
                                                   break;
                                                }
                                                _loc2_ += -55;
                                                _loc11_ = _loc2_ << 24;
                                                _loc11_ >>= 24;
                                                if(_loc11_ >= _loc5_)
                                                {
                                                   break;
                                                }
                                                §§goto(addr539);
                                             }
                                             _loc2_ = int(_loc10_);
                                             §§goto(addr484);
                                          }
                                          §§goto(addr463);
                                       }
                                    }
                                    §§goto(addr718);
                                 }
                              }
                              _loc5_ = 16;
                              _loc1_ += 2;
                              _loc2_ = int(_loc7_);
                              §§goto(addr328);
                           }
                           §§goto(addr240);
                        }
                        §§goto(addr259);
                     }
                  }
                  else
                  {
                     _loc2_ = 0;
                     _loc6_ = int(_loc2_);
                     _loc2_ = int(_loc1_);
                     _loc1_ = int(_loc7_);
                  }
                  §§goto(addr328);
               }
               §§goto(addr222);
            }
            else
            {
               _loc1_ <<= 0;
               _loc1_ += _loc3_;
               _loc2_ = int(li8(_loc2_));
               _loc1_ += 1;
               if(_loc5_ != 0)
               {
                  if(_loc5_ == 16)
                  {
                     addr180:
                     _loc6_ = 1;
                     §§goto(addr222);
                  }
                  else
                  {
                     _loc6_ = 1;
                  }
                  §§goto(addr328);
               }
               §§goto(addr180);
            }
         }
         else
         {
            _loc1_ <<= 0;
            _loc1_ += _loc3_;
            _loc2_ = int(li8(_loc2_));
            _loc6_ = int(_loc1_ + 1);
            _loc1_ = int(_loc2_);
            _loc2_ = int(_loc6_);
         }
         §§goto(addr210);
      }
   }
}
