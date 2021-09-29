package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_f_seek extends Machine
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
      
      public function FSM_f_seek()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_f_seek = null;
         _loc1_ = new FSM_f_seek();
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
               mstate.esp -= 8;
               this.i0 = __2E_str17320;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checkudata.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i0);
               if(this.i2 == 0)
               {
                  this.i2 = __2E_str20323;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               this.i0 = this.i2;
               §§goto(addr139);
               break;
            case 2:
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               addr139:
               this.i2 = __2E_str35338;
               mstate.esp -= 16;
               this.i3 = _modenames_2E_2974;
               this.i4 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 3;
               mstate.esp -= 4;
               FSM_luaL_checkoption.start();
               return;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 8;
               this.i3 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = _luaO_nilobject_;
               if(this.i3 != this.i4)
               {
                  this.i3 = li32(this.i3 + 8);
                  if(this.i3 >= 1)
                  {
                     this.i3 = 3;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaL_checkinteger.start();
                     return;
                  }
               }
               this.i3 = 0;
               this.i4 = this.i3;
               break;
            case 5:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = this.i3 >> 31;
               break;
            case 6:
               this.i2 = mstate.eax;
               mstate.esp += 20;
               if(this.i2 == 0)
               {
                  this.i2 = mstate.ebp + -8;
                  si32(this.i5,_val_2E_1440);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 7;
                  mstate.esp -= 4;
                  FSM__ftello.start();
                  return;
               }
               this.i0 = 0;
               this.i2 = li32(_val_2E_1440);
               this.i3 = li32(this.i1 + 8);
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 12;
               this.i0 = _ebuf_2E_1986;
               this.i3 = 2048;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_strerror_r.start();
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i3 = this.i1 + 8;
               if(this.i0 != 0)
               {
                  this.i0 = 22;
                  si32(this.i0,_val_2E_1440);
               }
               this.i0 = __2E_str54344;
               mstate.esp -= 12;
               this.i4 = _ebuf_2E_1986;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = -1;
                  this.i2 = this.i0;
               }
               else
               {
                  this.i0 = li32(mstate.ebp + -8);
                  this.i2 = li32(mstate.ebp + -4);
                  if(this.i2 < 0)
                  {
                     this.i0 = 29;
                     si32(this.i0,_val_2E_1440);
                     this.i0 = -1;
                     this.i2 = this.i0;
                  }
               }
               this.i3 = this.i2 < 0 ? 1 : 0;
               this.i4 = uint(this.i0) < uint(-2147483648) ? 1 : 0;
               this.i2 = this.i2 == 0 ? 1 : 0;
               this.i2 = this.i2 != 0 ? int(this.i4) : int(this.i3);
               if(this.i2 == 0)
               {
                  this.i0 = 84;
                  si32(this.i0,_val_2E_1440);
                  this.f0 = -1;
               }
               else
               {
                  this.f0 = Number(this.i0);
               }
               this.i0 = 3;
               this.i2 = li32(this.i1 + 8);
               sf64(this.f0,this.i2);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               this.i0 = 1;
               mstate.eax = this.i0;
               §§goto(addr930);
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i3);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0);
               this.i1 = 3;
               si32(this.i1,this.i0 + 8);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.eax = this.i1;
               addr930:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _f_seek";
         }
         this.i5 = _mode_2E_2973;
         this.i2 <<= 2;
         this.i2 = this.i5 + this.i2;
         this.i2 = li32(this.i2);
         this.i5 = li32(_val_2E_1440);
         this.i6 = li8(___sdidinit_2E_b);
         if(this.i6 == 0)
         {
            this.i6 = _usual;
            this.i7 = _usual_extra;
            this.i8 = 0;
            this.i6 += 56;
            do
            {
               si32(this.i7,this.i6);
               this.i7 += 148;
               this.i6 += 88;
               this.i8 += 1;
            }
            while(this.i8 != 17);
            
            this.i6 = 1;
            si8(this.i6,___cleanup_2E_b);
            si8(this.i6,___sdidinit_2E_b);
         }
         this.i6 = 1;
         mstate.esp -= 20;
         si32(this.i0,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         si32(this.i4,mstate.esp + 8);
         si32(this.i2,mstate.esp + 12);
         si32(this.i6,mstate.esp + 16);
         state = 6;
         mstate.esp -= 4;
         FSM__fseeko.start();
      }
   }
}
