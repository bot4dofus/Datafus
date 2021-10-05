package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_as3_set extends Machine
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
      
      public function FSM_as3_set()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_as3_set = null;
         _loc1_ = new FSM_as3_set();
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
               this.i0 = __2E_str1143;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checkudata.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i4 = 2;
               this.i5 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 2:
               this.i4 = mstate.eax;
               this.i2 -= this.i3;
               mstate.esp += 12;
               this.i2 /= 12;
               this.i3 = this.i1 + 12;
               this.i5 = this.i1 + 8;
               if(this.i4 == 0)
               {
                  this.i6 = __2E_str33240;
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
               addr228:
               this.i6 = 3;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 3:
               mstate.esp += 12;
               §§goto(addr228);
            case 4:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i7 = _luaO_nilobject_;
               if(this.i6 == this.i7)
               {
                  this.i6 = -1;
               }
               else
               {
                  this.i6 = li32(this.i6 + 8);
               }
               this.i7 = 3;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_get_as3_value_from_lua_stack_type.start();
               return;
            case 5:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               state = 6;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Undefined]();
               return;
            case 6:
               this.i7 = mstate.eax;
               if(this.i7 == this.i6)
               {
                  this.i7 = __2E_str34241;
                  mstate.esp -= 12;
                  this.i8 = 3;
                  si32(this.i1,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i7,mstate.esp + 8);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               §§goto(addr421);
               break;
            case 7:
               mstate.esp += 12;
               addr421:
               this.i0 = li32(this.i0);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i3);
               this.i0 -= this.i4;
               this.i0 /= 12;
               if(this.i0 != this.i2)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr2200);
               break;
            case 9:
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 16);
               this.i4 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               this.i6 = this.i1 + 16;
               if(uint(this.i4) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 10;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr612);
               break;
            case 10:
               mstate.esp += 4;
               addr612:
               this.i0 = __2E_str19226;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 11:
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
                  state = 12;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr762);
               break;
            case 12:
               mstate.esp += 4;
               addr762:
               this.i0 = __2E_str1100;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 13:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i5);
               this.i4 = this.i0 + 12;
               si32(this.i4,this.i5);
               this.i4 = 1081561088;
               this.i7 = 0;
               si32(this.i7,this.i0 + 12);
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
                  state = 14;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr958);
               break;
            case 14:
               mstate.esp += 4;
               addr958:
               this.i0 = __2E_str2101;
               this.i4 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 15;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 15:
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
                  state = 16;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1147);
               break;
            case 16:
               mstate.esp += 4;
               addr1147:
               this.i0 = __2E_str3102;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 17;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 17:
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
               this.f1 = Number(this.i2);
               sf64(this.f1,this.i0 + 12);
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
                  state = 18;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1360);
               break;
            case 18:
               mstate.esp += 4;
               addr1360:
               this.i0 = __2E_str4103;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 19:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i5);
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
                  state = 20;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1543);
               break;
            case 20:
               mstate.esp += 4;
               addr1543:
               this.i0 = __2E_str10143;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 21;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 21:
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
                  state = 22;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1693);
               break;
            case 22:
               mstate.esp += 4;
               addr1693:
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
               state = 23;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 23:
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
            case 24:
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
            case 25:
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
                  state = 26;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 26:
               mstate.esp += 4;
               break;
            case 27:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i0 += -12;
               si32(this.i0,this.i5);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 28;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 28:
               mstate.esp += 4;
               addr2200:
               this.i0 = 0;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _as3_set";
         }
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
         state = 27;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
