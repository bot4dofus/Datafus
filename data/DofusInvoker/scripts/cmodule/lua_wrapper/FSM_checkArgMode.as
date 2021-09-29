package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_checkArgMode extends Machine
   {
       
      
      public function FSM_checkArgMode()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         _loc2_ = int(li32(mstate.ebp + 12));
         _loc3_ = int(li32(mstate.ebp + 16));
         if(_loc3_ != 3)
         {
            if(_loc3_ != 2)
            {
               if(_loc3_ == 0)
               {
                  _loc1_ = int(_loc2_ == 0 ? 1 : 0);
                  addr102:
                  _loc1_ &= 1;
               }
               else
               {
                  _loc1_ = 1;
               }
               mstate.eax = _loc1_;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
            addr86:
            _loc1_ = int(li8(_loc1_ + 75));
            _loc1_ = int(_loc1_ > _loc2_ ? 1 : 0);
         }
         else
         {
            _loc3_ = _loc2_ & 256;
            if(_loc3_ != 0)
            {
               _loc1_ = int(li32(_loc1_ + 40));
               _loc2_ &= -257;
               _loc1_ = int(_loc2_ < _loc1_ ? 1 : 0);
            }
            else
            {
               §§goto(addr86);
            }
         }
         §§goto(addr102);
      }
   }
}
