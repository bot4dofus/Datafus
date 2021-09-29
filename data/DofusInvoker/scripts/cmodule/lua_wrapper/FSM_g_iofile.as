package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_g_iofile extends Machine
   {
      
      public static const intRegCount:int = 9;
      
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
      
      public function FSM_g_iofile()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_g_iofile = null;
         _loc1_ = new FSM_g_iofile();
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
               mstate.esp -= 16;
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
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = _luaO_nilobject_;
               if(this.i0 != this.i4)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 >= 1)
                  {
                     this.i0 = 0;
                     mstate.esp -= 12;
                     this.i4 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_lua_tolstring.start();
                     return;
                  }
               }
               this.i0 = -10001;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 22:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 23:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 != 0)
               {
                  this.i4 = 4;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_lua_newuserdata.start();
                  return;
               }
               this.i0 = __2E_str17320;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 16;
               mstate.esp -= 4;
               FSM_luaL_checkudata.start();
               return;
               break;
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = 0;
               si32(this.i5,this.i4);
               mstate.esp -= 8;
               this.i5 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i6 = __2E_str17320;
               while(true)
               {
                  this.i7 = li8(this.i6 + 1);
                  this.i6 += 1;
                  this.i8 = this.i6;
                  if(this.i7 == 0)
                  {
                     break;
                  }
                  this.i6 = this.i8;
               }
               this.i7 = __2E_str17320;
               mstate.esp -= 12;
               this.i6 -= this.i7;
               si32(this.i1,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 5:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               si32(this.i6,mstate.ebp + -16);
               this.i6 = 4;
               si32(this.i6,mstate.ebp + -8);
               this.i6 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i7 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 6:
               mstate.esp += 16;
               this.i5 = li32(this.i1 + 8);
               this.i5 += 12;
               si32(this.i5,this.i1 + 8);
               mstate.esp -= 8;
               this.i5 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 7:
               mstate.esp += 8;
               this.i5 = li8(this.i3);
               this.i6 = li8(this.i3 + 1);
               this.i3 = li8(this.i3 + 2);
               mstate.esp -= 16;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 8;
               mstate.esp -= 4;
               FSM_fopen387.start();
               return;
            case 8:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               si32(this.i3,this.i4);
               this.i4 = this.i1 + 8;
               if(this.i3 == 0)
               {
                  this.i3 = _ebuf_2E_1986;
                  this.i5 = li32(_val_2E_1440);
                  mstate.esp -= 12;
                  this.i6 = 2048;
                  si32(this.i5,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_strerror_r.start();
               }
               else
               {
                  §§goto(addr1173);
               }
            case 9:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               if(this.i3 != 0)
               {
                  this.i3 = 22;
                  si32(this.i3,_val_2E_1440);
               }
               this.i3 = __2E_str15318;
               mstate.esp -= 16;
               this.i5 = _ebuf_2E_1986;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 10;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 12;
               this.i0 = -1;
               this.i3 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 11:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 12:
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i0 = -10001;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 13:
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 14:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i1 = li32(this.i1);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 15:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i2);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               break;
            case 16:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               if(this.i0 == 0)
               {
                  this.i0 = __2E_str20323;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               addr1082:
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 17:
               mstate.esp += 8;
               §§goto(addr1082);
            case 18:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i3);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               addr1173:
               this.i0 = -10001;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 19:
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 20:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 21:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i0);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               break;
            default:
               throw "Invalid state in _g_iofile";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
