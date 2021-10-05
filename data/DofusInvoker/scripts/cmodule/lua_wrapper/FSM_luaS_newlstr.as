package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaS_newlstr extends Machine
   {
      
      public static const intRegCount:int = 14;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
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
      
      public function FSM_luaS_newlstr()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaS_newlstr = null;
         _loc1_ = new FSM_luaS_newlstr();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop3:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = li32(mstate.ebp + 16);
               this.i1 = this.i0 >>> 5;
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = this.i1 + 1;
               this.i5 = this.i3;
               if(uint(this.i4) > uint(this.i0))
               {
                  this.i1 = this.i0;
               }
               else
               {
                  this.i6 = this.i1 ^ -1;
                  this.i1 += this.i6;
                  this.i1 = 0 - this.i1;
                  this.i7 = this.i0 + -1;
                  this.i8 = this.i0;
                  do
                  {
                     this.i9 = this.i5 + this.i7;
                     this.i10 = this.i8 >>> 2;
                     this.i11 = this.i8 << 5;
                     this.i9 = li8(this.i9);
                     this.i10 = this.i11 + this.i10;
                     this.i9 = this.i10 + this.i9;
                     this.i7 = this.i6 + this.i7;
                     this.i8 = this.i9 ^ this.i8;
                     this.i9 = this.i1 + this.i7;
                  }
                  while(uint(this.i9) >= uint(this.i4));
                  
                  this.i1 = this.i8;
               }
               this.i4 = li32(this.i2 + 16);
               this.i6 = li32(this.i4 + 8);
               this.i6 += -1;
               this.i6 &= this.i1;
               this.i7 = li32(this.i4);
               this.i6 <<= 2;
               this.i6 = this.i7 + this.i6;
               this.i6 = li32(this.i6);
               this.i7 = this.i2 + 16;
               if(this.i6 != 0)
               {
                  while(true)
                  {
                     this.i8 = li32(this.i6 + 12);
                     this.i9 = this.i6;
                     if(this.i8 == this.i0)
                     {
                        this.i8 = this.i6 + 16;
                        if(this.i0 == 0)
                        {
                           this.i0 = li8(this.i4 + 20);
                           this.i1 = li8(this.i6 + 5);
                           this.i0 ^= 3;
                           this.i6 += 5;
                           this.i0 &= this.i1;
                           this.i0 &= 3;
                        }
                        this.i10 = 0;
                        this.i11 = this.i0 + 1;
                        while(true)
                        {
                           this.i12 = this.i8 + this.i10;
                           this.i13 = this.i5 + this.i10;
                           this.i13 = li8(this.i13);
                           this.i12 = li8(this.i12);
                           if(this.i13 != this.i12)
                           {
                              break;
                           }
                           this.i11 += -1;
                           this.i10 += 1;
                           if(this.i11 != 1)
                           {
                              continue;
                           }
                        }
                        addr401:
                        this.i6 = li32(this.i6);
                        if(this.i6 == 0)
                        {
                           break;
                        }
                        continue;
                        if(this.i0 == 0)
                        {
                           this.i6 = this.i9;
                           addr832:
                           this.i0 = this.i6;
                           mstate.eax = this.i0;
                           break loop3;
                        }
                        this.i0 = this.i1 ^ 3;
                        si8(this.i0,this.i6);
                        mstate.eax = this.i9;
                        break loop3;
                     }
                     §§goto(addr401);
                  }
               }
               this.i6 = this.i0 + 1;
               if(uint(this.i6) >= uint(-18))
               {
                  this.i6 = __2E_str149;
                  mstate.esp -= 8;
                  si32(this.i2,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               §§goto(addr468);
               break;
            case 1:
               mstate.esp += 8;
               addr468:
               this.i6 = 0;
               this.i4 = li32(this.i7);
               this.i5 = li32(this.i4 + 12);
               this.i8 = li32(this.i4 + 16);
               mstate.esp -= 16;
               this.i9 = this.i0 + 17;
               si32(this.i8,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i9,mstate.esp + 12);
               state = 2;
               mstate.esp -= 4;
               mstate.funcs[this.i5]();
               return;
            case 2:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               if(this.i6 == 0)
               {
                  if(this.i9 != 0)
                  {
                     this.i5 = 4;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr607:
               this.i5 = 4;
               this.i8 = li32(this.i4 + 68);
               this.i8 = this.i9 + this.i8;
               si32(this.i8,this.i4 + 68);
               si32(this.i0,this.i6 + 12);
               si32(this.i1,this.i6 + 8);
               this.i4 = li32(this.i7);
               this.i4 = li8(this.i4 + 20);
               this.i4 &= 3;
               si8(this.i4,this.i6 + 5);
               si8(this.i5,this.i6 + 4);
               this.i4 = 0;
               si8(this.i4,this.i6 + 6);
               this.i5 = this.i6 + 16;
               this.i8 = this.i0;
               memcpy(this.i5,this.i3,this.i8);
               this.i0 += this.i6;
               si8(this.i4,this.i0 + 16);
               this.i0 = li32(this.i7);
               this.i3 = li32(this.i0 + 8);
               this.i3 += -1;
               this.i1 = this.i3 & this.i1;
               this.i3 = li32(this.i0);
               this.i1 <<= 2;
               this.i3 += this.i1;
               this.i3 = li32(this.i3);
               si32(this.i3,this.i6);
               this.i3 = li32(this.i0);
               this.i1 = this.i3 + this.i1;
               si32(this.i6,this.i1);
               this.i1 = li32(this.i0 + 4);
               this.i1 += 1;
               si32(this.i1,this.i0 + 4);
               this.i0 = li32(this.i0 + 8);
               if(uint(this.i1) > uint(this.i0))
               {
                  if(this.i0 < 1073741823)
                  {
                     mstate.esp -= 8;
                     this.i0 <<= 1;
                     si32(this.i2,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaS_resize.start();
                     return;
                  }
               }
               §§goto(addr832);
            case 3:
               mstate.esp += 8;
               §§goto(addr607);
            case 4:
               mstate.esp += 8;
               mstate.eax = this.i6;
               break;
            default:
               throw "Invalid state in _luaS_newlstr";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
