package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_lua_topointer extends Machine
   {
       
      
      public function FSM_lua_topointer()
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
         _loc1_ = _luaO_nilobject_;
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = li32(_loc2_ + 8);
         _loc4_ = li32(_loc2_ + 12);
         _loc1_ = uint(_loc3_) > uint(_loc4_) ? int(_loc4_) : int(_loc1_);
         _loc3_ = li32(_loc1_ + 8);
         if(_loc3_ <= 5)
         {
            if(_loc3_ != 2)
            {
               if(_loc3_ != 5)
               {
                  addr200:
                  _loc1_ = 0;
                  addr199:
               }
               else
               {
                  addr99:
                  _loc1_ = li32(_loc1_);
               }
            }
            else
            {
               addr126:
               _loc1_ = 1;
               mstate.esp -= 8;
               si32(_loc2_,mstate.esp);
               si32(_loc1_,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               _loc1_ = mstate.eax;
               mstate.esp += 8;
               _loc2_ = li32(_loc1_ + 8);
               if(_loc2_ != 2)
               {
                  if(_loc2_ == 7)
                  {
                     _loc1_ = li32(_loc1_);
                     _loc1_ += 20;
                  }
                  else
                  {
                     §§goto(addr200);
                  }
               }
               else
               {
                  §§goto(addr99);
                  addr198:
               }
            }
            §§goto(addr202);
         }
         else if(_loc3_ != 6)
         {
            if(_loc3_ != 7)
            {
               if(_loc3_ != 8)
               {
                  §§goto(addr199);
               }
               else
               {
                  _loc2_ = li32(_loc1_);
                  mstate.eax = _loc2_;
               }
               §§goto(addr202);
            }
            else
            {
               §§goto(addr126);
            }
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr198);
      }
   }
}
