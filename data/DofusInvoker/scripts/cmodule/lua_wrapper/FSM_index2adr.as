package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_index2adr extends Machine
   {
       
      
      public function FSM_index2adr()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 12);
         if(_loc2_ >= 1)
         {
            _loc3_ = _luaO_nilobject_;
            _loc4_ = li32(_loc1_ + 12);
            _loc2_ *= 12;
            _loc2_ += _loc4_;
            _loc1_ = li32(_loc1_ + 8);
            _loc2_ += -12;
            _loc1_ = uint(_loc1_) > uint(_loc2_) ? int(_loc2_) : int(_loc3_);
         }
         else if(_loc2_ >= -9999)
         {
            _loc1_ = li32(_loc1_ + 8);
            _loc2_ *= 12;
            _loc1_ += _loc2_;
         }
         else if(_loc2_ != -10002)
         {
            if(_loc2_ != -10001)
            {
               if(_loc2_ == -10000)
               {
                  _loc1_ = li32(_loc1_ + 16);
                  _loc1_ += 92;
               }
               else
               {
                  _loc1_ = li32(_loc1_ + 20);
                  _loc1_ = li32(_loc1_ + 4);
                  _loc1_ = li32(_loc1_);
                  _loc3_ = li8(_loc1_ + 7);
                  _loc2_ = -10002 - _loc2_;
                  if(_loc3_ >= _loc2_)
                  {
                     _loc2_ *= 12;
                     _loc1_ = _loc2_ + _loc1_;
                     _loc1_ += 8;
                  }
                  else
                  {
                     _loc1_ = _luaO_nilobject_;
                  }
               }
            }
            else
            {
               _loc2_ = 5;
               _loc3_ = li32(_loc1_ + 20);
               _loc3_ = li32(_loc3_ + 4);
               _loc3_ = li32(_loc3_);
               _loc3_ = li32(_loc3_ + 12);
               si32(_loc3_,_loc1_ + 84);
               si32(_loc2_,_loc1_ + 92);
               _loc1_ += 84;
            }
         }
         else
         {
            _loc1_ += 72;
         }
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
