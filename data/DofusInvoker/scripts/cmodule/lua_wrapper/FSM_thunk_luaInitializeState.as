package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_thunk_luaInitializeState extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 2;
       
      
      public var f1:Number;
      
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
      
      public function FSM_thunk_luaInitializeState()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_thunk_luaInitializeState = null;
         _loc1_ = new FSM_thunk_luaInitializeState();
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
               mstate.esp -= 128;
               this.i0 = __2E_str45;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[_AS3_ArrayValue]();
               return;
            case 1:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i0 = 348;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i1 = 0;
                  si32(this.i1,this.i0);
                  this.i2 = 8;
                  si8(this.i2,this.i0 + 4);
                  this.i2 = 33;
                  si8(this.i2,this.i0 + 132);
                  this.i2 = 97;
                  si8(this.i2,this.i0 + 5);
                  this.i2 = this.i0 + 112;
                  si32(this.i2,this.i0 + 16);
                  si32(this.i1,this.i0 + 32);
                  si32(this.i1,this.i0 + 44);
                  si32(this.i1,this.i0 + 104);
                  si32(this.i1,this.i0 + 68);
                  si8(this.i1,this.i0 + 56);
                  si32(this.i1,this.i0 + 60);
                  this.i2 = 1;
                  si8(this.i2,this.i0 + 57);
                  this.i2 = li32(this.i0 + 60);
                  si32(this.i2,this.i0 + 64);
                  si32(this.i1,this.i0 + 96);
                  si32(this.i1,this.i0 + 48);
                  si16(this.i1,this.i0 + 54);
                  si16(this.i1,this.i0 + 52);
                  si8(this.i1,this.i0 + 6);
                  si32(this.i1,this.i0 + 20);
                  si32(this.i1,this.i0 + 40);
                  si32(this.i1,this.i0 + 24);
                  si32(this.i1,this.i0 + 108);
                  si32(this.i1,this.i0 + 80);
                  this.i2 = _l_alloc;
                  si32(this.i2,this.i0 + 124);
                  si32(this.i1,this.i0 + 128);
                  si32(this.i0,this.i0 + 216);
                  this.i2 = this.i0 + 220;
                  si32(this.i2,this.i0 + 232);
                  si32(this.i2,this.i0 + 236);
                  si32(this.i1,this.i0 + 176);
                  si32(this.i1,this.i0 + 120);
                  si32(this.i1,this.i0 + 116);
                  si32(this.i1,this.i0 + 112);
                  this.i2 = li32(this.i0 + 16);
                  si32(this.i1,this.i2 + 100);
                  si32(this.i1,this.i0 + 164);
                  si32(this.i1,this.i0 + 172);
                  si32(this.i1,this.i0 + 200);
                  si8(this.i1,this.i0 + 133);
                  si32(this.i0,this.i0 + 140);
                  si32(this.i1,this.i0 + 136);
                  this.i2 = this.i0 + 140;
                  si32(this.i2,this.i0 + 144);
                  si32(this.i1,this.i0 + 148);
                  si32(this.i1,this.i0 + 152);
                  si32(this.i1,this.i0 + 156);
                  si32(this.i1,this.i0 + 160);
                  this.i2 = 348;
                  si32(this.i2,this.i0 + 180);
                  this.i2 = 200;
                  si32(this.i2,this.i0 + 192);
                  si32(this.i2,this.i0 + 196);
                  si32(this.i1,this.i0 + 188);
                  si32(this.i1,this.i0 + 244);
                  si32(this.i1,this.i0 + 248);
                  si32(this.i1,this.i0 + 252);
                  si32(this.i1,this.i0 + 256);
                  si32(this.i1,this.i0 + 260);
                  si32(this.i1,this.i0 + 264);
                  si32(this.i1,this.i0 + 268);
                  si32(this.i1,this.i0 + 272);
                  si32(this.i1,this.i0 + 276);
                  si32(this.i1,mstate.ebp + -76);
                  this.i1 = li32(this.i0 + 104);
                  this.i2 = mstate.ebp + -128;
                  si32(this.i1,mstate.ebp + -128);
                  si32(this.i2,this.i0 + 104);
                  mstate.esp -= 4;
                  this.i1 = this.i2 + 4;
                  si32(this.i1,mstate.esp);
                  state = 3;
                  mstate.esp -= 4;
                  mstate.funcs[__setjmp]();
                  return;
               }
               this.i0 = 0;
               addr783:
               if(this.i0 != 0)
               {
                  this.i1 = _panic;
                  this.i2 = li32(this.i0 + 16);
                  si32(this.i1,this.i2 + 88);
                  this.i1 = li32(this.i0 + 16);
                  this.i2 = _panic_handler;
                  si32(this.i2,this.i1 + 88);
                  this.i1 = li32(this.i0 + 8);
                  this.i2 = li32(this.i0 + 12);
                  mstate.esp -= 12;
                  this.i3 = 0;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_lua_gc.start();
                  return;
               }
               this.i0 = __2E_str9108;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               this.i0 = 0;
               §§goto(addr9303);
               break;
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               this.i3 = this.i2 + 52;
               this.i4 = this.i0 + 104;
               if(this.i1 == 0)
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_f_luaopen391.start();
                  return;
               }
               addr724:
               this.i1 = li32(this.i2);
               si32(this.i1,this.i4);
               this.i1 = li32(this.i3);
               if(this.i1 != 0)
               {
                  this.i1 = 0;
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_close_state.start();
                  return;
               }
               §§goto(addr783);
               break;
            case 4:
               mstate.esp += 4;
               §§goto(addr724);
            case 5:
               mstate.esp += 4;
               this.i0 = this.i1;
               §§goto(addr783);
            case 6:
               this.i3 = mstate.eax;
               this.i1 -= this.i2;
               mstate.esp += 12;
               this.i2 = _lualibs;
               this.i1 /= 12;
               this.i3 = this.i0 + 12;
               this.i4 = this.i0 + 8;
               this.i5 = this.i0 + 16;
               §§goto(addr927);
            case 7:
               mstate.esp += 12;
               this.i7 = li32(this.i2);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_lua_pushstring.start();
               return;
            case 8:
               mstate.esp += 8;
               this.i7 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 += -24;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
            case 9:
               mstate.esp += 12;
               this.i6 = li32(this.i2 + 12);
               this.i2 += 8;
               if(this.i6 != 0)
               {
                  addr927:
                  this.i6 = 0;
                  this.i7 = li32(this.i2 + 4);
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_lua_pushcclosure.start();
                  return;
               }
               this.i2 = li32(this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               if(this.i2 != this.i1)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 10;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               this.i2 = __2E_str185;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 30;
               mstate.esp -= 4;
               FSM_luaL_newmetatable.start();
               return;
               break;
            case 10:
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1222);
               break;
            case 11:
               mstate.esp += 4;
               addr1222:
               this.i2 = __2E_str99;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 14;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 12:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1372);
               break;
            case 13:
               mstate.esp += 4;
               addr1372:
               this.i2 = __2E_str1100;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i4);
               this.i6 = 1078657024;
               this.i7 = 0;
               si32(this.i7,this.i2 + 12);
               si32(this.i6,this.i2 + 16);
               this.i6 = 3;
               si32(this.i6,this.i2 + 20);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1568);
               break;
            case 15:
               mstate.esp += 4;
               addr1568:
               this.i2 = __2E_str2101;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i4);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i2 + 12);
               this.i1 = 3;
               si32(this.i1,this.i2 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1757);
               break;
            case 17:
               mstate.esp += 4;
               addr1757:
               this.i1 = __2E_str3102;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 18:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               this.i2 += -7;
               this.f1 = Number(this.i2);
               sf64(this.f1,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 19;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1970);
               break;
            case 19:
               mstate.esp += 4;
               addr1970:
               this.i1 = __2E_str4103;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 20:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i4);
               sf64(this.f0,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 21;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2153);
               break;
            case 21:
               mstate.esp += 4;
               addr2153:
               this.i1 = __2E_str10143;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 22:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 23;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2303);
               break;
            case 23:
               mstate.esp += 4;
               addr2303:
               this.i1 = 10;
               this.i2 = li32(this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 24;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 24:
               mstate.esp += 12;
               this.i1 = li32(this.i4);
               this.i1 += -108;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               this.i1 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 25:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i2);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               this.i1 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 26:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.i6 = this.i1;
               this.i7 = this.i1 + 12;
               if(uint(this.i7) >= uint(this.i2))
               {
                  this.i1 = this.i2;
               }
               else
               {
                  this.i1 += 12;
                  this.i2 = this.i6;
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i6 = li32(this.i2 + 20);
                     si32(this.i6,this.i2 + 8);
                     this.i2 = li32(this.i4);
                     this.i6 = this.i1 + 12;
                     this.i7 = this.i1;
                     if(uint(this.i6) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i1 = this.i6;
                     this.i2 = this.i7;
                  }
                  this.i1 = this.i2;
               }
               this.i1 += -12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i5 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i5) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 27;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 27:
               mstate.esp += 4;
               break;
            case 28:
               mstate.esp += 12;
               this.i1 = li32(this.i4);
               this.i1 += -12;
               si32(this.i1,this.i4);
               mstate.esp -= 12;
               this.i1 = 0;
               this.i3 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 29;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 29:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i4);
               this.i0 += -12;
               si32(this.i0,this.i4);
               this.i0 = __2E_str157;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i1;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               §§goto(addr9276);
            case 30:
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i2 = _release_callback;
               this.i6 = 0;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 31;
               mstate.esp -= 4;
               FSM_lua_pushcclosure.start();
               return;
            case 31:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 32:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i6 = __2E_str1186;
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
               this.i7 = __2E_str1186;
               mstate.esp -= 12;
               this.i6 -= this.i7;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 33;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 33:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,mstate.ebp + -32);
               this.i6 = 4;
               si32(this.i6,mstate.ebp + -24);
               this.i6 = li32(this.i4);
               mstate.esp -= 16;
               this.i6 += -12;
               this.i7 = mstate.ebp + -32;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 34;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 34:
               mstate.esp += 16;
               this.i2 = li32(this.i4);
               this.i2 += -24;
               si32(this.i2,this.i4);
               mstate.esp -= 8;
               this.i2 = 0;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 35;
               mstate.esp -= 4;
               FSM_lua_createtable.start();
               return;
            case 35:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = -10000;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 36:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i6 = __2E_str2187;
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
               this.i7 = __2E_str2187;
               mstate.esp -= 12;
               this.i6 -= this.i7;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 37:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,mstate.ebp + -16);
               this.i6 = 4;
               si32(this.i6,mstate.ebp + -8);
               this.i6 = li32(this.i4);
               mstate.esp -= 16;
               this.i6 += -12;
               this.i7 = mstate.ebp + -16;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 38;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 38:
               mstate.esp += 16;
               this.i2 = li32(this.i4);
               this.i2 += -12;
               si32(this.i2,this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               if(this.i2 != this.i1)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 39;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               this.i2 = __2E_str1143;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 57;
               mstate.esp -= 4;
               FSM_luaL_newmetatable.start();
               return;
               break;
            case 39:
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 40;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3604);
               break;
            case 40:
               mstate.esp += 4;
               addr3604:
               this.i2 = __2E_str99;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 14;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 41;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 41:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 42;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3754);
               break;
            case 42:
               mstate.esp += 4;
               addr3754:
               this.i2 = __2E_str1100;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 43;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 43:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i4);
               this.i6 = 1078788096;
               this.i7 = 0;
               si32(this.i7,this.i2 + 12);
               si32(this.i6,this.i2 + 16);
               this.i6 = 3;
               si32(this.i6,this.i2 + 20);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 44;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3950);
               break;
            case 44:
               mstate.esp += 4;
               addr3950:
               this.i2 = __2E_str2101;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 45;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 45:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i4);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i2 + 12);
               this.i1 = 3;
               si32(this.i1,this.i2 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 46;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4139);
               break;
            case 46:
               mstate.esp += 4;
               addr4139:
               this.i1 = __2E_str3102;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 47;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 47:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               this.i2 += -7;
               this.f1 = Number(this.i2);
               sf64(this.f1,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 48;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4352);
               break;
            case 48:
               mstate.esp += 4;
               addr4352:
               this.i1 = __2E_str4103;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 49;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 49:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i4);
               sf64(this.f0,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 50;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4535);
               break;
            case 50:
               mstate.esp += 4;
               addr4535:
               this.i1 = __2E_str10143;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 51;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 51:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 52;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4685);
               break;
            case 52:
               mstate.esp += 4;
               addr4685:
               this.i1 = 10;
               this.i2 = li32(this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 53;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 53:
               mstate.esp += 12;
               this.i1 = li32(this.i4);
               this.i1 += -108;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               this.i1 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 54:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i2);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               this.i1 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 55:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.i6 = this.i1;
               this.i7 = this.i1 + 12;
               if(uint(this.i7) >= uint(this.i2))
               {
                  this.i1 = this.i2;
               }
               else
               {
                  this.i1 += 12;
                  this.i2 = this.i6;
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i6 = li32(this.i2 + 20);
                     si32(this.i6,this.i2 + 8);
                     this.i2 = li32(this.i4);
                     this.i6 = this.i1 + 12;
                     this.i7 = this.i1;
                     if(uint(this.i6) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i1 = this.i6;
                     this.i2 = this.i7;
                  }
                  this.i1 = this.i2;
               }
               this.i1 += -12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i5 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i5) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 56;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               addr5072:
               break;
               addr5072:
               break;
            case 56:
               mstate.esp += 4;
               §§goto(addr5072);
            case 57:
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i2 = _as3_release;
               this.i6 = 0;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 58;
               mstate.esp -= 4;
               FSM_lua_pushcclosure.start();
               return;
            case 58:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 59:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i6 = __2E_str1186;
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
               this.i7 = __2E_str1186;
               mstate.esp -= 12;
               this.i6 -= this.i7;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 60;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 60:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,mstate.ebp + -48);
               this.i6 = 4;
               si32(this.i6,mstate.ebp + -40);
               this.i6 = li32(this.i4);
               mstate.esp -= 16;
               this.i6 += -12;
               this.i7 = mstate.ebp + -48;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 61;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 61:
               mstate.esp += 16;
               this.i2 = li32(this.i4);
               this.i2 += -24;
               si32(this.i2,this.i4);
               mstate.esp -= 12;
               this.i2 = __2E_str18175;
               this.i6 = _AS3_LUA_LIB;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 62;
               mstate.esp -= 4;
               FSM_luaL_register.start();
               return;
            case 62:
               mstate.esp += 12;
               this.i2 = li32(this.i4);
               this.i2 += -12;
               si32(this.i2,this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               if(this.i2 != this.i1)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 63;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 81;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7112);
               break;
            case 63:
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 64;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5586);
               break;
            case 64:
               mstate.esp += 4;
               addr5586:
               this.i2 = __2E_str99;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 14;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 65;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 65:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 66;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5736);
               break;
            case 66:
               mstate.esp += 4;
               addr5736:
               this.i2 = __2E_str1100;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 67;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 67:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i4);
               this.i6 = 1078919168;
               this.i7 = 0;
               si32(this.i7,this.i2 + 12);
               si32(this.i6,this.i2 + 16);
               this.i6 = 3;
               si32(this.i6,this.i2 + 20);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 68;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5932);
               break;
            case 68:
               mstate.esp += 4;
               addr5932:
               this.i2 = __2E_str2101;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 69;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 69:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i4);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i2 + 12);
               this.i1 = 3;
               si32(this.i1,this.i2 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 70;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6121);
               break;
            case 70:
               mstate.esp += 4;
               addr6121:
               this.i1 = __2E_str3102;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 71;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 71:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               this.i2 += -7;
               this.f1 = Number(this.i2);
               sf64(this.f1,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 72;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6334);
               break;
            case 72:
               mstate.esp += 4;
               addr6334:
               this.i1 = __2E_str4103;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 73;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 73:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i4);
               sf64(this.f0,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 74;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6517);
               break;
            case 74:
               mstate.esp += 4;
               addr6517:
               this.i1 = __2E_str10143;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 75;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 75:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 76;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6667);
               break;
            case 76:
               mstate.esp += 4;
               addr6667:
               this.i1 = 10;
               this.i2 = li32(this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 77;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 77:
               mstate.esp += 12;
               this.i1 = li32(this.i4);
               this.i1 += -108;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               this.i1 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 78:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i2);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               this.i1 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 79:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.i6 = this.i1;
               this.i7 = this.i1 + 12;
               if(uint(this.i7) >= uint(this.i2))
               {
                  this.i1 = this.i2;
               }
               else
               {
                  this.i1 += 12;
                  this.i2 = this.i6;
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i6 = li32(this.i2 + 20);
                     si32(this.i6,this.i2 + 8);
                     this.i2 = li32(this.i4);
                     this.i6 = this.i1 + 12;
                     this.i7 = this.i1;
                     if(uint(this.i6) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i1 = this.i6;
                     this.i2 = this.i7;
                  }
                  this.i1 = this.i2;
               }
               this.i1 += -12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i5 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i5) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 80;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5072);
               addr7052:
               break;
            case 80:
               mstate.esp += 4;
               §§goto(addr7052);
            case 81:
               mstate.esp += 4;
               addr7112:
               this.i2 = __2E_str10109;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 6;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 82;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 82:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               mstate.esp -= 8;
               this.i2 = -10002;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 83:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i6 = __2E_str11110;
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
               this.i7 = __2E_str11110;
               mstate.esp -= 12;
               this.i6 -= this.i7;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 84;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 84:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,mstate.ebp + -64);
               this.i6 = 4;
               si32(this.i6,mstate.ebp + -56);
               this.i6 = li32(this.i4);
               mstate.esp -= 16;
               this.i6 += -12;
               this.i7 = mstate.ebp + -64;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 85;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 85:
               mstate.esp += 16;
               this.i2 = li32(this.i4);
               this.i2 += -12;
               si32(this.i2,this.i4);
               mstate.esp -= 12;
               this.i2 = 1;
               this.i6 = 0;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 86;
               mstate.esp -= 4;
               FSM_lua_gc.start();
               return;
            case 86:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               if(this.i2 != this.i1)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 87;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr9295);
               break;
            case 87:
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 88;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7615);
               break;
            case 88:
               mstate.esp += 4;
               addr7615:
               this.i2 = __2E_str99;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 14;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 89;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 89:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 90;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7765);
               break;
            case 90:
               mstate.esp += 4;
               addr7765:
               this.i2 = __2E_str1100;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 91;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 91:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i4);
               this.i6 = 1079066624;
               this.i7 = 0;
               si32(this.i7,this.i2 + 12);
               si32(this.i6,this.i2 + 16);
               this.i6 = 3;
               si32(this.i6,this.i2 + 20);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 92;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7961);
               break;
            case 92:
               mstate.esp += 4;
               addr7961:
               this.i2 = __2E_str2101;
               this.i6 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 93;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 93:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i4);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i4);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i2 + 12);
               this.i1 = 3;
               si32(this.i1,this.i2 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 94;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8150);
               break;
            case 94:
               mstate.esp += 4;
               addr8150:
               this.i1 = __2E_str3102;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 95;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 95:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               this.i2 += -7;
               this.f1 = Number(this.i2);
               sf64(this.f1,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 96;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8363);
               break;
            case 96:
               mstate.esp += 4;
               addr8363:
               this.i1 = __2E_str4103;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 97;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 97:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i4);
               sf64(this.f0,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 98;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8546);
               break;
            case 98:
               mstate.esp += 4;
               addr8546:
               this.i1 = __2E_str10143;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i6 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 99;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 99:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i2);
               this.i1 = 4;
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 100;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8696);
               break;
            case 100:
               mstate.esp += 4;
               addr8696:
               this.i1 = 10;
               this.i2 = li32(this.i4);
               this.i6 = li32(this.i3);
               this.i2 -= this.i6;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 101;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 101:
               mstate.esp += 12;
               this.i1 = li32(this.i4);
               this.i1 += -108;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               this.i1 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 102:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i2);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               this.i1 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 103:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.i6 = this.i1;
               this.i7 = this.i1 + 12;
               if(uint(this.i7) >= uint(this.i2))
               {
                  this.i1 = this.i2;
               }
               else
               {
                  this.i1 += 12;
                  this.i2 = this.i6;
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i6 = li32(this.i2 + 20);
                     si32(this.i6,this.i2 + 8);
                     this.i2 = li32(this.i4);
                     this.i6 = this.i1 + 12;
                     this.i7 = this.i1;
                     if(uint(this.i6) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i1 = this.i6;
                     this.i2 = this.i7;
                  }
                  this.i1 = this.i2;
               }
               this.i1 += -12;
               si32(this.i1,this.i4);
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 104;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr9081);
               break;
            case 104:
               mstate.esp += 4;
               addr9081:
               this.i1 = 2;
               this.i2 = li32(this.i4);
               this.i3 = li32(this.i3);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 105;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 105:
               mstate.esp += 12;
               this.i1 = li32(this.i4);
               this.i1 += -12;
               si32(this.i1,this.i4);
               mstate.esp -= 12;
               this.i1 = 0;
               this.i2 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 106;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 106:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i4);
               this.i0 += -12;
               si32(this.i0,this.i4);
               this.i0 = __2E_str157;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i1;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               addr9276:
               state = 107;
               mstate.esp -= 4;
               FSM_exit.start();
               return;
            case 107:
               mstate.esp += 4;
               addr9295:
               mstate.esp -= 4;
               addr9303:
               si32(this.i0,mstate.esp);
               state = 108;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Int]();
               return;
            case 108:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _thunk_luaInitializeState";
         }
         this.i1 = 2;
         this.i5 = li32(this.i4);
         this.i3 = li32(this.i3);
         this.i3 = this.i5 - this.i3;
         this.i3 /= 12;
         mstate.esp -= 12;
         this.i3 += -1;
         si32(this.i0,mstate.esp);
         si32(this.i1,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 28;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
