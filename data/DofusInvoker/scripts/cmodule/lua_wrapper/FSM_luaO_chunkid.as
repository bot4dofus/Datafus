package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaO_chunkid extends Machine
   {
       
      
      public function FSM_luaO_chunkid()
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
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 32;
         _loc1_ = li32(mstate.ebp + 12);
         _loc2_ = int(li8(_loc1_));
         _loc3_ = li32(mstate.ebp + 8);
         _loc4_ = li32(mstate.ebp + 16);
         _loc5_ = _loc3_;
         _loc6_ = _loc1_;
         if(_loc2_ != 64)
         {
            _loc7_ = _loc2_ & 255;
            if(_loc7_ != 61)
            {
               _loc7_ = _loc2_ & 255;
               if(_loc7_ == 0)
               {
                  _loc2_ = 0;
               }
               else
               {
                  _loc7_ = 1;
                  si32(_loc7_,mstate.ebp + -32);
                  _loc7_ = 0;
                  si32(_loc7_,mstate.ebp + -28);
                  si32(_loc7_,mstate.ebp + -24);
                  si32(_loc7_,mstate.ebp + -20);
                  si32(_loc7_,mstate.ebp + -16);
                  si32(_loc7_,mstate.ebp + -12);
                  si32(_loc7_,mstate.ebp + -8);
                  si32(_loc7_,mstate.ebp + -4);
                  _loc7_ = int(__2E_str655308);
                  do
                  {
                     _loc8_ = int(mstate.ebp + -32);
                     _loc9_ = int(li8(_loc7_));
                     _loc10_ = _loc9_ & 224;
                     _loc10_ >>>= 3;
                     _loc8_ += _loc10_;
                     _loc10_ = 1;
                     _loc9_ &= 31;
                     _loc11_ = li32(_loc8_);
                     _loc9_ = _loc10_ << _loc9_;
                     _loc9_ |= _loc11_;
                     si32(_loc9_,_loc8_);
                     _loc8_ = int(li8(_loc7_ + 1));
                     _loc7_ += 1;
                  }
                  while(_loc8_ != 0);
                  
                  _loc7_ = int(mstate.ebp + -32);
                  _loc8_ = _loc2_ & 224;
                  _loc8_ >>>= 3;
                  _loc7_ += _loc8_;
                  _loc8_ = 1;
                  _loc2_ &= 31;
                  _loc7_ = int(li32(_loc7_));
                  _loc2_ = _loc8_ << _loc2_;
                  _loc2_ &= _loc7_;
                  if(_loc2_ != 0)
                  {
                     _loc2_ = int(_loc1_);
                  }
                  else
                  {
                     _loc2_ = int(_loc6_);
                     while(true)
                     {
                        _loc7_ = int(mstate.ebp + -32);
                        _loc8_ = int(li8(_loc2_ + 1));
                        _loc9_ = _loc8_ & 224;
                        _loc9_ >>>= 3;
                        _loc7_ += _loc9_;
                        _loc7_ = int(li32(_loc7_));
                        _loc2_ += 1;
                        _loc8_ &= 31;
                        _loc9_ = 1;
                        _loc8_ = _loc9_ << _loc8_;
                        _loc9_ = int(_loc2_);
                        _loc7_ = _loc8_ & _loc7_;
                        if(_loc7_ != 0)
                        {
                           break;
                        }
                        _loc2_ = int(_loc9_);
                     }
                  }
                  _loc2_ -= _loc6_;
               }
               _loc7_ = int(__2E_str756);
               _loc8_ = int(_loc3_);
               _loc9_ = 10;
               _loc4_ += -17;
               _loc2_ = int(uint(_loc2_) > uint(_loc4_) ? int(_loc4_) : int(_loc2_));
               memcpy(_loc8_,_loc7_,_loc9_);
               _loc1_ += _loc2_;
               _loc1_ = li8(_loc1_);
               if(_loc1_ != 0)
               {
                  if(_loc2_ != 0)
                  {
                     _loc1_ = li8(_loc3_);
                     if(_loc1_ != 0)
                     {
                        _loc1_ = _loc5_;
                        while(true)
                        {
                           _loc4_ = li8(_loc1_ + 1);
                           _loc1_ += 1;
                           _loc7_ = int(_loc1_);
                           if(_loc4_ == 0)
                           {
                              break;
                           }
                           _loc1_ = _loc7_;
                        }
                     }
                     else
                     {
                        _loc1_ = _loc3_;
                     }
                     _loc4_ = 0;
                     _loc2_ += 1;
                     while(true)
                     {
                        _loc7_ = int(_loc6_ + _loc4_);
                        _loc7_ = int(li8(_loc7_));
                        _loc8_ = int(_loc1_ + _loc4_);
                        si8(_loc7_,_loc8_);
                        if(_loc7_ != 0)
                        {
                           _loc2_ += -1;
                           _loc4_ += 1;
                           if(_loc2_ == 1)
                           {
                              _loc1_ += _loc4_;
                           }
                           continue;
                           break;
                        }
                        _loc1_ += _loc4_;
                        break;
                     }
                     _loc6_ = _loc1_;
                     _loc1_ = 0;
                     si8(_loc1_,_loc6_);
                  }
                  _loc6_ = li8(_loc3_);
                  if(_loc6_ != 0)
                  {
                     _loc6_ = _loc5_;
                     while(true)
                     {
                        _loc1_ = li8(_loc6_ + 1);
                        _loc6_ += 1;
                        _loc2_ = int(_loc6_);
                        if(_loc1_ == 0)
                        {
                           break;
                        }
                        _loc6_ = _loc2_;
                     }
                  }
                  else
                  {
                     _loc6_ = _loc3_;
                  }
                  _loc1_ = 46;
                  _loc2_ = 0;
                  si8(_loc1_,_loc6_);
                  si8(_loc1_,_loc6_ + 1);
                  si8(_loc1_,_loc6_ + 2);
                  si8(_loc2_,_loc6_ + 3);
                  _loc6_ = li8(_loc3_);
                  _loc1_ = _loc3_;
                  if(_loc6_ != 0)
                  {
                     while(true)
                     {
                        _loc6_ = li8(_loc5_ + 1);
                        _loc5_ += 1;
                        _loc2_ = int(_loc5_);
                        if(_loc6_ == 0)
                        {
                           break;
                        }
                        _loc5_ = _loc2_;
                     }
                  }
                  else
                  {
                     _loc5_ = _loc3_;
                  }
                  _loc6_ = 34;
                  _loc5_ -= _loc1_;
                  _loc1_ = 93;
                  _loc2_ = 0;
                  _loc3_ += _loc5_;
                  si8(_loc6_,_loc3_);
                  si8(_loc1_,_loc3_ + 1);
                  si8(_loc2_,_loc3_ + 2);
               }
               else
               {
                  _loc1_ = li8(_loc3_);
                  if(_loc1_ != 0)
                  {
                     _loc1_ = _loc5_;
                     while(true)
                     {
                        _loc2_ = int(li8(_loc1_ + 1));
                        _loc1_ += 1;
                        _loc4_ = _loc1_;
                        if(_loc2_ == 0)
                        {
                           break;
                        }
                        _loc1_ = _loc4_;
                     }
                  }
                  else
                  {
                     _loc1_ = _loc3_;
                  }
                  _loc2_ = 0;
                  do
                  {
                     _loc4_ = _loc6_ + _loc2_;
                     _loc4_ = li8(_loc4_);
                     _loc7_ = int(_loc1_ + _loc2_);
                     si8(_loc4_,_loc7_);
                     _loc2_ += 1;
                  }
                  while(_loc4_ != 0);
                  
                  _loc1_ = li8(_loc3_);
                  if(_loc1_ != 0)
                  {
                     _loc1_ = _loc5_;
                     while(true)
                     {
                        _loc2_ = int(li8(_loc1_ + 1));
                        _loc1_ += 1;
                        _loc4_ = _loc1_;
                        if(_loc2_ == 0)
                        {
                           break;
                        }
                        _loc1_ = _loc4_;
                     }
                  }
                  else
                  {
                     _loc1_ = _loc3_;
                  }
                  _loc2_ = 34;
                  _loc1_ -= _loc5_;
                  _loc4_ = 93;
                  _loc5_ = 0;
                  _loc1_ = _loc3_ + _loc1_;
                  si8(_loc2_,_loc1_);
                  si8(_loc4_,_loc1_ + 1);
                  si8(_loc5_,_loc1_ + 2);
               }
               addr849:
            }
            else
            {
               if(_loc4_ != 0)
               {
                  _loc2_ = 0;
                  _loc1_ = _loc4_;
                  loop4:
                  while(true)
                  {
                     _loc7_ = int(_loc6_ + _loc2_);
                     _loc7_ = int(li8(_loc7_ + 1));
                     _loc8_ = int(_loc5_ + _loc2_);
                     si8(_loc7_,_loc8_);
                     _loc8_ = int(_loc2_ + 1);
                     if(_loc7_ == 0)
                     {
                        if(_loc1_ != 1)
                        {
                           _loc2_ = 0;
                           while(true)
                           {
                              _loc5_ = 0;
                              _loc6_ = _loc8_ + _loc2_;
                              _loc6_ = _loc3_ + _loc6_;
                              si8(_loc5_,_loc6_);
                              _loc5_ = _loc2_ + 1;
                              _loc2_ = int(_loc1_ - _loc2_);
                              if(_loc2_ == 2)
                              {
                                 break loop4;
                              }
                              _loc2_ = int(_loc5_);
                           }
                        }
                     }
                     _loc7_ = int(_loc1_ + -1);
                     _loc2_ += 1;
                     if(_loc1_ == 1)
                     {
                        break;
                     }
                     _loc1_ = _loc7_;
                  }
               }
               _loc2_ = 0;
               _loc1_ = _loc4_ + _loc3_;
               si8(_loc2_,_loc1_ + -1);
            }
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         _loc2_ = int(li8(_loc1_ + 1));
         _loc7_ = int(_loc4_ + -8);
         _loc1_ += 1;
         if(_loc2_ != 0)
         {
            _loc2_ = int(_loc6_);
            do
            {
               _loc8_ = int(li8(_loc2_ + 2));
               _loc2_ += 1;
            }
            while(_loc8_ != 0);
            
            _loc2_ += 1;
         }
         else
         {
            _loc2_ = int(_loc1_);
         }
         _loc8_ = 0;
         si8(_loc8_,_loc3_);
         _loc8_ = int(_loc1_);
         _loc9_ = int(_loc2_);
         _loc2_ -= _loc1_;
         if(uint(_loc2_) <= uint(_loc7_))
         {
            _loc2_ = 0;
            do
            {
               _loc1_ = _loc6_ + _loc2_;
               _loc1_ = li8(_loc1_ + 1);
               _loc3_ = _loc5_ + _loc2_;
               si8(_loc1_,_loc3_);
               _loc2_ += 1;
            }
            while(_loc1_ != 0);
            
            §§goto(addr849);
         }
         else
         {
            _loc2_ = 46;
            _loc1_ = 0;
            si8(_loc2_,_loc3_);
            si8(_loc2_,_loc3_ + 1);
            si8(_loc2_,_loc3_ + 2);
            si8(_loc1_,_loc3_ + 3);
            _loc2_ = int(li8(_loc3_));
            if(_loc2_ != 0)
            {
               _loc2_ = int(_loc5_);
               while(true)
               {
                  _loc1_ = li8(_loc2_ + 1);
                  _loc2_ += 1;
                  _loc3_ = _loc2_;
                  if(_loc1_ == 0)
                  {
                     break;
                  }
                  _loc2_ = int(_loc3_);
               }
            }
            else
            {
               _loc2_ = int(_loc3_);
            }
            _loc1_ = 0;
            _loc3_ = _loc8_ + _loc4_;
            _loc4_ = _loc9_ + _loc6_;
            _loc3_ = _loc4_ - _loc3_;
            do
            {
               _loc4_ = _loc3_ + _loc1_;
               _loc4_ = li8(_loc4_ + 9);
               _loc5_ = _loc2_ + _loc1_;
               si8(_loc4_,_loc5_);
               _loc1_ += 1;
            }
            while(_loc4_ != 0);
            
         }
         §§goto(addr849);
      }
   }
}
