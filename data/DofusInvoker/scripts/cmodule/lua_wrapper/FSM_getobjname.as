package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_getobjname extends Machine
   {
       
      
      public function FSM_getobjname()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 12));
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = int(li32(mstate.ebp + 16));
         _loc4_ = li32(mstate.ebp + 20);
         _loc5_ = _loc1_ + 12;
         _loc6_ = _loc2_ + 24;
         _loc2_ += 20;
         _loc7_ = _loc1_ + 4;
         while(true)
         {
            _loc8_ = int(li32(_loc7_));
            _loc9_ = int(li32(_loc8_ + 8));
            if(_loc9_ != 6)
            {
               break;
            }
            _loc10_ = int(li32(_loc8_));
            _loc11_ = li8(_loc10_ + 6);
            if(_loc11_ == 0)
            {
               _loc10_ = int(li32(_loc10_ + 16));
               if(_loc9_ == 6)
               {
                  _loc9_ = _loc11_ & 255;
                  if(_loc9_ != 0)
                  {
                     addr169:
                     _loc8_ = -1;
                  }
                  else
                  {
                     _loc9_ = int(li32(_loc2_));
                     if(_loc9_ == _loc1_)
                     {
                        _loc9_ = int(li32(_loc6_));
                        si32(_loc9_,_loc5_);
                     }
                     _loc8_ = int(li32(_loc8_));
                     _loc8_ = int(li32(_loc8_ + 16));
                     _loc9_ = int(li32(_loc5_));
                     _loc8_ = int(li32(_loc8_ + 12));
                     _loc8_ = int(_loc9_ - _loc8_);
                     _loc8_ >>= 2;
                     _loc8_ += -1;
                  }
                  _loc9_ = int(li32(_loc10_ + 24));
                  _loc11_ = li32(_loc10_ + 56);
                  mstate.esp -= 16;
                  _loc12_ = _loc3_ + 1;
                  si32(_loc9_,mstate.esp);
                  si32(_loc11_,mstate.esp + 4);
                  si32(_loc12_,mstate.esp + 8);
                  si32(_loc8_,mstate.esp + 12);
                  mstate.esp -= 4;
                  FSM_luaF_getlocalname388.start();
                  _loc9_ = int(mstate.eax);
                  mstate.esp += 16;
                  si32(_loc9_,_loc4_);
                  if(_loc9_ != 0)
                  {
                     _loc3_ = int(__2E_str37260);
                     addr131:
                     _loc1_ = int(_loc3_);
                  }
                  else
                  {
                     mstate.esp -= 12;
                     si32(_loc10_,mstate.esp);
                     si32(_loc8_,mstate.esp + 4);
                     si32(_loc3_,mstate.esp + 8);
                     mstate.esp -= 4;
                     FSM_symbexec.start();
                     _loc3_ = int(mstate.eax);
                     mstate.esp += 12;
                     _loc8_ = _loc3_ & 63;
                     if(_loc8_ <= 4)
                     {
                        if(_loc8_ != 0)
                        {
                           if(_loc8_ != 4)
                           {
                              addr125:
                              break;
                           }
                           _loc10_ = int(li32(_loc10_ + 28));
                           if(_loc10_ != 0)
                           {
                              _loc1_ = int(__2E_str6263);
                              _loc3_ &= -8388608;
                              _loc3_ >>>= 21;
                              _loc3_ = int(_loc10_ + _loc3_);
                              addr409:
                              _loc3_ = int(li32(_loc3_));
                              _loc3_ += 16;
                              addr651:
                              si32(_loc3_,_loc4_);
                              mstate.eax = _loc1_;
                           }
                           else
                           {
                              _loc3_ = int(__2E_str6354);
                              si32(_loc3_,_loc4_);
                              _loc3_ = int(__2E_str6263);
                              mstate.eax = _loc3_;
                           }
                           §§goto(addr659);
                        }
                        _loc10_ = int(_loc3_ >>> 6);
                        _loc3_ >>>= 23;
                        _loc10_ &= 255;
                        if(_loc3_ < _loc10_)
                        {
                           continue;
                        }
                        §§goto(addr125);
                        §§goto(addr125);
                     }
                     else
                     {
                        if(_loc8_ != 11)
                        {
                           if(_loc8_ != 6)
                           {
                              if(_loc8_ == 5)
                              {
                                 _loc1_ = int(__2E_str48261);
                                 _loc3_ >>>= 14;
                                 _loc2_ = li32(_loc10_ + 8);
                                 _loc3_ *= 12;
                                 _loc3_ = int(_loc2_ + _loc3_);
                                 §§goto(addr409);
                              }
                              else
                              {
                                 §§goto(addr125);
                              }
                           }
                           else
                           {
                              _loc3_ >>>= 14;
                              _loc1_ = _loc3_ & 256;
                              if(_loc1_ != 0)
                              {
                                 _loc3_ &= 255;
                                 _loc10_ = int(li32(_loc10_ + 8));
                                 _loc1_ = int(_loc3_ * 12);
                                 _loc1_ = int(_loc10_ + _loc1_);
                                 _loc1_ = int(li32(_loc1_ + 8));
                                 if(_loc1_ == 4)
                                 {
                                    _loc3_ *= 12;
                                    _loc3_ = int(_loc10_ + _loc3_);
                                    _loc3_ = int(li32(_loc3_));
                                    _loc3_ += 16;
                                 }
                                 else
                                 {
                                    addr493:
                                    _loc3_ = int(__2E_str6354);
                                 }
                                 _loc10_ = int(__2E_str59262);
                                 si32(_loc3_,_loc4_);
                                 mstate.eax = _loc10_;
                                 §§goto(addr659);
                              }
                              §§goto(addr493);
                           }
                           addr659:
                           mstate.esp = mstate.ebp;
                           mstate.ebp = li32(mstate.esp);
                           mstate.esp += 4;
                           mstate.esp += 4;
                           return;
                        }
                        _loc3_ >>>= 14;
                        _loc1_ = _loc3_ & 256;
                        if(_loc1_ != 0)
                        {
                           _loc3_ &= 255;
                           _loc1_ = int(li32(_loc10_ + 8));
                           _loc2_ = _loc3_ * 12;
                           _loc2_ = _loc1_ + _loc2_;
                           _loc2_ = li32(_loc2_ + 8);
                           if(_loc2_ == 4)
                           {
                              _loc3_ *= 12;
                              _loc3_ = int(_loc1_ + _loc3_);
                              _loc3_ = int(li32(_loc3_));
                              _loc3_ += 16;
                           }
                           else
                           {
                              addr592:
                              _loc3_ = int(__2E_str6354);
                           }
                           _loc1_ = int(__2E_str7264);
                           §§goto(addr651);
                        }
                        §§goto(addr592);
                     }
                     §§goto(addr409);
                  }
                  §§goto(addr409);
               }
               §§goto(addr169);
            }
            §§goto(addr125);
         }
         _loc3_ = 0;
         §§goto(addr131);
      }
   }
}
