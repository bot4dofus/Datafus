package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaK_exp2RK extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
      
      public function FSM_luaK_exp2RK()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaK_exp2RK = null;
         _loc1_ = new FSM_luaK_exp2RK();
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
               mstate.esp -= 64;
               this.i0 = li32(mstate.ebp + 8);
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 12);
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_exp2val.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i2 = li32(this.i1);
               this.i3 = this.i1;
               this.i4 = this.i2 + -1;
               if(uint(this.i4) >= uint(3))
               {
                  if(this.i2 != 4)
                  {
                     if(this.i2 == 5)
                     {
                        addr112:
                        this.i4 = li32(this.i0 + 40);
                        if(this.i4 <= 255)
                        {
                           if(this.i2 != 5)
                           {
                              if(this.i2 == 1)
                              {
                                 this.i2 = 0;
                                 si32(this.i2,mstate.ebp + -40);
                                 this.i2 = li32(this.i0 + 4);
                                 si32(this.i2,mstate.ebp + -32);
                                 this.i2 = 5;
                                 si32(this.i2,mstate.ebp + -24);
                                 mstate.esp -= 12;
                                 this.i2 = mstate.ebp + -32;
                                 this.i4 = mstate.ebp + -48;
                                 si32(this.i0,mstate.esp);
                                 si32(this.i2,mstate.esp + 4);
                                 si32(this.i4,mstate.esp + 8);
                                 state = 2;
                                 mstate.esp -= 4;
                                 FSM_addk.start();
                                 return;
                              }
                              this.i4 = 1;
                              this.i2 = this.i2 == 2 ? 1 : 0;
                              this.i2 &= 1;
                              si32(this.i2,mstate.ebp + -64);
                              si32(this.i4,mstate.ebp + -56);
                              mstate.esp -= 12;
                              this.i2 = mstate.ebp + -64;
                              si32(this.i0,mstate.esp);
                              si32(this.i2,mstate.esp + 4);
                              si32(this.i2,mstate.esp + 8);
                              state = 4;
                              mstate.esp -= 4;
                              FSM_addk.start();
                              return;
                           }
                           this.i2 = 3;
                           this.f0 = lf64(this.i1 + 4);
                           sf64(this.f0,mstate.ebp + -16);
                           si32(this.i2,mstate.ebp + -8);
                           mstate.esp -= 12;
                           this.i2 = mstate.ebp + -16;
                           si32(this.i0,mstate.esp);
                           si32(this.i2,mstate.esp + 4);
                           si32(this.i2,mstate.esp + 8);
                           state = 3;
                           mstate.esp -= 4;
                           FSM_addk.start();
                           return;
                        }
                     }
                  }
                  else
                  {
                     this.i2 = li32(this.i1 + 4);
                     if(this.i2 <= 255)
                     {
                        this.i0 = this.i2 | 256;
                        addr437:
                        mstate.eax = this.i0;
                        break;
                     }
                  }
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaK_dischargevars.start();
                  return;
               }
               §§goto(addr112);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               addr395:
               this.i2 = 4;
               si32(this.i0,this.i1 + 4);
               si32(this.i2,this.i3);
               this.i0 |= 256;
               §§goto(addr437);
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr395);
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr395);
            case 5:
               mstate.esp += 8;
               this.i2 = li32(this.i3);
               if(this.i2 == 12)
               {
                  this.i2 = li32(this.i1 + 12);
                  this.i3 = li32(this.i1 + 16);
                  this.i4 = li32(this.i1 + 4);
                  this.i5 = this.i1 + 4;
                  if(this.i2 == this.i3)
                  {
                     addr630:
                     mstate.eax = this.i4;
                     break;
                  }
                  this.i2 = li8(this.i0 + 50);
                  if(this.i4 >= this.i2)
                  {
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i4,mstate.esp + 8);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_exp2reg.start();
                     return;
                  }
               }
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 7;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 6:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               §§goto(addr437);
            case 7:
               mstate.esp += 8;
               this.i4 = li32(this.i1 + 4);
               §§goto(addr630);
            default:
               throw "Invalid state in _luaK_exp2RK";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
