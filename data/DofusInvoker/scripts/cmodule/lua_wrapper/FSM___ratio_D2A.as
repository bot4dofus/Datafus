package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___ratio_D2A extends Machine
   {
       
      
      public function FSM___ratio_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 40;
         _loc1_ = int(mstate.ebp + -8);
         mstate.esp -= 8;
         _loc2_ = li32(mstate.ebp + 8);
         si32(_loc2_,mstate.esp);
         si32(_loc1_,mstate.esp + 4);
         mstate.esp -= 4;
         FSM___b2d_D2A.start();
         _loc7_ = mstate.st0;
         mstate.esp += 8;
         mstate.esp -= 8;
         _loc1_ = int(li32(mstate.ebp + 12));
         _loc3_ = mstate.ebp + -4;
         si32(_loc1_,mstate.esp);
         si32(_loc3_,mstate.esp + 4);
         mstate.esp -= 4;
         FSM___b2d_D2A.start();
         _loc8_ = mstate.st0;
         mstate.esp += 8;
         _loc2_ = li32(_loc2_ + 16);
         _loc1_ = int(li32(_loc1_ + 16));
         _loc1_ = int(_loc2_ - _loc1_);
         _loc2_ = li32(mstate.ebp + -8);
         _loc3_ = li32(mstate.ebp + -4);
         sf64(_loc7_,mstate.ebp + -16);
         sf64(_loc8_,mstate.ebp + -24);
         _loc1_ <<= 5;
         _loc2_ -= _loc3_;
         _loc3_ = li32(mstate.ebp + -16);
         _loc4_ = li32(mstate.ebp + -12);
         _loc5_ = li32(mstate.ebp + -24);
         _loc6_ = li32(mstate.ebp + -20);
         _loc1_ += _loc2_;
         if(_loc1_ >= 1)
         {
            _loc1_ <<= 20;
            _loc1_ += _loc4_;
            si32(_loc3_,mstate.ebp + -32);
            si32(_loc1_,mstate.ebp + -28);
            _loc7_ = lf64(mstate.ebp + -32);
         }
         else
         {
            _loc1_ <<= 20;
            _loc1_ = int(_loc6_ - _loc1_);
            si32(_loc5_,mstate.ebp + -40);
            si32(_loc1_,mstate.ebp + -36);
            _loc8_ = lf64(mstate.ebp + -40);
         }
         _loc7_ /= _loc8_;
         mstate.st0 = _loc7_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
