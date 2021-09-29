package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_get_compTM extends Machine
   {
       
      
      public function FSM_get_compTM()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = int(li32(mstate.ebp + 12));
         _loc3_ = li32(mstate.ebp + 16);
         if(_loc2_ != 0)
         {
            _loc4_ = int(li8(_loc2_ + 6));
            _loc4_ &= 16;
            if(_loc4_ == 0)
            {
               _loc4_ = 4;
               _loc5_ = li32(_loc1_ + 16);
               _loc5_ = li32(_loc5_ + 184);
               mstate.esp -= 12;
               si32(_loc2_,mstate.esp);
               si32(_loc4_,mstate.esp + 4);
               si32(_loc5_,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaT_gettm.start();
               _loc4_ = int(mstate.eax);
               mstate.esp += 12;
            }
            else
            {
               addr73:
               _loc4_ = 0;
            }
            if(_loc4_ != 0)
            {
               if(_loc2_ == _loc3_)
               {
                  _loc1_ = _loc4_;
               }
               else
               {
                  if(_loc3_ != 0)
                  {
                     _loc2_ = int(li8(_loc3_ + 6));
                     _loc2_ &= 16;
                     if(_loc2_ == 0)
                     {
                        _loc2_ = 4;
                        _loc1_ = li32(_loc1_ + 16);
                        _loc1_ = li32(_loc1_ + 184);
                        mstate.esp -= 12;
                        si32(_loc3_,mstate.esp);
                        si32(_loc2_,mstate.esp + 4);
                        si32(_loc1_,mstate.esp + 8);
                        mstate.esp -= 4;
                        FSM_luaT_gettm.start();
                        _loc1_ = mstate.eax;
                        mstate.esp += 12;
                     }
                     else
                     {
                        addr182:
                        _loc1_ = 0;
                     }
                     if(_loc1_ != 0)
                     {
                        mstate.esp -= 8;
                        si32(_loc4_,mstate.esp);
                        si32(_loc1_,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM_luaO_rawequalObj.start();
                        _loc1_ = mstate.eax;
                        mstate.esp += 8;
                        _loc1_ = _loc1_ == 0 ? 0 : int(_loc4_);
                     }
                     else
                     {
                        addr163:
                        _loc1_ = 0;
                     }
                     §§goto(addr322);
                  }
                  §§goto(addr182);
               }
               addr322:
               mstate.eax = _loc1_;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
            §§goto(addr163);
         }
         §§goto(addr73);
      }
   }
}
