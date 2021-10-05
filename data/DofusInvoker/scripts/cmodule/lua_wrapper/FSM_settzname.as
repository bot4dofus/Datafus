package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_settzname extends Machine
   {
       
      
      public function FSM_settzname()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = _wildabbr;
         si32(_loc1_,_tzname);
         si32(_loc1_,_tzname + 4);
         _loc1_ = li32(_lclmem + 8);
         if(_loc1_ >= 1)
         {
            _loc2_ = _lclmem;
            _loc3_ = 0;
            do
            {
               _loc4_ = _lclmem;
               _loc5_ = int(li32(_loc2_ + 1872));
               _loc6_ = int(li32(_loc2_ + 1876));
               _loc4_ += _loc6_;
               _loc6_ = int(_tzname);
               _loc5_ <<= 2;
               _loc4_ += 6988;
               _loc5_ = int(_loc6_ + _loc5_);
               si32(_loc4_,_loc5_);
               _loc2_ += 20;
               _loc3_ += 1;
            }
            while(_loc1_ > _loc3_);
            
         }
         _loc3_ = li32(_lclmem + 4);
         if(_loc3_ >= 1)
         {
            _loc2_ = _lclmem;
            _loc1_ = 0;
            do
            {
               _loc4_ = _lclmem;
               _loc5_ = int(_loc2_ + _loc1_);
               _loc5_ = int(li8(_loc5_ + 1496));
               _loc5_ *= 20;
               _loc5_ = int(_loc4_ + _loc5_);
               _loc6_ = int(li32(_loc5_ + 1872));
               _loc5_ = int(li32(_loc5_ + 1876));
               _loc4_ += _loc5_;
               _loc5_ = int(_tzname);
               _loc6_ <<= 2;
               _loc4_ += 6988;
               _loc5_ += _loc6_;
               si32(_loc4_,_loc5_);
               _loc1_ += 1;
            }
            while(_loc3_ > _loc1_);
            
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
