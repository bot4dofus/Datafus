package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi16;
   
   public final class FSM_close_func extends Machine
   {
      
      public static const intRegCount:int = 13;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
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
      
      public function FSM_close_func()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_close_func = null;
         _loc1_ = new FSM_close_func();
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
               this.i1 = li32(this.i0 + 36);
               this.i2 = li32(this.i0 + 40);
               this.i3 = li32(this.i1);
               this.i4 = li8(this.i1 + 50);
               this.i5 = this.i1 + 50;
               this.i6 = this.i0 + 36;
               this.i7 = this.i0 + 40;
               this.i8 = this.i1;
               if(this.i4 >= 1)
               {
                  this.i9 = this.i8 + 24;
                  do
                  {
                     this.i4 += -1;
                     this.i10 = li32(this.i1);
                     this.i10 = li32(this.i10 + 24);
                     this.i11 = this.i4 & 255;
                     this.i11 <<= 1;
                     si8(this.i4,this.i5);
                     this.i4 = this.i8 + this.i11;
                     this.i4 = li16(this.i4 + 172);
                     this.i11 = li32(this.i9);
                     this.i4 *= 12;
                     this.i4 = this.i10 + this.i4;
                     si32(this.i11,this.i4 + 8);
                     this.i4 = li8(this.i5);
                  }
                  while(this.i4 >= 1);
                  
               }
               this.i1 = 8388638;
               this.i4 = li32(this.i8 + 12);
               this.i4 = li32(this.i4 + 8);
               mstate.esp -= 12;
               si32(this.i8,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i1 = li32(this.i8 + 24);
               this.i4 = this.i8 + 24;
               this.i5 = this.i1 + 1;
               if(uint(this.i5) <= uint(1073741823))
               {
                  this.i5 = li32(this.i2 + 16);
                  this.i9 = li32(this.i3 + 44);
                  this.i10 = li32(this.i3 + 12);
                  this.i11 = li32(this.i5 + 12);
                  this.i12 = li32(this.i5 + 16);
                  mstate.esp -= 16;
                  this.i9 <<= 2;
                  this.i1 <<= 2;
                  si32(this.i12,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  si32(this.i9,mstate.esp + 8);
                  si32(this.i1,mstate.esp + 12);
                  state = 2;
                  mstate.esp -= 4;
                  mstate.funcs[this.i11]();
                  return;
               }
               this.i1 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 2:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               if(this.i10 == 0)
               {
                  if(this.i1 != 0)
                  {
                     this.i11 = 4;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr430:
               this.i11 = li32(this.i5 + 68);
               this.i1 -= this.i9;
               this.i1 += this.i11;
               si32(this.i1,this.i5 + 68);
               this.i1 = this.i10;
               break;
            case 3:
               mstate.esp += 8;
               §§goto(addr430);
            case 4:
               mstate.esp += 8;
               this.i1 = 0;
               break;
            case 5:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               if(this.i10 == 0)
               {
                  if(this.i1 != 0)
                  {
                     this.i11 = 4;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr704:
               this.i11 = li32(this.i5 + 68);
               this.i1 -= this.i9;
               this.i1 += this.i11;
               si32(this.i1,this.i5 + 68);
               this.i1 = this.i10;
               si32(this.i1,this.i3 + 20);
               this.i1 = li32(this.i4);
               si32(this.i1,this.i3 + 48);
               this.i1 = li32(this.i8 + 40);
               this.i4 = this.i8 + 40;
               this.i5 = this.i1 + 1;
               if(uint(this.i5) <= uint(357913941))
               {
                  this.i5 = li32(this.i2 + 16);
                  this.i9 = li32(this.i3 + 40);
                  this.i10 = li32(this.i3 + 8);
                  this.i11 = li32(this.i5 + 12);
                  this.i12 = li32(this.i5 + 16);
                  mstate.esp -= 16;
                  this.i9 *= 12;
                  this.i1 *= 12;
                  si32(this.i12,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  si32(this.i9,mstate.esp + 8);
                  si32(this.i1,mstate.esp + 12);
                  state = 8;
                  mstate.esp -= 4;
                  mstate.funcs[this.i11]();
                  return;
               }
               this.i1 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 10;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 6:
               mstate.esp += 8;
               §§goto(addr704);
            case 7:
               mstate.esp += 8;
               this.i1 = 0;
               §§goto(addr704);
            case 8:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               if(this.i10 == 0)
               {
                  if(this.i1 != 0)
                  {
                     this.i11 = 4;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 9;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr986:
               this.i11 = li32(this.i5 + 68);
               this.i1 -= this.i9;
               this.i1 += this.i11;
               si32(this.i1,this.i5 + 68);
               this.i1 = this.i10;
               si32(this.i1,this.i3 + 8);
               this.i1 = li32(this.i4);
               si32(this.i1,this.i3 + 40);
               this.i1 = li32(this.i8 + 44);
               this.i4 = this.i8 + 44;
               this.i5 = this.i1 + 1;
               if(uint(this.i5) <= uint(1073741823))
               {
                  this.i5 = li32(this.i2 + 16);
                  this.i9 = li32(this.i3 + 52);
                  this.i10 = li32(this.i3 + 16);
                  this.i11 = li32(this.i5 + 12);
                  this.i12 = li32(this.i5 + 16);
                  mstate.esp -= 16;
                  this.i9 <<= 2;
                  this.i1 <<= 2;
                  si32(this.i12,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  si32(this.i9,mstate.esp + 8);
                  si32(this.i1,mstate.esp + 12);
                  state = 11;
                  mstate.esp -= 4;
                  mstate.funcs[this.i11]();
                  return;
               }
               this.i1 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 13;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 9:
               mstate.esp += 8;
               §§goto(addr986);
            case 10:
               mstate.esp += 8;
               this.i1 = 0;
               §§goto(addr986);
            case 11:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               if(this.i10 == 0)
               {
                  if(this.i1 != 0)
                  {
                     this.i11 = 4;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 12;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr1268:
               this.i11 = li32(this.i5 + 68);
               this.i1 -= this.i9;
               this.i1 += this.i11;
               si32(this.i1,this.i5 + 68);
               this.i1 = this.i10;
               si32(this.i1,this.i3 + 16);
               this.i1 = li32(this.i4);
               si32(this.i1,this.i3 + 52);
               this.i1 = si16(li16(this.i8 + 48));
               this.i4 = this.i8 + 48;
               this.i5 = this.i1 + 1;
               if(uint(this.i5) <= uint(357913941))
               {
                  this.i5 = li32(this.i2 + 16);
                  this.i9 = li32(this.i3 + 56);
                  this.i10 = li32(this.i3 + 24);
                  this.i11 = li32(this.i5 + 12);
                  this.i12 = li32(this.i5 + 16);
                  mstate.esp -= 16;
                  this.i9 *= 12;
                  this.i1 *= 12;
                  si32(this.i12,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  si32(this.i9,mstate.esp + 8);
                  si32(this.i1,mstate.esp + 12);
                  state = 14;
                  mstate.esp -= 4;
                  mstate.funcs[this.i11]();
                  return;
               }
               this.i1 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 16;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 12:
               mstate.esp += 8;
               §§goto(addr1268);
            case 13:
               mstate.esp += 8;
               this.i1 = 0;
               §§goto(addr1268);
            case 14:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               if(this.i10 == 0)
               {
                  if(this.i1 != 0)
                  {
                     this.i11 = 4;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 15;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               §§goto(addr1551);
            case 15:
               mstate.esp += 8;
               §§goto(addr1551);
            case 16:
               mstate.esp += 8;
               this.i1 = 0;
               addr1551:
               this.i11 = li32(this.i5 + 68);
               this.i1 -= this.i9;
               this.i1 += this.i11;
               si32(this.i1,this.i5 + 68);
               this.i1 = this.i10;
               si32(this.i1,this.i3 + 24);
               this.i1 = si16(li16(this.i4));
               si32(this.i1,this.i3 + 56);
               this.i1 = li32(this.i2 + 16);
               this.i4 = li8(this.i3 + 72);
               this.i5 = li32(this.i3 + 36);
               this.i9 = li32(this.i3 + 28);
               this.i10 = li32(this.i1 + 12);
               this.i11 = li32(this.i1 + 16);
               mstate.esp -= 16;
               this.i5 <<= 2;
               this.i4 <<= 2;
               si32(this.i11,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 17;
               mstate.esp -= 4;
               mstate.funcs[this.i10]();
               return;
            case 17:
               this.i9 = mstate.eax;
               mstate.esp += 16;
               this.i10 = this.i3 + 28;
               this.i11 = this.i3 + 36;
               this.i3 += 72;
               if(this.i9 == 0)
               {
                  if(this.i4 != 0)
                  {
                     this.i12 = 4;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i12,mstate.esp + 4);
                     state = 18;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               §§goto(addr1831);
            case 18:
               mstate.esp += 8;
               §§goto(addr1831);
            case 19:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i1 = li32(this.i6);
               this.i1 = li32(this.i1 + 4);
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_luaH_setstr.start();
               return;
            case 20:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i1 = li32(this.i0 + 8);
               this.i2 = this.i0 + 8;
               if(this.i1 == 0)
               {
                  this.i1 = 1;
                  si32(this.i1,this.i0);
                  si32(this.i1,this.i2);
               }
               addr1831:
               this.i12 = li32(this.i1 + 68);
               this.i4 -= this.i5;
               this.i4 += this.i12;
               si32(this.i4,this.i1 + 68);
               si32(this.i9,this.i10);
               this.i1 = li8(this.i3);
               si32(this.i1,this.i11);
               this.i1 = li32(this.i8 + 8);
               si32(this.i1,this.i6);
               this.i1 = li32(this.i2 + 8);
               this.i1 += -24;
               si32(this.i1,this.i2 + 8);
               if(this.i8 != 0)
               {
                  this.i1 = li32(this.i0 + 12);
                  this.i1 += -285;
                  if(uint(this.i1) <= uint(1))
                  {
                     this.i0 = li32(this.i0 + 16);
                     this.i1 = li32(this.i0 + 12);
                     this.i2 = li32(this.i7);
                     mstate.esp -= 12;
                     this.i0 += 16;
                     si32(this.i2,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     si32(this.i1,mstate.esp + 8);
                     state = 19;
                     mstate.esp -= 4;
                     FSM_luaS_newlstr.start();
                     return;
                  }
               }
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _close_func";
         }
         si32(this.i1,this.i3 + 12);
         this.i1 = li32(this.i4);
         si32(this.i1,this.i3 + 44);
         this.i1 = li32(this.i4);
         this.i5 = this.i1 + 1;
         if(uint(this.i5) <= uint(1073741823))
         {
            this.i5 = li32(this.i2 + 16);
            this.i9 = li32(this.i3 + 48);
            this.i10 = li32(this.i3 + 20);
            this.i11 = li32(this.i5 + 12);
            this.i12 = li32(this.i5 + 16);
            mstate.esp -= 16;
            this.i9 <<= 2;
            this.i1 <<= 2;
            si32(this.i12,mstate.esp);
            si32(this.i10,mstate.esp + 4);
            si32(this.i9,mstate.esp + 8);
            si32(this.i1,mstate.esp + 12);
            state = 5;
            mstate.esp -= 4;
            mstate.funcs[this.i11]();
            return;
         }
         this.i1 = __2E_str149;
         mstate.esp -= 8;
         si32(this.i2,mstate.esp);
         si32(this.i1,mstate.esp + 4);
         state = 7;
         mstate.esp -= 4;
         FSM_luaG_runerror.start();
      }
   }
}
