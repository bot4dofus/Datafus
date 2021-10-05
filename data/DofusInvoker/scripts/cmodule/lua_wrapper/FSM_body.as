package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_body extends Machine
   {
      
      public static const intRegCount:int = 27;
      
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
      
      public var i20:int;
      
      public var i9:int;
      
      public function FSM_body()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_body = null;
         _loc1_ = new FSM_body();
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
               mstate.esp -= 656;
               this.i0 = mstate.ebp + -656;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_open_func.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i2 = li32(mstate.ebp + 20);
               this.i3 = li32(mstate.ebp + -656);
               si32(this.i2,this.i3 + 60);
               mstate.esp -= 8;
               this.i3 = 40;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_checknext.start();
               return;
            case 2:
               mstate.esp += 8;
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = this.i0;
               this.i5 = li32(mstate.ebp + 16);
               if(this.i5 != 0)
               {
                  this.i5 = __2E_str18112;
                  this.i6 = li32(this.i1 + 40);
                  mstate.esp -= 12;
                  this.i7 = 4;
                  si32(this.i6,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i7,mstate.esp + 8);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaS_newlstr.start();
                  return;
               }
               addr497:
               this.i5 = 0;
               this.i6 = li32(this.i1 + 36);
               this.i7 = li32(this.i6);
               si8(this.i5,this.i7 + 74);
               this.i5 = li32(this.i1 + 12);
               this.i8 = this.i1 + 12;
               this.i9 = this.i7 + 74;
               this.i10 = this.i1 + 36;
               if(this.i5 == 41)
               {
                  this.i8 = 0;
                  §§goto(addr556);
               }
               else
               {
                  this.i5 = 0;
                  this.i11 = this.i1 + 16;
                  this.i12 = this.i1 + 28;
                  this.i13 = this.i1 + 24;
                  this.i14 = this.i1 + 8;
                  this.i15 = this.i1 + 48;
                  this.i16 = this.i1 + 40;
                  this.i17 = this.i1 + 4;
                  this.i18 = mstate.ebp + -80;
                  this.i19 = this.i1 + 52;
                  this.i20 = this.i11;
                  addr773:
                  this.i21 = li32(this.i8);
                  if(this.i21 == 279)
                  {
                     this.i15 = li32(this.i17);
                     si32(this.i15,this.i14);
                     this.i14 = li32(this.i13);
                     if(this.i14 != 287)
                     {
                        this.i15 = 287;
                        si32(this.i14,this.i8);
                        this.f0 = lf64(this.i12);
                        sf64(this.f0,this.i11);
                        si32(this.i15,this.i13);
                        break;
                     }
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i20,mstate.esp + 4);
                     state = 8;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  if(this.i21 == 285)
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_str_checkname.start();
                     return;
                  }
                  this.i22 = 80;
                  this.i23 = li32(this.i19);
                  mstate.esp -= 12;
                  this.i23 += 16;
                  si32(this.i18,mstate.esp);
                  si32(this.i23,mstate.esp + 4);
                  si32(this.i22,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaO_chunkid.start();
               }
               break;
            case 5:
               mstate.esp += 12;
               this.i5 = li32(this.i9);
               this.i7 = li8(this.i5 + 50);
               this.i7 += 1;
               si8(this.i7,this.i5 + 50);
               this.i7 = this.i5 + 24;
               this.i8 = this.i5 + 50;
               this.i9 = this.i5;
               while(true)
               {
                  this.i10 = li8(this.i8);
                  this.i10 = this.i6 + this.i10;
                  this.i10 <<= 1;
                  this.i10 += this.i5;
                  this.i10 = li16(this.i10 + 170);
                  this.i11 = li32(this.i9);
                  this.i11 = li32(this.i11 + 24);
                  this.i12 = li32(this.i7);
                  this.i10 *= 12;
                  this.i10 = this.i11 + this.i10;
                  si32(this.i12,this.i10 + 4);
                  this.i10 = this.i6 + 1;
                  if(this.i6 == 0)
                  {
                     break;
                  }
                  this.i6 = this.i10;
               }
               §§goto(addr497);
            case 7:
               mstate.esp += 12;
               this.i21 = li8(this.i9);
               this.i5 += 1;
               if(this.i21 != 0)
               {
                  this.i8 = this.i5;
               }
               else
               {
                  addr891:
                  this.i21 = li32(this.i8);
                  if(this.i21 != 44)
                  {
                     this.i8 = this.i5;
                  }
                  else
                  {
                     this.i21 = li32(this.i17);
                     si32(this.i21,this.i14);
                     this.i21 = li32(this.i13);
                     if(this.i21 == 287)
                     {
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i20,mstate.esp + 4);
                        state = 21;
                        mstate.esp -= 4;
                        FSM_llex.start();
                        return;
                     }
                     this.i22 = 287;
                     si32(this.i21,this.i8);
                     this.f0 = lf64(this.i12);
                     sf64(this.f0,this.i11);
                     si32(this.i22,this.i13);
                     addr772:
                     §§goto(addr773);
                  }
               }
               §§goto(addr555);
            case 16:
               mstate.esp += 8;
               §§goto(addr1724);
            case 19:
               mstate.esp += 8;
               §§goto(addr1724);
            case 20:
               mstate.esp += 8;
               addr1724:
               this.i21 = li8(this.i9);
               if(this.i21 != 0)
               {
                  this.i8 = this.i5;
               }
               else
               {
                  §§goto(addr891);
               }
               §§goto(addr555);
            case 21:
               this.i21 = mstate.eax;
               mstate.esp += 8;
               si32(this.i21,this.i8);
               §§goto(addr772);
            case 12:
               mstate.esp += 12;
               this.i22 = li32(this.i17);
               this.i23 = li32(this.i16);
               mstate.esp -= 20;
               this.i24 = __2E_str15272;
               this.i25 = __2E_str20114;
               this.i26 = mstate.ebp + -80;
               si32(this.i23,mstate.esp);
               si32(this.i24,mstate.esp + 4);
               si32(this.i26,mstate.esp + 8);
               si32(this.i22,mstate.esp + 12);
               si32(this.i25,mstate.esp + 16);
               state = 13;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 3:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               this.i7 = li32(this.i1 + 36);
               this.i7 = li32(this.i7 + 4);
               mstate.esp -= 12;
               si32(this.i6,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaH_setstr.start();
               return;
            case 4:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               this.i7 = li32(this.i6 + 8);
               this.i8 = this.i6 + 8;
               this.i9 = this.i1 + 36;
               if(this.i7 == 0)
               {
                  this.i7 = 1;
                  si32(this.i7,this.i6);
                  si32(this.i7,this.i8);
               }
               this.i6 = 0;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_new_localvar.start();
               return;
            case 6:
               this.i21 = mstate.eax;
               mstate.esp += 4;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i21,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_new_localvar.start();
               return;
            case 8:
               this.i11 = mstate.eax;
               mstate.esp += 8;
               si32(this.i11,this.i8);
               break;
            case 9:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               this.i12 = li32(this.i10);
               this.i12 = li32(this.i12 + 4);
               mstate.esp -= 12;
               si32(this.i11,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaH_setstr.start();
               return;
            case 10:
               this.i11 = mstate.eax;
               mstate.esp += 12;
               this.i12 = li32(this.i11 + 8);
               this.i13 = this.i11 + 8;
               this.i14 = this.i5 + 1;
               if(this.i12 == 0)
               {
                  this.i12 = 1;
                  si32(this.i12,this.i11);
                  si32(this.i12,this.i13);
               }
               this.i11 = 7;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_new_localvar.start();
               return;
            case 11:
               mstate.esp += 12;
               si8(this.i11,this.i9);
               this.i8 = this.i14;
               addr555:
               addr556:
               this.i5 = this.i8;
               this.i8 = li32(this.i10);
               this.i11 = li8(this.i8 + 50);
               this.i11 += this.i5;
               si8(this.i11,this.i8 + 50);
               this.i11 = this.i8 + 50;
               if(this.i5 != 0)
               {
                  this.i12 = 0;
                  this.i13 = 0 - this.i5;
                  this.i14 = this.i8 + 24;
                  this.i15 = this.i8;
                  do
                  {
                     this.i16 = li8(this.i11);
                     this.i17 = this.i13 + this.i12;
                     this.i16 = this.i17 + this.i16;
                     this.i16 <<= 1;
                     this.i16 = this.i8 + this.i16;
                     this.i16 = li16(this.i16 + 172);
                     this.i17 = li32(this.i15);
                     this.i17 = li32(this.i17 + 24);
                     this.i18 = li32(this.i14);
                     this.i16 *= 12;
                     this.i16 = this.i17 + this.i16;
                     si32(this.i18,this.i16 + 4);
                     this.i12 += 1;
                  }
                  while(this.i12 != this.i5);
                  
               }
               this.i5 = 41;
               this.i8 = li8(this.i9);
               this.i9 = li8(this.i6 + 50);
               this.i8 &= 1;
               this.i8 = this.i9 - this.i8;
               si8(this.i8,this.i7 + 73);
               this.i7 = li8(this.i6 + 50);
               mstate.esp -= 8;
               si32(this.i6,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               state = 22;
               mstate.esp -= 4;
               FSM_luaK_checkstack.start();
               return;
            case 13:
               this.i22 = mstate.eax;
               mstate.esp += 20;
               if(this.i21 != 0)
               {
                  if(this.i21 != 284)
                  {
                     if(this.i21 != 286)
                     {
                        this.i23 = __2E_str35292;
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i21,mstate.esp + 4);
                        state = 17;
                        mstate.esp -= 4;
                        FSM_luaX_token2str.start();
                        return;
                     }
                  }
                  this.i21 = 0;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i21,mstate.esp + 4);
                  state = 14;
                  mstate.esp -= 4;
                  FSM_save.start();
                  return;
               }
               this.i21 = 3;
               this.i22 = li32(this.i16);
               mstate.esp -= 8;
               si32(this.i22,mstate.esp);
               si32(this.i21,mstate.esp + 4);
               state = 20;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
               break;
            case 14:
               mstate.esp += 8;
               this.i21 = li32(this.i15);
               this.i21 = li32(this.i21);
               this.i23 = li32(this.i16);
               mstate.esp -= 16;
               this.i24 = __2E_str35292;
               si32(this.i23,mstate.esp);
               si32(this.i24,mstate.esp + 4);
               si32(this.i22,mstate.esp + 8);
               si32(this.i21,mstate.esp + 12);
               state = 15;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 15:
               this.i21 = mstate.eax;
               mstate.esp += 16;
               this.i21 = li32(this.i16);
               mstate.esp -= 8;
               this.i22 = 3;
               si32(this.i21,mstate.esp);
               si32(this.i22,mstate.esp + 4);
               state = 16;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 17:
               this.i21 = mstate.eax;
               mstate.esp += 8;
               this.i24 = li32(this.i16);
               mstate.esp -= 16;
               si32(this.i24,mstate.esp);
               si32(this.i23,mstate.esp + 4);
               si32(this.i22,mstate.esp + 8);
               si32(this.i21,mstate.esp + 12);
               state = 18;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 18:
               this.i21 = mstate.eax;
               mstate.esp += 16;
               this.i21 = li32(this.i16);
               mstate.esp -= 8;
               this.i22 = 3;
               si32(this.i21,mstate.esp);
               si32(this.i22,mstate.esp + 4);
               state = 19;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 22:
               mstate.esp += 8;
               this.i8 = li32(this.i6 + 36);
               this.i7 = this.i8 + this.i7;
               si32(this.i7,this.i6 + 36);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 23;
               mstate.esp -= 4;
               FSM_checknext.start();
               return;
            case 23:
               mstate.esp += 8;
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 24;
               mstate.esp -= 4;
               FSM_chunk.start();
               return;
            case 24:
               mstate.esp += 4;
               this.i5 = li32(this.i0);
               this.i6 = li32(this.i1 + 4);
               si32(this.i6,this.i5 + 64);
               mstate.esp -= 16;
               this.i5 = 265;
               this.i6 = 262;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 25;
               mstate.esp -= 4;
               FSM_check_match.start();
               return;
            case 25:
               mstate.esp += 16;
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 26;
               mstate.esp -= 4;
               FSM_close_func.start();
               return;
            case 26:
               mstate.esp += 4;
               this.i2 = li32(this.i10);
               this.i5 = li32(this.i2);
               this.i6 = li32(this.i2 + 44);
               this.i7 = li32(this.i5 + 52);
               this.i8 = this.i2 + 44;
               this.i9 = this.i5 + 52;
               this.i6 += 1;
               if(this.i6 > this.i7)
               {
                  this.i6 = __2E_str32256;
                  this.i10 = li32(this.i5 + 16);
                  this.i11 = li32(this.i1 + 40);
                  mstate.esp -= 24;
                  this.i12 = 262143;
                  this.i13 = 4;
                  si32(this.i11,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  si32(this.i9,mstate.esp + 8);
                  si32(this.i13,mstate.esp + 12);
                  si32(this.i12,mstate.esp + 16);
                  si32(this.i6,mstate.esp + 20);
                  state = 27;
                  mstate.esp -= 4;
                  FSM_luaM_growaux_.start();
                  return;
               }
               loop2:
               while(true)
               {
                  this.i6 = li32(this.i9);
                  this.i10 = li32(this.i5 + 16);
                  if(this.i6 <= this.i7)
                  {
                     break;
                  }
                  this.i6 = this.i10;
                  addr2274:
                  while(true)
                  {
                     this.i10 = 0;
                     this.i11 = this.i7 << 2;
                     this.i6 += this.i11;
                     si32(this.i10,this.i6);
                     this.i7 += 1;
                     continue loop2;
                  }
               }
               this.i7 = this.i10;
               §§goto(addr2324);
               break;
            case 27:
               this.i6 = mstate.eax;
               mstate.esp += 24;
               si32(this.i6,this.i5 + 16);
               this.i10 = li32(this.i9);
               if(this.i10 <= this.i7)
               {
                  this.i7 = this.i6;
               }
               else
               {
                  §§goto(addr2274);
               }
               addr2324:
               this.i6 = this.i7;
               this.i7 = li32(this.i8);
               this.i9 = li32(this.i0);
               this.i10 = this.i7 << 2;
               this.i6 += this.i10;
               si32(this.i9,this.i6);
               this.i6 = this.i7 + 1;
               si32(this.i6,this.i8);
               this.i6 = li32(this.i0);
               this.i9 = li8(this.i6 + 5);
               this.i9 &= 3;
               if(this.i9 != 0)
               {
                  this.i9 = li8(this.i5 + 5);
                  this.i5 += 5;
                  this.i10 = this.i9 & 4;
                  if(this.i10 != 0)
                  {
                     this.i7 = li32(this.i1 + 40);
                     this.i7 = li32(this.i7 + 16);
                     this.i1 = li8(this.i7 + 21);
                     if(this.i1 == 1)
                     {
                        mstate.esp -= 8;
                        si32(this.i7,mstate.esp);
                        si32(this.i6,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM_reallymarkobject.start();
                        addr2468:
                        mstate.esp += 8;
                     }
                     else
                     {
                        this.i7 = li8(this.i7 + 20);
                        this.i1 = this.i9 & -8;
                        this.i7 &= 3;
                        this.i7 |= this.i1;
                        si8(this.i7,this.i5);
                     }
                     this.i7 = -1;
                     this.i1 = li32(this.i8);
                     this.i5 = li32(this.i2 + 12);
                     this.i5 = li32(this.i5 + 8);
                     this.i1 <<= 14;
                     this.i1 += -16384;
                     mstate.esp -= 12;
                     this.i1 |= 36;
                     si32(this.i2,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i5,mstate.esp + 8);
                     state = 29;
                     mstate.esp -= 4;
                     FSM_luaK_code.start();
                     return;
                  }
               }
               this.i1 = -1;
               this.i5 = li32(this.i2 + 12);
               this.i5 = li32(this.i5 + 8);
               this.i6 = this.i7 << 14;
               mstate.esp -= 12;
               this.i6 |= 36;
               si32(this.i2,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 30;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 28:
               §§goto(addr2468);
            case 29:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i7,this.i3 + 12);
               si32(this.i7,this.i3 + 16);
               this.i7 = 11;
               si32(this.i7,this.i3);
               si32(this.i1,this.i3 + 4);
               addr2730:
               this.i1 = li32(this.i0);
               this.i1 = li8(this.i1 + 72);
               if(this.i1 >= 1)
               {
                  this.i1 = 0;
                  this.i3 = this.i2 + 12;
                  §§goto(addr2758);
               }
               else
               {
                  §§goto(addr2885);
               }
            case 30:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i3 + 12);
               si32(this.i1,this.i3 + 16);
               this.i1 = 11;
               si32(this.i1,this.i3);
               si32(this.i5,this.i3 + 4);
               §§goto(addr2730);
            case 31:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               this.i5 = li32(this.i0);
               this.i5 = li8(this.i5 + 72);
               this.i4 += 2;
               this.i1 += 1;
               if(this.i5 > this.i1)
               {
                  addr2758:
                  this.i5 = li32(this.i3);
                  this.i6 = li8(this.i4 + 51);
                  this.i7 = li8(this.i4 + 52);
                  this.i5 = li32(this.i5 + 8);
                  this.i6 = this.i6 == 6 ? 0 : 4;
                  this.i7 <<= 23;
                  mstate.esp -= 12;
                  this.i6 |= this.i7;
                  si32(this.i2,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  state = 31;
                  mstate.esp -= 4;
                  FSM_luaK_code.start();
                  return;
               }
               addr2885:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
               break;
            default:
               throw "Invalid state in _body";
         }
         this.i8 = __2E_str19113;
         this.i11 = li32(this.i16);
         mstate.esp -= 12;
         this.i12 = 3;
         si32(this.i11,mstate.esp);
         si32(this.i8,mstate.esp + 4);
         si32(this.i12,mstate.esp + 8);
         state = 9;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
