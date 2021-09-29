package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_getrule extends Machine
   {
       
      
      public function FSM_getrule()
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
         _loc2_ = int(li8(_loc1_));
         _loc3_ = li32(mstate.ebp + 12);
         if(_loc2_ != 77)
         {
            _loc4_ = _loc2_ & 255;
            if(_loc4_ == 74)
            {
               _loc2_ = 0;
               si32(_loc2_,_loc3_);
               mstate.esp -= 16;
               _loc2_ = 365;
               _loc4_ = int(_loc3_ + 4);
               _loc1_ += 1;
               _loc5_ = 1;
               si32(_loc1_,mstate.esp);
               si32(_loc4_,mstate.esp + 4);
               si32(_loc5_,mstate.esp + 8);
               si32(_loc2_,mstate.esp + 12);
               mstate.esp -= 4;
               FSM_getnum.start();
               _loc1_ = mstate.eax;
               mstate.esp += 16;
               if(_loc1_ != 0)
               {
                  addr506:
                  _loc2_ = int(li8(_loc1_));
                  if(_loc2_ == 47)
                  {
                     mstate.esp -= 8;
                     _loc3_ += 16;
                     _loc1_ += 1;
                     si32(_loc1_,mstate.esp);
                     si32(_loc3_,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_getsecs.start();
                     _loc1_ = mstate.eax;
                     mstate.esp += 8;
                  }
                  else
                  {
                     _loc2_ = 7200;
                     si32(_loc2_,_loc3_ + 16);
                  }
               }
               else
               {
                  addr578:
                  _loc1_ = 0;
               }
               §§goto(addr580);
            }
            else
            {
               _loc2_ <<= 24;
               _loc2_ >>= 24;
               _loc2_ += -48;
               if(uint(_loc2_) <= uint(9))
               {
                  _loc2_ = 1;
                  si32(_loc2_,_loc3_);
                  mstate.esp -= 16;
                  _loc2_ = 365;
                  _loc4_ = 0;
                  _loc5_ = _loc3_ + 4;
                  si32(_loc1_,mstate.esp);
                  si32(_loc5_,mstate.esp + 4);
                  si32(_loc4_,mstate.esp + 8);
                  si32(_loc2_,mstate.esp + 12);
                  mstate.esp -= 4;
                  FSM_getnum.start();
                  _loc1_ = mstate.eax;
                  mstate.esp += 16;
                  if(_loc1_ != 0)
                  {
                     §§goto(addr506);
                  }
                  else
                  {
                     §§goto(addr578);
                  }
               }
            }
         }
         else
         {
            _loc2_ = 2;
            si32(_loc2_,_loc3_);
            mstate.esp -= 16;
            _loc2_ = int(_loc3_ + 12);
            _loc4_ = 12;
            _loc1_ += 1;
            _loc5_ = 1;
            si32(_loc1_,mstate.esp);
            si32(_loc2_,mstate.esp + 4);
            si32(_loc5_,mstate.esp + 8);
            si32(_loc4_,mstate.esp + 12);
            mstate.esp -= 4;
            FSM_getnum.start();
            _loc1_ = mstate.eax;
            mstate.esp += 16;
            if(_loc1_ != 0)
            {
               _loc2_ = int(li8(_loc1_));
               if(_loc2_ == 46)
               {
                  _loc2_ = 5;
                  mstate.esp -= 16;
                  _loc4_ = int(_loc3_ + 8);
                  _loc1_ += 1;
                  _loc5_ = 1;
                  si32(_loc1_,mstate.esp);
                  si32(_loc4_,mstate.esp + 4);
                  si32(_loc5_,mstate.esp + 8);
                  si32(_loc2_,mstate.esp + 12);
                  mstate.esp -= 4;
                  FSM_getnum.start();
                  _loc1_ = mstate.eax;
                  mstate.esp += 16;
                  if(_loc1_ != 0)
                  {
                     _loc2_ = int(li8(_loc1_));
                     if(_loc2_ == 46)
                     {
                        _loc2_ = 6;
                        mstate.esp -= 16;
                        _loc4_ = 0;
                        _loc5_ = _loc3_ + 4;
                        _loc1_ += 1;
                        si32(_loc1_,mstate.esp);
                        si32(_loc5_,mstate.esp + 4);
                        si32(_loc4_,mstate.esp + 8);
                        si32(_loc2_,mstate.esp + 12);
                        mstate.esp -= 4;
                        FSM_getnum.start();
                        _loc1_ = mstate.eax;
                        mstate.esp += 16;
                        if(_loc1_ != 0)
                        {
                           §§goto(addr506);
                        }
                        else
                        {
                           §§goto(addr578);
                        }
                        mstate.esp += 4;
                        mstate.esp += 4;
                        return;
                     }
                  }
               }
            }
         }
         §§goto(addr578);
      }
   }
}
