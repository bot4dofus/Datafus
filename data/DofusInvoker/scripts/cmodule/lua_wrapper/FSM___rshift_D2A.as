package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___rshift_D2A extends Machine
   {
       
      
      public function FSM___rshift_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:int = 0;
         var _loc13_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = int(li32(mstate.ebp + 12));
         _loc3_ = li32(_loc1_ + 16);
         _loc4_ = _loc1_ + 16;
         _loc5_ = _loc2_ >> 5;
         _loc6_ = _loc1_ + 20;
         _loc7_ = _loc1_;
         if(_loc3_ <= _loc5_)
         {
            addr103:
            _loc2_ = int(_loc6_);
         }
         else
         {
            _loc2_ &= 31;
            if(_loc2_ == 0)
            {
               if(_loc5_ < _loc3_)
               {
                  _loc2_ = 0;
                  _loc8_ = _loc5_ << 2;
                  _loc7_ += 20;
                  do
                  {
                     _loc9_ = _loc8_ + _loc7_;
                     _loc9_ = li32(_loc9_);
                     si32(_loc9_,_loc7_);
                     _loc7_ += 4;
                     _loc2_ += 1;
                     _loc9_ = _loc5_ + _loc2_;
                  }
                  while(_loc9_ < _loc3_);
                  
                  _loc2_ <<= 2;
                  _loc2_ = int(_loc1_ + _loc2_);
                  _loc2_ += 20;
               }
               else
               {
                  §§goto(addr103);
               }
            }
            else
            {
               _loc8_ = _loc5_ << 2;
               _loc8_ = int(_loc1_ + _loc8_);
               _loc8_ = int(li32(_loc8_ + 20));
               _loc8_ >>>= _loc2_;
               _loc9_ = 32 - _loc2_;
               _loc10_ = _loc5_ + 1;
               if(_loc10_ >= _loc3_)
               {
                  _loc2_ = int(_loc6_);
                  _loc7_ = _loc8_;
               }
               else
               {
                  _loc10_ = 0;
                  _loc11_ = _loc5_ << 2;
                  _loc5_ += 1;
                  do
                  {
                     _loc12_ = _loc11_ + _loc7_;
                     _loc13_ = int(li32(_loc12_ + 24));
                     _loc13_ <<= _loc9_;
                     _loc8_ = _loc13_ | _loc8_;
                     si32(_loc8_,_loc7_ + 20);
                     _loc8_ = int(li32(_loc12_ + 24));
                     _loc7_ += 4;
                     _loc10_ += 1;
                     _loc8_ >>>= _loc2_;
                     _loc12_ = _loc5_ + _loc10_;
                  }
                  while(_loc12_ < _loc3_);
                  
                  _loc2_ = _loc10_ << 2;
                  _loc2_ = int(_loc1_ + _loc2_);
                  _loc2_ += 20;
                  _loc7_ = _loc8_;
               }
               _loc3_ = _loc7_;
               si32(_loc3_,_loc2_);
               if(_loc3_ != 0)
               {
                  _loc2_ += 4;
               }
            }
         }
         _loc1_ += 20;
         _loc1_ = _loc2_ - _loc1_;
         _loc2_ = _loc1_ >> 2;
         si32(_loc2_,_loc4_);
         if(uint(_loc1_) <= uint(3))
         {
            _loc1_ = 0;
            si32(_loc1_,_loc6_);
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
