package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_push_as3_to_lua_stack extends Machine
   {
      
      public static const intRegCount:int = 10;
      
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
      
      public var i9:int;
      
      public function FSM_push_as3_to_lua_stack()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_push_as3_to_lua_stack = null;
         _loc1_ = new FSM_push_as3_to_lua_stack();
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
               mstate.esp -= 16;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 8);
               this.i2 = li32(this.i0 + 12);
               mstate.esp -= 8;
               this.i3 = li32(mstate.ebp + 12);
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_push_as3_to_lua_stack_if_convertible.start();
               return;
            case 1:
               this.i4 = mstate.eax;
               this.i1 -= this.i2;
               mstate.esp += 8;
               this.i1 /= 12;
               this.i2 = this.i0 + 12;
               this.i5 = this.i0 + 8;
               if(this.i4 == 0)
               {
                  this.i4 = 4;
                  this.i6 = li32(this.i5);
                  this.i7 = li32(this.i2);
                  mstate.esp -= 4;
                  si32(this.i3,mstate.esp);
                  state = 2;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_Acquire]();
                  return;
               }
               addr2265:
               this.i3 = li32(this.i5);
               this.i4 = li32(this.i2);
               this.i3 -= this.i4;
               this.i4 = this.i1 + 1;
               this.i3 /= 12;
               if(this.i3 == this.i4)
               {
                  break;
               }
               §§goto(addr2300);
               break;
            case 2:
               mstate.esp += 4;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_lua_newuserdata.start();
               return;
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               si32(this.i3,this.i4);
               mstate.esp -= 8;
               this.i3 = -10000;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i3 = mstate.eax;
               this.i4 = this.i6 - this.i7;
               mstate.esp += 8;
               this.i6 = __2E_str1143;
               this.i4 /= 12;
               while(true)
               {
                  this.i7 = li8(this.i6 + 1);
                  this.i6 += 1;
                  this.i8 = this.i6;
                  if(this.i7 == 0)
                  {
                     break;
                  }
                  this.i6 = this.i8;
               }
               this.i7 = __2E_str1143;
               mstate.esp -= 12;
               this.i6 -= this.i7;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 5:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,mstate.ebp + -16);
               this.i6 = 4;
               si32(this.i6,mstate.ebp + -8);
               this.i6 = li32(this.i5);
               mstate.esp -= 16;
               this.i7 = mstate.ebp + -16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 6:
               mstate.esp += 16;
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               mstate.esp -= 8;
               this.i3 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 7:
               mstate.esp += 8;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i2);
               this.i7 = this.i4 + 1;
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i7)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr2265);
               break;
            case 8:
               mstate.esp += 8;
               this.i3 = li32(this.i0 + 16);
               this.i6 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               this.i8 = this.i0 + 16;
               if(uint(this.i6) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr635);
               break;
            case 9:
               mstate.esp += 4;
               addr635:
               this.i3 = __2E_str2144;
               this.i6 = li32(this.i5);
               mstate.esp -= 12;
               this.i9 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i6);
               this.i3 = 4;
               si32(this.i3,this.i6 + 8);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i8);
               this.i6 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i6) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr785);
               break;
            case 11:
               mstate.esp += 4;
               addr785:
               this.i3 = __2E_str1100;
               this.i6 = li32(this.i5);
               mstate.esp -= 12;
               this.i9 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 12:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i6);
               this.i3 = 4;
               si32(this.i3,this.i6 + 8);
               this.i3 = li32(this.i5);
               this.i6 = this.i3 + 12;
               si32(this.i6,this.i5);
               this.i6 = 1081135104;
               this.i9 = 0;
               si32(this.i9,this.i3 + 12);
               si32(this.i6,this.i3 + 16);
               this.i6 = 3;
               si32(this.i6,this.i3 + 20);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i8);
               this.i6 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i6) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr981);
               break;
            case 13:
               mstate.esp += 4;
               addr981:
               this.i3 = __2E_str2101;
               this.i6 = li32(this.i5);
               mstate.esp -= 12;
               this.i9 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i6);
               this.i3 = 4;
               si32(this.i3,this.i6 + 8);
               this.i3 = li32(this.i5);
               this.i6 = this.i3 + 12;
               si32(this.i6,this.i5);
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i3 + 12);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1170);
               break;
            case 15:
               mstate.esp += 4;
               addr1170:
               this.i3 = __2E_str3102;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i5);
               this.i6 = li32(this.i2);
               this.i4 -= this.i6;
               this.i4 /= 12;
               this.i4 += -7;
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i3 + 12);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1383);
               break;
            case 17:
               mstate.esp += 4;
               addr1383:
               this.i3 = __2E_str4103;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 18:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i5);
               this.f0 = Number(this.i7);
               sf64(this.f0,this.i3 + 12);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 19;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1572);
               break;
            case 19:
               mstate.esp += 4;
               addr1572:
               this.i3 = __2E_str10143;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i6 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 20:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 21;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1722);
               break;
            case 21:
               mstate.esp += 4;
               addr1722:
               this.i3 = 10;
               this.i4 = li32(this.i5);
               this.i6 = li32(this.i2);
               this.i4 -= this.i6;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 22:
               mstate.esp += 12;
               this.i3 = li32(this.i5);
               this.i3 += -108;
               si32(this.i3,this.i5);
               mstate.esp -= 8;
               this.i3 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 23:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i5);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i4);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               mstate.esp -= 8;
               this.i3 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 24:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i5);
               this.i6 = this.i3;
               this.i7 = this.i3 + 12;
               if(uint(this.i7) >= uint(this.i4))
               {
                  this.i3 = this.i4;
               }
               else
               {
                  this.i3 += 12;
                  this.i4 = this.i6;
                  while(true)
                  {
                     this.f0 = lf64(this.i4 + 12);
                     sf64(this.f0,this.i4);
                     this.i6 = li32(this.i4 + 20);
                     si32(this.i6,this.i4 + 8);
                     this.i4 = li32(this.i5);
                     this.i6 = this.i3 + 12;
                     this.i7 = this.i3;
                     if(uint(this.i6) >= uint(this.i4))
                     {
                        break;
                     }
                     this.i3 = this.i6;
                     this.i4 = this.i7;
                  }
                  this.i3 = this.i4;
               }
               this.i3 += -12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 25;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2107);
               break;
            case 25:
               mstate.esp += 4;
               addr2107:
               this.i3 = 2;
               this.i4 = li32(this.i5);
               this.i6 = li32(this.i2);
               this.i4 -= this.i6;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 26;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 26:
               mstate.esp += 12;
               this.i3 = li32(this.i5);
               this.i3 += -12;
               si32(this.i3,this.i5);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 27;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 27:
               mstate.esp += 4;
               this.i3 = li32(this.i5);
               this.i4 = li32(this.i2);
               this.i3 -= this.i4;
               this.i4 = this.i1 + 1;
               this.i3 /= 12;
               if(this.i3 != this.i4)
               {
                  addr2300:
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 28;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               break;
            case 28:
               mstate.esp += 8;
               this.i3 = li32(this.i0 + 16);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               this.i6 = this.i0 + 16;
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 29;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2404);
               break;
            case 29:
               mstate.esp += 4;
               addr2404:
               this.i3 = __2E_str2144;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 30;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 30:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i6);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 31;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2554);
               break;
            case 31:
               mstate.esp += 4;
               addr2554:
               this.i3 = __2E_str1100;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 32;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 32:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i5);
               this.i4 = 1081462784;
               this.i7 = 0;
               si32(this.i7,this.i3 + 12);
               si32(this.i4,this.i3 + 16);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i6);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 33;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2750);
               break;
            case 33:
               mstate.esp += 4;
               addr2750:
               this.i3 = __2E_str2101;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 34;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 34:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i5);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i3 + 12);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i6);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 35;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2939);
               break;
            case 35:
               mstate.esp += 4;
               addr2939:
               this.i3 = __2E_str3102;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 36;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 36:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i5);
               this.i7 = li32(this.i2);
               this.i4 -= this.i7;
               this.i4 /= 12;
               this.i4 += -7;
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i3 + 12);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i3 = li32(this.i6);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 37;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3152);
               break;
            case 37:
               mstate.esp += 4;
               addr3152:
               this.i3 = __2E_str4103;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 38;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 38:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i1 += 1;
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i5);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i3 + 12);
               this.i1 = 3;
               si32(this.i1,this.i3 + 20);
               this.i1 = li32(this.i5);
               this.i1 += 12;
               si32(this.i1,this.i5);
               this.i1 = li32(this.i6);
               this.i3 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i3) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 39;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3347);
               break;
            case 39:
               mstate.esp += 4;
               addr3347:
               this.i1 = __2E_str10143;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 40;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 40:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i3);
               this.i1 = 4;
               si32(this.i1,this.i3 + 8);
               this.i1 = li32(this.i5);
               this.i1 += 12;
               si32(this.i1,this.i5);
               this.i1 = li32(this.i6);
               this.i3 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i3) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 41;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3497);
               break;
            case 41:
               mstate.esp += 4;
               addr3497:
               this.i1 = 10;
               this.i3 = li32(this.i5);
               this.i4 = li32(this.i2);
               this.i3 -= this.i4;
               this.i3 /= 12;
               mstate.esp -= 12;
               this.i3 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 42;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 42:
               mstate.esp += 12;
               this.i1 = li32(this.i5);
               this.i1 += -108;
               si32(this.i1,this.i5);
               mstate.esp -= 8;
               this.i1 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 43:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i5);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i3);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i3 + 8);
               this.i1 = li32(this.i5);
               this.i1 += 12;
               si32(this.i1,this.i5);
               mstate.esp -= 8;
               this.i1 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 44:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i5);
               this.i4 = this.i1;
               this.i7 = this.i1 + 12;
               if(uint(this.i7) >= uint(this.i3))
               {
                  this.i1 = this.i3;
               }
               else
               {
                  this.i1 += 12;
                  this.i3 = this.i4;
                  while(true)
                  {
                     this.f0 = lf64(this.i3 + 12);
                     sf64(this.f0,this.i3);
                     this.i4 = li32(this.i3 + 20);
                     si32(this.i4,this.i3 + 8);
                     this.i3 = li32(this.i5);
                     this.i4 = this.i1 + 12;
                     this.i7 = this.i1;
                     if(uint(this.i4) >= uint(this.i3))
                     {
                        break;
                     }
                     this.i1 = this.i4;
                     this.i3 = this.i7;
                  }
                  this.i1 = this.i3;
               }
               this.i1 += -12;
               si32(this.i1,this.i5);
               this.i1 = li32(this.i6);
               this.i3 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i3) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 45;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3882);
               break;
            case 45:
               mstate.esp += 4;
               addr3882:
               this.i1 = 2;
               this.i3 = li32(this.i5);
               this.i2 = li32(this.i2);
               this.i2 = this.i3 - this.i2;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 46;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 46:
               mstate.esp += 12;
               this.i1 = li32(this.i5);
               this.i1 += -12;
               si32(this.i1,this.i5);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 47;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 47:
               mstate.esp += 4;
               break;
            default:
               throw "Invalid state in _push_as3_to_lua_stack";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
