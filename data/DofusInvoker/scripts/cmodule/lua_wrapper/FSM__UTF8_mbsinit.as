package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM__UTF8_mbsinit extends Machine
   {
       
      
      public function FSM__UTF8_mbsinit()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         if(_loc1_ != 0)
         {
            _loc1_ = int(li32(_loc1_ + 4));
            _loc1_ = int(_loc1_ == 0 ? 1 : 0);
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
      }
   }
}
