package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___get_locale_env extends Machine
   {
       
      
      public function FSM___get_locale_env()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = __2E_str31162;
         mstate.esp -= 4;
         si32(_loc1_,mstate.esp);
         mstate.esp -= 4;
         FSM_getenv.start();
         _loc1_ = mstate.eax;
         mstate.esp += 4;
         _loc2_ = int(li32(mstate.ebp + 8));
         if(_loc1_ != 0)
         {
            _loc3_ = li8(_loc1_);
            if(_loc3_ != 0)
            {
               _loc2_ = int(_loc1_);
            }
            else
            {
               addr103:
               _loc1_ = _categories;
               _loc2_ <<= 2;
               _loc2_ = int(_loc1_ + _loc2_);
               _loc2_ = int(li32(_loc2_));
               mstate.esp -= 4;
               si32(_loc2_,mstate.esp);
               mstate.esp -= 4;
               FSM_getenv.start();
               _loc2_ = int(mstate.eax);
               mstate.esp += 4;
            }
            _loc1_ = _loc2_;
            if(_loc1_ != 0)
            {
               _loc2_ = int(li8(_loc1_));
               if(_loc2_ == 0)
               {
                  addr173:
                  _loc1_ = __2E_str738;
                  mstate.esp -= 4;
                  si32(_loc1_,mstate.esp);
                  mstate.esp -= 4;
                  FSM_getenv.start();
                  _loc1_ = mstate.eax;
                  mstate.esp += 4;
               }
               if(_loc1_ != 0)
               {
                  _loc2_ = int(__2E_str3149);
                  _loc3_ = li8(_loc1_);
                  _loc1_ = _loc3_ == 0 ? int(_loc2_) : int(_loc1_);
               }
               else
               {
                  _loc1_ = __2E_str3149;
               }
               mstate.eax = _loc1_;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
            §§goto(addr173);
         }
         §§goto(addr103);
      }
   }
}
