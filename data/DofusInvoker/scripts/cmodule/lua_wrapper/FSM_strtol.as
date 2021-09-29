package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_strtol extends Machine
   {
       
      
      public function FSM_strtol()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = 0;
         _loc2_ = li32(__CurrentRuneLocale);
         _loc3_ = int(li32(mstate.ebp + 8));
         _loc4_ = int(_loc3_);
         do
         {
            _loc5_ = int(_loc4_ + _loc1_);
            _loc5_ = int(li8(_loc5_));
            _loc6_ = _loc5_ << 2;
            _loc6_ = int(_loc2_ + _loc6_);
            _loc6_ = int(li32(_loc6_ + 52));
            _loc1_ += 1;
            _loc6_ &= 16384;
         }
         while(_loc6_ != 0);
         
         _loc2_ = _loc3_ + _loc1_;
         _loc4_ = _loc5_ & 255;
         if(_loc4_ != 43)
         {
            _loc4_ = _loc5_ & 255;
            if(_loc4_ != 45)
            {
               _loc1_ = 1;
               _loc3_ = int(_loc5_);
            }
            else
            {
               _loc4_ = 0;
               _loc1_ <<= 0;
               _loc1_ += _loc3_;
               _loc3_ = int(li8(_loc2_));
               _loc2_ = _loc1_ + 1;
               _loc1_ = int(_loc4_);
            }
         }
         else
         {
            _loc4_ = 1;
            _loc1_ <<= 0;
            _loc1_ += _loc3_;
            _loc3_ = int(li8(_loc2_));
            _loc2_ = _loc1_ + 1;
            _loc1_ = int(_loc4_);
         }
         _loc4_ = 0;
         _loc5_ = _loc1_ & 1;
         _loc5_ = int(_loc5_ != 0 ? 2147483647 : -2147483648);
         _loc6_ = int(uint(_loc5_) / uint(10));
         _loc7_ = _loc6_ * 10;
         _loc7_ = _loc5_ - _loc7_;
         _loc8_ = int(_loc4_);
         loop1:
         while(true)
         {
            _loc9_ = int(_loc3_ + -48);
            _loc9_ &= 255;
            if(uint(_loc9_) >= uint(10))
            {
               loop2:
               while(true)
               {
                  _loc9_ = int(_loc3_ + -65);
                  _loc9_ &= 255;
                  if(uint(_loc9_) > uint(25))
                  {
                     _loc9_ = int(_loc3_ + -97);
                     _loc9_ &= 255;
                     if(uint(_loc9_) <= uint(25))
                     {
                        _loc3_ += -87;
                        _loc9_ = _loc3_ << 24;
                        _loc9_ >>= 24;
                        if(_loc9_ <= 9)
                        {
                           loop3:
                           while(_loc4_ >= 0)
                           {
                              if(uint(_loc8_) > uint(_loc6_))
                              {
                                 break;
                              }
                              if(_loc8_ == _loc6_)
                              {
                                 _loc4_ = _loc3_ << 24;
                                 _loc4_ >>= 24;
                                 if(_loc4_ > _loc7_)
                                 {
                                    break;
                                 }
                              }
                              _loc3_ <<= 24;
                              _loc3_ >>= 24;
                              _loc8_ *= 10;
                              _loc4_ = int(li8(_loc2_));
                              _loc2_ += 1;
                              _loc3_ = int(_loc8_ + _loc3_);
                              _loc8_ = int(_loc4_ + -48);
                              _loc8_ &= 255;
                              if(uint(_loc8_) >= uint(10))
                              {
                                 continue loop2;
                              }
                              addr298:
                              _loc9_ = 1;
                              _loc8_ = int(_loc3_);
                              _loc3_ = int(_loc4_);
                              _loc4_ = int(_loc9_);
                              while(true)
                              {
                                 _loc3_ += -48;
                                 _loc9_ = _loc3_ << 24;
                                 _loc9_ >>= 24;
                                 if(_loc9_ >= 10)
                                 {
                                    _loc2_ = _loc8_;
                                    _loc3_ = int(_loc4_);
                                    §§goto(addr322);
                                 }
                                 continue loop3;
                              }
                           }
                           continue loop1;
                           addr374:
                        }
                     }
                     break;
                  }
                  _loc3_ += -55;
                  _loc9_ = _loc3_ << 24;
                  _loc9_ >>= 24;
                  if(_loc9_ >= 10)
                  {
                     break;
                  }
                  §§goto(addr374);
               }
               _loc2_ = _loc8_;
               _loc3_ = int(_loc4_);
               addr322:
               if(_loc3_ <= -1)
               {
                  _loc1_ = 34;
                  si32(_loc1_,_val_2E_1440);
                  mstate.eax = _loc5_;
               }
               else if(_loc3_ == 0)
               {
                  _loc1_ = 22;
                  si32(_loc1_,_val_2E_1440);
                  mstate.eax = _loc2_;
               }
               else
               {
                  _loc1_ &= 1;
                  _loc3_ = int(0 - _loc2_);
                  _loc1_ = int(_loc1_ != 0 ? int(_loc2_) : int(_loc3_));
                  mstate.eax = _loc1_;
               }
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
            §§goto(addr298);
         }
      }
   }
}
