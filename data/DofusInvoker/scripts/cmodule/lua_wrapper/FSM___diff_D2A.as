package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___diff_D2A extends Machine
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
      
      public function FSM___diff_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___diff_D2A = null;
         _loc1_ = new FSM___diff_D2A();
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
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(this.i0 + 16);
               this.i3 = li32(this.i1 + 16);
               this.i4 = this.i2 - this.i3;
               if(this.i2 != this.i3)
               {
                  this.i3 = this.i4;
               }
               else
               {
                  this.i2 = 0;
                  while(true)
                  {
                     this.i4 = this.i2 ^ -1;
                     this.i4 = this.i3 + this.i4;
                     this.i5 = this.i4 << 2;
                     this.i6 = this.i0 + this.i5;
                     this.i5 = this.i1 + this.i5;
                     this.i6 = li32(this.i6 + 20);
                     this.i5 = li32(this.i5 + 20);
                     if(this.i6 != this.i5)
                     {
                        this.i2 = uint(this.i6) < uint(this.i5) ? -1 : 1;
                        this.i3 = this.i2;
                        break;
                     }
                     this.i2 += 1;
                     if(this.i4 <= 0)
                     {
                        this.i2 = 0;
                        this.i3 = this.i2;
                        break;
                     }
                  }
               }
               this.i2 = this.i3;
               if(this.i2 == 0)
               {
                  this.i0 = li32(_freelist);
                  if(this.i0 != 0)
                  {
                     this.i1 = li32(this.i0);
                     si32(this.i1,_freelist);
                  }
                  else
                  {
                     this.i0 = _private_mem;
                     this.i1 = li32(_pmem_next);
                     this.i0 = this.i1 - this.i0;
                     this.i0 >>= 3;
                     this.i0 += 3;
                     if(uint(this.i0) > uint(288))
                     {
                        this.i0 = 24;
                        mstate.esp -= 4;
                        si32(this.i0,mstate.esp);
                        state = 1;
                        mstate.esp -= 4;
                        FSM_malloc.start();
                        return;
                     }
                     this.i0 = 0;
                     this.i2 = this.i1 + 24;
                     si32(this.i2,_pmem_next);
                     si32(this.i0,this.i1 + 4);
                     this.i0 = 1;
                     si32(this.i0,this.i1 + 8);
                     this.i0 = this.i1;
                  }
                  addr329:
                  this.i1 = 0;
                  si32(this.i1,this.i0 + 12);
                  this.i2 = 1;
                  si32(this.i2,this.i0 + 16);
                  si32(this.i1,this.i0 + 20);
                  mstate.eax = this.i0;
                  break;
               }
               this.i3 = 20;
               this.i4 = this.i2 < 0 ? int(this.i1) : int(this.i0);
               this.i5 = li32(this.i4 + 4);
               mstate.esp -= 4;
               si32(this.i5,mstate.esp);
               state = 2;
               mstate.esp -= 4;
               FSM___Balloc_D2A.start();
               return;
               break;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i1 = 0;
               si32(this.i1,this.i0 + 4);
               this.i1 = 1;
               si32(this.i1,this.i0 + 8);
               §§goto(addr329);
            case 2:
               this.i5 = mstate.eax;
               mstate.esp += 4;
               this.i6 = this.i2 >>> 31;
               si32(this.i6,this.i5 + 12);
               this.i0 = this.i2 < 0 ? int(this.i0) : int(this.i1);
               this.i1 = li32(this.i4 + 16);
               this.i2 = li32(this.i0 + 16);
               this.i6 = 0;
               this.i7 = this.i6;
               this.i8 = this.i6;
               this.i9 = this.i5;
               this.i10 = this.i4;
               while(true)
               {
                  this.i11 = 0;
                  this.i12 = this.i4 + this.i3;
                  this.i13 = this.i0 + this.i3;
                  this.i12 = li32(this.i12);
                  this.i13 = li32(this.i13);
                  this.i12 = __subc(this.i12,this.i13);
                  this.i13 = __sube(this.i11,this.i11);
                  this.i6 = __subc(this.i12,this.i6);
                  this.i7 = __sube(this.i13,this.i7);
                  this.i12 = this.i9 + this.i3;
                  si32(this.i6,this.i12);
                  this.i6 = this.i7 & 1;
                  this.i3 += 4;
                  this.i7 = this.i8 + 1;
                  if(this.i7 >= this.i2)
                  {
                     break;
                  }
                  this.i8 = this.i7;
                  this.i7 = this.i11;
               }
               this.i0 = this.i7 << 2;
               this.i0 = this.i5 + this.i0;
               this.i0 += 20;
               if(this.i7 >= this.i1)
               {
                  this.i11 = this.i0;
               }
               else
               {
                  this.i0 = 0;
                  while(true)
                  {
                     this.i2 = 0;
                     this.i3 = this.i7 + this.i0;
                     this.i3 <<= 2;
                     this.i4 = this.i10 + this.i3;
                     this.i4 = li32(this.i4 + 20);
                     this.i6 = __subc(this.i4,this.i6);
                     this.i11 = __sube(this.i2,this.i11);
                     this.i3 = this.i5 + this.i3;
                     this.i0 += 1;
                     si32(this.i6,this.i3 + 20);
                     this.i6 = this.i11 & 1;
                     this.i11 = this.i7 + this.i0;
                     if(this.i11 >= this.i1)
                     {
                        break;
                     }
                     this.i11 = this.i2;
                  }
                  this.i11 <<= 2;
                  this.i11 = this.i5 + this.i11;
                  this.i11 += 20;
               }
               this.i0 = li32(this.i11 + -4);
               if(this.i0 != 0)
               {
                  this.i11 = this.i1;
               }
               else
               {
                  this.i2 = -1;
                  this.i11 += -8;
                  this.i0 = this.i11;
                  this.i11 = this.i2;
                  do
                  {
                     this.i2 = li32(this.i0);
                     this.i0 += -4;
                     this.i11 += 1;
                  }
                  while(this.i2 == 0);
                  
                  this.i11 = this.i1 - this.i11;
                  this.i11 += -1;
               }
               this.i0 = this.i11;
               si32(this.i0,this.i5 + 16);
               mstate.eax = this.i5;
               break;
            default:
               throw "Invalid state in ___diff_D2A";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
