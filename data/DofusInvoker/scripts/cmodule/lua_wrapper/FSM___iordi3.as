package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___iordi3 extends Machine
   {
       
      
      public function FSM___iordi3()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 16));
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = int(li32(mstate.ebp + 12));
         _loc4_ = li32(mstate.ebp + 20);
         _loc3_ |= _loc4_;
         _loc1_ |= _loc2_;
         mstate.edx = _loc3_;
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
