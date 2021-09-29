package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_match_class extends Machine
   {
       
      
      public function FSM_match_class()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(__CurrentRuneLocale));
         _loc2_ = int(li32(mstate.ebp + 8));
         _loc3_ = int(li32(mstate.ebp + 12));
         if(uint(_loc3_) >= uint(256))
         {
            if(_loc3_ > -1)
            {
               _loc4_ = int(li32(_loc1_ + 3136));
               _loc5_ = int(li32(_loc1_ + 3132));
               if(_loc5_ != 0)
               {
                  while(true)
                  {
                     _loc6_ = _loc5_ & 536870910;
                     _loc6_ <<= 3;
                     _loc6_ = int(_loc4_ + _loc6_);
                     _loc6_ = int(li32(_loc6_));
                     _loc7_ = _loc5_ >>> 1;
                     if(_loc6_ <= _loc3_)
                     {
                        _loc8_ = _loc7_ << 4;
                        _loc8_ = int(_loc4_ + _loc8_);
                        _loc8_ = int(li32(_loc8_ + 4));
                        if(_loc8_ >= _loc3_)
                        {
                           _loc5_ = _loc7_ << 4;
                           _loc4_ += _loc5_;
                           _loc4_ = int(li32(_loc4_ + 8));
                           _loc4_ += _loc3_;
                           _loc4_ -= _loc6_;
                           addr89:
                           if(_loc4_ <= 114)
                           {
                              if(_loc4_ <= 99)
                              {
                                 if(_loc4_ != 97)
                                 {
                                    if(_loc4_ != 99)
                                    {
                                       _loc2_ = int(_loc3_ == _loc2_ ? 1 : 0);
                                       _loc2_ &= 1;
                                       mstate.eax = _loc2_;
                                       addr589:
                                    }
                                    else
                                    {
                                       addr111:
                                       if(uint(_loc2_) >= uint(256))
                                       {
                                          mstate.esp -= 4;
                                          si32(_loc2_,mstate.esp);
                                          mstate.esp -= 4;
                                          FSM____runetype.start();
                                          _loc2_ = int(mstate.eax);
                                          _loc2_ >>>= 9;
                                          mstate.esp += 4;
                                          _loc2_ &= 1;
                                          if(uint(_loc3_) <= uint(255))
                                          {
                                             addr671:
                                             _loc3_ <<= 2;
                                             _loc1_ += _loc3_;
                                             _loc1_ = int(li32(_loc1_ + 52));
                                             _loc1_ &= 4096;
                                             if(_loc1_ != 0)
                                             {
                                                _loc1_ = int(_loc2_);
                                             }
                                             else
                                             {
                                                _loc1_ = int(_loc2_);
                                                _loc1_ = int(_loc1_ == 0 ? 1 : 0);
                                                _loc1_ &= 1;
                                                addr1311:
                                             }
                                             §§goto(addr1323);
                                          }
                                          else
                                          {
                                             addr1258:
                                          }
                                          addr1258:
                                          _loc1_ = int(_loc2_);
                                          mstate.esp -= 4;
                                          si32(_loc3_,mstate.esp);
                                          mstate.esp -= 4;
                                          FSM____runetype.start();
                                          _loc2_ = int(mstate.eax);
                                          mstate.esp += 4;
                                          _loc2_ &= 4096;
                                          if(_loc2_ == 0)
                                          {
                                             §§goto(addr1311);
                                          }
                                          addr1323:
                                          mstate.eax = _loc1_;
                                          mstate.esp = mstate.ebp;
                                          mstate.ebp = li32(mstate.esp);
                                          mstate.esp += 4;
                                          mstate.esp += 4;
                                          return;
                                          §§goto(addr1311);
                                       }
                                       else
                                       {
                                          _loc2_ <<= 2;
                                          _loc2_ = int(_loc1_ + _loc2_);
                                          _loc2_ = int(li32(_loc2_ + 52));
                                          _loc2_ >>>= 9;
                                          _loc2_ &= 1;
                                          if(uint(_loc3_) <= uint(255))
                                          {
                                             addr670:
                                             §§goto(addr671);
                                          }
                                          else
                                          {
                                             §§goto(addr1258);
                                          }
                                       }
                                       §§goto(addr1258);
                                    }
                                    §§goto(addr671);
                                 }
                                 else
                                 {
                                    addr606:
                                    if(uint(_loc2_) >= uint(256))
                                    {
                                       mstate.esp -= 4;
                                       si32(_loc2_,mstate.esp);
                                       mstate.esp -= 4;
                                       FSM____runetype.start();
                                       _loc2_ = int(mstate.eax);
                                       _loc2_ >>>= 8;
                                       mstate.esp += 4;
                                       _loc2_ &= 1;
                                       if(uint(_loc3_) <= uint(255))
                                       {
                                          §§goto(addr671);
                                       }
                                       else
                                       {
                                          §§goto(addr1258);
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ <<= 2;
                                       _loc2_ = int(_loc1_ + _loc2_);
                                       _loc2_ = int(li32(_loc2_ + 52));
                                       _loc2_ >>>= 8;
                                       _loc2_ &= 1;
                                       if(uint(_loc3_) <= uint(255))
                                       {
                                          §§goto(addr670);
                                       }
                                       else
                                       {
                                          §§goto(addr1258);
                                       }
                                    }
                                 }
                              }
                              else if(_loc4_ != 100)
                              {
                                 if(_loc4_ != 108)
                                 {
                                    if(_loc4_ != 112)
                                    {
                                       §§goto(addr589);
                                    }
                                    else
                                    {
                                       addr336:
                                       if(uint(_loc2_) >= uint(256))
                                       {
                                          mstate.esp -= 4;
                                          si32(_loc2_,mstate.esp);
                                          mstate.esp -= 4;
                                          FSM____runetype.start();
                                          _loc2_ = int(mstate.eax);
                                          _loc2_ >>>= 13;
                                          mstate.esp += 4;
                                          _loc2_ &= 1;
                                          if(uint(_loc3_) <= uint(255))
                                          {
                                             §§goto(addr671);
                                          }
                                          else
                                          {
                                             §§goto(addr1258);
                                          }
                                       }
                                       else
                                       {
                                          _loc2_ <<= 2;
                                          _loc2_ = int(_loc1_ + _loc2_);
                                          _loc2_ = int(li32(_loc2_ + 52));
                                          _loc2_ >>>= 13;
                                          _loc2_ &= 1;
                                          if(uint(_loc3_) <= uint(255))
                                          {
                                             §§goto(addr670);
                                          }
                                          else
                                          {
                                             §§goto(addr1258);
                                          }
                                       }
                                       §§goto(addr1258);
                                    }
                                 }
                                 else
                                 {
                                    addr818:
                                    if(uint(_loc2_) >= uint(256))
                                    {
                                       mstate.esp -= 4;
                                       si32(_loc2_,mstate.esp);
                                       mstate.esp -= 4;
                                       FSM____runetype.start();
                                       _loc2_ = int(mstate.eax);
                                       _loc2_ >>>= 12;
                                       mstate.esp += 4;
                                       _loc2_ &= 1;
                                       if(uint(_loc3_) <= uint(255))
                                       {
                                          §§goto(addr670);
                                       }
                                       else
                                       {
                                          §§goto(addr1258);
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ <<= 2;
                                       _loc2_ = int(_loc1_ + _loc2_);
                                       _loc2_ = int(li32(_loc2_ + 52));
                                       _loc2_ >>>= 12;
                                       _loc2_ &= 1;
                                       if(uint(_loc3_) <= uint(255))
                                       {
                                          §§goto(addr670);
                                       }
                                       else
                                       {
                                          §§goto(addr1258);
                                       }
                                    }
                                 }
                              }
                              else
                              {
                                 addr769:
                                 if(uint(_loc2_) <= uint(255))
                                 {
                                    _loc4_ = int(__DefaultRuneLocale);
                                    _loc2_ <<= 2;
                                    _loc2_ = int(_loc4_ + _loc2_);
                                    _loc2_ = int(li32(_loc2_ + 52));
                                    _loc2_ &= 1024;
                                    if(_loc2_ != 0)
                                    {
                                       addr1245:
                                       if(uint(_loc3_) <= uint(255))
                                       {
                                          _loc2_ = 1;
                                          §§goto(addr670);
                                       }
                                       else
                                       {
                                          _loc2_ = 1;
                                          §§goto(addr1258);
                                       }
                                    }
                                    §§goto(addr1258);
                                 }
                                 if(uint(_loc3_) <= uint(255))
                                 {
                                    addr815:
                                    _loc2_ = 0;
                                    §§goto(addr670);
                                 }
                                 else
                                 {
                                    addr1241:
                                    _loc2_ = 0;
                                    §§goto(addr1258);
                                 }
                              }
                           }
                           else if(_loc4_ <= 118)
                           {
                              if(_loc4_ != 115)
                              {
                                 if(_loc4_ != 117)
                                 {
                                    §§goto(addr589);
                                 }
                                 else
                                 {
                                    addr416:
                                    if(uint(_loc2_) >= uint(256))
                                    {
                                       mstate.esp -= 4;
                                       si32(_loc2_,mstate.esp);
                                       mstate.esp -= 4;
                                       FSM____runetype.start();
                                       _loc2_ = int(mstate.eax);
                                       _loc2_ >>>= 15;
                                       mstate.esp += 4;
                                       _loc2_ &= 1;
                                       if(uint(_loc3_) <= uint(255))
                                       {
                                          §§goto(addr671);
                                       }
                                       else
                                       {
                                          §§goto(addr1258);
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ <<= 2;
                                       _loc2_ = int(_loc1_ + _loc2_);
                                       _loc2_ = int(li32(_loc2_ + 52));
                                       _loc2_ >>>= 15;
                                       _loc2_ &= 1;
                                       if(uint(_loc3_) <= uint(255))
                                       {
                                          §§goto(addr670);
                                       }
                                       else
                                       {
                                          §§goto(addr1258);
                                       }
                                    }
                                    §§goto(addr1258);
                                 }
                              }
                              else
                              {
                                 addr951:
                                 if(uint(_loc2_) >= uint(256))
                                 {
                                    mstate.esp -= 4;
                                    si32(_loc2_,mstate.esp);
                                    mstate.esp -= 4;
                                    FSM____runetype.start();
                                    _loc2_ = int(mstate.eax);
                                    _loc2_ >>>= 14;
                                    mstate.esp += 4;
                                    _loc2_ &= 1;
                                    if(uint(_loc3_) <= uint(255))
                                    {
                                       §§goto(addr670);
                                    }
                                    else
                                    {
                                       §§goto(addr1258);
                                    }
                                 }
                                 else
                                 {
                                    _loc2_ <<= 2;
                                    _loc2_ = int(_loc1_ + _loc2_);
                                    _loc2_ = int(li32(_loc2_ + 52));
                                    _loc2_ >>>= 14;
                                    _loc2_ &= 1;
                                    if(uint(_loc3_) <= uint(255))
                                    {
                                       §§goto(addr670);
                                    }
                                    else
                                    {
                                       §§goto(addr1258);
                                    }
                                 }
                              }
                           }
                           else if(_loc4_ != 119)
                           {
                              if(_loc4_ != 120)
                              {
                                 if(_loc4_ != 122)
                                 {
                                    §§goto(addr589);
                                 }
                                 else
                                 {
                                    _loc2_ = int(_loc2_ == 0 ? 1 : 0);
                                    _loc2_ &= 1;
                                    addr496:
                                    if(uint(_loc3_) <= uint(255))
                                    {
                                       §§goto(addr671);
                                    }
                                    else
                                    {
                                       §§goto(addr1258);
                                    }
                                 }
                                 §§goto(addr671);
                              }
                              else
                              {
                                 addr1196:
                                 if(uint(_loc2_) <= uint(255))
                                 {
                                    _loc4_ = int(__DefaultRuneLocale);
                                    _loc2_ <<= 2;
                                    _loc2_ = int(_loc4_ + _loc2_);
                                    _loc2_ = int(li32(_loc2_ + 52));
                                    _loc2_ &= 65536;
                                    if(_loc2_ != 0)
                                    {
                                       §§goto(addr1245);
                                    }
                                    §§goto(addr1258);
                                 }
                                 if(uint(_loc3_) <= uint(255))
                                 {
                                    §§goto(addr815);
                                 }
                                 else
                                 {
                                    §§goto(addr1241);
                                 }
                              }
                           }
                           else
                           {
                              addr1084:
                              if(uint(_loc2_) >= uint(256))
                              {
                                 mstate.esp -= 4;
                                 si32(_loc2_,mstate.esp);
                                 mstate.esp -= 4;
                                 FSM____runetype.start();
                                 _loc2_ = int(mstate.eax);
                                 _loc2_ &= 1280;
                                 _loc2_ = int(_loc2_ != 0 ? 1 : 0);
                                 mstate.esp += 4;
                                 _loc2_ &= 1;
                                 if(uint(_loc3_) <= uint(255))
                                 {
                                    §§goto(addr670);
                                 }
                                 else
                                 {
                                    §§goto(addr1258);
                                 }
                              }
                              else
                              {
                                 _loc2_ <<= 2;
                                 _loc2_ = int(_loc1_ + _loc2_);
                                 _loc2_ = int(li32(_loc2_ + 52));
                                 _loc2_ &= 1280;
                                 _loc2_ = int(_loc2_ != 0 ? 1 : 0);
                                 _loc2_ &= 1;
                                 if(uint(_loc3_) <= uint(255))
                                 {
                                    §§goto(addr670);
                                 }
                                 else
                                 {
                                    §§goto(addr1258);
                                 }
                              }
                           }
                           §§goto(addr1258);
                        }
                     }
                     _loc6_ = _loc7_ << 4;
                     _loc6_ = int(_loc4_ + _loc6_);
                     _loc6_ = int(li32(_loc6_ + 4));
                     if(_loc6_ < _loc3_)
                     {
                        _loc6_ = _loc7_ << 4;
                        _loc4_ = int(_loc6_ + _loc4_);
                        _loc4_ += 16;
                        _loc5_ += -1;
                     }
                     _loc6_ = int(_loc5_ >>> 1);
                     if(uint(_loc5_) < uint(2))
                     {
                        break;
                     }
                     _loc5_ = int(_loc6_);
                  }
               }
            }
            _loc4_ = int(_loc3_);
            §§goto(addr89);
         }
         else
         {
            _loc4_ = _loc3_ << 2;
            _loc4_ = int(_loc1_ + _loc4_);
            _loc4_ = int(li32(_loc4_ + 1076));
            if(_loc4_ <= 114)
            {
               if(_loc4_ <= 99)
               {
                  if(_loc4_ != 97)
                  {
                     if(_loc4_ != 99)
                     {
                        §§goto(addr589);
                     }
                     else
                     {
                        §§goto(addr111);
                     }
                  }
                  else
                  {
                     §§goto(addr606);
                  }
               }
               else if(_loc4_ != 100)
               {
                  if(_loc4_ != 108)
                  {
                     if(_loc4_ != 112)
                     {
                        §§goto(addr589);
                     }
                     else
                     {
                        §§goto(addr336);
                     }
                  }
                  else
                  {
                     §§goto(addr818);
                  }
               }
               else
               {
                  §§goto(addr769);
               }
            }
            else if(_loc4_ <= 118)
            {
               if(_loc4_ != 115)
               {
                  if(_loc4_ != 117)
                  {
                     §§goto(addr589);
                  }
                  else
                  {
                     §§goto(addr416);
                  }
               }
               else
               {
                  §§goto(addr951);
               }
            }
            else if(_loc4_ != 119)
            {
               if(_loc4_ != 120)
               {
                  if(_loc4_ != 122)
                  {
                     §§goto(addr589);
                  }
                  else
                  {
                     §§goto(addr496);
                  }
               }
               else
               {
                  §§goto(addr1196);
               }
            }
            else
            {
               §§goto(addr1084);
            }
            §§goto(addr1258);
         }
      }
   }
}
