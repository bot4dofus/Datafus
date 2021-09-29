package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaH_getn extends Machine
   {
       
      
      public function FSM_luaH_getn()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(_loc1_ + 28);
         if(_loc2_ != 0)
         {
            _loc3_ = int(li32(_loc1_ + 12));
            _loc4_ = _loc2_ * 12;
            _loc4_ += _loc3_;
            _loc4_ = li32(_loc4_ + -4);
            if(_loc4_ == 0)
            {
               _loc1_ = 0;
               loop0:
               while(true)
               {
                  _loc4_ = _loc1_;
                  _loc1_ = _loc2_;
                  _loc2_ = _loc1_ - _loc4_;
                  if(uint(_loc2_) <= uint(1))
                  {
                     _loc1_ = _loc4_;
                     break;
                  }
                  _loc2_ = _loc4_;
                  while(true)
                  {
                     _loc4_ = _loc2_ + _loc1_;
                     _loc4_ >>>= 1;
                     _loc5_ = _loc4_ * 12;
                     _loc5_ += _loc3_;
                     _loc5_ = li32(_loc5_ + -4);
                     if(_loc5_ == 0)
                     {
                        break;
                     }
                     _loc2_ = _loc1_ - _loc4_;
                     if(uint(_loc2_) <= uint(1))
                     {
                        _loc1_ = _loc4_;
                        break loop0;
                     }
                     _loc2_ = _loc4_;
                  }
                  _loc1_ = _loc2_;
                  _loc2_ = _loc4_;
               }
            }
            else
            {
               addr182:
               _loc3_ = int(_dummynode_);
               _loc4_ = li32(_loc1_ + 16);
               if(_loc4_ == _loc3_)
               {
                  _loc1_ = _loc2_;
               }
               else
               {
                  mstate.esp -= 8;
                  _loc3_ = int(_loc2_ + 1);
                  si32(_loc1_,mstate.esp);
                  si32(_loc3_,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_luaH_getnum.start();
                  _loc4_ = mstate.eax;
                  mstate.esp += 8;
                  _loc4_ = li32(_loc4_ + 8);
                  if(_loc4_ != 0)
                  {
                     _loc2_ = _loc3_;
                     while(true)
                     {
                        _loc3_ = _loc2_ << 1;
                        if(uint(_loc3_) <= uint(2147483645))
                        {
                           mstate.esp -= 8;
                           si32(_loc1_,mstate.esp);
                           si32(_loc3_,mstate.esp + 4);
                           mstate.esp -= 4;
                           FSM_luaH_getnum.start();
                           _loc4_ = mstate.eax;
                           mstate.esp += 8;
                           _loc4_ = li32(_loc4_ + 8);
                           if(_loc4_ != 0)
                           {
                              continue;
                           }
                        }
                        else
                        {
                           _loc2_ = 1;
                           mstate.esp -= 8;
                           si32(_loc1_,mstate.esp);
                           si32(_loc2_,mstate.esp + 4);
                           mstate.esp -= 4;
                           FSM_luaH_getnum.start();
                           _loc2_ = mstate.eax;
                           mstate.esp += 8;
                           _loc2_ = li32(_loc2_ + 8);
                           if(_loc2_ != 0)
                           {
                              _loc2_ = 0;
                              do
                              {
                                 mstate.esp -= 8;
                                 _loc3_ = int(_loc2_ + 2);
                                 si32(_loc1_,mstate.esp);
                                 si32(_loc3_,mstate.esp + 4);
                                 mstate.esp -= 4;
                                 FSM_luaH_getnum.start();
                                 _loc3_ = int(mstate.eax);
                                 mstate.esp += 8;
                                 _loc3_ = int(li32(_loc3_ + 8));
                                 _loc2_ += 1;
                              }
                              while(_loc3_ != 0);
                              
                              _loc1_ = _loc2_;
                              §§goto(addr565);
                           }
                           _loc2_ = 0;
                           _loc1_ = _loc2_;
                           addr565:
                           mstate.eax = _loc1_;
                           mstate.esp = mstate.ebp;
                           mstate.ebp = li32(mstate.esp);
                           mstate.esp += 4;
                           mstate.esp += 4;
                           return;
                           §§goto(addr565);
                        }
                        §§goto(addr565);
                     }
                  }
                  while(true)
                  {
                     _loc4_ = _loc3_ - _loc2_;
                     if(uint(_loc4_) <= uint(1))
                     {
                        break;
                     }
                     _loc4_ = _loc2_ + _loc3_;
                     mstate.esp -= 8;
                     _loc4_ >>>= 1;
                     si32(_loc1_,mstate.esp);
                     si32(_loc4_,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_luaH_getnum.start();
                     _loc5_ = mstate.eax;
                     mstate.esp += 8;
                     _loc5_ = li32(_loc5_ + 8);
                     if(_loc5_ != 0)
                     {
                        _loc2_ = _loc4_;
                     }
                     else
                     {
                        _loc3_ = int(_loc4_);
                     }
                  }
                  _loc1_ = _loc2_;
               }
            }
            §§goto(addr565);
         }
         §§goto(addr182);
      }
   }
}
