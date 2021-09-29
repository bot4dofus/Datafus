package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___udivdi3 extends Machine
   {
       
      
      public function FSM___udivdi3()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = 0;
         mstate.esp -= 20;
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = li32(mstate.ebp + 12);
         _loc4_ = li32(mstate.ebp + 16);
         _loc5_ = li32(mstate.ebp + 20);
         si32(_loc2_,mstate.esp);
         si32(_loc3_,mstate.esp + 4);
         si32(_loc4_,mstate.esp + 8);
         si32(_loc5_,mstate.esp + 12);
         si32(_loc1_,mstate.esp + 16);
         mstate.esp -= 4;
         FSM___qdivrem.start();
         _loc1_ = mstate.eax;
         _loc2_ = mstate.edx;
         mstate.esp += 20;
         mstate.edx = _loc2_;
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
