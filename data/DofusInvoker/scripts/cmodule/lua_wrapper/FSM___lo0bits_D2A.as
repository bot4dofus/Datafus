package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___lo0bits_D2A extends Machine
   {
       
      
      public function FSM___lo0bits_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(_loc1_);
         _loc3_ = _loc2_ & 7;
         if(_loc3_ != 0)
         {
            _loc3_ = _loc2_ & 1;
            if(_loc3_ != 0)
            {
               _loc1_ = 0;
               addr219:
               mstate.eax = _loc1_;
            }
            else
            {
               _loc3_ = _loc2_ & 2;
               if(_loc3_ != 0)
               {
                  _loc3_ = 1;
                  _loc2_ >>>= 1;
               }
               else
               {
                  _loc3_ = 2;
                  _loc2_ >>>= 2;
               }
               addr208:
               si32(_loc2_,_loc1_);
               mstate.eax = _loc3_;
            }
            §§goto(addr223);
         }
         else
         {
            _loc3_ = _loc2_ & 65535;
            _loc3_ = int(_loc3_ == 0 ? 16 : 0);
            _loc2_ >>>= _loc3_;
            _loc4_ = _loc2_ & 255;
            _loc4_ = int(_loc4_ == 0 ? 8 : 0);
            _loc2_ >>>= _loc4_;
            _loc5_ = _loc2_ & 15;
            _loc5_ = int(_loc5_ == 0 ? 4 : 0);
            _loc2_ >>>= _loc5_;
            _loc3_ = _loc4_ | _loc3_;
            _loc4_ = _loc2_ & 3;
            _loc4_ = int(_loc4_ == 0 ? 2 : 0);
            _loc3_ |= _loc5_;
            _loc2_ >>>= _loc4_;
            _loc3_ |= _loc4_;
            _loc4_ = _loc2_ & 1;
            if(_loc4_ != 0)
            {
               §§goto(addr208);
            }
            else
            {
               _loc4_ = int(_loc2_ >>> 1);
               _loc3_ += 1;
               if(uint(_loc2_) >= uint(2))
               {
                  _loc2_ = _loc4_;
                  §§goto(addr208);
               }
               else
               {
                  _loc1_ = 32;
                  §§goto(addr219);
               }
            }
            addr223:
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr219);
      }
   }
}
