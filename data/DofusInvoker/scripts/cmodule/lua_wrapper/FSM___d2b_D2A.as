package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___d2b_D2A extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
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
      
      public function FSM___d2b_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___d2b_D2A = null;
         _loc1_ = new FSM___d2b_D2A();
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
               this.i0 = li32(_freelist + 4);
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = li32(mstate.ebp + 20);
               if(this.i0 != 0)
               {
                  this.i5 = li32(this.i0);
                  si32(this.i5,_freelist + 4);
               }
               else
               {
                  this.i0 = _private_mem;
                  this.i5 = li32(_pmem_next);
                  this.i0 = this.i5 - this.i0;
                  this.i0 >>= 3;
                  this.i0 += 4;
                  if(uint(this.i0) > uint(288))
                  {
                     this.i0 = 32;
                     mstate.esp -= 4;
                     si32(this.i0,mstate.esp);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_malloc.start();
                     return;
                  }
                  this.i0 = 1;
                  this.i6 = this.i5 + 32;
                  si32(this.i6,_pmem_next);
                  si32(this.i0,this.i5 + 4);
                  this.i0 = 2;
                  si32(this.i0,this.i5 + 8);
                  this.i0 = this.i5;
               }
               §§goto(addr209);
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i5 = 1;
               si32(this.i5,this.i0 + 4);
               this.i5 = 2;
               si32(this.i5,this.i0 + 8);
               §§goto(addr209);
            case 3:
               §§goto(addr477);
            case 2:
               §§goto(addr321);
            default:
               throw "Invalid state in ___d2b_D2A";
         }
         this.i1 = this.i5;
         this.i5 = this.i6;
         this.i2 += this.i5;
         this.i2 += -1074;
         this.i5 = this.i1 << 2;
         si32(this.i2,this.i3);
         this.i2 = this.i5 + this.i0;
         this.i2 = li32(this.i2 + 16);
         this.i3 = uint(this.i2) < uint(65536) ? 16 : 0;
         this.i2 <<= this.i3;
         this.i5 = uint(this.i2) < uint(16777216) ? 8 : 0;
         this.i2 <<= this.i5;
         this.i6 = uint(this.i2) < uint(268435456) ? 4 : 0;
         this.i3 = this.i5 | this.i3;
         this.i2 <<= this.i6;
         this.i5 = uint(this.i2) < uint(1073741824) ? 2 : 0;
         this.i3 |= this.i6;
         this.i3 |= this.i5;
         this.i2 <<= this.i5;
         if(this.i2 <= -1)
         {
            this.i2 = this.i3;
         }
         else
         {
            this.i2 &= 1073741824;
            this.i3 += 1;
            this.i2 = this.i2 == 0 ? 32 : int(this.i3);
         }
         this.i1 <<= 5;
         this.i1 -= this.i2;
         si32(this.i1,this.i4);
         addr209:
         this.i5 = 0;
         this.i6 = this.i2 & 2147483647;
         si32(this.i5,this.i0 + 16);
         this.i7 = uint(this.i6) < uint(1048576) ? 0 : 1048576;
         this.i2 &= 1048575;
         si32(this.i5,this.i0 + 12);
         this.i2 |= this.i7;
         si32(this.i2,mstate.ebp + -4);
         si32(this.i1,mstate.ebp + -8);
         this.i2 = this.i6 >>> 20;
         this.i5 = this.i0 + 20;
         this.i7 = this.i0 + 16;
         if(this.i1 != 0)
         {
            this.i1 = mstate.ebp + -8;
            mstate.esp -= 4;
            si32(this.i1,mstate.esp);
            mstate.esp -= 4;
            FSM___lo0bits_D2A.start();
            addr321:
            this.i1 = mstate.eax;
            mstate.esp += 4;
            if(this.i1 != 0)
            {
               this.i8 = li32(mstate.ebp + -4);
               this.i9 = 32 - this.i1;
               this.i10 = li32(mstate.ebp + -8);
               this.i8 <<= this.i9;
               this.i8 |= this.i10;
               si32(this.i8,this.i5);
               this.i5 = li32(mstate.ebp + -4);
               this.i5 >>>= this.i1;
               si32(this.i5,mstate.ebp + -4);
            }
            else
            {
               this.i8 = li32(mstate.ebp + -8);
               si32(this.i8,this.i5);
            }
            this.i5 = li32(mstate.ebp + -4);
            si32(this.i5,this.i0 + 24);
            this.i5 = this.i5 == 0 ? 1 : 2;
            si32(this.i5,this.i7);
            if(uint(this.i6) < uint(1048576))
            {
               this.i6 = this.i1;
               break loop0;
            }
            this.i5 = this.i1;
         }
         else
         {
            this.i1 = mstate.ebp + -4;
            mstate.esp -= 4;
            si32(this.i1,mstate.esp);
            mstate.esp -= 4;
            FSM___lo0bits_D2A.start();
            addr477:
            this.i1 = mstate.eax;
            mstate.esp += 4;
            this.i8 = li32(mstate.ebp + -4);
            si32(this.i8,this.i5);
            this.i5 = 1;
            si32(this.i5,this.i7);
            this.i1 += 32;
            if(uint(this.i6) < uint(1048576))
            {
               this.i5 = 1;
               this.i6 = this.i1;
               break loop0;
            }
            this.i5 = this.i1;
         }
         this.i2 += this.i5;
         this.i2 += -1075;
         si32(this.i2,this.i3);
         this.i2 = 53 - this.i5;
         si32(this.i2,this.i4);
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
