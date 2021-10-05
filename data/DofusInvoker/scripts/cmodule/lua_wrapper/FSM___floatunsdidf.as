package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___floatunsdidf extends Machine
   {
       
      
      public function FSM___floatunsdidf()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 12);
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = Number(uint(_loc1_));
         _loc4_ = Number(uint(_loc2_));
         _loc3_ *= 4294970000;
         _loc3_ = _loc4_ + _loc3_;
         mstate.st0 = _loc3_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
