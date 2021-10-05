package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_forbody extends Machine
   {
      
      public static const intRegCount:int = 19;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i17:int;
      
      public var i16:int;
      
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
      
      public var i18:int;
      
      public function FSM_forbody()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_forbody = null;
         _loc1_ = new FSM_forbody();
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
               mstate.esp -= 48;
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 36);
               this.i3 = li8(this.i2 + 50);
               this.i3 += 3;
               si8(this.i3,this.i2 + 50);
               this.i3 = this.i2 + 24;
               this.i4 = this.i2 + 50;
               this.i5 = this.i1 + 36;
               this.i6 = li32(mstate.ebp + 12);
               this.i7 = li32(mstate.ebp + 16);
               this.i8 = li32(mstate.ebp + 20);
               this.i9 = li32(mstate.ebp + 24);
               this.i10 = this.i2;
               do
               {
                  this.i11 = li8(this.i4);
                  this.i11 = this.i0 + this.i11;
                  this.i11 <<= 1;
                  this.i11 += this.i2;
                  this.i11 = li16(this.i11 + 166);
                  this.i12 = li32(this.i10);
                  this.i12 = li32(this.i12 + 24);
                  this.i13 = li32(this.i3);
                  this.i11 *= 12;
                  this.i11 = this.i12 + this.i11;
                  si32(this.i13,this.i11 + 4);
                  this.i0 += 1;
               }
               while(this.i0 != 3);
               
               this.i0 = 259;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_checknext.start();
               return;
            case 1:
               mstate.esp += 8;
               if(this.i9 != 0)
               {
                  this.i0 = li32(this.i2 + 12);
                  this.i0 = li32(this.i0 + 8);
                  this.i11 = this.i6 << 6;
                  mstate.esp -= 12;
                  this.i11 |= 2147450912;
                  si32(this.i2,mstate.esp);
                  si32(this.i11,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaK_code.start();
                  return;
               }
               this.i0 = -1;
               this.i11 = li32(this.i2 + 32);
               si32(this.i0,this.i2 + 32);
               this.i0 = li32(this.i2 + 12);
               this.i0 = li32(this.i0 + 8);
               mstate.esp -= 12;
               this.i12 = 2147450902;
               si32(this.i2,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr462);
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,mstate.ebp + -24);
               mstate.esp -= 12;
               this.i0 = mstate.ebp + -24;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 4:
               mstate.esp += 12;
               this.i0 = li32(mstate.ebp + -24);
               addr462:
               this.i11 = -1;
               si32(this.i11,mstate.ebp + -44);
               this.i11 = 0;
               si8(this.i11,mstate.ebp + -38);
               this.i4 = li8(this.i4);
               si8(this.i4,mstate.ebp + -40);
               si8(this.i11,mstate.ebp + -39);
               this.i4 = li32(this.i2 + 20);
               si32(this.i4,mstate.ebp + -48);
               this.i4 = mstate.ebp + -48;
               si32(this.i4,this.i2 + 20);
               this.i4 = li32(this.i5);
               this.i11 = li8(this.i4 + 50);
               this.i11 += this.i8;
               si8(this.i11,this.i4 + 50);
               this.i11 = this.i4 + 50;
               if(this.i8 != 0)
               {
                  this.i12 = 0;
                  this.i13 = 0 - this.i8;
                  this.i14 = this.i4 + 24;
                  this.i15 = this.i4;
                  do
                  {
                     this.i16 = li8(this.i11);
                     this.i17 = this.i13 + this.i12;
                     this.i16 = this.i17 + this.i16;
                     this.i16 <<= 1;
                     this.i16 = this.i4 + this.i16;
                     this.i16 = li16(this.i16 + 172);
                     this.i17 = li32(this.i15);
                     this.i17 = li32(this.i17 + 24);
                     this.i18 = li32(this.i14);
                     this.i16 *= 12;
                     this.i16 = this.i17 + this.i16;
                     si32(this.i18,this.i16 + 4);
                     this.i12 += 1;
                  }
                  while(this.i12 != this.i8);
                  
               }
               this.i4 = -1;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_luaK_checkstack.start();
               return;
            case 5:
               mstate.esp += 8;
               this.i11 = li32(this.i2 + 36);
               this.i11 += this.i8;
               si32(this.i11,this.i2 + 36);
               this.i5 = li32(this.i5);
               si32(this.i4,mstate.ebp + -12);
               this.i4 = 0;
               si8(this.i4,mstate.ebp + -6);
               this.i11 = li8(this.i5 + 50);
               si8(this.i11,mstate.ebp + -8);
               si8(this.i4,mstate.ebp + -7);
               this.i4 = li32(this.i5 + 20);
               si32(this.i4,mstate.ebp + -16);
               this.i4 = mstate.ebp + -16;
               si32(this.i4,this.i5 + 20);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               FSM_chunk.start();
               return;
            case 6:
               mstate.esp += 4;
               mstate.esp -= 4;
               si32(this.i5,mstate.esp);
               state = 7;
               mstate.esp -= 4;
               FSM_leaveblock.start();
               return;
            case 7:
               mstate.esp += 4;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 8;
               mstate.esp -= 4;
               FSM_leaveblock.start();
               return;
            case 8:
               mstate.esp += 4;
               this.i1 = li32(this.i3);
               si32(this.i1,this.i2 + 28);
               mstate.esp -= 12;
               this.i1 = this.i2 + 32;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 9:
               mstate.esp += 12;
               this.i4 = li32(this.i2 + 12);
               this.i4 = li32(this.i4 + 8);
               this.i5 = this.i6 << 6;
               this.i6 = this.i2 + 12;
               this.i0 += 1;
               if(this.i9 != 0)
               {
                  mstate.esp -= 12;
                  this.i1 = this.i5 | 2147450911;
                  si32(this.i2,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i4,mstate.esp + 8);
                  state = 10;
                  mstate.esp -= 4;
                  FSM_luaK_code.start();
                  return;
               }
               this.i9 = -1;
               this.i8 <<= 14;
               this.i5 |= this.i8;
               mstate.esp -= 12;
               this.i5 |= 33;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
               break;
            case 10:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i4 = li32(this.i10);
               this.i3 = li32(this.i3);
               this.i4 = li32(this.i4 + 20);
               this.i3 <<= 2;
               this.i3 += this.i4;
               si32(this.i7,this.i3 + -4);
               break;
            case 11:
               mstate.esp += 12;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 12:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               this.i4 = li32(this.i10);
               this.i3 = li32(this.i3);
               this.i4 = li32(this.i4 + 20);
               this.i3 <<= 2;
               this.i3 += this.i4;
               si32(this.i7,this.i3 + -4);
               this.i3 = li32(this.i1);
               si32(this.i9,this.i1);
               this.i1 = li32(this.i6);
               this.i1 = li32(this.i1 + 8);
               mstate.esp -= 12;
               this.i4 = 2147450902;
               si32(this.i2,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 13:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,mstate.ebp + -20);
               mstate.esp -= 12;
               this.i1 = mstate.ebp + -20;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 14:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -20);
               break;
            default:
               throw "Invalid state in _forbody";
         }
         mstate.esp -= 12;
         si32(this.i2,mstate.esp);
         si32(this.i1,mstate.esp + 4);
         si32(this.i0,mstate.esp + 8);
         state = 11;
         mstate.esp -= 4;
         FSM_luaK_patchlist.start();
      }
   }
}
