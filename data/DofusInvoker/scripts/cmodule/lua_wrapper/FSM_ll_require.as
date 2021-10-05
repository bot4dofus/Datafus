package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_ll_require extends Machine
   {
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 1;
       
      
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
      
      public var i9:int;
      
      public function FSM_ll_require()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_ll_require = null;
         _loc1_ = new FSM_ll_require();
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
               mstate.esp -= 112;
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + 8);
               mstate.esp -= 12;
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
               this.i2 = li32(this.i1 + 12);
               this.i3 = li32(this.i1 + 8);
               this.i4 = this.i1 + 12;
               this.i5 = this.i1 + 8;
               this.i6 = this.i0;
               this.i7 = this.i2 + 12;
               if(uint(this.i3) >= uint(this.i7))
               {
                  this.i3 = this.i2;
               }
               else
               {
                  while(true)
                  {
                     this.i2 = 0;
                     si32(this.i2,this.i3 + 8);
                     this.i2 = this.i3 + 12;
                     si32(this.i2,this.i5);
                     this.i7 = li32(this.i4);
                     if(this.i3 >= this.i7)
                     {
                        break;
                     }
                     this.i3 = this.i2;
                  }
                  this.i3 = this.i7;
               }
               this.i2 = this.i3;
               this.i3 = -10000;
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = __2E_str13188331;
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
               this.i7 = __2E_str13188331;
               mstate.esp -= 12;
               this.i3 -= this.i7;
               si32(this.i1,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -64);
               this.i3 = 4;
               si32(this.i3,mstate.ebp + -56);
               this.i3 = li32(this.i5);
               mstate.esp -= 16;
               this.i7 = mstate.ebp + -64;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 4:
               mstate.esp += 16;
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li8(this.i0);
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
                  this.i3 = this.i0;
               }
               this.i7 = 4;
               mstate.esp -= 12;
               this.i3 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               mstate.esp += 12;
               §§goto(addr3895);
            case 38:
               mstate.esp += 16;
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 39:
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
                        §§goto(addr588);
                     }
                  }
                  this.i4 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  addr3076:
                  this.i4 = mstate.eax;
                  mstate.esp += 8;
                  this.i5 = li32(this.i4 + 8);
                  if(this.i5 != 2)
                  {
                     if(this.i5 != 7)
                     {
                        this.i4 = 0;
                     }
                     else
                     {
                        this.i4 = li32(this.i4);
                        this.i4 += 20;
                     }
                  }
                  else
                  {
                     this.i4 = li32(this.i4);
                  }
                  this.i5 = _sentinel_;
                  if(this.i4 == this.i5)
                  {
                     this.i4 = __2E_str29498;
                     mstate.esp -= 12;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_luaL_error.start();
                     return;
                  }
                  §§goto(addr3895);
               }
               addr588:
               this.i2 = -10001;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr619);
            case 40:
               §§goto(addr3076);
            case 7:
               addr619:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = __2E_str30499;
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
               this.i7 = __2E_str30499;
               mstate.esp -= 12;
               this.i3 -= this.i7;
               si32(this.i1,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 8:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -16);
               this.i3 = 4;
               si32(this.i3,mstate.ebp + -8);
               this.i3 = li32(this.i5);
               mstate.esp -= 16;
               this.i7 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 9;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 9:
               mstate.esp += 16;
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 10:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 == 5)
                  {
                     addr919:
                     this.i2 = li32(this.i1 + 16);
                     this.i3 = li32(this.i2 + 68);
                     this.i2 = li32(this.i2 + 64);
                     this.i7 = this.i1 + 16;
                     if(uint(this.i3) >= uint(this.i2))
                     {
                        mstate.esp -= 4;
                        si32(this.i1,mstate.esp);
                        state = 12;
                        mstate.esp -= 4;
                        FSM_luaC_step.start();
                        return;
                     }
                     §§goto(addr986);
                  }
               }
               this.i2 = __2E_str31500;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 11;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
            case 11:
               mstate.esp += 8;
               §§goto(addr919);
            case 12:
               mstate.esp += 4;
               addr986:
               this.i2 = __2E_str45;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 13:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i3);
               this.i2 = 4;
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 14:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i2);
               mstate.esp -= 8;
               this.i3 = 1;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 15:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i5);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i3);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 16:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 == 0)
                  {
                     this.i2 = 1;
                     §§goto(addr1282);
                  }
               }
               this.i2 = 1;
               addr1391:
               this.i2 += 1;
               break;
            case 17:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 16;
               this.i8 = __2E_str32501;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 18;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
            case 18:
               mstate.esp += 16;
               §§goto(addr1391);
            case 19:
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 += -24;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
            case 20:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 21:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = _luaO_nilobject_;
               if(this.i3 != this.i8)
               {
                  this.i3 = li32(this.i3 + 8);
                  if(this.i3 == 6)
                  {
                     this.i2 = _sentinel_;
                     this.i3 = li32(this.i5);
                     si32(this.i2,this.i3);
                     this.i2 = 2;
                     si32(this.i2,this.i3 + 8);
                     this.i3 = li32(this.i5);
                     this.i3 += 12;
                     si32(this.i3,this.i5);
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr2279);
                  }
               }
               this.i3 = -1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 22:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = _luaO_nilobject_;
               if(this.i3 == this.i8)
               {
                  this.i3 = 0;
               }
               else
               {
                  this.i3 = li32(this.i3 + 8);
                  this.i3 += -3;
                  this.i3 = uint(this.i3) < uint(2) ? 1 : 0;
               }
               this.i3 ^= 1;
               this.i3 &= 1;
               if(this.i3 == 0)
               {
                  this.i3 = li32(this.i7);
                  this.i8 = li32(this.i3 + 68);
                  this.i3 = li32(this.i3 + 64);
                  if(uint(this.i8) >= uint(this.i3))
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 23;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  §§goto(addr1714);
               }
               else
               {
                  this.i3 = -2;
                  this.i8 = li32(this.i5);
                  this.i8 += -12;
                  si32(this.i8,this.i5);
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
            case 28:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i3);
               mstate.esp -= 8;
               si32(this.i3,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 29:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i8);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i8 + 8);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               mstate.esp -= 8;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 30:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = _luaO_nilobject_;
               if(this.i3 != this.i8)
               {
                  this.i3 = li32(this.i3 + 8);
                  if(this.i3 == 0)
                  {
                     addr1282:
                     this.i3 = 0;
                     mstate.esp -= 12;
                     this.i8 = -2;
                     si32(this.i1,mstate.esp);
                     si32(this.i8,mstate.esp + 4);
                     si32(this.i3,mstate.esp + 8);
                     state = 17;
                     mstate.esp -= 4;
                     FSM_lua_tolstring.start();
                     return;
                     addr1998:
                  }
               }
               addr2205:
               this.i2 += 1;
               break;
            case 23:
               mstate.esp += 4;
               addr1714:
               this.i3 = 2;
               this.i8 = li32(this.i5);
               this.i9 = li32(this.i4);
               this.i8 -= this.i9;
               this.i8 /= 12;
               mstate.esp -= 12;
               this.i8 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 24;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 24:
               mstate.esp += 12;
               this.i3 = li32(this.i5);
               this.i3 += -12;
               si32(this.i3,this.i5);
               mstate.esp -= 8;
               this.i3 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 25:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i3);
               mstate.esp -= 8;
               si32(this.i3,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 26:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i5);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i8);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i8 + 8);
               this.i3 = li32(this.i5);
               this.i3 += 12;
               si32(this.i3,this.i5);
               mstate.esp -= 8;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 27:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i8 = _luaO_nilobject_;
               if(this.i3 != this.i8)
               {
                  this.i3 = li32(this.i3 + 8);
                  if(this.i3 == 0)
                  {
                     §§goto(addr1998);
                  }
               }
               §§goto(addr2205);
            case 31:
               addr2279:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li8(this.i0);
               if(this.i3 != 0)
               {
                  this.i3 = this.i6;
                  while(true)
                  {
                     this.i4 = li8(this.i3 + 1);
                     this.i3 += 1;
                     this.i7 = this.i3;
                     if(this.i4 == 0)
                     {
                        break;
                     }
                     this.i3 = this.i7;
                  }
               }
               else
               {
                  this.i3 = this.i0;
               }
               this.i4 = 4;
               mstate.esp -= 12;
               this.i3 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 41;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 32:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -80);
               si32(this.i4,mstate.ebp + -72);
               this.i3 = li32(this.i5);
               mstate.esp -= 16;
               this.i3 += -12;
               this.i4 = mstate.ebp + -80;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 33;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 33:
               mstate.esp += 16;
               this.i2 = li32(this.i5);
               this.i2 += -12;
               si32(this.i2,this.i5);
               addr2499:
               this.i2 = 2;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 44:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i2 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 45:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 == 0)
                  {
                     §§goto(addr2499);
                  }
               }
               this.i2 = 2;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 46:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li8(this.i0);
               if(this.i3 != 0)
               {
                  this.i3 = this.i6;
                  while(true)
                  {
                     this.i4 = li8(this.i3 + 1);
                     this.i3 += 1;
                     this.i7 = this.i3;
                     if(this.i4 == 0)
                     {
                        break;
                     }
                     this.i3 = this.i7;
                  }
               }
               else
               {
                  this.i3 = this.i0;
               }
               this.i4 = 4;
               mstate.esp -= 12;
               this.i3 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 32;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 34:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li8(this.i0);
               if(this.i3 != 0)
               {
                  this.i3 = this.i6;
                  while(true)
                  {
                     this.i4 = li8(this.i3 + 1);
                     this.i3 += 1;
                     this.i7 = this.i3;
                     if(this.i4 == 0)
                     {
                        break;
                     }
                     this.i3 = this.i7;
                  }
               }
               else
               {
                  this.i3 = this.i0;
               }
               this.i4 = 4;
               mstate.esp -= 12;
               this.i3 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 47;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 48:
               mstate.esp += 16;
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 49:
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
               this.i3 = _sentinel_;
               if(this.i2 == this.i3)
               {
                  this.i2 = 1;
                  this.i3 = li32(this.i5);
                  si32(this.i2,this.i3);
                  si32(this.i2,this.i3 + 8);
                  this.i2 = li32(this.i5);
                  this.i2 += 12;
                  si32(this.i2,this.i5);
                  mstate.esp -= 8;
                  this.i2 = -1;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  §§goto(addr3895);
               }
            case 35:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i5);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i3);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i5);
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               this.i2 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 36:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li8(this.i0);
               if(this.i3 != 0)
               {
                  this.i3 = this.i6;
                  while(true)
                  {
                     this.i4 = li8(this.i3 + 1);
                     this.i3 += 1;
                     this.i7 = this.i3;
                     if(this.i4 == 0)
                     {
                        break;
                     }
                     this.i3 = this.i7;
                  }
               }
               else
               {
                  this.i3 = this.i0;
               }
               this.i4 = 4;
               mstate.esp -= 12;
               this.i3 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 50;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 37:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -32);
               si32(this.i7,mstate.ebp + -24);
               this.i3 = li32(this.i5);
               mstate.esp -= 16;
               this.i7 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 38;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 41:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -48);
               si32(this.i4,mstate.ebp + -40);
               this.i3 = li32(this.i5);
               mstate.esp -= 16;
               this.i3 += -12;
               this.i4 = mstate.ebp + -48;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 42;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 42:
               mstate.esp += 16;
               this.i2 = li32(this.i5);
               this.i2 += -12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 43;
               mstate.esp -= 4;
               FSM_lua_pushstring.start();
               return;
            case 43:
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 1;
               this.i2 += -24;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 44;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
            case 47:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -96);
               si32(this.i4,mstate.ebp + -88);
               this.i3 = li32(this.i5);
               mstate.esp -= 16;
               this.i4 = mstate.ebp + -96;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 48;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 50:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,mstate.ebp + -112);
               si32(this.i4,mstate.ebp + -104);
               this.i0 = li32(this.i5);
               mstate.esp -= 16;
               this.i0 += -12;
               this.i3 = mstate.ebp + -112;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 51;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 51:
               mstate.esp += 16;
               this.i0 = li32(this.i5);
               this.i0 += -12;
               si32(this.i0,this.i5);
               addr3895:
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _ll_require";
         }
         this.i3 = 1;
         mstate.esp -= 8;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         state = 19;
         mstate.esp -= 4;
         FSM_lua_pushstring.start();
      }
   }
}
