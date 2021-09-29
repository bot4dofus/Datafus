package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_countint389 extends Machine
   {
       
      
      public function FSM_countint389()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc5_ = lf64(mstate.ebp + 8);
         _loc1_ = li32(mstate.ebp + 20);
         _loc2_ = int(li32(mstate.ebp + 16));
         if(_loc2_ != 3)
         {
            _loc2_ = -2;
         }
         else
         {
            _loc2_ = int(int(_loc5_));
            _loc3_ = int(_loc2_ + -1);
            _loc6_ = Number(_loc2_);
            _loc2_ = int(_loc6_ == _loc5_ ? int(_loc3_) : -2);
         }
         if(uint(_loc2_) <= uint(67108863))
         {
            if(uint(_loc2_) <= uint(255))
            {
               _loc3_ = -1;
            }
            else
            {
               _loc3_ = -1;
               do
               {
                  _loc3_ += 1;
                  _loc2_ >>>= 8;
               }
               while(uint(_loc2_) >= uint(256));
               
               _loc3_ <<= 3;
               _loc3_ |= 7;
            }
            _loc4_ = _log_2_2E_3461;
            _loc2_ = int(_loc4_ + _loc2_);
            _loc2_ = int(li8(_loc2_));
            _loc2_ += _loc3_;
            _loc2_ <<= 2;
            _loc1_ = _loc2_ + _loc1_;
            _loc2_ = int(li32(_loc1_ + 4));
            _loc2_ += 1;
            si32(_loc2_,_loc1_ + 4);
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = 0;
         }
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
