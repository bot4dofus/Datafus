package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_aux_upvalue extends Machine
   {
       
      
      public function FSM_aux_upvalue()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = int(li32(mstate.ebp + 12));
         _loc3_ = li32(mstate.ebp + 16);
         _loc4_ = li32(_loc1_ + 8);
         if(_loc4_ == 6)
         {
            _loc1_ = li32(_loc1_);
            _loc4_ = li8(_loc1_ + 6);
            _loc5_ = _loc1_;
            if(_loc4_ != 0)
            {
               if(_loc2_ >= 1)
               {
                  _loc5_ = li8(_loc1_ + 7);
                  if(_loc5_ >= _loc2_)
                  {
                     _loc5_ = __2E_str45;
                     _loc2_ *= 12;
                     _loc2_ += _loc1_;
                     _loc2_ += 8;
                     si32(_loc2_,_loc3_);
                     mstate.eax = _loc5_;
                  }
                  else
                  {
                     addr208:
                     _loc1_ = 0;
                     mstate.eax = _loc1_;
                  }
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  return;
               }
            }
            else
            {
               _loc1_ = li32(_loc5_ + 16);
               _loc4_ = _loc5_;
               if(_loc2_ >= 1)
               {
                  _loc5_ = li32(_loc1_ + 36);
                  if(_loc5_ >= _loc2_)
                  {
                     _loc2_ += -1;
                     _loc2_ <<= 2;
                     _loc4_ += _loc2_;
                     _loc4_ = li32(_loc4_ + 20);
                     _loc4_ = li32(_loc4_ + 8);
                     si32(_loc4_,_loc3_);
                     _loc1_ = li32(_loc1_ + 28);
                     _loc1_ += _loc2_;
                     _loc1_ = li32(_loc1_);
                     _loc1_ += 16;
                  }
                  else
                  {
                     §§goto(addr208);
                  }
                  §§goto(addr208);
               }
            }
         }
         §§goto(addr208);
      }
   }
}
