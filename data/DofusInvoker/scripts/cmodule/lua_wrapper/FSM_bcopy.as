package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_bcopy extends Machine
   {
       
      
      public function FSM_bcopy()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = int(li32(mstate.ebp + 16));
         _loc4_ = int(_loc1_);
         _loc5_ = int(_loc2_);
         if(_loc3_ != 0)
         {
            if(_loc2_ != _loc1_)
            {
               if(uint(_loc2_) < uint(_loc1_))
               {
                  _loc6_ = _loc5_ | _loc4_;
                  _loc6_ &= 3;
                  if(_loc6_ != 0)
                  {
                     _loc6_ = _loc5_ ^ _loc4_;
                     _loc6_ &= 3;
                     if(_loc6_ == 0)
                     {
                        if(uint(_loc3_) <= uint(3))
                        {
                           addr133:
                           _loc6_ = int(_loc3_);
                        }
                        else
                        {
                           _loc6_ = _loc4_ & 3;
                           _loc6_ = int(4 - _loc6_);
                        }
                        _loc7_ = 0;
                        _loc3_ -= _loc6_;
                        do
                        {
                           _loc8_ = _loc4_ + _loc7_;
                           _loc8_ = li8(_loc8_);
                           _loc9_ = _loc5_ + _loc7_;
                           si8(_loc8_,_loc9_);
                           _loc7_ += 1;
                        }
                        while(_loc7_ != _loc6_);
                        
                        _loc1_ += _loc7_;
                        _loc2_ += _loc7_;
                        addr192:
                        _loc4_ = int(_loc3_ >>> 2);
                        _loc5_ = int(_loc1_);
                        _loc6_ = int(_loc2_);
                        if(uint(_loc3_) > uint(3))
                        {
                           _loc7_ = 0;
                           _loc8_ = _loc7_;
                           do
                           {
                              _loc9_ = _loc5_ + _loc8_;
                              _loc9_ = li32(_loc9_);
                              _loc10_ = _loc6_ + _loc8_;
                              si32(_loc9_,_loc10_);
                              _loc8_ += 4;
                              _loc7_ += 1;
                           }
                           while(_loc7_ != _loc4_);
                           
                           _loc2_ += _loc8_;
                           _loc1_ += _loc8_;
                        }
                        _loc3_ &= 3;
                        if(_loc3_ != 0)
                        {
                           _loc4_ = 0;
                           while(true)
                           {
                              _loc5_ = int(_loc1_ + _loc4_);
                              _loc5_ = int(li8(_loc5_));
                              _loc6_ = int(_loc2_ + _loc4_);
                              si8(_loc5_,_loc6_);
                              _loc4_ += 1;
                              if(_loc4_ == _loc3_)
                              {
                                 mstate.esp = mstate.ebp;
                                 mstate.ebp = li32(mstate.esp);
                                 mstate.esp += 4;
                              }
                              else
                              {
                                 addr571:
                              }
                              continue;
                              mstate.esp += 4;
                              return;
                           }
                        }
                        §§goto(addr571);
                     }
                     §§goto(addr133);
                  }
                  §§goto(addr192);
               }
               else
               {
                  _loc4_ = int(_loc2_ + _loc3_);
                  _loc5_ = int(_loc1_ + _loc3_);
                  _loc6_ = _loc5_ | _loc4_;
                  _loc7_ = int(_loc4_);
                  _loc8_ = _loc5_;
                  _loc6_ &= 3;
                  if(_loc6_ == 0)
                  {
                     _loc1_ = int(_loc3_);
                     _loc2_ = _loc8_;
                     _loc3_ = int(_loc7_);
                  }
                  else
                  {
                     _loc6_ = 0;
                     _loc4_ = _loc5_ ^ _loc4_;
                     _loc4_ &= 3;
                     _loc4_ = int(_loc4_ != 0 ? 1 : 0);
                     _loc7_ = int(uint(_loc3_) < uint(5) ? 1 : 0);
                     _loc4_ |= _loc7_;
                     _loc4_ &= 1;
                     _loc5_ &= 3;
                     _loc4_ = int(_loc4_ != 0 ? int(_loc3_) : int(_loc5_));
                     _loc5_ = int(_loc3_ - _loc4_);
                     do
                     {
                        _loc7_ = _loc6_ ^ -1;
                        _loc7_ += _loc3_;
                        _loc8_ = _loc1_ + _loc7_;
                        _loc9_ = li8(_loc8_);
                        _loc7_ = int(_loc2_ + _loc7_);
                        si8(_loc9_,_loc7_);
                        _loc6_ += 1;
                     }
                     while(_loc6_ != _loc4_);
                     
                     _loc1_ = int(_loc5_);
                     _loc2_ = _loc8_;
                     _loc3_ = int(_loc7_);
                  }
                  _loc4_ = int(_loc1_ >>> 2);
                  _loc5_ = int(_loc3_);
                  _loc6_ = int(_loc2_);
                  if(uint(_loc1_) <= uint(3))
                  {
                     _loc4_ = int(_loc2_);
                     _loc5_ = int(_loc3_);
                  }
                  else
                  {
                     _loc2_ = 0;
                     _loc3_ = int(_loc2_);
                     do
                     {
                        _loc7_ = int(_loc6_ + _loc3_);
                        _loc7_ = int(li32(_loc7_ + -4));
                        _loc8_ = _loc5_ + _loc3_;
                        si32(_loc7_,_loc8_ + -4);
                        _loc3_ += -4;
                        _loc2_ += 1;
                     }
                     while(_loc2_ != _loc4_);
                     
                     _loc5_ += _loc3_;
                     _loc4_ = int(_loc6_ + _loc3_);
                  }
                  _loc2_ = _loc4_;
                  _loc3_ = int(_loc5_);
                  _loc1_ &= 3;
                  if(_loc1_ != 0)
                  {
                     _loc4_ = 0;
                     do
                     {
                        _loc5_ = _loc4_ ^ -1;
                        _loc6_ = int(_loc2_ + _loc5_);
                        _loc6_ = int(li8(_loc6_));
                        _loc5_ = int(_loc3_ + _loc5_);
                        si8(_loc6_,_loc5_);
                        _loc4_ += 1;
                     }
                     while(_loc4_ != _loc1_);
                     
                  }
               }
            }
         }
         §§goto(addr571);
      }
   }
}
