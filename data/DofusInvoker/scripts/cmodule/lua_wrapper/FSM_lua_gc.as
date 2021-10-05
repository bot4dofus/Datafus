package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_lua_gc extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_lua_gc()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_lua_gc = null;
         _loc1_ = new FSM_lua_gc();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 16);
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               if(this.i2 <= 3)
               {
                  if(this.i2 <= 1)
                  {
                     if(this.i2 == 0)
                     {
                        this.i0 = -3;
                        si32(this.i0,this.i1 + 64);
                        this.i0 = 0;
                        break;
                     }
                     if(this.i2 != 1)
                     {
                        addr211:
                        this.i0 = -1;
                        break;
                     }
                     this.i0 = 0;
                     this.i3 = li32(this.i1 + 68);
                  }
                  else
                  {
                     if(this.i2 == 2)
                     {
                        this.i3 = li8(this.i1 + 21);
                        this.i2 = this.i1 + 21;
                        if(uint(this.i3) <= uint(1))
                        {
                           this.i3 = 0;
                           si32(this.i3,this.i1 + 24);
                           this.i4 = this.i1 + 28;
                           si32(this.i4,this.i1 + 32);
                           si32(this.i3,this.i1 + 36);
                           si32(this.i3,this.i1 + 40);
                           si32(this.i3,this.i1 + 44);
                           this.i3 = 2;
                           si8(this.i3,this.i2);
                        }
                        else
                        {
                           addr339:
                           this.i3 = li8(this.i2);
                           if(this.i3 == 4)
                           {
                              mstate.esp -= 4;
                              si32(this.i0,mstate.esp);
                              mstate.esp -= 4;
                              FSM_markroot.start();
                              addr370:
                              mstate.esp += 4;
                              this.i3 = li8(this.i2);
                              if(this.i3 == 0)
                              {
                                 addr433:
                                 this.i0 = 0;
                                 this.i3 = li32(this.i1 + 72);
                                 this.i2 = li32(this.i1 + 80);
                                 this.i3 = uint(this.i3) / uint(100);
                                 this.i3 = this.i2 * this.i3;
                                 addr88:
                                 si32(this.i3,this.i1 + 64);
                                 addr98:
                                 break;
                              }
                              §§goto(addr388);
                           }
                        }
                        mstate.esp -= 4;
                        si32(this.i0,mstate.esp);
                        state = 1;
                        mstate.esp -= 4;
                        FSM_singlestep.start();
                        return;
                     }
                     if(this.i2 != 3)
                     {
                        §§goto(addr211);
                     }
                     else
                     {
                        this.i0 = li32(this.i1 + 68);
                        this.i0 >>>= 10;
                        addr97:
                     }
                     §§goto(addr98);
                  }
                  §§goto(addr88);
               }
               else if(this.i2 <= 5)
               {
                  if(this.i2 != 4)
                  {
                     if(this.i2 != 5)
                     {
                        §§goto(addr211);
                     }
                     else
                     {
                        this.i2 = li32(this.i1 + 68);
                        this.i4 = this.i1 + 68;
                        this.i3 <<= 10;
                        if(uint(this.i2) >= uint(this.i3))
                        {
                           this.i3 = this.i2 - this.i3;
                           si32(this.i3,this.i1 + 64);
                           if(uint(this.i3) > uint(this.i2))
                           {
                              addr197:
                              this.i0 = 0;
                              break;
                           }
                        }
                        else
                        {
                           this.i3 = 0;
                           si32(this.i3,this.i1 + 64);
                        }
                        this.i3 = this.i1 + 64;
                        this.i1 += 21;
                        §§goto(addr506);
                     }
                  }
                  else
                  {
                     this.i0 = li32(this.i1 + 68);
                     this.i0 &= 1023;
                  }
               }
               else if(this.i2 != 6)
               {
                  if(this.i2 == 7)
                  {
                     this.i0 = li32(this.i1 + 84);
                     si32(this.i3,this.i1 + 84);
                     break;
                  }
                  §§goto(addr211);
               }
               else
               {
                  this.i0 = li32(this.i1 + 80);
                  si32(this.i3,this.i1 + 80);
               }
               §§goto(addr97);
            case 1:
               this.i3 = mstate.eax;
               mstate.esp += 4;
               §§goto(addr339);
            case 2:
               §§goto(addr370);
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 4;
               this.i3 = li8(this.i2);
               if(this.i3 != 0)
               {
                  addr388:
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_singlestep.start();
                  return;
               }
               §§goto(addr433);
               break;
            case 4:
               mstate.esp += 4;
               this.i2 = li8(this.i1);
               if(this.i2 == 0)
               {
                  this.i0 = 1;
                  break;
               }
               this.i2 = li32(this.i3);
               this.i5 = li32(this.i4);
               if(uint(this.i2) <= uint(this.i5))
               {
                  addr506:
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr197);
               break;
            default:
               throw "Invalid state in _lua_gc";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
