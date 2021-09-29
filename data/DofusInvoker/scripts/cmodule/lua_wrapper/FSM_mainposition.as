package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_mainposition extends Machine
   {
       
      
      public function FSM_mainposition()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 8;
         _loc1_ = int(li32(mstate.ebp + 12));
         _loc2_ = int(li32(_loc1_ + 8));
         _loc3_ = li32(mstate.ebp + 8);
         if(_loc2_ <= 2)
         {
            if(_loc2_ != 1)
            {
               if(_loc2_ != 2)
               {
                  addr303:
                  _loc2_ = 1;
                  _loc4_ = int(li8(_loc3_ + 7));
                  _loc2_ <<= _loc4_;
                  _loc2_ += -1;
                  _loc1_ = int(li32(_loc1_));
                  _loc2_ |= 1;
                  _loc1_ = int(uint(_loc1_) % uint(_loc2_));
                  _loc2_ = int(li32(_loc3_ + 16));
                  _loc1_ *= 28;
                  _loc1_ = int(_loc2_ + _loc1_);
               }
               else
               {
                  _loc2_ = 1;
                  _loc4_ = int(li8(_loc3_ + 7));
                  _loc2_ <<= _loc4_;
                  _loc2_ += -1;
                  _loc1_ = int(li32(_loc1_));
                  _loc2_ |= 1;
                  _loc1_ = int(uint(_loc1_) % uint(_loc2_));
                  addr251:
                  _loc3_ = li32(_loc3_ + 16);
                  _loc1_ *= 28;
                  _loc1_ = int(_loc3_ + _loc1_);
               }
               §§goto(addr269);
            }
            else
            {
               _loc2_ = 1;
               _loc4_ = int(li8(_loc3_ + 7));
               _loc2_ <<= _loc4_;
               _loc1_ = int(li32(_loc1_));
               addr242:
               _loc2_ += -1;
               _loc1_ = _loc2_ & _loc1_;
            }
         }
         else
         {
            if(_loc2_ != 4)
            {
               if(_loc2_ == 3)
               {
                  _loc6_ = 0;
                  _loc7_ = lf64(_loc1_);
                  sf64(_loc7_,mstate.ebp + -8);
                  _loc1_ = int(li32(mstate.ebp + -8));
                  _loc2_ = int(li32(mstate.ebp + -4));
                  if(_loc7_ == _loc6_)
                  {
                     _loc1_ = int(li32(_loc3_ + 16));
                  }
                  else
                  {
                     _loc4_ = 1;
                     _loc5_ = li8(_loc3_ + 7);
                     _loc4_ <<= _loc5_;
                     _loc4_ += -1;
                     _loc4_ |= 1;
                     _loc1_ = int(_loc2_ + _loc1_);
                     _loc1_ = int(uint(_loc1_) % uint(_loc4_));
                     §§goto(addr251);
                  }
               }
               else
               {
                  §§goto(addr303);
               }
               addr269:
               mstate.eax = _loc1_;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
            _loc2_ = 1;
            _loc4_ = int(li8(_loc3_ + 7));
            _loc2_ <<= _loc4_;
            _loc1_ = int(li32(_loc1_));
            _loc1_ = int(li32(_loc1_ + 8));
            §§goto(addr242);
         }
         §§goto(addr251);
      }
   }
}
