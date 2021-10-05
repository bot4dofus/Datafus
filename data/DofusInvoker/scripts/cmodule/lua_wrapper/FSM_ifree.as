package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_ifree extends Machine
   {
       
      
      public function FSM_ifree()
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
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         while(true)
         {
            _loc3_ = int(_loc1_);
            if(_loc3_ == 0)
            {
               break;
            }
            _loc1_ = int(li32(_malloc_origo));
            _loc2_ = int(_loc3_ >>> 12);
            _loc4_ = int(_loc2_ - _loc1_);
            _loc5_ = int(_loc3_);
            if(uint(_loc4_) < uint(12))
            {
               break;
            }
            _loc6_ = int(li32(_last_index));
            if(uint(_loc4_) > uint(_loc6_))
            {
               break;
            }
            _loc6_ = int(li32(_page_dir));
            _loc7_ = _loc4_ << 2;
            _loc7_ = int(_loc6_ + _loc7_);
            _loc8_ = int(li32(_loc7_));
            _loc9_ = _loc6_;
            if(uint(_loc8_) <= uint(3))
            {
               if(_loc8_ == 2)
               {
                  if(_loc8_ != 1)
                  {
                     _loc5_ &= 4095;
                     if(_loc5_ == 0)
                     {
                        _loc5_ = 1;
                        _loc8_ = _loc4_ << 2;
                        si32(_loc5_,_loc7_);
                        _loc5_ = int(_loc8_ + _loc9_);
                        _loc5_ = int(li32(_loc5_ + 4));
                        if(_loc5_ != 3)
                        {
                           _loc1_ = 4096;
                        }
                        else
                        {
                           _loc5_ = 1;
                           _loc1_ = int(_loc2_ - _loc1_);
                           _loc1_ <<= 2;
                           _loc8_ = int(_loc6_);
                           do
                           {
                              _loc2_ = 1;
                              _loc4_ = int(_loc1_ + _loc8_);
                              si32(_loc2_,_loc4_ + 4);
                              _loc2_ = int(li32(_loc4_ + 8));
                              _loc8_ += 4;
                              _loc5_ += 1;
                           }
                           while(_loc2_ == 3);
                           
                           _loc1_ = _loc5_ << 12;
                        }
                        _loc5_ = int(_loc1_);
                        _loc1_ = int(li8(_malloc_junk_2E_b));
                        _loc1_ ^= 1;
                        _loc1_ &= 1;
                        if(_loc1_ == 0)
                        {
                           _loc1_ = -48;
                           _loc8_ = int(_loc3_);
                           _loc2_ = int(_loc5_);
                           memset(_loc8_,_loc1_,_loc2_);
                        }
                        _loc1_ = int(li8(_malloc_hint_2E_b));
                        _loc1_ ^= 1;
                        _loc1_ &= 1;
                        if(_loc1_ == 0)
                        {
                           _loc1_ = int(__2E_str8);
                           _loc8_ = 4;
                           _loc2_ = int(_loc8_);
                           log(_loc2_,mstate.gworker.stringFromPtr(_loc1_));
                        }
                        _loc1_ = int(li32(_px));
                        _loc8_ = int(_loc3_ + _loc5_);
                        if(_loc1_ != 0)
                        {
                           _loc2_ = int(_loc1_);
                        }
                        else
                        {
                           _loc1_ = 20;
                           mstate.esp -= 4;
                           si32(_loc1_,mstate.esp);
                           mstate.esp -= 4;
                           FSM_imalloc.start();
                           _loc1_ = int(mstate.eax);
                           mstate.esp += 4;
                           si32(_loc1_,_px);
                           _loc2_ = int(_loc1_);
                        }
                        si32(_loc3_,_loc1_ + 8);
                        si32(_loc8_,_loc2_ + 12);
                        si32(_loc5_,_loc2_ + 16);
                        _loc1_ = int(li32(_free_list));
                        if(_loc1_ == 0)
                        {
                           _loc5_ = int(_free_list);
                           si32(_loc1_,_loc2_);
                           si32(_loc5_,_loc2_ + 4);
                           si32(_loc2_,_free_list);
                           _loc1_ = 0;
                           si32(_loc1_,_px);
                           _loc1_ = int(li32(_loc2_));
                           if(_loc1_ != 0)
                           {
                              _loc1_ = 0;
                           }
                           else
                           {
                              _loc1_ = 0;
                              _loc5_ = int(_loc2_);
                              addr741:
                              _loc3_ = int(_loc5_);
                              _loc5_ = int(li32(_loc3_ + 16));
                              _loc8_ = int(li32(_malloc_cache));
                              _loc2_ = int(_loc3_ + 16);
                              if(uint(_loc5_) > uint(_loc8_))
                              {
                                 _loc5_ = int(li32(_loc3_ + 12));
                                 _loc8_ = int(li32(_malloc_brk));
                                 _loc4_ = int(_loc3_ + 12);
                                 if(_loc5_ == _loc8_)
                                 {
                                    _loc5_ = 0;
                                    _loc5_ = int(_sbrk(_loc5_));
                                    _loc8_ = int(li32(_malloc_brk));
                                    if(_loc5_ == _loc8_)
                                    {
                                       _loc3_ = int(li32(_loc3_ + 8));
                                       _loc5_ = int(li32(_malloc_cache));
                                       _loc3_ += _loc5_;
                                       si32(_loc3_,_loc4_);
                                       si32(_loc5_,_loc2_);
                                       _loc3_ = int(_brk(_loc3_));
                                       _loc3_ = int(li32(_loc4_));
                                       si32(_loc3_,_malloc_brk);
                                       _loc5_ = int(li32(_malloc_origo));
                                       _loc8_ = int(li32(_last_index));
                                       _loc3_ >>>= 12;
                                       _loc2_ = int(_loc3_ - _loc5_);
                                       if(uint(_loc2_) <= uint(_loc8_))
                                       {
                                          _loc3_ -= _loc5_;
                                          _loc5_ = int(li32(_page_dir));
                                          _loc4_ = _loc3_ << 2;
                                          _loc5_ += _loc4_;
                                          do
                                          {
                                             _loc4_ = 0;
                                             si32(_loc4_,_loc5_);
                                             _loc5_ += 4;
                                             _loc3_ += 1;
                                          }
                                          while(uint(_loc3_) <= uint(_loc8_));
                                          
                                       }
                                       _loc3_ = int(_loc2_ + -1);
                                       si32(_loc3_,_last_index);
                                       addr926:
                                       if(_loc1_ == 0)
                                       {
                                          break;
                                       }
                                       continue;
                                    }
                                    §§goto(addr926);
                                 }
                              }
                           }
                           §§goto(addr926);
                        }
                        else
                        {
                           _loc4_ = int(li32(_loc1_ + 12));
                           if(uint(_loc4_) < uint(_loc3_))
                           {
                              do
                              {
                                 _loc4_ = int(_loc1_);
                                 _loc1_ = int(li32(_loc4_));
                                 if(_loc1_ == 0)
                                 {
                                    _loc1_ = int(_loc4_);
                                    break;
                                 }
                                 _loc4_ = int(li32(_loc1_ + 12));
                              }
                              while(uint(_loc4_) < uint(_loc3_));
                              
                           }
                           _loc4_ = int(li32(_loc1_ + 8));
                           _loc6_ = int(_loc1_ + 8);
                           if(uint(_loc4_) > uint(_loc8_))
                           {
                              _loc5_ = 0;
                              si32(_loc1_,_loc2_);
                              _loc8_ = int(li32(_loc1_ + 4));
                              si32(_loc8_,_loc2_ + 4);
                              si32(_loc2_,_loc1_ + 4);
                              _loc1_ = int(li32(_loc2_ + 4));
                              si32(_loc2_,_loc1_);
                              si32(_loc5_,_px);
                              _loc1_ = int(_loc2_);
                           }
                           else
                           {
                              _loc7_ = int(li32(_loc1_ + 12));
                              _loc9_ = _loc1_ + 12;
                              if(_loc7_ == _loc3_)
                              {
                                 _loc8_ = int(_loc7_ + _loc5_);
                                 si32(_loc8_,_loc9_);
                                 _loc2_ = int(li32(_loc1_ + 16));
                                 _loc5_ = int(_loc2_ + _loc5_);
                                 si32(_loc5_,_loc1_ + 16);
                                 _loc2_ = int(li32(_loc1_));
                                 _loc3_ = int(_loc1_ + 16);
                                 _loc4_ = int(_loc1_);
                                 if(_loc2_ != 0)
                                 {
                                    _loc6_ = int(li32(_loc2_ + 8));
                                    if(_loc8_ == _loc6_)
                                    {
                                       _loc8_ = int(li32(_loc2_ + 12));
                                       si32(_loc8_,_loc9_);
                                       _loc8_ = int(li32(_loc2_ + 16));
                                       _loc5_ = int(_loc8_ + _loc5_);
                                       si32(_loc5_,_loc3_);
                                       _loc5_ = int(li32(_loc2_));
                                       si32(_loc5_,_loc4_);
                                       if(_loc5_ == 0)
                                       {
                                          _loc5_ = int(_loc2_);
                                          addr720:
                                          _loc3_ = int(_loc5_);
                                          _loc5_ = int(li32(_loc1_));
                                          if(_loc5_ != 0)
                                          {
                                             _loc1_ = int(_loc3_);
                                          }
                                          else
                                          {
                                             _loc5_ = int(_loc1_);
                                             _loc1_ = int(_loc3_);
                                             §§goto(addr741);
                                          }
                                          §§goto(addr926);
                                       }
                                       else
                                       {
                                          si32(_loc1_,_loc5_ + 4);
                                          _loc5_ = int(_loc2_);
                                          §§goto(addr720);
                                       }
                                    }
                                    else
                                    {
                                       addr595:
                                    }
                                    §§goto(addr720);
                                 }
                                 _loc5_ = 0;
                              }
                              else if(_loc4_ == _loc8_)
                              {
                                 _loc2_ = 0;
                                 _loc8_ = int(li32(_loc1_ + 16));
                                 _loc5_ = int(_loc8_ + _loc5_);
                                 si32(_loc5_,_loc1_ + 16);
                                 si32(_loc3_,_loc6_);
                                 _loc5_ = int(_loc2_);
                              }
                              else
                              {
                                 _loc5_ = int(li32(_loc1_));
                                 _loc3_ = int(_loc1_);
                                 if(_loc5_ == 0)
                                 {
                                    _loc5_ = 0;
                                    si32(_loc5_,_loc2_);
                                    si32(_loc1_,_loc2_ + 4);
                                    si32(_loc2_,_loc3_);
                                    si32(_loc5_,_px);
                                    _loc1_ = int(_loc2_);
                                 }
                              }
                              §§goto(addr720);
                           }
                           §§goto(addr720);
                        }
                     }
                     break;
                  }
                  break;
               }
               break;
            }
            _loc1_ = int(li16(_loc8_ + 8));
            _loc2_ = int(li16(_loc8_ + 10));
            _loc4_ = _loc5_ & 4095;
            _loc2_ = int(_loc4_ >>> _loc2_);
            _loc4_ = int(_loc8_ + 10);
            _loc6_ = int(_loc1_ + -1);
            _loc5_ = _loc6_ & _loc5_;
            if(_loc5_ != 0)
            {
               break;
            }
            _loc5_ = 1;
            _loc6_ = _loc2_ & -32;
            _loc6_ >>>= 3;
            _loc6_ = int(_loc8_ + _loc6_);
            _loc2_ &= 31;
            _loc7_ = int(li32(_loc6_ + 16));
            _loc2_ = _loc5_ << _loc2_;
            _loc5_ = int(_loc6_ + 16);
            _loc6_ = _loc7_ & _loc2_;
            if(_loc6_ != 0)
            {
               break;
            }
            _loc6_ = int(li8(_malloc_junk_2E_b));
            _loc6_ ^= 1;
            _loc6_ &= 1;
            if(_loc6_ == 0)
            {
               _loc6_ = -48;
               memset(_loc3_,_loc6_,_loc1_);
            }
            _loc1_ = int(li32(_loc5_));
            _loc1_ |= _loc2_;
            si32(_loc1_,_loc5_);
            _loc1_ = int(li16(_loc8_ + 12));
            _loc2_ = int(_loc1_ + 1);
            si16(_loc2_,_loc8_ + 12);
            _loc3_ = int(li16(_loc4_));
            _loc4_ = int(li32(_page_dir));
            _loc3_ <<= 2;
            _loc3_ = int(_loc4_ + _loc3_);
            if(_loc1_ == 0)
            {
               _loc1_ = int(li32(_loc3_));
               if(_loc1_ == 0)
               {
                  _loc1_ = int(_loc3_);
               }
               else
               {
                  _loc1_ = int(_loc8_ + 4);
                  _loc2_ = int(_loc3_);
                  while(true)
                  {
                     _loc3_ = int(li32(_loc2_));
                     _loc4_ = int(li32(_loc3_));
                     if(_loc4_ == 0)
                     {
                        _loc1_ = int(_loc2_);
                        break;
                     }
                     _loc5_ = int(li32(_loc4_ + 4));
                     _loc6_ = int(li32(_loc1_));
                     _loc2_ = int(uint(_loc5_) < uint(_loc6_) ? int(_loc3_) : int(_loc2_));
                     _loc5_ = int(uint(_loc5_) >= uint(_loc6_) ? 1 : 0);
                     if(_loc4_ != 0)
                     {
                        _loc4_ = _loc5_ & 1;
                        if(_loc4_ == 0)
                        {
                           continue;
                        }
                     }
                     _loc1_ = int(_loc2_);
                     break;
                  }
               }
               _loc2_ = int(li32(_loc1_));
               si32(_loc2_,_loc8_);
               si32(_loc8_,_loc1_);
               break;
            }
            _loc1_ = int(li16(_loc8_ + 14));
            _loc2_ &= 65535;
            if(_loc2_ != _loc1_)
            {
               break;
            }
            _loc1_ = int(li32(_loc3_));
            if(_loc1_ != _loc8_)
            {
               _loc1_ = int(_loc3_);
               do
               {
                  _loc1_ = int(li32(_loc1_));
                  _loc2_ = int(li32(_loc1_));
               }
               while(_loc2_ != _loc8_);
               
            }
            else
            {
               _loc1_ = int(_loc3_);
            }
            _loc2_ = 2;
            _loc3_ = int(li32(_loc8_));
            si32(_loc3_,_loc1_);
            _loc1_ = int(li32(_loc8_ + 4));
            _loc3_ = int(li32(_malloc_origo));
            _loc1_ >>>= 12;
            _loc1_ -= _loc3_;
            _loc1_ <<= 2;
            _loc1_ = int(_loc4_ + _loc1_);
            si32(_loc2_,_loc1_);
            _loc1_ = int(li32(_loc8_ + 4));
            _loc2_ = int(_loc8_);
            if(_loc1_ != _loc8_)
            {
               mstate.esp -= 4;
               si32(_loc2_,mstate.esp);
               mstate.esp -= 4;
               FSM_ifree.start();
               mstate.esp += 4;
            }
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
