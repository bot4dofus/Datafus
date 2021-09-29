package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM__UTF8_mbrtowc extends Machine
   {
       
      
      public function FSM__UTF8_mbrtowc()
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
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 20));
         _loc2_ = int(li32(_loc1_ + 4));
         _loc3_ = _loc1_ + 4;
         _loc4_ = li32(mstate.ebp + 8);
         _loc5_ = int(li32(mstate.ebp + 12));
         _loc6_ = li32(mstate.ebp + 16);
         _loc7_ = _loc1_;
         if(uint(_loc2_) >= uint(7))
         {
            _loc1_ = 22;
            addr114:
            si32(_loc1_,_val_2E_1440);
            _loc1_ = -1;
            addr165:
            mstate.eax = _loc1_;
            addr122:
         }
         else
         {
            _loc8_ = __2E_str45;
            _loc8_ = _loc5_ == 0 ? int(_loc8_) : int(_loc5_);
            _loc6_ = _loc5_ == 0 ? 1 : int(_loc6_);
            _loc4_ = _loc5_ == 0 ? 0 : int(_loc4_);
            if(_loc6_ == 0)
            {
               _loc1_ = -2;
               §§goto(addr165);
            }
            else
            {
               if(_loc2_ == 0)
               {
                  _loc5_ = int(li8(_loc8_));
                  _loc9_ = _loc5_ & 128;
                  _loc10_ = _loc5_;
                  if(_loc9_ == 0)
                  {
                     _loc1_ = _loc5_ & 255;
                     _loc1_ = int(_loc1_ != 0 ? 1 : 0);
                     _loc1_ &= 1;
                     if(_loc4_ != 0)
                     {
                        si32(_loc10_,_loc4_);
                        addr121:
                        §§goto(addr122);
                     }
                     §§goto(addr165);
                  }
                  else
                  {
                     if(_loc2_ == 0)
                     {
                        if(_loc9_ == 0)
                        {
                           _loc10_ = 0;
                           _loc5_ = 1;
                           _loc9_ = 127;
                           addr358:
                           if(_loc2_ == 0)
                           {
                              _loc2_ = int(_loc2_ == 0 ? 1 : 0);
                              _loc11_ = int(li8(_loc8_));
                              _loc2_ &= 1;
                              _loc8_ += 1;
                              _loc9_ = _loc11_ & _loc9_;
                              _loc11_ = int(uint(_loc6_) <= uint(_loc5_) ? int(_loc6_) : int(_loc5_));
                              if(uint(_loc2_) >= uint(_loc11_))
                              {
                                 _loc8_ = _loc9_;
                              }
                              else
                              {
                                 loop0:
                                 while(true)
                                 {
                                    _loc11_ = int(li8(_loc8_));
                                    _loc12_ = _loc11_ & 192;
                                    if(_loc12_ != 128)
                                    {
                                       _loc2_ = 86;
                                       si32(_loc2_,_val_2E_1440);
                                       _loc2_ = -1;
                                       mstate.eax = _loc2_;
                                    }
                                    else
                                    {
                                       _loc11_ &= 63;
                                       _loc9_ <<= 6;
                                       _loc2_ += 1;
                                       _loc8_ += 1;
                                       _loc9_ = _loc11_ | _loc9_;
                                       while(true)
                                       {
                                          _loc11_ = int(uint(_loc6_) <= uint(_loc5_) ? int(_loc6_) : int(_loc5_));
                                          if(uint(_loc2_) < uint(_loc11_))
                                          {
                                             continue loop0;
                                          }
                                          _loc8_ = _loc9_;
                                          _loc6_ = _loc8_;
                                          if(_loc2_ < _loc5_)
                                          {
                                             _loc4_ = -2;
                                             _loc5_ -= _loc2_;
                                             si32(_loc5_,_loc3_);
                                             si32(_loc10_,_loc7_ + 8);
                                             si32(_loc6_,_loc1_);
                                             mstate.eax = _loc4_;
                                             break;
                                          }
                                          if(_loc6_ < _loc10_)
                                          {
                                             addr542:
                                             _loc1_ = 86;
                                             §§goto(addr114);
                                          }
                                          else
                                          {
                                             if(_loc4_ != 0)
                                             {
                                                _loc1_ = 0;
                                                si32(_loc6_,_loc4_);
                                             }
                                             else
                                             {
                                                _loc1_ = 0;
                                             }
                                             si32(_loc1_,_loc3_);
                                             _loc1_ = int(_loc6_ == 0 ? 0 : int(_loc5_));
                                             §§goto(addr121);
                                          }
                                       }
                                       addr481:
                                    }
                                    break;
                                 }
                                 §§goto(addr172);
                              }
                              §§goto(addr507);
                           }
                           else
                           {
                              _loc2_ = int(_loc2_ == 0 ? 1 : 0);
                              _loc9_ = int(li32(_loc1_));
                              _loc2_ &= 1;
                           }
                           §§goto(addr481);
                        }
                        else
                        {
                           _loc5_ = _loc10_ & 224;
                           if(_loc5_ == 192)
                           {
                              _loc10_ = 128;
                              _loc5_ = 2;
                              _loc9_ = 31;
                              §§goto(addr358);
                           }
                           else
                           {
                              _loc5_ = _loc10_ & 240;
                              if(_loc5_ == 224)
                              {
                                 _loc10_ = 2048;
                                 _loc5_ = 3;
                                 _loc9_ = 15;
                                 §§goto(addr358);
                              }
                              else
                              {
                                 _loc5_ = _loc10_ & 248;
                                 if(_loc5_ == 240)
                                 {
                                    _loc10_ = 65536;
                                    _loc5_ = 4;
                                    _loc9_ = 7;
                                    §§goto(addr358);
                                 }
                                 else
                                 {
                                    _loc5_ = _loc10_ & 252;
                                    if(_loc5_ == 248)
                                    {
                                       _loc10_ = 2097152;
                                       _loc5_ = 5;
                                       _loc9_ = 3;
                                       §§goto(addr358);
                                    }
                                    else
                                    {
                                       _loc5_ = _loc10_ & 254;
                                       if(_loc5_ == 252)
                                       {
                                          _loc10_ = 67108864;
                                          _loc5_ = 6;
                                          _loc9_ = 1;
                                          §§goto(addr358);
                                       }
                                    }
                                 }
                              }
                           }
                        }
                        §§goto(addr542);
                     }
                     else
                     {
                        addr346:
                        _loc10_ = li32(_loc7_ + 8);
                        _loc9_ = int(_loc5_);
                        _loc5_ = int(_loc2_);
                     }
                     §§goto(addr358);
                  }
               }
               §§goto(addr346);
            }
         }
         addr172:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
