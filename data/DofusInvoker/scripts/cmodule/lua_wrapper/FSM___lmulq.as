package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___lmulq extends Machine
   {
       
      
      public function FSM___lmulq()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = int(li32(mstate.ebp + 12));
         _loc3_ = _loc2_ & 65535;
         _loc4_ = _loc1_ & 65535;
         _loc5_ = _loc3_ * _loc4_;
         _loc6_ = int(_loc2_ >>> 16);
         _loc7_ = _loc1_ >>> 16;
         if(uint(_loc2_) <= uint(65535))
         {
            if(uint(_loc1_) <= uint(65535))
            {
               _loc3_ = 0;
               mstate.edx = _loc3_;
               mstate.eax = _loc5_;
            }
            else
            {
               _loc1_ = uint(_loc7_) < uint(_loc4_) ? int(_loc4_) : int(_loc7_);
               _loc2_ = int(uint(_loc7_) < uint(_loc4_) ? int(_loc7_) : int(_loc4_));
               _loc8_ = uint(_loc3_) < uint(_loc6_) ? int(_loc6_) : int(_loc3_);
               _loc9_ = uint(_loc3_) < uint(_loc6_) ? int(_loc3_) : int(_loc6_);
               _loc10_ = _loc6_ * _loc7_;
               _loc8_ -= _loc9_;
               _loc1_ -= _loc2_;
               _loc2_ = int(_loc10_ >>> 16);
               _loc1_ = _loc8_ * _loc1_;
               _loc4_ = int(uint(_loc7_) < uint(_loc4_) ? 1 : 0);
               _loc3_ = int(uint(_loc3_) < uint(_loc6_) ? 1 : 0);
               _loc3_ ^= _loc4_;
               _loc4_ = _loc1_ << 16;
               _loc6_ = _loc10_ << 16;
               _loc2_ += _loc10_;
               _loc3_ ^= 1;
               _loc3_ &= 1;
               addr149:
               if(_loc3_ == 0)
               {
                  _loc4_ = int(_loc6_ - _loc4_);
                  _loc6_ = int(uint(_loc4_) > uint(_loc6_) ? 1 : 0);
                  _loc1_ >>>= 16;
                  _loc6_ &= 1;
                  _loc1_ = _loc2_ - _loc1_;
                  _loc1_ -= _loc6_;
                  _loc2_ = int(_loc4_);
               }
               else
               {
                  _loc3_ = int(_loc4_ + _loc6_);
                  _loc4_ = int(uint(_loc3_) < uint(_loc6_) ? 1 : 0);
                  _loc1_ >>>= 16;
                  _loc4_ &= 1;
                  _loc1_ += _loc2_;
                  _loc1_ += _loc4_;
                  _loc2_ = int(_loc3_);
               }
               _loc3_ = _loc5_ << 16;
               _loc3_ = int(_loc2_ + _loc3_);
               _loc2_ = int(uint(_loc3_) < uint(_loc2_) ? 1 : 0);
               _loc3_ += _loc5_;
               _loc4_ = int(_loc5_ >>> 16);
               _loc5_ = uint(_loc3_) < uint(_loc5_) ? 1 : 0;
               _loc2_ &= 1;
               _loc1_ += _loc4_;
               _loc4_ = _loc5_ & 1;
               _loc1_ += _loc2_;
               _loc1_ += _loc4_;
               mstate.edx = _loc1_;
               mstate.eax = _loc3_;
            }
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr149);
      }
   }
}
