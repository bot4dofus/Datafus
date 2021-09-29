package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_transtime extends Machine
   {
       
      
      public function FSM_transtime()
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
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 12);
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = li32(mstate.ebp + 16);
         _loc4_ = li32(mstate.ebp + 20);
         _loc5_ = _loc1_ & 3;
         if(_loc5_ == 0)
         {
            _loc5_ = int(_loc1_ / 100);
            _loc5_ *= 100;
            _loc5_ = int(_loc1_ - _loc5_);
            if(_loc5_ == 0)
            {
               _loc5_ = int(_loc1_ / 400);
               _loc5_ *= 400;
               _loc5_ = int(_loc1_ - _loc5_);
               if(_loc5_ != 0)
               {
                  addr136:
                  _loc5_ = 0;
               }
               else
               {
                  addr114:
                  _loc5_ = 1;
               }
               _loc6_ = li32(_loc3_);
               if(_loc6_ != 0)
               {
                  if(_loc6_ != 1)
                  {
                     if(_loc6_ != 2)
                     {
                        addr157:
                        _loc2_ = li32(_loc3_ + 16);
                        _loc1_ += _loc4_;
                        _loc1_ += _loc2_;
                     }
                     else
                     {
                        _loc6_ = li32(_loc3_ + 12);
                        _loc7_ = _loc6_ + -1;
                        if(_loc7_ > 0)
                        {
                           _loc8_ = int(_mon_lengths);
                           _loc9_ = int(_loc5_ * 48);
                           _loc10_ = 0;
                           _loc8_ += _loc9_;
                           _loc9_ = int(_loc10_);
                           do
                           {
                              _loc10_ = int(li32(_loc8_));
                              _loc10_ *= 86400;
                              _loc8_ += 4;
                              _loc9_ += 1;
                              _loc2_ = _loc10_ + _loc2_;
                           }
                           while(_loc7_ > _loc9_);
                           
                        }
                        _loc7_ = _loc1_ + -1;
                        _loc1_ = _loc6_ > 2 ? int(_loc1_) : int(_loc7_);
                        _loc7_ = _loc6_ + 9;
                        _loc8_ = int(_loc1_ / 100);
                        _loc9_ = int(_loc7_ / 12);
                        _loc9_ *= 12;
                        _loc10_ = int(_loc8_ * 100);
                        _loc7_ -= _loc9_;
                        _loc9_ = int(_loc1_ - _loc10_);
                        _loc10_ = _loc9_ >> 31;
                        _loc8_ <<= 1;
                        _loc7_ *= 26;
                        _loc10_ >>>= 30;
                        _loc8_ = int(1 - _loc8_);
                        _loc7_ += 24;
                        _loc10_ = int(_loc9_ + _loc10_);
                        _loc8_ += _loc9_;
                        _loc7_ /= 10;
                        _loc9_ = _loc10_ >> 2;
                        _loc7_ = _loc8_ + _loc7_;
                        _loc7_ += _loc9_;
                        _loc1_ /= 400;
                        _loc1_ = _loc7_ + _loc1_;
                        _loc7_ = _loc1_ / 7;
                        _loc7_ *= 7;
                        _loc8_ = int(li32(_loc3_ + 4));
                        _loc1_ -= _loc7_;
                        _loc7_ = _loc8_ - _loc1_;
                        _loc8_ = int(_loc7_ + -7);
                        _loc1_ = _loc1_ > -1 ? int(_loc7_) : int(_loc8_);
                        if(_loc1_ >= 0)
                        {
                           _loc7_ = 1;
                           while(true)
                           {
                              _loc8_ = int(li32(_loc3_ + 8));
                              if(_loc8_ <= _loc7_)
                              {
                                 break;
                              }
                              addr558:
                              _loc7_ += 1;
                              _loc1_ = _loc9_;
                           }
                           §§goto(addr577);
                        }
                        else
                        {
                           _loc7_ = li32(_loc3_ + 8);
                           _loc1_ += 7;
                           if(_loc7_ > 1)
                           {
                              _loc7_ = 1;
                              while(true)
                              {
                                 _loc8_ = int(_mon_lengths);
                                 _loc9_ = int(_loc5_ * 48);
                                 _loc10_ = _loc6_ << 2;
                                 _loc8_ += _loc9_;
                                 _loc8_ = int(_loc10_ + _loc8_);
                                 _loc8_ = int(li32(_loc8_ + -4));
                                 _loc9_ = int(_loc1_ + 7);
                                 if(_loc9_ < _loc8_)
                                 {
                                    §§goto(addr558);
                                 }
                              }
                              addr519:
                           }
                           addr577:
                           _loc3_ = li32(_loc3_ + 16);
                           _loc4_ = _loc2_ + _loc4_;
                           _loc3_ = _loc4_ + _loc3_;
                           _loc1_ *= 86400;
                           _loc1_ = _loc3_ + _loc1_;
                           §§goto(addr604);
                        }
                     }
                  }
                  else
                  {
                     _loc1_ = li32(_loc3_ + 4);
                     _loc3_ = li32(_loc3_ + 16);
                     _loc2_ = _loc4_ + _loc2_;
                     _loc2_ += _loc3_;
                     _loc1_ *= 86400;
                     _loc1_ = _loc2_ + _loc1_;
                  }
                  addr604:
                  mstate.eax = _loc1_;
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  return;
               }
               _loc1_ = li32(_loc3_ + 4);
               _loc6_ = _loc1_ * 86400;
               _loc2_ += _loc6_;
               _loc2_ += -86400;
               if(_loc1_ >= 60)
               {
                  if(_loc5_ == 0)
                  {
                     addr220:
                     _loc1_ = _loc2_;
                     §§goto(addr157);
                  }
                  else
                  {
                     _loc1_ = li32(_loc3_ + 16);
                     _loc2_ = _loc4_ + _loc2_;
                     _loc2_ += _loc1_;
                     _loc2_ += 86400;
                     mstate.eax = _loc2_;
                  }
                  §§goto(addr577);
               }
               §§goto(addr220);
               §§goto(addr157);
            }
            §§goto(addr114);
         }
         §§goto(addr136);
      }
   }
}
