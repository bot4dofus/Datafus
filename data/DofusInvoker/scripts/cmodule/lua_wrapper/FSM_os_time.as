package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_os_time extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
      
      public function FSM_os_time()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_os_time = null;
         _loc1_ = new FSM_os_time();
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
               mstate.esp -= 160;
               this.i0 = 1;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 > 0)
                  {
                     this.i0 = 1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr175);
                  }
               }
               mstate.esp -= 4;
               FSM_time.start();
            case 3:
               addr175:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 5)
                  {
                     §§goto(addr257);
                  }
               }
               this.i0 = 5;
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_tag_error.start();
               return;
            case 4:
               mstate.esp += 12;
               addr257:
               this.i0 = li32(this.i1 + 12);
               this.i2 = li32(this.i1 + 8);
               this.i3 = this.i1 + 12;
               this.i4 = this.i1 + 8;
               this.i5 = this.i0 + 12;
               if(uint(this.i2) < uint(this.i5))
               {
                  this.i0 = this.i2;
                  while(true)
                  {
                     this.i2 = 0;
                     si32(this.i2,this.i0 + 8);
                     this.i2 = this.i0 + 12;
                     si32(this.i2,this.i4);
                     this.i5 = li32(this.i3);
                     if(this.i0 >= this.i5)
                     {
                        break;
                     }
                     this.i0 = this.i2;
                  }
                  this.i0 = this.i5;
               }
               this.i2 = -1;
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr384);
            case 5:
               addr384:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str17399;
               while(true)
               {
                  this.i3 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i3 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i3 = __2E_str17399;
               mstate.esp -= 12;
               this.i2 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               if(this.i0 == -1)
               {
                  break;
               }
               §§goto(addr116);
               break;
            case 6:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -16);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -8);
               this.i2 = li32(this.i4);
               mstate.esp -= 16;
               this.i3 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 7:
               mstate.esp += 16;
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_lua_isnumber.start();
               return;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_lua_tointeger.start();
                  return;
               }
               this.i0 = 0;
               addr679:
               this.i2 = -1;
               this.i3 = li32(this.i4);
               this.i3 += -12;
               si32(this.i3,this.i4);
               si32(this.i0,mstate.ebp + -160);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr679);
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str17365;
               while(true)
               {
                  this.i3 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i3 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i3 = __2E_str17365;
               mstate.esp -= 12;
               this.i2 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 11:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -32);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -24);
               this.i2 = li32(this.i4);
               mstate.esp -= 16;
               this.i3 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 12;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 12:
               mstate.esp += 16;
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 13;
               mstate.esp -= 4;
               FSM_lua_isnumber.start();
               return;
            case 13:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 14;
                  mstate.esp -= 4;
                  FSM_lua_tointeger.start();
                  return;
               }
               this.i0 = 0;
               addr1027:
               this.i2 = -1;
               this.i3 = li32(this.i4);
               this.i3 += -12;
               si32(this.i3,this.i4);
               si32(this.i0,mstate.ebp + -156);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 14:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr1027);
            case 15:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str19401;
               while(true)
               {
                  this.i3 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i3 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i3 = __2E_str19401;
               mstate.esp -= 12;
               this.i2 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -48);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -40);
               this.i2 = li32(this.i4);
               mstate.esp -= 16;
               this.i3 = mstate.ebp + -48;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 17;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 17:
               mstate.esp += 16;
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 18;
               mstate.esp -= 4;
               FSM_lua_isnumber.start();
               return;
            case 18:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 19;
                  mstate.esp -= 4;
                  FSM_lua_tointeger.start();
                  return;
               }
               this.i0 = 12;
               addr1375:
               this.i2 = -1;
               this.i3 = li32(this.i4);
               this.i3 += -12;
               si32(this.i3,this.i4);
               si32(this.i0,mstate.ebp + -152);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 19:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr1375);
            case 20:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str20402;
               while(true)
               {
                  this.i3 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i3 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i3 = __2E_str20402;
               mstate.esp -= 12;
               this.i2 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 21;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 21:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -64);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -56);
               this.i2 = li32(this.i4);
               mstate.esp -= 16;
               this.i3 = mstate.ebp + -64;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 22;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 22:
               mstate.esp += 16;
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 23;
               mstate.esp -= 4;
               FSM_lua_isnumber.start();
               return;
            case 23:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 24;
                  mstate.esp -= 4;
                  FSM_lua_tointeger.start();
                  return;
               }
               this.i0 = __2E_str14396;
               mstate.esp -= 12;
               this.i2 = __2E_str20402;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 25;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
               break;
            case 24:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.i2 += -12;
               si32(this.i2,this.i4);
               addr1790:
               this.i2 = -1;
               si32(this.i0,mstate.ebp + -148);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 25:
               mstate.esp += 12;
               this.i0 = 0;
               §§goto(addr1790);
            case 26:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str21403;
               while(true)
               {
                  this.i3 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i3 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i3 = __2E_str21403;
               mstate.esp -= 12;
               this.i2 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 27;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 27:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -80);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -72);
               this.i2 = li32(this.i4);
               mstate.esp -= 16;
               this.i3 = mstate.ebp + -80;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 28;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 28:
               mstate.esp += 16;
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 29;
               mstate.esp -= 4;
               FSM_lua_isnumber.start();
               return;
            case 29:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 30;
                  mstate.esp -= 4;
                  FSM_lua_tointeger.start();
                  return;
               }
               this.i0 = __2E_str14396;
               mstate.esp -= 12;
               this.i2 = __2E_str21403;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 31;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
               break;
            case 30:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.i2 += -12;
               si32(this.i2,this.i4);
               this.i0 += -1;
               addr2195:
               this.i2 = -1;
               si32(this.i0,mstate.ebp + -144);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 31:
               mstate.esp += 12;
               this.i0 = -1;
               §§goto(addr2195);
            case 32:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str22404;
               while(true)
               {
                  this.i3 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i3 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i3 = __2E_str22404;
               mstate.esp -= 12;
               this.i2 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 33;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 33:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -96);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -88);
               this.i2 = li32(this.i4);
               mstate.esp -= 16;
               this.i3 = mstate.ebp + -96;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 34;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 34:
               mstate.esp += 16;
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 35;
               mstate.esp -= 4;
               FSM_lua_isnumber.start();
               return;
            case 35:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 36;
                  mstate.esp -= 4;
                  FSM_lua_tointeger.start();
                  return;
               }
               this.i0 = __2E_str14396;
               mstate.esp -= 12;
               this.i2 = __2E_str22404;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
               break;
            case 36:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.i2 += -12;
               si32(this.i2,this.i4);
               this.i0 += -1900;
               addr2600:
               this.i2 = -1;
               si32(this.i0,mstate.ebp + -140);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 37:
               mstate.esp += 12;
               this.i0 = -1900;
               §§goto(addr2600);
            case 38:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str25407;
               while(true)
               {
                  this.i3 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i3 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i3 = __2E_str25407;
               mstate.esp -= 12;
               this.i2 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 39;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 39:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -112);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -104);
               this.i2 = li32(this.i4);
               mstate.esp -= 16;
               this.i3 = mstate.ebp + -112;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 40;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 40:
               mstate.esp += 16;
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 41:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 0)
                  {
                     this.i0 = -1;
                  }
                  else
                  {
                     addr2901:
                     this.i0 = -1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     this.i2 = li32(this.i0 + 8);
                     if(this.i2 != 0)
                     {
                        if(this.i2 != 1)
                        {
                           this.i0 = 1;
                        }
                        else
                        {
                           this.i0 = li32(this.i0);
                           this.i0 = this.i0 != 0 ? 1 : 0;
                           this.i0 &= 1;
                        }
                     }
                     else
                     {
                        this.i0 = 0;
                     }
                  }
                  this.i2 = mstate.ebp + -160;
                  this.i3 = li32(this.i4);
                  this.i3 += -12;
                  si32(this.i3,this.i4);
                  si32(this.i0,mstate.ebp + -128);
                  state = 43;
                  mstate.esp -= 4;
                  FSM_tzset_basic.start();
                  return;
               }
               §§goto(addr2901);
            case 42:
               §§goto(addr2901);
            case 43:
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               mstate.esp -= 4;
               FSM_time1.start();
            case 44:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               if(this.i0 == -1)
               {
                  break;
               }
               §§goto(addr116);
               break;
            default:
               throw "Invalid state in _os_time";
         }
         this.i0 = 0;
         this.i2 = li32(this.i1 + 8);
         si32(this.i0,this.i2 + 8);
         addr116:
         this.i2 = 3;
         this.i3 = li32(this.i1 + 8);
         this.f0 = Number(this.i0);
         sf64(this.f0,this.i3);
         si32(this.i2,this.i3 + 8);
         this.i0 = li32(this.i1 + 8);
         this.i0 += 12;
         si32(this.i0,this.i1 + 8);
         this.i0 = 1;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
