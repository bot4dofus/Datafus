package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_as3_invoke extends Machine
   {
      
      public static const intRegCount:int = 12;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var f0:Number;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public var i9:int;
      
      public function FSM_as3_invoke()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_as3_invoke = null;
         _loc1_ = new FSM_as3_invoke();
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
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 8;
               this.i0 = __2E_str1143;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checkudata.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 -= this.i3;
               this.i2 /= 12;
               this.i3 = li32(this.i1 + 8);
               this.i4 = li32(this.i1 + 12);
               this.i5 = this.i2 + 1;
               this.i6 = this.i1 + 12;
               this.i7 = this.i1 + 8;
               this.i3 -= this.i4;
               this.i3 /= 12;
               if(this.i3 != this.i5)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr1884);
               break;
            case 2:
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 16);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               this.i8 = this.i1 + 16;
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr290);
               break;
            case 3:
               mstate.esp += 4;
               addr290:
               this.i3 = __2E_str19226;
               this.i4 = li32(this.i7);
               mstate.esp -= 12;
               this.i9 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr440);
               break;
            case 5:
               mstate.esp += 4;
               addr440:
               this.i3 = __2E_str1100;
               this.i4 = li32(this.i7);
               mstate.esp -= 12;
               this.i9 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i7);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i7);
               this.i4 = 1081749504;
               this.i9 = 0;
               si32(this.i9,this.i3 + 12);
               si32(this.i4,this.i3 + 16);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr636);
               break;
            case 7:
               mstate.esp += 4;
               addr636:
               this.i3 = __2E_str2101;
               this.i4 = li32(this.i7);
               mstate.esp -= 12;
               this.i9 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 8:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i7);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i7);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i3 + 12);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr825);
               break;
            case 9:
               mstate.esp += 4;
               addr825:
               this.i3 = __2E_str3102;
               this.i4 = li32(this.i7);
               mstate.esp -= 12;
               this.i9 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i7);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i7);
               this.i9 = li32(this.i6);
               this.i4 -= this.i9;
               this.i4 /= 12;
               this.i4 += -7;
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i3 + 12);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1038);
               break;
            case 11:
               mstate.esp += 4;
               addr1038:
               this.i3 = __2E_str4103;
               this.i4 = li32(this.i7);
               mstate.esp -= 12;
               this.i9 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 12:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i7);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i7);
               this.f0 = Number(this.i5);
               sf64(this.f0,this.i3 + 12);
               this.i4 = 3;
               si32(this.i4,this.i3 + 20);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1227);
               break;
            case 13:
               mstate.esp += 4;
               addr1227:
               this.i3 = __2E_str10143;
               this.i4 = li32(this.i7);
               mstate.esp -= 12;
               this.i9 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1377);
               break;
            case 15:
               mstate.esp += 4;
               addr1377:
               this.i3 = 10;
               this.i4 = li32(this.i7);
               this.i9 = li32(this.i6);
               this.i4 -= this.i9;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 16:
               mstate.esp += 12;
               this.i3 = li32(this.i7);
               this.i3 += -108;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               this.i3 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 17:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i7);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i4);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               this.i3 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 18:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i7);
               this.i9 = this.i3;
               this.i10 = this.i3 + 12;
               if(uint(this.i10) >= uint(this.i4))
               {
                  this.i3 = this.i4;
               }
               else
               {
                  this.i3 += 12;
                  this.i4 = this.i9;
                  while(true)
                  {
                     this.f0 = lf64(this.i4 + 12);
                     sf64(this.f0,this.i4);
                     this.i9 = li32(this.i4 + 20);
                     si32(this.i9,this.i4 + 8);
                     this.i4 = li32(this.i7);
                     this.i9 = this.i3 + 12;
                     this.i10 = this.i3;
                     if(uint(this.i9) >= uint(this.i4))
                     {
                        break;
                     }
                     this.i3 = this.i9;
                     this.i4 = this.i10;
                  }
                  this.i3 = this.i4;
               }
               this.i3 += -12;
               si32(this.i3,this.i7);
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 19;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1762);
               break;
            case 19:
               mstate.esp += 4;
               addr1762:
               this.i3 = 2;
               this.i4 = li32(this.i7);
               this.i8 = li32(this.i6);
               this.i4 -= this.i8;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 20:
               mstate.esp += 12;
               this.i3 = li32(this.i7);
               this.i3 += -12;
               si32(this.i3,this.i7);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 21;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 21:
               mstate.esp += 4;
               addr1884:
               this.i3 = 0;
               mstate.esp -= 16;
               this.i4 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 22;
               mstate.esp -= 4;
               FSM_create_as3_value_from_lua_stack.start();
               return;
            case 22:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               this.i4 = li32(this.i7);
               this.i8 = li32(this.i6);
               this.i4 -= this.i8;
               this.i4 /= 12;
               if(this.i4 != this.i5)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 23;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr3672);
               break;
            case 23:
               mstate.esp += 8;
               this.i4 = li32(this.i1 + 16);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               this.i9 = this.i1 + 16;
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 24;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2078);
               break;
            case 24:
               mstate.esp += 4;
               addr2078:
               this.i4 = __2E_str19226;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 25;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 25:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 26;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2228);
               break;
            case 26:
               mstate.esp += 4;
               addr2228:
               this.i4 = __2E_str1100;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 27;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 27:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i7);
               this.i8 = 1081765888;
               this.i10 = 0;
               si32(this.i10,this.i4 + 12);
               si32(this.i8,this.i4 + 16);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 28;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2424);
               break;
            case 28:
               mstate.esp += 4;
               addr2424:
               this.i4 = __2E_str2101;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 29;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 29:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i7);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i4 + 12);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 30;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2613);
               break;
            case 30:
               mstate.esp += 4;
               addr2613:
               this.i4 = __2E_str3102;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 31;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 31:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i7);
               this.i10 = li32(this.i6);
               this.i8 -= this.i10;
               this.i8 /= 12;
               this.i8 += -7;
               this.f0 = Number(this.i8);
               sf64(this.f0,this.i4 + 12);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 32;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2826);
               break;
            case 32:
               mstate.esp += 4;
               addr2826:
               this.i4 = __2E_str4103;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 33;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 33:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i7);
               this.f0 = Number(this.i5);
               sf64(this.f0,this.i4 + 12);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 34;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3015);
               break;
            case 34:
               mstate.esp += 4;
               addr3015:
               this.i4 = __2E_str10143;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 35;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 35:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 36;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3165);
               break;
            case 36:
               mstate.esp += 4;
               addr3165:
               this.i4 = 10;
               this.i8 = li32(this.i7);
               this.i10 = li32(this.i6);
               this.i8 -= this.i10;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 37:
               mstate.esp += 12;
               this.i4 = li32(this.i7);
               this.i4 += -108;
               si32(this.i4,this.i7);
               mstate.esp -= 8;
               this.i4 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 38:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i7);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i8);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               mstate.esp -= 8;
               this.i4 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 39:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i7);
               this.i10 = this.i4;
               this.i11 = this.i4 + 12;
               if(uint(this.i11) >= uint(this.i8))
               {
                  this.i4 = this.i8;
               }
               else
               {
                  this.i4 += 12;
                  this.i8 = this.i10;
                  while(true)
                  {
                     this.f0 = lf64(this.i8 + 12);
                     sf64(this.f0,this.i8);
                     this.i10 = li32(this.i8 + 20);
                     si32(this.i10,this.i8 + 8);
                     this.i8 = li32(this.i7);
                     this.i10 = this.i4 + 12;
                     this.i11 = this.i4;
                     if(uint(this.i10) >= uint(this.i8))
                     {
                        break;
                     }
                     this.i4 = this.i10;
                     this.i8 = this.i11;
                  }
                  this.i4 = this.i8;
               }
               this.i4 += -12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 40;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3550);
               break;
            case 40:
               mstate.esp += 4;
               addr3550:
               this.i4 = 2;
               this.i8 = li32(this.i7);
               this.i9 = li32(this.i6);
               this.i8 -= this.i9;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 41;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 41:
               mstate.esp += 12;
               this.i4 = li32(this.i7);
               this.i4 += -12;
               si32(this.i4,this.i7);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 42;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 42:
               mstate.esp += 4;
               addr3672:
               state = 43;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Undefined]();
               return;
            case 43:
               this.i4 = mstate.eax;
               this.i0 = li32(this.i0);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 44;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Call]();
               return;
            case 44:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i4 = li32(this.i7);
               this.i8 = li32(this.i6);
               this.i4 -= this.i8;
               this.i4 += 11;
               if(uint(this.i4) <= uint(22))
               {
                  this.i0 = __2E_str157;
                  this.i1 = __2E_str35242;
                  trace(mstate.gworker.stringFromPtr(this.i0));
                  this.i0 = this.i1;
                  trace(mstate.gworker.stringFromPtr(this.i0));
                  mstate.esp -= 4;
                  this.i0 = -1;
                  si32(this.i0,mstate.esp);
                  state = 45;
                  mstate.esp -= 4;
                  FSM_exit.start();
                  return;
               }
               addr3843:
               this.i4 = li32(this.i7);
               this.i8 = li32(this.i6);
               this.i4 -= this.i8;
               this.i4 /= 12;
               if(this.i4 != this.i5)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 46;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr5570);
               break;
            case 45:
               mstate.esp += 4;
               §§goto(addr3843);
            case 46:
               mstate.esp += 8;
               this.i4 = li32(this.i1 + 16);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               this.i9 = this.i1 + 16;
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 47;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3976);
               break;
            case 47:
               mstate.esp += 4;
               addr3976:
               this.i4 = __2E_str19226;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 48;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 48:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 49;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4126);
               break;
            case 49:
               mstate.esp += 4;
               addr4126:
               this.i4 = __2E_str1100;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 50;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 50:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i7);
               this.i8 = 1081827328;
               this.i10 = 0;
               si32(this.i10,this.i4 + 12);
               si32(this.i8,this.i4 + 16);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 51;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4322);
               break;
            case 51:
               mstate.esp += 4;
               addr4322:
               this.i4 = __2E_str2101;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 52;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 52:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i7);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i4 + 12);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 53;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4511);
               break;
            case 53:
               mstate.esp += 4;
               addr4511:
               this.i4 = __2E_str3102;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 54;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 54:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i7);
               this.i10 = li32(this.i6);
               this.i8 -= this.i10;
               this.i8 /= 12;
               this.i8 += -7;
               this.f0 = Number(this.i8);
               sf64(this.f0,this.i4 + 12);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 55;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4724);
               break;
            case 55:
               mstate.esp += 4;
               addr4724:
               this.i4 = __2E_str4103;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 56;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 56:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i7);
               this.f0 = Number(this.i5);
               sf64(this.f0,this.i4 + 12);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 57;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4913);
               break;
            case 57:
               mstate.esp += 4;
               addr4913:
               this.i4 = __2E_str10143;
               this.i8 = li32(this.i7);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 58;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 58:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 59;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5063);
               break;
            case 59:
               mstate.esp += 4;
               addr5063:
               this.i4 = 10;
               this.i8 = li32(this.i7);
               this.i10 = li32(this.i6);
               this.i8 -= this.i10;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 60;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 60:
               mstate.esp += 12;
               this.i4 = li32(this.i7);
               this.i4 += -108;
               si32(this.i4,this.i7);
               mstate.esp -= 8;
               this.i4 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 61:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i7);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i8);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i7);
               this.i4 += 12;
               si32(this.i4,this.i7);
               mstate.esp -= 8;
               this.i4 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 62:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i7);
               this.i10 = this.i4;
               this.i11 = this.i4 + 12;
               if(uint(this.i11) >= uint(this.i8))
               {
                  this.i4 = this.i8;
               }
               else
               {
                  this.i4 += 12;
                  this.i8 = this.i10;
                  while(true)
                  {
                     this.f0 = lf64(this.i8 + 12);
                     sf64(this.f0,this.i8);
                     this.i10 = li32(this.i8 + 20);
                     si32(this.i10,this.i8 + 8);
                     this.i8 = li32(this.i7);
                     this.i10 = this.i4 + 12;
                     this.i11 = this.i4;
                     if(uint(this.i10) >= uint(this.i8))
                     {
                        break;
                     }
                     this.i4 = this.i10;
                     this.i8 = this.i11;
                  }
                  this.i4 = this.i8;
               }
               this.i4 += -12;
               si32(this.i4,this.i7);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 63;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 63:
               mstate.esp += 4;
               break;
            case 64:
               mstate.esp += 12;
               this.i4 = li32(this.i7);
               this.i4 += -12;
               si32(this.i4,this.i7);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 65;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 65:
               mstate.esp += 4;
               addr5570:
               this.i4 = li32(this.i7);
               this.i4 += -12;
               si32(this.i4,this.i7);
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               state = 66;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 66:
               mstate.esp += 4;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 67;
               mstate.esp -= 4;
               FSM_push_as3_lua_userdata.start();
               return;
            case 67:
               mstate.esp += 8;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 68;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 68:
               mstate.esp += 4;
               this.i0 = li32(this.i7);
               this.i3 = li32(this.i6);
               this.i0 -= this.i3;
               this.i0 /= 12;
               if(this.i0 != this.i5)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 69;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr7420);
               break;
            case 69:
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 16);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               this.i4 = this.i1 + 16;
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 70;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5826);
               break;
            case 70:
               mstate.esp += 4;
               addr5826:
               this.i0 = __2E_str19226;
               this.i3 = li32(this.i7);
               mstate.esp -= 12;
               this.i8 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 71;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 71:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               this.i0 = li32(this.i4);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 72;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5976);
               break;
            case 72:
               mstate.esp += 4;
               addr5976:
               this.i0 = __2E_str1100;
               this.i3 = li32(this.i7);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 73;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 73:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i7);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i7);
               this.i3 = 1081864192;
               this.i8 = 0;
               si32(this.i8,this.i0 + 12);
               si32(this.i3,this.i0 + 16);
               this.i3 = 3;
               si32(this.i3,this.i0 + 20);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               this.i0 = li32(this.i4);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 74;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6172);
               break;
            case 74:
               mstate.esp += 4;
               addr6172:
               this.i0 = __2E_str2101;
               this.i3 = li32(this.i7);
               mstate.esp -= 12;
               this.i8 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 75;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 75:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i7);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i7);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               this.i0 = li32(this.i4);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 76;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6361);
               break;
            case 76:
               mstate.esp += 4;
               addr6361:
               this.i0 = __2E_str3102;
               this.i2 = li32(this.i7);
               mstate.esp -= 12;
               this.i3 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 77;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 77:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i7);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i7);
               this.i3 = li32(this.i6);
               this.i2 -= this.i3;
               this.i2 /= 12;
               this.i2 += -7;
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               this.i0 = li32(this.i4);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 78;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6574);
               break;
            case 78:
               mstate.esp += 4;
               addr6574:
               this.i0 = __2E_str4103;
               this.i2 = li32(this.i7);
               mstate.esp -= 12;
               this.i3 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 79;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 79:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i7);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i7);
               this.f0 = Number(this.i5);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               this.i0 = li32(this.i4);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 80;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6763);
               break;
            case 80:
               mstate.esp += 4;
               addr6763:
               this.i0 = __2E_str10143;
               this.i2 = li32(this.i7);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 81;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 81:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               this.i0 = li32(this.i4);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 82;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6913);
               break;
            case 82:
               mstate.esp += 4;
               addr6913:
               this.i0 = 10;
               this.i2 = li32(this.i7);
               this.i3 = li32(this.i6);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 83;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 83:
               mstate.esp += 12;
               this.i0 = li32(this.i7);
               this.i0 += -108;
               si32(this.i0,this.i7);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 84:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i7);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               mstate.esp -= 8;
               this.i0 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 85:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i7);
               this.i3 = this.i0;
               this.i5 = this.i0 + 12;
               if(uint(this.i5) >= uint(this.i2))
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
                     this.i2 = li32(this.i7);
                     this.i3 = this.i0 + 12;
                     this.i5 = this.i0;
                     if(uint(this.i3) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i0 = this.i3;
                     this.i2 = this.i5;
                  }
                  this.i0 = this.i2;
               }
               this.i0 += -12;
               si32(this.i0,this.i7);
               this.i0 = li32(this.i4);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 86;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7298);
               break;
            case 86:
               mstate.esp += 4;
               addr7298:
               this.i0 = 2;
               this.i2 = li32(this.i7);
               this.i3 = li32(this.i6);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 87;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 87:
               mstate.esp += 12;
               this.i0 = li32(this.i7);
               this.i0 += -12;
               si32(this.i0,this.i7);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 88;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 88:
               mstate.esp += 4;
               addr7420:
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _as3_invoke";
         }
         this.i4 = 2;
         this.i8 = li32(this.i7);
         this.i9 = li32(this.i6);
         this.i8 -= this.i9;
         this.i8 /= 12;
         mstate.esp -= 12;
         this.i8 += -1;
         si32(this.i1,mstate.esp);
         si32(this.i4,mstate.esp + 4);
         si32(this.i8,mstate.esp + 8);
         state = 64;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
