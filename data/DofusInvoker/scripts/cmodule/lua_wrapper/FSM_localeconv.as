package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_localeconv extends Machine
   {
       
      
      public function FSM_localeconv()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li8(___mlocale_changed_2E_b);
         if(_loc1_ == 0)
         {
            _loc1_ = 1;
            si8(_loc1_,___mlocale_changed_2E_b);
         }
         _loc1_ = li8(___nlocale_changed_2E_b);
         if(_loc1_ == 0)
         {
            _loc1_ = __C_numeric_locale;
            _loc2_ = li32(__numeric_using_locale);
            _loc3_ = __numeric_locale;
            _loc1_ = _loc2_ == 0 ? int(_loc1_) : int(_loc3_);
            _loc2_ = li32(_loc1_);
            si32(_loc2_,_ret_2E_1494_2E_0);
            _loc2_ = li32(_loc1_ + 4);
            si32(_loc2_,_ret_2E_1494_2E_1);
            _loc1_ = li32(_loc1_ + 8);
            si32(_loc1_,_ret_2E_1494_2E_2);
            _loc1_ = 1;
            si8(_loc1_,___nlocale_changed_2E_b);
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
