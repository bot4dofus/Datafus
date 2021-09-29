package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_findlocal extends Machine
   {
       
      
      public function FSM_findlocal()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 12);
         _loc2_ = int(li32(_loc1_ + 4));
         _loc3_ = li32(_loc2_ + 8);
         _loc4_ = li32(mstate.ebp + 8);
         _loc5_ = li32(mstate.ebp + 16);
         if(_loc3_ == 6)
         {
            _loc6_ = li32(_loc2_);
            _loc7_ = li8(_loc6_ + 6);
            if(_loc7_ == 0)
            {
               _loc6_ = li32(_loc6_ + 16);
            }
            else
            {
               addr88:
               _loc6_ = 0;
            }
            if(_loc6_ != 0)
            {
               if(_loc3_ == 6)
               {
                  _loc3_ = li32(_loc2_);
                  _loc3_ = li8(_loc3_ + 6);
                  if(_loc3_ == 0)
                  {
                     _loc3_ = li32(_loc4_ + 20);
                     if(_loc3_ == _loc1_)
                     {
                        _loc3_ = li32(_loc4_ + 24);
                        si32(_loc3_,_loc1_ + 12);
                     }
                     _loc2_ = int(li32(_loc2_));
                     _loc2_ = int(li32(_loc2_ + 16));
                     _loc3_ = li32(_loc1_ + 12);
                     _loc2_ = int(li32(_loc2_ + 12));
                     _loc2_ = int(_loc3_ - _loc2_);
                     _loc2_ >>= 2;
                     _loc2_ += -1;
                  }
                  else
                  {
                     addr122:
                     _loc2_ = -1;
                  }
                  _loc3_ = li32(_loc6_ + 24);
                  _loc6_ = li32(_loc6_ + 56);
                  mstate.esp -= 16;
                  si32(_loc3_,mstate.esp);
                  si32(_loc6_,mstate.esp + 4);
                  si32(_loc5_,mstate.esp + 8);
                  si32(_loc2_,mstate.esp + 12);
                  mstate.esp -= 4;
                  FSM_luaF_getlocalname388.start();
                  _loc2_ = int(mstate.eax);
                  mstate.esp += 16;
                  if(_loc2_ == 0)
                  {
                     addr273:
                     _loc2_ = int(li32(_loc4_ + 20));
                     if(_loc2_ == _loc1_)
                     {
                        _loc2_ = int(_loc4_ + 8);
                     }
                     else
                     {
                        _loc2_ = int(_loc1_ + 28);
                     }
                     _loc3_ = __2E_str5258;
                     _loc2_ = int(li32(_loc2_));
                     _loc1_ = li32(_loc1_);
                     _loc2_ -= _loc1_;
                     _loc2_ /= 12;
                     _loc2_ = int(_loc2_ >= _loc5_ ? 1 : 0);
                     _loc1_ = _loc5_ > 0 ? 1 : 0;
                     _loc2_ &= _loc1_;
                     _loc2_ &= 1;
                     _loc2_ = int(_loc2_ != 0 ? int(_loc3_) : 0);
                  }
                  mstate.eax = _loc2_;
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  return;
               }
               §§goto(addr122);
            }
            §§goto(addr273);
         }
         §§goto(addr88);
      }
   }
}
