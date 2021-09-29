package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_as3_lua_callback extends Machine
   {
      
      public static const intRegCount:int = 19;
      
      public static const NumberRegCount:int = 2;
       
      
      public var f1:Number;
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i17:int;
      
      public var f0:Number;
      
      public var i16:int;
      
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
      
      public var i18:int;
      
      public function FSM_as3_lua_callback()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_as3_lua_callback = null;
         _loc1_ = new FSM_as3_lua_callback();
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
               mstate.esp -= 32;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0);
               this.i2 = li32(mstate.ebp + 12);
               if(this.i1 == 0)
               {
                  this.i0 = __2E_str3188;
                  trace(mstate.gworker.stringFromPtr(this.i0));
                  state = 1;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_Undefined]();
                  return;
               }
               this.i3 = -10000;
               this.i4 = li32(this.i1 + 8);
               this.i5 = li32(this.i1 + 12);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i3 = mstate.eax;
               this.i4 -= this.i5;
               mstate.esp += 8;
               this.i5 = __2E_str2187;
               this.i6 = this.i4 / 12;
               this.i7 = this.i1 + 12;
               this.i8 = this.i1 + 8;
               while(true)
               {
                  this.i9 = li8(this.i5 + 1);
                  this.i5 += 1;
                  this.i10 = this.i5;
                  if(this.i9 == 0)
                  {
                     break;
                  }
                  this.i5 = this.i10;
               }
               this.i9 = __2E_str2187;
               mstate.esp -= 12;
               this.i5 -= this.i9;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               addr21808:
               mstate.eax = this.i0;
               §§goto(addr21812);
            case 3:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -32);
               this.i5 = 4;
               si32(this.i5,mstate.ebp + -24);
               this.i5 = li32(this.i8);
               mstate.esp -= 16;
               this.i9 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 4:
               mstate.esp += 16;
               this.i3 = li32(this.i8);
               this.i3 += 12;
               si32(this.i3,this.i8);
               this.i0 = li32(this.i0 + 4);
               mstate.esp -= 8;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i5,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i5);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i5 + 8);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i0 != this.i3)
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
                     addr2453:
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     this.i0 = li32(this.i0);
                     mstate.esp -= 8;
                     this.i3 = 1;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_luaH_getnum.start();
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     this.i3 = li32(this.i8);
                     this.f0 = lf64(this.i0);
                     sf64(this.f0,this.i3);
                     this.i0 = li32(this.i0 + 8);
                     si32(this.i0,this.i3 + 8);
                     this.i0 = li32(this.i8);
                     this.i0 += 12;
                     si32(this.i0,this.i8);
                     this.i3 = li32(this.i7);
                     this.i5 = this.i6 + 3;
                     this.i0 -= this.i3;
                     this.i0 /= 12;
                     if(this.i0 != this.i5)
                     {
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i6,mstate.esp + 4);
                        state = 31;
                        mstate.esp -= 4;
                        FSM_dump_lua_stack.start();
                        return;
                     }
                     this.i0 = li32(this.i8);
                     this.i3 = li32(this.i7);
                     this.i9 = li32(_Array_class);
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     state = 49;
                     mstate.esp -= 4;
                     mstate.funcs[_AS3_InstanceOf]();
                     return;
                  }
               }
               this.i2 = li32(this.i8);
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i4 = li32(this.i7);
               this.i2 -= this.i4;
               this.i2 /= 12;
               if(this.i2 != this.i6)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               addr2378:
               this.i1 = __2E_str157;
               this.i2 = __2E_str10195;
               this.i0 = this.i1;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i2;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               this.i1 = -1;
               si32(this.i1,mstate.esp);
               addr2359:
               state = 28;
               mstate.esp -= 4;
               FSM_exit.start();
               return;
               addr2358:
            case 29:
               §§goto(addr2453);
            case 30:
               §§goto(addr2453);
            case 8:
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 16);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i0 = this.i1 + 16;
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr688);
               break;
            case 9:
               mstate.esp += 4;
               addr688:
               this.i2 = __2E_str4189;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr838);
               break;
            case 11:
               mstate.esp += 4;
               addr838:
               this.i2 = __2E_str1100;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 1;
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
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i4 = 1079328768;
               this.i3 = 0;
               si32(this.i3,this.i2 + 12);
               si32(this.i4,this.i2 + 16);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1034);
               break;
            case 13:
               mstate.esp += 4;
               addr1034:
               this.i2 = __2E_str2101;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 38;
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
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1223);
               break;
            case 15:
               mstate.esp += 4;
               addr1223:
               this.i2 = __2E_str3102;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i6 = li32(this.i7);
               this.i4 -= this.i6;
               this.i4 /= 12;
               this.i4 += -7;
               this.f1 = Number(this.i4);
               sf64(this.f1,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1436);
               break;
            case 17:
               mstate.esp += 4;
               addr1436:
               this.i2 = __2E_str4103;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 18:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 19;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1619);
               break;
            case 19:
               mstate.esp += 4;
               addr1619:
               this.i2 = __2E_str10143;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 20:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 21;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1769);
               break;
            case 21:
               mstate.esp += 4;
               addr1769:
               this.i2 = 10;
               this.i4 = li32(this.i8);
               this.i6 = li32(this.i7);
               this.i4 -= this.i6;
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
               this.i2 = li32(this.i8);
               this.i2 += -108;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 23:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i4);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 24:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i8);
               this.i6 = this.i2;
               this.i3 = this.i2 + 12;
               if(uint(this.i3) >= uint(this.i4))
               {
                  this.i2 = this.i4;
               }
               else
               {
                  this.i2 += 12;
                  this.i4 = this.i6;
                  while(true)
                  {
                     this.f0 = lf64(this.i4 + 12);
                     sf64(this.f0,this.i4);
                     this.i6 = li32(this.i4 + 20);
                     si32(this.i6,this.i4 + 8);
                     this.i4 = li32(this.i8);
                     this.i6 = this.i2 + 12;
                     this.i3 = this.i2;
                     if(uint(this.i6) >= uint(this.i4))
                     {
                        break;
                     }
                     this.i2 = this.i6;
                     this.i4 = this.i3;
                  }
                  this.i2 = this.i4;
               }
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 25;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2154);
               break;
            case 25:
               mstate.esp += 4;
               §§goto(addr2154);
            case 26:
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -12;
               si32(this.i2,this.i8);
               mstate.esp -= 12;
               this.i2 = 0;
               this.i4 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 27;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 27:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i2 = __2E_str157;
               this.i0 = this.i2;
               addr2328:
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i1;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               si32(this.i4,mstate.esp);
               §§goto(addr2359);
            case 28:
               mstate.esp += 4;
               §§goto(addr2378);
            case 31:
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 16);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i0 = this.i1 + 16;
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 32;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2687);
               break;
            case 32:
               mstate.esp += 4;
               addr2687:
               this.i2 = __2E_str4189;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 33;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 33:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 34;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2837);
               break;
            case 34:
               mstate.esp += 4;
               addr2837:
               this.i2 = __2E_str1100;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 35;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 35:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i4 = 1079656448;
               this.i3 = 0;
               si32(this.i3,this.i2 + 12);
               si32(this.i4,this.i2 + 16);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 36;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3033);
               break;
            case 36:
               mstate.esp += 4;
               addr3033:
               this.i2 = __2E_str2101;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 37:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 38;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3222);
               break;
            case 38:
               mstate.esp += 4;
               addr3222:
               this.i2 = __2E_str3102;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 39;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 39:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i6 = li32(this.i7);
               this.i4 -= this.i6;
               this.i4 /= 12;
               this.i4 += -7;
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 40;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3435);
               break;
            case 40:
               mstate.esp += 4;
               addr3435:
               this.i2 = __2E_str4103;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 41;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 41:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i5);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 42;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3624);
               break;
            case 42:
               mstate.esp += 4;
               addr3624:
               this.i2 = __2E_str10143;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i5 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 43;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 43:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 44;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3774);
               break;
            case 44:
               mstate.esp += 4;
               addr3774:
               this.i2 = 10;
               this.i4 = li32(this.i8);
               this.i5 = li32(this.i7);
               this.i4 -= this.i5;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 45;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 45:
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -108;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 46:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i4);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 47:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i8);
               this.i5 = this.i2;
               this.i6 = this.i2 + 12;
               if(uint(this.i6) >= uint(this.i4))
               {
                  this.i2 = this.i4;
               }
               else
               {
                  this.i2 += 12;
                  this.i4 = this.i5;
                  while(true)
                  {
                     this.f0 = lf64(this.i4 + 12);
                     sf64(this.f0,this.i4);
                     this.i5 = li32(this.i4 + 20);
                     si32(this.i5,this.i4 + 8);
                     this.i4 = li32(this.i8);
                     this.i5 = this.i2 + 12;
                     this.i6 = this.i2;
                     if(uint(this.i5) >= uint(this.i4))
                     {
                        break;
                     }
                     this.i2 = this.i5;
                     this.i4 = this.i6;
                  }
                  this.i2 = this.i4;
               }
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 48;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4161);
               break;
            case 48:
               mstate.esp += 4;
               §§goto(addr4161);
            case 49:
               this.i9 = mstate.eax;
               this.i0 -= this.i3;
               mstate.esp += 8;
               this.i0 /= 12;
               if(this.i9 == 0)
               {
                  this.i2 = li32(this.i8);
                  this.i3 = li32(this.i7);
                  this.i2 -= this.i3;
                  this.i2 /= 12;
                  if(this.i2 == this.i0)
                  {
                     this.i0 = 0;
                     addr10195:
                     this.i2 = li32(this.i8);
                     this.i3 = li32(this.i7);
                     this.i2 -= this.i3;
                     this.i3 = this.i5 + this.i0;
                     this.i2 /= 12;
                     if(this.i2 != this.i3)
                     {
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i6,mstate.esp + 4);
                        state = 124;
                        mstate.esp -= 4;
                        FSM_dump_lua_stack.start();
                        return;
                     }
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 144;
                     mstate.esp -= 4;
                     FSM_get_async_state.start();
                     return;
                  }
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 50;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               this.i3 = __2E_str8150;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 70;
               mstate.esp -= 4;
               mstate.funcs[_AS3_GetS]();
               return;
               break;
            case 50:
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 16);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i9 = this.i1 + 16;
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 51;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4400);
               break;
            case 51:
               mstate.esp += 4;
               addr4400:
               this.i2 = __2E_str2144;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i10 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 52;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 52:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 53;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4550);
               break;
            case 53:
               mstate.esp += 4;
               addr4550:
               this.i2 = __2E_str1100;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 54;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 54:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i8);
               this.i3 = 1077215232;
               this.i10 = 0;
               si32(this.i10,this.i2 + 12);
               si32(this.i3,this.i2 + 16);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 55;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4746);
               break;
            case 55:
               mstate.esp += 4;
               addr4746:
               this.i2 = __2E_str2101;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i10 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 56;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 56:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i8);
               this.f0 = Number(this.i0);
               sf64(this.f0,this.i2 + 12);
               this.i0 = 3;
               si32(this.i0,this.i2 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i9);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 57;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4935);
               break;
            case 57:
               mstate.esp += 4;
               addr4935:
               this.i0 = __2E_str3102;
               this.i2 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 58;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 58:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i8);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i8);
               this.i3 = li32(this.i7);
               this.i2 -= this.i3;
               this.i2 /= 12;
               this.i2 += -7;
               this.f1 = Number(this.i2);
               sf64(this.f1,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i9);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 59;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5148);
               break;
            case 59:
               mstate.esp += 4;
               addr5148:
               this.i0 = __2E_str4103;
               this.i2 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 60;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 60:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i8);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i8);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i9);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 61;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5331);
               break;
            case 61:
               mstate.esp += 4;
               addr5331:
               this.i0 = __2E_str10143;
               this.i2 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 62;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 62:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i9);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 63;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5481);
               break;
            case 63:
               mstate.esp += 4;
               addr5481:
               this.i0 = 10;
               this.i2 = li32(this.i8);
               this.i3 = li32(this.i7);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 64;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 64:
               mstate.esp += 12;
               this.i0 = li32(this.i8);
               this.i0 += -108;
               si32(this.i0,this.i8);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 65:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               mstate.esp -= 8;
               this.i0 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 66:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i8);
               this.i3 = this.i0;
               this.i10 = this.i0 + 12;
               if(uint(this.i10) >= uint(this.i2))
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
                     this.i2 = li32(this.i8);
                     this.i3 = this.i0 + 12;
                     this.i10 = this.i0;
                     if(uint(this.i3) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i0 = this.i3;
                     this.i2 = this.i10;
                  }
                  this.i0 = this.i2;
               }
               this.i0 += -12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i9);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 67;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5866);
               break;
            case 67:
               mstate.esp += 4;
               addr5866:
               this.i0 = 2;
               this.i2 = li32(this.i8);
               this.i3 = li32(this.i7);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 68;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 68:
               mstate.esp += 12;
               this.i0 = li32(this.i8);
               this.i0 += -12;
               si32(this.i0,this.i8);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 69;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 69:
               mstate.esp += 4;
               this.i0 = 0;
               §§goto(addr10195);
            case 70:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               state = 71;
               mstate.esp -= 4;
               mstate.funcs[_AS3_IntValue]();
               return;
            case 71:
               this.i9 = mstate.eax;
               mstate.esp += 4;
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               state = 72;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 72:
               mstate.esp += 4;
               if(this.i9 >= 1)
               {
                  this.i3 = mstate.ebp + -16;
                  this.i10 = 0;
                  this.i11 = this.i1 + 16;
                  this.i12 = this.i3 + 8;
                  §§goto(addr6144);
               }
               else
               {
                  addr8451:
                  this.i2 = li32(this.i8);
                  this.i3 = li32(this.i7);
                  this.i2 -= this.i3;
                  this.i3 = this.i9 + this.i0;
                  this.i2 /= 12;
                  if(this.i2 != this.i3)
                  {
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 104;
                     mstate.esp -= 4;
                     FSM_dump_lua_stack.start();
                     return;
                  }
                  this.i0 = this.i9;
                  §§goto(addr10195);
               }
               break;
            case 73:
               this.i14 = mstate.eax;
               mstate.esp += 4;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               state = 74;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Get]();
               return;
            case 74:
               this.i15 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 4;
               si32(this.i14,mstate.esp);
               state = 75;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 75:
               mstate.esp += 4;
               this.i14 = li32(this.i8);
               this.i16 = li32(this.i7);
               mstate.esp -= 4;
               si32(this.i15,mstate.esp);
               state = 76;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Acquire]();
               return;
            case 76:
               mstate.esp += 4;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               state = 77;
               mstate.esp -= 4;
               FSM_lua_newuserdata.start();
               return;
            case 77:
               this.i13 = mstate.eax;
               mstate.esp += 8;
               si32(this.i15,this.i13);
               mstate.esp -= 8;
               this.i13 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 78:
               this.i13 = mstate.eax;
               this.i14 -= this.i16;
               mstate.esp += 8;
               this.i16 = __2E_str1143;
               this.i14 /= 12;
               while(true)
               {
                  this.i17 = li8(this.i16 + 1);
                  this.i16 += 1;
                  this.i18 = this.i16;
                  if(this.i17 == 0)
                  {
                     break;
                  }
                  this.i16 = this.i18;
               }
               this.i17 = __2E_str1143;
               mstate.esp -= 12;
               this.i16 -= this.i17;
               si32(this.i1,mstate.esp);
               si32(this.i17,mstate.esp + 4);
               si32(this.i16,mstate.esp + 8);
               state = 79;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 79:
               this.i16 = mstate.eax;
               mstate.esp += 12;
               si32(this.i16,this.i3);
               this.i16 = 4;
               si32(this.i16,this.i12);
               this.i16 = li32(this.i8);
               mstate.esp -= 16;
               this.i17 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i17,mstate.esp + 8);
               si32(this.i16,mstate.esp + 12);
               state = 80;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 80:
               mstate.esp += 16;
               this.i13 = li32(this.i8);
               this.i13 += 12;
               si32(this.i13,this.i8);
               mstate.esp -= 8;
               this.i13 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 81:
               mstate.esp += 8;
               this.i13 = li32(this.i8);
               this.i16 = li32(this.i7);
               this.i17 = this.i14 + 1;
               this.i13 -= this.i16;
               this.i13 /= 12;
               if(this.i13 != this.i17)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i14,mstate.esp + 4);
                  state = 82;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               mstate.esp -= 4;
               si32(this.i15,mstate.esp);
               state = 103;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
               break;
            case 82:
               mstate.esp += 8;
               this.i13 = li32(this.i11);
               this.i16 = li32(this.i13 + 68);
               this.i13 = li32(this.i13 + 64);
               if(uint(this.i16) >= uint(this.i13))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 83;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6761);
               break;
            case 83:
               mstate.esp += 4;
               addr6761:
               this.i13 = __2E_str2144;
               this.i16 = li32(this.i8);
               mstate.esp -= 12;
               this.i18 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i18,mstate.esp + 8);
               state = 84;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 84:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               si32(this.i13,this.i16);
               this.i13 = 4;
               si32(this.i13,this.i16 + 8);
               this.i13 = li32(this.i8);
               this.i13 += 12;
               si32(this.i13,this.i8);
               this.i13 = li32(this.i11);
               this.i16 = li32(this.i13 + 68);
               this.i13 = li32(this.i13 + 64);
               if(uint(this.i16) >= uint(this.i13))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 85;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6911);
               break;
            case 85:
               mstate.esp += 4;
               addr6911:
               this.i13 = __2E_str1100;
               this.i16 = li32(this.i8);
               mstate.esp -= 12;
               this.i18 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i18,mstate.esp + 8);
               state = 86;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 86:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               si32(this.i13,this.i16);
               this.i13 = 4;
               si32(this.i13,this.i16 + 8);
               this.i13 = li32(this.i8);
               this.i16 = this.i13 + 12;
               si32(this.i16,this.i8);
               this.i16 = 1081135104;
               this.i18 = 0;
               si32(this.i18,this.i13 + 12);
               si32(this.i16,this.i13 + 16);
               this.i16 = 3;
               si32(this.i16,this.i13 + 20);
               this.i13 = li32(this.i8);
               this.i13 += 12;
               si32(this.i13,this.i8);
               this.i13 = li32(this.i11);
               this.i16 = li32(this.i13 + 68);
               this.i13 = li32(this.i13 + 64);
               if(uint(this.i16) >= uint(this.i13))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 87;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7107);
               break;
            case 87:
               mstate.esp += 4;
               addr7107:
               this.i13 = __2E_str2101;
               this.i16 = li32(this.i8);
               mstate.esp -= 12;
               this.i18 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i18,mstate.esp + 8);
               state = 88;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 88:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               si32(this.i13,this.i16);
               this.i13 = 4;
               si32(this.i13,this.i16 + 8);
               this.i13 = li32(this.i8);
               this.i16 = this.i13 + 12;
               si32(this.i16,this.i8);
               this.f0 = Number(this.i14);
               sf64(this.f0,this.i13 + 12);
               this.i14 = 3;
               si32(this.i14,this.i13 + 20);
               this.i13 = li32(this.i8);
               this.i13 += 12;
               si32(this.i13,this.i8);
               this.i13 = li32(this.i11);
               this.i14 = li32(this.i13 + 68);
               this.i13 = li32(this.i13 + 64);
               if(uint(this.i14) >= uint(this.i13))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 89;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7296);
               break;
            case 89:
               mstate.esp += 4;
               addr7296:
               this.i13 = __2E_str3102;
               this.i14 = li32(this.i8);
               mstate.esp -= 12;
               this.i16 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i16,mstate.esp + 8);
               state = 90;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 90:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               si32(this.i13,this.i14);
               this.i13 = 4;
               si32(this.i13,this.i14 + 8);
               this.i13 = li32(this.i8);
               this.i14 = this.i13 + 12;
               si32(this.i14,this.i8);
               this.i16 = li32(this.i7);
               this.i14 -= this.i16;
               this.i14 /= 12;
               this.i14 += -7;
               this.f0 = Number(this.i14);
               sf64(this.f0,this.i13 + 12);
               this.i14 = 3;
               si32(this.i14,this.i13 + 20);
               this.i13 = li32(this.i8);
               this.i13 += 12;
               si32(this.i13,this.i8);
               this.i13 = li32(this.i11);
               this.i14 = li32(this.i13 + 68);
               this.i13 = li32(this.i13 + 64);
               if(uint(this.i14) >= uint(this.i13))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 91;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7509);
               break;
            case 91:
               mstate.esp += 4;
               addr7509:
               this.i13 = __2E_str4103;
               this.i14 = li32(this.i8);
               mstate.esp -= 12;
               this.i16 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i16,mstate.esp + 8);
               state = 92;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 92:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               si32(this.i13,this.i14);
               this.i13 = 4;
               si32(this.i13,this.i14 + 8);
               this.i13 = li32(this.i8);
               this.i14 = this.i13 + 12;
               si32(this.i14,this.i8);
               this.f0 = Number(this.i17);
               sf64(this.f0,this.i13 + 12);
               this.i14 = 3;
               si32(this.i14,this.i13 + 20);
               this.i13 = li32(this.i8);
               this.i13 += 12;
               si32(this.i13,this.i8);
               this.i13 = li32(this.i11);
               this.i14 = li32(this.i13 + 68);
               this.i13 = li32(this.i13 + 64);
               if(uint(this.i14) >= uint(this.i13))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 93;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7698);
               break;
            case 93:
               mstate.esp += 4;
               addr7698:
               this.i13 = __2E_str10143;
               this.i14 = li32(this.i8);
               mstate.esp -= 12;
               this.i16 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i16,mstate.esp + 8);
               state = 94;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 94:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               si32(this.i13,this.i14);
               this.i13 = 4;
               si32(this.i13,this.i14 + 8);
               this.i13 = li32(this.i8);
               this.i13 += 12;
               si32(this.i13,this.i8);
               this.i13 = li32(this.i11);
               this.i14 = li32(this.i13 + 68);
               this.i13 = li32(this.i13 + 64);
               if(uint(this.i14) >= uint(this.i13))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 95;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7848);
               break;
            case 95:
               mstate.esp += 4;
               addr7848:
               this.i13 = 10;
               this.i14 = li32(this.i8);
               this.i16 = li32(this.i7);
               this.i14 -= this.i16;
               this.i14 /= 12;
               mstate.esp -= 12;
               this.i14 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i14,mstate.esp + 8);
               state = 96;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 96:
               mstate.esp += 12;
               this.i13 = li32(this.i8);
               this.i13 += -108;
               si32(this.i13,this.i8);
               mstate.esp -= 8;
               this.i13 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 97:
               this.i13 = mstate.eax;
               mstate.esp += 8;
               this.i14 = li32(this.i8);
               this.f0 = lf64(this.i13);
               sf64(this.f0,this.i14);
               this.i13 = li32(this.i13 + 8);
               si32(this.i13,this.i14 + 8);
               this.i13 = li32(this.i8);
               this.i13 += 12;
               si32(this.i13,this.i8);
               mstate.esp -= 8;
               this.i13 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 98:
               this.i13 = mstate.eax;
               mstate.esp += 8;
               this.i14 = li32(this.i8);
               this.i16 = this.i13;
               this.i17 = this.i13 + 12;
               if(uint(this.i17) >= uint(this.i14))
               {
                  this.i13 = this.i14;
               }
               else
               {
                  this.i13 += 12;
                  this.i14 = this.i16;
                  while(true)
                  {
                     this.f0 = lf64(this.i14 + 12);
                     sf64(this.f0,this.i14);
                     this.i16 = li32(this.i14 + 20);
                     si32(this.i16,this.i14 + 8);
                     this.i14 = li32(this.i8);
                     this.i16 = this.i13 + 12;
                     this.i17 = this.i13;
                     if(uint(this.i16) >= uint(this.i14))
                     {
                        break;
                     }
                     this.i13 = this.i16;
                     this.i14 = this.i17;
                  }
                  this.i13 = this.i14;
               }
               this.i13 += -12;
               si32(this.i13,this.i8);
               this.i13 = li32(this.i11);
               this.i14 = li32(this.i13 + 68);
               this.i13 = li32(this.i13 + 64);
               if(uint(this.i14) >= uint(this.i13))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 99;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8233);
               break;
            case 99:
               mstate.esp += 4;
               addr8233:
               this.i13 = 2;
               this.i14 = li32(this.i8);
               this.i16 = li32(this.i7);
               this.i14 -= this.i16;
               this.i14 /= 12;
               mstate.esp -= 12;
               this.i14 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i14,mstate.esp + 8);
               state = 100;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 100:
               mstate.esp += 12;
               this.i13 = li32(this.i8);
               this.i13 += -12;
               si32(this.i13,this.i8);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 101;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 101:
               mstate.esp += 4;
               mstate.esp -= 4;
               si32(this.i15,mstate.esp);
               state = 102;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 102:
               mstate.esp += 4;
               this.i10 += 1;
               if(this.i10 < this.i9)
               {
                  §§goto(addr6143);
               }
               else
               {
                  §§goto(addr8451);
               }
            case 103:
               mstate.esp += 4;
               this.i10 += 1;
               if(this.i10 < this.i9)
               {
                  addr6143:
                  addr6144:
                  this.i13 = 4;
                  mstate.esp -= 4;
                  si32(this.i10,mstate.esp);
                  state = 73;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_Int]();
                  return;
               }
               §§goto(addr8451);
               break;
            case 104:
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 16);
               this.i10 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i11 = this.i1 + 16;
               if(uint(this.i10) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 105;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8597);
               break;
            case 105:
               mstate.esp += 4;
               addr8597:
               this.i2 = __2E_str2144;
               this.i10 = li32(this.i8);
               mstate.esp -= 12;
               this.i12 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 106;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 106:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i10);
               this.i2 = 4;
               si32(this.i2,this.i10 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i11);
               this.i10 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i10) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 107;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8747);
               break;
            case 107:
               mstate.esp += 4;
               addr8747:
               this.i2 = __2E_str1100;
               this.i10 = li32(this.i8);
               mstate.esp -= 12;
               this.i12 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 108;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 108:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i10);
               this.i2 = 4;
               si32(this.i2,this.i10 + 8);
               this.i2 = li32(this.i8);
               this.i10 = this.i2 + 12;
               si32(this.i10,this.i8);
               this.i10 = 1078132736;
               this.i12 = 0;
               si32(this.i12,this.i2 + 12);
               si32(this.i10,this.i2 + 16);
               this.i10 = 3;
               si32(this.i10,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i11);
               this.i10 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i10) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 109;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8943);
               break;
            case 109:
               mstate.esp += 4;
               addr8943:
               this.i2 = __2E_str2101;
               this.i10 = li32(this.i8);
               mstate.esp -= 12;
               this.i12 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 110;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 110:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i10);
               this.i2 = 4;
               si32(this.i2,this.i10 + 8);
               this.i2 = li32(this.i8);
               this.i10 = this.i2 + 12;
               si32(this.i10,this.i8);
               this.f0 = Number(this.i0);
               sf64(this.f0,this.i2 + 12);
               this.i0 = 3;
               si32(this.i0,this.i2 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i11);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 111;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr9132);
               break;
            case 111:
               mstate.esp += 4;
               addr9132:
               this.i0 = __2E_str3102;
               this.i2 = li32(this.i8);
               mstate.esp -= 12;
               this.i10 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 112;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 112:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i8);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i8);
               this.i10 = li32(this.i7);
               this.i2 -= this.i10;
               this.i2 /= 12;
               this.i2 += -7;
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i11);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 113;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr9345);
               break;
            case 113:
               mstate.esp += 4;
               addr9345:
               this.i0 = __2E_str4103;
               this.i2 = li32(this.i8);
               mstate.esp -= 12;
               this.i10 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 114;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 114:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i8);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i8);
               this.f0 = Number(this.i3);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i11);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 115;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr9534);
               break;
            case 115:
               mstate.esp += 4;
               addr9534:
               this.i0 = __2E_str10143;
               this.i2 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 116;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 116:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i11);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 117;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr9684);
               break;
            case 117:
               mstate.esp += 4;
               addr9684:
               this.i0 = 10;
               this.i2 = li32(this.i8);
               this.i3 = li32(this.i7);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 118;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 118:
               mstate.esp += 12;
               this.i0 = li32(this.i8);
               this.i0 += -108;
               si32(this.i0,this.i8);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 119:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               mstate.esp -= 8;
               this.i0 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 120:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i8);
               this.i3 = this.i0;
               this.i10 = this.i0 + 12;
               if(uint(this.i10) >= uint(this.i2))
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
                     this.i2 = li32(this.i8);
                     this.i3 = this.i0 + 12;
                     this.i10 = this.i0;
                     if(uint(this.i3) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i0 = this.i3;
                     this.i2 = this.i10;
                  }
                  this.i0 = this.i2;
               }
               this.i0 += -12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i11);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 121;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10069);
               break;
            case 121:
               mstate.esp += 4;
               addr10069:
               this.i0 = 2;
               this.i2 = li32(this.i8);
               this.i3 = li32(this.i7);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 122;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 122:
               mstate.esp += 12;
               this.i0 = li32(this.i8);
               this.i0 += -12;
               si32(this.i0,this.i8);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 123;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 123:
               mstate.esp += 4;
               this.i0 = this.i9;
               §§goto(addr10195);
            case 124:
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 16);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               this.i5 = this.i1 + 16;
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 125;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10335);
               break;
            case 125:
               mstate.esp += 4;
               addr10335:
               this.i0 = __2E_str4189;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i2 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 126;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 126:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 127;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10485);
               break;
            case 127:
               mstate.esp += 4;
               addr10485:
               this.i0 = __2E_str1100;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 128;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 128:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i8);
               this.i4 = this.i0 + 12;
               si32(this.i4,this.i8);
               this.i4 = 1079869440;
               this.i2 = 0;
               si32(this.i2,this.i0 + 12);
               si32(this.i4,this.i0 + 16);
               this.i4 = 3;
               si32(this.i4,this.i0 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 129;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10681);
               break;
            case 129:
               mstate.esp += 4;
               addr10681:
               this.i0 = __2E_str2101;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i2 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 130;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 130:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i8);
               this.i4 = this.i0 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i0 + 12);
               this.i4 = 3;
               si32(this.i4,this.i0 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 131;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10870);
               break;
            case 131:
               mstate.esp += 4;
               addr10870:
               this.i0 = __2E_str3102;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 132;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 132:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i8);
               this.i4 = this.i0 + 12;
               si32(this.i4,this.i8);
               this.i6 = li32(this.i7);
               this.i4 -= this.i6;
               this.i4 /= 12;
               this.i4 += -7;
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i0 + 12);
               this.i4 = 3;
               si32(this.i4,this.i0 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 133;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr11083);
               break;
            case 133:
               mstate.esp += 4;
               addr11083:
               this.i0 = __2E_str4103;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 134;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 134:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i8);
               this.i4 = this.i0 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i3);
               sf64(this.f0,this.i0 + 12);
               this.i4 = 3;
               si32(this.i4,this.i0 + 20);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 135;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr11272);
               break;
            case 135:
               mstate.esp += 4;
               addr11272:
               this.i0 = __2E_str10143;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 136;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 136:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 137;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr11422);
               break;
            case 137:
               mstate.esp += 4;
               addr11422:
               this.i0 = 10;
               this.i4 = li32(this.i8);
               this.i6 = li32(this.i7);
               this.i4 -= this.i6;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 138;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 138:
               mstate.esp += 12;
               this.i0 = li32(this.i8);
               this.i0 += -108;
               si32(this.i0,this.i8);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 139:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i4);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i8);
               this.i0 += 12;
               si32(this.i0,this.i8);
               mstate.esp -= 8;
               this.i0 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 140:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i8);
               this.i6 = this.i0;
               this.i2 = this.i0 + 12;
               if(uint(this.i2) >= uint(this.i4))
               {
                  this.i0 = this.i4;
               }
               else
               {
                  this.i0 += 12;
                  this.i4 = this.i6;
                  while(true)
                  {
                     this.f0 = lf64(this.i4 + 12);
                     sf64(this.f0,this.i4);
                     this.i6 = li32(this.i4 + 20);
                     si32(this.i6,this.i4 + 8);
                     this.i4 = li32(this.i8);
                     this.i6 = this.i0 + 12;
                     this.i2 = this.i0;
                     if(uint(this.i6) >= uint(this.i4))
                     {
                        break;
                     }
                     this.i0 = this.i6;
                     this.i4 = this.i2;
                  }
                  this.i0 = this.i4;
               }
               this.i0 += -12;
               si32(this.i0,this.i8);
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 141;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr11807);
               break;
            case 141:
               mstate.esp += 4;
               addr11807:
               this.i0 = 2;
               this.i4 = li32(this.i8);
               this.i5 = li32(this.i7);
               this.i4 -= this.i5;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 142;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 142:
               mstate.esp += 12;
               this.i0 = li32(this.i8);
               this.i0 += -12;
               si32(this.i0,this.i8);
               mstate.esp -= 12;
               this.i0 = 0;
               this.i4 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 143;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 143:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i8);
               this.i0 += -12;
               si32(this.i0,this.i8);
               this.i0 = __2E_str157;
               §§goto(addr2328);
            case 144:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 145;
               mstate.esp -= 4;
               FSM_do_pcall_with_traceback.start();
               return;
            case 145:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i3 = li32(this.i7);
               this.i2 -= this.i3;
               this.i2 /= 12;
               if(this.i0 == 0)
               {
                  this.i0 = 1;
                  mstate.esp -= 16;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  si32(this.i0,mstate.esp + 12);
                  state = 251;
                  mstate.esp -= 4;
                  FSM_create_as3_value_from_lua_stack.start();
                  return;
               }
               if(this.i2 != this.i5)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 146;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               this.i2 = -2;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 164:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i8);
               this.i3 = this.i2;
               this.i9 = this.i2 + 12;
               if(uint(this.i9) >= uint(this.i0))
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
                     this.i0 = li32(this.i8);
                     this.i3 = this.i2 + 12;
                     this.i9 = this.i2;
                     if(uint(this.i3) >= uint(this.i0))
                     {
                        break;
                     }
                     this.i2 = this.i3;
                     this.i0 = this.i9;
                  }
                  this.i2 = this.i0;
               }
               this.i0 = -2;
               this.i2 += -12;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 165:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i8);
               this.i3 = this.i2;
               this.i9 = this.i2 + 12;
               if(uint(this.i9) >= uint(this.i0))
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
                     this.i0 = li32(this.i8);
                     this.i3 = this.i2 + 12;
                     this.i9 = this.i2;
                     if(uint(this.i3) >= uint(this.i0))
                     {
                        break;
                     }
                     this.i2 = this.i3;
                     this.i0 = this.i9;
                  }
                  this.i2 = this.i0;
               }
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i0 = li32(this.i7);
               this.i3 = this.i6 + 1;
               this.i2 -= this.i0;
               this.i2 /= 12;
               if(this.i2 != this.i3)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 166;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               this.i2 = 0;
               mstate.esp -= 12;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 186;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
               break;
            case 146:
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 16);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i0 = this.i1 + 16;
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 147;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12194);
               break;
            case 147:
               mstate.esp += 4;
               addr12194:
               this.i2 = __2E_str4189;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 148;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 148:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 149;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12344);
               break;
            case 149:
               mstate.esp += 4;
               addr12344:
               this.i2 = __2E_str1100;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 150;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 150:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i4 = 1080033280;
               this.i3 = 0;
               si32(this.i3,this.i2 + 12);
               si32(this.i4,this.i2 + 16);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 151;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12540);
               break;
            case 151:
               mstate.esp += 4;
               addr12540:
               this.i2 = __2E_str2101;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i3 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 152;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 152:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 153;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12729);
               break;
            case 153:
               mstate.esp += 4;
               addr12729:
               this.i2 = __2E_str3102;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 154;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 154:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i6 = li32(this.i7);
               this.i4 -= this.i6;
               this.i4 /= 12;
               this.i4 += -7;
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 155;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12942);
               break;
            case 155:
               mstate.esp += 4;
               addr12942:
               this.i2 = __2E_str4103;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 156;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 156:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i5);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 157;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr13131);
               break;
            case 157:
               mstate.esp += 4;
               addr13131:
               this.i2 = __2E_str10143;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i5 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 158;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 158:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 159;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr13281);
               break;
            case 159:
               mstate.esp += 4;
               addr13281:
               this.i2 = 10;
               this.i4 = li32(this.i8);
               this.i5 = li32(this.i7);
               this.i4 -= this.i5;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 160;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 160:
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -108;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 161:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i4);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 162:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i8);
               this.i5 = this.i2;
               this.i6 = this.i2 + 12;
               if(uint(this.i6) >= uint(this.i4))
               {
                  this.i2 = this.i4;
               }
               else
               {
                  this.i2 += 12;
                  this.i4 = this.i5;
                  while(true)
                  {
                     this.f0 = lf64(this.i4 + 12);
                     sf64(this.f0,this.i4);
                     this.i5 = li32(this.i4 + 20);
                     si32(this.i5,this.i4 + 8);
                     this.i4 = li32(this.i8);
                     this.i5 = this.i2 + 12;
                     this.i6 = this.i2;
                     if(uint(this.i5) >= uint(this.i4))
                     {
                        break;
                     }
                     this.i2 = this.i5;
                     this.i4 = this.i6;
                  }
                  this.i2 = this.i4;
               }
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i0);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 163;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               addr4161:
               this.i2 = 2;
               this.i4 = li32(this.i8);
               this.i5 = li32(this.i7);
               this.i4 -= this.i5;
               addr2154:
               this.i2 = 2;
               this.i4 = li32(this.i8);
               this.i6 = li32(this.i7);
               this.i4 -= this.i6;
               this.i4 /= 12;
               mstate.esp -= 12;
               this.i4 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 26;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
               addr13666:
               break;
            case 163:
               mstate.esp += 4;
               §§goto(addr13666);
            case 166:
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 16);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i5 = this.i1 + 16;
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 167;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr14099);
               break;
            case 167:
               mstate.esp += 4;
               addr14099:
               this.i2 = __2E_str4189;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i0 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 168;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 168:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 169;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr14249);
               break;
            case 169:
               mstate.esp += 4;
               addr14249:
               this.i2 = __2E_str1100;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i0 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 170;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 170:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i4 = 1080057856;
               this.i0 = 0;
               si32(this.i0,this.i2 + 12);
               si32(this.i4,this.i2 + 16);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 171;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr14445);
               break;
            case 171:
               mstate.esp += 4;
               addr14445:
               this.i2 = __2E_str2101;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i0 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 172;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 172:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 173;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr14634);
               break;
            case 173:
               mstate.esp += 4;
               addr14634:
               this.i2 = __2E_str3102;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 174;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 174:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i6 = li32(this.i7);
               this.i4 -= this.i6;
               this.i4 /= 12;
               this.i4 += -7;
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 175;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr14847);
               break;
            case 175:
               mstate.esp += 4;
               addr14847:
               this.i2 = __2E_str4103;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 176;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 176:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i3);
               sf64(this.f0,this.i2 + 12);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 177;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr15036);
               break;
            case 177:
               mstate.esp += 4;
               addr15036:
               this.i2 = __2E_str10143;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 178;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 178:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 179;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr15186);
               break;
            case 179:
               mstate.esp += 4;
               addr15186:
               this.i2 = 10;
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i7);
               this.i3 -= this.i4;
               this.i3 /= 12;
               mstate.esp -= 12;
               this.i3 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 180;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 180:
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -108;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 181:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i3);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 182:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i8);
               this.i4 = this.i2;
               this.i6 = this.i2 + 12;
               if(uint(this.i6) >= uint(this.i3))
               {
                  this.i2 = this.i3;
               }
               else
               {
                  this.i2 += 12;
                  this.i3 = this.i4;
                  while(true)
                  {
                     this.f0 = lf64(this.i3 + 12);
                     sf64(this.f0,this.i3);
                     this.i4 = li32(this.i3 + 20);
                     si32(this.i4,this.i3 + 8);
                     this.i3 = li32(this.i8);
                     this.i4 = this.i2 + 12;
                     this.i6 = this.i2;
                     if(uint(this.i4) >= uint(this.i3))
                     {
                        break;
                     }
                     this.i2 = this.i4;
                     this.i3 = this.i6;
                  }
                  this.i2 = this.i3;
               }
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 183;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 183:
               mstate.esp += 4;
               break;
            case 184:
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -12;
               si32(this.i2,this.i8);
               mstate.esp -= 12;
               this.i2 = 0;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 185;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 185:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i2 = __2E_str157;
               this.i0 = this.i2;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i1;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               §§goto(addr2358);
            case 186:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i2 == 0)
               {
                  this.i2 = li32(this.i8);
                  this.i2 += -12;
                  si32(this.i2,this.i8);
                  this.i2 = li32(this.i1 + 16);
                  this.i0 = li32(this.i2 + 68);
                  this.i2 = li32(this.i2 + 64);
                  if(uint(this.i0) >= uint(this.i2))
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 187;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  §§goto(addr15910);
               }
               else
               {
                  addr16001:
                  this.i2 = li32(this.i8);
                  this.i0 = li32(this.i7);
                  this.i2 -= this.i0;
                  this.i2 /= 12;
                  if(this.i2 != this.i3)
                  {
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     state = 189;
                     mstate.esp -= 4;
                     FSM_dump_lua_stack.start();
                     return;
                  }
                  this.i2 = li32(this.i1 + 16);
                  this.i0 = li32(this.i2 + 68);
                  this.i2 = li32(this.i2 + 64);
                  this.i9 = this.i1 + 16;
                  if(uint(this.i0) >= uint(this.i2))
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 207;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  §§goto(addr17676);
               }
               break;
            case 187:
               mstate.esp += 4;
               addr15910:
               this.i2 = __2E_str6105;
               this.i0 = li32(this.i8);
               mstate.esp -= 12;
               this.i9 = 12;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 188;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 188:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               §§goto(addr16001);
            case 189:
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 16);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i5 = this.i1 + 16;
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 190;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr16134);
               break;
            case 190:
               mstate.esp += 4;
               addr16134:
               this.i2 = __2E_str4189;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i0 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 191;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 191:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 192;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr16284);
               break;
            case 192:
               mstate.esp += 4;
               addr16284:
               this.i2 = __2E_str1100;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i0 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 193;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 193:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i4 = 1080164352;
               this.i0 = 0;
               si32(this.i0,this.i2 + 12);
               si32(this.i4,this.i2 + 16);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 194;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr16480);
               break;
            case 194:
               mstate.esp += 4;
               addr16480:
               this.i2 = __2E_str2101;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i0 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 195;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 195:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 196;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr16669);
               break;
            case 196:
               mstate.esp += 4;
               addr16669:
               this.i2 = __2E_str3102;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 197;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 197:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i6 = li32(this.i7);
               this.i4 -= this.i6;
               this.i4 /= 12;
               this.i4 += -7;
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 198;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr16882);
               break;
            case 198:
               mstate.esp += 4;
               addr16882:
               this.i2 = __2E_str4103;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i6 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 199;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 199:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i3);
               sf64(this.f0,this.i2 + 12);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 200;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr17071);
               break;
            case 200:
               mstate.esp += 4;
               addr17071:
               this.i2 = __2E_str10143;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 201;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 201:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 202;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr17221);
               break;
            case 202:
               mstate.esp += 4;
               addr17221:
               this.i2 = 10;
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i7);
               this.i3 -= this.i4;
               this.i3 /= 12;
               mstate.esp -= 12;
               this.i3 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 203;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 203:
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -108;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 204:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i3);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 205:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i8);
               this.i4 = this.i2;
               this.i6 = this.i2 + 12;
               if(uint(this.i6) >= uint(this.i3))
               {
                  this.i2 = this.i3;
               }
               else
               {
                  this.i2 += 12;
                  this.i3 = this.i4;
                  while(true)
                  {
                     this.f0 = lf64(this.i3 + 12);
                     sf64(this.f0,this.i3);
                     this.i4 = li32(this.i3 + 20);
                     si32(this.i4,this.i3 + 8);
                     this.i3 = li32(this.i8);
                     this.i4 = this.i2 + 12;
                     this.i6 = this.i2;
                     if(uint(this.i4) >= uint(this.i3))
                     {
                        break;
                     }
                     this.i2 = this.i4;
                     this.i3 = this.i6;
                  }
                  this.i2 = this.i3;
               }
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 206;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               addr17608:
               break;
               addr17608:
               break;
            case 206:
               mstate.esp += 4;
               §§goto(addr17608);
            case 207:
               mstate.esp += 4;
               addr17676:
               this.i2 = __2E_str12197;
               this.i0 = li32(this.i8);
               mstate.esp -= 12;
               this.i10 = 23;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 208;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 208:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i0);
               this.i2 = 4;
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 209:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i8);
               this.i10 = this.i0;
               if(uint(this.i0) > uint(this.i2))
               {
                  this.i11 = 0;
                  do
                  {
                     this.i12 = this.i11 ^ -1;
                     this.i12 *= 12;
                     this.i12 = this.i10 + this.i12;
                     this.f0 = lf64(this.i12);
                     sf64(this.f0,this.i0);
                     this.i13 = li32(this.i12 + 8);
                     si32(this.i13,this.i0 + 8);
                     this.i0 += -12;
                     this.i11 += 1;
                  }
                  while(uint(this.i12) > uint(this.i2));
                  
               }
               this.i0 = li32(this.i8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i2 = li32(this.i8);
               this.i0 = li32(this.i7);
               this.i2 -= this.i0;
               this.i0 = this.i6 + 2;
               this.i2 /= 12;
               if(this.i2 != this.i0)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 210;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               this.i2 = li32(this.i9);
               this.i0 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i0) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 228;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr19591);
               break;
            case 210:
               mstate.esp += 8;
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 211;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr18057);
               break;
            case 211:
               mstate.esp += 4;
               addr18057:
               this.i2 = __2E_str4189;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i4 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 212;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 212:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 213;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr18207);
               break;
            case 213:
               mstate.esp += 4;
               addr18207:
               this.i2 = __2E_str1100;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 214;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 214:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i8);
               this.i3 = 1080205312;
               this.i4 = 0;
               si32(this.i4,this.i2 + 12);
               si32(this.i3,this.i2 + 16);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 215;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr18403);
               break;
            case 215:
               mstate.esp += 4;
               addr18403:
               this.i2 = __2E_str2101;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i4 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 216;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 216:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i8);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i2 + 12);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 217;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr18592);
               break;
            case 217:
               mstate.esp += 4;
               addr18592:
               this.i2 = __2E_str3102;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i4 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 218;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 218:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i8);
               this.i4 = li32(this.i7);
               this.i3 -= this.i4;
               this.i3 /= 12;
               this.i3 += -7;
               this.f0 = Number(this.i3);
               sf64(this.f0,this.i2 + 12);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 219;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr18805);
               break;
            case 219:
               mstate.esp += 4;
               addr18805:
               this.i2 = __2E_str4103;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i4 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 220;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 220:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i8);
               this.f0 = Number(this.i0);
               sf64(this.f0,this.i2 + 12);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 221;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr18994);
               break;
            case 221:
               mstate.esp += 4;
               addr18994:
               this.i2 = __2E_str10143;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 222;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 222:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 223;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr19144);
               break;
            case 223:
               mstate.esp += 4;
               addr19144:
               this.i2 = 10;
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i7);
               this.i3 -= this.i4;
               this.i3 /= 12;
               mstate.esp -= 12;
               this.i3 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 224;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 224:
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -108;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 225:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i3);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 226:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i8);
               this.i4 = this.i2;
               this.i5 = this.i2 + 12;
               if(uint(this.i5) >= uint(this.i3))
               {
                  this.i2 = this.i3;
               }
               else
               {
                  this.i2 += 12;
                  this.i3 = this.i4;
                  while(true)
                  {
                     this.f0 = lf64(this.i3 + 12);
                     sf64(this.f0,this.i3);
                     this.i4 = li32(this.i3 + 20);
                     si32(this.i4,this.i3 + 8);
                     this.i3 = li32(this.i8);
                     this.i4 = this.i2 + 12;
                     this.i5 = this.i2;
                     if(uint(this.i4) >= uint(this.i3))
                     {
                        break;
                     }
                     this.i2 = this.i4;
                     this.i3 = this.i5;
                  }
                  this.i2 = this.i3;
               }
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 227;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               addr19531:
               §§goto(addr17608);
               addr19531:
               break;
            case 227:
               mstate.esp += 4;
               §§goto(addr19531);
            case 228:
               mstate.esp += 4;
               addr19591:
               this.i2 = 2;
               this.i0 = li32(this.i8);
               this.i10 = li32(this.i7);
               this.i0 -= this.i10;
               this.i0 /= 12;
               mstate.esp -= 12;
               this.i0 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 229;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 229:
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i0 = li32(this.i7);
               this.i2 -= this.i0;
               this.i2 /= 12;
               if(this.i2 != this.i3)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 230;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               this.i2 = 0;
               mstate.esp -= 12;
               this.i9 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 248;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
               break;
            case 230:
               mstate.esp += 8;
               this.i2 = li32(this.i9);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 231;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr19803);
               break;
            case 231:
               mstate.esp += 4;
               addr19803:
               this.i2 = __2E_str4189;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i5 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 232;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 232:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 233;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr19953);
               break;
            case 233:
               mstate.esp += 4;
               addr19953:
               this.i2 = __2E_str1100;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i5 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 234;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 234:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i4 = 1080238080;
               this.i5 = 0;
               si32(this.i5,this.i2 + 12);
               si32(this.i4,this.i2 + 16);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 235;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr20149);
               break;
            case 235:
               mstate.esp += 4;
               addr20149:
               this.i2 = __2E_str2101;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i5 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 236;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 236:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 237;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr20338);
               break;
            case 237:
               mstate.esp += 4;
               addr20338:
               this.i2 = __2E_str3102;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i5 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 238;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 238:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.i5 = li32(this.i7);
               this.i4 -= this.i5;
               this.i4 /= 12;
               this.i4 += -7;
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i2 + 12);
               this.i4 = 3;
               si32(this.i4,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i4 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i4) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 239;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr20551);
               break;
            case 239:
               mstate.esp += 4;
               addr20551:
               this.i2 = __2E_str4103;
               this.i4 = li32(this.i8);
               mstate.esp -= 12;
               this.i5 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 240;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 240:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               this.i2 = 4;
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i8);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i8);
               this.f0 = Number(this.i3);
               sf64(this.f0,this.i2 + 12);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 241;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr20740);
               break;
            case 241:
               mstate.esp += 4;
               addr20740:
               this.i2 = __2E_str10143;
               this.i3 = li32(this.i8);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 242;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 242:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 243;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr20890);
               break;
            case 243:
               mstate.esp += 4;
               addr20890:
               this.i2 = 10;
               this.i3 = li32(this.i8);
               this.i4 = li32(this.i7);
               this.i3 -= this.i4;
               this.i3 /= 12;
               mstate.esp -= 12;
               this.i3 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 244;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 244:
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -108;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 245:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i3);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i8);
               this.i2 += 12;
               si32(this.i2,this.i8);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 246:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i8);
               this.i4 = this.i2;
               this.i5 = this.i2 + 12;
               if(uint(this.i5) >= uint(this.i3))
               {
                  this.i2 = this.i3;
               }
               else
               {
                  this.i2 += 12;
                  this.i3 = this.i4;
                  while(true)
                  {
                     this.f0 = lf64(this.i3 + 12);
                     sf64(this.f0,this.i3);
                     this.i4 = li32(this.i3 + 20);
                     si32(this.i4,this.i3 + 8);
                     this.i3 = li32(this.i8);
                     this.i4 = this.i2 + 12;
                     this.i5 = this.i2;
                     if(uint(this.i4) >= uint(this.i3))
                     {
                        break;
                     }
                     this.i2 = this.i4;
                     this.i3 = this.i5;
                  }
                  this.i2 = this.i3;
               }
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i2 = li32(this.i9);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 247;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr19531);
               addr21275:
               break;
            case 247:
               mstate.esp += 4;
               §§goto(addr21275);
            case 248:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 249;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 249:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i8);
               this.i2 += -12;
               si32(this.i2,this.i8);
               this.i0 = li32(this.i7);
               this.i2 -= this.i0;
               mstate.esp -= 16;
               this.i0 = 1;
               this.i2 /= 12;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 250;
               mstate.esp -= 4;
               FSM_create_as3_value_from_lua_stack.start();
               return;
            case 250:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i8);
               if(this.i4 >= -11)
               {
                  this.i3 = li32(this.i7);
                  this.i4 = this.i6 * 12;
                  this.i4 = this.i3 + this.i4;
                  if(uint(this.i2) >= uint(this.i4))
                  {
                     this.i2 = this.i3;
                  }
                  else
                  {
                     do
                     {
                        this.i3 = 0;
                        si32(this.i3,this.i2 + 8);
                        this.i2 += 12;
                        si32(this.i2,this.i8);
                        this.i3 = li32(this.i7);
                        this.i4 = this.i6 * 12;
                        this.i4 = this.i3 + this.i4;
                     }
                     while(uint(this.i2) < uint(this.i4));
                     
                     this.i2 = this.i3;
                  }
                  this.i3 = this.i6 * 12;
                  this.i2 += this.i3;
               }
               else
               {
                  this.i4 = this.i3 * 12;
                  this.i2 += this.i4;
               }
               si32(this.i2,this.i8);
               mstate.eax = this.i1;
               addr21812:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 251:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i8);
               if(this.i4 >= -11)
               {
                  this.i2 = li32(this.i7);
                  this.i3 = this.i6 * 12;
                  this.i3 = this.i2 + this.i3;
                  if(uint(this.i1) >= uint(this.i3))
                  {
                     this.i1 = this.i2;
                  }
                  else
                  {
                     do
                     {
                        this.i2 = 0;
                        si32(this.i2,this.i1 + 8);
                        this.i1 += 12;
                        si32(this.i1,this.i8);
                        this.i2 = li32(this.i7);
                        this.i3 = this.i6 * 12;
                        this.i3 = this.i2 + this.i3;
                     }
                     while(uint(this.i1) < uint(this.i3));
                     
                     this.i1 = this.i2;
                  }
                  this.i6 *= 12;
                  this.i1 += this.i6;
               }
               else
               {
                  this.i2 = this.i6 * 12;
                  this.i1 = this.i2 + this.i1;
                  this.i1 += 12;
               }
               si32(this.i1,this.i8);
               §§goto(addr21808);
            default:
               throw "Invalid state in _as3_lua_callback";
         }
         this.i2 = 2;
         this.i3 = li32(this.i8);
         this.i4 = li32(this.i7);
         this.i3 -= this.i4;
         this.i3 /= 12;
         mstate.esp -= 12;
         this.i3 += -1;
         si32(this.i1,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 184;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
