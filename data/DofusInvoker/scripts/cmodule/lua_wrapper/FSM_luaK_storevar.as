package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaK_storevar extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public function FSM_luaK_storevar()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaK_storevar = null;
         _loc1_ = new FSM_luaK_storevar();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(this.i0);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 16);
               if(this.i1 <= 7)
               {
                  if(this.i1 == 6)
                  {
                     this.i1 = li32(this.i3);
                     if(this.i1 == 12)
                     {
                        this.i1 = li32(this.i3 + 4);
                        this.i4 = this.i1 & 256;
                        if(this.i4 == 0)
                        {
                           this.i4 = li8(this.i2 + 50);
                           if(this.i4 <= this.i1)
                           {
                              this.i1 = li32(this.i2 + 36);
                              this.i1 += -1;
                              si32(this.i1,this.i2 + 36);
                           }
                        }
                     }
                     this.i0 = li32(this.i0 + 4);
                     mstate.esp -= 12;
                     si32(this.i2,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_exp2reg.start();
                     return;
                  }
                  if(this.i1 == 7)
                  {
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaK_dischargevars.start();
                     return;
                  }
               }
               else
               {
                  if(this.i1 == 8)
                  {
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 8;
                     mstate.esp -= 4;
                     FSM_luaK_dischargevars.start();
                     return;
                  }
                  if(this.i1 == 9)
                  {
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaK_exp2RK.start();
                     return;
                  }
               }
               this.i0 = li32(this.i3);
               if(this.i0 == 12)
               {
                  this.i0 = li32(this.i3 + 4);
                  this.i1 = this.i0 & 256;
                  if(this.i1 == 0)
                  {
                     this.i1 = li8(this.i2 + 50);
                     if(this.i1 <= this.i0)
                     {
                        addr797:
                        this.i0 = li32(this.i2 + 36);
                        this.i0 += -1;
                        si32(this.i0,this.i2 + 36);
                        addr392:
                        addr1155:
                     }
                     else
                     {
                        addr398:
                     }
                     addr403:
                     break;
                  }
               }
               §§goto(addr398);
            case 1:
               mstate.esp += 8;
               this.i1 = li32(this.i3);
               this.i4 = this.i3;
               if(this.i1 == 12)
               {
                  this.i1 = li32(this.i3 + 12);
                  this.i5 = li32(this.i3 + 16);
                  this.i6 = li32(this.i3 + 4);
                  this.i7 = this.i3 + 4;
                  if(this.i1 == this.i5)
                  {
                     §§goto(addr654);
                  }
                  else
                  {
                     this.i1 = li8(this.i2 + 50);
                     if(this.i6 >= this.i1)
                     {
                        mstate.esp -= 12;
                        si32(this.i2,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        si32(this.i6,mstate.esp + 8);
                        state = 5;
                        mstate.esp -= 4;
                        FSM_exp2reg.start();
                        return;
                     }
                  }
               }
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 6;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i0 + 8);
               this.i0 = li32(this.i0 + 4);
               this.i5 = li32(this.i2 + 12);
               this.i4 <<= 23;
               this.i0 <<= 6;
               this.i5 = li32(this.i5 + 8);
               this.i0 |= this.i4;
               this.i1 <<= 14;
               this.i0 |= this.i1;
               mstate.esp -= 12;
               this.i0 |= 9;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i3);
               if(this.i0 == 12)
               {
                  this.i3 = li32(this.i3 + 4);
                  this.i0 = this.i3 & 256;
                  if(this.i0 == 0)
                  {
                     this.i0 = li8(this.i2 + 50);
                     if(this.i0 <= this.i3)
                     {
                        this.i3 = li32(this.i2 + 36);
                        this.i3 += -1;
                        si32(this.i3,this.i2 + 36);
                        §§goto(addr392);
                     }
                     break;
                  }
                  break;
               }
               break;
            case 4:
               mstate.esp += 12;
               break;
            case 5:
               mstate.esp += 12;
               this.i6 = li32(this.i7);
               §§goto(addr654);
            case 6:
               mstate.esp += 8;
               this.i6 = li32(this.i3 + 4);
               addr654:
               this.i1 = this.i6;
               this.i0 = li32(this.i0 + 4);
               this.i5 = li32(this.i2 + 12);
               this.i5 = li32(this.i5 + 8);
               this.i0 <<= 23;
               this.i1 <<= 6;
               this.i0 = this.i1 | this.i0;
               mstate.esp -= 12;
               this.i0 |= 8;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i4);
               if(this.i0 == 12)
               {
                  this.i0 = li32(this.i3 + 4);
                  this.i3 = this.i0 & 256;
                  if(this.i3 == 0)
                  {
                     this.i3 = li8(this.i2 + 50);
                     if(this.i3 <= this.i0)
                     {
                        §§goto(addr797);
                     }
                     else
                     {
                        addr402:
                     }
                     §§goto(addr403);
                  }
               }
               §§goto(addr402);
            case 8:
               mstate.esp += 8;
               this.i1 = li32(this.i3);
               this.i4 = this.i3;
               if(this.i1 == 12)
               {
                  this.i1 = li32(this.i3 + 12);
                  this.i5 = li32(this.i3 + 16);
                  this.i6 = li32(this.i3 + 4);
                  this.i7 = this.i3 + 4;
                  if(this.i1 == this.i5)
                  {
                     §§goto(addr1012);
                  }
                  else
                  {
                     this.i1 = li8(this.i2 + 50);
                     if(this.i6 >= this.i1)
                     {
                        mstate.esp -= 12;
                        si32(this.i2,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        si32(this.i6,mstate.esp + 8);
                        state = 9;
                        mstate.esp -= 4;
                        FSM_exp2reg.start();
                        return;
                     }
                  }
               }
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 10;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 9:
               mstate.esp += 12;
               this.i6 = li32(this.i7);
               §§goto(addr1012);
            case 10:
               mstate.esp += 8;
               this.i6 = li32(this.i3 + 4);
               addr1012:
               this.i1 = this.i6;
               this.i0 = li32(this.i0 + 4);
               this.i5 = li32(this.i2 + 12);
               this.i5 = li32(this.i5 + 8);
               this.i0 <<= 14;
               this.i1 <<= 6;
               this.i0 = this.i1 | this.i0;
               mstate.esp -= 12;
               this.i0 |= 7;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 11:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i4);
               if(this.i0 == 12)
               {
                  this.i0 = li32(this.i3 + 4);
                  this.i3 = this.i0 & 256;
                  if(this.i3 == 0)
                  {
                     this.i3 = li8(this.i2 + 50);
                     if(this.i3 <= this.i0)
                     {
                        §§goto(addr1155);
                     }
                     else
                     {
                        addr395:
                     }
                     §§goto(addr797);
                  }
               }
               §§goto(addr395);
            default:
               throw "Invalid state in _luaK_storevar";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
