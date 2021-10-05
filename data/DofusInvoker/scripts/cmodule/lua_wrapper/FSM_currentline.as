package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_currentline extends Machine
   {
       
      
      public function FSM_currentline()
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
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 12));
         _loc2_ = li32(_loc1_ + 4);
         _loc3_ = li32(_loc2_ + 8);
         _loc4_ = li32(mstate.ebp + 8);
         if(_loc3_ == 6)
         {
            _loc3_ = li32(_loc2_);
            _loc3_ = li8(_loc3_ + 6);
            _loc5_ = _loc2_;
            if(_loc3_ == 0)
            {
               _loc3_ = li32(_loc4_ + 20);
               if(_loc3_ == _loc1_)
               {
                  _loc3_ = li32(_loc4_ + 24);
                  si32(_loc3_,_loc1_ + 12);
               }
               _loc3_ = li32(_loc5_);
               _loc3_ = li32(_loc3_ + 16);
               _loc1_ = int(li32(_loc1_ + 12));
               _loc3_ = li32(_loc3_ + 12);
               _loc1_ -= _loc3_;
               _loc1_ >>= 2;
               _loc1_ += -1;
            }
            else
            {
               addr76:
               _loc1_ = -1;
            }
            if(_loc1_ <= -1)
            {
               _loc1_ = -1;
            }
            else
            {
               _loc2_ = li32(_loc2_);
               _loc2_ = li32(_loc2_ + 16);
               _loc2_ = li32(_loc2_ + 20);
               if(_loc2_ == 0)
               {
                  _loc1_ = 0;
               }
               else
               {
                  _loc1_ <<= 2;
                  _loc1_ = int(_loc2_ + _loc1_);
                  _loc1_ = int(li32(_loc1_));
               }
            }
            mstate.eax = _loc1_;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr76);
      }
   }
}
