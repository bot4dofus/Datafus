package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_lua_getmetatable extends Machine
   {
       
      
      public function FSM_lua_getmetatable()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         mstate.esp -= 8;
         _loc2_ = li32(mstate.ebp + 12);
         si32(_loc1_,mstate.esp);
         si32(_loc2_,mstate.esp + 4);
         mstate.esp -= 4;
         FSM_index2adr.start();
         _loc2_ = mstate.eax;
         mstate.esp += 8;
         _loc3_ = int(li32(_loc2_ + 8));
         if(_loc3_ != 7)
         {
            if(_loc3_ == 5)
            {
               _loc2_ = li32(_loc2_);
               _loc2_ = li32(_loc2_ + 8);
               if(_loc2_ != 0)
               {
                  addr170:
                  _loc3_ = 5;
                  _loc4_ = li32(_loc1_ + 8);
                  si32(_loc2_,_loc4_);
                  si32(_loc3_,_loc4_ + 8);
                  _loc2_ = li32(_loc1_ + 8);
                  _loc2_ += 12;
                  si32(_loc2_,_loc1_ + 8);
                  _loc1_ = 1;
               }
               else
               {
                  addr205:
                  _loc1_ = 0;
               }
               §§goto(addr207);
            }
            else
            {
               _loc2_ = li32(_loc1_ + 16);
               _loc3_ <<= 2;
               _loc2_ += _loc3_;
               _loc2_ = li32(_loc2_ + 132);
               if(_loc2_ != 0)
               {
                  §§goto(addr170);
               }
               else
               {
                  §§goto(addr205);
               }
            }
         }
         else
         {
            _loc2_ = li32(_loc2_);
            _loc2_ = li32(_loc2_ + 8);
            if(_loc2_ != 0)
            {
               §§goto(addr170);
            }
            else
            {
               §§goto(addr205);
            }
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr205);
      }
   }
}
