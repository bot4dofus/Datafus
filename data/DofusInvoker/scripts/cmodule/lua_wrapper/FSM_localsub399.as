package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_localsub399 extends Machine
   {
       
      
      public function FSM_localsub399()
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
         _loc1_ = li32(_lclmem + 4);
         _loc2_ = int(li32(mstate.ebp + 8));
         _loc3_ = li32(mstate.ebp + 16);
         if(_loc1_ != 0)
         {
            _loc4_ = li32(_lclmem + 16);
            if(_loc4_ <= _loc2_)
            {
               _loc4_ = _lclmem;
               _loc5_ = 0;
               _loc4_ += 20;
               while(true)
               {
                  _loc6_ = _loc4_;
                  _loc4_ = _loc5_;
                  _loc5_ = _loc6_;
                  _loc7_ = _loc4_ + 1;
                  if(_loc1_ <= _loc7_)
                  {
                     break;
                  }
                  _loc5_ = li32(_loc5_);
                  _loc6_ += 4;
                  _loc7_ = _loc4_ + 1;
                  if(_loc5_ > _loc2_)
                  {
                     break;
                  }
                  _loc4_ = _loc6_;
                  _loc5_ = _loc7_;
               }
               _loc1_ = _lclmem;
               _loc1_ += _loc4_;
               _loc1_ = li8(_loc1_ + 1496);
            }
            else
            {
               addr76:
               _loc1_ = _lclmem;
               _loc4_ = 0;
               _loc1_ += 1872;
               while(true)
               {
                  _loc5_ = _loc1_;
                  _loc1_ = _loc4_;
                  _loc4_ = li32(_loc5_);
                  if(_loc4_ == 0)
                  {
                     break;
                  }
                  _loc4_ = li32(_lclmem + 8);
                  _loc5_ += 20;
                  _loc6_ = _loc1_ + 1;
                  if(_loc6_ >= _loc4_)
                  {
                     _loc1_ = 0;
                     break;
                  }
                  _loc1_ = _loc5_;
                  _loc4_ = _loc6_;
               }
            }
            _loc4_ = _lclmem;
            _loc1_ *= 20;
            _loc1_ = _loc4_ + _loc1_;
            _loc5_ = li32(_loc1_ + 1868);
            mstate.esp -= 16;
            si32(_loc2_,mstate.esp);
            si32(_loc5_,mstate.esp + 4);
            si32(_loc4_,mstate.esp + 8);
            si32(_loc3_,mstate.esp + 12);
            mstate.esp -= 4;
            FSM_timesub398.start();
            mstate.esp += 16;
            _loc2_ = int(li32(_loc1_ + 1872));
            si32(_loc2_,_loc3_ + 32);
            _loc1_ = li32(_loc1_ + 1876);
            _loc1_ = _loc4_ + _loc1_;
            _loc4_ = _tzname;
            _loc2_ <<= 2;
            _loc1_ += 6988;
            _loc2_ = int(_loc4_ + _loc2_);
            si32(_loc1_,_loc2_);
            si32(_loc1_,_loc3_ + 40);
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr76);
      }
   }
}
