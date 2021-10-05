package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_luaO_pushvfstring extends Machine
   {
      
      public static const intRegCount:int = 17;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var f0:Number;
      
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
      
      public function FSM_luaO_pushvfstring()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaO_pushvfstring = null;
         _loc1_ = new FSM_luaO_pushvfstring();
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
               this.i0 = __2E_str45;
               this.i1 = li32(mstate.ebp + 16);
               si32(this.i1,mstate.ebp + -4);
               this.i1 = li32(mstate.ebp + 8);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               this.i0 = mstate.ebp + -48;
               state = 1;
               mstate.esp -= 4;
               FSM_pushstr.start();
               return;
            case 1:
               this.i2 = mstate.ebp + -6;
               mstate.esp += 8;
               this.i3 = this.i1 + 44;
               this.i4 = this.i0 + 2;
               this.i5 = this.i0 + 1;
               this.i6 = mstate.ebp + -32;
               this.i7 = this.i2 + 1;
               this.i8 = 1;
               this.i9 = this.i1 + 28;
               this.i10 = this.i1 + 8;
               this.i11 = li32(mstate.ebp + 12);
               addr154:
               this.i12 = li8(this.i11);
               this.i13 = this.i11;
               if(this.i12 != 37)
               {
                  this.i12 = this.i13;
                  while(true)
                  {
                     this.i13 = li8(this.i12);
                     if(this.i13 == 0)
                     {
                        this.i12 = 0;
                        break;
                     }
                     this.i13 = li8(this.i12 + 1);
                     this.i12 += 1;
                     this.i14 = this.i12;
                     if(this.i13 == 37)
                     {
                        break;
                     }
                     this.i12 = this.i14;
                  }
               }
               else
               {
                  this.i12 = this.i11;
               }
               if(this.i12 == 0)
               {
                  break;
               }
               this.i13 = 0;
               §§goto(addr1545);
               break;
            case 2:
               mstate.esp += 8;
               addr265:
               this.i11 = li32(this.i10);
               this.i14 = this.i11 + 12;
               si32(this.i14,this.i10);
               this.i14 = si8(li8(this.i12 + 1));
               this.i16 = this.i12 + 1;
               if(this.i14 <= 101)
               {
                  if(this.i14 == 37)
                  {
                     this.i11 = __2E_str453306;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 11;
                     mstate.esp -= 4;
                     FSM_pushstr.start();
                     return;
                  }
                  if(this.i14 == 99)
                  {
                     this.i11 = 0;
                     this.i16 = li32(mstate.ebp + -4);
                     this.i14 = this.i16 + 4;
                     si32(this.i14,mstate.ebp + -4);
                     this.i16 = li8(this.i16);
                     si8(this.i16,this.i2);
                     si8(this.i11,this.i7);
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_pushstr.start();
                     return;
                  }
                  if(this.i14 != 100)
                  {
                     §§goto(addr1206);
                  }
                  else
                  {
                     this.i16 = 3;
                     this.i14 = li32(mstate.ebp + -4);
                     this.i15 = this.i14 + 4;
                     si32(this.i15,mstate.ebp + -4);
                     this.i14 = li32(this.i14);
                     this.f0 = Number(this.i14);
                     sf64(this.f0,this.i11 + 12);
                     si32(this.i16,this.i11 + 20);
                     this.i11 = li32(this.i9);
                     this.i16 = li32(this.i10);
                     this.i13 <<= 1;
                     this.i8 = this.i13 + this.i8;
                     this.i11 -= this.i16;
                     if(this.i11 <= 12)
                     {
                        this.i11 = li32(this.i3);
                        if(this.i11 >= 1)
                        {
                           mstate.esp -= 8;
                           this.i11 <<= 1;
                           si32(this.i1,mstate.esp);
                           si32(this.i11,mstate.esp + 4);
                           state = 3;
                           mstate.esp -= 4;
                           FSM_luaD_reallocstack.start();
                           return;
                        }
                        mstate.esp -= 8;
                        this.i11 += 1;
                        si32(this.i1,mstate.esp);
                        si32(this.i11,mstate.esp + 4);
                        state = 6;
                        mstate.esp -= 4;
                        FSM_luaD_reallocstack.start();
                        return;
                     }
                     this.i11 = this.i16 + 12;
                     si32(this.i11,this.i10);
                     this.i11 = this.i8;
                  }
               }
               else
               {
                  if(this.i14 != 102)
                  {
                     if(this.i14 != 112)
                     {
                        if(this.i14 == 115)
                        {
                           this.i11 = __2E_str522;
                           this.i16 = li32(mstate.ebp + -4);
                           this.i14 = this.i16 + 4;
                           si32(this.i14,mstate.ebp + -4);
                           this.i16 = li32(this.i16);
                           mstate.esp -= 8;
                           this.i11 = this.i16 == 0 ? int(this.i11) : int(this.i16);
                           si32(this.i1,mstate.esp);
                           si32(this.i11,mstate.esp + 4);
                           state = 4;
                           mstate.esp -= 4;
                           FSM_pushstr.start();
                           return;
                        }
                        addr1206:
                        this.i11 = 37;
                        si8(this.i11,this.i0);
                        this.i11 = li8(this.i16);
                        si8(this.i11,this.i5);
                        this.i11 = 0;
                        si8(this.i11,this.i4);
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        state = 12;
                        mstate.esp -= 4;
                        FSM_pushstr.start();
                        return;
                     }
                     this.i11 = __2E_str352305;
                     this.i16 = li32(mstate.ebp + -4);
                     this.i14 = this.i16 + 4;
                     si32(this.i14,mstate.ebp + -4);
                     this.i16 = li32(this.i16);
                     mstate.esp -= 12;
                     si32(this.i6,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     si32(this.i16,mstate.esp + 8);
                     state = 9;
                     mstate.esp -= 4;
                     FSM_sprintf.start();
                     return;
                  }
                  this.i16 = 3;
                  this.i14 = li32(mstate.ebp + -4);
                  this.i15 = this.i14 + 8;
                  si32(this.i15,mstate.ebp + -4);
                  this.f0 = lf64(this.i14);
                  sf64(this.f0,this.i11 + 12);
                  si32(this.i16,this.i11 + 20);
                  this.i11 = li32(this.i9);
                  this.i16 = li32(this.i10);
                  this.i13 <<= 1;
                  this.i8 = this.i13 + this.i8;
                  this.i11 -= this.i16;
                  if(this.i11 <= 12)
                  {
                     this.i11 = li32(this.i3);
                     if(this.i11 >= 1)
                     {
                        mstate.esp -= 8;
                        this.i11 <<= 1;
                        si32(this.i1,mstate.esp);
                        si32(this.i11,mstate.esp + 4);
                        state = 7;
                        mstate.esp -= 4;
                        FSM_luaD_reallocstack.start();
                        return;
                     }
                     mstate.esp -= 8;
                     this.i11 += 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 8;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  this.i11 = this.i16 + 12;
                  si32(this.i11,this.i10);
                  this.i11 = this.i8;
               }
               addr1282:
               this.i8 = this.i11;
               this.i11 = this.i12 + 2;
               this.i8 += 2;
               §§goto(addr154);
            case 3:
               mstate.esp += 8;
               addr779:
               this.i11 = li32(this.i10);
               this.i11 += 12;
               si32(this.i11,this.i10);
               this.i11 = this.i8;
               §§goto(addr1282);
            case 4:
               mstate.esp += 8;
               this.i11 = li8(this.i12 + 2);
               this.i12 += 2;
               if(this.i11 != 37)
               {
                  this.i11 = this.i15;
                  while(true)
                  {
                     this.i16 = li8(this.i11 + 2);
                     if(this.i16 == 0)
                     {
                        this.i11 = 0;
                        break;
                     }
                     this.i16 = li8(this.i11 + 3);
                     this.i11 += 1;
                     if(this.i16 == 37)
                     {
                        this.i11 += 2;
                     }
                  }
               }
               else
               {
                  this.i11 = this.i12;
               }
               this.i16 = this.i11;
               this.i11 = this.i13 + 1;
               if(this.i16 != 0)
               {
                  this.i13 = this.i11;
                  this.i11 = this.i12;
                  this.i12 = this.i16;
                  addr1545:
                  this.i14 = 4;
                  this.i15 = li32(this.i10);
                  mstate.esp -= 12;
                  this.i16 = this.i12 - this.i11;
                  si32(this.i1,mstate.esp);
                  si32(this.i11,mstate.esp + 4);
                  si32(this.i16,mstate.esp + 8);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaS_newlstr.start();
                  return;
               }
               this.i11 <<= 1;
               this.i8 = this.i11 + this.i8;
               this.i11 = this.i12;
               break;
            case 5:
               this.i11 = this.i13 << 1;
               mstate.esp += 8;
               this.i11 += this.i8;
               §§goto(addr1282);
            case 6:
               mstate.esp += 8;
               §§goto(addr779);
            case 7:
               mstate.esp += 8;
               addr990:
               this.i11 = li32(this.i10);
               this.i11 += 12;
               si32(this.i11,this.i10);
               this.i11 = this.i8;
               §§goto(addr1282);
            case 8:
               mstate.esp += 8;
               §§goto(addr990);
            case 9:
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               state = 10;
               mstate.esp -= 4;
               FSM_pushstr.start();
               return;
            case 10:
               this.i11 = this.i13 << 1;
               mstate.esp += 8;
               this.i11 += this.i8;
               §§goto(addr1282);
            case 11:
               this.i11 = this.i13 << 1;
               mstate.esp += 8;
               this.i11 += this.i8;
               §§goto(addr1282);
            case 12:
               this.i11 = this.i13 << 1;
               mstate.esp += 8;
               this.i11 += this.i8;
               §§goto(addr1282);
            case 13:
               mstate.esp += 8;
               this.i2 = li32(this.i10);
               this.i3 = li32(this.i1 + 12);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i3 = this.i0 + 1;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 14:
               mstate.esp += 12;
               this.i1 = 0 - this.i0;
               this.i0 ^= -1;
               this.i2 = li32(this.i10);
               this.i1 *= 12;
               this.i0 *= 12;
               this.i1 = this.i2 + this.i1;
               si32(this.i1,this.i10);
               this.i0 = this.i2 + this.i0;
               this.i0 = li32(this.i0);
               this.i0 += 16;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 15:
               this.i11 = mstate.eax;
               mstate.esp += 12;
               si32(this.i11,this.i15);
               si32(this.i14,this.i15 + 8);
               this.i11 = li32(this.i9);
               this.i14 = li32(this.i10);
               this.i15 = this.i12;
               this.i11 -= this.i14;
               if(this.i11 <= 12)
               {
                  this.i11 = li32(this.i3);
                  if(this.i11 >= 1)
                  {
                     mstate.esp -= 8;
                     this.i11 <<= 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 16;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  mstate.esp -= 8;
                  this.i11 += 1;
                  si32(this.i1,mstate.esp);
                  si32(this.i11,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaD_reallocstack.start();
                  return;
               }
               addr264:
               §§goto(addr265);
               break;
            case 16:
               mstate.esp += 8;
               §§goto(addr264);
            default:
               throw "Invalid state in _luaO_pushvfstring";
         }
         this.i0 = this.i8;
         this.i2 = this.i11;
         mstate.esp -= 8;
         si32(this.i1,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         state = 13;
         mstate.esp -= 4;
         FSM_pushstr.start();
      }
   }
}
