package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaopen_io extends Machine
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
      
      public function FSM_luaopen_io()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaopen_io = null;
         _loc1_ = new FSM_luaopen_io();
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
               mstate.esp -= 80;
               this.i0 = __2E_str17320;
               this.i1 = li32(mstate.ebp + 8);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_newmetatable.start();
               return;
            case 1:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
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
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 3:
               break;
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -80);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -72);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -80;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 5;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 5:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i0 += -12;
               si32(this.i0,this.i3);
               mstate.esp -= 12;
               this.i0 = _flib;
               this.i2 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaL_register.start();
               return;
            case 6:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i0 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 7;
               mstate.esp -= 4;
               FSM_lua_createtable.start();
               return;
            case 7:
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i0 = _io_fclose;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_lua_pushcclosure.start();
               return;
            case 8:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str22325;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str22325;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -32);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -24);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i5 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 11;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 11:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i0 += -12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -10001;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 12;
               mstate.esp -= 4;
               FSM_lua_replace.start();
               return;
            case 12:
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i0 = __2E_str41344;
               this.i2 = _iolib;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaL_register.start();
               return;
            case 13:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i0 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 14;
               mstate.esp -= 4;
               FSM_lua_createtable.start();
               return;
            case 14:
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i0 = _io_noclose;
               this.i2 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 15;
               mstate.esp -= 4;
               FSM_lua_pushcclosure.start();
               return;
            case 15:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 16:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = this.i4;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str22325;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 17;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 17:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -16);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -8);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 18;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 18:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i0 += -12;
               si32(this.i0,this.i3);
               this.i0 = ___sF;
               mstate.esp -= 16;
               this.i2 = __2E_str42345;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 19;
               mstate.esp -= 4;
               FSM_createstdfile.start();
               return;
            case 19:
               mstate.esp += 16;
               mstate.esp -= 16;
               this.i2 = __2E_str43346;
               this.i4 = 2;
               this.i5 = this.i0 + 88;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 20;
               mstate.esp -= 4;
               FSM_createstdfile.start();
               return;
            case 20:
               mstate.esp += 16;
               mstate.esp -= 16;
               this.i2 = __2E_str44347;
               this.i0 += 176;
               this.i4 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 21;
               mstate.esp -= 4;
               FSM_createstdfile.start();
               return;
            case 21:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i0 += -12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 22:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str6309;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str6309;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 23;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 23:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -48);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -40);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i4 = mstate.ebp + -48;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 24;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 24:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 25;
               mstate.esp -= 4;
               FSM_lua_createtable.start();
               return;
            case 25:
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i0 = _io_pclose;
               this.i2 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 26;
               mstate.esp -= 4;
               FSM_lua_pushcclosure.start();
               return;
            case 26:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 27:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str22325;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str22325;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 28;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 28:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -64);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -56);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -64;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 29;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 29:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i0 += -12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setfenv.start();
            case 30:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i3);
               this.i0 += -12;
               si32(this.i0,this.i3);
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaopen_io";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i2 = __2E_str11139;
         this.i3 = this.i1 + 8;
         while(true)
         {
            this.i4 = li8(this.i2 + 1);
            this.i2 += 1;
            this.i5 = this.i2;
            if(this.i4 == 0)
            {
               break;
            }
            this.i2 = this.i5;
         }
         this.i4 = __2E_str11139;
         mstate.esp -= 12;
         this.i2 -= this.i4;
         si32(this.i1,mstate.esp);
         si32(this.i4,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 4;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
