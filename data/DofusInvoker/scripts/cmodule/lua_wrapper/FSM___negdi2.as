package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___negdi2 extends Machine
   {
       
      
      public function FSM___negdi2()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = 0;
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = li32(mstate.ebp + 12);
         _loc4_ = int(_loc2_ != 0 ? 1 : 0);
         _loc3_ = __subc(_loc1_,_loc3_);
         _loc4_ &= 1;
         _loc1_ = __subc(_loc1_,_loc2_);
         _loc2_ = __subc(_loc3_,_loc4_);
         mstate.edx = _loc2_;
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
