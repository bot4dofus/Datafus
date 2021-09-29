package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM___sflags386 extends Machine
   {
       
      
      public function FSM___sflags386()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(si8(li8(mstate.ebp + 12)));
         _loc2_ = si8(li8(mstate.ebp + 16));
         _loc3_ = li32(mstate.ebp + 20);
         _loc4_ = int(si8(li8(mstate.ebp + 8)));
         if(_loc4_ != 97)
         {
            if(_loc4_ != 114)
            {
               if(_loc4_ == 119)
               {
                  _loc4_ = _loc1_ & 255;
                  if(_loc4_ != 43)
                  {
                     _loc4_ = 8;
                     _loc5_ = 1536;
                     _loc6_ = 1;
                     addr157:
                     _loc1_ &= 255;
                     if(_loc1_ == 98)
                     {
                        _loc1_ = _loc2_ & 255;
                        if(_loc1_ == 43)
                        {
                           _loc1_ = int(_loc5_);
                           addr180:
                           _loc4_ = int(_loc1_);
                           _loc5_ = 16;
                           _loc4_ |= 2;
                           si32(_loc4_,_loc3_);
                           mstate.eax = _loc5_;
                           §§goto(addr208);
                        }
                        addr208:
                        mstate.esp = mstate.ebp;
                        mstate.ebp = li32(mstate.esp);
                        mstate.esp += 4;
                        mstate.esp += 4;
                        return;
                     }
                     _loc1_ = _loc5_ | _loc6_;
                     si32(_loc1_,_loc3_);
                     mstate.eax = _loc4_;
                  }
                  else
                  {
                     _loc1_ = 1536;
                     §§goto(addr180);
                  }
                  §§goto(addr180);
               }
               else
               {
                  _loc1_ = 22;
                  si32(_loc1_,_val_2E_1440);
                  _loc1_ = 0;
                  mstate.eax = _loc1_;
               }
               §§goto(addr180);
            }
            else
            {
               _loc4_ = _loc1_ & 255;
               if(_loc4_ != 43)
               {
                  _loc4_ = 4;
                  _loc5_ = 0;
                  _loc6_ = _loc5_;
                  §§goto(addr157);
               }
               else
               {
                  _loc1_ = 0;
               }
            }
         }
         else
         {
            _loc4_ = _loc1_ & 255;
            if(_loc4_ != 43)
            {
               _loc4_ = 8;
               _loc5_ = 520;
               _loc6_ = 1;
               §§goto(addr157);
            }
            else
            {
               _loc1_ = 520;
            }
         }
         §§goto(addr180);
      }
   }
}
