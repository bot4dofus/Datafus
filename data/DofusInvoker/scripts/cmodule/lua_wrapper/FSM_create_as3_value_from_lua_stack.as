package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_create_as3_value_from_lua_stack extends Machine
   {
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 2;
       
      
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
      
      public function FSM_create_as3_value_from_lua_stack()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_create_as3_value_from_lua_stack = null;
         _loc1_ = new FSM_create_as3_value_from_lua_stack();
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
               this.i1 -= this.i2;
               this.i2 = si8(li8(mstate.ebp + 20));
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = li32(mstate.ebp + 16);
               this.i1 /= 12;
               this.i5 = this.i0 + 12;
               this.i6 = this.i0 + 8;
               this.i7 = this.i2 & 255;
               if(this.i7 == 1)
               {
                  if(this.i3 > this.i4)
                  {
                     state = 1;
                     mstate.esp -= 4;
                     mstate.funcs[_AS3_Null]();
                     return;
                  }
               }
               this.i2 &= 255;
               if(this.i2 == 1)
               {
                  if(this.i3 == this.i4)
                  {
                     this.i4 = _luaO_nilobject_;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr250);
                  }
               }
               this.i2 = __2E_str45;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 4;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Array]();
               return;
            case 2:
               addr250:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               if(this.i2 == this.i4)
               {
                  this.i2 = -1;
               }
               else
               {
                  this.i2 = li32(this.i2 + 8);
               }
               this.i4 = this.i2;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_get_as3_value_from_lua_stack_type.start();
               return;
            case 1:
               this.i2 = mstate.eax;
               this.i3 = li32(this.i6);
               this.i4 = li32(this.i5);
               this.i3 -= this.i4;
               this.i3 /= 12;
               if(this.i3 == this.i1)
               {
                  this.i0 = this.i2;
                  §§goto(addr171);
               }
               else
               {
                  §§goto(addr713);
               }
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               this.i4 = li32(this.i6);
               this.i2 = li32(this.i5);
               this.i4 -= this.i2;
               this.i4 /= 12;
               if(this.i4 == this.i1)
               {
                  this.i0 = this.i3;
                  §§goto(addr170);
               }
               else
               {
                  §§goto(addr713);
               }
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               if(this.i3 > this.i4)
               {
                  addr678:
                  this.i3 = li32(this.i6);
                  this.i4 = li32(this.i5);
                  this.i3 -= this.i4;
                  this.i3 /= 12;
                  if(this.i3 == this.i1)
                  {
                     this.i0 = this.i2;
                     addr170:
                     addr171:
                     mstate.eax = this.i0;
                     mstate.esp = mstate.ebp;
                     mstate.ebp = li32(mstate.esp);
                     mstate.esp += 4;
                     mstate.esp += 4;
                     mstate.gworker = caller;
                     return;
                  }
                  addr713:
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 10;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               addr416:
               this.i7 = _luaO_nilobject_;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 9:
               mstate.esp += 4;
               this.i3 += 1;
               if(this.i3 <= this.i4)
               {
                  §§goto(addr416);
               }
               else
               {
                  §§goto(addr678);
               }
            case 5:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               if(this.i8 == this.i7)
               {
                  this.i8 = -1;
               }
               else
               {
                  this.i8 = li32(this.i8 + 8);
               }
               this.i7 = this.i8;
               this.i8 = __2E_str12154;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_get_as3_value_from_lua_stack_type.start();
               return;
            case 6:
               this.i7 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 16;
               this.i9 = __2E_str2132;
               si32(this.i8,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               mstate.funcs[_AS3_CallTS]();
               return;
            case 7:
               this.i8 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 4;
               si32(this.i8,mstate.esp);
               state = 8;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 8:
               mstate.esp += 4;
               mstate.esp -= 4;
               si32(this.i7,mstate.esp);
               state = 9;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 10:
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 16);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i4 = this.i0 + 16;
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr817);
               break;
            case 11:
               mstate.esp += 4;
               addr817:
               this.i2 = __2E_str2144;
               this.i3 = li32(this.i6);
               mstate.esp -= 12;
               this.i7 = 16;
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
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i6);
               this.i2 += 12;
               si32(this.i2,this.i6);
               this.i2 = li32(this.i4);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr967);
               break;
            case 13:
               mstate.esp += 4;
               addr967:
               this.i2 = __2E_str1100;
               this.i3 = li32(this.i6);
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
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i6);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i6);
               this.i3 = 1080999936;
               this.i7 = 0;
               si32(this.i7,this.i2 + 12);
               si32(this.i3,this.i2 + 16);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i6);
               this.i2 += 12;
               si32(this.i2,this.i6);
               this.i2 = li32(this.i4);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1163);
               break;
            case 15:
               mstate.esp += 4;
               addr1163:
               this.i2 = __2E_str2101;
               this.i3 = li32(this.i6);
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
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i6);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i6);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i2 + 12);
               this.i1 = 3;
               si32(this.i1,this.i2 + 20);
               this.i1 = li32(this.i6);
               this.i1 += 12;
               si32(this.i1,this.i6);
               this.i1 = li32(this.i4);
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
               §§goto(addr1352);
               break;
            case 17:
               mstate.esp += 4;
               addr1352:
               this.i1 = __2E_str3102;
               this.i2 = li32(this.i6);
               mstate.esp -= 12;
               this.i3 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
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
               this.i1 = li32(this.i6);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i6);
               this.i3 = li32(this.i5);
               this.i2 -= this.i3;
               this.i2 /= 12;
               this.i2 += -7;
               this.f1 = Number(this.i2);
               sf64(this.f1,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i6);
               this.i1 += 12;
               si32(this.i1,this.i6);
               this.i1 = li32(this.i4);
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
               §§goto(addr1565);
               break;
            case 19:
               mstate.esp += 4;
               addr1565:
               this.i1 = __2E_str4103;
               this.i2 = li32(this.i6);
               mstate.esp -= 12;
               this.i3 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
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
               this.i1 = li32(this.i6);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i6);
               sf64(this.f0,this.i1 + 12);
               this.i2 = 3;
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i6);
               this.i1 += 12;
               si32(this.i1,this.i6);
               this.i1 = li32(this.i4);
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
               §§goto(addr1748);
               break;
            case 21:
               mstate.esp += 4;
               addr1748:
               this.i1 = __2E_str10143;
               this.i2 = li32(this.i6);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
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
               this.i1 = li32(this.i6);
               this.i1 += 12;
               si32(this.i1,this.i6);
               this.i1 = li32(this.i4);
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
               §§goto(addr1898);
               break;
            case 23:
               mstate.esp += 4;
               addr1898:
               this.i1 = 10;
               this.i2 = li32(this.i6);
               this.i3 = li32(this.i5);
               this.i2 -= this.i3;
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
               this.i1 = li32(this.i6);
               this.i1 += -108;
               si32(this.i1,this.i6);
               mstate.esp -= 8;
               this.i1 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 25:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i6);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i2);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i6);
               this.i1 += 12;
               si32(this.i1,this.i6);
               mstate.esp -= 8;
               this.i1 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 26:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i6);
               this.i3 = this.i1;
               this.i7 = this.i1 + 12;
               if(uint(this.i7) >= uint(this.i2))
               {
                  this.i1 = this.i2;
               }
               else
               {
                  this.i1 += 12;
                  this.i2 = this.i3;
                  loop0:
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i3 = li32(this.i2 + 20);
                     si32(this.i3,this.i2 + 8);
                     this.i2 = li32(this.i6);
                     this.i3 = this.i1 + 12;
                     this.i7 = this.i1;
                     if(uint(this.i3) >= uint(this.i2))
                     {
                        break;
                     }
                     addr2497:
                     while(true)
                     {
                        this.i1 = this.i3;
                        this.i2 = this.i7;
                        continue loop0;
                     }
                  }
                  this.i1 = this.i2;
               }
               this.i1 += -12;
               si32(this.i1,this.i6);
               this.i1 = li32(this.i4);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
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
               this.i1 = li32(this.i6);
               this.i1 += -12;
               si32(this.i1,this.i6);
               mstate.esp -= 12;
               this.i1 = 0;
               this.i2 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 29;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 29:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i6);
               this.i0 += -12;
               si32(this.i0,this.i6);
               this.i0 = __2E_str157;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i1;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 30;
               mstate.esp -= 4;
               FSM_exit.start();
               return;
            case 30:
               mstate.esp += 4;
               §§goto(addr2497);
            default:
               throw "Invalid state in _create_as3_value_from_lua_stack";
         }
         this.i1 = 2;
         this.i2 = li32(this.i6);
         this.i3 = li32(this.i5);
         this.i2 -= this.i3;
         this.i2 /= 12;
         mstate.esp -= 12;
         this.i2 += -1;
         si32(this.i0,mstate.esp);
         si32(this.i1,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 28;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
