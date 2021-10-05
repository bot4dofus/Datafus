package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_str_gsub extends Machine
   {
      
      public static const intRegCount:int = 21;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i17:int;
      
      public var i19:int;
      
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
      
      public var i20:int;
      
      public var f0:Number;
      
      public function FSM_str_gsub()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_str_gsub = null;
         _loc1_ = new FSM_str_gsub();
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
               mstate.esp -= 1332;
               this.i0 = mstate.ebp + -4;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i2 = 2;
               this.i3 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i3 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = _luaO_nilobject_;
               if(this.i3 == this.i4)
               {
                  this.i3 = -1;
               }
               else
               {
                  this.i3 = li32(this.i3 + 8);
               }
               this.i4 = 4;
               this.i5 = li32(mstate.ebp + -4);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 += 1;
               this.i6 = _luaO_nilobject_;
               if(this.i4 != this.i6)
               {
                  this.i4 = li32(this.i4 + 8);
                  if(this.i4 >= 1)
                  {
                     this.i4 = 4;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaL_checkinteger.start();
                     return;
                  }
               }
               this.i4 = this.i5;
               addr333:
               this.i5 = li8(this.i2);
               if(this.i5 != 94)
               {
                  this.i5 = 1;
               }
               else
               {
                  this.i5 = 0;
                  this.i2 += 1;
               }
               this.i6 = this.i3 + -3;
               this.i3 += -5;
               if(uint(this.i3) >= uint(2))
               {
                  if(uint(this.i6) >= uint(2))
                  {
                     this.i3 = __2E_str38468;
                     mstate.esp -= 12;
                     this.i6 = 3;
                     si32(this.i1,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     si32(this.i3,mstate.esp + 8);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_luaL_argerror.start();
                     return;
                  }
               }
               this.i3 = mstate.ebp + -1328;
               si32(this.i1,mstate.ebp + -1320);
               this.i6 = this.i3 + 12;
               si32(this.i6,mstate.ebp + -1328);
               this.i6 = 0;
               si32(this.i6,mstate.ebp + -1324);
               si32(this.i1,mstate.ebp + -280);
               si32(this.i0,mstate.ebp + -288);
               this.i6 = li32(mstate.ebp + -4);
               this.i7 = mstate.ebp + -288;
               this.i6 = this.i0 + this.i6;
               si32(this.i6,mstate.ebp + -284);
               this.i6 = this.i7 + 4;
               this.i7 += 8;
               this.i8 = this.i3 + 4;
               this.i9 = this.i3 + 8;
               if(this.i4 > 0)
               {
                  this.i10 = mstate.ebp + -1328;
                  this.i11 = mstate.ebp + -288;
                  this.i10 += 1036;
                  this.i12 = 0;
                  this.i11 += 12;
                  break;
               }
               this.i2 = 0;
               §§goto(addr2626);
               break;
            case 5:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr333);
            case 6:
               mstate.esp += 12;
               §§goto(addr333);
            case 7:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               if(this.i13 == 0)
               {
                  addr2426:
                  if(this.i13 != 0)
                  {
                     if(uint(this.i13) <= uint(this.i0))
                     {
                        addr2442:
                        this.i13 = li32(this.i6);
                        if(uint(this.i13) <= uint(this.i0))
                        {
                           this.i2 = this.i12;
                        }
                        else
                        {
                           this.i13 = li32(this.i3);
                           if(uint(this.i13) >= uint(this.i10))
                           {
                              this.i13 = mstate.ebp + -1328;
                              mstate.esp -= 4;
                              si32(this.i13,mstate.esp);
                              state = 32;
                              mstate.esp -= 4;
                              FSM_emptybuffer.start();
                              return;
                           }
                           addr2558:
                           this.i13 = li32(this.i3);
                           this.i14 = li8(this.i0);
                           si8(this.i14,this.i13);
                           this.i13 += 1;
                           si32(this.i13,this.i3);
                           this.i0 += 1;
                           this.i13 = this.i12 < this.i4 ? 1 : 0;
                           this.i13 &= this.i5;
                           this.i13 &= 1;
                           addr2592:
                           if(this.i13 != 0)
                           {
                              break;
                           }
                           this.i2 = this.i12;
                        }
                        addr2626:
                        this.i3 = mstate.ebp + -1328;
                        this.i4 = li32(this.i6);
                        mstate.esp -= 12;
                        this.i4 -= this.i0;
                        si32(this.i3,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i4,mstate.esp + 8);
                        state = 34;
                        mstate.esp -= 4;
                        FSM_luaL_addlstring.start();
                        return;
                        addr2441:
                     }
                     else
                     {
                        this.i0 = this.i13;
                     }
                     §§goto(addr2592);
                  }
                  §§goto(addr2441);
               }
               else
               {
                  this.i14 = 3;
                  this.i15 = li32(this.i7);
                  mstate.esp -= 8;
                  si32(this.i15,mstate.esp);
                  si32(this.i14,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
            case 8:
               this.i14 = mstate.eax;
               mstate.esp += 8;
               this.i12 += 1;
               this.i16 = _luaO_nilobject_;
               if(this.i14 == this.i16)
               {
                  this.i14 = -1;
               }
               else
               {
                  this.i14 = li32(this.i14 + 8);
               }
               if(this.i14 != 6)
               {
                  if(this.i14 == 5)
                  {
                     this.i14 = 0;
                     mstate.esp -= 16;
                     this.i16 = mstate.ebp + -288;
                     si32(this.i16,mstate.esp);
                     si32(this.i14,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     si32(this.i13,mstate.esp + 12);
                     state = 23;
                     mstate.esp -= 4;
                     FSM_push_onecapture.start();
                     return;
                  }
                  this.i14 += -3;
                  if(uint(this.i14) <= uint(1))
                  {
                     this.i15 = mstate.ebp + -1332;
                     this.i14 = li32(this.i7);
                     mstate.esp -= 12;
                     this.i16 = 3;
                     si32(this.i14,mstate.esp);
                     si32(this.i16,mstate.esp + 4);
                     si32(this.i15,mstate.esp + 8);
                     state = 9;
                     mstate.esp -= 4;
                     FSM_lua_tolstring.start();
                     return;
                  }
                  addr1998:
                  this.i14 = -1;
                  mstate.esp -= 8;
                  si32(this.i15,mstate.esp);
                  si32(this.i14,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  this.i14 = 3;
                  mstate.esp -= 8;
                  si32(this.i15,mstate.esp);
                  si32(this.i14,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               break;
            case 19:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i14 = -1;
               si32(this.i15,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 20:
               this.i14 = mstate.eax;
               mstate.esp += 8;
               this.i16 = li32(this.i14 + 8);
               if(this.i16 != 0)
               {
                  if(this.i16 == 1)
                  {
                     this.i14 = li32(this.i14);
                     if(this.i14 == 0)
                     {
                        addr2067:
                        this.i14 = li32(this.i15 + 8);
                        this.i14 += -12;
                        si32(this.i14,this.i15 + 8);
                        this.i14 = li32(this.i15 + 16);
                        this.i16 = li32(this.i14 + 68);
                        this.i14 = li32(this.i14 + 64);
                        this.i17 = this.i13 - this.i0;
                        this.i18 = this.i15 + 8;
                        if(uint(this.i16) >= uint(this.i14))
                        {
                           mstate.esp -= 4;
                           si32(this.i15,mstate.esp);
                           state = 27;
                           mstate.esp -= 4;
                           FSM_luaC_step.start();
                           return;
                        }
                        §§goto(addr2161);
                     }
                  }
                  §§goto(addr1704);
               }
               §§goto(addr2067);
            case 25:
               mstate.esp += 16;
               §§goto(addr1998);
            case 26:
               this.i14 = mstate.eax;
               mstate.esp += 8;
               this.i16 = li32(this.i14 + 8);
               if(this.i16 != 0)
               {
                  if(this.i16 == 1)
                  {
                     this.i14 = li32(this.i14);
                     if(this.i14 == 0)
                     {
                        §§goto(addr2067);
                     }
                  }
                  addr1704:
                  this.i14 = -1;
                  mstate.esp -= 8;
                  si32(this.i15,mstate.esp);
                  si32(this.i14,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  §§goto(addr1734);
               }
               §§goto(addr2067);
            case 21:
               addr1734:
               this.i14 = mstate.eax;
               mstate.esp += 8;
               this.i16 = _luaO_nilobject_;
               if(this.i14 != this.i16)
               {
                  this.i14 = li32(this.i14 + 8);
                  this.i14 += -3;
                  if(uint(this.i14) < uint(2))
                  {
                     §§goto(addr2390);
                  }
               }
               this.i14 = -1;
               mstate.esp -= 8;
               si32(this.i15,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr1808);
            case 22:
               addr1808:
               this.i14 = mstate.eax;
               mstate.esp += 8;
               this.i16 = _luaO_nilobject_;
               if(this.i14 == this.i16)
               {
                  this.i14 = -1;
               }
               else
               {
                  this.i14 = li32(this.i14 + 8);
               }
               if(this.i14 == -1)
               {
                  this.i14 = __2E_str2251;
               }
               else
               {
                  this.i16 = _luaT_typenames;
                  this.i14 <<= 2;
                  this.i14 = this.i16 + this.i14;
                  this.i14 = li32(this.i14);
               }
               this.i16 = __2E_str39469;
               mstate.esp -= 12;
               si32(this.i15,mstate.esp);
               si32(this.i16,mstate.esp + 4);
               si32(this.i14,mstate.esp + 8);
               state = 30;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
            case 17:
               this.i14 = mstate.eax;
               mstate.esp += 8;
               this.i16 = li32(this.i15 + 8);
               this.f0 = lf64(this.i14);
               sf64(this.f0,this.i16);
               this.i14 = li32(this.i14 + 8);
               si32(this.i14,this.i16 + 8);
               this.i14 = li32(this.i15 + 8);
               this.i14 += 12;
               si32(this.i14,this.i15 + 8);
               mstate.esp -= 12;
               this.i14 = mstate.ebp + -288;
               si32(this.i14,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_push_captures.start();
               return;
            case 9:
               this.i15 = mstate.eax;
               mstate.esp += 12;
               this.i14 = li32(mstate.ebp + -1332);
               if(this.i14 != 0)
               {
                  this.i14 = 0;
                  this.i16 = this.i13 - this.i0;
                  loop0:
                  while(true)
                  {
                     this.i17 = this.i15 + this.i14;
                     this.i18 = li8(this.i17);
                     if(this.i18 != 37)
                     {
                        this.i18 = li32(this.i3);
                        if(uint(this.i18) >= uint(this.i10))
                        {
                           this.i18 = mstate.ebp + -1328;
                           mstate.esp -= 4;
                           si32(this.i18,mstate.esp);
                           state = 10;
                           mstate.esp -= 4;
                           FSM_emptybuffer.start();
                           return;
                        }
                        addr946:
                        while(true)
                        {
                           this.i18 = li32(this.i3);
                           this.i17 = li8(this.i17);
                           si8(this.i17,this.i18);
                           this.i17 = this.i18 + 1;
                           si32(this.i17,this.i3);
                           this.i17 = li32(mstate.ebp + -1332);
                           this.i14 += 1;
                           if(uint(this.i14) >= uint(this.i17))
                           {
                              break loop0;
                           }
                           continue loop0;
                        }
                     }
                     else
                     {
                        this.i17 = __DefaultRuneLocale;
                        this.i18 = this.i14 + this.i15;
                        this.i19 = li8(this.i18 + 1);
                        this.i20 = this.i19 << 2;
                        this.i17 += this.i20;
                        this.i17 = li32(this.i17 + 52);
                        this.i18 += 1;
                        this.i17 &= 1024;
                        if(this.i17 != 0)
                        {
                           this.i14 += 2;
                           this.i17 = this.i19 & 255;
                           if(this.i17 == 48)
                           {
                              this.i19 = mstate.ebp + -1328;
                              mstate.esp -= 12;
                              si32(this.i19,mstate.esp);
                              si32(this.i0,mstate.esp + 4);
                              si32(this.i16,mstate.esp + 8);
                              state = 14;
                              mstate.esp -= 4;
                              FSM_luaL_addlstring.start();
                              return;
                           }
                           this.i17 = mstate.ebp + -288;
                           this.i18 = this.i19 << 24;
                           this.i18 >>= 24;
                           mstate.esp -= 16;
                           this.i18 += -49;
                           si32(this.i17,mstate.esp);
                           si32(this.i18,mstate.esp + 4);
                           si32(this.i0,mstate.esp + 8);
                           si32(this.i13,mstate.esp + 12);
                           state = 15;
                           mstate.esp -= 4;
                           FSM_push_onecapture.start();
                           return;
                        }
                        this.i19 = li32(this.i3);
                        if(uint(this.i19) >= uint(this.i10))
                        {
                           this.i19 = mstate.ebp + -1328;
                           mstate.esp -= 4;
                           si32(this.i19,mstate.esp);
                           state = 12;
                           mstate.esp -= 4;
                           FSM_emptybuffer.start();
                           return;
                        }
                        addr1148:
                        while(true)
                        {
                           this.i19 = li32(this.i3);
                           this.i17 = li8(this.i18);
                           si8(this.i17,this.i19);
                           this.i19 += 1;
                           si32(this.i19,this.i3);
                           this.i19 = li32(mstate.ebp + -1332);
                           this.i14 += 2;
                           if(uint(this.i14) >= uint(this.i19))
                           {
                              break loop0;
                           }
                           continue loop0;
                        }
                     }
                  }
                  addr819:
               }
               §§goto(addr2426);
            case 10:
               this.i18 = mstate.eax;
               mstate.esp += 4;
               if(this.i18 != 0)
               {
                  this.i18 = mstate.ebp + -1328;
                  mstate.esp -= 4;
                  si32(this.i18,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr946);
               break;
            case 11:
               mstate.esp += 4;
               §§goto(addr946);
            case 12:
               this.i19 = mstate.eax;
               mstate.esp += 4;
               if(this.i19 != 0)
               {
                  this.i19 = mstate.ebp + -1328;
                  mstate.esp -= 4;
                  si32(this.i19,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr1148);
               break;
            case 13:
               mstate.esp += 4;
               §§goto(addr1148);
            case 14:
               mstate.esp += 12;
               this.i19 = li32(mstate.ebp + -1332);
               if(uint(this.i14) < uint(this.i19))
               {
                  addr1285:
                  §§goto(addr832);
               }
               §§goto(addr819);
            case 15:
               mstate.esp += 16;
               mstate.esp -= 4;
               this.i17 = mstate.ebp + -1328;
               si32(this.i17,mstate.esp);
               state = 16;
               mstate.esp -= 4;
               FSM_luaL_addvalue.start();
               return;
            case 16:
               mstate.esp += 4;
               this.i17 = li32(mstate.ebp + -1332);
               if(uint(this.i14) < uint(this.i17))
               {
                  §§goto(addr1285);
               }
               §§goto(addr819);
            case 18:
               this.i14 = mstate.eax;
               mstate.esp += 12;
               this.i14 ^= -1;
               this.i16 = li32(this.i15 + 8);
               this.i14 *= 12;
               mstate.esp -= 12;
               this.i17 = 1;
               this.i14 = this.i16 + this.i14;
               si32(this.i15,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               si32(this.i17,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
            case 23:
               mstate.esp += 16;
               mstate.esp -= 8;
               this.i14 = 3;
               si32(this.i15,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 24:
               this.i14 = mstate.eax;
               mstate.esp += 8;
               this.i16 = li32(this.i15 + 8);
               mstate.esp -= 16;
               this.i16 += -12;
               si32(this.i15,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               si32(this.i16,mstate.esp + 8);
               si32(this.i16,mstate.esp + 12);
               state = 25;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 27:
               mstate.esp += 4;
               addr2161:
               this.i14 = 4;
               this.i16 = li32(this.i18);
               mstate.esp -= 12;
               si32(this.i15,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i17,mstate.esp + 8);
               state = 28;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 28:
               this.i15 = mstate.eax;
               mstate.esp += 12;
               si32(this.i15,this.i16);
               si32(this.i14,this.i16 + 8);
               this.i15 = li32(this.i18);
               this.i15 += 12;
               si32(this.i15,this.i18);
               mstate.esp -= 4;
               this.i15 = mstate.ebp + -1328;
               si32(this.i15,mstate.esp);
               state = 29;
               mstate.esp -= 4;
               FSM_luaL_addvalue.start();
               return;
            case 29:
               mstate.esp += 4;
               if(this.i13 != 0)
               {
                  if(uint(this.i13) <= uint(this.i0))
                  {
                     addr2296:
                     §§goto(addr2442);
                  }
                  else
                  {
                     this.i0 = this.i13;
                  }
                  §§goto(addr2592);
               }
               §§goto(addr2296);
            case 30:
               mstate.esp += 12;
               addr2390:
               this.i14 = mstate.ebp + -1328;
               mstate.esp -= 4;
               si32(this.i14,mstate.esp);
               state = 31;
               mstate.esp -= 4;
               FSM_luaL_addvalue.start();
               return;
            case 31:
               mstate.esp += 4;
               §§goto(addr2426);
            case 32:
               this.i13 = mstate.eax;
               mstate.esp += 4;
               if(this.i13 != 0)
               {
                  this.i13 = mstate.ebp + -1328;
                  mstate.esp -= 4;
                  si32(this.i13,mstate.esp);
                  state = 33;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr2558);
               break;
            case 33:
               mstate.esp += 4;
               §§goto(addr2558);
            case 34:
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               state = 35;
               mstate.esp -= 4;
               FSM_emptybuffer.start();
               return;
            case 35:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i0 = li32(this.i8);
               this.i3 = li32(this.i9);
               mstate.esp -= 8;
               si32(this.i3,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 36;
               mstate.esp -= 4;
               FSM_lua_concat.start();
               return;
            case 36:
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 8);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0);
               this.i2 = 3;
               si32(this.i2,this.i0 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               this.i0 = 2;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _str_gsub";
         }
         this.i13 = 0;
         si32(this.i13,this.i11);
         mstate.esp -= 12;
         this.i13 = mstate.ebp + -288;
         si32(this.i13,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 7;
         mstate.esp -= 4;
         FSM_match384.start();
      }
   }
}
