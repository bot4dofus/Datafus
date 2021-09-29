package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaT_gettm extends Machine
   {
       
      
      public function FSM_luaT_gettm()
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
         _loc1_ = 1;
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = li8(_loc2_ + 7);
         _loc1_ <<= _loc3_;
         _loc3_ = li32(mstate.ebp + 16);
         _loc4_ = li32(_loc3_ + 8);
         _loc1_ += -1;
         _loc1_ &= _loc4_;
         _loc4_ = li32(_loc2_ + 16);
         _loc1_ *= 28;
         _loc5_ = li32(mstate.ebp + 12);
         _loc1_ = int(_loc4_ + _loc1_);
         do
         {
            _loc4_ = li32(_loc1_ + 20);
            if(_loc4_ == 4)
            {
               _loc4_ = li32(_loc1_ + 12);
               if(_loc4_ == _loc3_)
               {
                  §§goto(addr149);
               }
            }
            _loc1_ = int(li32(_loc1_ + 24));
         }
         while(_loc1_ != 0);
         
         _loc1_ = int(_luaO_nilobject_);
         addr149:
         _loc3_ = li32(_loc1_ + 8);
         if(_loc3_ == 0)
         {
            _loc1_ = 1;
            _loc3_ = li8(_loc2_ + 6);
            _loc1_ <<= _loc5_;
            _loc1_ = _loc3_ | _loc1_;
            si8(_loc1_,_loc2_ + 6);
            _loc1_ = 0;
         }
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
