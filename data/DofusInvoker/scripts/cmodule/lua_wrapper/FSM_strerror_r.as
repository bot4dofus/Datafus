package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_strerror_r extends Machine
   {
       
      
      public function FSM_strerror_r()
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
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 48;
         _loc1_ = int(mstate.ebp + -48);
         _loc2_ = int(li32(mstate.ebp + 8));
         _loc3_ = int(li32(mstate.ebp + 12));
         _loc4_ = li32(mstate.ebp + 16);
         _loc5_ = _loc3_;
         _loc6_ = int(_loc2_ + -1);
         if(uint(_loc6_) >= uint(92))
         {
            _loc6_ = 0;
            _loc7_ = _loc2_ >> 31;
            _loc8_ = _loc2_ + _loc7_;
            si8(_loc6_,mstate.ebp + -13);
            _loc6_ = _loc8_ ^ _loc7_;
            _loc7_ = -1;
            while(true)
            {
               _loc8_ = __2E_str2661;
               _loc9_ = uint(_loc6_) / uint(10);
               _loc10_ = _loc9_ * 10;
               _loc10_ = _loc6_ - _loc10_;
               _loc8_ += _loc10_;
               _loc8_ = li8(_loc8_);
               si8(_loc8_,_loc1_ + 34);
               _loc1_ += -1;
               _loc7_ += 1;
               if(uint(_loc6_) < uint(10))
               {
                  break;
               }
               _loc6_ = int(_loc9_);
            }
            if(_loc2_ >= 0)
            {
               _loc2_ = int(_loc1_ + 35);
            }
            else
            {
               _loc2_ = int(mstate.ebp + -48);
               _loc1_ = int(33 - _loc7_);
               _loc6_ = 45;
               _loc2_ += _loc1_;
               si8(_loc6_,_loc2_);
            }
            _loc1_ = 32;
            si8(_loc1_,_loc2_ + -1);
            _loc1_ = 58;
            si8(_loc1_,_loc2_ + -2);
            mstate.esp -= 12;
            _loc1_ = int(__2E_str393);
            si32(_loc3_,mstate.esp);
            si32(_loc1_,mstate.esp + 4);
            si32(_loc4_,mstate.esp + 8);
            mstate.esp -= 4;
            FSM_strlcpy.start();
            _loc1_ = int(mstate.eax);
            mstate.esp += 12;
            _loc1_ = int(_loc2_ + -2);
            if(_loc4_ != 0)
            {
               _loc3_ = 0;
               _loc6_ = int(_loc4_ + -1);
               while(true)
               {
                  _loc7_ = int(_loc5_ + _loc3_);
                  _loc7_ = int(li8(_loc7_));
                  if(_loc7_ == 0)
                  {
                     _loc3_ = int(_loc5_ + _loc3_);
                     break;
                  }
                  _loc7_ = int(_loc3_ + 1);
                  if(_loc6_ == _loc3_)
                  {
                     _loc3_ = int(_loc5_ + _loc7_);
                  }
                  _loc3_ = int(_loc7_);
               }
            }
            _loc5_ = _loc3_ - _loc5_;
            _loc1_ = int(li8(_loc1_));
            _loc6_ = int(_loc4_ - _loc5_);
            if(_loc5_ != _loc4_)
            {
               _loc1_ &= 255;
               if(_loc1_ != 0)
               {
                  _loc1_ = int(_loc6_);
                  do
                  {
                     if(_loc1_ != 1)
                     {
                        _loc4_ = li8(_loc2_ + -2);
                        si8(_loc4_,_loc3_);
                        _loc1_ += -1;
                        _loc3_ += 1;
                     }
                     _loc4_ = li8(_loc2_ + -1);
                     _loc2_ += 1;
                  }
                  while(_loc4_ != 0);
                  
                  _loc2_ = int(_loc3_);
               }
               else
               {
                  _loc2_ = int(_loc3_);
               }
               _loc3_ = 0;
               si8(_loc3_,_loc2_);
            }
            else
            {
               _loc3_ = _loc1_ & 255;
               if(_loc3_ != 0)
               {
                  _loc2_ += -1;
                  do
                  {
                     _loc3_ = int(li8(_loc2_));
                     _loc2_ += 1;
                  }
                  while(_loc3_ != 0);
                  
               }
            }
            _loc2_ = 22;
            mstate.eax = _loc2_;
         }
         else
         {
            _loc1_ = int(_sys_errlist);
            _loc2_ <<= 2;
            _loc1_ += _loc2_;
            _loc1_ = int(li32(_loc1_));
            mstate.esp -= 12;
            si32(_loc3_,mstate.esp);
            si32(_loc1_,mstate.esp + 4);
            si32(_loc4_,mstate.esp + 8);
            mstate.esp -= 4;
            FSM_strlcpy.start();
            _loc1_ = int(mstate.eax);
            mstate.esp += 12;
            _loc1_ = int(uint(_loc1_) < uint(_loc4_) ? 0 : 34);
            mstate.eax = _loc1_;
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
