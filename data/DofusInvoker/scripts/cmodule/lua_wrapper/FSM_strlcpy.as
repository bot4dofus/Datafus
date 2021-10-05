package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_strlcpy extends Machine
   {
       
      
      public function FSM_strlcpy()
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
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = int(li32(mstate.ebp + 12));
         _loc3_ = li32(mstate.ebp + 16);
         _loc4_ = _loc2_;
         _loc5_ = _loc1_;
         if(_loc3_ == 0)
         {
            _loc5_ = _loc3_;
         }
         else
         {
            _loc6_ = _loc3_ + -1;
            if(_loc3_ != 1)
            {
               _loc6_ = 0;
               _loc7_ = _loc3_;
               while(true)
               {
                  _loc8_ = _loc4_ + _loc6_;
                  _loc8_ = li8(_loc8_);
                  _loc9_ = _loc5_ + _loc6_;
                  si8(_loc8_,_loc9_);
                  _loc9_ = _loc6_ + 1;
                  if(_loc8_ != 0)
                  {
                     _loc7_ += -1;
                     _loc6_ += 1;
                     if(_loc7_ == 1)
                     {
                        _loc5_ = _loc7_ + -1;
                     }
                     continue;
                     break;
                  }
                  _loc5_ = _loc7_ + -1;
                  break;
               }
               _loc2_ += _loc9_;
               _loc1_ += _loc9_;
            }
            else
            {
               _loc5_ = _loc6_;
            }
         }
         _loc6_ = _loc2_;
         if(_loc5_ != 0)
         {
            _loc1_ = _loc2_;
         }
         else
         {
            if(_loc3_ == 0)
            {
               _loc1_ = 0;
            }
            else
            {
               _loc3_ = 0;
               si8(_loc3_,_loc1_);
               _loc1_ = _loc3_;
            }
            do
            {
               _loc3_ = _loc6_ + _loc1_;
               _loc3_ = li8(_loc3_);
               _loc1_ += 1;
            }
            while(_loc3_ != 0);
            
            _loc1_ = _loc2_ + _loc1_;
         }
         _loc2_ = _loc4_ ^ -1;
         _loc1_ += _loc2_;
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
