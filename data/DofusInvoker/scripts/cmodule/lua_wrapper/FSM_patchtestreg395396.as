package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_patchtestreg395396 extends Machine
   {
       
      
      public function FSM_patchtestreg395396()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 12));
         _loc2_ = int(li32(mstate.ebp + 8));
         _loc3_ = _loc1_ << 2;
         _loc4_ = int(li32(mstate.ebp + 16));
         _loc3_ = int(_loc2_ + _loc3_);
         if(_loc1_ <= 0)
         {
            _loc1_ = int(_loc3_);
         }
         else
         {
            _loc5_ = _luaP_opmodes;
            _loc1_ <<= 2;
            _loc1_ += _loc2_;
            _loc2_ = int(li32(_loc1_ + -4));
            _loc2_ &= 63;
            _loc2_ = int(_loc5_ + _loc2_);
            _loc2_ = int(li8(_loc2_));
            _loc2_ <<= 24;
            _loc2_ >>= 24;
            _loc1_ += -4;
            _loc1_ = int(_loc2_ > -1 ? int(_loc3_) : int(_loc1_));
         }
         _loc2_ = int(li32(_loc1_));
         _loc3_ = _loc2_ & 63;
         if(_loc3_ == 27)
         {
            if(_loc4_ != 255)
            {
               _loc3_ = int(_loc2_ >>> 23);
               if(_loc3_ != _loc4_)
               {
                  _loc3_ = 1;
                  _loc4_ <<= 6;
                  _loc4_ &= 16320;
                  _loc2_ &= -16321;
                  _loc2_ |= _loc4_;
               }
               else
               {
                  addr192:
                  _loc3_ = 1;
                  _loc4_ = _loc2_ | 26;
                  _loc2_ >>>= 17;
                  _loc4_ &= 8372250;
                  _loc2_ &= 32704;
                  _loc2_ = _loc4_ | _loc2_;
               }
               si32(_loc2_,_loc1_);
               mstate.eax = _loc3_;
               §§goto(addr222);
            }
            §§goto(addr192);
         }
         else
         {
            _loc1_ = 0;
            mstate.eax = _loc1_;
         }
         addr222:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
