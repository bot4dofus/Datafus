package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___moddi3 extends Machine
   {
       
      
      public function FSM___moddi3()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 8;
         _loc1_ = mstate.ebp + -8;
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = int(li32(mstate.ebp + 20));
         _loc4_ = int(li32(mstate.ebp + 8));
         _loc5_ = _loc2_ >> 31;
         _loc6_ = int(li32(mstate.ebp + 16));
         _loc7_ = _loc3_ >> 31;
         _loc4_ = int(__addc(_loc4_,_loc5_));
         _loc8_ = __adde(_loc2_,_loc5_);
         _loc6_ = int(__addc(_loc6_,_loc7_));
         _loc3_ = int(__adde(_loc3_,_loc7_));
         mstate.esp -= 20;
         _loc3_ ^= _loc7_;
         _loc6_ ^= _loc7_;
         _loc7_ = _loc8_ ^ _loc5_;
         _loc4_ ^= _loc5_;
         si32(_loc4_,mstate.esp);
         si32(_loc7_,mstate.esp + 4);
         si32(_loc6_,mstate.esp + 8);
         si32(_loc3_,mstate.esp + 12);
         si32(_loc1_,mstate.esp + 16);
         mstate.esp -= 4;
         FSM___qdivrem.start();
         _loc1_ = mstate.eax;
         _loc1_ = mstate.edx;
         mstate.esp += 20;
         _loc1_ = li32(mstate.ebp + -8);
         _loc3_ = int(li32(mstate.ebp + -4));
         if(_loc2_ <= -1)
         {
            _loc2_ = 0;
            _loc1_ = __subc(_loc2_,_loc1_);
            _loc3_ = int(__sube(_loc2_,_loc3_));
         }
         mstate.edx = _loc3_;
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
