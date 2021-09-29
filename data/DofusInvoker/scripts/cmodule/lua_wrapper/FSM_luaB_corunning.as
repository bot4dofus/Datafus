package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_corunning extends Machine
   {
       
      
      public function FSM_luaB_corunning()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = 8;
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = li32(_loc2_ + 8);
         si32(_loc2_,_loc3_);
         si32(_loc1_,_loc3_ + 8);
         _loc1_ = li32(_loc2_ + 8);
         _loc3_ = _loc1_ + 12;
         si32(_loc3_,_loc2_ + 8);
         _loc3_ = li32(_loc2_ + 16);
         _loc3_ = li32(_loc3_ + 104);
         _loc4_ = _loc2_ + 8;
         if(_loc3_ == _loc2_)
         {
            _loc2_ = 0;
            si32(_loc2_,_loc1_ + 20);
            _loc1_ = li32(_loc4_);
            _loc1_ += 12;
            si32(_loc1_,_loc4_);
         }
         _loc1_ = 1;
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
