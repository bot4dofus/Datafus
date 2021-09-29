package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___quorem_D2A extends Machine
   {
       
      
      public function FSM___quorem_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = int(li32(mstate.ebp + 12));
         _loc3_ = int(li32(_loc2_ + 16));
         _loc4_ = li32(_loc1_ + 16);
         _loc5_ = _loc1_ + 16;
         _loc6_ = _loc2_ + 16;
         _loc7_ = _loc2_;
         _loc8_ = _loc1_;
         if(_loc4_ < _loc3_)
         {
            _loc1_ = 0;
            addr133:
            mstate.eax = _loc1_;
         }
         else
         {
            _loc9_ = _loc3_ + -1;
            _loc10_ = _loc9_ << 2;
            _loc11_ = int(_loc2_ + _loc10_);
            _loc11_ = int(li32(_loc11_ + 20));
            _loc10_ = int(_loc1_ + _loc10_);
            _loc12_ = int(li32(_loc10_ + 20));
            _loc11_ += 1;
            _loc10_ += 20;
            _loc11_ = int(uint(_loc12_) / uint(_loc11_));
            if(_loc11_ != 0)
            {
               _loc12_ = 20;
               _loc13_ = 0;
               _loc14_ = _loc13_;
               _loc15_ = int(_loc13_);
               _loc16_ = _loc13_;
               _loc17_ = _loc11_;
               _loc18_ = _loc15_;
               _loc19_ = _loc14_;
               while(true)
               {
                  _loc20_ = 0;
                  _loc21_ = _loc7_ + _loc12_;
                  mstate.esp -= 16;
                  _loc21_ = li32(_loc21_);
                  si32(_loc21_,mstate.esp);
                  si32(_loc20_,mstate.esp + 4);
                  si32(_loc17_,mstate.esp + 8);
                  si32(_loc13_,mstate.esp + 12);
                  mstate.esp -= 4;
                  mstate.funcs[___muldi3]();
                  _loc21_ = mstate.eax;
                  _loc22_ = mstate.edx;
                  _loc23_ = _loc8_ + _loc12_;
                  _loc24_ = li32(_loc23_);
                  _loc15_ = int(__addc(_loc21_,_loc15_));
                  _loc14_ = __adde(_loc22_,_loc14_);
                  _loc15_ = int(__subc(_loc24_,_loc15_));
                  _loc21_ = __sube(_loc20_,_loc20_);
                  _loc15_ = int(__subc(_loc15_,_loc18_));
                  _loc18_ = __sube(_loc21_,_loc19_);
                  si32(_loc15_,_loc23_);
                  _loc15_ = _loc18_ & 1;
                  _loc12_ += 4;
                  _loc16_ += 1;
                  mstate.esp += 16;
                  _loc19_ = _loc20_;
                  if(_loc16_ > _loc9_)
                  {
                     break;
                  }
                  _loc18_ = _loc15_;
                  _loc15_ = int(_loc14_);
                  _loc14_ = _loc20_;
               }
               _loc10_ = int(li32(_loc10_));
               if(_loc10_ == 0)
               {
                  _loc4_ = _loc3_ + -2;
                  if(_loc4_ <= 0)
                  {
                     _loc3_ = int(_loc9_);
                  }
                  else
                  {
                     _loc10_ = 0;
                     _loc12_ = _loc3_ << 2;
                     _loc12_ = int(_loc8_ + _loc12_);
                     _loc12_ += 12;
                     _loc3_ += -1;
                     while(true)
                     {
                        _loc13_ = _loc12_;
                        _loc12_ = int(_loc3_);
                        _loc3_ = int(_loc10_);
                        _loc10_ = int(li32(_loc13_));
                        if(_loc10_ != 0)
                        {
                           _loc3_ = int(_loc12_);
                           break;
                        }
                        _loc10_ = int(_loc13_ + -4);
                        _loc13_ = _loc12_ + -1;
                        _loc14_ = _loc3_ + 1;
                        _loc3_ ^= -1;
                        _loc3_ = int(_loc4_ + _loc3_);
                        if(_loc3_ <= 0)
                        {
                           _loc3_ = int(_loc13_);
                           break;
                        }
                        _loc12_ = int(_loc10_);
                        _loc3_ = int(_loc13_);
                        _loc10_ = int(_loc14_);
                     }
                  }
                  _loc4_ = _loc3_;
                  si32(_loc4_,_loc5_);
                  _loc3_ = int(_loc4_);
               }
               else
               {
                  addr195:
                  _loc3_ = int(_loc4_);
                  _loc4_ = _loc9_;
               }
               _loc6_ = li32(_loc6_);
               _loc10_ = int(_loc3_ - _loc6_);
               if(_loc3_ != _loc6_)
               {
                  _loc2_ = int(_loc10_);
               }
               else
               {
                  _loc3_ = 0;
                  while(true)
                  {
                     _loc10_ = _loc3_ ^ -1;
                     _loc10_ = int(_loc6_ + _loc10_);
                     _loc12_ = _loc10_ << 2;
                     _loc13_ = _loc1_ + _loc12_;
                     _loc12_ = int(_loc2_ + _loc12_);
                     _loc13_ = li32(_loc13_ + 20);
                     _loc12_ = int(li32(_loc12_ + 20));
                     if(_loc13_ != _loc12_)
                     {
                        _loc2_ = int(uint(_loc13_) < uint(_loc12_) ? -1 : 1);
                        break;
                     }
                     _loc3_ += 1;
                     if(_loc10_ <= 0)
                     {
                        _loc2_ = 0;
                        break;
                     }
                  }
               }
               if(_loc2_ <= -1)
               {
                  _loc1_ = _loc11_;
                  addr132:
                  §§goto(addr133);
               }
               else
               {
                  _loc2_ = 0;
                  _loc3_ = 20;
                  _loc6_ = _loc11_ + 1;
                  _loc10_ = int(_loc2_);
                  _loc11_ = int(_loc2_);
                  _loc12_ = int(_loc11_);
                  _loc13_ = _loc10_;
                  while(true)
                  {
                     _loc14_ = 0;
                     _loc15_ = int(_loc7_ + _loc3_);
                     _loc15_ = int(li32(_loc15_));
                     _loc16_ = _loc8_ + _loc3_;
                     _loc17_ = li32(_loc16_);
                     _loc11_ = int(__addc(_loc15_,_loc11_));
                     _loc10_ = int(__adde(_loc10_,_loc14_));
                     _loc11_ = int(__subc(_loc17_,_loc11_));
                     _loc15_ = int(__sube(_loc14_,_loc14_));
                     _loc11_ = int(__subc(_loc11_,_loc12_));
                     _loc12_ = int(__sube(_loc15_,_loc13_));
                     si32(_loc11_,_loc16_);
                     _loc11_ = _loc12_ & 1;
                     _loc3_ += 4;
                     _loc2_ += 1;
                     _loc13_ = _loc14_;
                     if(_loc2_ > _loc9_)
                     {
                        break;
                     }
                     _loc12_ = int(_loc11_);
                     _loc11_ = int(_loc10_);
                     _loc10_ = int(_loc14_);
                  }
                  _loc2_ = _loc4_ << 2;
                  _loc2_ = int(_loc1_ + _loc2_);
                  _loc2_ = int(li32(_loc2_ + 20));
                  if(_loc2_ != 0)
                  {
                     _loc1_ = _loc6_;
                     §§goto(addr132);
                  }
                  else
                  {
                     _loc2_ = 0;
                     while(true)
                     {
                        _loc3_ = _loc2_ ^ -1;
                        _loc3_ = int(_loc4_ + _loc3_);
                        if(_loc3_ < 1)
                        {
                           break;
                        }
                        _loc3_ <<= 2;
                        _loc3_ = int(_loc1_ + _loc3_);
                        _loc3_ = int(li32(_loc3_ + 20));
                        if(_loc3_ != 0)
                        {
                           break;
                        }
                        _loc2_ += 1;
                     }
                     _loc1_ = _loc4_ - _loc2_;
                     si32(_loc1_,_loc5_);
                     mstate.eax = _loc6_;
                     §§goto(addr783);
                  }
               }
               §§goto(addr783);
            }
            §§goto(addr195);
         }
         addr783:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
