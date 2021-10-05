package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_auxsort extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
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
      
      public function FSM_auxsort()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_auxsort = null;
         _loc1_ = new FSM_auxsort();
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
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               if(this.i1 < this.i2)
               {
                  this.i3 = this.i0 + 8;
                  addr61:
                  this.i4 = 1;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  §§goto(addr477);
               }
            case 1:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i5,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 2:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i6 = li32(this.i3);
               this.f0 = lf64(this.i5);
               sf64(this.f0,this.i6);
               this.i5 = li32(this.i5 + 8);
               si32(this.i5,this.i6 + 8);
               this.i5 = li32(this.i3);
               this.i5 += 12;
               si32(this.i5,this.i3);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 47:
               mstate.esp += 12;
               this.i2 = this.i6 < this.i8 ? int(this.i2) : int(this.i4);
               this.i1 = this.i6 < this.i8 ? int(this.i5) : int(this.i1);
               if(this.i1 < this.i2)
               {
                  §§goto(addr61);
               }
               else
               {
                  §§goto(addr476);
               }
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i4);
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 4:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i3);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i5);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i5 + 8);
               this.i4 = li32(this.i3);
               this.i4 += 12;
               si32(this.i4,this.i3);
               mstate.esp -= 12;
               this.i4 = -2;
               this.i5 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_sort_comp.start();
               return;
            case 5:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               if(this.i4 != 0)
               {
                  this.i4 = 1;
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_lua_rawseti.start();
                  return;
               }
               this.i4 = li32(this.i3);
               this.i4 += -24;
               si32(this.i4,this.i3);
               this.i4 = this.i2 - this.i1;
               if(this.i4 != 1)
               {
                  addr530:
                  this.i4 = 1;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  addr476:
                  §§goto(addr477);
               }
               break;
            case 7:
               mstate.esp += 12;
               this.i4 = this.i2 - this.i1;
               if(this.i4 == 1)
               {
                  addr477:
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  mstate.gworker = caller;
                  return;
               }
               §§goto(addr530);
            case 8:
               this.i5 = mstate.eax;
               this.i6 = this.i1 + this.i2;
               mstate.esp += 8;
               this.i7 = this.i6 >>> 31;
               this.i5 = li32(this.i5);
               this.i6 += this.i7;
               mstate.esp -= 8;
               this.i6 >>= 1;
               si32(this.i5,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 9:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i3);
               this.f0 = lf64(this.i5);
               sf64(this.f0,this.i7);
               this.i5 = li32(this.i5 + 8);
               si32(this.i5,this.i7 + 8);
               this.i5 = li32(this.i3);
               this.i5 += 12;
               si32(this.i5,this.i3);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 10:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i4);
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 11:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i3);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i5);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i5 + 8);
               this.i4 = li32(this.i3);
               this.i4 += 12;
               si32(this.i4,this.i3);
               mstate.esp -= 12;
               this.i4 = -1;
               this.i5 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_sort_comp.start();
               return;
            case 6:
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 12:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               if(this.i4 != 0)
               {
                  this.i4 = 1;
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_lua_rawseti.start();
                  return;
               }
               this.i4 = 1;
               this.i5 = li32(this.i3);
               this.i5 += -12;
               si32(this.i5,this.i3);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 15:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i4);
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 16:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i3);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i5);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i5 + 8);
               this.i4 = li32(this.i3);
               this.i4 += 12;
               si32(this.i4,this.i3);
               mstate.esp -= 12;
               this.i4 = -2;
               this.i5 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 17;
               mstate.esp -= 4;
               FSM_sort_comp.start();
               return;
            case 13:
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 14:
               mstate.esp += 12;
               this.i4 = this.i2 - this.i1;
               if(this.i4 != 2)
               {
                  addr1304:
                  this.i4 = 1;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  §§goto(addr476);
               }
               break;
            case 17:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               if(this.i4 != 0)
               {
                  this.i4 = 1;
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  state = 18;
                  mstate.esp -= 4;
                  FSM_lua_rawseti.start();
                  return;
               }
               this.i4 = li32(this.i3);
               this.i4 += -24;
               si32(this.i4,this.i3);
               this.i4 = this.i2 - this.i1;
               if(this.i4 != 2)
               {
                  §§goto(addr1304);
               }
               else
               {
                  §§goto(addr476);
               }
               break;
            case 19:
               mstate.esp += 12;
               this.i4 = this.i2 - this.i1;
               if(this.i4 != 2)
               {
                  §§goto(addr1304);
               }
               else
               {
                  §§goto(addr476);
               }
            case 20:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i5,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 21:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i3);
               this.f0 = lf64(this.i5);
               sf64(this.f0,this.i7);
               this.i5 = li32(this.i5 + 8);
               si32(this.i5,this.i7 + 8);
               this.i5 = li32(this.i3);
               this.i5 += 12;
               si32(this.i5,this.i3);
               mstate.esp -= 8;
               this.i5 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 22:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i3);
               this.f0 = lf64(this.i7);
               sf64(this.f0,this.i8);
               this.i7 = li32(this.i7 + 8);
               si32(this.i7,this.i8 + 8);
               this.i7 = li32(this.i3);
               this.i7 += 12;
               si32(this.i7,this.i3);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 23:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i7);
               mstate.esp -= 8;
               this.i8 = this.i2 + -1;
               si32(this.i7,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
               break;
            case 24:
               break;
            case 18:
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 25:
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 26;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 26:
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 27:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i4);
               mstate.esp -= 8;
               this.i6 = this.i1 + 1;
               si32(this.i4,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 28:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i3);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i7);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i7 + 8);
               this.i4 = li32(this.i3);
               this.i4 += 12;
               si32(this.i4,this.i3);
               mstate.esp -= 12;
               this.i4 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 29;
               mstate.esp -= 4;
               FSM_sort_comp.start();
               return;
            case 29:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               if(this.i4 != 0)
               {
                  this.i4 = this.i8;
                  addr1927:
                  if(this.i6 > this.i2)
                  {
                     this.i5 = __2E_str13428;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 30;
                     mstate.esp -= 4;
                     FSM_luaL_error.start();
                     return;
                  }
                  addr1974:
                  this.i5 = li32(this.i3);
                  this.i5 += -12;
                  si32(this.i5,this.i3);
                  this.i5 = this.i4;
                  this.i4 = 1;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  this.i4 = this.i1;
                  this.i5 = this.i8;
                  addr2207:
                  this.i7 = 1;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               break;
            case 30:
               mstate.esp += 8;
               §§goto(addr1974);
            case 33:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               if(this.i4 != 0)
               {
                  this.i4 = this.i5;
                  this.i6 = this.i7;
                  §§goto(addr1927);
               }
               else
               {
                  this.i4 = this.i6;
                  this.i6 = this.i7;
                  §§goto(addr2207);
               }
            case 49:
               mstate.esp += 12;
               this.i4 = this.i5;
               §§goto(addr1974);
            case 31:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i4);
               mstate.esp -= 8;
               this.i7 = this.i6 + 1;
               si32(this.i4,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 32:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i3);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i9);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i9 + 8);
               this.i4 = li32(this.i3);
               this.i4 += 12;
               si32(this.i4,this.i3);
               mstate.esp -= 12;
               this.i4 = -2;
               this.i9 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 33;
               mstate.esp -= 4;
               FSM_sort_comp.start();
               return;
            case 34:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i7);
               mstate.esp -= 8;
               this.i9 = this.i5 + -1;
               si32(this.i7,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 35:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i10 = li32(this.i3);
               this.f0 = lf64(this.i7);
               sf64(this.f0,this.i10);
               this.i7 = li32(this.i7 + 8);
               si32(this.i7,this.i10 + 8);
               this.i7 = li32(this.i3);
               this.i7 += 12;
               si32(this.i7,this.i3);
               mstate.esp -= 12;
               this.i7 = -3;
               this.i10 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 36;
               mstate.esp -= 4;
               FSM_sort_comp.start();
               return;
            case 36:
               this.i7 = mstate.eax;
               mstate.esp += 12;
               if(this.i7 != 0)
               {
                  this.i9 = this.i5;
                  addr2406:
                  this.i5 = this.i9 + -1;
                  if(this.i5 < this.i1)
                  {
                     this.i5 = __2E_str13428;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 37;
                     mstate.esp -= 4;
                     FSM_luaL_error.start();
                     return;
                  }
                  addr2459:
                  this.i5 = 1;
                  this.i7 = li32(this.i3);
                  this.i7 += -12;
                  si32(this.i7,this.i3);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  addr2682:
                  this.i5 = this.i9;
                  if(this.i5 >= this.i6)
                  {
                     this.i4 = 1;
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     si32(this.i6,mstate.esp + 8);
                     state = 48;
                     mstate.esp -= 4;
                     FSM_lua_rawseti.start();
                     return;
                  }
                  this.i5 = 1;
                  this.i7 = li32(this.i3);
                  this.i7 += -36;
                  si32(this.i7,this.i3);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               break;
            case 37:
               mstate.esp += 8;
               §§goto(addr2459);
            case 40:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               this.i9 += -1;
               if(this.i5 != 0)
               {
                  §§goto(addr2406);
               }
               else
               {
                  this.i9 += -1;
                  §§goto(addr2682);
               }
            case 38:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i5);
               mstate.esp -= 8;
               this.i7 = this.i9 + -2;
               si32(this.i5,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 39:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i3);
               this.f0 = lf64(this.i5);
               sf64(this.f0,this.i7);
               this.i5 = li32(this.i5 + 8);
               si32(this.i5,this.i7 + 8);
               this.i5 = li32(this.i3);
               this.i5 += 12;
               si32(this.i5,this.i3);
               mstate.esp -= 12;
               this.i5 = -1;
               this.i7 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 40;
               mstate.esp -= 4;
               FSM_sort_comp.start();
               return;
            case 41:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i7);
               mstate.esp -= 8;
               si32(this.i7,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 42:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i3);
               this.f0 = lf64(this.i7);
               sf64(this.f0,this.i9);
               this.i7 = li32(this.i7 + 8);
               si32(this.i7,this.i9 + 8);
               this.i7 = li32(this.i3);
               this.i7 += 12;
               si32(this.i7,this.i3);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 43:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i7);
               mstate.esp -= 8;
               si32(this.i7,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 44:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i9 = li32(this.i3);
               this.f0 = lf64(this.i7);
               sf64(this.f0,this.i9);
               this.i7 = li32(this.i7 + 8);
               si32(this.i7,this.i9 + 8);
               this.i7 = li32(this.i3);
               this.i7 += 12;
               si32(this.i7,this.i3);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 45;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 45:
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 46;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 46:
               mstate.esp += 12;
               this.i5 = this.i4 + 2;
               this.i8 = this.i2 - this.i6;
               this.i6 -= this.i1;
               mstate.esp -= 12;
               this.i7 = this.i6 < this.i8 ? int(this.i4) : int(this.i2);
               this.i9 = this.i6 < this.i8 ? int(this.i1) : int(this.i5);
               si32(this.i0,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 47;
               mstate.esp -= 4;
               FSM_auxsort.start();
               return;
            case 48:
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 49;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            default:
               throw "Invalid state in _auxsort";
         }
         this.i7 = mstate.eax;
         mstate.esp += 8;
         this.i9 = li32(this.i3);
         this.f0 = lf64(this.i7);
         sf64(this.f0,this.i9);
         this.i7 = li32(this.i7 + 8);
         si32(this.i7,this.i9 + 8);
         this.i7 = li32(this.i3);
         this.i7 += 12;
         si32(this.i7,this.i3);
         mstate.esp -= 12;
         si32(this.i0,mstate.esp);
         si32(this.i4,mstate.esp + 4);
         si32(this.i6,mstate.esp + 8);
         state = 25;
         mstate.esp -= 4;
         FSM_lua_rawseti.start();
      }
   }
}
