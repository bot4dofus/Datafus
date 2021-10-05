package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_dorounding extends Machine
   {
       
      
      public function FSM_dorounding()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = int(_loc1_ + _loc2_);
         _loc3_ = int(li8(_loc3_));
         _loc4_ = li32(mstate.ebp + 16);
         _loc5_ = _loc3_ << 24;
         _loc6_ = _loc1_;
         _loc5_ >>= 24;
         if(_loc5_ <= 8)
         {
            _loc3_ &= 255;
            if(_loc3_ == 8)
            {
               _loc3_ = int(_loc2_ + _loc1_);
               _loc3_ = int(li8(_loc3_ + -1));
               _loc3_ &= 1;
               if(_loc3_ != 0)
               {
                  addr124:
                  _loc3_ = int(_loc2_ + -1);
                  _loc5_ = int(_loc1_ + _loc3_);
                  _loc7_ = li8(_loc5_);
                  if(_loc7_ != 15)
                  {
                     _loc1_ = _loc5_;
                     addr215:
                     _loc4_ = _loc1_;
                     _loc6_ = li8(_loc4_);
                     _loc6_ += 1;
                     si8(_loc6_,_loc4_);
                  }
                  else
                  {
                     _loc5_ = 0;
                     _loc2_ = _loc6_ + _loc2_;
                     _loc2_ += -1;
                     while(true)
                     {
                        _loc6_ = _loc2_;
                        if(_loc3_ == _loc5_)
                        {
                           _loc1_ = 1;
                           si8(_loc1_,_loc6_);
                           _loc1_ = li32(_loc4_);
                           _loc1_ += 4;
                           si32(_loc1_,_loc4_);
                           break;
                        }
                        _loc7_ = li8(_loc6_);
                        _loc8_ = _loc5_ ^ -1;
                        _loc7_ += 1;
                        _loc8_ = int(_loc3_ + _loc8_);
                        si8(_loc7_,_loc6_);
                        _loc6_ = _loc1_ + _loc8_;
                        _loc7_ = li8(_loc6_);
                        _loc2_ += -1;
                        _loc5_ += 1;
                        if(_loc7_ == 15)
                        {
                           continue;
                        }
                        _loc1_ = _loc6_;
                        §§goto(addr215);
                     }
                  }
               }
            }
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr124);
      }
   }
}
