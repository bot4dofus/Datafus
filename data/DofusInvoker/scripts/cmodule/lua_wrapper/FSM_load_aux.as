package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_load_aux extends Machine
   {
       
      
      public function FSM_load_aux()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 12);
         if(_loc2_ != 0)
         {
            _loc2_ = 0;
            _loc3_ = li32(_loc1_ + 8);
            si32(_loc2_,_loc3_ + 8);
            _loc2_ = li32(_loc1_ + 8);
            _loc2_ += 12;
            si32(_loc2_,_loc1_ + 8);
            mstate.esp -= 8;
            _loc2_ = -2;
            si32(_loc1_,mstate.esp);
            si32(_loc2_,mstate.esp + 4);
            mstate.esp -= 4;
            FSM_index2adr.start();
            _loc2_ = mstate.eax;
            mstate.esp += 8;
            _loc3_ = li32(_loc1_ + 8);
            _loc1_ += 8;
            _loc4_ = _loc3_;
            if(uint(_loc3_) > uint(_loc2_))
            {
               _loc5_ = 0;
               do
               {
                  _loc6_ = _loc5_ ^ -1;
                  _loc6_ *= 12;
                  _loc6_ = int(_loc4_ + _loc6_);
                  _loc8_ = lf64(_loc6_);
                  sf64(_loc8_,_loc3_);
                  _loc7_ = li32(_loc6_ + 8);
                  si32(_loc7_,_loc3_ + 8);
                  _loc3_ += -12;
                  _loc5_ += 1;
               }
               while(uint(_loc6_) > uint(_loc2_));
               
            }
            _loc3_ = 2;
            _loc1_ = li32(_loc1_);
            _loc8_ = lf64(_loc1_);
            sf64(_loc8_,_loc2_);
            _loc1_ = li32(_loc1_ + 8);
            si32(_loc1_,_loc2_ + 8);
            mstate.eax = _loc3_;
         }
         else
         {
            _loc1_ = 1;
            mstate.eax = _loc1_;
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
