package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_need_value extends Machine
   {
       
      
      public function FSM_need_value()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 12);
         if(_loc2_ != -1)
         {
            _loc1_ = li32(_loc1_);
            _loc3_ = li32(_loc1_ + 12);
            while(true)
            {
               _loc4_ = _loc2_ << 2;
               _loc4_ = int(_loc3_ + _loc4_);
               if(_loc2_ > 0)
               {
                  _loc5_ = int(_luaP_opmodes);
                  _loc6_ = _loc2_ << 2;
                  _loc6_ += _loc3_;
                  _loc7_ = int(li32(_loc6_ + -4));
                  _loc7_ &= 63;
                  _loc5_ += _loc7_;
                  _loc5_ = int(li8(_loc5_));
                  _loc5_ <<= 24;
                  _loc5_ >>= 24;
                  _loc6_ += -4;
                  _loc4_ = int(_loc5_ > -1 ? int(_loc4_) : int(_loc6_));
               }
               _loc4_ = int(li32(_loc4_));
               _loc4_ &= 63;
               if(_loc4_ != 27)
               {
                  _loc1_ = 1;
                  break;
               }
               _loc4_ = int(li32(_loc1_ + 12));
               _loc5_ = _loc2_ << 2;
               _loc4_ += _loc5_;
               _loc4_ = int(li32(_loc4_));
               _loc4_ >>>= 14;
               _loc4_ += -131071;
               if(_loc4_ == -1)
               {
                  _loc2_ = -1;
               }
               else
               {
                  _loc2_ += _loc4_;
                  _loc2_ += 1;
               }
               if(_loc2_ != -1)
               {
                  continue;
               }
            }
            §§goto(addr74);
         }
         _loc1_ = 0;
         addr74:
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
