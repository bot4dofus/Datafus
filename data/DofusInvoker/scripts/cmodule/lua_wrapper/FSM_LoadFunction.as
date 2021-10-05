package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_LoadFunction extends Machine
   {
      
      public static const intRegCount:int = 18;
      
      public static const NumberRegCount:int = 1;
       
      
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
      
      public function FSM_LoadFunction()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_LoadFunction = null;
         _loc1_ = new FSM_LoadFunction();
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
               mstate.esp -= 72;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0);
               this.i2 = li16(this.i1 + 52);
               this.i2 += 1;
               si16(this.i2,this.i1 + 52);
               this.i1 = li32(mstate.ebp + 12);
               this.i3 = this.i0;
               this.i2 &= 65535;
               if(uint(this.i2) >= uint(201))
               {
                  this.i2 = __2E_str156317;
                  this.i4 = li32(this.i0 + 12);
                  this.i5 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i6 = __2E_str3159;
                  si32(this.i5,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i4,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               §§goto(addr204);
               break;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i3);
               mstate.esp -= 8;
               this.i4 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 2:
               mstate.esp += 8;
               addr204:
               this.i2 = 9;
               this.i4 = li32(this.i3);
               mstate.esp -= 4;
               si32(this.i4,mstate.esp);
               state = 3;
               mstate.esp -= 4;
               FSM_luaF_newproto.start();
               return;
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 4;
               this.i5 = li32(this.i3);
               this.i5 = li32(this.i5 + 8);
               si32(this.i4,this.i5);
               si32(this.i2,this.i5 + 8);
               this.i2 = li32(this.i3);
               this.i5 = li32(this.i2 + 28);
               this.i6 = li32(this.i2 + 8);
               this.i5 -= this.i6;
               if(this.i5 <= 12)
               {
                  this.i5 = li32(this.i2 + 44);
                  if(this.i5 >= 1)
                  {
                     mstate.esp -= 8;
                     this.i5 <<= 1;
                     si32(this.i2,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  mstate.esp -= 8;
                  this.i5 += 1;
                  si32(this.i2,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaD_reallocstack.start();
                  return;
               }
               §§goto(addr400);
               break;
            case 4:
               mstate.esp += 8;
               §§goto(addr400);
            case 5:
               mstate.esp += 8;
               addr400:
               this.i2 = 4;
               this.i5 = li32(this.i3);
               this.i6 = li32(this.i5 + 8);
               this.i6 += 12;
               si32(this.i6,this.i5 + 8);
               mstate.esp -= 12;
               this.i5 = mstate.ebp + -28;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 6:
               mstate.esp += 12;
               this.i2 = li32(mstate.ebp + -28);
               if(this.i2 != 0)
               {
                  this.i5 = li32(this.i0 + 8);
                  this.i6 = li32(this.i3);
                  mstate.esp -= 12;
                  si32(this.i6,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaZ_openspace.start();
                  return;
               }
               this.i2 = 0;
               §§goto(addr672);
               break;
            case 7:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i5 = li32(mstate.ebp + -28);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 8:
               mstate.esp += 12;
               this.i5 = li32(mstate.ebp + -28);
               this.i6 = li32(this.i3);
               mstate.esp -= 12;
               this.i5 += -1;
               si32(this.i6,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 9:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               addr672:
               this.i5 = 4;
               this.i1 = this.i2 == 0 ? int(this.i1) : int(this.i2);
               si32(this.i1,this.i4 + 32);
               mstate.esp -= 12;
               this.i1 = mstate.ebp + -16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 10:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -16);
               this.i2 = this.i4 + 32;
               if(this.i1 < 0)
               {
                  this.i1 = __2E_str156317;
                  this.i5 = li32(this.i0 + 12);
                  this.i6 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i7 = __2E_str2158;
                  si32(this.i6,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  si32(this.i7,mstate.esp + 12);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               §§goto(addr891);
               break;
            case 11:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i3);
               mstate.esp -= 8;
               this.i5 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 12;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 12:
               mstate.esp += 8;
               this.i1 = li32(mstate.ebp + -16);
               addr891:
               this.i5 = 4;
               si32(this.i1,this.i4 + 60);
               mstate.esp -= 12;
               this.i1 = mstate.ebp + -4;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 13:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -4);
               if(this.i1 < 0)
               {
                  this.i1 = __2E_str156317;
                  this.i5 = li32(this.i0 + 12);
                  this.i6 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i7 = __2E_str2158;
                  si32(this.i6,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  si32(this.i7,mstate.esp + 12);
                  state = 14;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               §§goto(addr1091);
               break;
            case 14:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i3);
               mstate.esp -= 8;
               this.i5 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 15;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 15:
               mstate.esp += 8;
               this.i1 = li32(mstate.ebp + -4);
               addr1091:
               this.i5 = 1;
               si32(this.i1,this.i4 + 64);
               mstate.esp -= 12;
               this.i1 = mstate.ebp + -5;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 16:
               mstate.esp += 12;
               this.i1 = li8(mstate.ebp + -5);
               si8(this.i1,this.i4 + 72);
               mstate.esp -= 12;
               this.i1 = mstate.ebp + -6;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 17;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 17:
               mstate.esp += 12;
               this.i1 = li8(mstate.ebp + -6);
               si8(this.i1,this.i4 + 73);
               mstate.esp -= 12;
               this.i1 = mstate.ebp + -7;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 18:
               mstate.esp += 12;
               this.i1 = li8(mstate.ebp + -7);
               si8(this.i1,this.i4 + 74);
               mstate.esp -= 12;
               this.i1 = mstate.ebp + -8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 19:
               mstate.esp += 12;
               this.i1 = li8(mstate.ebp + -8);
               si8(this.i1,this.i4 + 75);
               mstate.esp -= 12;
               this.i1 = mstate.ebp + -12;
               this.i5 = 4;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 20:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -12);
               if(this.i1 >= 0)
               {
                  addr1550:
                  this.i5 = this.i1 + 1;
                  if(uint(this.i5) <= uint(1073741823))
                  {
                     this.i5 = 0;
                     this.i6 = li32(this.i3);
                     this.i7 = li32(this.i6 + 16);
                     this.i8 = li32(this.i7 + 12);
                     this.i9 = li32(this.i7 + 16);
                     mstate.esp -= 16;
                     this.i10 = this.i1 << 2;
                     si32(this.i9,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     si32(this.i5,mstate.esp + 8);
                     si32(this.i10,mstate.esp + 12);
                     state = 23;
                     mstate.esp -= 4;
                     mstate.funcs[this.i8]();
                     return;
                  }
                  this.i5 = __2E_str149;
                  this.i6 = li32(this.i3);
                  mstate.esp -= 8;
                  si32(this.i6,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 25;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               this.i1 = __2E_str156317;
               this.i5 = li32(this.i0 + 12);
               this.i6 = li32(this.i3);
               mstate.esp -= 16;
               this.i7 = __2E_str2158;
               si32(this.i6,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 21;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
               break;
            case 21:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i3);
               mstate.esp -= 8;
               this.i5 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 22;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 22:
               mstate.esp += 8;
               this.i1 = li32(mstate.ebp + -12);
               §§goto(addr1550);
            case 23:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               if(this.i5 == 0)
               {
                  if(this.i10 != 0)
                  {
                     this.i8 = 4;
                     mstate.esp -= 8;
                     si32(this.i6,mstate.esp);
                     si32(this.i8,mstate.esp + 4);
                     state = 24;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               §§goto(addr1711);
            case 24:
               mstate.esp += 8;
               §§goto(addr1711);
            case 25:
               mstate.esp += 8;
               this.i5 = 0;
               addr1711:
               this.i6 = li32(this.i7 + 68);
               this.i6 = this.i10 + this.i6;
               si32(this.i6,this.i7 + 68);
               this.i6 = mstate.ebp + -20;
               si32(this.i5,this.i4 + 12);
               si32(this.i1,this.i4 + 44);
               mstate.esp -= 12;
               this.i1 <<= 2;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 26;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 26:
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i1 = 4;
               si32(this.i0,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 27;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 27:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -20);
               this.i5 = this.i4 + 44;
               if(this.i1 >= 0)
               {
                  addr2045:
                  this.i6 = this.i4 + 40;
                  this.i7 = this.i4 + 8;
                  this.i8 = this.i1 + 1;
                  if(uint(this.i8) <= uint(357913941))
                  {
                     this.i8 = 0;
                     this.i9 = li32(this.i3);
                     this.i10 = li32(this.i9 + 16);
                     this.i11 = li32(this.i10 + 12);
                     this.i12 = li32(this.i10 + 16);
                     mstate.esp -= 16;
                     this.i13 = this.i1 * 12;
                     si32(this.i12,mstate.esp);
                     si32(this.i8,mstate.esp + 4);
                     si32(this.i8,mstate.esp + 8);
                     si32(this.i13,mstate.esp + 12);
                     state = 30;
                     mstate.esp -= 4;
                     mstate.funcs[this.i11]();
                     return;
                  }
                  this.i8 = __2E_str149;
                  this.i9 = li32(this.i3);
                  mstate.esp -= 8;
                  si32(this.i9,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  state = 41;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               this.i1 = __2E_str156317;
               this.i6 = li32(this.i0 + 12);
               this.i7 = li32(this.i3);
               mstate.esp -= 16;
               this.i8 = __2E_str2158;
               si32(this.i7,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               state = 28;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
               break;
            case 28:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i3);
               mstate.esp -= 8;
               this.i6 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               state = 29;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 29:
               mstate.esp += 8;
               this.i1 = li32(mstate.ebp + -20);
               §§goto(addr2045);
            case 30:
               this.i8 = mstate.eax;
               mstate.esp += 16;
               if(this.i8 == 0)
               {
                  if(this.i13 != 0)
                  {
                     this.i11 = 4;
                     mstate.esp -= 8;
                     si32(this.i9,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 31;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr2218:
               this.i9 = li32(this.i10 + 68);
               this.i9 = this.i13 + this.i9;
               si32(this.i9,this.i10 + 68);
               si32(this.i8,this.i7);
               si32(this.i1,this.i6);
               if(this.i1 >= 1)
               {
                  addr2256:
                  this.i6 = 0;
                  this.i8 = 8;
                  do
                  {
                     this.i9 = 0;
                     this.i10 = li32(this.i7);
                     this.i10 += this.i8;
                     si32(this.i9,this.i10);
                     this.i8 += 12;
                     this.i6 += 1;
                  }
                  while(this.i6 < this.i1);
                  
               }
               addr3127:
               this.i6 = 0;
               this.i11 = this.i0 + 12;
               this.i8 = this.i0 + 8;
               this.i9 = mstate.ebp + -32;
               this.i10 = mstate.ebp + -72;
               if(this.i6 >= this.i1)
               {
                  break;
               }
               §§goto(addr2304);
               break;
            case 31:
               mstate.esp += 8;
               §§goto(addr2218);
            case 32:
               mstate.esp += 12;
               this.i12 = this.i6 * 12;
               this.i14 = si8(li8(mstate.ebp + -21));
               this.i12 = this.i13 + this.i12;
               if(this.i14 <= 2)
               {
                  if(this.i14 != 0)
                  {
                     if(this.i14 == 1)
                     {
                        this.i14 = 1;
                        mstate.esp -= 12;
                        this.i15 = mstate.ebp + -22;
                        si32(this.i0,mstate.esp);
                        si32(this.i15,mstate.esp + 4);
                        si32(this.i14,mstate.esp + 8);
                        state = 33;
                        mstate.esp -= 4;
                        FSM_LoadBlock.start();
                        return;
                     }
                  }
                  else
                  {
                     this.i12 = 0;
                     this.i14 = this.i6 * 12;
                     this.i13 += this.i14;
                     si32(this.i12,this.i13 + 8);
                     this.i6 += 1;
                     if(this.i6 >= this.i1)
                     {
                        break;
                     }
                     §§goto(addr2304);
                  }
               }
               else
               {
                  if(this.i14 == 3)
                  {
                     this.i12 = 8;
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i10,mstate.esp + 4);
                     si32(this.i12,mstate.esp + 8);
                     state = 35;
                     mstate.esp -= 4;
                     FSM_LoadBlock.start();
                     return;
                  }
                  if(this.i14 == 4)
                  {
                     this.i14 = 4;
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     si32(this.i14,mstate.esp + 8);
                     state = 34;
                     mstate.esp -= 4;
                     FSM_LoadBlock.start();
                     return;
                  }
               }
               this.i12 = __2E_str156317;
               this.i13 = li32(this.i11);
               this.i14 = li32(this.i3);
               mstate.esp -= 16;
               this.i15 = __2E_str4160;
               si32(this.i14,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               si32(this.i15,mstate.esp + 12);
               state = 39;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 33:
               mstate.esp += 12;
               this.i15 = li8(mstate.ebp + -22);
               this.i15 = this.i15 != 0 ? 1 : 0;
               this.i15 &= 1;
               this.i16 = this.i6 * 12;
               si32(this.i15,this.i12);
               this.i12 = this.i13 + this.i16;
               si32(this.i14,this.i12 + 8);
               this.i6 += 1;
               if(this.i6 >= this.i1)
               {
                  break;
               }
               §§goto(addr2304);
               break;
            case 34:
               mstate.esp += 12;
               this.i14 = li32(mstate.ebp + -32);
               if(this.i14 != 0)
               {
                  this.i15 = li32(this.i8);
                  this.i16 = li32(this.i3);
                  mstate.esp -= 12;
                  si32(this.i16,mstate.esp);
                  si32(this.i15,mstate.esp + 4);
                  si32(this.i14,mstate.esp + 8);
                  state = 36;
                  mstate.esp -= 4;
                  FSM_luaZ_openspace.start();
                  return;
               }
               this.i14 = 0;
               addr2896:
               this.i15 = 4;
               this.i16 = this.i6 * 12;
               si32(this.i14,this.i12);
               this.i12 = this.i13 + this.i16;
               si32(this.i15,this.i12 + 8);
               this.i6 += 1;
               if(this.i6 >= this.i1)
               {
                  break;
               }
               §§goto(addr2304);
               break;
            case 35:
               mstate.esp += 12;
               this.i12 = this.i6 * 12;
               this.f0 = lf64(mstate.ebp + -72);
               this.i12 = this.i13 + this.i12;
               sf64(this.f0,this.i12);
               this.i13 = 3;
               si32(this.i13,this.i12 + 8);
               this.i6 += 1;
               if(this.i6 < this.i1)
               {
                  addr2304:
                  this.i12 = 1;
                  this.i13 = li32(this.i7);
                  mstate.esp -= 12;
                  this.i14 = mstate.ebp + -21;
                  si32(this.i0,mstate.esp);
                  si32(this.i14,mstate.esp + 4);
                  si32(this.i12,mstate.esp + 8);
                  state = 32;
                  mstate.esp -= 4;
                  FSM_LoadBlock.start();
                  return;
               }
               break;
            case 36:
               this.i14 = mstate.eax;
               mstate.esp += 12;
               this.i15 = li32(mstate.ebp + -32);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               si32(this.i15,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 37:
               mstate.esp += 12;
               this.i15 = li32(mstate.ebp + -32);
               this.i16 = li32(this.i3);
               mstate.esp -= 12;
               this.i15 += -1;
               si32(this.i16,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               si32(this.i15,mstate.esp + 8);
               state = 38;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 38:
               this.i14 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr2896);
            case 39:
               this.i12 = mstate.eax;
               mstate.esp += 16;
               this.i12 = li32(this.i3);
               mstate.esp -= 8;
               this.i13 = 3;
               si32(this.i12,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               state = 40;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 40:
               mstate.esp += 8;
               this.i6 += 1;
               §§goto(addr2218);
            case 41:
               mstate.esp += 8;
               this.i8 = 0;
               si32(this.i8,this.i7);
               si32(this.i1,this.i6);
               if(this.i1 > 0)
               {
                  §§goto(addr2256);
               }
               §§goto(addr3127);
            case 42:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -36);
               if(this.i1 >= 0)
               {
                  addr3352:
                  this.i6 = this.i4 + 52;
                  this.i7 = this.i4 + 16;
                  this.i9 = this.i1 + 1;
                  if(uint(this.i9) <= uint(1073741823))
                  {
                     this.i9 = 0;
                     this.i10 = li32(this.i3);
                     this.i12 = li32(this.i10 + 16);
                     this.i13 = li32(this.i12 + 12);
                     this.i14 = li32(this.i12 + 16);
                     mstate.esp -= 16;
                     this.i15 = this.i1 << 2;
                     si32(this.i14,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     si32(this.i9,mstate.esp + 8);
                     si32(this.i15,mstate.esp + 12);
                     state = 45;
                     mstate.esp -= 4;
                     mstate.funcs[this.i13]();
                     return;
                  }
                  this.i9 = __2E_str149;
                  this.i10 = li32(this.i3);
                  mstate.esp -= 8;
                  si32(this.i10,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  state = 48;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               this.i1 = __2E_str156317;
               this.i6 = li32(this.i11);
               this.i7 = li32(this.i3);
               mstate.esp -= 16;
               this.i9 = __2E_str2158;
               si32(this.i7,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i9,mstate.esp + 12);
               state = 43;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
               break;
            case 43:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i3);
               mstate.esp -= 8;
               this.i6 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               state = 44;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 44:
               mstate.esp += 8;
               this.i1 = li32(mstate.ebp + -36);
               §§goto(addr3352);
            case 45:
               this.i9 = mstate.eax;
               mstate.esp += 16;
               if(this.i9 == 0)
               {
                  if(this.i15 != 0)
                  {
                     this.i13 = 4;
                     mstate.esp -= 8;
                     si32(this.i10,mstate.esp);
                     si32(this.i13,mstate.esp + 4);
                     state = 46;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr3525:
               this.i10 = li32(this.i12 + 68);
               this.i10 = this.i15 + this.i10;
               si32(this.i10,this.i12 + 68);
               si32(this.i9,this.i7);
               si32(this.i1,this.i6);
               if(this.i1 >= 1)
               {
                  addr3563:
                  this.i6 = 0;
                  this.i9 = this.i6;
                  do
                  {
                     this.i10 = 0;
                     this.i12 = li32(this.i7);
                     this.i12 += this.i9;
                     si32(this.i10,this.i12);
                     this.i9 += 4;
                     this.i6 += 1;
                  }
                  while(this.i6 < this.i1);
                  
               }
               if(this.i1 >= 1)
               {
                  this.i6 = 0;
                  this.i9 = this.i6;
                  §§goto(addr3612);
               }
               else
               {
                  §§goto(addr3773);
               }
            case 46:
               mstate.esp += 8;
               §§goto(addr3525);
            case 47:
               this.i12 = mstate.eax;
               mstate.esp += 8;
               this.i10 += this.i9;
               si32(this.i12,this.i10);
               this.i9 += 4;
               this.i6 += 1;
               if(this.i6 != this.i1)
               {
                  addr3612:
                  this.i10 = li32(this.i7);
                  this.i12 = li32(this.i2);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i12,mstate.esp + 4);
                  state = 47;
                  mstate.esp -= 4;
                  FSM_LoadFunction.start();
                  return;
               }
               addr3773:
               this.i1 = 4;
               mstate.esp -= 12;
               this.i2 = mstate.ebp + -40;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 49;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
               break;
            case 48:
               mstate.esp += 8;
               this.i9 = 0;
               si32(this.i9,this.i7);
               si32(this.i1,this.i6);
               if(this.i1 > 0)
               {
                  §§goto(addr3563);
               }
               §§goto(addr3525);
            case 49:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -40);
               if(this.i1 >= 0)
               {
                  addr3964:
                  this.i2 = this.i1 + 1;
                  if(uint(this.i2) <= uint(1073741823))
                  {
                     this.i2 = 0;
                     this.i6 = li32(this.i3);
                     this.i7 = li32(this.i6 + 16);
                     this.i9 = li32(this.i7 + 12);
                     this.i10 = li32(this.i7 + 16);
                     mstate.esp -= 16;
                     this.i12 = this.i1 << 2;
                     si32(this.i10,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i2,mstate.esp + 8);
                     si32(this.i12,mstate.esp + 12);
                     state = 52;
                     mstate.esp -= 4;
                     mstate.funcs[this.i9]();
                     return;
                  }
                  this.i2 = __2E_str149;
                  this.i6 = li32(this.i3);
                  mstate.esp -= 8;
                  si32(this.i6,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 54;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               this.i1 = __2E_str156317;
               this.i2 = li32(this.i11);
               this.i6 = li32(this.i3);
               mstate.esp -= 16;
               this.i7 = __2E_str2158;
               si32(this.i6,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 50;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
               break;
            case 50:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i3);
               mstate.esp -= 8;
               this.i2 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 51;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 51:
               mstate.esp += 8;
               this.i1 = li32(mstate.ebp + -40);
               §§goto(addr3964);
            case 52:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               if(this.i2 == 0)
               {
                  if(this.i12 != 0)
                  {
                     this.i9 = 4;
                     mstate.esp -= 8;
                     si32(this.i6,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     state = 53;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               §§goto(addr4125);
            case 53:
               mstate.esp += 8;
               §§goto(addr4125);
            case 54:
               mstate.esp += 8;
               this.i2 = 0;
               addr4125:
               this.i6 = li32(this.i7 + 68);
               this.i6 = this.i12 + this.i6;
               si32(this.i6,this.i7 + 68);
               this.i6 = mstate.ebp + -44;
               si32(this.i2,this.i4 + 20);
               si32(this.i1,this.i4 + 48);
               mstate.esp -= 12;
               this.i1 <<= 2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 55;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 55:
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i1 = 4;
               si32(this.i0,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 56;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 56:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -44);
               if(this.i1 >= 0)
               {
                  addr4451:
                  this.i2 = this.i4 + 56;
                  this.i6 = this.i4 + 24;
                  this.i7 = this.i1 + 1;
                  if(uint(this.i7) <= uint(357913941))
                  {
                     this.i7 = 0;
                     this.i9 = li32(this.i3);
                     this.i10 = li32(this.i9 + 16);
                     this.i12 = li32(this.i10 + 12);
                     this.i13 = li32(this.i10 + 16);
                     mstate.esp -= 16;
                     this.i14 = this.i1 * 12;
                     si32(this.i13,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     si32(this.i7,mstate.esp + 8);
                     si32(this.i14,mstate.esp + 12);
                     state = 59;
                     mstate.esp -= 4;
                     mstate.funcs[this.i12]();
                     return;
                  }
                  this.i7 = __2E_str149;
                  this.i9 = li32(this.i3);
                  mstate.esp -= 8;
                  si32(this.i9,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  state = 71;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               this.i1 = __2E_str156317;
               this.i2 = li32(this.i11);
               this.i6 = li32(this.i3);
               mstate.esp -= 16;
               this.i7 = __2E_str2158;
               si32(this.i6,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 57;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
               break;
            case 57:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i3);
               mstate.esp -= 8;
               this.i2 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 58;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 58:
               mstate.esp += 8;
               this.i1 = li32(mstate.ebp + -44);
               §§goto(addr4451);
            case 59:
               this.i7 = mstate.eax;
               mstate.esp += 16;
               if(this.i7 == 0)
               {
                  if(this.i14 != 0)
                  {
                     this.i12 = 4;
                     mstate.esp -= 8;
                     si32(this.i9,mstate.esp);
                     si32(this.i12,mstate.esp + 4);
                     state = 60;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr4624:
               this.i9 = li32(this.i10 + 68);
               this.i9 = this.i14 + this.i9;
               si32(this.i9,this.i10 + 68);
               si32(this.i7,this.i6);
               si32(this.i1,this.i2);
               if(this.i1 >= 1)
               {
                  addr4662:
                  this.i2 = 0;
                  this.i7 = this.i2;
                  do
                  {
                     this.i9 = 0;
                     this.i10 = li32(this.i6);
                     this.i10 += this.i7;
                     si32(this.i9,this.i10);
                     this.i7 += 12;
                     this.i2 += 1;
                  }
                  while(this.i2 < this.i1);
                  
               }
               if(this.i1 >= 1)
               {
                  this.i9 = 0;
                  this.i10 = mstate.ebp + -56;
                  this.i2 = mstate.ebp + -52;
                  this.i7 = mstate.ebp + -48;
                  this.i12 = this.i9;
                  §§goto(addr4711);
               }
               else
               {
                  §§goto(addr5491);
               }
            case 60:
               mstate.esp += 8;
               §§goto(addr4624);
            case 61:
               mstate.esp += 12;
               this.i13 = li32(mstate.ebp + -48);
               if(this.i13 != 0)
               {
                  this.i15 = li32(this.i8);
                  this.i16 = li32(this.i3);
                  mstate.esp -= 12;
                  si32(this.i16,mstate.esp);
                  si32(this.i15,mstate.esp + 4);
                  si32(this.i13,mstate.esp + 8);
                  state = 62;
                  mstate.esp -= 4;
                  FSM_luaZ_openspace.start();
                  return;
               }
               this.i13 = 0;
               §§goto(addr4956);
               break;
            case 62:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               this.i15 = li32(mstate.ebp + -48);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i15,mstate.esp + 8);
               state = 63;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 63:
               mstate.esp += 12;
               this.i15 = li32(mstate.ebp + -48);
               this.i16 = li32(this.i3);
               mstate.esp -= 12;
               this.i15 += -1;
               si32(this.i16,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i15,mstate.esp + 8);
               state = 64;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 64:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               addr4956:
               this.i15 = 4;
               this.i14 += this.i12;
               si32(this.i13,this.i14);
               this.i13 = li32(this.i6);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i15,mstate.esp + 8);
               state = 65;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 65:
               mstate.esp += 12;
               this.i14 = li32(mstate.ebp + -52);
               if(this.i14 < 0)
               {
                  this.i14 = __2E_str156317;
                  this.i15 = li32(this.i11);
                  this.i16 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i17 = __2E_str2158;
                  si32(this.i16,mstate.esp);
                  si32(this.i14,mstate.esp + 4);
                  si32(this.i15,mstate.esp + 8);
                  si32(this.i17,mstate.esp + 12);
                  state = 66;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               §§goto(addr5158);
               break;
            case 66:
               this.i14 = mstate.eax;
               mstate.esp += 16;
               this.i14 = li32(this.i3);
               mstate.esp -= 8;
               this.i15 = 3;
               si32(this.i14,mstate.esp);
               si32(this.i15,mstate.esp + 4);
               state = 67;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 67:
               mstate.esp += 8;
               this.i14 = li32(mstate.ebp + -52);
               addr5158:
               this.i15 = 4;
               this.i13 += this.i12;
               si32(this.i14,this.i13 + 4);
               this.i13 = li32(this.i6);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i15,mstate.esp + 8);
               state = 68;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 68:
               mstate.esp += 12;
               this.i14 = li32(mstate.ebp + -56);
               if(this.i14 >= 0)
               {
                  addr5362:
                  this.i13 += this.i12;
                  si32(this.i14,this.i13 + 8);
                  this.i12 += 12;
                  this.i9 += 1;
                  if(this.i9 != this.i1)
                  {
                     addr4711:
                     this.i13 = 4;
                     this.i14 = li32(this.i6);
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     si32(this.i13,mstate.esp + 8);
                     state = 61;
                     mstate.esp -= 4;
                     FSM_LoadBlock.start();
                     return;
                  }
                  addr5491:
                  this.i1 = 4;
                  mstate.esp -= 12;
                  this.i2 = mstate.ebp + -60;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  state = 72;
                  mstate.esp -= 4;
                  FSM_LoadBlock.start();
                  return;
               }
               this.i14 = __2E_str156317;
               this.i15 = li32(this.i11);
               this.i16 = li32(this.i3);
               mstate.esp -= 16;
               this.i17 = __2E_str2158;
               si32(this.i16,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               si32(this.i15,mstate.esp + 8);
               si32(this.i17,mstate.esp + 12);
               state = 69;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
               break;
            case 69:
               this.i14 = mstate.eax;
               mstate.esp += 16;
               this.i14 = li32(this.i3);
               mstate.esp -= 8;
               this.i15 = 3;
               si32(this.i14,mstate.esp);
               si32(this.i15,mstate.esp + 4);
               state = 70;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 70:
               mstate.esp += 8;
               this.i14 = li32(mstate.ebp + -56);
               §§goto(addr5362);
            case 71:
               mstate.esp += 8;
               this.i7 = 0;
               si32(this.i7,this.i6);
               si32(this.i1,this.i2);
               if(this.i1 > 0)
               {
                  §§goto(addr4662);
               }
               §§goto(addr4624);
            case 72:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -60);
               if(this.i1 >= 0)
               {
                  addr5682:
                  this.i2 = this.i4 + 36;
                  this.i6 = this.i4 + 28;
                  this.i7 = this.i1 + 1;
                  if(uint(this.i7) <= uint(1073741823))
                  {
                     this.i7 = 0;
                     this.i9 = li32(this.i3);
                     this.i10 = li32(this.i9 + 16);
                     this.i12 = li32(this.i10 + 12);
                     this.i13 = li32(this.i10 + 16);
                     mstate.esp -= 16;
                     this.i14 = this.i1 << 2;
                     si32(this.i13,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     si32(this.i7,mstate.esp + 8);
                     si32(this.i14,mstate.esp + 12);
                     state = 75;
                     mstate.esp -= 4;
                     mstate.funcs[this.i12]();
                     return;
                  }
                  this.i7 = __2E_str149;
                  this.i9 = li32(this.i3);
                  mstate.esp -= 8;
                  si32(this.i9,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  state = 81;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               this.i1 = __2E_str156317;
               this.i2 = li32(this.i11);
               this.i6 = li32(this.i3);
               mstate.esp -= 16;
               this.i7 = __2E_str2158;
               si32(this.i6,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 73;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
               break;
            case 73:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i3);
               mstate.esp -= 8;
               this.i2 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 74;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 74:
               mstate.esp += 8;
               this.i1 = li32(mstate.ebp + -60);
               §§goto(addr5682);
            case 75:
               this.i7 = mstate.eax;
               mstate.esp += 16;
               if(this.i7 == 0)
               {
                  if(this.i14 != 0)
                  {
                     this.i12 = 4;
                     mstate.esp -= 8;
                     si32(this.i9,mstate.esp);
                     si32(this.i12,mstate.esp + 4);
                     state = 76;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr5855:
               this.i9 = li32(this.i10 + 68);
               this.i9 = this.i14 + this.i9;
               si32(this.i9,this.i10 + 68);
               si32(this.i7,this.i6);
               si32(this.i1,this.i2);
               if(this.i1 >= 1)
               {
                  addr5893:
                  this.i2 = 0;
                  this.i7 = this.i2;
                  do
                  {
                     this.i9 = 0;
                     this.i10 = li32(this.i6);
                     this.i10 += this.i7;
                     si32(this.i9,this.i10);
                     this.i7 += 4;
                     this.i2 += 1;
                  }
                  while(this.i2 < this.i1);
                  
               }
               if(this.i1 >= 1)
               {
                  this.i7 = 0;
                  this.i9 = mstate.ebp + -64;
                  this.i2 = this.i7;
                  §§goto(addr5942);
               }
               else
               {
                  addr6302:
                  this.i0 = 255;
                  this.i1 = li32(this.i5);
                  mstate.esp -= 12;
                  si32(this.i4,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_symbexec.start();
               }
               break;
            case 76:
               mstate.esp += 8;
               §§goto(addr5855);
            case 77:
               mstate.esp += 12;
               this.i10 = li32(mstate.ebp + -64);
               if(this.i10 != 0)
               {
                  this.i13 = li32(this.i8);
                  this.i14 = li32(this.i3);
                  mstate.esp -= 12;
                  si32(this.i14,mstate.esp);
                  si32(this.i13,mstate.esp + 4);
                  si32(this.i10,mstate.esp + 8);
                  state = 78;
                  mstate.esp -= 4;
                  FSM_luaZ_openspace.start();
                  return;
               }
               this.i10 = 0;
               addr6187:
               this.i12 += this.i2;
               si32(this.i10,this.i12);
               this.i2 += 4;
               this.i7 += 1;
               if(this.i7 != this.i1)
               {
                  addr5942:
                  this.i10 = 4;
                  this.i12 = li32(this.i6);
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i10,mstate.esp + 8);
                  state = 77;
                  mstate.esp -= 4;
                  FSM_LoadBlock.start();
                  return;
               }
               §§goto(addr6302);
               break;
            case 80:
               this.i10 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr6187);
            case 81:
               mstate.esp += 8;
               this.i7 = 0;
               si32(this.i7,this.i6);
               si32(this.i1,this.i2);
               if(this.i1 > 0)
               {
                  §§goto(addr5893);
               }
               §§goto(addr5855);
            case 82:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 == 0)
               {
                  this.i0 = __2E_str156317;
                  this.i1 = li32(this.i11);
                  this.i2 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i5 = __2E_str5161;
                  si32(this.i2,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i5,mstate.esp + 12);
                  state = 83;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               §§goto(addr6478);
               break;
            case 78:
               this.i10 = mstate.eax;
               mstate.esp += 12;
               this.i13 = li32(mstate.ebp + -64);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 79;
               mstate.esp -= 4;
               FSM_LoadBlock.start();
               return;
            case 79:
               mstate.esp += 12;
               this.i13 = li32(mstate.ebp + -64);
               this.i14 = li32(this.i3);
               mstate.esp -= 12;
               this.i13 += -1;
               si32(this.i14,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 80;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 83:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               mstate.esp -= 8;
               this.i1 = 3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 84;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 84:
               mstate.esp += 8;
               addr6478:
               this.i0 = li32(this.i3);
               this.i1 = li32(this.i0 + 8);
               this.i1 += -12;
               si32(this.i1,this.i0 + 8);
               this.i0 = li32(this.i3);
               this.i1 = li16(this.i0 + 52);
               this.i1 += -1;
               si16(this.i1,this.i0 + 52);
               mstate.eax = this.i4;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _LoadFunction";
         }
         this.i1 = 4;
         mstate.esp -= 12;
         this.i6 = mstate.ebp + -36;
         si32(this.i0,mstate.esp);
         si32(this.i6,mstate.esp + 4);
         si32(this.i1,mstate.esp + 8);
         state = 42;
         mstate.esp -= 4;
         FSM_LoadBlock.start();
      }
   }
}
