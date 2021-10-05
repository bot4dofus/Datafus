package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_malloc_pages extends Machine
   {
       
      
      public function FSM_malloc_pages()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         _loc1_ += 4095;
         _loc2_ = int(li32(_free_list));
         _loc3_ = _loc1_ & -4096;
         if(_loc2_ != 0)
         {
            _loc1_ = int(_loc2_);
            while(true)
            {
               _loc2_ = int(li32(_loc1_ + 16));
               _loc4_ = _loc1_ + 16;
               if(uint(_loc2_) >= uint(_loc3_))
               {
                  _loc5_ = li32(_loc1_ + 8);
                  _loc6_ = int(_loc1_ + 8);
                  if(_loc2_ == _loc3_)
                  {
                     _loc2_ = int(li32(_loc1_));
                     _loc4_ = _loc1_;
                     if(_loc2_ != 0)
                     {
                        _loc6_ = int(li32(_loc1_ + 4));
                        si32(_loc6_,_loc2_ + 4);
                     }
                     _loc2_ = int(li32(_loc1_ + 4));
                     _loc4_ = li32(_loc4_);
                     si32(_loc4_,_loc2_);
                     _loc2_ = int(_loc3_ >>> 12);
                     if(_loc5_ == 0)
                     {
                        break;
                     }
                     _loc4_ = _loc5_;
                  }
                  else
                  {
                     _loc1_ = int(_loc5_ + _loc3_);
                     si32(_loc1_,_loc6_);
                     _loc1_ = int(_loc2_ - _loc3_);
                     si32(_loc1_,_loc4_);
                     _loc2_ = int(_loc3_ >>> 12);
                     if(_loc5_ == 0)
                     {
                        _loc1_ = 0;
                        break;
                     }
                     _loc1_ = 0;
                     _loc4_ = _loc5_;
                  }
                  §§goto(addr465);
               }
               _loc1_ = int(li32(_loc1_));
               if(_loc1_ != 0)
               {
                  continue;
               }
            }
            addr217:
            _loc4_ = _loc1_;
            _loc5_ = _loc2_;
            _loc1_ = 0;
            _loc1_ = int(_sbrk(_loc1_));
            _loc1_ += 4095;
            _loc6_ = _loc1_ & -4096;
            _loc1_ = int(_loc6_ + _loc3_);
            if(uint(_loc1_) >= uint(_loc6_))
            {
               _loc2_ = int(_loc1_);
               _loc2_ = int(_brk(_loc2_));
               if(_loc2_ == 0)
               {
                  _loc2_ = int(_loc1_ >>> 12);
                  _loc7_ = li32(_malloc_origo);
                  _loc2_ += -1;
                  _loc7_ = _loc2_ - _loc7_;
                  si32(_loc7_,_last_index);
                  si32(_loc1_,_malloc_brk);
                  _loc1_ = int(li32(_malloc_ninfo));
                  _loc2_ = int(_loc7_ + 1);
                  if(uint(_loc2_) < uint(_loc1_))
                  {
                     _loc1_ = int(_loc4_);
                     _loc2_ = int(_loc5_);
                     _loc4_ = _loc6_;
                  }
                  else
                  {
                     _loc1_ = int(__2E_str210);
                     _loc2_ = 4;
                     _loc8_ = 0;
                     log(_loc2_,mstate.gworker.stringFromPtr(_loc1_));
                     _loc1_ = int(_sbrk(_loc8_));
                     _loc1_ &= 4095;
                     _loc1_ = int(4096 - _loc1_);
                     _loc2_ = int(_loc7_ >>> 9);
                     _loc1_ &= 4095;
                     _loc2_ &= 1048575;
                     _loc2_ += 2;
                     _loc1_ = int(_sbrk(_loc1_));
                     _loc1_ = _loc2_ << 12;
                     _loc1_ = int(_sbrk(_loc1_));
                     _loc7_ = _loc1_;
                     if(_loc1_ != -1)
                     {
                        _loc8_ = int(__2E_str19);
                        _loc9_ = int(li32(_malloc_ninfo));
                        _loc10_ = li32(_page_dir);
                        _loc9_ <<= 2;
                        _loc2_ <<= 10;
                        memcpy(_loc1_,_loc10_,_loc9_);
                        _loc1_ = _loc2_ & 1073740800;
                        si32(_loc1_,_malloc_ninfo);
                        si32(_loc7_,_page_dir);
                        _loc2_ = 4;
                        _loc1_ = int(_loc8_);
                        log(_loc2_,mstate.gworker.stringFromPtr(_loc1_));
                        _loc1_ = int(_loc4_);
                        _loc2_ = int(_loc5_);
                        _loc4_ = _loc6_;
                     }
                     else
                     {
                        addr254:
                        _loc6_ = 0;
                        _loc1_ = int(_loc4_);
                        _loc2_ = int(_loc5_);
                        _loc4_ = _loc6_;
                        addr253:
                     }
                  }
                  addr465:
                  if(_loc4_ != 0)
                  {
                     _loc5_ = 2;
                     _loc6_ = int(li32(_malloc_origo));
                     _loc7_ = _loc4_ >>> 12;
                     _loc8_ = int(_loc7_ - _loc6_);
                     _loc9_ = int(li32(_page_dir));
                     _loc8_ <<= 2;
                     _loc8_ = int(_loc9_ + _loc8_);
                     si32(_loc5_,_loc8_);
                     if(uint(_loc2_) >= uint(2))
                     {
                        _loc5_ = 0;
                        _loc6_ = int(_loc7_ - _loc6_);
                        _loc6_ <<= 2;
                        _loc6_ += _loc9_;
                        _loc6_ += 4;
                        _loc2_ += -1;
                        do
                        {
                           _loc7_ = 3;
                           si32(_loc7_,_loc6_);
                           _loc6_ += 4;
                           _loc5_ += 1;
                        }
                        while(_loc5_ != _loc2_);
                        
                     }
                     _loc2_ = int(li8(_malloc_junk_2E_b));
                     _loc2_ ^= 1;
                     _loc2_ &= 1;
                     if(_loc2_ == 0)
                     {
                        _loc2_ = -48;
                        _loc5_ = _loc4_;
                        memset(_loc5_,_loc2_,_loc3_);
                     }
                  }
                  if(_loc1_ != 0)
                  {
                     _loc2_ = int(li32(_px));
                     if(_loc2_ == 0)
                     {
                        si32(_loc1_,_px);
                     }
                     else
                     {
                        mstate.esp -= 4;
                        si32(_loc1_,mstate.esp);
                        mstate.esp -= 4;
                        FSM_ifree.start();
                        mstate.esp += 4;
                     }
                  }
                  mstate.eax = _loc4_;
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  return;
               }
               §§goto(addr253);
            }
            §§goto(addr254);
         }
         _loc1_ = 0;
         _loc2_ = int(_loc3_ >>> 12);
         §§goto(addr217);
      }
   }
}
