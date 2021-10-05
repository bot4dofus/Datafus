package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_strstr extends Machine
   {
       
      
      public function FSM_strstr()
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
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 12);
         _loc2_ = li8(_loc1_);
         _loc3_ = li32(mstate.ebp + 8);
         _loc4_ = _loc1_ + 1;
         _loc5_ = _loc3_;
         if(_loc2_ == 0)
         {
            _loc1_ = _loc3_;
            addr95:
            mstate.eax = _loc1_;
         }
         else
         {
            _loc3_ = li8(_loc4_);
            if(_loc3_ != 0)
            {
               _loc3_ = _loc1_;
               do
               {
                  _loc6_ = li8(_loc3_ + 2);
                  _loc3_ += 1;
               }
               while(_loc6_ != 0);
               
               _loc3_ += 1;
            }
            else
            {
               _loc3_ = _loc4_;
            }
            _loc6_ = _loc4_;
            _loc7_ = _loc3_;
            loop1:
            while(true)
            {
               _loc8_ = int(li8(_loc5_));
               _loc9_ = _loc5_;
               if(_loc8_ != 0)
               {
                  _loc10_ = _loc2_ & 255;
                  _loc8_ &= 255;
                  if(_loc8_ == _loc10_)
                  {
                     if(_loc3_ != _loc4_)
                     {
                        _loc8_ = 1;
                        _loc10_ = int(_loc7_ - _loc6_);
                        while(true)
                        {
                           _loc11_ = _loc1_ + _loc8_;
                           _loc12_ = int(_loc5_ + _loc8_);
                           _loc12_ = int(li8(_loc12_));
                           _loc11_ = li8(_loc11_);
                           if(_loc12_ == _loc11_)
                           {
                              _loc11_ = _loc10_ + -1;
                              _loc8_ += 1;
                              _loc12_ &= 255;
                              if(_loc12_ == 0)
                              {
                                 break;
                              }
                              if(_loc10_ == 1)
                              {
                                 break;
                              }
                              continue;
                           }
                           continue loop1;
                        }
                     }
                     mstate.eax = _loc9_;
                  }
                  continue;
                  break;
               }
               _loc1_ = 0;
               §§goto(addr95);
            }
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
