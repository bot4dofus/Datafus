package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_getthread extends Machine
   {
       
      
      public function FSM_getthread()
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
         _loc1_ = 1;
         mstate.esp -= 8;
         _loc2_ = li32(mstate.ebp + 8);
         si32(_loc2_,mstate.esp);
         si32(_loc1_,mstate.esp + 4);
         mstate.esp -= 4;
         FSM_index2adr.start();
         _loc1_ = mstate.eax;
         mstate.esp += 8;
         _loc3_ = li32(mstate.ebp + 12);
         _loc4_ = _luaO_nilobject_;
         if(_loc1_ != _loc4_)
         {
            _loc1_ = li32(_loc1_ + 8);
            if(_loc1_ == 8)
            {
               _loc1_ = 1;
               si32(_loc1_,_loc3_);
               mstate.esp -= 8;
               si32(_loc2_,mstate.esp);
               si32(_loc1_,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               _loc2_ = mstate.eax;
               mstate.esp += 8;
               _loc3_ = li32(_loc2_ + 8);
               if(_loc3_ == 8)
               {
                  _loc2_ = li32(_loc2_);
               }
               else
               {
                  _loc2_ = 0;
               }
            }
            else
            {
               addr224:
               _loc1_ = 0;
               si32(_loc1_,_loc3_);
            }
            mstate.eax = _loc2_;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr224);
      }
   }
}
