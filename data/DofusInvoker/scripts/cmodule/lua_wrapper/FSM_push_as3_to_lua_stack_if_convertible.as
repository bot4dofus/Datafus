package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_push_as3_to_lua_stack_if_convertible extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 2;
       
      
      public var i10:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
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
      
      public function FSM_push_as3_to_lua_stack_if_convertible()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_push_as3_to_lua_stack_if_convertible = null;
         _loc1_ = new FSM_push_as3_to_lua_stack_if_convertible();
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
               this.i1 = li32(this.i0 + 8);
               this.i2 = li32(this.i0 + 12);
               this.i3 = li32(_Number_class);
               mstate.esp -= 8;
               this.i4 = li32(mstate.ebp + 12);
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[_AS3_InstanceOf]();
               return;
            case 1:
               this.i3 = mstate.eax;
               this.i1 -= this.i2;
               mstate.esp += 8;
               this.i1 /= 12;
               this.i2 = this.i0 + 12;
               this.i5 = this.i0 + 8;
               if(this.i3 != 0)
               {
                  this.i3 = 3;
                  mstate.esp -= 4;
                  si32(this.i4,mstate.esp);
                  state = 2;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_NumberValue]();
                  return;
               }
               this.i3 = li32(_int_class);
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               mstate.funcs[_AS3_InstanceOf]();
               return;
               break;
            case 2:
               this.f0 = mstate.st0;
               mstate.esp += 4;
               this.i4 = li32(this.i5);
               sf64(this.f0,this.i4);
               si32(this.i3,this.i4 + 8);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i3 = li32(this.i2);
               this.i4 -= this.i3;
               this.i3 = this.i1 + 1;
               this.i4 /= 12;
               if(this.i4 == this.i3)
               {
                  addr243:
                  this.i0 = 1;
                  break;
               }
               §§goto(addr417);
               break;
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               if(this.i3 != 0)
               {
                  this.i3 = 3;
                  mstate.esp -= 4;
                  si32(this.i4,mstate.esp);
                  state = 4;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_IntValue]();
                  return;
               }
               this.i3 = li32(_String_class);
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 22;
               mstate.esp -= 4;
               mstate.funcs[_AS3_InstanceOf]();
               return;
               break;
            case 4:
               this.i4 = mstate.eax;
               mstate.esp += 4;
               this.i6 = li32(this.i5);
               this.f0 = Number(this.i4);
               sf64(this.f0,this.i6);
               si32(this.i3,this.i6 + 8);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i3 = li32(this.i2);
               this.i4 -= this.i3;
               this.i3 = this.i1 + 1;
               this.i4 /= 12;
               if(this.i4 != this.i3)
               {
                  §§goto(addr417);
               }
               else
               {
                  addr242:
                  §§goto(addr243);
               }
            case 5:
               mstate.esp += 8;
               this.i3 = li32(this.i0 + 16);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               this.i6 = this.i0 + 16;
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr523);
               break;
            case 6:
               mstate.esp += 4;
               addr523:
               this.i3 = __2E_str2144;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 7:
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
                  state = 8;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr675);
               break;
            case 8:
               mstate.esp += 4;
               addr675:
               this.i3 = __2E_str1100;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 9:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i5);
               this.i4 = 1081389056;
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
                  state = 10;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr873);
               break;
            case 10:
               mstate.esp += 4;
               addr873:
               this.i3 = __2E_str2101;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 11:
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
                  state = 12;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1064);
               break;
            case 12:
               mstate.esp += 4;
               addr1064:
               this.i3 = __2E_str3102;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 13:
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
                  state = 14;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1279);
               break;
            case 14:
               mstate.esp += 4;
               addr1279:
               this.i3 = __2E_str4103;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 15;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 15:
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
                  state = 16;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1476);
               break;
            case 16:
               mstate.esp += 4;
               addr1476:
               this.i1 = __2E_str10143;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 17;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 17:
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
                  state = 18;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1628);
               break;
            case 18:
               mstate.esp += 4;
               addr1628:
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
               state = 19;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 19:
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
            case 20:
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
            case 21:
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
                  state = 53;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4569);
               break;
            case 22:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               if(this.i3 != 0)
               {
                  mstate.esp -= 4;
                  si32(this.i4,mstate.esp);
                  state = 23;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_StringValue]();
                  return;
               }
               this.i3 = li32(_Boolean_class);
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 24;
               mstate.esp -= 4;
               mstate.funcs[_AS3_InstanceOf]();
               return;
               break;
            case 23:
               this.i4 = mstate.eax;
               mstate.esp += 4;
               this.i3 = li8(this.i4);
               this.i6 = this.i4;
               if(this.i3 != 0)
               {
                  this.i3 = this.i6;
                  while(true)
                  {
                     this.i7 = li8(this.i3 + 1);
                     this.i3 += 1;
                     this.i8 = this.i3;
                     if(this.i7 == 0)
                     {
                        break;
                     }
                     this.i3 = this.i8;
                  }
               }
               else
               {
                  this.i3 = this.i4;
               }
               this.i7 = li32(this.i0 + 16);
               this.i8 = li32(this.i7 + 68);
               this.i7 = li32(this.i7 + 64);
               this.i3 -= this.i6;
               if(uint(this.i8) >= uint(this.i7))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 56;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4798);
               break;
            case 24:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               if(this.i3 != 0)
               {
                  this.i3 = 1;
                  mstate.esp -= 4;
                  si32(this.i4,mstate.esp);
                  state = 25;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_IntValue]();
                  return;
               }
               state = 26;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Undefined]();
               return;
               break;
            case 25:
               this.i4 = mstate.eax;
               this.i4 = this.i4 != 0 ? 1 : 0;
               mstate.esp += 4;
               this.i6 = li32(this.i5);
               this.i4 &= 1;
               si32(this.i4,this.i6);
               si32(this.i3,this.i6 + 8);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i3 = li32(this.i2);
               this.i4 -= this.i3;
               this.i3 = this.i1 + 1;
               this.i4 /= 12;
               if(this.i4 != this.i3)
               {
                  §§goto(addr416);
               }
               else
               {
                  §§goto(addr242);
               }
            case 26:
               this.i3 = mstate.eax;
               if(this.i3 != this.i4)
               {
                  this.i3 = __2E_str2132;
                  this.i6 = li32(_getQualifiedClassName_method);
                  mstate.esp -= 16;
                  this.i7 = 0;
                  si32(this.i6,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  si32(this.i4,mstate.esp + 12);
                  state = 27;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_CallT]();
                  return;
               }
               this.i4 = 0;
               this.i3 = li32(this.i5);
               si32(this.i4,this.i3 + 8);
               this.i4 = li32(this.i5);
               this.i4 += 12;
               si32(this.i4,this.i5);
               this.i3 = li32(this.i2);
               this.i4 -= this.i3;
               this.i3 = this.i1 + 1;
               this.i4 /= 12;
               if(this.i4 != this.i3)
               {
                  §§goto(addr416);
               }
               else
               {
                  §§goto(addr242);
               }
               break;
            case 27:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               state = 28;
               mstate.esp -= 4;
               mstate.funcs[_AS3_StringValue]();
               return;
            case 28:
               this.i4 = mstate.eax;
               mstate.esp += 4;
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               state = 29;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 29:
               mstate.esp += 4;
               this.i3 = __2E_str3133;
               this.i6 = 5;
               this.i8 = this.i4;
               while(true)
               {
                  this.i9 = this.i3 + this.i7;
                  this.i10 = this.i8 + this.i7;
                  this.i10 = li8(this.i10);
                  this.i9 = li8(this.i9);
                  if(this.i10 == this.i9)
                  {
                     this.i9 = this.i10 & 255;
                     if(this.i9 != 0)
                     {
                        this.i6 += -1;
                        this.i7 += 1;
                        if(this.i6 == 1)
                        {
                           this.i3 = 0;
                           mstate.esp -= 8;
                           si32(this.i4,mstate.esp);
                           si32(this.i3,mstate.esp + 4);
                        }
                        continue;
                        state = 31;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     this.i3 = 0;
                     mstate.esp -= 8;
                     si32(this.i4,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 32;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
                  break;
               }
               this.i3 = 0;
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 30;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
            case 30:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i5);
               this.i3 = li32(this.i2);
               this.i4 -= this.i3;
               this.i4 /= 12;
               if(this.i4 == this.i1)
               {
                  this.i0 = 0;
                  break;
               }
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 33;
               mstate.esp -= 4;
               FSM_dump_lua_stack.start();
               return;
               break;
            case 31:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               addr2673:
               this.i3 = 0;
               this.i4 = li32(this.i5);
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i4 = li32(this.i2);
               this.i3 -= this.i4;
               this.i4 = this.i1 + 1;
               this.i3 /= 12;
               if(this.i3 != this.i4)
               {
                  §§goto(addr416);
               }
               else
               {
                  §§goto(addr242);
               }
            case 32:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr2673);
            case 33:
               mstate.esp += 8;
               this.i3 = li32(this.i0 + 16);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               this.i6 = this.i0 + 16;
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 34;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2839);
               break;
            case 34:
               mstate.esp += 4;
               addr2839:
               this.i3 = __2E_str2144;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 35;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 35:
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
                  state = 36;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2989);
               break;
            case 36:
               mstate.esp += 4;
               addr2989:
               this.i3 = __2E_str1100;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 37:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i4);
               this.i3 = 4;
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i5);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i5);
               this.i4 = 1081368576;
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
                  state = 38;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3185);
               break;
            case 38:
               mstate.esp += 4;
               addr3185:
               this.i3 = __2E_str2101;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 39;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 39:
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
                  state = 40;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3374);
               break;
            case 40:
               mstate.esp += 4;
               addr3374:
               this.i1 = __2E_str3102;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 41;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 41:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i3);
               this.i1 = 4;
               si32(this.i1,this.i3 + 8);
               this.i1 = li32(this.i5);
               this.i3 = this.i1 + 12;
               si32(this.i3,this.i5);
               this.i4 = li32(this.i2);
               this.i3 -= this.i4;
               this.i3 /= 12;
               this.i3 += -7;
               this.f1 = Number(this.i3);
               sf64(this.f1,this.i1 + 12);
               this.i3 = 3;
               si32(this.i3,this.i1 + 20);
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
                  state = 42;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3587);
               break;
            case 42:
               mstate.esp += 4;
               addr3587:
               this.i1 = __2E_str4103;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 43;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 43:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i3);
               this.i1 = 4;
               si32(this.i1,this.i3 + 8);
               this.i1 = li32(this.i5);
               this.i3 = this.i1 + 12;
               si32(this.i3,this.i5);
               sf64(this.f0,this.i1 + 12);
               this.i3 = 3;
               si32(this.i3,this.i1 + 20);
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
                  state = 44;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3770);
               break;
            case 44:
               mstate.esp += 4;
               addr3770:
               this.i1 = __2E_str10143;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 45;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 45:
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
                  state = 46;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3920);
               break;
            case 46:
               mstate.esp += 4;
               addr3920:
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
               state = 47;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 47:
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
            case 48:
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
            case 49:
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
                  state = 50;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4305);
               break;
            case 50:
               mstate.esp += 4;
               addr4305:
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
               state = 51;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 51:
               mstate.esp += 12;
               this.i1 = li32(this.i5);
               this.i1 += -12;
               si32(this.i1,this.i5);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 52;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 52:
               mstate.esp += 4;
               this.i0 = 0;
               break;
            case 53:
               mstate.esp += 4;
               addr4569:
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
               state = 54;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 54:
               mstate.esp += 12;
               this.i1 = li32(this.i5);
               this.i1 += -12;
               si32(this.i1,this.i5);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 55;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 55:
               mstate.esp += 4;
               this.i0 = 1;
               break;
            case 56:
               mstate.esp += 4;
               addr4798:
               this.i6 = 4;
               this.i7 = li32(this.i5);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 57;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 57:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i7);
               si32(this.i6,this.i7 + 8);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               mstate.esp -= 8;
               this.i3 = 0;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 58;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
            case 58:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i5);
               this.i3 = li32(this.i2);
               this.i4 -= this.i3;
               this.i3 = this.i1 + 1;
               this.i4 /= 12;
               if(this.i4 != this.i3)
               {
                  addr416:
                  addr417:
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr242);
               break;
            default:
               throw "Invalid state in _push_as3_to_lua_stack_if_convertible";
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
