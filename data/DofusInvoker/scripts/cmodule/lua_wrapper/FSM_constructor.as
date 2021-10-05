package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_constructor extends Machine
   {
      
      public static const intRegCount:int = 32;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i21:int;
      
      public var i30:int;
      
      public var i31:int;
      
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
      
      public var i29:int;
      
      public function FSM_constructor()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_constructor = null;
         _loc1_ = new FSM_constructor();
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
               mstate.esp -= 368;
               this.i0 = 10;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 36);
               this.i3 = li32(this.i2 + 12);
               this.i4 = li32(this.i1 + 4);
               this.i3 = li32(this.i3 + 8);
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i3 = 0;
               si32(this.i3,mstate.ebp + -336);
               si32(this.i3,mstate.ebp + -344);
               si32(this.i3,mstate.ebp + -340);
               this.i5 = li32(mstate.ebp + 12);
               si32(this.i5,mstate.ebp + -348);
               this.i6 = -1;
               si32(this.i6,this.i5 + 12);
               si32(this.i6,this.i5 + 16);
               this.i7 = 11;
               si32(this.i7,this.i5);
               si32(this.i0,this.i5 + 4);
               si32(this.i6,mstate.ebp + -356);
               si32(this.i6,mstate.ebp + -352);
               si32(this.i3,mstate.ebp + -368);
               si32(this.i3,mstate.ebp + -364);
               this.i3 = li32(this.i1 + 36);
               mstate.esp -= 8;
               si32(this.i3,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 2:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i3 = 123;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               this.i3 = mstate.ebp + -368;
               state = 3;
               mstate.esp -= 4;
               FSM_checknext.start();
               return;
            case 3:
               mstate.esp += 8;
               this.i5 = this.i1 + 28;
               this.i6 = this.i1 + 16;
               this.i7 = mstate.ebp + -240;
               this.i8 = mstate.ebp + -320;
               this.i9 = this.i1 + 8;
               this.i10 = mstate.ebp + -80;
               this.i11 = mstate.ebp + -160;
               this.i12 = this.i2 + 36;
               this.i13 = this.i1 + 24;
               this.i14 = this.i1 + 12;
               this.i15 = this.i3 + 4;
               this.i16 = this.i3 + 20;
               this.i17 = this.i3 + 28;
               this.i18 = this.i3 + 24;
               this.i19 = this.i3 + 32;
               this.i20 = this.i2 + 12;
               this.i21 = this.i1 + 4;
               this.i22 = this.i1 + 36;
               this.i23 = this.i6;
               this.i24 = this.i5;
               this.i25 = this.i3;
               addr422:
               this.i26 = li32(this.i14);
               if(this.i26 != 125)
               {
                  this.i26 = li32(this.i3);
                  if(this.i26 != 0)
                  {
                     this.i26 = 0;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i25,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaK_exp2nextreg.start();
                     return;
                  }
                  break;
               }
               §§goto(addr2737);
               break;
            case 4:
               mstate.esp += 8;
               si32(this.i26,this.i3);
               this.i26 = li32(this.i19);
               if(this.i26 == 50)
               {
                  this.i27 = li32(this.i17);
                  this.i27 += -1;
                  this.i28 = li32(this.i16);
                  this.i29 = li32(this.i20);
                  this.i28 = li32(this.i28 + 4);
                  this.i29 = li32(this.i29 + 8);
                  this.i30 = this.i26 << 23;
                  this.i27 /= 50;
                  this.i26 = this.i26 == -1 ? 0 : int(this.i30);
                  this.i30 = this.i28 << 6;
                  this.i28 += 1;
                  this.i27 += 1;
                  if(this.i27 <= 511)
                  {
                     this.i26 = this.i30 | this.i26;
                     this.i27 <<= 14;
                     this.i26 |= this.i27;
                     mstate.esp -= 12;
                     this.i26 |= 34;
                     si32(this.i2,mstate.esp);
                     si32(this.i26,mstate.esp + 4);
                     si32(this.i29,mstate.esp + 8);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaK_code.start();
                     return;
                  }
                  this.i26 = this.i30 | this.i26;
                  mstate.esp -= 12;
                  this.i26 |= 34;
                  si32(this.i2,mstate.esp);
                  si32(this.i26,mstate.esp + 4);
                  si32(this.i29,mstate.esp + 8);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaK_code.start();
                  return;
               }
               break;
            case 5:
               this.i26 = mstate.eax;
               mstate.esp += 12;
               addr775:
               this.i26 = 0;
               si32(this.i28,this.i12);
               si32(this.i26,this.i19);
               break;
            case 6:
               this.i26 = mstate.eax;
               mstate.esp += 12;
               this.i26 = li32(this.i20);
               this.i26 = li32(this.i26 + 8);
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i27,mstate.esp + 4);
               si32(this.i26,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 7:
               this.i26 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr775);
            case 8:
               this.i26 = mstate.eax;
               mstate.esp += 8;
               si32(this.i26,this.i13);
               if(this.i26 != 61)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i25,mstate.esp + 4);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_expr.start();
                  return;
               }
               this.i26 = mstate.ebp + -368;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i26,mstate.esp + 4);
               state = 19;
               mstate.esp -= 4;
               FSM_recfield.start();
               return;
               break;
            case 9:
               mstate.esp += 8;
               this.i26 = li32(this.i17);
               if(this.i26 >= 2147483646)
               {
                  this.i26 = li32(this.i22);
                  this.i27 = li32(this.i26);
                  this.i27 = li32(this.i27 + 60);
                  this.i28 = li32(this.i26 + 16);
                  this.i26 += 12;
                  if(this.i27 == 0)
                  {
                     this.i27 = __2E_str196;
                     mstate.esp -= 16;
                     this.i29 = __2E_str23117;
                     this.i30 = 2147483645;
                     si32(this.i28,mstate.esp);
                     si32(this.i27,mstate.esp + 4);
                     si32(this.i30,mstate.esp + 8);
                     si32(this.i29,mstate.esp + 12);
                     state = 10;
                     mstate.esp -= 4;
                     FSM_luaO_pushfstring.start();
                     return;
                  }
                  this.i29 = __2E_str297;
                  mstate.esp -= 20;
                  this.i30 = __2E_str23117;
                  this.i31 = 2147483645;
                  si32(this.i28,mstate.esp);
                  si32(this.i29,mstate.esp + 4);
                  si32(this.i27,mstate.esp + 8);
                  si32(this.i31,mstate.esp + 12);
                  si32(this.i30,mstate.esp + 16);
                  state = 14;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               §§goto(addr1466);
               break;
            case 10:
               this.i27 = mstate.eax;
               mstate.esp += 16;
               this.i26 = li32(this.i26);
               this.i28 = li32(this.i26 + 52);
               mstate.esp -= 12;
               this.i29 = 80;
               this.i28 += 16;
               si32(this.i11,mstate.esp);
               si32(this.i28,mstate.esp + 4);
               si32(this.i29,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 11:
               mstate.esp += 12;
               this.i28 = li32(this.i26 + 4);
               this.i29 = li32(this.i26 + 40);
               mstate.esp -= 20;
               this.i30 = __2E_str15272;
               this.i31 = mstate.ebp + -160;
               si32(this.i29,mstate.esp);
               si32(this.i30,mstate.esp + 4);
               si32(this.i31,mstate.esp + 8);
               si32(this.i28,mstate.esp + 12);
               si32(this.i27,mstate.esp + 16);
               state = 12;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 12:
               this.i27 = mstate.eax;
               mstate.esp += 20;
               this.i26 = li32(this.i26 + 40);
               mstate.esp -= 8;
               this.i27 = 3;
               si32(this.i26,mstate.esp);
               si32(this.i27,mstate.esp + 4);
               state = 13;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 13:
               mstate.esp += 8;
               §§goto(addr1466);
            case 14:
               this.i27 = mstate.eax;
               mstate.esp += 20;
               this.i26 = li32(this.i26);
               this.i28 = li32(this.i26 + 52);
               mstate.esp -= 12;
               this.i29 = 80;
               this.i28 += 16;
               si32(this.i10,mstate.esp);
               si32(this.i28,mstate.esp + 4);
               si32(this.i29,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 15:
               mstate.esp += 12;
               this.i28 = li32(this.i26 + 4);
               this.i29 = li32(this.i26 + 40);
               mstate.esp -= 20;
               this.i30 = __2E_str15272;
               this.i31 = mstate.ebp + -80;
               si32(this.i29,mstate.esp);
               si32(this.i30,mstate.esp + 4);
               si32(this.i31,mstate.esp + 8);
               si32(this.i28,mstate.esp + 12);
               si32(this.i27,mstate.esp + 16);
               state = 16;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 16:
               this.i27 = mstate.eax;
               mstate.esp += 20;
               this.i26 = li32(this.i26 + 40);
               mstate.esp -= 8;
               this.i27 = 3;
               si32(this.i26,mstate.esp);
               si32(this.i27,mstate.esp + 4);
               state = 17;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 17:
               mstate.esp += 8;
               addr1466:
               this.i26 = li32(this.i17);
               this.i26 += 1;
               si32(this.i26,this.i17);
               this.i26 = li32(this.i19);
               this.i26 += 1;
               si32(this.i26,this.i19);
               this.i26 = li32(this.i14);
               if(this.i26 == 44)
               {
                  this.i26 = li32(this.i21);
                  si32(this.i26,this.i9);
                  this.i26 = li32(this.i13);
                  if(this.i26 == 287)
                  {
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i23,mstate.esp + 4);
                     state = 18;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  this.i27 = 287;
                  si32(this.i26,this.i14);
                  this.f0 = lf64(this.i24);
                  sf64(this.f0,this.i6);
                  si32(this.i27,this.i13);
                  addr421:
                  §§goto(addr422);
               }
               else
               {
                  addr2635:
                  this.i26 = li32(this.i14);
                  if(this.i26 == 59)
                  {
                     this.i26 = li32(this.i21);
                     si32(this.i26,this.i9);
                     this.i26 = li32(this.i13);
                     if(this.i26 == 287)
                     {
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i23,mstate.esp + 4);
                        state = 33;
                        mstate.esp -= 4;
                        FSM_llex.start();
                        return;
                     }
                     this.i27 = 287;
                     si32(this.i26,this.i14);
                     this.f0 = lf64(this.i24);
                     sf64(this.f0,this.i6);
                     si32(this.i27,this.i13);
                     §§goto(addr421);
                  }
               }
               §§goto(addr2737);
            case 18:
               this.i26 = mstate.eax;
               mstate.esp += 8;
               si32(this.i26,this.i14);
               §§goto(addr421);
            case 19:
               mstate.esp += 8;
               this.i26 = li32(this.i14);
               if(this.i26 == 44)
               {
                  this.i26 = li32(this.i21);
                  si32(this.i26,this.i9);
                  this.i26 = li32(this.i13);
                  if(this.i26 == 287)
                  {
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i23,mstate.esp + 4);
                     state = 20;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  this.i27 = 287;
                  si32(this.i26,this.i14);
                  this.f0 = lf64(this.i24);
                  sf64(this.f0,this.i6);
                  si32(this.i27,this.i13);
                  §§goto(addr421);
               }
               else
               {
                  §§goto(addr2635);
               }
               §§goto(addr2737);
            case 20:
               this.i26 = mstate.eax;
               mstate.esp += 8;
               si32(this.i26,this.i14);
               §§goto(addr421);
            case 21:
               mstate.esp += 8;
               this.i26 = li32(this.i14);
               if(this.i26 == 44)
               {
                  this.i26 = li32(this.i21);
                  si32(this.i26,this.i9);
                  this.i26 = li32(this.i13);
                  if(this.i26 == 287)
                  {
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i23,mstate.esp + 4);
                     state = 22;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  this.i27 = 287;
                  si32(this.i26,this.i14);
                  this.f0 = lf64(this.i24);
                  sf64(this.f0,this.i6);
                  si32(this.i27,this.i13);
                  §§goto(addr421);
               }
               else
               {
                  §§goto(addr2635);
               }
               §§goto(addr2737);
            case 22:
               this.i26 = mstate.eax;
               mstate.esp += 8;
               si32(this.i26,this.i14);
               §§goto(addr421);
            case 23:
               mstate.esp += 8;
               this.i26 = li32(this.i17);
               if(this.i26 >= 2147483646)
               {
                  this.i26 = li32(this.i22);
                  this.i27 = li32(this.i26);
                  this.i27 = li32(this.i27 + 60);
                  this.i28 = li32(this.i26 + 16);
                  this.i26 += 12;
                  if(this.i27 == 0)
                  {
                     this.i27 = __2E_str196;
                     mstate.esp -= 16;
                     this.i29 = __2E_str23117;
                     this.i30 = 2147483645;
                     si32(this.i28,mstate.esp);
                     si32(this.i27,mstate.esp + 4);
                     si32(this.i30,mstate.esp + 8);
                     si32(this.i29,mstate.esp + 12);
                     state = 24;
                     mstate.esp -= 4;
                     FSM_luaO_pushfstring.start();
                     return;
                  }
                  this.i29 = __2E_str297;
                  mstate.esp -= 20;
                  this.i30 = __2E_str23117;
                  this.i31 = 2147483645;
                  si32(this.i28,mstate.esp);
                  si32(this.i29,mstate.esp + 4);
                  si32(this.i27,mstate.esp + 8);
                  si32(this.i31,mstate.esp + 12);
                  si32(this.i30,mstate.esp + 16);
                  state = 28;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               §§goto(addr2501);
               break;
            case 24:
               this.i27 = mstate.eax;
               mstate.esp += 16;
               this.i26 = li32(this.i26);
               this.i28 = li32(this.i26 + 52);
               mstate.esp -= 12;
               this.i29 = 80;
               this.i28 += 16;
               si32(this.i8,mstate.esp);
               si32(this.i28,mstate.esp + 4);
               si32(this.i29,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 25:
               mstate.esp += 12;
               this.i28 = li32(this.i26 + 4);
               this.i29 = li32(this.i26 + 40);
               mstate.esp -= 20;
               this.i30 = __2E_str15272;
               this.i31 = mstate.ebp + -320;
               si32(this.i29,mstate.esp);
               si32(this.i30,mstate.esp + 4);
               si32(this.i31,mstate.esp + 8);
               si32(this.i28,mstate.esp + 12);
               si32(this.i27,mstate.esp + 16);
               state = 26;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 26:
               this.i27 = mstate.eax;
               mstate.esp += 20;
               this.i26 = li32(this.i26 + 40);
               mstate.esp -= 8;
               this.i27 = 3;
               si32(this.i26,mstate.esp);
               si32(this.i27,mstate.esp + 4);
               state = 27;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 27:
               mstate.esp += 8;
               §§goto(addr2501);
            case 28:
               this.i27 = mstate.eax;
               mstate.esp += 20;
               this.i26 = li32(this.i26);
               this.i28 = li32(this.i26 + 52);
               mstate.esp -= 12;
               this.i29 = 80;
               this.i28 += 16;
               si32(this.i7,mstate.esp);
               si32(this.i28,mstate.esp + 4);
               si32(this.i29,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 29:
               mstate.esp += 12;
               this.i28 = li32(this.i26 + 4);
               this.i29 = li32(this.i26 + 40);
               mstate.esp -= 20;
               this.i30 = __2E_str15272;
               this.i31 = mstate.ebp + -240;
               si32(this.i29,mstate.esp);
               si32(this.i30,mstate.esp + 4);
               si32(this.i31,mstate.esp + 8);
               si32(this.i28,mstate.esp + 12);
               si32(this.i27,mstate.esp + 16);
               state = 30;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 30:
               this.i27 = mstate.eax;
               mstate.esp += 20;
               this.i26 = li32(this.i26 + 40);
               mstate.esp -= 8;
               this.i27 = 3;
               si32(this.i26,mstate.esp);
               si32(this.i27,mstate.esp + 4);
               state = 31;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 31:
               mstate.esp += 8;
               addr2501:
               this.i26 = li32(this.i17);
               this.i26 += 1;
               si32(this.i26,this.i17);
               this.i26 = li32(this.i19);
               this.i26 += 1;
               si32(this.i26,this.i19);
               this.i26 = li32(this.i14);
               if(this.i26 == 44)
               {
                  this.i26 = li32(this.i21);
                  si32(this.i26,this.i9);
                  this.i26 = li32(this.i13);
                  if(this.i26 == 287)
                  {
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i23,mstate.esp + 4);
                     state = 32;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  this.i27 = 287;
                  si32(this.i26,this.i14);
                  this.f0 = lf64(this.i24);
                  sf64(this.f0,this.i6);
                  si32(this.i27,this.i13);
                  §§goto(addr421);
               }
               else
               {
                  §§goto(addr2635);
               }
               addr2737:
               this.i5 = 123;
               mstate.esp -= 16;
               this.i6 = 125;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 34;
               mstate.esp -= 4;
               FSM_check_match.start();
               return;
            case 32:
               this.i26 = mstate.eax;
               mstate.esp += 8;
               si32(this.i26,this.i14);
               §§goto(addr421);
            case 33:
               this.i26 = mstate.eax;
               mstate.esp += 8;
               si32(this.i26,this.i14);
               §§goto(addr421);
            case 34:
               mstate.esp += 16;
               this.i1 = li32(this.i19);
               if(this.i1 != 0)
               {
                  this.i1 = li32(this.i3);
                  this.i3 = this.i1 + -13;
                  if(uint(this.i3) <= uint(1))
                  {
                     if(this.i1 != 14)
                     {
                        if(this.i1 == 13)
                        {
                           this.i1 = li32(this.i15);
                           this.i15 = li32(this.i2);
                           this.i15 = li32(this.i15 + 12);
                           this.i1 <<= 2;
                           this.i1 = this.i15 + this.i1;
                           this.i15 = li32(this.i1);
                           this.i15 &= -8372225;
                           si32(this.i15,this.i1);
                        }
                        addr3054:
                        this.i1 = li32(this.i17);
                        this.i1 += -1;
                        this.i16 = li32(this.i16);
                        this.i19 = li32(this.i20);
                        this.i16 = li32(this.i16 + 4);
                        this.i19 = li32(this.i19 + 8);
                        this.i1 /= 50;
                        this.i25 = this.i16 << 6;
                        this.i16 += 1;
                        this.i1 += 1;
                        if(this.i1 <= 511)
                        {
                           this.i1 <<= 14;
                           this.i1 = this.i25 | this.i1;
                           mstate.esp -= 12;
                           this.i1 |= 34;
                           si32(this.i2,mstate.esp);
                           si32(this.i1,mstate.esp + 4);
                           si32(this.i19,mstate.esp + 8);
                           state = 36;
                           mstate.esp -= 4;
                           FSM_luaK_code.start();
                           return;
                        }
                        mstate.esp -= 12;
                        this.i25 |= 34;
                        si32(this.i2,mstate.esp);
                        si32(this.i25,mstate.esp + 4);
                        si32(this.i19,mstate.esp + 8);
                        state = 37;
                        mstate.esp -= 4;
                        FSM_luaK_code.start();
                        return;
                     }
                     this.i1 = 1;
                     this.i19 = li32(this.i15);
                     this.i25 = li32(this.i2);
                     this.i25 = li32(this.i25 + 12);
                     this.i19 <<= 2;
                     this.i19 = this.i25 + this.i19;
                     this.i25 = li32(this.i19);
                     this.i25 &= 8388607;
                     si32(this.i25,this.i19);
                     this.i19 = li32(this.i2);
                     this.i25 = li32(this.i15);
                     this.i19 = li32(this.i19 + 12);
                     this.i25 <<= 2;
                     this.i3 = li32(this.i12);
                     this.i19 += this.i25;
                     this.i25 = li32(this.i19);
                     this.i3 <<= 6;
                     this.i3 &= 16320;
                     this.i25 &= -16321;
                     this.i25 = this.i3 | this.i25;
                     si32(this.i25,this.i19);
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     state = 35;
                     mstate.esp -= 4;
                     FSM_luaK_checkstack.start();
                     return;
                  }
                  if(this.i1 != 0)
                  {
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i25,mstate.esp + 4);
                     state = 39;
                     mstate.esp -= 4;
                     FSM_luaK_exp2nextreg.start();
                     return;
                  }
                  addr3364:
                  this.i1 = li32(this.i17);
                  this.i3 = li32(this.i19);
                  this.i1 += -1;
                  this.i4 = li32(this.i16);
                  this.i5 = li32(this.i20);
                  this.i4 = li32(this.i4 + 4);
                  this.i5 = li32(this.i5 + 8);
                  this.i6 = this.i3 << 23;
                  this.i1 /= 50;
                  this.i3 = this.i3 == -1 ? 0 : int(this.i6);
                  this.i6 = this.i4 << 6;
                  this.i4 += 1;
                  this.i1 += 1;
                  if(this.i1 <= 511)
                  {
                     this.i3 = this.i6 | this.i3;
                     this.i1 <<= 14;
                     this.i1 = this.i3 | this.i1;
                     mstate.esp -= 12;
                     this.i1 |= 34;
                     si32(this.i2,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i5,mstate.esp + 8);
                     state = 40;
                     mstate.esp -= 4;
                     FSM_luaK_code.start();
                     return;
                  }
                  this.i3 = this.i6 | this.i3;
                  mstate.esp -= 12;
                  this.i3 |= 34;
                  si32(this.i2,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  state = 41;
                  mstate.esp -= 4;
                  FSM_luaK_code.start();
                  return;
               }
               addr3651:
               this.i1 = li32(this.i2);
               this.i1 = li32(this.i1 + 12);
               this.i0 <<= 2;
               this.i1 += this.i0;
               this.i3 = li32(this.i1);
               this.i4 = li32(this.i17);
               mstate.esp -= 4;
               si32(this.i4,mstate.esp);
               mstate.esp -= 4;
               FSM_luaO_int2fb.start();
               break;
            case 36:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               addr3300:
               si32(this.i16,this.i12);
               this.i1 = li32(this.i17);
               this.i1 += -1;
               si32(this.i1,this.i17);
               §§goto(addr3651);
            case 38:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr3300);
            case 40:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               addr3646:
               si32(this.i4,this.i12);
               §§goto(addr3651);
            case 42:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr3646);
            case 43:
               this.i4 = mstate.eax;
               this.i4 <<= 23;
               this.i3 &= 8388607;
               mstate.esp += 4;
               this.i3 = this.i4 | this.i3;
               si32(this.i3,this.i1);
               this.i1 = li32(this.i2);
               this.i1 = li32(this.i1 + 12);
               this.i0 = this.i1 + this.i0;
               this.i1 = li32(this.i0);
               this.i2 = li32(this.i18);
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               mstate.esp -= 4;
               FSM_luaO_int2fb.start();
            case 44:
               this.i2 = mstate.eax;
               this.i2 <<= 14;
               this.i2 &= 8372224;
               this.i1 &= -8372225;
               mstate.esp += 4;
               this.i1 = this.i2 | this.i1;
               si32(this.i1,this.i0);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 35:
               mstate.esp += 8;
               this.i1 = li32(this.i12);
               this.i1 += 1;
               si32(this.i1,this.i12);
               §§goto(addr3054);
            case 37:
               this.i19 = mstate.eax;
               mstate.esp += 12;
               this.i19 = li32(this.i20);
               this.i19 = li32(this.i19 + 8);
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i19,mstate.esp + 8);
               state = 38;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 39:
               mstate.esp += 8;
               §§goto(addr3364);
            case 41:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(this.i20);
               this.i3 = li32(this.i3 + 8);
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 42;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            default:
               throw "Invalid state in _constructor";
         }
         this.i26 = li32(this.i14);
         if(this.i26 != 91)
         {
            if(this.i26 == 285)
            {
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_llex.start();
               return;
            }
            mstate.esp -= 8;
            si32(this.i1,mstate.esp);
            si32(this.i25,mstate.esp + 4);
            state = 23;
            mstate.esp -= 4;
            FSM_expr.start();
            return;
         }
         this.i26 = mstate.ebp + -368;
         mstate.esp -= 8;
         si32(this.i1,mstate.esp);
         si32(this.i26,mstate.esp + 4);
         state = 21;
         mstate.esp -= 4;
         FSM_recfield.start();
      }
   }
}
