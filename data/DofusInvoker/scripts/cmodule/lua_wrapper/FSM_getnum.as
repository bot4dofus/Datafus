package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_getnum extends Machine
   {
       
      
      public function FSM_getnum()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = li32(mstate.ebp + 16);
         _loc4_ = li32(mstate.ebp + 20);
         _loc5_ = _loc1_;
         if(_loc1_ != 0)
         {
            _loc1_ = int(li8(_loc1_));
            _loc6_ = _loc1_ << 24;
            _loc6_ >>= 24;
            _loc6_ += -48;
            if(uint(_loc6_) <= uint(9))
            {
               _loc6_ = 0;
               while(true)
               {
                  _loc1_ <<= 24;
                  _loc1_ >>= 24;
                  _loc6_ *= 10;
                  _loc1_ = int(_loc6_ + _loc1_);
                  _loc1_ += -48;
                  if(_loc1_ <= _loc4_)
                  {
                     _loc7_ = li8(_loc5_ + 1);
                     _loc5_ += 1;
                     _loc6_ = _loc7_ << 24;
                     _loc6_ >>= 24;
                     _loc8_ = _loc5_;
                     _loc6_ += -48;
                     if(uint(_loc6_) > uint(9))
                     {
                        if(_loc1_ >= _loc3_)
                        {
                           si32(_loc1_,_loc2_);
                           mstate.eax = _loc5_;
                           §§goto(addr201);
                        }
                     }
                     continue;
                     break;
                  }
                  break;
               }
            }
         }
         _loc1_ = 0;
         mstate.eax = _loc1_;
         addr201:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
