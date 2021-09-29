package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_ll_module extends Machine
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
      
      public function FSM_ll_module()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_ll_module = null;
         _loc1_ = new FSM_ll_module();
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
               mstate.esp -= 224;
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
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               mstate.esp -= 8;
               this.i4 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               this.i2 -= this.i3;
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i3 = mstate.eax;
               this.i4 = this.i2 / 12;
               mstate.esp += 8;
               this.i5 = __2E_str13188331;
               this.i6 = this.i4 + 1;
               this.i7 = this.i1 + 8;
               this.i8 = this.i0;
               while(true)
               {
                  this.i9 = li8(this.i5 + 1);
                  this.i5 += 1;
                  this.i10 = this.i5;
                  if(this.i9 == 0)
                  {
                     break;
                  }
                  this.i5 = this.i10;
               }
               this.i9 = __2E_str13188331;
               mstate.esp -= 12;
               this.i5 -= this.i9;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 3:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -112);
               this.i5 = 4;
               si32(this.i5,mstate.ebp + -104);
               this.i5 = li32(this.i7);
               mstate.esp -= 16;
               this.i9 = mstate.ebp + -112;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 4:
               mstate.esp += 16;
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li8(this.i0);
               if(this.i5 != 0)
               {
                  this.i5 = this.i8;
                  while(true)
                  {
                     this.i9 = li8(this.i5 + 1);
                     this.i5 += 1;
                     this.i10 = this.i5;
                     if(this.i9 == 0)
                     {
                        break;
                     }
                     this.i5 = this.i10;
                  }
               }
               else
               {
                  this.i5 = this.i0;
               }
               this.i9 = 4;
               mstate.esp -= 12;
               this.i5 -= this.i8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 36;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 39:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               if(this.i3 != 0)
               {
                  this.i2 = __2E_str14189332;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 40;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               this.i3 = -1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i7);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i5);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i5 + 8);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 7:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li8(this.i0);
               if(this.i5 != 0)
               {
                  this.i5 = this.i8;
                  while(true)
                  {
                     this.i6 = li8(this.i5 + 1);
                     this.i5 += 1;
                     this.i9 = this.i5;
                     if(this.i6 == 0)
                     {
                        break;
                     }
                     this.i5 = this.i9;
                  }
               }
               else
               {
                  this.i5 = this.i0;
               }
               this.i6 = 4;
               mstate.esp -= 12;
               this.i5 -= this.i8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 41;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 8:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -16);
               this.i5 = 4;
               si32(this.i5,mstate.ebp + -8);
               this.i5 = li32(this.i7);
               mstate.esp -= 16;
               this.i6 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 9;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 9:
               mstate.esp += 16;
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 10:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = _luaO_nilobject_;
               if(this.i3 != this.i5)
               {
                  this.i5 = li32(this.i7);
                  this.i3 = li32(this.i3 + 8);
                  this.i5 += -12;
                  si32(this.i5,this.i7);
                  if(this.i3 == 0)
                  {
                     this.i3 = -1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr869);
                  }
               }
               else
               {
                  this.i0 = li32(this.i7);
                  this.i0 += -12;
                  si32(this.i0,this.i7);
               }
               addr1914:
               this.i0 = -1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 11:
               addr869:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i7);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i5);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i5 + 8);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               this.i3 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr954);
            case 12:
               addr954:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = __2E_str35504;
               while(true)
               {
                  this.i6 = li8(this.i5 + 1);
                  this.i5 += 1;
                  this.i9 = this.i5;
                  if(this.i6 == 0)
                  {
                     break;
                  }
                  this.i5 = this.i9;
               }
               this.i6 = __2E_str35504;
               mstate.esp -= 12;
               this.i5 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 13:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -32);
               this.i5 = 4;
               si32(this.i5,mstate.ebp + -24);
               this.i5 = li32(this.i7);
               mstate.esp -= 16;
               this.i5 += -12;
               this.i6 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 14;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 14:
               mstate.esp += 16;
               this.i3 = li32(this.i7);
               this.i3 += -12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 15;
               mstate.esp -= 4;
               FSM_lua_pushstring.start();
               return;
            case 15:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i3 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 16:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = __2E_str34503;
               while(true)
               {
                  this.i6 = li8(this.i5 + 1);
                  this.i5 += 1;
                  this.i9 = this.i5;
                  if(this.i6 == 0)
                  {
                     break;
                  }
                  this.i5 = this.i9;
               }
               this.i6 = __2E_str34503;
               mstate.esp -= 12;
               this.i5 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 17;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 17:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -64);
               this.i5 = 4;
               si32(this.i5,mstate.ebp + -56);
               this.i5 = li32(this.i7);
               mstate.esp -= 16;
               this.i5 += -12;
               this.i6 = mstate.ebp + -64;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 18;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 18:
               mstate.esp += 16;
               this.i3 = li32(this.i7);
               this.i3 += -12;
               si32(this.i3,this.i7);
               this.i3 = li8(this.i0);
               this.i5 = this.i3 == 46 ? int(this.i0) : 0;
               if(this.i3 != 0)
               {
                  this.i3 = this.i8 + 1;
                  do
                  {
                     this.i6 = li8(this.i3);
                     this.i5 = this.i6 == 46 ? int(this.i3) : int(this.i5);
                     this.i3 += 1;
                  }
                  while(this.i6 != 0);
                  
               }
               this.i3 = this.i5;
               if(this.i3 == 0)
               {
                  this.i3 = this.i0;
               }
               else
               {
                  this.i3 += 1;
               }
               this.i5 = li32(this.i1 + 16);
               this.i6 = li32(this.i5 + 68);
               this.i5 = li32(this.i5 + 64);
               this.i3 -= this.i8;
               if(uint(this.i6) >= uint(this.i5))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 19;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1580);
               break;
            case 19:
               mstate.esp += 4;
               addr1580:
               this.i5 = 4;
               this.i6 = li32(this.i7);
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 20:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i6);
               si32(this.i5,this.i6 + 8);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 21:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = __2E_str36505;
               while(true)
               {
                  this.i5 = li8(this.i3 + 1);
                  this.i3 += 1;
                  this.i6 = this.i3;
                  if(this.i5 == 0)
                  {
                     break;
                  }
                  this.i3 = this.i6;
               }
               this.i5 = __2E_str36505;
               mstate.esp -= 12;
               this.i3 -= this.i5;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 22:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -80);
               this.i3 = 4;
               si32(this.i3,mstate.ebp + -72);
               this.i3 = li32(this.i7);
               mstate.esp -= 16;
               this.i3 += -12;
               this.i5 = mstate.ebp + -80;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 23;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 23:
               mstate.esp += 16;
               this.i0 = li32(this.i7);
               this.i0 += -12;
               si32(this.i0,this.i7);
               §§goto(addr1914);
            case 24:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i7);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i3);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i7);
               this.i0 += 12;
               si32(this.i0,this.i7);
               this.i0 = li32(this.i1 + 20);
               this.i3 = li32(this.i1 + 40);
               mstate.esp -= 16;
               this.i5 = mstate.ebp + -224;
               this.i6 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               mstate.esp -= 4;
               FSM_lua_getstack390.start();
            case 25:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               if(this.i0 != 0)
               {
                  this.i0 = __2E_str40240;
                  mstate.esp -= 12;
                  this.i3 = mstate.ebp + -224;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 26;
                  mstate.esp -= 4;
                  FSM_lua_getinfo.start();
                  return;
               }
               §§goto(addr2211);
               break;
            case 26:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 != 0)
               {
                  this.i0 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  addr2171:
                  this.i0 = mstate.eax;
                  mstate.esp += 8;
                  this.i3 = li32(this.i0 + 8);
                  if(this.i3 == 6)
                  {
                     this.i0 = li32(this.i0);
                     this.i0 = li8(this.i0 + 6);
                     if(this.i0 != 0)
                     {
                        §§goto(addr2211);
                     }
                  }
                  this.i0 = -2;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  addr2666:
                  this.i3 = mstate.eax;
                  mstate.esp += 8;
                  this.i5 = li32(this.i7);
                  this.f0 = lf64(this.i3);
                  sf64(this.f0,this.i5);
                  this.i3 = li32(this.i3 + 8);
                  si32(this.i3,this.i5 + 8);
                  this.i3 = li32(this.i7);
                  this.i3 += 12;
                  si32(this.i3,this.i7);
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_lua_setfenv.start();
                  this.i0 = mstate.eax;
                  mstate.esp += 8;
                  this.i0 = li32(this.i7);
                  this.i0 += -12;
                  si32(this.i0,this.i7);
                  if(this.i2 >= 24)
                  {
                     addr2397:
                     this.i2 = 2;
                     addr2403:
                     this.i0 = -2;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     this.i3 = mstate.eax;
                     mstate.esp += 8;
                     this.i5 = li32(this.i7);
                     this.f0 = lf64(this.i3);
                     sf64(this.f0,this.i5);
                     this.i3 = li32(this.i3 + 8);
                     si32(this.i3,this.i5 + 8);
                     this.i3 = li32(this.i7);
                     this.i3 += 12;
                     si32(this.i3,this.i7);
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     break;
                  }
                  §§goto(addr2782);
               }
               addr2211:
               this.i0 = __2E_str38507;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 28;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
            case 27:
               §§goto(addr2171);
            case 28:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 29:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i7);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i5);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i5 + 8);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setfenv.start();
            case 30:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i7);
               this.i0 += -12;
               si32(this.i0,this.i7);
               if(this.i2 >= 24)
               {
                  §§goto(addr2397);
               }
               else
               {
                  §§goto(addr2782);
               }
            case 33:
               mstate.esp += 12;
               this.i2 += 1;
               if(this.i2 <= this.i4)
               {
                  §§goto(addr2403);
               }
               else
               {
                  §§goto(addr2782);
               }
            case 34:
               §§goto(addr2666);
            case 35:
               §§goto(addr2171);
            case 31:
               §§goto(addr2397);
            case 32:
               break;
            case 36:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -96);
               si32(this.i9,mstate.ebp + -88);
               this.i5 = li32(this.i7);
               mstate.esp -= 16;
               this.i9 = mstate.ebp + -96;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 37;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 37:
               mstate.esp += 16;
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               this.i3 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 38:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = _luaO_nilobject_;
               if(this.i3 != this.i5)
               {
                  this.i3 = li32(this.i3 + 8);
                  if(this.i3 == 5)
                  {
                     §§goto(addr3327);
                  }
               }
               this.i3 = 1;
               this.i5 = li32(this.i7);
               this.i5 += -12;
               si32(this.i5,this.i7);
               mstate.esp -= 16;
               this.i5 = -10002;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 39;
               mstate.esp -= 4;
               FSM_luaL_findtable.start();
               return;
            case 42:
               mstate.esp += 16;
               this.i3 = li32(this.i7);
               this.i3 += -12;
               si32(this.i3,this.i7);
               addr3327:
               this.i3 = -1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr3357);
            case 43:
               addr3357:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = __2E_str34503;
               while(true)
               {
                  this.i6 = li8(this.i5 + 1);
                  this.i5 += 1;
                  this.i9 = this.i5;
                  if(this.i6 == 0)
                  {
                     break;
                  }
                  this.i5 = this.i9;
               }
               this.i6 = __2E_str34503;
               mstate.esp -= 12;
               this.i5 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 40:
               mstate.esp += 12;
               addr2782:
               this.i0 = 0;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 41:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -48);
               si32(this.i6,mstate.ebp + -40);
               this.i5 = li32(this.i7);
               mstate.esp -= 16;
               this.i5 += -12;
               this.i6 = mstate.ebp + -48;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 42;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            default:
               throw "Invalid state in _ll_module";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i3 = li32(this.i7);
         this.f0 = lf64(this.i0);
         sf64(this.f0,this.i3);
         this.i0 = li32(this.i0 + 8);
         si32(this.i0,this.i3 + 8);
         this.i0 = li32(this.i7);
         this.i3 = this.i0 + 12;
         si32(this.i3,this.i7);
         mstate.esp -= 12;
         this.i0 += -12;
         this.i3 = 0;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 33;
         mstate.esp -= 4;
         FSM_luaD_call.start();
      }
   }
}
