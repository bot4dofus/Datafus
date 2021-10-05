package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaH_get extends Machine
   {
       
      
      public function FSM_luaH_get()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 12);
         _loc2_ = int(li32(_loc1_ + 8));
         _loc3_ = li32(mstate.ebp + 8);
         if(_loc2_ != 0)
         {
            if(_loc2_ == 3)
            {
               _loc5_ = lf64(_loc1_);
               _loc2_ = int(int(_loc5_));
               _loc6_ = Number(_loc2_);
               if(_loc6_ == _loc5_)
               {
                  mstate.esp -= 8;
                  si32(_loc3_,mstate.esp);
                  si32(_loc2_,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_luaH_getnum.start();
                  _loc1_ = mstate.eax;
                  mstate.esp += 8;
               }
               else
               {
                  §§goto(addr243);
               }
               addr174:
               mstate.eax = _loc1_;
               addr346:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
            if(_loc2_ == 4)
            {
               _loc2_ = 1;
               _loc4_ = li8(_loc3_ + 7);
               _loc2_ <<= _loc4_;
               _loc1_ = li32(_loc1_);
               _loc4_ = li32(_loc1_ + 8);
               _loc2_ += -1;
               _loc2_ &= _loc4_;
               _loc3_ = li32(_loc3_ + 16);
               _loc2_ *= 28;
               _loc3_ += _loc2_;
               do
               {
                  _loc2_ = int(li32(_loc3_ + 20));
                  if(_loc2_ == 4)
                  {
                     _loc2_ = int(li32(_loc3_ + 12));
                     if(_loc2_ == _loc1_)
                     {
                        mstate.eax = _loc3_;
                        §§goto(addr346);
                     }
                  }
                  _loc3_ = li32(_loc3_ + 24);
               }
               while(_loc3_ != 0);
               
            }
            else
            {
               addr243:
               mstate.esp -= 8;
               si32(_loc3_,mstate.esp);
               si32(_loc1_,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_mainposition.start();
               _loc2_ = int(mstate.eax);
               mstate.esp += 8;
               while(true)
               {
                  mstate.esp -= 8;
                  _loc3_ = _loc2_ + 12;
                  si32(_loc3_,mstate.esp);
                  si32(_loc1_,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_luaO_rawequalObj.start();
                  _loc3_ = mstate.eax;
                  mstate.esp += 8;
                  if(_loc3_ != 0)
                  {
                     mstate.eax = _loc2_;
                     break;
                  }
                  _loc2_ = int(li32(_loc2_ + 24));
                  if(_loc2_ != 0)
                  {
                     continue;
                  }
                  addr167:
               }
               §§goto(addr346);
            }
            _loc1_ = _luaO_nilobject_;
            §§goto(addr174);
            §§goto(addr243);
         }
         §§goto(addr167);
      }
   }
}
