package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_do_pcall_with_traceback extends Machine
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
      
      public function FSM_do_pcall_with_traceback()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_do_pcall_with_traceback = null;
         _loc1_ = new FSM_do_pcall_with_traceback();
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
               mstate.esp -= 112;
               this.i0 = -10002;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               mstate.esp -= 8;
               this.i2 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               this.i3 = li32(mstate.ebp + 12);
               this.i0 = this.i2 / 12;
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i2 = mstate.eax;
               this.i4 = this.i0 - this.i3;
               mstate.esp += 8;
               this.i0 = __2E_str18175;
               this.i5 = this.i4 + -1;
               this.i6 = this.i1 + 12;
               this.i7 = this.i1 + 8;
               this.i8 = si8(li8(mstate.ebp + 16));
               while(true)
               {
                  this.i9 = li8(this.i0 + 1);
                  this.i0 += 1;
                  this.i10 = this.i0;
                  if(this.i9 == 0)
                  {
                     break;
                  }
                  this.i0 = this.i10;
               }
               this.i9 = __2E_str18175;
               mstate.esp -= 12;
               this.i0 -= this.i9;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,mstate.ebp + -112);
               this.i0 = 4;
               si32(this.i0,mstate.ebp + -104);
               this.i0 = li32(this.i7);
               mstate.esp -= 16;
               this.i9 = mstate.ebp + -112;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 3;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 3:
               mstate.esp += 16;
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 5)
                  {
                     this.i0 = -1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr458);
                  }
               }
               this.i8 = __2E_str19176;
               this.i0 = li32(this.i7);
               this.i0 += -12;
               si32(this.i0,this.i7);
               this.i2 = 0;
               this.i0 = this.i8;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i8 = this.i2;
               §§goto(addr1047);
            case 5:
               addr458:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str20177;
               while(true)
               {
                  this.i9 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i10 = this.i2;
                  if(this.i9 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i10;
               }
               this.i9 = __2E_str20177;
               mstate.esp -= 12;
               this.i2 -= this.i9;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -32);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -24);
               this.i2 = li32(this.i7);
               mstate.esp -= 16;
               this.i9 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 7:
               mstate.esp += 16;
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 8);
               if(this.i2 != 0)
               {
                  if(this.i2 != 1)
                  {
                     this.i0 = 1;
                  }
                  else
                  {
                     this.i0 = li32(this.i0);
                     this.i0 = this.i0 != 0 ? 1 : 0;
                     this.i0 &= 1;
                  }
               }
               else
               {
                  this.i0 = 0;
               }
               this.i2 = 1;
               this.i9 = li32(this.i7);
               this.i8 &= 255;
               this.i8 = this.i8 != 0 ? 1 : 0;
               this.i10 = this.i9 + -12;
               si32(this.i10,this.i7);
               this.i8 &= 1;
               si32(this.i8,this.i9 + -12);
               si32(this.i2,this.i9 + -4);
               this.i8 = li32(this.i7);
               this.i8 += 12;
               si32(this.i8,this.i7);
               mstate.esp -= 8;
               this.i8 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 9:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str20177;
               while(true)
               {
                  this.i9 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i10 = this.i2;
                  if(this.i9 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i10;
               }
               this.i9 = __2E_str20177;
               mstate.esp -= 12;
               this.i2 -= this.i9;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -16);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -8);
               this.i2 = li32(this.i7);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i9 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 11;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 11:
               mstate.esp += 16;
               this.i8 = li32(this.i7);
               this.i8 += -24;
               si32(this.i8,this.i7);
               this.i8 = this.i0;
               addr1047:
               this.i0 = this.i8;
               this.i2 = _db_errorfb;
               mstate.esp -= 12;
               this.i8 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_lua_pushcclosure.start();
               return;
            case 12:
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 13:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i7);
               this.i9 = this.i8;
               if(uint(this.i8) > uint(this.i2))
               {
                  this.i10 = 0;
                  do
                  {
                     this.i11 = this.i10 ^ -1;
                     this.i11 *= 12;
                     this.i11 = this.i9 + this.i11;
                     this.f0 = lf64(this.i11);
                     sf64(this.f0,this.i8);
                     this.i12 = li32(this.i11 + 8);
                     si32(this.i12,this.i8 + 8);
                     this.i8 += -12;
                     this.i10 += 1;
                  }
                  while(uint(this.i11) > uint(this.i2));
                  
               }
               this.i8 = li32(this.i7);
               this.f0 = lf64(this.i8);
               sf64(this.f0,this.i2);
               this.i8 = li32(this.i8 + 8);
               si32(this.i8,this.i2 + 8);
               this.i2 = this.i3 + this.i5;
               this.i8 = li32(this.i7);
               this.i9 = li32(this.i6);
               this.i8 -= this.i9;
               this.i2 += 2;
               this.i8 /= 12;
               if(this.i8 != this.i2)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 14;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr3092);
               break;
            case 34:
               mstate.esp += 4;
               addr3092:
               if(this.i5 == 0)
               {
                  this.i2 = 0;
               }
               else
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  addr3129:
                  this.i2 = mstate.eax;
                  mstate.esp += 8;
                  this.i8 = li32(this.i1 + 32);
                  this.i2 -= this.i8;
               }
               this.i8 = -1;
               this.i3 ^= -1;
               this.i9 = li32(this.i7);
               this.i3 *= 12;
               this.i3 = this.i9 + this.i3;
               si32(this.i3,mstate.ebp + -40);
               si32(this.i8,mstate.ebp + -36);
               this.i8 = li32(this.i1 + 32);
               mstate.esp -= 20;
               this.i9 = _f_call;
               this.i3 -= this.i8;
               this.i8 = mstate.ebp + -40;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               si32(this.i2,mstate.esp + 16);
               state = 36;
               mstate.esp -= 4;
               FSM_luaD_pcall.start();
               return;
            case 35:
               §§goto(addr3129);
            case 14:
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 16);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               this.i4 = this.i1 + 16;
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1404);
               break;
            case 15:
               mstate.esp += 4;
               addr1404:
               this.i0 = __2E_str23180;
               this.i3 = li32(this.i7);
               mstate.esp -= 12;
               this.i8 = 14;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
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
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1554);
               break;
            case 17:
               mstate.esp += 4;
               addr1554:
               this.i0 = __2E_str1100;
               this.i3 = li32(this.i7);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 18:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i7);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i7);
               this.i3 = 1080885248;
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
                  state = 19;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1750);
               break;
            case 19:
               mstate.esp += 4;
               addr1750:
               this.i0 = __2E_str2101;
               this.i3 = li32(this.i7);
               mstate.esp -= 12;
               this.i8 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 20:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i7);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i7);
               this.f0 = Number(this.i5);
               sf64(this.f0,this.i0 + 12);
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
                  state = 21;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1939);
               break;
            case 21:
               mstate.esp += 4;
               addr1939:
               this.i0 = __2E_str3102;
               this.i3 = li32(this.i7);
               mstate.esp -= 12;
               this.i5 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 22:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i7);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i7);
               this.i5 = li32(this.i6);
               this.i3 -= this.i5;
               this.i3 /= 12;
               this.i3 += -7;
               this.f0 = Number(this.i3);
               sf64(this.f0,this.i0 + 12);
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
                  state = 23;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2152);
               break;
            case 23:
               mstate.esp += 4;
               addr2152:
               this.i0 = __2E_str4103;
               this.i3 = li32(this.i7);
               mstate.esp -= 12;
               this.i5 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 24;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 24:
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
                  state = 25;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2341);
               break;
            case 25:
               mstate.esp += 4;
               addr2341:
               this.i0 = __2E_str10143;
               this.i3 = li32(this.i7);
               mstate.esp -= 12;
               this.i5 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 26;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 26:
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
                  state = 27;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2491);
               break;
            case 27:
               mstate.esp += 4;
               addr2491:
               this.i0 = 10;
               this.i3 = li32(this.i7);
               this.i5 = li32(this.i6);
               this.i3 -= this.i5;
               this.i3 /= 12;
               mstate.esp -= 12;
               this.i3 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 28;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 28:
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
            case 29:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i7);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i3);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               mstate.esp -= 8;
               this.i0 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 30:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i7);
               this.i5 = this.i0;
               this.i2 = this.i0 + 12;
               if(uint(this.i2) >= uint(this.i3))
               {
                  this.i0 = this.i3;
               }
               else
               {
                  this.i0 += 12;
                  this.i3 = this.i5;
                  while(true)
                  {
                     this.f0 = lf64(this.i3 + 12);
                     sf64(this.f0,this.i3);
                     this.i5 = li32(this.i3 + 20);
                     si32(this.i5,this.i3 + 8);
                     this.i3 = li32(this.i7);
                     this.i5 = this.i0 + 12;
                     this.i2 = this.i0;
                     if(uint(this.i5) >= uint(this.i3))
                     {
                        break;
                     }
                     this.i0 = this.i5;
                     this.i3 = this.i2;
                  }
                  this.i0 = this.i3;
               }
               this.i0 += -12;
               si32(this.i0,this.i7);
               this.i0 = li32(this.i4);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 31;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 31:
               mstate.esp += 4;
               break;
            case 32:
               mstate.esp += 12;
               this.i0 = li32(this.i7);
               this.i0 += -12;
               si32(this.i0,this.i7);
               mstate.esp -= 12;
               this.i0 = 0;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 33;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 33:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i7);
               this.i0 += -12;
               si32(this.i0,this.i7);
               this.i0 = __2E_str157;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i1;
               §§goto(addr3055);
            case 36:
               this.i2 = mstate.eax;
               mstate.esp += 20;
               this.i3 = li32(this.i1 + 20);
               this.i8 = li32(this.i7);
               this.i9 = li32(this.i3 + 8);
               this.i3 += 8;
               if(uint(this.i8) >= uint(this.i9))
               {
                  si32(this.i8,this.i3);
               }
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 37:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i7);
               this.i9 = this.i3;
               this.i10 = this.i3 + 12;
               if(uint(this.i10) >= uint(this.i8))
               {
                  this.i3 = this.i8;
               }
               else
               {
                  this.i3 += 12;
                  this.i8 = this.i9;
                  while(true)
                  {
                     this.f0 = lf64(this.i8 + 12);
                     sf64(this.f0,this.i8);
                     this.i9 = li32(this.i8 + 20);
                     si32(this.i9,this.i8 + 8);
                     this.i8 = li32(this.i7);
                     this.i9 = this.i3 + 12;
                     this.i10 = this.i3;
                     if(uint(this.i9) >= uint(this.i8))
                     {
                        break;
                     }
                     this.i3 = this.i9;
                     this.i8 = this.i10;
                  }
                  this.i3 = this.i8;
               }
               this.i8 = -10002;
               this.i3 += -12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 38:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = __2E_str18175;
               while(true)
               {
                  this.i9 = li8(this.i8 + 1);
                  this.i8 += 1;
                  this.i10 = this.i8;
                  if(this.i9 == 0)
                  {
                     break;
                  }
                  this.i8 = this.i10;
               }
               this.i9 = __2E_str18175;
               mstate.esp -= 12;
               this.i8 -= this.i9;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 39;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 39:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,mstate.ebp + -64);
               this.i8 = 4;
               si32(this.i8,mstate.ebp + -56);
               this.i8 = li32(this.i7);
               mstate.esp -= 16;
               this.i9 = mstate.ebp + -64;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               state = 40;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 40:
               mstate.esp += 16;
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 41:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = _luaO_nilobject_;
               if(this.i3 == this.i8)
               {
                  this.i3 = 0;
               }
               else
               {
                  this.i3 = li32(this.i3 + 8);
                  this.i3 = this.i3 == 5 ? 1 : 0;
               }
               this.i3 &= 1;
               if(this.i3 == 0)
               {
                  this.i0 = __2E_str19176;
                  this.i3 = li32(this.i7);
                  this.i3 += -12;
                  si32(this.i3,this.i7);
                  trace(mstate.gworker.stringFromPtr(this.i0));
                  if(this.i2 != 0)
                  {
                     §§goto(addr4409);
                  }
                  else
                  {
                     §§goto(addr3811);
                  }
               }
               else
               {
                  this.i3 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
            case 42:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = __2E_str20177;
               while(true)
               {
                  this.i9 = li8(this.i8 + 1);
                  this.i8 += 1;
                  this.i10 = this.i8;
                  if(this.i9 == 0)
                  {
                     break;
                  }
                  this.i8 = this.i10;
               }
               this.i9 = __2E_str20177;
               mstate.esp -= 12;
               this.i8 -= this.i9;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 43;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 43:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,mstate.ebp + -80);
               this.i8 = 4;
               si32(this.i8,mstate.ebp + -72);
               this.i8 = li32(this.i7);
               mstate.esp -= 16;
               this.i10 = mstate.ebp + -80;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               state = 44;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 44:
               mstate.esp += 16;
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 45:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i7);
               this.i0 = this.i0 != 0 ? 1 : 0;
               this.i8 = this.i3 + -12;
               si32(this.i8,this.i7);
               this.i0 &= 1;
               si32(this.i0,this.i3 + -12);
               this.i0 = 1;
               si32(this.i0,this.i3 + -4);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 46:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = this.i9;
               while(true)
               {
                  this.i8 = li8(this.i3 + 1);
                  this.i3 += 1;
                  this.i9 = this.i3;
                  if(this.i8 == 0)
                  {
                     break;
                  }
                  this.i3 = this.i9;
               }
               this.i8 = __2E_str20177;
               mstate.esp -= 12;
               this.i3 -= this.i8;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 47;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 47:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -96);
               this.i3 = 4;
               si32(this.i3,mstate.ebp + -88);
               this.i3 = li32(this.i7);
               mstate.esp -= 16;
               this.i3 += -12;
               this.i8 = mstate.ebp + -96;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 48;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 48:
               mstate.esp += 16;
               this.i0 = li32(this.i7);
               this.i0 += -24;
               si32(this.i0,this.i7);
               if(this.i2 != 0)
               {
                  addr4409:
                  this.i0 = 0;
                  mstate.esp -= 12;
                  this.i3 = 2;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 49;
                  mstate.esp -= 4;
                  FSM_lua_gc.start();
                  return;
               }
               §§goto(addr3810);
               break;
            case 49:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i7);
               this.i3 = li32(this.i6);
               this.i0 -= this.i3;
               this.i0 /= 12;
               if(this.i0 != this.i4)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 50;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               addr3810:
               addr3811:
               mstate.eax = this.i2;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
               break;
            case 50:
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 16);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i3 = this.i1 + 16;
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 51;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4596);
               break;
            case 51:
               mstate.esp += 4;
               addr4596:
               this.i2 = __2E_str23180;
               this.i0 = li32(this.i7);
               mstate.esp -= 12;
               this.i8 = 14;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 52;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 52:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i7);
               this.i2 += 12;
               si32(this.i2,this.i7);
               this.i2 = li32(this.i3);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 53;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4746);
               break;
            case 53:
               mstate.esp += 4;
               addr4746:
               this.i2 = __2E_str1100;
               this.i0 = li32(this.i7);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 54;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 54:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i7);
               this.i0 = this.i2 + 12;
               si32(this.i0,this.i7);
               this.i0 = 1081024512;
               this.i8 = 0;
               si32(this.i8,this.i2 + 12);
               si32(this.i0,this.i2 + 16);
               this.i0 = 3;
               si32(this.i0,this.i2 + 20);
               this.i2 = li32(this.i7);
               this.i2 += 12;
               si32(this.i2,this.i7);
               this.i2 = li32(this.i3);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 55;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4942);
               break;
            case 55:
               mstate.esp += 4;
               addr4942:
               this.i2 = __2E_str2101;
               this.i0 = li32(this.i7);
               mstate.esp -= 12;
               this.i8 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 56;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 56:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i7);
               this.i0 = this.i2 + 12;
               si32(this.i0,this.i7);
               this.f0 = Number(this.i5);
               sf64(this.f0,this.i2 + 12);
               this.i0 = 3;
               si32(this.i0,this.i2 + 20);
               this.i2 = li32(this.i7);
               this.i2 += 12;
               si32(this.i2,this.i7);
               this.i2 = li32(this.i3);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 57;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5131);
               break;
            case 57:
               mstate.esp += 4;
               addr5131:
               this.i2 = __2E_str3102;
               this.i0 = li32(this.i7);
               mstate.esp -= 12;
               this.i5 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 58;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 58:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i7);
               this.i0 = this.i2 + 12;
               si32(this.i0,this.i7);
               this.i5 = li32(this.i6);
               this.i0 -= this.i5;
               this.i0 /= 12;
               this.i0 += -7;
               this.f0 = Number(this.i0);
               sf64(this.f0,this.i2 + 12);
               this.i0 = 3;
               si32(this.i0,this.i2 + 20);
               this.i2 = li32(this.i7);
               this.i2 += 12;
               si32(this.i2,this.i7);
               this.i2 = li32(this.i3);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 59;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5344);
               break;
            case 59:
               mstate.esp += 4;
               addr5344:
               this.i2 = __2E_str4103;
               this.i0 = li32(this.i7);
               mstate.esp -= 12;
               this.i5 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 60;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 60:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i7);
               this.i0 = this.i2 + 12;
               si32(this.i0,this.i7);
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i2 + 12);
               this.i0 = 3;
               si32(this.i0,this.i2 + 20);
               this.i2 = li32(this.i7);
               this.i2 += 12;
               si32(this.i2,this.i7);
               this.i2 = li32(this.i3);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 61;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5533);
               break;
            case 61:
               mstate.esp += 4;
               addr5533:
               this.i2 = __2E_str10143;
               this.i0 = li32(this.i7);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 62;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 62:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i7);
               this.i2 += 12;
               si32(this.i2,this.i7);
               this.i2 = li32(this.i3);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 63;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5683);
               break;
            case 63:
               mstate.esp += 4;
               addr5683:
               this.i2 = 10;
               this.i0 = li32(this.i7);
               this.i4 = li32(this.i6);
               this.i0 -= this.i4;
               this.i0 /= 12;
               mstate.esp -= 12;
               this.i0 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 64;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 64:
               mstate.esp += 12;
               this.i2 = li32(this.i7);
               this.i2 += -108;
               si32(this.i2,this.i7);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 65:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i7);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i0);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i7);
               this.i2 += 12;
               si32(this.i2,this.i7);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 66:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i7);
               this.i4 = this.i2;
               this.i5 = this.i2 + 12;
               if(uint(this.i5) >= uint(this.i0))
               {
                  this.i2 = this.i0;
               }
               else
               {
                  this.i2 += 12;
                  this.i0 = this.i4;
                  while(true)
                  {
                     this.f0 = lf64(this.i0 + 12);
                     sf64(this.f0,this.i0);
                     this.i4 = li32(this.i0 + 20);
                     si32(this.i4,this.i0 + 8);
                     this.i0 = li32(this.i7);
                     this.i4 = this.i2 + 12;
                     this.i5 = this.i2;
                     if(uint(this.i4) >= uint(this.i0))
                     {
                        break;
                     }
                     this.i2 = this.i4;
                     this.i0 = this.i5;
                  }
                  this.i2 = this.i0;
               }
               this.i2 += -12;
               si32(this.i2,this.i7);
               this.i2 = li32(this.i3);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 67;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6068);
               break;
            case 67:
               mstate.esp += 4;
               addr6068:
               this.i2 = 2;
               this.i0 = li32(this.i7);
               this.i3 = li32(this.i6);
               this.i0 -= this.i3;
               this.i0 /= 12;
               mstate.esp -= 12;
               this.i0 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 68;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 68:
               mstate.esp += 12;
               this.i2 = li32(this.i7);
               this.i2 += -12;
               si32(this.i2,this.i7);
               mstate.esp -= 12;
               this.i2 = 0;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 69;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 69:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i7);
               this.i0 += -12;
               si32(this.i0,this.i7);
               this.i0 = __2E_str157;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i2;
               addr3055:
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               state = 34;
               mstate.esp -= 4;
               FSM_exit.start();
               return;
            default:
               throw "Invalid state in _do_pcall_with_traceback";
         }
         this.i0 = 2;
         this.i3 = li32(this.i7);
         this.i4 = li32(this.i6);
         this.i3 -= this.i4;
         this.i3 /= 12;
         mstate.esp -= 12;
         this.i3 += -1;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 32;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
