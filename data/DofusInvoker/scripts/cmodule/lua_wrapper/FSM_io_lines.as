package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_io_lines extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public function FSM_io_lines()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_io_lines = null;
         _loc1_ = new FSM_io_lines();
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
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 > 0)
                  {
                     this.i0 = 0;
                     mstate.esp -= 12;
                     this.i2 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 8;
                     mstate.esp -= 4;
                     FSM_luaL_checklstring.start();
                     return;
                  }
               }
               this.i0 = -10001;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               mstate.esp -= 8;
               this.i2 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 3:
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
               this.i0 = __2E_str17320;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaL_checkudata.start();
               return;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               this.i2 = this.i1 + 8;
               if(this.i0 == 0)
               {
                  this.i0 = __2E_str20323;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               addr334:
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 5:
               mstate.esp += 8;
               §§goto(addr334);
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i2);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i4);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i2);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i2);
               this.i4 = 0;
               si32(this.i4,this.i3 + 12);
               si32(this.i0,this.i3 + 20);
               this.i3 = li32(this.i2);
               this.i3 += 12;
               si32(this.i3,this.i2);
               break;
            case 7:
               mstate.esp += 12;
               mstate.eax = this.i0;
               §§goto(addr511);
            case 8:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i3 = 4;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               FSM_lua_newuserdata.start();
               return;
            case 9:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i4 = __2E_str17320;
               while(true)
               {
                  this.i5 = li8(this.i4 + 1);
                  this.i4 += 1;
                  this.i6 = this.i4;
                  if(this.i5 == 0)
                  {
                     break;
                  }
                  this.i4 = this.i6;
               }
               this.i5 = __2E_str17320;
               mstate.esp -= 12;
               this.i4 -= this.i5;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 11:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,mstate.ebp + -16);
               this.i4 = 4;
               si32(this.i4,mstate.ebp + -8);
               this.i4 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i5 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 12;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 12:
               mstate.esp += 16;
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 13:
               mstate.esp += 8;
               this.i0 = li8(__2E_str19170 + 2);
               mstate.esp -= 16;
               this.i4 = 114;
               this.i5 = 0;
               si32(this.i2,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 14;
               mstate.esp -= 4;
               FSM_fopen387.start();
               return;
            case 14:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               si32(this.i0,this.i3);
               this.i3 = this.i1 + 8;
               if(this.i0 == 0)
               {
                  this.i0 = _ebuf_2E_1986;
                  this.i4 = li32(_val_2E_1440);
                  mstate.esp -= 12;
                  this.i5 = 2048;
                  si32(this.i4,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_strerror_r.start();
               }
               else
               {
                  this.i0 = 1;
                  this.i2 = li32(this.i3);
                  this.i4 = li32(this.i1 + 12);
                  this.i2 -= this.i4;
                  mstate.esp -= 8;
                  this.i2 /= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
            case 21:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i3);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i4);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i3);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i3);
               si32(this.i0,this.i2 + 12);
               si32(this.i0,this.i2 + 20);
               this.i2 = li32(this.i3);
               this.i2 += 12;
               si32(this.i2,this.i3);
               break;
            case 15:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 != 0)
               {
                  this.i0 = 22;
                  si32(this.i0,_val_2E_1440);
               }
               this.i0 = __2E_str15318;
               mstate.esp -= 16;
               this.i4 = _ebuf_2E_1986;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 16;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
            case 16:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 12;
               this.i0 = -1;
               this.i2 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 17;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 17:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 18:
               mstate.esp += 12;
               this.i0 = li32(this.i3);
               this.i4 = li32(this.i1 + 12);
               this.i0 -= this.i4;
               mstate.esp -= 8;
               this.i0 /= 12;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 19:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i3);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i4);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i3);
               this.i4 = this.i0 + 12;
               si32(this.i4,this.i3);
               si32(this.i2,this.i0 + 12);
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 12;
               this.i3 = _io_readline;
               this.i0 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_lua_pushcclosure.start();
               return;
            case 20:
               mstate.esp += 12;
               mstate.eax = this.i2;
               addr511:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _io_lines";
         }
         mstate.esp -= 12;
         this.i2 = _io_readline;
         this.i3 = 2;
         si32(this.i1,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 7;
         mstate.esp -= 4;
         FSM_lua_pushcclosure.start();
      }
   }
}
