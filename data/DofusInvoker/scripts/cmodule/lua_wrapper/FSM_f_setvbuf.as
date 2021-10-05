package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi16;
   
   public final class FSM_f_setvbuf extends Machine
   {
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_f_setvbuf()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_f_setvbuf = null;
         _loc1_ = new FSM_f_setvbuf();
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
               this.i2 = _modenames_2E_2991;
               mstate.esp -= 16;
               this.i3 = 0;
               this.i4 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
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
               this.i3 = 1024;
               §§goto(addr317);
            case 5:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               addr317:
               this.i4 = _mode_2E_2990;
               this.i2 <<= 2;
               this.i2 = this.i4 + this.i2;
               this.i2 = li32(this.i2);
               if(this.i2 != 2)
               {
                  if(this.i3 >= 0)
                  {
                     if(uint(this.i2) < uint(2))
                     {
                        §§goto(addr362);
                     }
                  }
                  this.i0 = -1;
                  break;
               }
               addr362:
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               FSM___sflush.start();
               return;
            case 6:
               this.i4 = mstate.eax;
               mstate.esp += 4;
               this.i4 = li32(this.i0 + 48);
               this.i5 = this.i0 + 48;
               if(this.i4 != 0)
               {
                  this.i6 = this.i0 + 64;
                  if(this.i4 != this.i6)
                  {
                     this.i6 = 0;
                     mstate.esp -= 8;
                     si32(this.i4,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
                  addr470:
                  this.i4 = 0;
                  si32(this.i4,this.i5);
               }
               this.i4 = 0;
               si32(this.i4,this.i0 + 24);
               si32(this.i4,this.i0 + 4);
               this.i4 = si16(li16(this.i0 + 12));
               this.i5 = this.i0 + 12;
               this.i6 = this.i0 + 24;
               this.i7 = this.i4 & 128;
               if(this.i7 != 0)
               {
                  this.i7 = 0;
                  this.i8 = li32(this.i0 + 16);
                  mstate.esp -= 8;
                  si32(this.i8,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               addr577:
               this.i4 &= -7332;
               if(this.i2 == 2)
               {
                  this.i2 = 0;
                  this.i3 = this.i4;
                  addr813:
                  this.i4 = 0;
                  this.i3 |= 2;
                  si16(this.i3,this.i5);
                  si32(this.i4,this.i0 + 8);
                  this.i3 = this.i0 + 67;
                  si32(this.i3,this.i0);
                  si32(this.i3,this.i0 + 16);
                  this.i3 = 1;
                  si32(this.i3,this.i0 + 20);
                  this.i0 = this.i2;
                  break;
               }
               this.i7 = mstate.ebp + -4;
               mstate.esp -= 12;
               this.i8 = mstate.ebp + -8;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM___swhatbuf.start();
               return;
               break;
            case 7:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr470);
            case 8:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr577);
            case 9:
               this.i7 = mstate.eax;
               mstate.esp += 12;
               this.i8 = li32(mstate.ebp + -8);
               mstate.esp -= 8;
               this.i3 = this.i3 == 0 ? int(this.i8) : int(this.i3);
               this.i9 = 0;
               si32(this.i9,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 10;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
            case 10:
               this.i9 = mstate.eax;
               mstate.esp += 8;
               this.i4 = this.i7 | this.i4;
               if(this.i9 != 0)
               {
                  this.i7 = 0;
               }
               else
               {
                  if(this.i3 != this.i8)
                  {
                     this.i3 = 0;
                     mstate.esp -= 8;
                     si32(this.i3,mstate.esp);
                     si32(this.i8,mstate.esp + 4);
                     state = 11;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
                  this.i7 = -1;
               }
               addr799:
               if(this.i9 != 0)
               {
                  this.i2 = this.i2 == 1 ? 1 : 0;
                  this.i2 &= 1;
                  this.i8 = this.i3 == this.i8 ? 0 : 2048;
                  this.i2 = this.i4 | this.i2;
                  this.i2 |= this.i8;
                  this.i2 |= 128;
                  si16(this.i2,this.i5);
                  si32(this.i9,this.i0);
                  si32(this.i9,this.i0 + 16);
                  si32(this.i3,this.i0 + 20);
                  this.i4 = this.i2 & 8;
                  if(this.i4 != 0)
                  {
                     this.i0 += 8;
                     this.i2 &= 1;
                     if(this.i2 != 0)
                     {
                        this.i2 = 0;
                        si32(this.i2,this.i0);
                        this.i0 = 0 - this.i3;
                        si32(this.i0,this.i6);
                        this.i0 = 1;
                        si8(this.i0,___cleanup_2E_b);
                        this.i0 = this.i7;
                        break;
                     }
                     this.i2 = 1;
                     si32(this.i3,this.i0);
                     si8(this.i2,___cleanup_2E_b);
                     this.i0 = this.i7;
                     break;
                  }
                  this.i2 = 0;
                  si32(this.i2,this.i0 + 8);
                  this.i0 = 1;
                  si8(this.i0,___cleanup_2E_b);
                  this.i0 = this.i7;
                  break;
               }
               this.i3 = this.i4;
               this.i2 = this.i7;
               §§goto(addr813);
               break;
            case 11:
               this.i9 = mstate.eax;
               mstate.esp += 8;
               this.i7 = -1;
               this.i3 = this.i8;
               §§goto(addr799);
            case 12:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _f_setvbuf";
         }
         this.i2 = 0;
         this.i0 = this.i0 == 0 ? 1 : 0;
         mstate.esp -= 12;
         this.i0 &= 1;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 12;
         mstate.esp -= 4;
         FSM_pushresult.start();
      }
   }
}
