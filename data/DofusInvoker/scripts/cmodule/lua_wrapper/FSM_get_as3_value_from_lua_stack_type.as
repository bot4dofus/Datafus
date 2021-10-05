package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_get_as3_value_from_lua_stack_type extends Machine
   {
      
      public static const intRegCount:int = 14;
      
      public static const NumberRegCount:int = 2;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
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
      
      public var f1:Number;
      
      public function FSM_get_as3_value_from_lua_stack_type()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_get_as3_value_from_lua_stack_type = null;
         _loc1_ = new FSM_get_as3_value_from_lua_stack_type();
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
               mstate.esp -= 52;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 8);
               this.i2 = li32(this.i0 + 12);
               this.i1 -= this.i2;
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               this.i1 /= 12;
               this.i4 = this.i0 + 12;
               this.i5 = this.i0 + 8;
               if(this.i3 <= 3)
               {
                  if(this.i3 <= 1)
                  {
                     this.i6 = this.i3 + 1;
                     if(uint(this.i6) < uint(2))
                     {
                        state = 11;
                        mstate.esp -= 4;
                        mstate.funcs[_AS3_Null]();
                        return;
                     }
                     if(this.i3 == 1)
                     {
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM_index2adr.start();
                        §§goto(addr144);
                     }
                  }
                  else if(this.i3 != 2)
                  {
                     if(this.i3 == 3)
                     {
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        state = 3;
                        mstate.esp -= 4;
                        FSM_lua_tonumber.start();
                        return;
                     }
                  }
                  else
                  {
                     §§goto(addr458);
                  }
                  §§goto(addr380);
               }
               else if(this.i3 <= 5)
               {
                  if(this.i3 == 4)
                  {
                     this.i3 = 0;
                     si32(this.i3,mstate.ebp + -52);
                     mstate.esp -= 12;
                     this.i3 = mstate.ebp + -52;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i3,mstate.esp + 8);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_lua_tolstring.start();
                     return;
                  }
                  if(this.i3 != 5)
                  {
                     §§goto(addr380);
                  }
               }
               else
               {
                  addr442:
                  if(this.i3 == 6)
                  {
                     this.i3 = 12;
                     mstate.esp -= 8;
                     this.i6 = 0;
                     si32(this.i6,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 24;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
                  if(this.i3 != 7)
                  {
                     if(this.i3 != 8)
                     {
                        §§goto(addr380);
                     }
                  }
                  else
                  {
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr964);
                  }
               }
               addr458:
               this.i2 = _luaT_typenames;
               this.i3 <<= 2;
               this.i2 += this.i3;
               this.i2 = li32(this.i2);
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               mstate.funcs[_AS3_String]();
               return;
            case 5:
               mstate.esp += 4;
               §§goto(addr442);
            case 12:
               addr964:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i6 = li32(this.i3 + 8);
               if(this.i6 != 2)
               {
                  if(this.i6 != 7)
                  {
                     this.i3 = 0;
                  }
                  else
                  {
                     this.i3 = li32(this.i3);
                     this.i3 += 20;
                  }
               }
               else
               {
                  this.i3 = li32(this.i3);
               }
               this.i6 = -10000;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr1042);
            case 13:
               addr1042:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i7 = __2E_str1143;
               while(true)
               {
                  this.i8 = li8(this.i7 + 1);
                  this.i7 += 1;
                  this.i9 = this.i7;
                  if(this.i8 == 0)
                  {
                     break;
                  }
                  this.i7 = this.i9;
               }
               this.i8 = __2E_str1143;
               mstate.esp -= 12;
               this.i7 -= this.i8;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 1:
               addr144:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i2 + 8);
               if(this.i3 != 0)
               {
                  if(this.i3 == 1)
                  {
                     this.i2 = li32(this.i2);
                     if(this.i2 == 0)
                     {
                        §§goto(addr831);
                     }
                  }
                  state = 2;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_True]();
                  return;
               }
               addr831:
               state = 10;
               mstate.esp -= 4;
               mstate.funcs[_AS3_False]();
               return;
            case 2:
               this.i2 = mstate.eax;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr714);
               break;
            case 3:
               this.f0 = mstate.st0;
               mstate.esp += 8;
               mstate.esp -= 8;
               sf64(this.f0,mstate.esp);
               state = 4;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Number]();
               return;
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr714);
               break;
            case 6:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr714);
               break;
            case 7:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i2 == 0)
               {
                  this.i2 = 6;
                  si32(this.i2,mstate.ebp + -52);
                  mstate.esp -= 8;
                  this.i3 = __2E_str522;
                  si32(this.i3,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 8;
                  mstate.esp -= 4;
                  mstate.funcs[_AS3_StringN]();
                  return;
               }
               this.i3 = li32(mstate.ebp + -52);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               mstate.funcs[_AS3_StringN]();
               return;
               break;
            case 8:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr714);
               break;
            case 9:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr713);
               break;
            case 10:
               this.i2 = mstate.eax;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr713);
               break;
            case 11:
               this.i2 = mstate.eax;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr713);
               break;
            case 14:
               this.i7 = mstate.eax;
               mstate.esp += 12;
               si32(this.i7,mstate.ebp + -16);
               this.i7 = 4;
               si32(this.i7,mstate.ebp + -8);
               this.i7 = li32(this.i5);
               mstate.esp -= 16;
               this.i8 = mstate.ebp + -16;
               si32(this.i0,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 15;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 15:
               mstate.esp += 16;
               this.i6 = li32(this.i5);
               this.i6 += 12;
               si32(this.i6,this.i5);
               if(this.i3 != 0)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_lua_getmetatable.start();
                  addr1271:
                  this.i3 = mstate.eax;
                  mstate.esp += 8;
                  if(this.i3 != 0)
                  {
                     this.i3 = -2;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr1407:
                     this.i3 = mstate.eax;
                     mstate.esp += 8;
                     mstate.esp -= 8;
                     this.i6 = -1;
                     si32(this.i0,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     this.i6 = mstate.eax;
                     mstate.esp += 8;
                     this.i7 = _luaO_nilobject_;
                     if(this.i6 != this.i7)
                     {
                        this.i7 = _luaO_nilobject_;
                        if(this.i3 != this.i7)
                        {
                           mstate.esp -= 8;
                           si32(this.i3,mstate.esp);
                           si32(this.i6,mstate.esp + 4);
                           mstate.esp -= 4;
                           FSM_luaO_rawequalObj.start();
                           addr1504:
                           this.i3 = mstate.eax;
                           mstate.esp += 8;
                           this.i6 = li32(this.i5);
                           this.i6 += -24;
                           si32(this.i6,this.i5);
                           if(this.i3 != 0)
                           {
                              mstate.esp -= 8;
                              si32(this.i0,mstate.esp);
                              si32(this.i2,mstate.esp + 4);
                              mstate.esp -= 4;
                              FSM_index2adr.start();
                              §§goto(addr1563);
                           }
                        }
                        else
                        {
                           addr1596:
                           this.i2 = li32(this.i5);
                           this.i2 += -24;
                           si32(this.i2,this.i5);
                        }
                        this.i2 = __2E_str142;
                        mstate.esp -= 4;
                        si32(this.i2,mstate.esp);
                        state = 22;
                        mstate.esp -= 4;
                        mstate.funcs[_AS3_String]();
                        return;
                     }
                     §§goto(addr1596);
                  }
               }
               this.i2 = __2E_str142;
               this.i3 = li32(this.i5);
               this.i3 += -12;
               si32(this.i3,this.i5);
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 17;
               mstate.esp -= 4;
               mstate.funcs[_AS3_String]();
               return;
            case 16:
               §§goto(addr1271);
            case 18:
               §§goto(addr1407);
            case 19:
               §§goto(addr1407);
            case 20:
               §§goto(addr1504);
            case 21:
               addr1563:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i2 + 8);
               if(this.i3 != 2)
               {
                  if(this.i3 != 7)
                  {
                     this.i2 = 0;
                  }
                  else
                  {
                     this.i2 = li32(this.i2);
                     this.i2 += 20;
                  }
               }
               else
               {
                  this.i2 = li32(this.i2);
               }
               this.i2 = li32(this.i2);
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 23;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Acquire]();
               return;
            case 17:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr713);
               break;
            case 22:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr713);
               break;
            case 23:
               mstate.esp += 4;
               this.i3 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i3 -= this.i6;
               this.i3 /= 12;
               if(this.i3 != this.i1)
               {
                  break;
               }
               §§goto(addr713);
               break;
            case 24:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i6 = this.i3;
               this.i7 = this.i3;
               if(this.i2 < 1)
               {
                  this.i8 = li32(this.i5);
                  this.i9 = li32(this.i4);
                  this.i8 -= this.i9;
                  this.i8 /= 12;
                  this.i2 += this.i8;
                  this.i2 += 1;
               }
               this.i8 = -10000;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 25:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i9 = __2E_str2187;
               while(true)
               {
                  this.i10 = li8(this.i9 + 1);
                  this.i9 += 1;
                  this.i11 = this.i9;
                  if(this.i10 == 0)
                  {
                     break;
                  }
                  this.i9 = this.i11;
               }
               this.i10 = __2E_str2187;
               mstate.esp -= 12;
               this.i9 -= this.i10;
               si32(this.i0,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 26;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 26:
               this.i9 = mstate.eax;
               mstate.esp += 12;
               si32(this.i9,mstate.ebp + -48);
               this.i9 = 4;
               si32(this.i9,mstate.ebp + -40);
               this.i9 = li32(this.i5);
               mstate.esp -= 16;
               this.i10 = mstate.ebp + -48;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i9,mstate.esp + 12);
               state = 27;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 27:
               mstate.esp += 16;
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               mstate.esp -= 8;
               this.i8 = 0;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 28;
               mstate.esp -= 4;
               FSM_lua_createtable.start();
               return;
            case 28:
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.i9 = li32(this.i4);
               this.i10 = this.i1 + 2;
               this.i8 -= this.i9;
               this.i8 /= 12;
               if(this.i8 != this.i10)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 29;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               addr3871:
               this.i8 = 1;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 48:
               mstate.esp += 4;
               §§goto(addr3871);
            case 49:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i5);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i9);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i9 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 12;
               this.i2 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 50;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 29:
               mstate.esp += 8;
               this.i8 = li32(this.i0 + 16);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               this.i11 = this.i0 + 16;
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 30;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2277);
               break;
            case 30:
               mstate.esp += 4;
               addr2277:
               this.i8 = __2E_str4189;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 19;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
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
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 32;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2427);
               break;
            case 32:
               mstate.esp += 4;
               addr2427:
               this.i8 = __2E_str1100;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
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
               this.i9 = 1081151488;
               this.i12 = 0;
               si32(this.i12,this.i8 + 12);
               si32(this.i9,this.i8 + 16);
               this.i9 = 3;
               si32(this.i9,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 34;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2623);
               break;
            case 34:
               mstate.esp += 4;
               addr2623:
               this.i8 = __2E_str2101;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
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
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i8 + 12);
               this.i9 = 3;
               si32(this.i9,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 36;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2812);
               break;
            case 36:
               mstate.esp += 4;
               addr2812:
               this.i8 = __2E_str3102;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
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
               this.i9 = this.i8 + 12;
               si32(this.i9,this.i5);
               this.i12 = li32(this.i4);
               this.i9 -= this.i12;
               this.i9 /= 12;
               this.i9 += -7;
               this.f0 = Number(this.i9);
               sf64(this.f0,this.i8 + 12);
               this.i9 = 3;
               si32(this.i9,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 38;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3025);
               break;
            case 38:
               mstate.esp += 4;
               addr3025:
               this.i8 = __2E_str4103;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 39;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 39:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i9);
               this.i8 = 4;
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i9 = this.i8 + 12;
               si32(this.i9,this.i5);
               this.f0 = Number(this.i10);
               sf64(this.f0,this.i8 + 12);
               this.i9 = 3;
               si32(this.i9,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 40;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3214);
               break;
            case 40:
               mstate.esp += 4;
               addr3214:
               this.i8 = __2E_str10143;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 41;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 41:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i9);
               this.i8 = 4;
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 42;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3364);
               break;
            case 42:
               mstate.esp += 4;
               addr3364:
               this.i8 = 10;
               this.i9 = li32(this.i5);
               this.i12 = li32(this.i4);
               this.i9 -= this.i12;
               this.i9 /= 12;
               mstate.esp -= 12;
               this.i9 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 43;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 43:
               mstate.esp += 12;
               this.i8 = li32(this.i5);
               this.i8 += -108;
               si32(this.i8,this.i5);
               mstate.esp -= 8;
               this.i8 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 44:
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
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 45:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i5);
               this.i12 = this.i8;
               this.i13 = this.i8 + 12;
               if(uint(this.i13) >= uint(this.i9))
               {
                  this.i8 = this.i9;
               }
               else
               {
                  this.i8 += 12;
                  this.i9 = this.i12;
                  while(true)
                  {
                     this.f0 = lf64(this.i9 + 12);
                     sf64(this.f0,this.i9);
                     this.i12 = li32(this.i9 + 20);
                     si32(this.i12,this.i9 + 8);
                     this.i9 = li32(this.i5);
                     this.i12 = this.i8 + 12;
                     this.i13 = this.i8;
                     if(uint(this.i12) >= uint(this.i9))
                     {
                        break;
                     }
                     this.i8 = this.i12;
                     this.i9 = this.i13;
                  }
                  this.i8 = this.i9;
               }
               this.i8 += -12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 46;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr3749);
               break;
            case 46:
               mstate.esp += 4;
               addr3749:
               this.i8 = 2;
               this.i9 = li32(this.i5);
               this.i11 = li32(this.i4);
               this.i9 -= this.i11;
               this.i9 /= 12;
               mstate.esp -= 12;
               this.i9 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 47;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 47:
               mstate.esp += 12;
               this.i8 = li32(this.i5);
               this.i8 += -12;
               si32(this.i8,this.i5);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 48;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 50:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i8 = li32(this.i4);
               this.i2 -= this.i8;
               this.i2 /= 12;
               if(this.i2 != this.i10)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 51;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr5730);
               break;
            case 51:
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 16);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i9 = this.i0 + 16;
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 52;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4136);
               break;
            case 52:
               mstate.esp += 4;
               addr4136:
               this.i2 = __2E_str4189;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 19;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 53;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 53:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 54;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4286);
               break;
            case 54:
               mstate.esp += 4;
               addr4286:
               this.i2 = __2E_str1100;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 55;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 55:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i8 = this.i2 + 12;
               si32(this.i8,this.i5);
               this.i8 = 1081171968;
               this.i11 = 0;
               si32(this.i11,this.i2 + 12);
               si32(this.i8,this.i2 + 16);
               this.i8 = 3;
               si32(this.i8,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 56;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4482);
               break;
            case 56:
               mstate.esp += 4;
               addr4482:
               this.i2 = __2E_str2101;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 57;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 57:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i8 = this.i2 + 12;
               si32(this.i8,this.i5);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i2 + 12);
               this.i8 = 3;
               si32(this.i8,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 58;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4671);
               break;
            case 58:
               mstate.esp += 4;
               addr4671:
               this.i2 = __2E_str3102;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 59;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 59:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i8 = this.i2 + 12;
               si32(this.i8,this.i5);
               this.i11 = li32(this.i4);
               this.i8 -= this.i11;
               this.i8 /= 12;
               this.i8 += -7;
               this.f0 = Number(this.i8);
               sf64(this.f0,this.i2 + 12);
               this.i8 = 3;
               si32(this.i8,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 60;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr4884);
               break;
            case 60:
               mstate.esp += 4;
               addr4884:
               this.i2 = __2E_str4103;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 61;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 61:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i8 = this.i2 + 12;
               si32(this.i8,this.i5);
               this.f0 = Number(this.i10);
               sf64(this.f0,this.i2 + 12);
               this.i8 = 3;
               si32(this.i8,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 62;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5073);
               break;
            case 62:
               mstate.esp += 4;
               addr5073:
               this.i2 = __2E_str10143;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 63;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 63:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 64;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5223);
               break;
            case 64:
               mstate.esp += 4;
               addr5223:
               this.i2 = 10;
               this.i8 = li32(this.i5);
               this.i11 = li32(this.i4);
               this.i8 -= this.i11;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 65;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 65:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i2 += -108;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 66:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i8);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 67:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.i11 = this.i2;
               this.i12 = this.i2 + 12;
               if(uint(this.i12) >= uint(this.i8))
               {
                  this.i2 = this.i8;
               }
               else
               {
                  this.i2 += 12;
                  this.i8 = this.i11;
                  while(true)
                  {
                     this.f0 = lf64(this.i8 + 12);
                     sf64(this.f0,this.i8);
                     this.i11 = li32(this.i8 + 20);
                     si32(this.i11,this.i8 + 8);
                     this.i8 = li32(this.i5);
                     this.i11 = this.i2 + 12;
                     this.i12 = this.i2;
                     if(uint(this.i11) >= uint(this.i8))
                     {
                        break;
                     }
                     this.i2 = this.i11;
                     this.i8 = this.i12;
                  }
                  this.i2 = this.i8;
               }
               this.i2 += -12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 68;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr5608);
               break;
            case 68:
               mstate.esp += 4;
               addr5608:
               this.i2 = 2;
               this.i8 = li32(this.i5);
               this.i9 = li32(this.i4);
               this.i8 -= this.i9;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 69;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 69:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i2 += -12;
               si32(this.i2,this.i5);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 70;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 70:
               mstate.esp += 4;
               addr5730:
               this.i2 = 4;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 71;
               mstate.esp -= 4;
               FSM_lua_newuserdata.start();
               return;
            case 71:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               si32(this.i6,this.i2);
               mstate.esp -= 8;
               this.i2 = -10000;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 72:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i8 = __2E_str185;
               while(true)
               {
                  this.i9 = li8(this.i8 + 1);
                  this.i8 += 1;
                  this.i11 = this.i8;
                  if(this.i9 == 0)
                  {
                     break;
                  }
                  this.i8 = this.i11;
               }
               this.i9 = __2E_str185;
               mstate.esp -= 12;
               this.i8 -= this.i9;
               si32(this.i0,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 73;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 73:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,mstate.ebp + -32);
               this.i8 = 4;
               si32(this.i8,mstate.ebp + -24);
               this.i8 = li32(this.i5);
               mstate.esp -= 16;
               this.i9 = mstate.ebp + -32;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               state = 74;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 74:
               mstate.esp += 16;
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 75:
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i8 = 2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 76;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 76:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i8 = li32(this.i4);
               this.i2 -= this.i8;
               this.i2 /= 12;
               if(this.i2 != this.i10)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 77;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               addr7816:
               this.i2 = -1;
               this.i8 = li32(this.i5);
               this.i9 = li32(this.i4);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               this.i2 = this.i8 - this.i9;
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 96:
               mstate.esp += 4;
               §§goto(addr7816);
            case 97:
               this.i8 = mstate.eax;
               this.i2 /= 12;
               mstate.esp += 8;
               this.i2 += -1;
               this.i9 = _luaO_nilobject_;
               if(this.i8 != this.i9)
               {
                  this.i8 = li32(this.i8 + 8);
                  if(this.i8 == 0)
                  {
                     this.i2 = -1;
                     this.i8 = li32(this.i5);
                     this.i8 += -12;
                     si32(this.i8,this.i5);
                     addr8435:
                     this.i8 = li32(this.i5);
                     this.i9 = li32(this.i4);
                     this.i8 -= this.i9;
                     this.i9 = this.i1 + 1;
                     this.i8 /= 12;
                     if(this.i8 != this.i9)
                     {
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 107;
                        mstate.esp -= 4;
                        FSM_dump_lua_stack.start();
                        return;
                     }
                     §§goto(addr10168);
                  }
               }
               this.i8 = 0;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 98:
               this.i9 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i9);
               mstate.esp -= 8;
               si32(this.i9,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 99:
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
               this.i8 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 100;
               mstate.esp -= 4;
               FSM_lua_tointeger.start();
               return;
            case 77:
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 16);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i9 = this.i0 + 16;
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 78;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6222);
               break;
            case 78:
               mstate.esp += 4;
               addr6222:
               this.i2 = __2E_str4189;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 19;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 79;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 79:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 80;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6372);
               break;
            case 80:
               mstate.esp += 4;
               addr6372:
               this.i2 = __2E_str1100;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 81;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 81:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i8 = this.i2 + 12;
               si32(this.i8,this.i5);
               this.i8 = 1081208832;
               this.i11 = 0;
               si32(this.i11,this.i2 + 12);
               si32(this.i8,this.i2 + 16);
               this.i8 = 3;
               si32(this.i8,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 82;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6568);
               break;
            case 82:
               mstate.esp += 4;
               addr6568:
               this.i2 = __2E_str2101;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 83;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 83:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i8 = this.i2 + 12;
               si32(this.i8,this.i5);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i2 + 12);
               this.i8 = 3;
               si32(this.i8,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 84;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6757);
               break;
            case 84:
               mstate.esp += 4;
               addr6757:
               this.i2 = __2E_str3102;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 85;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 85:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i8 = this.i2 + 12;
               si32(this.i8,this.i5);
               this.i11 = li32(this.i4);
               this.i8 -= this.i11;
               this.i8 /= 12;
               this.i8 += -7;
               this.f0 = Number(this.i8);
               sf64(this.f0,this.i2 + 12);
               this.i8 = 3;
               si32(this.i8,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 86;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr6970);
               break;
            case 86:
               mstate.esp += 4;
               addr6970:
               this.i2 = __2E_str4103;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i11 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 87;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 87:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i8 = this.i2 + 12;
               si32(this.i8,this.i5);
               this.f0 = Number(this.i10);
               sf64(this.f0,this.i2 + 12);
               this.i8 = 3;
               si32(this.i8,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 88;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7159);
               break;
            case 88:
               mstate.esp += 4;
               addr7159:
               this.i2 = __2E_str10143;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 89;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 89:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i8);
               this.i2 = 4;
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 90;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7309);
               break;
            case 90:
               mstate.esp += 4;
               addr7309:
               this.i2 = 10;
               this.i8 = li32(this.i5);
               this.i10 = li32(this.i4);
               this.i8 -= this.i10;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 91;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 91:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i2 += -108;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 92:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i8);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i8 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 93:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.i10 = this.i2;
               this.i11 = this.i2 + 12;
               if(uint(this.i11) >= uint(this.i8))
               {
                  this.i2 = this.i8;
               }
               else
               {
                  this.i2 += 12;
                  this.i8 = this.i10;
                  while(true)
                  {
                     this.f0 = lf64(this.i8 + 12);
                     sf64(this.f0,this.i8);
                     this.i10 = li32(this.i8 + 20);
                     si32(this.i10,this.i8 + 8);
                     this.i8 = li32(this.i5);
                     this.i10 = this.i2 + 12;
                     this.i11 = this.i2;
                     if(uint(this.i10) >= uint(this.i8))
                     {
                        break;
                     }
                     this.i2 = this.i10;
                     this.i8 = this.i11;
                  }
                  this.i2 = this.i8;
               }
               this.i2 += -12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i9);
               this.i8 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i8) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 94;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr7694);
               break;
            case 94:
               mstate.esp += 4;
               addr7694:
               this.i2 = 2;
               this.i8 = li32(this.i5);
               this.i9 = li32(this.i4);
               this.i8 -= this.i9;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 95;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 95:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i2 += -12;
               si32(this.i2,this.i5);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 96;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 100:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i5);
               this.i9 += -12;
               si32(this.i9,this.i5);
               if(this.i8 == 0)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 105;
                  mstate.esp -= 4;
                  FSM_lua_objlen.start();
                  return;
               }
               this.i9 = 0;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 101:
               this.i10 = mstate.eax;
               mstate.esp += 8;
               this.i10 = li32(this.i10);
               mstate.esp -= 8;
               si32(this.i10,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 102:
               this.i10 = mstate.eax;
               mstate.esp += 8;
               this.i11 = li32(this.i5);
               this.f0 = lf64(this.i10);
               sf64(this.f0,this.i11);
               this.i10 = li32(this.i10 + 8);
               si32(this.i10,this.i11 + 8);
               this.i10 = li32(this.i5);
               this.i10 += 12;
               si32(this.i10,this.i5);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 103;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 103:
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 104;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 104:
               mstate.esp += 12;
               this.i2 = this.i8;
               §§goto(addr8435);
            case 105:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i8 += 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 106;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 106:
               mstate.esp += 12;
               this.i2 = this.i8;
               §§goto(addr8435);
            case 107:
               mstate.esp += 8;
               this.i8 = li32(this.i0 + 16);
               this.i10 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               this.i11 = this.i0 + 16;
               if(uint(this.i10) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 108;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8574);
               break;
            case 108:
               mstate.esp += 4;
               addr8574:
               this.i8 = __2E_str4189;
               this.i10 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 19;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 109;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 109:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i10);
               this.i8 = 4;
               si32(this.i8,this.i10 + 8);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i10 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i10) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 110;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8724);
               break;
            case 110:
               mstate.esp += 4;
               addr8724:
               this.i8 = __2E_str1100;
               this.i10 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 111;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 111:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i10);
               this.i8 = 4;
               si32(this.i8,this.i10 + 8);
               this.i8 = li32(this.i5);
               this.i10 = this.i8 + 12;
               si32(this.i10,this.i5);
               this.i10 = 1081225216;
               this.i12 = 0;
               si32(this.i12,this.i8 + 12);
               si32(this.i10,this.i8 + 16);
               this.i10 = 3;
               si32(this.i10,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i10 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i10) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 112;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr8920);
               break;
            case 112:
               mstate.esp += 4;
               addr8920:
               this.i8 = __2E_str2101;
               this.i10 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 113;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 113:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i10);
               this.i8 = 4;
               si32(this.i8,this.i10 + 8);
               this.i8 = li32(this.i5);
               this.i10 = this.i8 + 12;
               si32(this.i10,this.i5);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i8 + 12);
               this.i10 = 3;
               si32(this.i10,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i10 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i10) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 114;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr9109);
               break;
            case 114:
               mstate.esp += 4;
               addr9109:
               this.i8 = __2E_str3102;
               this.i10 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 115;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 115:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i10);
               this.i8 = 4;
               si32(this.i8,this.i10 + 8);
               this.i8 = li32(this.i5);
               this.i10 = this.i8 + 12;
               si32(this.i10,this.i5);
               this.i12 = li32(this.i4);
               this.i10 -= this.i12;
               this.i10 /= 12;
               this.i10 += -7;
               this.f0 = Number(this.i10);
               sf64(this.f0,this.i8 + 12);
               this.i10 = 3;
               si32(this.i10,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i10 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i10) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 116;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr9322);
               break;
            case 116:
               mstate.esp += 4;
               addr9322:
               this.i8 = __2E_str4103;
               this.i10 = li32(this.i5);
               mstate.esp -= 12;
               this.i12 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 117;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 117:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i10);
               this.i8 = 4;
               si32(this.i8,this.i10 + 8);
               this.i8 = li32(this.i5);
               this.i10 = this.i8 + 12;
               si32(this.i10,this.i5);
               this.f0 = Number(this.i9);
               sf64(this.f0,this.i8 + 12);
               this.i9 = 3;
               si32(this.i9,this.i8 + 20);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 118;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr9511);
               break;
            case 118:
               mstate.esp += 4;
               addr9511:
               this.i8 = __2E_str10143;
               this.i9 = li32(this.i5);
               mstate.esp -= 12;
               this.i10 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 119;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 119:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i9);
               this.i8 = 4;
               si32(this.i8,this.i9 + 8);
               this.i8 = li32(this.i5);
               this.i8 += 12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 120;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr9661);
               break;
            case 120:
               mstate.esp += 4;
               addr9661:
               this.i8 = 10;
               this.i9 = li32(this.i5);
               this.i10 = li32(this.i4);
               this.i9 -= this.i10;
               this.i9 /= 12;
               mstate.esp -= 12;
               this.i9 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 121;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 121:
               mstate.esp += 12;
               this.i8 = li32(this.i5);
               this.i8 += -108;
               si32(this.i8,this.i5);
               mstate.esp -= 8;
               this.i8 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 122:
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
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 123:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i5);
               this.i10 = this.i8;
               this.i12 = this.i8 + 12;
               if(uint(this.i12) >= uint(this.i9))
               {
                  this.i8 = this.i9;
               }
               else
               {
                  this.i8 += 12;
                  this.i9 = this.i10;
                  while(true)
                  {
                     this.f0 = lf64(this.i9 + 12);
                     sf64(this.f0,this.i9);
                     this.i10 = li32(this.i9 + 20);
                     si32(this.i10,this.i9 + 8);
                     this.i9 = li32(this.i5);
                     this.i10 = this.i8 + 12;
                     this.i12 = this.i8;
                     if(uint(this.i10) >= uint(this.i9))
                     {
                        break;
                     }
                     this.i8 = this.i10;
                     this.i9 = this.i12;
                  }
                  this.i8 = this.i9;
               }
               this.i8 += -12;
               si32(this.i8,this.i5);
               this.i8 = li32(this.i11);
               this.i9 = li32(this.i8 + 68);
               this.i8 = li32(this.i8 + 64);
               if(uint(this.i9) >= uint(this.i8))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 124;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10046);
               break;
            case 124:
               mstate.esp += 4;
               addr10046:
               this.i8 = 2;
               this.i9 = li32(this.i5);
               this.i10 = li32(this.i4);
               this.i9 -= this.i10;
               this.i9 /= 12;
               mstate.esp -= 12;
               this.i9 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 125;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 125:
               mstate.esp += 12;
               this.i8 = li32(this.i5);
               this.i8 += -12;
               si32(this.i8,this.i5);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 126;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 126:
               mstate.esp += 4;
               addr10168:
               this.i8 = _as3_lua_callback;
               this.i9 = li32(this.i5);
               this.i9 += -12;
               si32(this.i9,this.i5);
               mstate.esp -= 8;
               si32(this.i3,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 127;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Function]();
               return;
            case 127:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               si32(this.i2,this.i6 + 4);
               si32(this.i0,this.i7);
               si32(this.i3,this.i6 + 8);
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i2 -= this.i6;
               this.i2 /= 12;
               if(this.i2 != this.i1)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 128;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               addr11974:
               this.i2 = li32(this.i5);
               this.i6 = li32(this.i4);
               this.i2 -= this.i6;
               this.i2 /= 12;
               if(this.i2 == this.i1)
               {
                  this.i2 = this.i3;
                  addr713:
                  addr714:
                  this.i0 = this.i2;
                  mstate.eax = this.i0;
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  mstate.gworker = caller;
                  return;
               }
               break;
            case 128:
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 16);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i7 = this.i0 + 16;
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 129;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10386);
               break;
            case 129:
               mstate.esp += 4;
               addr10386:
               this.i2 = __2E_str4189;
               this.i6 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 19;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 130;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 130:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i7);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 131;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10536);
               break;
            case 131:
               mstate.esp += 4;
               addr10536:
               this.i2 = __2E_str1100;
               this.i6 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 132;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 132:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i5);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i5);
               this.i6 = 1081266176;
               this.i8 = 0;
               si32(this.i8,this.i2 + 12);
               si32(this.i6,this.i2 + 16);
               this.i6 = 3;
               si32(this.i6,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i7);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 133;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10732);
               break;
            case 133:
               mstate.esp += 4;
               addr10732:
               this.i2 = __2E_str2101;
               this.i6 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 134;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 134:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i5);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i5);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i2 + 12);
               this.i6 = 3;
               si32(this.i6,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i7);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 135;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr10921);
               break;
            case 135:
               mstate.esp += 4;
               addr10921:
               this.i2 = __2E_str3102;
               this.i6 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 136;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 136:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i5);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i5);
               this.i8 = li32(this.i4);
               this.i6 -= this.i8;
               this.i6 /= 12;
               this.i6 += -7;
               this.f1 = Number(this.i6);
               sf64(this.f1,this.i2 + 12);
               this.i6 = 3;
               si32(this.i6,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i7);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 137;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr11134);
               break;
            case 137:
               mstate.esp += 4;
               addr11134:
               this.i2 = __2E_str4103;
               this.i6 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 138;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 138:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i5);
               this.i6 = this.i2 + 12;
               si32(this.i6,this.i5);
               sf64(this.f0,this.i2 + 12);
               this.i6 = 3;
               si32(this.i6,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i7);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 139;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr11317);
               break;
            case 139:
               mstate.esp += 4;
               addr11317:
               this.i2 = __2E_str10143;
               this.i6 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 140;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 140:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i6);
               this.i2 = 4;
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i7);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 141;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr11467);
               break;
            case 141:
               mstate.esp += 4;
               addr11467:
               this.i2 = 10;
               this.i6 = li32(this.i5);
               this.i8 = li32(this.i4);
               this.i6 -= this.i8;
               this.i6 /= 12;
               mstate.esp -= 12;
               this.i6 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 142;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 142:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i2 += -108;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 143:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i6 = li32(this.i5);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i6);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i6 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 144:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i6 = li32(this.i5);
               this.i8 = this.i2;
               this.i9 = this.i2 + 12;
               if(uint(this.i9) >= uint(this.i6))
               {
                  this.i2 = this.i6;
               }
               else
               {
                  this.i2 += 12;
                  this.i6 = this.i8;
                  while(true)
                  {
                     this.f0 = lf64(this.i6 + 12);
                     sf64(this.f0,this.i6);
                     this.i8 = li32(this.i6 + 20);
                     si32(this.i8,this.i6 + 8);
                     this.i6 = li32(this.i5);
                     this.i8 = this.i2 + 12;
                     this.i9 = this.i2;
                     if(uint(this.i8) >= uint(this.i6))
                     {
                        break;
                     }
                     this.i2 = this.i8;
                     this.i6 = this.i9;
                  }
                  this.i2 = this.i6;
               }
               this.i2 += -12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i7);
               this.i6 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i6) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 145;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr11852);
               break;
            case 145:
               mstate.esp += 4;
               addr11852:
               this.i2 = 2;
               this.i6 = li32(this.i5);
               this.i7 = li32(this.i4);
               this.i6 -= this.i7;
               this.i6 /= 12;
               mstate.esp -= 12;
               this.i6 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 146;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 146:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i2 += -12;
               si32(this.i2,this.i5);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 147;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 147:
               mstate.esp += 4;
               §§goto(addr11974);
            case 148:
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 16);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               this.i6 = this.i0 + 16;
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 149;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12113);
               break;
            case 149:
               mstate.esp += 4;
               addr12113:
               this.i2 = __2E_str2144;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 150;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 150:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 151;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12263);
               break;
            case 151:
               mstate.esp += 4;
               addr12263:
               this.i2 = __2E_str1100;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 152;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 152:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i5);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i5);
               this.i3 = 1080426496;
               this.i7 = 0;
               si32(this.i7,this.i2 + 12);
               si32(this.i3,this.i2 + 16);
               this.i3 = 3;
               si32(this.i3,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i3 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i3) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 153;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12459);
               break;
            case 153:
               mstate.esp += 4;
               addr12459:
               this.i2 = __2E_str2101;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 154;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 154:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i5);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i5);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i2 + 12);
               this.i1 = 3;
               si32(this.i1,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i1 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i1) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 155;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12648);
               break;
            case 155:
               mstate.esp += 4;
               addr12648:
               this.i2 = __2E_str3102;
               this.i1 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 16;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 156;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 156:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i1);
               this.i2 = 4;
               si32(this.i2,this.i1 + 8);
               this.i2 = li32(this.i5);
               this.i1 = this.i2 + 12;
               si32(this.i1,this.i5);
               this.i3 = li32(this.i4);
               this.i1 -= this.i3;
               this.i1 /= 12;
               this.i1 += -7;
               this.f1 = Number(this.i1);
               sf64(this.f1,this.i2 + 12);
               this.i1 = 3;
               si32(this.i1,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i1 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i1) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 157;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr12861);
               break;
            case 157:
               mstate.esp += 4;
               addr12861:
               this.i2 = __2E_str4103;
               this.i1 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 18;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 158;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 158:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i1);
               this.i2 = 4;
               si32(this.i2,this.i1 + 8);
               this.i2 = li32(this.i5);
               this.i1 = this.i2 + 12;
               si32(this.i1,this.i5);
               sf64(this.f0,this.i2 + 12);
               this.i1 = 3;
               si32(this.i1,this.i2 + 20);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i1 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i1) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 159;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr13044);
               break;
            case 159:
               mstate.esp += 4;
               addr13044:
               this.i2 = __2E_str10143;
               this.i1 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 160;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 160:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i1);
               this.i2 = 4;
               si32(this.i2,this.i1 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i1 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i1) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 161;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr13194);
               break;
            case 161:
               mstate.esp += 4;
               addr13194:
               this.i2 = 10;
               this.i1 = li32(this.i5);
               this.i3 = li32(this.i4);
               this.i1 -= this.i3;
               this.i1 /= 12;
               mstate.esp -= 12;
               this.i1 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 162;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 162:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i2 += -108;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 163:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i1 = li32(this.i5);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i1);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i1 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 164:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i1 = li32(this.i5);
               this.i3 = this.i2;
               this.i7 = this.i2 + 12;
               if(uint(this.i7) >= uint(this.i1))
               {
                  this.i2 = this.i1;
               }
               else
               {
                  this.i2 += 12;
                  this.i1 = this.i3;
                  while(true)
                  {
                     this.f0 = lf64(this.i1 + 12);
                     sf64(this.f0,this.i1);
                     this.i3 = li32(this.i1 + 20);
                     si32(this.i3,this.i1 + 8);
                     this.i1 = li32(this.i5);
                     this.i3 = this.i2 + 12;
                     this.i7 = this.i2;
                     if(uint(this.i3) >= uint(this.i1))
                     {
                        break;
                     }
                     this.i2 = this.i3;
                     this.i1 = this.i7;
                  }
                  this.i2 = this.i1;
               }
               this.i2 += -12;
               si32(this.i2,this.i5);
               this.i2 = li32(this.i6);
               this.i1 = li32(this.i2 + 68);
               this.i2 = li32(this.i2 + 64);
               if(uint(this.i1) >= uint(this.i2))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 165;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr13579);
               break;
            case 165:
               mstate.esp += 4;
               addr13579:
               this.i2 = 2;
               this.i1 = li32(this.i5);
               this.i3 = li32(this.i4);
               this.i1 -= this.i3;
               this.i1 /= 12;
               mstate.esp -= 12;
               this.i1 += -1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 166;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 166:
               mstate.esp += 12;
               this.i2 = li32(this.i5);
               this.i2 += -12;
               si32(this.i2,this.i5);
               mstate.esp -= 12;
               this.i2 = 0;
               this.i1 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 167;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 167:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i0 += -12;
               si32(this.i0,this.i5);
               this.i0 = __2E_str157;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i2;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               addr380:
               this.i0 = __2E_str157;
               this.i1 = __2E_str10152;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i1;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               this.i0 = -1;
               si32(this.i0,mstate.esp);
               state = 5;
               mstate.esp -= 4;
               FSM_exit.start();
               return;
            default:
               throw "Invalid state in _get_as3_value_from_lua_stack_type";
         }
         mstate.esp -= 8;
         si32(this.i0,mstate.esp);
         si32(this.i1,mstate.esp + 4);
         state = 148;
         mstate.esp -= 4;
         FSM_dump_lua_stack.start();
      }
   }
}
