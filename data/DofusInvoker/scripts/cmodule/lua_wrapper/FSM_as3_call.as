package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_as3_call extends Machine
   {
      
      public static const intRegCount:int = 13;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
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
      
      public function FSM_as3_call()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_as3_call = null;
         _loc1_ = new FSM_as3_call();
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
               this.i4 = li32(this.i1 + 8);
               this.i4 += 12;
               si32(this.i4,this.i1 + 8);
               mstate.esp -= 8;
               this.i4 = __2E_str1143;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checkudata.start();
               return;
            case 1:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i5 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               this.i2 -= this.i3;
               mstate.esp += 12;
               this.i2 /= 12;
               this.i3 = this.i1 + 12;
               this.i5 = this.i1 + 8;
               if(this.i0 == 0)
               {
                  this.i6 = __2E_str36243;
                  mstate.esp -= 12;
                  this.i7 = 2;
                  si32(this.i1,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               addr255:
               this.i6 = li32(this.i5);
               this.i7 = li32(this.i3);
               this.i6 -= this.i7;
               this.i7 = this.i2 + 1;
               this.i6 /= 12;
               if(this.i6 != this.i7)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr1988);
               break;
            case 3:
               mstate.esp += 12;
               §§goto(addr255);
            case 4:
               mstate.esp += 8;
               this.i6 = li32(this.i1 + 16);
               this.i8 = li32(this.i6 + 68);
               this.i6 = li32(this.i6 + 64);
               this.i9 = this.i1 + 16;
               if(uint(this.i8) >= uint(this.i6))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr394);
               break;
            case 5:
               mstate.esp += 4;
               addr394:
               this.i6 = __2E_str19226;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,this.i8);
               this.i6 = 4;
               si32(this.i6,this.i8 + 8);
               this.i6 = li32(this.i5);
               this.i6 += 12;
               si32(this.i6,this.i5);
               this.i6 = li32(this.i9);
               this.i8 = li32(this.i6 + 68);
               this.i6 = li32(this.i6 + 64);
               if(uint(this.i8) >= uint(this.i6))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr544);
               break;
            case 7:
               mstate.esp += 4;
               addr544:
               this.i6 = __2E_str1100;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 8:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,this.i8);
               this.i6 = 4;
               si32(this.i6,this.i8 + 8);
               this.i6 = li32(this.i5);
               this.i8 = this.i6 + 12;
               si32(this.i8,this.i5);
               this.i8 = 1081966592;
               this.i10 = 0;
               si32(this.i10,this.i6 + 12);
               si32(this.i8,this.i6 + 16);
               this.i8 = 3;
               si32(this.i8,this.i6 + 20);
               this.i6 = li32(this.i5);
               this.i6 += 12;
               si32(this.i6,this.i5);
               this.i6 = li32(this.i9);
               this.i8 = li32(this.i6 + 68);
               this.i6 = li32(this.i6 + 64);
               if(uint(this.i8) >= uint(this.i6))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr740);
               break;
            case 9:
               mstate.esp += 4;
               addr740:
               this.i6 = __2E_str2101;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,this.i8);
               this.i6 = 4;
               si32(this.i6,this.i8 + 8);
               this.i6 = li32(this.i5);
               this.i8 = this.i6 + 12;
               si32(this.i8,this.i5);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i6 + 12);
               this.i8 = 3;
               si32(this.i8,this.i6 + 20);
               this.i6 = li32(this.i5);
               this.i6 += 12;
               si32(this.i6,this.i5);
               this.i6 = li32(this.i9);
               this.i8 = li32(this.i6 + 68);
               this.i6 = li32(this.i6 + 64);
               if(uint(this.i8) >= uint(this.i6))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr929);
               break;
            case 11:
               mstate.esp += 4;
               addr929:
               this.i6 = __2E_str3102;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 12:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,this.i8);
               this.i6 = 4;
               si32(this.i6,this.i8 + 8);
               this.i6 = li32(this.i5);
               this.i8 = this.i6 + 12;
               si32(this.i8,this.i5);
               this.i10 = li32(this.i3);
               this.i8 -= this.i10;
               this.i8 /= 12;
               this.i8 += -7;
               this.f0 = Number(this.i8);
               sf64(this.f0,this.i6 + 12);
               this.i8 = 3;
               si32(this.i8,this.i6 + 20);
               this.i6 = li32(this.i5);
               this.i6 += 12;
               si32(this.i6,this.i5);
               this.i6 = li32(this.i9);
               this.i8 = li32(this.i6 + 68);
               this.i6 = li32(this.i6 + 64);
               if(uint(this.i8) >= uint(this.i6))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1142);
               break;
            case 13:
               mstate.esp += 4;
               addr1142:
               this.i6 = __2E_str4103;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,this.i8);
               this.i6 = 4;
               si32(this.i6,this.i8 + 8);
               this.i6 = li32(this.i5);
               this.i8 = this.i6 + 12;
               si32(this.i8,this.i5);
               this.f0 = Number(this.i7);
               sf64(this.f0,this.i6 + 12);
               this.i8 = 3;
               si32(this.i8,this.i6 + 20);
               this.i6 = li32(this.i5);
               this.i6 += 12;
               si32(this.i6,this.i5);
               this.i6 = li32(this.i9);
               this.i8 = li32(this.i6 + 68);
               this.i6 = li32(this.i6 + 64);
               if(uint(this.i8) >= uint(this.i6))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1331);
               break;
            case 15:
               mstate.esp += 4;
               addr1331:
               this.i6 = __2E_str10143;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,this.i8);
               this.i6 = 4;
               si32(this.i6,this.i8 + 8);
               this.i6 = li32(this.i5);
               this.i6 += 12;
               si32(this.i6,this.i5);
               this.i6 = li32(this.i9);
               this.i8 = li32(this.i6 + 68);
               this.i6 = li32(this.i6 + 64);
               if(uint(this.i8) >= uint(this.i6))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1481);
               break;
            case 17:
               mstate.esp += 4;
               addr1481:
               this.i6 = 10;
               this.i8 = li32(this.i5);
               this.i10 = li32(this.i3);
               this.i8 -= this.i10;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 18:
               mstate.esp += 12;
               this.i6 = li32(this.i5);
               this.i6 += -108;
               si32(this.i6,this.i5);
               mstate.esp -= 8;
               this.i6 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 19:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.f0 = lf64(this.i6);
               sf64(this.f0,this.i8);
               this.i6 = li32(this.i6 + 8);
               si32(this.i6,this.i8 + 8);
               this.i6 = li32(this.i5);
               this.i6 += 12;
               si32(this.i6,this.i5);
               mstate.esp -= 8;
               this.i6 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 20:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.i10 = this.i6;
               this.i11 = this.i6 + 12;
               if(uint(this.i11) >= uint(this.i8))
               {
                  this.i6 = this.i8;
               }
               else
               {
                  this.i6 += 12;
                  this.i8 = this.i10;
                  while(true)
                  {
                     this.f0 = lf64(this.i8 + 12);
                     sf64(this.f0,this.i8);
                     this.i10 = li32(this.i8 + 20);
                     si32(this.i10,this.i8 + 8);
                     this.i8 = li32(this.i5);
                     this.i10 = this.i6 + 12;
                     this.i11 = this.i6;
                     if(uint(this.i10) >= uint(this.i8))
                     {
                        break;
                     }
                     this.i6 = this.i10;
                     this.i8 = this.i11;
                  }
                  this.i6 = this.i8;
               }
               this.i6 += -12;
               si32(this.i6,this.i5);
               this.i6 = li32(this.i9);
               this.i8 = li32(this.i6 + 68);
               this.i6 = li32(this.i6 + 64);
               if(uint(this.i8) >= uint(this.i6))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 21;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1866);
               break;
            case 21:
               mstate.esp += 4;
               addr1866:
               this.i6 = 2;
               this.i8 = li32(this.i5);
               this.i9 = li32(this.i3);
               this.i8 -= this.i9;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 22:
               mstate.esp += 12;
               this.i6 = li32(this.i5);
               this.i6 += -12;
               si32(this.i6,this.i5);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 23;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 23:
               mstate.esp += 4;
               addr1988:
               this.i6 = 0;
               mstate.esp -= 16;
               this.i8 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 24;
               mstate.esp -= 4;
               FSM_create_as3_value_from_lua_stack.start();
               return;
            case 24:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               this.i8 = li32(this.i5);
               this.i9 = li32(this.i3);
               this.i8 -= this.i9;
               this.i8 /= 12;
               if(this.i8 != this.i7)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 25;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr3776);
               break;
            case 25:
               mstate.esp += 8;
               this.i8 = li32(this.i1 + 16);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               this.i10 = this.i1 + 16;
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 26;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2182);
               break;
            case 26:
               mstate.esp += 4;
               addr2182:
               this.i8 = __2E_str19226;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 27;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 27:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i9);
               this.i8 = 4;
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i10);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 28;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2332);
               break;
            case 28:
               mstate.esp += 4;
               addr2332:
               this.i8 = __2E_str1100;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 29;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 29:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i9);
               this.i8 = 4;
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i9 = this.i8 + 12;
               si32(this.i9,this.i5);
               this.i9 = 1081982976;
               this.i11 = 0;
               si32(this.i11,this.i8 + 12);
               si32(this.i9,this.i8 + 16);
               this.i9 = 3;
               si32(this.i9,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i10);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 30;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2528);
               break;
            case 30:
               mstate.esp += 4;
               addr2528:
               this.i8 = __2E_str2101;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 31;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 31:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i9);
               this.i8 = 4;
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i9 = this.i8 + 12;
               si32(this.i9,this.i5);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i8 + 12);
               this.i9 = 3;
               si32(this.i9,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i10);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 32;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2717);
               break;
            case 32:
               mstate.esp += 4;
               addr2717:
               this.i8 = __2E_str3102;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 33;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 33:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i9);
               this.i8 = 4;
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i9 = this.i8 + 12;
               si32(this.i9,this.i5);
               this.i11 = li32(this.i3);
               this.i9 -= this.i11;
               this.i9 /= 12;
               this.i9 += -7;
               this.f0 = Number(this.i9);
               sf64(this.f0,this.i8 + 12);
               this.i9 = 3;
               si32(this.i9,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i10);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 34;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2930);
               break;
            case 34:
               mstate.esp += 4;
               addr2930:
               this.i8 = __2E_str4103;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 35;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 35:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i9);
               this.i8 = 4;
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i9 = this.i8 + 12;
               si32(this.i9,this.i5);
               this.f0 = Number(this.i7);
               sf64(this.f0,this.i8 + 12);
               this.i9 = 3;
               si32(this.i9,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i10);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 36;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3119);
               break;
            case 36:
               mstate.esp += 4;
               addr3119:
               this.i8 = __2E_str10143;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 37:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i9);
               this.i8 = 4;
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i10);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 38;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3269);
               break;
            case 38:
               mstate.esp += 4;
               addr3269:
               this.i8 = 10;
               this.i9 = li32(this.i5);
               this.i11 = li32(this.i3);
               this.i9 -= this.i11;
               this.i9 /= 12;
               mstate.esp -= 12;
               this.i9 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 39;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 39:
               mstate.esp += 12;
               this.i8 = li32(this.i5);
               this.i8 += -108;
               si32(this.i8,this.i5);
               mstate.esp -= 8;
               this.i8 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 40:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i5);
               this.f0 = lf64(this.i8);
               sf64(this.f0,this.i9);
               this.i8 = li32(this.i8 + 8);
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               mstate.esp -= 8;
               this.i8 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 41:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i5);
               this.i11 = this.i8;
               this.i12 = this.i8 + 12;
               if(uint(this.i12) >= uint(this.i9))
               {
                  this.i8 = this.i9;
               }
               else
               {
                  this.i8 += 12;
                  this.i9 = this.i11;
                  while(true)
                  {
                     this.f0 = lf64(this.i9 + 12);
                     sf64(this.f0,this.i9);
                     this.i11 = li32(this.i9 + 20);
                     si32(this.i11,this.i9 + 8);
                     this.i9 = li32(this.i5);
                     this.i11 = this.i8 + 12;
                     this.i12 = this.i8;
                     if(uint(this.i11) >= uint(this.i9))
                     {
                        break;
                     }
                     this.i8 = this.i11;
                     this.i9 = this.i12;
                  }
                  this.i8 = this.i9;
               }
               this.i8 += -12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i10);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 42;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 42:
               mstate.esp += 4;
               break;
            case 43:
               mstate.esp += 12;
               this.i8 = li32(this.i5);
               this.i8 += -12;
               si32(this.i8,this.i5);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 44;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 44:
               mstate.esp += 4;
               addr3776:
               this.i4 = li32(this.i4);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 45;
               mstate.esp -= 4;
               mstate.funcs[_AS3_CallS]();
               return;
            case 45:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i4 = li32(this.i5);
               this.i8 = li32(this.i3);
               this.i4 -= this.i8;
               this.i4 += 11;
               if(uint(this.i4) <= uint(22))
               {
                  this.i0 = __2E_str157;
                  this.i1 = __2E_str37244;
                  trace(mstate.gworker.stringFromPtr(this.i0));
                  this.i0 = this.i1;
                  trace(mstate.gworker.stringFromPtr(this.i0));
                  mstate.esp -= 4;
                  this.i0 = -1;
                  si32(this.i0,mstate.esp);
                  state = 46;
                  mstate.esp -= 4;
                  FSM_exit.start();
                  return;
               }
               addr3925:
               this.i4 = li32(this.i5);
               this.i8 = li32(this.i3);
               this.i4 -= this.i8;
               this.i4 /= 12;
               if(this.i4 != this.i7)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 47;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr5652);
               break;
            case 46:
               mstate.esp += 4;
               §§goto(addr3925);
            case 47:
               mstate.esp += 8;
               this.i4 = li32(this.i1 + 16);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               this.i9 = this.i1 + 16;
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 48;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4058);
               break;
            case 48:
               mstate.esp += 4;
               addr4058:
               this.i4 = __2E_str19226;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 49;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 49:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 50;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4208);
               break;
            case 50:
               mstate.esp += 4;
               addr4208:
               this.i4 = __2E_str1100;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 51;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 51:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i5);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i5);
               this.i8 = 1082048512;
               this.i10 = 0;
               si32(this.i10,this.i4 + 12);
               si32(this.i8,this.i4 + 16);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 52;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4404);
               break;
            case 52:
               mstate.esp += 4;
               addr4404:
               this.i4 = __2E_str2101;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 53;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 53:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i5);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i5);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i4 + 12);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 54;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4593);
               break;
            case 54:
               mstate.esp += 4;
               addr4593:
               this.i4 = __2E_str3102;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 55;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 55:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i5);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i5);
               this.i10 = li32(this.i3);
               this.i8 -= this.i10;
               this.i8 /= 12;
               this.i8 += -7;
               this.f0 = Number(this.i8);
               sf64(this.f0,this.i4 + 12);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 56;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4806);
               break;
            case 56:
               mstate.esp += 4;
               addr4806:
               this.i4 = __2E_str4103;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 57;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 57:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i5);
               this.i8 = this.i4 + 12;
               si32(this.i8,this.i5);
               this.f0 = Number(this.i7);
               sf64(this.f0,this.i4 + 12);
               this.i8 = 3;
               si32(this.i8,this.i4 + 20);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 58;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4995);
               break;
            case 58:
               mstate.esp += 4;
               addr4995:
               this.i4 = __2E_str10143;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 59;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 59:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,this.i8);
               this.i4 = 4;
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 60;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5145);
               break;
            case 60:
               mstate.esp += 4;
               addr5145:
               this.i4 = 10;
               this.i8 = li32(this.i5);
               this.i10 = li32(this.i3);
               this.i8 -= this.i10;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 61;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 61:
               mstate.esp += 12;
               this.i4 = li32(this.i5);
               this.i4 += -108;
               si32(this.i4,this.i5);
               mstate.esp -= 8;
               this.i4 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 62:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i8);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i8 + 8);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               mstate.esp -= 8;
               this.i4 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 63:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
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
                     this.i8 = li32(this.i5);
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
               si32(this.i4,this.i5);
               this.i4 = li32(this.i9);
               this.i8 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i8) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 64;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5530);
               break;
            case 64:
               mstate.esp += 4;
               addr5530:
               this.i4 = 2;
               this.i8 = li32(this.i5);
               this.i9 = li32(this.i3);
               this.i8 -= this.i9;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 65;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 65:
               mstate.esp += 12;
               this.i4 = li32(this.i5);
               this.i4 += -12;
               si32(this.i4,this.i5);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 66;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 66:
               mstate.esp += 4;
               addr5652:
               this.i4 = li32(this.i5);
               this.i4 += -12;
               si32(this.i4,this.i5);
               mstate.esp -= 4;
               si32(this.i6,mstate.esp);
               state = 67;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 67:
               mstate.esp += 4;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 68;
               mstate.esp -= 4;
               FSM_push_as3_lua_userdata.start();
               return;
            case 68:
               mstate.esp += 8;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 69;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 69:
               mstate.esp += 4;
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i3);
               this.i0 -= this.i4;
               this.i0 /= 12;
               if(this.i0 != this.i7)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 70;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr7502);
               break;
            case 70:
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 16);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               this.i6 = this.i1 + 16;
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 71;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5908);
               break;
            case 71:
               mstate.esp += 4;
               addr5908:
               this.i0 = __2E_str19226;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 72;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 72:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i6);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 73;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6058);
               break;
            case 73:
               mstate.esp += 4;
               addr6058:
               this.i0 = __2E_str1100;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 74;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 74:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i5);
               this.i4 = this.i0 + 12;
               si32(this.i4,this.i5);
               this.i4 = 1082085376;
               this.i8 = 0;
               si32(this.i8,this.i0 + 12);
               si32(this.i4,this.i0 + 16);
               this.i4 = 3;
               si32(this.i4,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i6);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 75;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6254);
               break;
            case 75:
               mstate.esp += 4;
               addr6254:
               this.i0 = __2E_str2101;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 76;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 76:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i5);
               this.i4 = this.i0 + 12;
               si32(this.i4,this.i5);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i6);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 77;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6443);
               break;
            case 77:
               mstate.esp += 4;
               addr6443:
               this.i0 = __2E_str3102;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 78;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 78:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i5);
               this.i4 = li32(this.i3);
               this.i2 -= this.i4;
               this.i2 /= 12;
               this.i2 += -7;
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i6);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 79;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6656);
               break;
            case 79:
               mstate.esp += 4;
               addr6656:
               this.i0 = __2E_str4103;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 80;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 80:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i5);
               this.f0 = Number(this.i7);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i6);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 81;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6845);
               break;
            case 81:
               mstate.esp += 4;
               addr6845:
               this.i0 = __2E_str10143;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 82;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 82:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i6);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 83;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6995);
               break;
            case 83:
               mstate.esp += 4;
               addr6995:
               this.i0 = 10;
               this.i2 = li32(this.i5);
               this.i4 = li32(this.i3);
               this.i2 -= this.i4;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 84;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 84:
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
            case 85:
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
            case 86:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.i4 = this.i0;
               this.i7 = this.i0 + 12;
               if(uint(this.i7) >= uint(this.i2))
               {
                  this.i0 = this.i2;
               }
               else
               {
                  this.i0 += 12;
                  this.i2 = this.i4;
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i4 = li32(this.i2 + 20);
                     si32(this.i4,this.i2 + 8);
                     this.i2 = li32(this.i5);
                     this.i4 = this.i0 + 12;
                     this.i7 = this.i0;
                     if(uint(this.i4) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i0 = this.i4;
                     this.i2 = this.i7;
                  }
                  this.i0 = this.i2;
               }
               this.i0 += -12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i6);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 87;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7380);
               break;
            case 87:
               mstate.esp += 4;
               addr7380:
               this.i0 = 2;
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i3);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 88;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 88:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i0 += -12;
               si32(this.i0,this.i5);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 89;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 89:
               mstate.esp += 4;
               addr7502:
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _as3_call";
         }
         this.i8 = 2;
         this.i9 = li32(this.i5);
         this.i10 = li32(this.i3);
         this.i9 -= this.i10;
         this.i9 /= 12;
         mstate.esp -= 12;
         this.i9 += -1;
         si32(this.i1,mstate.esp);
         si32(this.i8,mstate.esp + 4);
         si32(this.i9,mstate.esp + 8);
         state = 43;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
