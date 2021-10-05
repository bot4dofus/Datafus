package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_primaryexp extends Machine
   {
      
      public static const intRegCount:int = 29;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i21:int;
      
      public var f0:Number;
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i17:int;
      
      public var i19:int;
      
      public var i16:int;
      
      public var i18:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i22:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public var i2:int;
      
      public var i23:int;
      
      public var i24:int;
      
      public var i25:int;
      
      public var i26:int;
      
      public var i27:int;
      
      public var i20:int;
      
      public var i9:int;
      
      public var i28:int;
      
      public function FSM_primaryexp()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_primaryexp = null;
         _loc1_ = new FSM_primaryexp();
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
               mstate.esp -= 176;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 36);
               this.i2 = li32(this.i0 + 12);
               this.i3 = this.i0 + 12;
               this.i4 = this.i0 + 36;
               this.i5 = li32(mstate.ebp + 12);
               if(this.i2 == 285)
               {
                  this.i2 = 1;
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_str_checkname.start();
                  return;
               }
               if(this.i2 == 40)
               {
                  this.i2 = li32(this.i0 + 4);
                  si32(this.i2,this.i0 + 8);
                  this.i6 = li32(this.i0 + 24);
                  this.i7 = this.i0 + 24;
                  if(this.i6 == 287)
                  {
                     mstate.esp -= 8;
                     this.i6 = this.i0 + 16;
                     si32(this.i0,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  this.i8 = 287;
                  si32(this.i6,this.i3);
                  this.f0 = lf64(this.i0 + 28);
                  sf64(this.f0,this.i0 + 16);
                  si32(this.i8,this.i7);
                  §§goto(addr189);
               }
               else
               {
                  this.i6 = 80;
                  this.i7 = li32(this.i0 + 52);
                  mstate.esp -= 12;
                  this.i8 = mstate.ebp + -96;
                  this.i7 += 16;
                  si32(this.i8,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaO_chunkid.start();
               }
            case 8:
               mstate.esp += 12;
               this.i6 = li32(this.i0 + 4);
               this.i7 = li32(this.i0 + 40);
               mstate.esp -= 20;
               this.i9 = __2E_str15272;
               this.i10 = __2E_str26120;
               si32(this.i7,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               si32(this.i10,mstate.esp + 16);
               state = 9;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 1:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               si32(this.i6,this.i3);
               addr189:
               this.i6 = 0;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_subexpr.start();
               return;
            case 2:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 16;
               this.i6 = 40;
               this.i7 = 41;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 3;
               mstate.esp -= 4;
               FSM_check_match.start();
               return;
            case 3:
               mstate.esp += 16;
               this.i2 = li32(this.i4);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaK_dischargevars.start();
               return;
            case 4:
               mstate.esp += 8;
               this.i2 = li32(this.i3);
               if(this.i2 <= 90)
               {
                  if(this.i2 != 40)
                  {
                     if(this.i2 != 46)
                     {
                        if(this.i2 == 58)
                        {
                           addr367:
                           this.i2 = mstate.ebp + -176;
                           this.i6 = mstate.ebp + -16;
                           this.i7 = this.i0 + 16;
                           this.i8 = this.i0 + 28;
                           this.i9 = this.i1 + 12;
                           this.i10 = this.i1 + 36;
                           this.i11 = this.i1 + 50;
                           this.i12 = this.i5 + 4;
                           this.i13 = this.i5 + 16;
                           this.i14 = this.i5 + 12;
                           this.i15 = this.i2 + 4;
                           this.i16 = this.i2 + 16;
                           this.i17 = this.i2 + 12;
                           this.i18 = this.i6 + 8;
                           this.i19 = this.i0 + 24;
                           this.i20 = this.i0 + 8;
                           this.i21 = this.i0 + 4;
                           this.i22 = this.i5;
                           this.i23 = this.i7;
                           this.i24 = li32(this.i21);
                           si32(this.i24,this.i20);
                           this.i24 = li32(this.i19);
                           if(this.i24 != 287)
                           {
                              this.i25 = 287;
                              si32(this.i24,this.i3);
                              this.f0 = lf64(this.i8);
                              sf64(this.f0,this.i7);
                              si32(this.i25,this.i19);
                              break;
                           }
                           mstate.esp -= 8;
                           si32(this.i0,mstate.esp);
                           si32(this.i23,mstate.esp + 4);
                           state = 26;
                           mstate.esp -= 4;
                           FSM_llex.start();
                           return;
                        }
                        §§goto(addr2824);
                     }
                     else
                     {
                        §§goto(addr1333);
                     }
                  }
               }
               else if(this.i2 != 91)
               {
                  if(this.i2 != 123)
                  {
                     if(this.i2 != 286)
                     {
                        §§goto(addr2824);
                     }
                  }
               }
               else
               {
                  §§goto(addr1414);
               }
               §§goto(addr2709);
            case 5:
               this.i6 = mstate.eax;
               mstate.esp += 4;
               this.i7 = li32(this.i4);
               mstate.esp -= 16;
               si32(this.i7,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               FSM_singlevaraux.start();
               return;
            case 6:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               if(this.i2 == 8)
               {
                  this.i2 = 4;
                  si32(this.i6,mstate.ebp + -112);
                  si32(this.i2,mstate.ebp + -104);
                  mstate.esp -= 12;
                  this.i2 = mstate.ebp + -112;
                  si32(this.i7,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_addk.start();
                  return;
               }
               §§goto(addr722);
               break;
            case 7:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i5 + 4);
               addr722:
               this.i2 = li32(this.i3);
               if(this.i2 <= 90)
               {
                  if(this.i2 != 40)
                  {
                     if(this.i2 != 46)
                     {
                        if(this.i2 != 58)
                        {
                           §§goto(addr2824);
                        }
                        else
                        {
                           addr366:
                           §§goto(addr367);
                        }
                     }
                     else
                     {
                        §§goto(addr1333);
                     }
                  }
               }
               else if(this.i2 != 91)
               {
                  if(this.i2 != 123)
                  {
                     if(this.i2 != 286)
                     {
                        §§goto(addr2824);
                     }
                  }
               }
               else
               {
                  §§goto(addr1414);
               }
               §§goto(addr2709);
            case 9:
               this.i6 = mstate.eax;
               mstate.esp += 20;
               this.i7 = this.i0 + 40;
               if(this.i2 != 0)
               {
                  if(this.i2 != 284)
                  {
                     if(this.i2 != 286)
                     {
                        this.i8 = __2E_str35292;
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        state = 13;
                        mstate.esp -= 4;
                        FSM_luaX_token2str.start();
                        return;
                     }
                  }
                  this.i2 = 0;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 10;
                  mstate.esp -= 4;
                  FSM_save.start();
                  return;
               }
               this.i2 = 3;
               this.i6 = li32(this.i7);
               mstate.esp -= 8;
               si32(this.i6,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 16;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
               break;
            case 10:
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 48);
               this.i2 = li32(this.i2);
               this.i8 = li32(this.i7);
               mstate.esp -= 16;
               this.i9 = __2E_str35292;
               si32(this.i8,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 11;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 11:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i7);
               mstate.esp -= 8;
               this.i6 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               state = 12;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 12:
               mstate.esp += 8;
               §§goto(addr1290);
            case 13:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i7);
               mstate.esp -= 16;
               si32(this.i9,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 14;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 14:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i7 = li32(this.i7);
               mstate.esp -= 8;
               this.i2 = 3;
               si32(this.i7,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 15;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 15:
               mstate.esp += 8;
               §§goto(addr1290);
            case 16:
               mstate.esp += 8;
               addr1290:
               this.i2 = li32(this.i3);
               if(this.i2 <= 90)
               {
                  if(this.i2 != 40)
                  {
                     if(this.i2 != 46)
                     {
                        if(this.i2 != 58)
                        {
                           §§goto(addr2824);
                        }
                        else
                        {
                           §§goto(addr366);
                        }
                     }
                     else
                     {
                        §§goto(addr1333);
                     }
                  }
               }
               else if(this.i2 != 91)
               {
                  if(this.i2 != 123)
                  {
                     if(this.i2 != 286)
                     {
                        §§goto(addr2824);
                     }
                  }
               }
               else
               {
                  §§goto(addr1414);
               }
               §§goto(addr2709);
            case 17:
               mstate.esp += 8;
               this.i2 = li32(this.i3);
               if(this.i2 <= 90)
               {
                  if(this.i2 != 40)
                  {
                     if(this.i2 != 46)
                     {
                        if(this.i2 != 58)
                        {
                           §§goto(addr2824);
                        }
                        else
                        {
                           §§goto(addr366);
                        }
                     }
                     else
                     {
                        §§goto(addr1332);
                     }
                  }
               }
               else if(this.i2 != 286)
               {
                  if(this.i2 != 123)
                  {
                     if(this.i2 == 91)
                     {
                        §§goto(addr1414);
                     }
                     else
                     {
                        §§goto(addr2824);
                     }
                  }
               }
               §§goto(addr2709);
            case 18:
               mstate.esp += 8;
               this.i17 = li32(this.i16);
               if(this.i17 == 12)
               {
                  this.i17 = li32(this.i14);
                  this.i18 = li32(this.i13);
                  this.i19 = li32(this.i12);
                  if(this.i17 != this.i18)
                  {
                     this.i17 = li8(this.i11);
                     if(this.i19 >= this.i17)
                     {
                        mstate.esp -= 12;
                        si32(this.i1,mstate.esp);
                        si32(this.i5,mstate.esp + 4);
                        si32(this.i19,mstate.esp + 8);
                        state = 19;
                        mstate.esp -= 4;
                        FSM_exp2reg.start();
                        return;
                     }
                  }
                  else
                  {
                     addr1646:
                     this.i17 = li32(this.i10);
                     si32(this.i17,this.i9);
                     this.i17 = li32(this.i8);
                     if(this.i17 == 287)
                     {
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i15,mstate.esp + 4);
                        state = 21;
                        mstate.esp -= 4;
                        FSM_llex.start();
                        return;
                     }
                     this.i18 = 287;
                     si32(this.i17,this.i3);
                     this.f0 = lf64(this.i6);
                     sf64(this.f0,this.i2);
                     si32(this.i18,this.i8);
                     §§goto(addr1736);
                  }
               }
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 20;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 19:
               mstate.esp += 12;
               §§goto(addr1646);
            case 20:
               mstate.esp += 8;
               §§goto(addr1646);
            case 21:
               this.i17 = mstate.eax;
               mstate.esp += 8;
               si32(this.i17,this.i3);
               addr1736:
               this.i17 = mstate.ebp + -144;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i17,mstate.esp + 4);
               state = 22;
               mstate.esp -= 4;
               FSM_expr.start();
               return;
            case 22:
               mstate.esp += 8;
               this.i18 = li32(this.i4);
               mstate.esp -= 8;
               si32(this.i18,mstate.esp);
               si32(this.i17,mstate.esp + 4);
               state = 23;
               mstate.esp -= 4;
               FSM_luaK_exp2val.start();
               return;
            case 23:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i18 = 93;
               si32(this.i0,mstate.esp);
               si32(this.i18,mstate.esp + 4);
               state = 24;
               mstate.esp -= 4;
               FSM_checknext.start();
               return;
            case 24:
               mstate.esp += 8;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i17,mstate.esp + 4);
               state = 25;
               mstate.esp -= 4;
               FSM_luaK_exp2RK.start();
               return;
            case 25:
               this.i17 = mstate.eax;
               mstate.esp += 8;
               si32(this.i17,this.i7);
               this.i17 = 9;
               si32(this.i17,this.i16);
               this.i17 = li32(this.i3);
               if(this.i17 <= 90)
               {
                  if(this.i17 != 40)
                  {
                     if(this.i17 != 46)
                     {
                        if(this.i17 != 58)
                        {
                           §§goto(addr2824);
                        }
                        else
                        {
                           §§goto(addr366);
                        }
                     }
                     else
                     {
                        §§goto(addr1332);
                     }
                  }
               }
               else if(this.i17 != 91)
               {
                  if(this.i17 != 123)
                  {
                     if(this.i17 != 286)
                     {
                        §§goto(addr2824);
                     }
                  }
               }
               else
               {
                  §§goto(addr1414);
               }
               §§goto(addr2709);
            case 26:
               this.i24 = mstate.eax;
               mstate.esp += 8;
               si32(this.i24,this.i3);
               break;
            case 27:
               this.i25 = mstate.eax;
               mstate.esp += 4;
               this.i26 = li32(this.i4);
               si32(this.i25,this.i6);
               si32(this.i24,this.i18);
               mstate.esp -= 12;
               this.i25 = mstate.ebp + -16;
               si32(this.i26,mstate.esp);
               si32(this.i25,mstate.esp + 4);
               si32(this.i25,mstate.esp + 8);
               state = 28;
               mstate.esp -= 4;
               FSM_addk.start();
               return;
            case 28:
               this.i25 = mstate.eax;
               mstate.esp += 12;
               this.i26 = -1;
               si32(this.i26,this.i17);
               si32(this.i26,this.i16);
               si32(this.i24,this.i2);
               si32(this.i25,this.i15);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 29;
               mstate.esp -= 4;
               FSM_luaK_dischargevars.start();
               return;
            case 29:
               mstate.esp += 8;
               this.i24 = li32(this.i22);
               if(this.i24 == 12)
               {
                  this.i24 = li32(this.i14);
                  this.i25 = li32(this.i13);
                  this.i26 = li32(this.i12);
                  if(this.i24 != this.i25)
                  {
                     this.i24 = li8(this.i11);
                     if(this.i26 >= this.i24)
                     {
                        mstate.esp -= 12;
                        si32(this.i1,mstate.esp);
                        si32(this.i5,mstate.esp + 4);
                        si32(this.i26,mstate.esp + 8);
                        state = 30;
                        mstate.esp -= 4;
                        FSM_exp2reg.start();
                        return;
                     }
                  }
                  else
                  {
                     §§goto(addr2294);
                  }
               }
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 31;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 30:
               mstate.esp += 12;
               §§goto(addr2294);
            case 31:
               mstate.esp += 8;
               addr2294:
               this.i24 = li32(this.i22);
               if(this.i24 == 12)
               {
                  this.i24 = li32(this.i12);
                  this.i25 = this.i24 & 256;
                  if(this.i25 == 0)
                  {
                     this.i25 = li8(this.i11);
                     if(this.i25 <= this.i24)
                     {
                        this.i24 = li32(this.i10);
                        this.i24 += -1;
                        si32(this.i24,this.i10);
                     }
                  }
               }
               this.i24 = 2;
               this.i25 = li32(this.i10);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i24,mstate.esp + 4);
               state = 32;
               mstate.esp -= 4;
               FSM_luaK_checkstack.start();
               return;
            case 32:
               mstate.esp += 8;
               this.i24 = li32(this.i10);
               this.i24 += 2;
               si32(this.i24,this.i10);
               mstate.esp -= 8;
               this.i24 = mstate.ebp + -176;
               si32(this.i1,mstate.esp);
               si32(this.i24,mstate.esp + 4);
               state = 33;
               mstate.esp -= 4;
               FSM_luaK_exp2RK.start();
               return;
            case 33:
               this.i24 = mstate.eax;
               mstate.esp += 8;
               this.i26 = li32(this.i12);
               this.i27 = li32(this.i9);
               this.i26 <<= 23;
               this.i28 = this.i25 << 6;
               this.i27 = li32(this.i27 + 8);
               this.i26 = this.i28 | this.i26;
               this.i24 <<= 14;
               this.i24 = this.i26 | this.i24;
               mstate.esp -= 12;
               this.i24 |= 11;
               si32(this.i1,mstate.esp);
               si32(this.i24,mstate.esp + 4);
               si32(this.i27,mstate.esp + 8);
               state = 34;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 34:
               this.i24 = mstate.eax;
               mstate.esp += 12;
               this.i24 = li32(this.i2);
               if(this.i24 == 12)
               {
                  this.i24 = li32(this.i15);
                  this.i26 = this.i24 & 256;
                  if(this.i26 == 0)
                  {
                     this.i26 = li8(this.i11);
                     if(this.i26 <= this.i24)
                     {
                        this.i24 = li32(this.i10);
                        this.i24 += -1;
                        si32(this.i24,this.i10);
                     }
                  }
               }
               this.i24 = 12;
               si32(this.i25,this.i12);
               si32(this.i24,this.i22);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 35;
               mstate.esp -= 4;
               FSM_funcargs.start();
               return;
            case 35:
               mstate.esp += 8;
               this.i24 = li32(this.i3);
               if(this.i24 <= 90)
               {
                  if(this.i24 != 40)
                  {
                     if(this.i24 != 46)
                     {
                        if(this.i24 != 58)
                        {
                           §§goto(addr2824);
                        }
                        else
                        {
                           §§goto(addr367);
                        }
                     }
                     else
                     {
                        §§goto(addr1332);
                     }
                  }
               }
               else if(this.i24 != 91)
               {
                  if(this.i24 != 123)
                  {
                     if(this.i24 != 286)
                     {
                        §§goto(addr2824);
                     }
                  }
               }
               else
               {
                  §§goto(addr1413);
               }
               §§goto(addr2709);
            case 36:
               mstate.esp += 8;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 37;
               mstate.esp -= 4;
               FSM_funcargs.start();
               return;
            case 37:
               mstate.esp += 8;
               this.i2 = li32(this.i3);
               if(this.i2 <= 90)
               {
                  if(this.i2 != 40)
                  {
                     if(this.i2 == 46)
                     {
                        addr1332:
                        addr1333:
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i5,mstate.esp + 4);
                        state = 17;
                        mstate.esp -= 4;
                        FSM_field.start();
                        return;
                     }
                     if(this.i2 != 58)
                     {
                        §§goto(addr2824);
                     }
                     else
                     {
                        §§goto(addr366);
                     }
                  }
               }
               else
               {
                  if(this.i2 == 91)
                  {
                     addr1413:
                     addr1414:
                     this.i2 = this.i0 + 16;
                     this.i6 = this.i0 + 28;
                     this.i7 = this.i5 + 8;
                     this.i8 = this.i0 + 24;
                     this.i9 = this.i0 + 8;
                     this.i10 = this.i0 + 4;
                     this.i11 = this.i1 + 50;
                     this.i12 = this.i5 + 4;
                     this.i13 = this.i5 + 16;
                     this.i14 = this.i5 + 12;
                     this.i15 = this.i2;
                     this.i16 = this.i5;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 18;
                     mstate.esp -= 4;
                     FSM_luaK_dischargevars.start();
                     return;
                  }
                  if(this.i2 != 123)
                  {
                     if(this.i2 != 286)
                     {
                        addr2824:
                        mstate.esp = mstate.ebp;
                        mstate.ebp = li32(mstate.esp);
                        mstate.esp += 4;
                        mstate.esp += 4;
                        mstate.gworker = caller;
                        return;
                     }
                  }
               }
               addr2709:
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 36;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            default:
               throw "Invalid state in _primaryexp";
         }
         this.i24 = 4;
         mstate.esp -= 4;
         si32(this.i0,mstate.esp);
         state = 27;
         mstate.esp -= 4;
         FSM_str_checkname.start();
      }
   }
}
