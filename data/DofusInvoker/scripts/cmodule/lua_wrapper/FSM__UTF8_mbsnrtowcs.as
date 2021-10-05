package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM__UTF8_mbsnrtowcs extends Machine
   {
       
      
      public function FSM__UTF8_mbsnrtowcs()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 4;
         _loc1_ = int(li32(mstate.ebp + 12));
         _loc2_ = li32(_loc1_);
         _loc3_ = li32(mstate.ebp + 24);
         _loc4_ = li32(mstate.ebp + 8);
         _loc5_ = int(li32(mstate.ebp + 16));
         _loc6_ = li32(mstate.ebp + 20);
         _loc7_ = int(_loc3_);
         if(_loc4_ == 0)
         {
            if(_loc5_ != 0)
            {
               _loc1_ = int(li32(_loc7_ + 4));
               if(_loc1_ >= 1)
               {
                  _loc1_ = int(li8(_loc2_));
                  _loc1_ <<= 24;
                  _loc1_ >>= 24;
                  if(_loc1_ >= 1)
                  {
                     addr144:
                     _loc1_ = 86;
                     si32(_loc1_,_val_2E_1440);
                  }
                  else
                  {
                     §§goto(addr156);
                  }
                  §§goto(addr153);
               }
            }
            §§goto(addr156);
         }
         else
         {
            _loc8_ = int(_loc5_ == 0 ? 1 : 0);
            if(_loc6_ != 0)
            {
               _loc8_ ^= 1;
               _loc8_ &= 1;
               if(_loc8_ != 0)
               {
                  _loc7_ = int(li32(_loc7_ + 4));
                  if(_loc7_ >= 1)
                  {
                     _loc7_ = int(li8(_loc2_));
                     _loc7_ <<= 24;
                     _loc7_ >>= 24;
                     if(_loc7_ >= 1)
                     {
                        §§goto(addr144);
                     }
                     §§goto(addr156);
                  }
               }
            }
            _loc7_ = 0;
            while(true)
            {
               _loc10_ = _loc7_;
               _loc9_ = _loc2_;
               _loc2_ = _loc6_;
               _loc8_ = int(_loc5_);
               _loc7_ = int(_loc4_);
               _loc5_ = int(_loc9_);
               _loc4_ = _loc7_;
               if(_loc2_ != 0)
               {
                  _loc11_ = 0;
                  _loc6_ = _loc2_ + -1;
                  _loc2_ = _loc11_;
                  while(true)
                  {
                     _loc11_ = int(_loc5_ + _loc2_);
                     _loc12_ = _loc4_;
                     if(_loc8_ != _loc2_)
                     {
                        _loc13_ = li8(_loc11_);
                        _loc14_ = _loc13_ << 24;
                        _loc14_ >>= 24;
                        if(_loc14_ < 1)
                        {
                           break;
                        }
                        _loc11_ = _loc13_ << 24;
                        _loc11_ >>= 24;
                        si32(_loc11_,_loc12_);
                        _loc4_ += 4;
                        _loc11_ = int(_loc2_ + 1);
                        if(_loc6_ != _loc2_)
                        {
                           continue;
                        }
                        _loc2_ = _loc11_ + _loc10_;
                        _loc4_ = _loc9_ + _loc11_;
                        §§goto(addr537);
                     }
                     break;
                  }
                  mstate.esp -= 16;
                  _loc4_ = _loc8_ - _loc2_;
                  si32(_loc12_,mstate.esp);
                  si32(_loc11_,mstate.esp + 4);
                  si32(_loc4_,mstate.esp + 8);
                  si32(_loc3_,mstate.esp + 12);
                  mstate.esp -= 4;
                  FSM__UTF8_mbrtowc.start();
                  _loc5_ = int(mstate.eax);
                  mstate.esp += 16;
                  _loc10_ = _loc2_ + _loc10_;
                  _loc6_ -= _loc2_;
                  if(_loc5_ != -2)
                  {
                     if(_loc5_ != 0)
                     {
                        if(_loc5_ == -1)
                        {
                           _loc2_ = -1;
                           si32(_loc11_,_loc1_);
                           addr543:
                           mstate.eax = _loc2_;
                           break;
                        }
                        continue;
                     }
                     _loc2_ = 0;
                  }
                  else
                  {
                     _loc2_ = _loc9_ + _loc8_;
                  }
                  si32(_loc2_,_loc1_);
                  mstate.eax = _loc10_;
                  break;
               }
               _loc2_ = _loc10_;
               _loc4_ = _loc9_;
               addr537:
               _loc3_ = _loc4_;
               si32(_loc3_,_loc1_);
               §§goto(addr543);
            }
         }
         addr156:
         if(_loc5_ != 0)
         {
            _loc1_ = 0;
            _loc4_ = _loc5_;
            while(true)
            {
               _loc5_ = int(li8(_loc2_));
               _loc5_ <<= 24;
               _loc5_ >>= 24;
               if(_loc5_ >= 1)
               {
                  _loc5_ = 1;
                  while(true)
                  {
                     _loc1_ += 1;
                     _loc6_ = _loc4_ - _loc5_;
                     _loc2_ += _loc5_;
                     if(_loc4_ != _loc5_)
                     {
                        break;
                     }
                     _loc4_ = _loc6_;
                     addr664:
                  }
                  continue;
               }
            }
         }
         else
         {
            _loc1_ = 0;
            _loc4_ = _loc5_;
         }
         while(true)
         {
            _loc5_ = int(mstate.ebp + -4);
            mstate.esp -= 16;
            si32(_loc5_,mstate.esp);
            si32(_loc2_,mstate.esp + 4);
            si32(_loc4_,mstate.esp + 8);
            si32(_loc3_,mstate.esp + 12);
            mstate.esp -= 4;
            FSM__UTF8_mbrtowc.start();
            _loc5_ = int(mstate.eax);
            mstate.esp += 16;
            if(_loc5_ != -2)
            {
               if(_loc5_ == -1)
               {
                  addr153:
                  _loc1_ = -1;
                  break;
               }
               if(_loc5_ == 0)
               {
                  break;
               }
               §§goto(addr664);
            }
            break;
         }
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
