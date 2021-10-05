package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_as3_flyield extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_as3_flyield()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_as3_flyield = null;
         _loc1_ = new FSM_as3_flyield();
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
               this.i1 = li32(mstate.ebp + 8);
               this.i0 = li32(this.i1 + 8);
               this.i2 = li32(this.i1 + 12);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 1;
               mstate.esp -= 4;
               FSM_get_async_state.start();
               return;
            case 1:
               this.i3 = mstate.eax;
               this.i0 -= this.i2;
               mstate.esp += 4;
               this.i2 = this.i0 / 12;
               this.i4 = this.i1 + 12;
               this.i5 = this.i1 + 8;
               if(this.i3 == 0)
               {
                  this.i0 = 0;
                  this.i3 = li32(this.i5);
                  si32(this.i0,this.i3 + 8);
                  this.i0 = li32(this.i5);
                  this.i0 += 12;
                  si32(this.i0,this.i5);
                  this.i0 = li32(this.i1 + 16);
                  this.i3 = li32(this.i0 + 68);
                  this.i0 = li32(this.i0 + 64);
                  this.i6 = this.i1 + 16;
                  if(uint(this.i3) >= uint(this.i0))
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  §§goto(addr210);
               }
               else
               {
                  this.i3 = 1;
                  this.i0 = this.i3;
                  state = 24;
               }
            case 24:
               if(this.i0)
               {
                  this.i0 = 0;
                  throw new AlchemyYield();
               }
               this.i0 = li32(this.i5);
               si32(this.i3,this.i0);
               si32(this.i3,this.i0 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i3 = li32(this.i4);
               this.i6 = this.i2 + 1;
               this.i0 -= this.i3;
               this.i0 /= 12;
               if(this.i0 == this.i6)
               {
                  this.i1 = 1;
                  addr338:
                  this.i0 = this.i1;
                  mstate.eax = this.i0;
                  break;
               }
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 25;
               mstate.esp -= 4;
               FSM_dump_lua_stack.start();
               return;
               break;
            case 2:
               mstate.esp += 4;
               addr210:
               this.i0 = __2E_str18225;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 24;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i3 = li32(this.i4);
               this.i7 = this.i2 + 2;
               this.i0 -= this.i3;
               this.i0 /= 12;
               if(this.i0 != this.i7)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               this.i1 = 2;
               §§goto(addr338);
               break;
            case 4:
               mstate.esp += 8;
               this.i0 = li32(this.i6);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr443);
               break;
            case 5:
               mstate.esp += 4;
               addr443:
               this.i0 = __2E_str19226;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i6);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr593);
               break;
            case 7:
               mstate.esp += 4;
               addr593:
               this.i0 = __2E_str1100;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i5);
               this.i3 = 1077870592;
               this.i8 = 0;
               si32(this.i8,this.i0 + 12);
               si32(this.i3,this.i0 + 16);
               this.i3 = 3;
               si32(this.i3,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i6);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr789);
               break;
            case 9:
               mstate.esp += 4;
               addr789:
               this.i0 = __2E_str2101;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i5);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr978);
               break;
            case 11:
               mstate.esp += 4;
               addr978:
               this.i2 = __2E_str3102;
               this.i0 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 12:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i5);
               this.i0 = this.i2 + 12;
               si32(this.i0,this.i5);
               this.i3 = li32(this.i4);
               this.i0 -= this.i3;
               this.i0 /= 12;
               this.i0 += -7;
               this.f0 = Number(this.i0);
               sf64(this.f0,this.i2 + 12);
               this.i0 = 3;
               si32(this.i0,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1191);
               break;
            case 13:
               mstate.esp += 4;
               addr1191:
               this.i2 = __2E_str4103;
               this.i0 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i5);
               this.i0 = this.i2 + 12;
               si32(this.i0,this.i5);
               this.f0 = Number(this.i7);
               sf64(this.f0,this.i2 + 12);
               this.i0 = 3;
               si32(this.i0,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1380);
               break;
            case 15:
               mstate.esp += 4;
               addr1380:
               this.i2 = __2E_str10143;
               this.i0 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1530);
               break;
            case 17:
               mstate.esp += 4;
               addr1530:
               this.i2 = 10;
               this.i0 = li32(this.i5);
               this.i3 = li32(this.i4);
               this.i0 -= this.i3;
               this.i0 /= 12;
               mstate.esp -= 12;
               this.i0 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 18:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i2 += -108;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 19:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i5);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i0);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 20:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i5);
               this.i3 = this.i2;
               this.i7 = this.i2 + 12;
               if(uint(this.i7) >= uint(this.i0))
               {
                  this.i2 = this.i0;
               }
               else
               {
                  this.i2 += 12;
                  this.i0 = this.i3;
                  while(true)
                  {
                     this.f0 = lf64(this.i0 + 12);
                     sf64(this.f0,this.i0);
                     this.i3 = li32(this.i0 + 20);
                     si32(this.i3,this.i0 + 8);
                     this.i0 = li32(this.i5);
                     this.i3 = this.i2 + 12;
                     this.i7 = this.i2;
                     if(uint(this.i3) >= uint(this.i0))
                     {
                        break;
                     }
                     this.i2 = this.i3;
                     this.i0 = this.i7;
                  }
                  this.i2 = this.i0;
               }
               this.i2 += -12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 21;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1915);
               break;
            case 21:
               mstate.esp += 4;
               addr1915:
               this.i2 = 2;
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i4);
               this.i4 = this.i0 - this.i4;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 22:
               mstate.esp += 12;
               this.i4 = li32(this.i5);
               this.i4 += -12;
               si32(this.i4,this.i5);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 23;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 23:
               mstate.esp += 4;
               mstate.eax = this.i2;
               break;
            case 25:
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 16);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               this.i7 = this.i1 + 16;
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 26;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2233);
               break;
            case 26:
               mstate.esp += 4;
               addr2233:
               this.i0 = __2E_str19226;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 27;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 27:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 28;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2383);
               break;
            case 28:
               mstate.esp += 4;
               addr2383:
               this.i0 = __2E_str1100;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 29;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 29:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i5);
               this.i3 = 1078099968;
               this.i8 = 0;
               si32(this.i8,this.i0 + 12);
               si32(this.i3,this.i0 + 16);
               this.i3 = 3;
               si32(this.i3,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 30;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2579);
               break;
            case 30:
               mstate.esp += 4;
               addr2579:
               this.i0 = __2E_str2101;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 31;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 31:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i5);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 32;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2768);
               break;
            case 32:
               mstate.esp += 4;
               addr2768:
               this.i0 = __2E_str3102;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 33;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 33:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i5);
               this.i3 = li32(this.i4);
               this.i2 -= this.i3;
               this.i2 /= 12;
               this.i2 += -7;
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 34;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2981);
               break;
            case 34:
               mstate.esp += 4;
               addr2981:
               this.i0 = __2E_str4103;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 35;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 35:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i5);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 36;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3170);
               break;
            case 36:
               mstate.esp += 4;
               addr3170:
               this.i0 = __2E_str10143;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 37:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 38;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3320);
               break;
            case 38:
               mstate.esp += 4;
               addr3320:
               this.i0 = 10;
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i4);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 39;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 39:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i0 += -108;
               si32(this.i0,this.i5);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 40:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               mstate.esp -= 8;
               this.i0 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 41:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.i3 = this.i0;
               this.i6 = this.i0 + 12;
               if(uint(this.i6) >= uint(this.i2))
               {
                  this.i0 = this.i2;
               }
               else
               {
                  this.i0 += 12;
                  this.i2 = this.i3;
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i3 = li32(this.i2 + 20);
                     si32(this.i3,this.i2 + 8);
                     this.i2 = li32(this.i5);
                     this.i3 = this.i0 + 12;
                     this.i6 = this.i0;
                     if(uint(this.i3) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i0 = this.i3;
                     this.i2 = this.i6;
                  }
                  this.i0 = this.i2;
               }
               this.i0 += -12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 42;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3705);
               break;
            case 42:
               mstate.esp += 4;
               addr3705:
               this.i0 = 2;
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i4);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 43;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 43:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i0 += -12;
               si32(this.i0,this.i5);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 44;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 44:
               mstate.esp += 4;
               this.i1 = 1;
               mstate.eax = this.i1;
               break;
            default:
               throw "Invalid state in _as3_flyield";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
