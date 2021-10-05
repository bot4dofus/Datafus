package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___ULtod_D2A extends Machine
   {
       
      
      public function FSM___ULtod_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 20));
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = int(li32(mstate.ebp + 12));
         _loc4_ = int(li32(mstate.ebp + 16));
         _loc5_ = _loc1_ & 7;
         if(_loc5_ <= 2)
         {
            if(_loc5_ != 0)
            {
               if(_loc5_ != 1)
               {
                  if(_loc5_ != 2)
                  {
                     addr150:
                     _loc1_ &= 8;
                     if(_loc1_ != 0)
                     {
                        addr252:
                        _loc1_ = int(li32(_loc2_ + 4));
                        _loc1_ |= -2147483648;
                        si32(_loc1_,_loc2_ + 4);
                     }
                  }
                  else
                  {
                     _loc4_ = int(li32(_loc3_));
                     si32(_loc4_,_loc2_);
                     _loc3_ = int(li32(_loc3_ + 4));
                     si32(_loc3_,_loc2_ + 4);
                     _loc1_ &= 8;
                     if(_loc1_ != 0)
                     {
                        §§goto(addr252);
                     }
                  }
               }
               else
               {
                  addr187:
                  _loc5_ = int(li32(_loc3_));
                  si32(_loc5_,_loc2_);
                  _loc3_ = int(li32(_loc3_ + 4));
                  _loc4_ <<= 20;
                  _loc4_ += 1127219200;
                  _loc3_ &= -1048577;
                  _loc3_ |= _loc4_;
                  si32(_loc3_,_loc2_ + 4);
                  _loc1_ &= 8;
                  if(_loc1_ != 0)
                  {
                     §§goto(addr252);
                  }
               }
            }
            else
            {
               addr168:
               _loc3_ = 0;
               si32(_loc3_,_loc2_ + 4);
               si32(_loc3_,_loc2_);
               _loc1_ &= 8;
               if(_loc1_ != 0)
               {
                  §§goto(addr252);
               }
            }
            §§goto(addr267);
         }
         else
         {
            if(_loc5_ <= 4)
            {
               if(_loc5_ != 3)
               {
                  if(_loc5_ == 4)
                  {
                     _loc3_ = 2147483647;
                     si32(_loc3_,_loc2_ + 4);
                     _loc3_ = -1;
                     si32(_loc3_,_loc2_);
                  }
                  §§goto(addr150);
               }
               else
               {
                  _loc3_ = 2146435072;
                  si32(_loc3_,_loc2_ + 4);
                  _loc3_ = 0;
                  si32(_loc3_,_loc2_);
                  _loc1_ &= 8;
                  if(_loc1_ != 0)
                  {
                     §§goto(addr252);
                  }
               }
            }
            else if(_loc5_ != 5)
            {
               if(_loc5_ == 6)
               {
                  §§goto(addr168);
               }
               else
               {
                  §§goto(addr150);
               }
            }
            else
            {
               §§goto(addr187);
            }
            addr267:
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr187);
      }
   }
}
