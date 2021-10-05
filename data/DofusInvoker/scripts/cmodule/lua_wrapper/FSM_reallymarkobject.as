package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_reallymarkobject extends Machine
   {
       
      
      public function FSM_reallymarkobject()
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
         var _loc6_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         _loc2_ = li32(mstate.ebp + 12);
         while(true)
         {
            _loc3_ = int(li8(_loc2_ + 5));
            _loc3_ &= -4;
            si8(_loc3_,_loc2_ + 5);
            _loc4_ = int(li8(_loc2_ + 4));
            _loc5_ = int(_loc2_ + 5);
            if(_loc4_ <= 7)
            {
               if(_loc4_ == 5)
               {
                  _loc3_ = int(li32(_loc1_ + 36));
                  si32(_loc3_,_loc2_ + 24);
                  break;
               }
               if(_loc4_ == 6)
               {
                  _loc3_ = int(li32(_loc1_ + 36));
                  si32(_loc3_,_loc2_ + 8);
                  break;
               }
               if(_loc4_ == 7)
               {
                  _loc4_ = int(li32(_loc2_ + 8));
                  _loc3_ |= 4;
                  si8(_loc3_,_loc5_);
                  if(_loc4_ != 0)
                  {
                     _loc5_ = int(li8(_loc4_ + 5));
                     _loc5_ &= 3;
                     if(_loc5_ != 0)
                     {
                        mstate.esp -= 8;
                        si32(_loc1_,mstate.esp);
                        si32(_loc4_,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM_reallymarkobject.start();
                        mstate.esp += 8;
                     }
                  }
                  _loc2_ = li32(_loc2_ + 12);
                  _loc5_ = int(li8(_loc2_ + 5));
                  _loc5_ &= 3;
                  if(_loc5_ != 0)
                  {
                     continue;
                  }
               }
            }
            else
            {
               if(_loc4_ == 8)
               {
                  _loc3_ = int(li32(_loc1_ + 36));
                  si32(_loc3_,_loc2_ + 100);
                  break;
               }
               if(_loc4_ == 9)
               {
                  _loc3_ = int(li32(_loc1_ + 36));
                  si32(_loc3_,_loc2_ + 68);
                  break;
               }
               if(_loc4_ == 10)
               {
                  _loc3_ = int(li32(_loc2_ + 8));
                  _loc4_ = int(li32(_loc3_ + 8));
                  _loc6_ = _loc2_ + 8;
                  if(_loc4_ >= 4)
                  {
                     _loc3_ = int(li32(_loc3_));
                     _loc4_ = int(li8(_loc3_ + 5));
                     _loc4_ &= 3;
                     if(_loc4_ != 0)
                     {
                        mstate.esp -= 8;
                        si32(_loc1_,mstate.esp);
                        si32(_loc3_,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM_reallymarkobject.start();
                        mstate.esp += 8;
                     }
                  }
                  _loc1_ = int(li32(_loc6_));
                  _loc2_ += 12;
                  if(_loc1_ == _loc2_)
                  {
                     _loc1_ = int(li8(_loc5_));
                     _loc1_ |= 4;
                     si8(_loc1_,_loc5_);
                  }
               }
            }
            §§goto(addr360);
         }
         si32(_loc2_,_loc1_ + 36);
         addr360:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
