package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM___gdtoa extends Machine
   {
      
      public static const intRegCount:int = 32;
      
      public static const NumberRegCount:int = 4;
       
      
      public var i21:int;
      
      public var i30:int;
      
      public var i31:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var f3:Number;
      
      public var f2:Number;
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i17:int;
      
      public var i19:int;
      
      public var i16:int;
      
      public var i18:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i22:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public var i2:int;
      
      public var i23:int;
      
      public var i24:int;
      
      public var i25:int;
      
      public var i26:int;
      
      public var i27:int;
      
      public var i20:int;
      
      public var i9:int;
      
      public var i28:int;
      
      public var i29:int;
      
      public function FSM___gdtoa()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___gdtoa = null;
         _loc1_ = new FSM___gdtoa();
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
               mstate.esp -= 216;
               this.i0 = li32(mstate.ebp + 16);
               this.i1 = li32(this.i0);
               this.i2 = this.i1 & -49;
               this.i3 = li32(mstate.ebp + 8);
               this.i4 = li32(mstate.ebp + 12);
               si32(this.i2,this.i0);
               this.i1 &= 7;
               this.i2 = li32(mstate.ebp + 20);
               this.i5 = li32(mstate.ebp + 24);
               this.i6 = li32(mstate.ebp + 28);
               this.i7 = li32(mstate.ebp + 32);
               this.i8 = this.i4;
               if(this.i1 <= 2)
               {
                  if(this.i1 != 0)
                  {
                     this.i1 += -1;
                     if(uint(this.i1) < uint(2))
                     {
                        this.i1 = 32;
                        this.i9 = 0;
                        do
                        {
                           this.i9 += 1;
                           this.i1 <<= 1;
                        }
                        while(this.i1 <= 63);
                        
                        this.i1 = 0;
                        mstate.esp -= 4;
                        si32(this.i9,mstate.esp);
                        state = 3;
                        mstate.esp -= 4;
                        FSM___Balloc_D2A.start();
                        return;
                     }
                     addr9967:
                     this.i0 = 0;
                  }
                  else
                  {
                     this.i0 = 1;
                     si32(this.i0,this.i6);
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
                           state = 8;
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
                     addr1729:
                     this.i1 = 0;
                     si32(this.i1,this.i0 + 16);
                     si32(this.i1,this.i0 + 12);
                     si32(this.i1,this.i0);
                     this.i2 = 48;
                     si8(this.i2,this.i0 + 4);
                     si8(this.i1,this.i0 + 5);
                     this.i1 = this.i0 + 5;
                     this.i0 += 4;
                     if(this.i7 != 0)
                     {
                        addr1553:
                        si32(this.i1,this.i7);
                     }
                  }
                  addr1565:
                  mstate.eax = this.i0;
                  break;
               }
               if(this.i1 != 3)
               {
                  if(this.i1 != 4)
                  {
                     §§goto(addr9967);
                  }
                  else
                  {
                     this.i0 = -32768;
                     si32(this.i0,this.i6);
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
                           state = 2;
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
                     addr602:
                     this.i1 = 0;
                     si32(this.i1,this.i0 + 16);
                     si32(this.i1,this.i0 + 12);
                     si32(this.i1,this.i0);
                     this.i2 = 78;
                     si8(this.i2,this.i0 + 4);
                     this.i0 += 4;
                     this.i2 = __2E_str260;
                     this.i3 = this.i0;
                     do
                     {
                        this.i4 = this.i2 + this.i1;
                        this.i4 = li8(this.i4 + 1);
                        this.i5 = this.i0 + this.i1;
                        si8(this.i4,this.i5 + 1);
                        this.i1 += 1;
                     }
                     while(this.i4 != 0);
                     
                     if(this.i7 != 0)
                     {
                        addr450:
                        this.i0 += this.i1;
                        si32(this.i0,this.i7);
                     }
                  }
               }
               else
               {
                  this.i0 = -32768;
                  si32(this.i0,this.i6);
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
                  addr355:
                  this.i1 = 0;
                  si32(this.i1,this.i0 + 16);
                  si32(this.i1,this.i0 + 12);
                  si32(this.i1,this.i0);
                  this.i2 = 73;
                  si8(this.i2,this.i0 + 4);
                  this.i0 += 4;
                  this.i2 = __2E_str159;
                  this.i3 = this.i0;
                  do
                  {
                     this.i4 = this.i2 + this.i1;
                     this.i4 = li8(this.i4 + 1);
                     this.i5 = this.i0 + this.i1;
                     si8(this.i4,this.i5 + 1);
                     this.i1 += 1;
                  }
                  while(this.i4 != 0);
                  
                  if(this.i7 != 0)
                  {
                     §§goto(addr450);
                  }
               }
               mstate.eax = this.i3;
               break;
               §§goto(addr9967);
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i1 = 0;
               si32(this.i1,this.i0 + 4);
               this.i1 = 1;
               si32(this.i1,this.i0 + 8);
               §§goto(addr355);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i1 = 0;
               si32(this.i1,this.i0 + 4);
               this.i1 = 1;
               si32(this.i1,this.i0 + 8);
               §§goto(addr602);
            case 3:
               this.i9 = mstate.eax;
               mstate.esp += 4;
               this.i10 = this.i9 + 20;
               this.i11 = this.i9;
               this.i12 = this.i1;
               do
               {
                  this.i13 = this.i8 + this.i12;
                  this.i13 = li32(this.i13);
                  this.i14 = this.i9 + this.i12;
                  si32(this.i13,this.i14 + 20);
                  this.i12 += 4;
                  this.i1 += 1;
               }
               while(this.i1 <= 1);
               
               this.i1 <<= 2;
               this.i8 = this.i11 + 20;
               this.i1 = this.i8 + this.i1;
               this.i1 -= this.i10;
               this.i1 >>= 2;
               this.i10 = this.i1 + -1;
               this.i12 = this.i10 << 2;
               this.i8 += this.i12;
               this.i8 = li32(this.i8);
               if(this.i8 != 0)
               {
                  this.i9 = this.i10;
               }
               else
               {
                  this.i8 = this.i1 << 2;
                  this.i9 += this.i8;
                  this.i9 += 12;
                  while(true)
                  {
                     this.i8 = this.i9;
                     if(this.i1 == 1)
                     {
                        this.i1 = 0;
                        si32(this.i1,this.i11 + 16);
                        mstate.esp -= 4;
                        si32(this.i11,mstate.esp);
                        mstate.esp -= 4;
                        FSM___trailz_D2A.start();
                        addr920:
                        this.i1 = mstate.eax;
                        mstate.esp += 4;
                        si32(this.i1,mstate.ebp + -4);
                        if(this.i1 == 0)
                        {
                           this.i1 = 0;
                           this.i9 = this.i3;
                           break;
                        }
                        this.i9 = 0;
                     }
                     else
                     {
                        this.i8 = li32(this.i8);
                        this.i9 += -4;
                        this.i1 += -1;
                        if(this.i8 == 0)
                        {
                           continue;
                        }
                        addr984:
                        this.i9 = this.i1 + -1;
                        this.i8 = this.i9 << 2;
                        si32(this.i1,this.i11 + 16);
                        this.i1 = this.i11 + this.i8;
                        this.i1 = li32(this.i1 + 20);
                        this.i8 = uint(this.i1) < uint(65536) ? 16 : 0;
                        this.i1 <<= this.i8;
                        this.i10 = uint(this.i1) < uint(16777216) ? 8 : 0;
                        this.i1 <<= this.i10;
                        this.i12 = uint(this.i1) < uint(268435456) ? 4 : 0;
                        this.i8 = this.i10 | this.i8;
                        this.i1 <<= this.i12;
                        this.i10 = uint(this.i1) < uint(1073741824) ? 2 : 0;
                        this.i8 |= this.i12;
                        this.i8 |= this.i10;
                        this.i1 <<= this.i10;
                        if(this.i1 <= -1)
                        {
                           this.i1 = this.i8;
                        }
                        else
                        {
                           this.i1 &= 1073741824;
                           this.i8 += 1;
                           this.i1 = this.i1 == 0 ? 32 : int(this.i8);
                        }
                        mstate.esp -= 4;
                        si32(this.i11,mstate.esp);
                        mstate.esp -= 4;
                        FSM___trailz_D2A.start();
                        this.i8 = mstate.eax;
                        this.i9 <<= 5;
                        mstate.esp += 4;
                        this.i9 += 32;
                        si32(this.i8,mstate.ebp + -4);
                        this.i9 -= this.i1;
                        if(this.i8 == 0)
                        {
                           this.i1 = this.i9;
                           this.i9 = this.i3;
                           break;
                        }
                        this.i1 = this.i8;
                     }
                     mstate.esp -= 8;
                     si32(this.i11,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM___rshift_D2A.start();
                     addr1238:
                     mstate.esp += 8;
                     this.i1 = li32(mstate.ebp + -4);
                     this.i9 -= this.i1;
                     this.i8 = this.i1 + this.i3;
                     this.i1 = this.i9;
                     this.i9 = this.i8;
                     break;
                  }
                  this.i8 = this.i9;
                  this.i9 = li32(this.i11 + 16);
                  if(this.i9 == 0)
                  {
                     if(this.i11 != 0)
                     {
                        this.i0 = _freelist;
                        this.i1 = li32(this.i11 + 4);
                        this.i1 <<= 2;
                        this.i0 += this.i1;
                        this.i1 = li32(this.i0);
                        si32(this.i1,this.i11);
                        si32(this.i11,this.i0);
                     }
                     this.i0 = 1;
                     si32(this.i0,this.i6);
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
                           state = 7;
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
                     addr1495:
                     this.i1 = 0;
                     si32(this.i1,this.i0 + 16);
                     si32(this.i1,this.i0 + 12);
                     si32(this.i1,this.i0);
                     this.i2 = 48;
                     si8(this.i2,this.i0 + 4);
                     si8(this.i1,this.i0 + 5);
                     this.i1 = this.i0 + 5;
                     this.i0 += 4;
                     if(this.i7 != 0)
                     {
                        §§goto(addr1553);
                     }
                     §§goto(addr1565);
                  }
                  else
                  {
                     this.i9 = mstate.ebp + -4;
                     mstate.esp -= 8;
                     si32(this.i11,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM___b2d_D2A.start();
                     addr1819:
                     this.f0 = mstate.st0;
                     sf64(this.f0,mstate.ebp + -16);
                     this.i9 = li32(mstate.ebp + -12);
                     this.i9 |= 1072693248;
                     this.i10 = li32(mstate.ebp + -16);
                     this.i9 &= 1073741823;
                     si32(this.i10,mstate.ebp + -24);
                     si32(this.i9,mstate.ebp + -20);
                     this.i12 = this.i1 + this.i8;
                     this.i12 += -1;
                     this.f0 = lf64(mstate.ebp + -24);
                     this.f0 += -1.5;
                     this.i13 = this.i12 >> 31;
                     this.i14 = this.i12 + this.i13;
                     this.f1 = Number(this.i12);
                     this.f0 *= 0.28953;
                     mstate.esp += 8;
                     this.i13 = this.i14 ^ this.i13;
                     this.f1 *= 0.30103;
                     this.f0 += 0.176091;
                     si32(this.i12,mstate.ebp + -4);
                     this.i13 += -1077;
                     this.f0 += this.f1;
                     if(this.i13 > 0)
                     {
                        this.f1 = Number(this.i13);
                        this.f1 *= 7e-17;
                        this.f0 = this.f1 + this.f0;
                     }
                     this.f1 = 0;
                     this.i13 = int(this.f0);
                     if(this.f0 < this.f1)
                     {
                        this.f1 = Number(this.i13);
                        if(this.f1 != this.f0)
                        {
                           this.i13 += -1;
                        }
                        else
                        {
                           addr2008:
                        }
                        this.i14 = this.i8 + this.i1;
                        this.i14 <<= 20;
                        this.i9 = this.i14 + this.i9;
                        this.i9 += -1048576;
                        if(uint(this.i13) >= uint(23))
                        {
                           this.i14 = 1;
                        }
                        else
                        {
                           this.i14 = ___tens_D2A;
                           this.i15 = this.i13 << 3;
                           si32(this.i10,mstate.ebp + -32);
                           si32(this.i9,mstate.ebp + -28);
                           this.i14 += this.i15;
                           this.f0 = lf64(mstate.ebp + -32);
                           this.f1 = lf64(this.i14);
                           if(this.f0 >= this.f1)
                           {
                              this.i14 = 0;
                           }
                           else
                           {
                              this.i14 = 0;
                              this.i13 += -1;
                           }
                        }
                        this.i15 = this.i1 - this.i12;
                        this.i16 = this.i15 + -1;
                        this.i15 = 1 - this.i15;
                        this.i17 = this.i16 > -1 ? int(this.i16) : 0;
                        this.i15 = this.i16 > -1 ? 0 : int(this.i15);
                        if(this.i13 >= 0)
                        {
                           this.i16 = 0;
                           this.i17 += this.i13;
                           this.i18 = this.i13;
                        }
                        else
                        {
                           this.i16 = 0;
                           this.i19 = 0 - this.i13;
                           this.i15 -= this.i13;
                           this.i18 = this.i16;
                           this.i16 = this.i19;
                        }
                        this.i2 = uint(this.i2) > uint(9) ? 0 : int(this.i2);
                        this.i19 = this.i2 + -4;
                        this.i19 = this.i2 < 6 ? int(this.i2) : int(this.i19);
                        this.i2 = this.i2 < 6 ? 1 : 0;
                        this.i20 = this.i5 < 1 ? 1 : int(this.i5);
                        if(this.i19 <= 2)
                        {
                           if(uint(this.i19) >= uint(2))
                           {
                              if(this.i19 != 2)
                              {
                                 addr2289:
                                 this.i21 = 1;
                                 this.i22 = this.i20;
                                 this.i23 = this.i20;
                              }
                              else
                              {
                                 this.i5 = 0;
                                 si32(this.i20,mstate.ebp + -4);
                                 this.i12 = this.i20;
                                 this.i21 = this.i5;
                                 this.i22 = this.i20;
                                 this.i23 = this.i20;
                                 this.i5 = this.i20;
                              }
                           }
                           else
                           {
                              this.i5 = 22;
                              si32(this.i5,mstate.ebp + -4);
                              this.i20 = 0;
                              this.i23 = -1;
                              this.i21 = 1;
                              this.i12 = this.i5;
                              this.i22 = this.i23;
                              this.i5 = this.i20;
                           }
                        }
                        else
                        {
                           if(this.i19 != 3)
                           {
                              if(this.i19 != 4)
                              {
                                 if(this.i19 == 5)
                                 {
                                    this.i12 = 1;
                                 }
                                 else
                                 {
                                    §§goto(addr2289);
                                 }
                              }
                              else
                              {
                                 this.i5 = 1;
                                 si32(this.i20,mstate.ebp + -4);
                                 this.i12 = this.i20;
                                 this.i21 = this.i5;
                                 this.i22 = this.i20;
                                 this.i23 = this.i20;
                                 this.i5 = this.i20;
                              }
                              §§goto(addr2462);
                           }
                           else
                           {
                              this.i12 = 0;
                           }
                           this.i21 = this.i12;
                           this.i22 = this.i13 + this.i5;
                           this.i23 = this.i22 + 1;
                           si32(this.i23,mstate.ebp + -4);
                           if(this.i23 >= 1)
                           {
                              this.i12 = this.i23;
                           }
                           else
                           {
                              this.i12 = 1;
                              si32(this.i12,mstate.ebp + -4);
                           }
                        }
                        addr2462:
                        this.i20 = this.i21;
                        this.i21 = this.i22;
                        this.i22 = this.i23;
                        if(uint(this.i12) >= uint(20))
                        {
                           this.i23 = 4;
                           this.i24 = 0;
                           do
                           {
                              this.i23 <<= 1;
                              this.i24 += 1;
                              this.i25 = this.i23 + 16;
                           }
                           while(uint(this.i25) <= uint(this.i12));
                           
                           this.i12 = this.i24;
                        }
                        else
                        {
                           this.i12 = 0;
                        }
                        mstate.esp -= 4;
                        si32(this.i12,mstate.esp);
                        state = 10;
                        mstate.esp -= 4;
                        FSM___Balloc_D2A.start();
                        return;
                     }
                     §§goto(addr2008);
                  }
               }
               §§goto(addr984);
            case 5:
               §§goto(addr984);
            case 4:
               §§goto(addr920);
            case 6:
               §§goto(addr1238);
            case 9:
               §§goto(addr1819);
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i1 = 0;
               si32(this.i1,this.i0 + 4);
               this.i1 = 1;
               si32(this.i1,this.i0 + 8);
               §§goto(addr1495);
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i1 = 0;
               si32(this.i1,this.i0 + 4);
               this.i1 = 1;
               si32(this.i1,this.i0 + 8);
               §§goto(addr1729);
            case 10:
               this.i23 = mstate.eax;
               mstate.esp += 4;
               si32(this.i12,this.i23);
               this.i12 = this.i23 + 4;
               this.i2 ^= 1;
               this.i23 = this.i13 != 0 ? 1 : 0;
               this.i2 = this.i23 | this.i2;
               this.i23 = this.i12;
               this.i2 &= 1;
               if(this.i2 == 0)
               {
                  if(uint(this.i22) <= uint(14))
                  {
                     this.i2 = 0;
                     si32(this.i2,mstate.ebp + -4);
                     if(this.i13 >= 1)
                     {
                        this.i2 = ___tens_D2A;
                        this.i24 = this.i13 & 15;
                        this.i24 <<= 3;
                        this.i2 += this.i24;
                        this.f0 = lf64(this.i2);
                        this.i2 = this.i13 >> 4;
                        this.i24 = this.i2 & 16;
                        if(this.i24 == 0)
                        {
                           this.i24 = 2;
                           this.i25 = 0;
                           this.i26 = this.i10;
                           this.i27 = this.i9;
                           loop14:
                           while(true)
                           {
                              this.i28 = this.i27;
                              this.i29 = this.i24;
                              if(this.i2 != 0)
                              {
                                 addr2867:
                                 this.i27 = this.i25;
                                 this.i24 = this.i26;
                                 this.i25 = this.i28;
                                 this.i26 = this.i29;
                                 while(true)
                                 {
                                    this.i28 = this.i25;
                                    this.i25 = this.i26;
                                    this.i26 = this.i2 & 1;
                                    if(this.i26 != 0)
                                    {
                                       this.i26 = ___bigtens_D2A;
                                       this.i29 = this.i27 << 3;
                                       this.i26 += this.i29;
                                       this.f1 = lf64(this.i26);
                                       this.f0 = this.f1 * this.f0;
                                       this.i25 += 1;
                                    }
                                    this.i29 = this.i25;
                                    this.i25 = this.i27 + 1;
                                    si32(this.i25,mstate.ebp + -4);
                                    this.i2 >>= 1;
                                    this.i26 = this.i24;
                                    this.i27 = this.i28;
                                    this.i24 = this.i29;
                                    continue loop14;
                                    §§goto(addr2867);
                                 }
                                 addr2763:
                              }
                              this.i24 = this.i26;
                              this.i25 = this.i28;
                              this.i2 = this.i29;
                              break;
                           }
                        }
                        else
                        {
                           si32(this.i10,mstate.ebp + -40);
                           si32(this.i9,mstate.ebp + -36);
                           this.f1 = lf64(mstate.ebp + -40);
                           this.f1 /= 1e+256;
                           sf64(this.f1,mstate.ebp + -48);
                           this.i24 = li32(mstate.ebp + -48);
                           this.i25 = li32(mstate.ebp + -44);
                           this.i2 &= 15;
                           if(this.i2 != 0)
                           {
                              this.i26 = 3;
                              this.i27 = 0;
                              §§goto(addr2763);
                           }
                           else
                           {
                              this.i2 = 3;
                              addr3153:
                           }
                        }
                        addr3154:
                        if(this.i14 != 0)
                        {
                           this.f1 = 1;
                           si32(this.i24,mstate.ebp + -88);
                           si32(this.i25,mstate.ebp + -84);
                           this.f2 = lf64(mstate.ebp + -88);
                           if(this.f2 < this.f1)
                           {
                              if(this.i22 >= 1)
                              {
                                 if(this.i21 >= 1)
                                 {
                                    this.f1 = this.f2 * 10;
                                    sf64(this.f1,mstate.ebp + -96);
                                    this.i24 = li32(mstate.ebp + -96);
                                    this.i25 = li32(mstate.ebp + -92);
                                    this.i2 += 1;
                                    this.i26 = this.i13 + -1;
                                    this.i27 = this.i21;
                                 }
                                 addr4260:
                                 if(this.i13 <= 14)
                                 {
                                    if(this.i8 >= 0)
                                    {
                                       this.i1 = ___tens_D2A;
                                       this.i2 = this.i13 << 3;
                                       this.i1 += this.i2;
                                       this.f0 = lf64(this.i1);
                                       if(this.i5 <= -1)
                                       {
                                          if(this.i22 <= 0)
                                          {
                                             if(this.i22 >= 0)
                                             {
                                                si32(this.i10,mstate.ebp + -200);
                                                si32(this.i9,mstate.ebp + -196);
                                                this.f1 = lf64(mstate.ebp + -200);
                                                this.f0 *= 5;
                                                if(this.f1 > this.f0)
                                                {
                                                   this.i1 = 0;
                                                   this.i2 = this.i11;
                                                   this.i3 = this.i1;
                                                   this.i4 = this.i13;
                                                   addr3378:
                                                   this.i11 = this.i4;
                                                   this.i13 = 49;
                                                   si8(this.i13,this.i12);
                                                   this.i13 = 32;
                                                   this.i4 = 0;
                                                   this.i11 += 1;
                                                   this.i24 = this.i12 + 1;
                                                   addr9604:
                                                   this.i5 = this.i11;
                                                   this.i8 = this.i13;
                                                   if(this.i1 != 0)
                                                   {
                                                      this.i11 = _freelist;
                                                      this.i13 = li32(this.i1 + 4);
                                                      this.i13 <<= 2;
                                                      this.i11 += this.i13;
                                                      this.i13 = li32(this.i11);
                                                      si32(this.i13,this.i1);
                                                      si32(this.i1,this.i11);
                                                   }
                                                   if(this.i3 != 0)
                                                   {
                                                      this.i11 = this.i4;
                                                      this.i13 = this.i24;
                                                      this.i4 = this.i5;
                                                      this.i1 = this.i8;
                                                      addr9678:
                                                      this.i24 = this.i4;
                                                      if(this.i11 != this.i3)
                                                      {
                                                         if(this.i11 != 0)
                                                         {
                                                            this.i4 = _freelist;
                                                            this.i5 = li32(this.i11 + 4);
                                                            this.i5 <<= 2;
                                                            this.i4 += this.i5;
                                                            this.i5 = li32(this.i4);
                                                            si32(this.i5,this.i11);
                                                            si32(this.i11,this.i4);
                                                         }
                                                      }
                                                      if(this.i3 == 0)
                                                      {
                                                         this.i3 = this.i2;
                                                         this.i2 = this.i13;
                                                         addr9815:
                                                         this.i4 = this.i24;
                                                         if(this.i3 != 0)
                                                         {
                                                            this.i5 = _freelist;
                                                            this.i8 = li32(this.i3 + 4);
                                                            this.i8 <<= 2;
                                                            this.i5 += this.i8;
                                                            this.i8 = li32(this.i5);
                                                            si32(this.i8,this.i3);
                                                            si32(this.i3,this.i5);
                                                         }
                                                         this.i3 = 0;
                                                         si8(this.i3,this.i2);
                                                         this.i3 = this.i4 + 1;
                                                         si32(this.i3,this.i6);
                                                         if(this.i7 != 0)
                                                         {
                                                            addr9888:
                                                            si32(this.i2,this.i7);
                                                            this.i2 = li32(this.i0);
                                                            this.i2 |= this.i1;
                                                            si32(this.i2,this.i0);
                                                         }
                                                         else
                                                         {
                                                            this.i2 = this.i1;
                                                            addr9917:
                                                            this.i1 = this.i2;
                                                            this.i2 = li32(this.i0);
                                                            this.i1 = this.i2 | this.i1;
                                                            si32(this.i1,this.i0);
                                                         }
                                                         mstate.eax = this.i12;
                                                         break;
                                                      }
                                                      this.i11 = _freelist;
                                                      this.i4 = li32(this.i3 + 4);
                                                      this.i4 <<= 2;
                                                      this.i11 += this.i4;
                                                      this.i4 = li32(this.i11);
                                                      si32(this.i4,this.i3);
                                                      si32(this.i3,this.i11);
                                                      this.i3 = this.i2;
                                                      this.i2 = this.i13;
                                                      §§goto(addr9815);
                                                   }
                                                   else
                                                   {
                                                      this.i3 = this.i2;
                                                      this.i2 = this.i24;
                                                      this.i24 = this.i5;
                                                      this.i1 = this.i8;
                                                   }
                                                   §§goto(addr9815);
                                                   addr3377:
                                                }
                                                §§goto(addr9815);
                                             }
                                             addr3422:
                                             this.i1 = 0;
                                             this.i2 = this.i11;
                                             this.i3 = this.i1;
                                             addr7247:
                                             this.i4 = this.i5 ^ -1;
                                             if(this.i1 != 0)
                                             {
                                                this.i11 = _freelist;
                                                this.i13 = li32(this.i1 + 4);
                                                this.i13 <<= 2;
                                                this.i11 += this.i13;
                                                this.i13 = li32(this.i11);
                                                si32(this.i13,this.i1);
                                                si32(this.i1,this.i11);
                                             }
                                             if(this.i3 != 0)
                                             {
                                                this.i1 = 16;
                                                this.i11 = 0;
                                                this.i13 = this.i12;
                                                §§goto(addr9678);
                                             }
                                             else
                                             {
                                                this.i1 = 16;
                                                this.i3 = this.i2;
                                                this.i2 = this.i12;
                                                this.i24 = this.i4;
                                             }
                                          }
                                          else
                                          {
                                             addr4356:
                                             this.i1 = 1;
                                             si32(this.i1,mstate.ebp + -4);
                                             this.i1 = 0;
                                             this.i2 = this.i10;
                                             this.i3 = this.i9;
                                             while(true)
                                             {
                                                this.f1 = 0;
                                                si32(this.i2,mstate.ebp + -208);
                                                si32(this.i3,mstate.ebp + -204);
                                                this.f2 = lf64(mstate.ebp + -208);
                                                this.f3 = this.f2 / this.f0;
                                                this.i2 = int(this.f3);
                                                this.f3 = Number(this.i2);
                                                this.f3 *= this.f0;
                                                this.i3 = this.i2 + 48;
                                                this.i4 = this.i23 + this.i1;
                                                si8(this.i3,this.i4);
                                                this.i3 = this.i1 + 1;
                                                this.f2 -= this.f3;
                                                if(this.f2 != this.f1)
                                                {
                                                   this.i4 = li32(mstate.ebp + -4);
                                                   if(this.i4 != this.i22)
                                                   {
                                                      continue;
                                                   }
                                                   this.f2 += this.f2;
                                                   this.i1 = this.i12 + this.i3;
                                                   if(this.f2 > this.f0)
                                                   {
                                                      addr4502:
                                                      this.i2 = this.i1;
                                                      this.i1 = this.i13;
                                                      addr4566:
                                                      this.i3 = li8(this.i2 + -1);
                                                      this.i4 = this.i2 + -1;
                                                      this.i5 = this.i2;
                                                      if(this.i3 != 57)
                                                      {
                                                         this.i3 = this.i4;
                                                      }
                                                      else
                                                      {
                                                         this.i3 = 0;
                                                         this.i4 = this.i5;
                                                         this.i5 = this.i2;
                                                         while(true)
                                                         {
                                                            this.i8 = this.i3 ^ -1;
                                                            this.i8 = this.i2 + this.i8;
                                                            if(this.i8 == this.i12)
                                                            {
                                                               this.i3 = 48;
                                                               si8(this.i3,this.i8);
                                                               this.i1 += 1;
                                                               this.i2 = this.i5;
                                                               this.i3 = this.i8;
                                                               break;
                                                            }
                                                            this.i5 = li8(this.i4 + -2);
                                                            this.i4 += -1;
                                                            this.i3 += 1;
                                                            if(this.i5 != 57)
                                                            {
                                                               this.i3 = this.i4 + -1;
                                                               this.i2 = this.i8;
                                                            }
                                                            this.i5 = this.i8;
                                                         }
                                                      }
                                                      this.i4 = 32;
                                                      this.i5 = li8(this.i3);
                                                      this.i5 += 1;
                                                      si8(this.i5,this.i3);
                                                      this.i3 = this.i11;
                                                      this.i24 = this.i1;
                                                      this.i1 = this.i4;
                                                   }
                                                   else
                                                   {
                                                      if(this.f2 == this.f0)
                                                      {
                                                         this.i2 &= 1;
                                                         if(this.i2 != 0)
                                                         {
                                                            §§goto(addr4502);
                                                         }
                                                         §§goto(addr9815);
                                                      }
                                                      this.i4 = 16;
                                                      this.i3 = this.i11;
                                                      this.i2 = this.i1;
                                                      this.i24 = this.i13;
                                                      this.i1 = this.i4;
                                                   }
                                                }
                                                else
                                                {
                                                   this.i1 = 0;
                                                   this.i2 = this.i12 + this.i3;
                                                   this.i3 = this.i11;
                                                   this.i24 = this.i13;
                                                }
                                             }
                                          }
                                          §§goto(addr9815);
                                       }
                                       §§goto(addr4356);
                                    }
                                    else
                                    {
                                       addr4768:
                                       if(this.i20 == 0)
                                       {
                                          this.i2 = 0;
                                          this.i8 = this.i17;
                                          this.i17 = this.i18;
                                          this.i18 = this.i16;
                                          this.i24 = this.i15;
                                       }
                                       else
                                       {
                                          if(this.i19 <= 1)
                                          {
                                             this.i2 = 65 - this.i1;
                                             si32(this.i2,mstate.ebp + -4);
                                             this.i24 = 64 - this.i1;
                                             this.i24 = this.i8 - this.i24;
                                             if(this.i24 >= -16445)
                                             {
                                                this.i8 = this.i18;
                                                this.i18 = this.i16;
                                                this.i24 = this.i15;
                                                addr5215:
                                                this.i9 = this.i8;
                                                this.i8 = li32(_freelist + 4);
                                                this.i17 = this.i2 + this.i17;
                                                this.i15 = this.i2 + this.i15;
                                                if(this.i8 != 0)
                                                {
                                                   this.i2 = li32(this.i8);
                                                   si32(this.i2,_freelist + 4);
                                                   this.i2 = this.i8;
                                                }
                                                else
                                                {
                                                   this.i2 = _private_mem;
                                                   this.i8 = li32(_pmem_next);
                                                   this.i2 = this.i8 - this.i2;
                                                   this.i2 >>= 3;
                                                   this.i2 += 4;
                                                   if(uint(this.i2) > uint(288))
                                                   {
                                                      this.i2 = 32;
                                                      mstate.esp -= 4;
                                                      si32(this.i2,mstate.esp);
                                                      state = 12;
                                                      mstate.esp -= 4;
                                                      FSM_malloc.start();
                                                      return;
                                                   }
                                                   this.i2 = 1;
                                                   this.i10 = this.i8 + 32;
                                                   si32(this.i10,_pmem_next);
                                                   si32(this.i2,this.i8 + 4);
                                                   this.i2 = 2;
                                                   si32(this.i2,this.i8 + 8);
                                                   this.i2 = this.i8;
                                                }
                                                addr5392:
                                                this.i8 = 0;
                                                si32(this.i8,this.i2 + 12);
                                                this.i8 = 1;
                                                si32(this.i8,this.i2 + 20);
                                                si32(this.i8,this.i2 + 16);
                                                this.i8 = this.i17;
                                                this.i17 = this.i9;
                                                addr5427:
                                                this.i9 = this.i18;
                                                this.i10 = this.i24;
                                                this.i25 = this.i15;
                                                if(this.i10 >= 1)
                                                {
                                                   if(this.i8 > 0)
                                                   {
                                                      this.i18 = this.i17;
                                                      this.i17 = this.i9;
                                                      this.i15 = this.i10;
                                                      this.i24 = this.i2;
                                                      this.i2 = this.i25;
                                                      this.i9 = this.i8 <= this.i15 ? int(this.i8) : int(this.i15);
                                                      si32(this.i9,mstate.ebp + -4);
                                                      this.i8 -= this.i9;
                                                      this.i15 -= this.i9;
                                                      this.i2 -= this.i9;
                                                      addr5532:
                                                      this.i9 = this.i18;
                                                      this.i10 = this.i17;
                                                      if(this.i16 <= 0)
                                                      {
                                                         this.i10 = this.i11;
                                                      }
                                                      else
                                                      {
                                                         if(this.i20 == 0)
                                                         {
                                                            mstate.esp -= 8;
                                                            si32(this.i11,mstate.esp);
                                                            si32(this.i16,mstate.esp + 4);
                                                            state = 17;
                                                            mstate.esp -= 4;
                                                            FSM___pow5mult_D2A.start();
                                                            return;
                                                         }
                                                         if(this.i10 > 0)
                                                         {
                                                            mstate.esp -= 8;
                                                            si32(this.i24,mstate.esp);
                                                            si32(this.i10,mstate.esp + 4);
                                                            state = 13;
                                                            mstate.esp -= 4;
                                                            FSM___pow5mult_D2A.start();
                                                            return;
                                                         }
                                                         addr5697:
                                                         if(this.i16 != this.i10)
                                                         {
                                                            mstate.esp -= 8;
                                                            this.i10 = this.i16 - this.i10;
                                                            si32(this.i11,mstate.esp);
                                                            si32(this.i10,mstate.esp + 4);
                                                            state = 15;
                                                            mstate.esp -= 4;
                                                            FSM___pow5mult_D2A.start();
                                                            return;
                                                         }
                                                         this.i10 = this.i11;
                                                      }
                                                      addr5987:
                                                      this.i11 = this.i10;
                                                      this.i10 = li32(_freelist + 4);
                                                      if(this.i10 != 0)
                                                      {
                                                         this.i16 = li32(this.i10);
                                                         si32(this.i16,_freelist + 4);
                                                      }
                                                      else
                                                      {
                                                         this.i10 = _private_mem;
                                                         this.i16 = li32(_pmem_next);
                                                         this.i10 = this.i16 - this.i10;
                                                         this.i10 >>= 3;
                                                         this.i10 += 4;
                                                         if(uint(this.i10) > uint(288))
                                                         {
                                                            this.i10 = 32;
                                                            mstate.esp -= 4;
                                                            si32(this.i10,mstate.esp);
                                                            state = 18;
                                                            mstate.esp -= 4;
                                                            FSM_malloc.start();
                                                            return;
                                                         }
                                                         this.i10 = 1;
                                                         this.i17 = this.i16 + 32;
                                                         si32(this.i17,_pmem_next);
                                                         si32(this.i10,this.i16 + 4);
                                                         this.i10 = 2;
                                                         si32(this.i10,this.i16 + 8);
                                                         this.i10 = this.i16;
                                                      }
                                                      this.i16 = this.i10;
                                                      this.i10 = 0;
                                                      si32(this.i10,this.i16 + 12);
                                                      this.i10 = 1;
                                                      si32(this.i10,this.i16 + 20);
                                                      si32(this.i10,this.i16 + 16);
                                                      if(this.i9 <= 0)
                                                      {
                                                         this.i10 = this.i11;
                                                         this.i11 = this.i16;
                                                         this.i16 = this.i19 < 2 ? 1 : 0;
                                                         this.i1 = this.i1 == 1 ? 1 : 0;
                                                         this.i1 &= this.i16;
                                                         this.i3 = this.i3 > -16444 ? 1 : 0;
                                                         this.i1 &= this.i3;
                                                         this.i3 = this.i1 & 1;
                                                         this.i2 += this.i3;
                                                         this.i3 = this.i8 + this.i3;
                                                         §§goto(addr6240);
                                                      }
                                                      else
                                                      {
                                                         this.i10 = this.i11;
                                                         this.i11 = this.i16;
                                                         §§goto(addr6199);
                                                      }
                                                   }
                                                   §§goto(addr5532);
                                                }
                                                this.i18 = this.i17;
                                                this.i17 = this.i9;
                                                this.i24 = this.i2;
                                                this.i15 = this.i10;
                                                this.i2 = this.i25;
                                             }
                                             else
                                             {
                                                this.i2 = this.i8 + 16446;
                                                si32(this.i2,mstate.ebp + -4);
                                                this.i24 = li32(_freelist + 4);
                                                this.i8 = this.i2 + this.i17;
                                                this.i2 += this.i15;
                                                if(this.i24 != 0)
                                                {
                                                   this.i17 = li32(this.i24);
                                                   si32(this.i17,_freelist + 4);
                                                }
                                                else
                                                {
                                                   this.i24 = _private_mem;
                                                   this.i17 = li32(_pmem_next);
                                                   this.i24 = this.i17 - this.i24;
                                                   this.i24 >>= 3;
                                                   this.i24 += 4;
                                                   if(uint(this.i24) > uint(288))
                                                   {
                                                      this.i24 = 32;
                                                      mstate.esp -= 4;
                                                      si32(this.i24,mstate.esp);
                                                      state = 11;
                                                      mstate.esp -= 4;
                                                      FSM_malloc.start();
                                                      return;
                                                   }
                                                   this.i24 = 1;
                                                   this.i9 = this.i17 + 32;
                                                   si32(this.i9,_pmem_next);
                                                   si32(this.i24,this.i17 + 4);
                                                   this.i24 = 2;
                                                   si32(this.i24,this.i17 + 8);
                                                   this.i24 = this.i17;
                                                }
                                                addr5025:
                                                this.i17 = 0;
                                                si32(this.i17,this.i24 + 12);
                                                this.i17 = 1;
                                                si32(this.i17,this.i24 + 20);
                                                si32(this.i17,this.i24 + 16);
                                                if(this.i8 >= 1)
                                                {
                                                   if(this.i15 > 0)
                                                   {
                                                      this.i17 = this.i16;
                                                      §§goto(addr5490);
                                                   }
                                                   §§goto(addr5532);
                                                }
                                                this.i17 = this.i16;
                                             }
                                             §§goto(addr5532);
                                          }
                                          else
                                          {
                                             this.i9 = this.i22 + -1;
                                             if(this.i16 >= this.i9)
                                             {
                                                si32(this.i22,mstate.ebp + -4);
                                                this.i24 = this.i16 - this.i9;
                                                if(this.i22 >= 0)
                                                {
                                                   this.i2 = this.i22;
                                                   this.i8 = this.i18;
                                                   this.i18 = this.i24;
                                                   this.i24 = this.i15;
                                                   §§goto(addr5215);
                                                }
                                                else
                                                {
                                                   this.i2 = this.i18;
                                                   this.i18 = this.i24;
                                                }
                                             }
                                             else
                                             {
                                                this.i2 = this.i9 - this.i16;
                                                si32(this.i22,mstate.ebp + -4);
                                                this.i16 = this.i2 + this.i18;
                                                if(this.i22 >= 0)
                                                {
                                                   this.i18 = 0;
                                                   this.i2 = this.i22;
                                                   this.i8 = this.i16;
                                                   this.i24 = this.i15;
                                                   this.i16 = this.i9;
                                                   §§goto(addr5215);
                                                }
                                                else
                                                {
                                                   this.i18 = 0;
                                                   this.i2 = this.i16;
                                                   this.i16 = this.i9;
                                                }
                                             }
                                             §§goto(addr5215);
                                             this.i9 = this.i15 - this.i22;
                                             this.i8 = this.i24;
                                             this.i24 = this.i9;
                                          }
                                          §§goto(addr5215);
                                       }
                                       §§goto(addr5427);
                                    }
                                 }
                                 §§goto(addr4768);
                              }
                              else
                              {
                                 addr3162:
                                 this.i26 = this.i13;
                                 this.i27 = this.i22;
                                 addr3161:
                              }
                              si32(this.i24,mstate.ebp + -104);
                              si32(this.i25,mstate.ebp + -100);
                              this.f1 = lf64(mstate.ebp + -104);
                              this.f2 = Number(this.i2);
                              this.f2 *= this.f1;
                              this.f2 += 7;
                              sf64(this.f2,mstate.ebp + -112);
                              this.i2 = li32(mstate.ebp + -108);
                              this.i28 = li32(mstate.ebp + -112);
                              this.i2 += -54525952;
                              if(this.i27 == 0)
                              {
                                 si32(this.i28,mstate.ebp + -120);
                                 si32(this.i2,mstate.ebp + -116);
                                 this.f0 = lf64(mstate.ebp + -120);
                                 this.f1 += -5;
                                 if(this.f1 > this.f0)
                                 {
                                    this.i1 = 0;
                                    this.i2 = this.i11;
                                    this.i3 = this.i1;
                                    this.i4 = this.i26;
                                    §§goto(addr3378);
                                 }
                                 else
                                 {
                                    this.f0 = -this.f0;
                                    if(this.f1 < this.f0)
                                    {
                                       §§goto(addr3422);
                                    }
                                    else
                                    {
                                       §§goto(addr4260);
                                    }
                                 }
                                 §§goto(addr9815);
                              }
                              else
                              {
                                 if(this.i20 != 0)
                                 {
                                    this.i29 = ___tens_D2A;
                                    this.i30 = this.i27 << 3;
                                    si32(this.i28,mstate.ebp + -128);
                                    si32(this.i2,mstate.ebp + -124);
                                    this.i2 = this.i30 + this.i29;
                                    this.f1 = lf64(this.i2 + -8);
                                    this.f2 = this.f0 * 0.5;
                                    this.i2 = 0;
                                    this.f3 = lf64(mstate.ebp + -128);
                                    this.f1 = this.f2 / this.f1;
                                    si32(this.i2,mstate.ebp + -4);
                                    this.f1 -= this.f3;
                                    while(true)
                                    {
                                       si32(this.i24,mstate.ebp + -136);
                                       si32(this.i25,mstate.ebp + -132);
                                       this.f2 = lf64(mstate.ebp + -136);
                                       this.f3 = this.f2 / this.f0;
                                       this.i24 = int(this.f3);
                                       this.f3 = Number(this.i24);
                                       this.f3 *= this.f0;
                                       this.i24 += 48;
                                       this.i25 = this.i23 + this.i2;
                                       si8(this.i24,this.i25);
                                       this.i24 = this.i2 + 1;
                                       this.f2 -= this.f3;
                                       if(this.f2 < this.f1)
                                       {
                                          this.f1 = 0;
                                          this.i2 = this.i12 + this.i24;
                                          if(this.f2 == this.f1)
                                          {
                                             this.i1 = 0;
                                             this.i3 = this.i11;
                                             this.i24 = this.i26;
                                             break;
                                          }
                                          if(this.i11 != 0)
                                          {
                                             this.i1 = _freelist;
                                             this.i3 = li32(this.i11 + 4);
                                             this.i3 <<= 2;
                                             this.i1 += this.i3;
                                             this.i3 = li32(this.i1);
                                             si32(this.i3,this.i11);
                                             si32(this.i11,this.i1);
                                          }
                                          this.i1 = 0;
                                          si8(this.i1,this.i2);
                                          this.i1 = this.i26 + 1;
                                          si32(this.i1,this.i6);
                                          if(this.i7 != 0)
                                          {
                                             this.i1 = 16;
                                             §§goto(addr9888);
                                          }
                                          else
                                          {
                                             this.i2 = 16;
                                             §§goto(addr9917);
                                          }
                                       }
                                       else
                                       {
                                          this.f3 = this.f0 - this.f2;
                                          if(this.f3 >= this.f1)
                                          {
                                             this.i24 = li32(mstate.ebp + -4);
                                             this.i24 += 1;
                                             si32(this.i24,mstate.ebp + -4);
                                             if(this.i24 < this.i27)
                                             {
                                                continue;
                                             }
                                             §§goto(addr4260);
                                          }
                                          else
                                          {
                                             this.i1 = this.i12 + this.i24;
                                             this.i2 = this.i1;
                                             this.i1 = this.i26;
                                          }
                                          §§goto(addr4566);
                                       }
                                    }
                                    §§goto(addr9815);
                                 }
                                 else
                                 {
                                    this.i29 = ___tens_D2A;
                                    this.i30 = this.i27 << 3;
                                    si32(this.i28,mstate.ebp + -152);
                                    si32(this.i2,mstate.ebp + -148);
                                    this.i2 = this.i30 + this.i29;
                                    this.f1 /= this.f0;
                                    this.f2 = lf64(this.i2 + -8);
                                    this.f3 = lf64(mstate.ebp + -152);
                                    this.i2 = 1;
                                    si32(this.i2,mstate.ebp + -4);
                                    this.i2 = int(this.f1);
                                    this.f1 = this.f3 * this.f2;
                                    if(this.i2 != 0)
                                    {
                                       this.i28 = this.i12;
                                       while(true)
                                       {
                                          si32(this.i24,mstate.ebp + -160);
                                          si32(this.i25,mstate.ebp + -156);
                                          this.f2 = Number(this.i2);
                                          this.f3 = lf64(mstate.ebp + -160);
                                          this.f2 *= this.f0;
                                          this.f2 = this.f3 - this.f2;
                                          sf64(this.f2,mstate.ebp + -168);
                                          this.i24 = li32(mstate.ebp + -168);
                                          this.i25 = li32(mstate.ebp + -164);
                                          addr3870:
                                          this.i2 = this.i28 + this.i2;
                                          this.i28 = this.i2;
                                          this.i2 = this.i29;
                                       }
                                       addr3886:
                                    }
                                    else
                                    {
                                       this.i28 = this.i12;
                                    }
                                    while(true)
                                    {
                                       this.i29 = 0;
                                       this.i30 = this.i28;
                                       this.i31 = this.i29;
                                       while(true)
                                       {
                                          this.i29 = this.i31;
                                          this.i2 += 48;
                                          this.i31 = this.i30 + this.i29;
                                          si8(this.i2,this.i31);
                                          this.i2 = li32(mstate.ebp + -4);
                                          this.i31 = this.i29 + 1;
                                          if(this.i2 == this.i27)
                                          {
                                             break;
                                          }
                                          si32(this.i24,mstate.ebp + -184);
                                          si32(this.i25,mstate.ebp + -180);
                                          this.f2 = lf64(mstate.ebp + -184);
                                          this.f2 *= 10;
                                          sf64(this.f2,mstate.ebp + -192);
                                          this.f2 /= this.f0;
                                          this.i2 += 1;
                                          si32(this.i2,mstate.ebp + -4);
                                          this.i24 = li32(mstate.ebp + -192);
                                          this.i25 = li32(mstate.ebp + -188);
                                          this.i2 = this.i29 + 1;
                                          this.i29 = int(this.f2);
                                          if(this.i29 == 0)
                                          {
                                             continue;
                                          }
                                          §§goto(addr3870);
                                       }
                                       si32(this.i24,mstate.ebp + -176);
                                       si32(this.i25,mstate.ebp + -172);
                                       this.f2 = lf64(mstate.ebp + -176);
                                       this.f0 *= 0.5;
                                       this.i2 = this.i28 + this.i31;
                                       this.f3 = this.f1 + this.f0;
                                       if(this.f2 > this.f3)
                                       {
                                          this.i1 = this.i26;
                                          §§goto(addr4502);
                                       }
                                       else
                                       {
                                          this.f0 -= this.f1;
                                          if(this.f2 < this.f0)
                                          {
                                             this.i2 = 0;
                                             do
                                             {
                                                this.i1 = this.i2 ^ -1;
                                                this.i1 = this.i31 + this.i1;
                                                this.i1 = this.i28 + this.i1;
                                                this.i1 = li8(this.i1);
                                                this.i2 += 1;
                                             }
                                             while(this.i1 == 48);
                                             
                                             this.f0 = 0;
                                             this.i2 += -1;
                                             this.i2 = this.i31 - this.i2;
                                             this.i2 = this.i28 + this.i2;
                                             if(this.f2 == this.f0)
                                             {
                                                this.i1 = 0;
                                                this.i3 = this.i11;
                                                this.i24 = this.i26;
                                             }
                                             else
                                             {
                                                this.i1 = 16;
                                                this.i3 = this.i11;
                                                this.i24 = this.i26;
                                             }
                                          }
                                          else
                                          {
                                             §§goto(addr4260);
                                          }
                                       }
                                       §§goto(addr9815);
                                       §§goto(addr3886);
                                    }
                                 }
                                 §§goto(addr4260);
                              }
                           }
                           §§goto(addr3161);
                        }
                        §§goto(addr3162);
                     }
                     else
                     {
                        this.i2 = 0 - this.i13;
                        if(this.i13 == 0)
                        {
                           this.f0 = 1;
                           this.i2 = 2;
                           this.i24 = this.i10;
                           this.i25 = this.i9;
                        }
                        else
                        {
                           this.i24 = ___tens_D2A;
                           this.i25 = this.i2 & 15;
                           this.i25 <<= 3;
                           si32(this.i10,mstate.ebp + -56);
                           si32(this.i9,mstate.ebp + -52);
                           this.i24 += this.i25;
                           this.f0 = lf64(this.i24);
                           this.f1 = lf64(mstate.ebp + -56);
                           this.f0 = this.f1 * this.f0;
                           sf64(this.f0,mstate.ebp + -64);
                           this.i24 = li32(mstate.ebp + -64);
                           this.i25 = li32(mstate.ebp + -60);
                           this.i26 = this.i2 >> 4;
                           if(uint(this.i2) >= uint(16))
                           {
                              this.i2 = ___bigtens_D2A;
                              this.i27 = 2;
                              this.i28 = 0;
                              while(true)
                              {
                                 this.i29 = this.i2;
                                 this.i30 = this.i26 & 1;
                                 if(this.i30 != 0)
                                 {
                                    si32(this.i24,mstate.ebp + -72);
                                    si32(this.i25,mstate.ebp + -68);
                                    this.f0 = lf64(this.i29);
                                    this.f1 = lf64(mstate.ebp + -72);
                                    this.f0 = this.f1 * this.f0;
                                    sf64(this.f0,mstate.ebp + -80);
                                    this.i24 = li32(mstate.ebp + -80);
                                    this.i25 = li32(mstate.ebp + -76);
                                    this.i27 += 1;
                                 }
                                 this.i2 += 8;
                                 this.i28 += 1;
                                 this.i29 = this.i26 >> 1;
                                 if(uint(this.i26) < uint(2))
                                 {
                                    break;
                                 }
                                 this.i26 = this.i29;
                              }
                              this.f0 = 1;
                              si32(this.i28,mstate.ebp + -4);
                              this.i2 = this.i27;
                           }
                           else
                           {
                              this.f0 = 1;
                              this.i2 = 2;
                              §§goto(addr3153);
                           }
                        }
                        §§goto(addr3154);
                     }
                  }
               }
               §§goto(addr4260);
            case 11:
               this.i24 = mstate.eax;
               mstate.esp += 4;
               this.i17 = 1;
               si32(this.i17,this.i24 + 4);
               this.i17 = 2;
               si32(this.i17,this.i24 + 8);
               §§goto(addr5025);
            case 12:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i8 = 1;
               si32(this.i8,this.i2 + 4);
               this.i8 = 2;
               si32(this.i8,this.i2 + 8);
               §§goto(addr5392);
            case 14:
               this.i17 = mstate.eax;
               mstate.esp += 8;
               if(this.i11 == 0)
               {
                  this.i11 = this.i17;
               }
               else
               {
                  this.i18 = _freelist;
                  this.i25 = li32(this.i11 + 4);
                  this.i25 <<= 2;
                  this.i18 += this.i25;
                  this.i25 = li32(this.i18);
                  si32(this.i25,this.i11);
                  si32(this.i11,this.i18);
                  this.i11 = this.i17;
               }
               §§goto(addr5697);
            case 15:
               this.i10 = mstate.eax;
               mstate.esp += 8;
               this.i11 = li32(_freelist + 4);
               if(this.i11 != 0)
               {
                  this.i16 = li32(this.i11);
                  si32(this.i16,_freelist + 4);
               }
               else
               {
                  this.i11 = _private_mem;
                  this.i16 = li32(_pmem_next);
                  this.i11 = this.i16 - this.i11;
                  this.i11 >>= 3;
                  this.i11 += 4;
                  if(uint(this.i11) > uint(288))
                  {
                     this.i11 = 32;
                     mstate.esp -= 4;
                     si32(this.i11,mstate.esp);
                     state = 16;
                     mstate.esp -= 4;
                     FSM_malloc.start();
                     return;
                  }
                  this.i11 = 1;
                  this.i17 = this.i16 + 32;
                  si32(this.i17,_pmem_next);
                  si32(this.i11,this.i16 + 4);
                  this.i11 = 2;
                  si32(this.i11,this.i16 + 8);
                  this.i11 = this.i16;
               }
               addr5912:
               this.i16 = 0;
               si32(this.i16,this.i11 + 12);
               this.i16 = 1;
               si32(this.i16,this.i11 + 20);
               si32(this.i16,this.i11 + 16);
               if(this.i9 > 0)
               {
                  addr6199:
                  mstate.esp -= 8;
                  si32(this.i11,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  state = 19;
                  mstate.esp -= 4;
                  FSM___pow5mult_D2A.start();
                  return;
               }
               §§goto(addr6240);
               break;
            case 16:
               this.i11 = mstate.eax;
               mstate.esp += 4;
               this.i16 = 1;
               si32(this.i16,this.i11 + 4);
               this.i16 = 2;
               si32(this.i16,this.i11 + 8);
               §§goto(addr5912);
            case 17:
               this.i10 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr5987);
            case 18:
               this.i10 = mstate.eax;
               mstate.esp += 4;
               this.i16 = 1;
               si32(this.i16,this.i10 + 4);
               this.i16 = 2;
               si32(this.i16,this.i10 + 8);
               §§goto(addr5532);
            case 19:
               this.i11 = mstate.eax;
               mstate.esp += 8;
               addr6240:
               if(this.i9 == 0)
               {
                  this.i8 = 1;
               }
               else
               {
                  this.i8 = li32(this.i11 + 16);
                  this.i8 <<= 2;
                  this.i8 += this.i11;
                  this.i8 = li32(this.i8 + 16);
                  this.i9 = uint(this.i8) < uint(65536) ? 16 : 0;
                  this.i8 <<= this.i9;
                  this.i16 = uint(this.i8) < uint(16777216) ? 8 : 0;
                  this.i8 <<= this.i16;
                  this.i17 = uint(this.i8) < uint(268435456) ? 4 : 0;
                  this.i9 = this.i16 | this.i9;
                  this.i8 <<= this.i17;
                  this.i16 = uint(this.i8) < uint(1073741824) ? 2 : 0;
                  this.i9 |= this.i17;
                  this.i9 |= this.i16;
                  this.i8 <<= this.i16;
                  if(this.i8 <= -1)
                  {
                     this.i8 = this.i9;
                  }
                  else
                  {
                     this.i8 &= 1073741824;
                     this.i9 += 1;
                     this.i8 = this.i8 == 0 ? 32 : int(this.i9);
                  }
                  this.i8 = 32 - this.i8;
               }
               this.i8 += this.i3;
               this.i8 &= 31;
               this.i9 = 32 - this.i8;
               this.i8 = this.i8 == 0 ? int(this.i8) : int(this.i9);
               si32(this.i8,mstate.ebp + -4);
               if(this.i8 >= 5)
               {
                  this.i8 += -4;
                  si32(this.i8,mstate.ebp + -4);
                  this.i3 = this.i8 + this.i3;
                  this.i15 = this.i8 + this.i15;
                  this.i2 = this.i8 + this.i2;
                  if(this.i2 <= 0)
                  {
                     this.i2 = this.i3;
                     this.i3 = this.i15;
                     this.i15 = this.i10;
                     addr6689:
                     this.i8 = this.i15;
                     if(this.i2 > 0)
                     {
                        mstate.esp -= 8;
                        si32(this.i11,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        state = 21;
                        mstate.esp -= 4;
                        FSM___lshift_D2A.start();
                        return;
                     }
                     this.i2 = this.i11;
                     addr6744:
                     this.i11 = this.i2;
                     if(this.i14 != 0)
                     {
                        this.i2 = li32(this.i8 + 16);
                        this.i9 = li32(this.i11 + 16);
                        this.i10 = this.i2 - this.i9;
                        if(this.i2 != this.i9)
                        {
                           this.i2 = this.i10;
                        }
                        else
                        {
                           this.i2 = 0;
                           while(true)
                           {
                              this.i10 = this.i2 ^ -1;
                              this.i10 = this.i9 + this.i10;
                              this.i14 = this.i10 << 2;
                              this.i15 = this.i8 + this.i14;
                              this.i14 = this.i11 + this.i14;
                              this.i15 = li32(this.i15 + 20);
                              this.i14 = li32(this.i14 + 20);
                              if(this.i15 != this.i14)
                              {
                                 this.i2 = uint(this.i15) < uint(this.i14) ? -1 : 1;
                                 break;
                              }
                              this.i2 += 1;
                              if(this.i10 <= 0)
                              {
                                 this.i2 = 0;
                                 break;
                              }
                           }
                        }
                        if(this.i2 <= -1)
                        {
                           this.i2 = 10;
                           mstate.esp -= 12;
                           this.i9 = 0;
                           si32(this.i8,mstate.esp);
                           si32(this.i2,mstate.esp + 4);
                           si32(this.i9,mstate.esp + 8);
                           state = 22;
                           mstate.esp -= 4;
                           FSM___multadd_D2A.start();
                           return;
                        }
                     }
                     this.i2 = this.i8;
                     this.i8 = this.i13;
                     this.i13 = this.i22;
                     addr7031:
                     if(this.i13 <= 0)
                     {
                        if(this.i19 >= 3)
                        {
                           if(this.i13 > -1)
                           {
                              this.i1 = 0;
                              mstate.esp -= 12;
                              this.i3 = 5;
                              si32(this.i11,mstate.esp);
                              si32(this.i3,mstate.esp + 4);
                              si32(this.i1,mstate.esp + 8);
                              state = 24;
                              mstate.esp -= 4;
                              FSM___multadd_D2A.start();
                              return;
                           }
                           this.i3 = this.i24;
                           this.i1 = this.i11;
                           §§goto(addr7247);
                        }
                     }
                     if(this.i20 == 0)
                     {
                        this.i1 = 1;
                        si32(this.i1,mstate.ebp + -4);
                        mstate.esp -= 8;
                        si32(this.i2,mstate.esp);
                        si32(this.i11,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM___quorem_D2A.start();
                        addr7372:
                        this.i1 = mstate.eax;
                        mstate.esp += 8;
                        this.i1 += 48;
                        si8(this.i1,this.i12);
                        this.i3 = li32(mstate.ebp + -4);
                        this.i4 = this.i12 + 1;
                        if(this.i3 >= this.i13)
                        {
                           this.i3 = 0;
                           this.i13 = this.i4;
                           this.i4 = this.i24;
                           §§goto(addr9173);
                        }
                        else
                        {
                           this.i1 = 0;
                           §§goto(addr8972);
                        }
                     }
                     else
                     {
                        if(this.i3 > 0)
                        {
                           mstate.esp -= 8;
                           si32(this.i24,mstate.esp);
                           si32(this.i3,mstate.esp + 4);
                           state = 26;
                           mstate.esp -= 4;
                           FSM___lshift_D2A.start();
                           return;
                        }
                        this.i3 = this.i24;
                        addr7475:
                        this.i1 &= 1;
                        if(this.i1 != 0)
                        {
                           this.i1 = 1;
                           this.i24 = li32(this.i3 + 4);
                           mstate.esp -= 4;
                           si32(this.i24,mstate.esp);
                           state = 27;
                           mstate.esp -= 4;
                           FSM___Balloc_D2A.start();
                           return;
                        }
                        this.i1 = this.i3;
                        §§goto(addr7616);
                     }
                  }
               }
               else
               {
                  if(this.i8 < 4)
                  {
                     this.i8 += 28;
                     si32(this.i8,mstate.ebp + -4);
                     this.i3 = this.i8 + this.i3;
                     this.i15 = this.i8 + this.i15;
                     this.i2 = this.i8 + this.i2;
                  }
                  if(this.i2 <= 0)
                  {
                     this.i2 = this.i3;
                     this.i3 = this.i15;
                     this.i15 = this.i10;
                     §§goto(addr6689);
                  }
               }
               mstate.esp -= 8;
               si32(this.i10,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 20;
               mstate.esp -= 4;
               FSM___lshift_D2A.start();
               return;
            case 20:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i2 = this.i3;
               this.i3 = this.i15;
               this.i15 = this.i8;
               §§goto(addr6689);
            case 21:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr6744);
            case 22:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i13 += -1;
               if(this.i20 != 0)
               {
                  this.i8 = 0;
                  mstate.esp -= 12;
                  this.i9 = 10;
                  si32(this.i24,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i8,mstate.esp + 8);
                  state = 23;
                  mstate.esp -= 4;
                  FSM___multadd_D2A.start();
                  return;
               }
               this.i8 = this.i13;
               this.i13 = this.i21;
               §§goto(addr7031);
               break;
            case 23:
               this.i24 = mstate.eax;
               mstate.esp += 12;
               this.i8 = this.i13;
               this.i13 = this.i21;
               §§goto(addr6744);
            case 25:
               §§goto(addr7372);
            case 26:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr7475);
            case 28:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               addr7616:
               this.i24 = 1;
               this.i5 = 0;
               §§goto(addr7624);
            case 33:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i3 = this.i1;
               §§goto(addr8946);
            case 35:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               addr8946:
               this.i24 = li32(mstate.ebp + -4);
               this.i5 += 1;
               this.i24 += 1;
               addr7624:
               this.i9 = this.i1;
               si32(this.i24,mstate.ebp + -4);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               mstate.esp -= 4;
               FSM___quorem_D2A.start();
               §§goto(addr7662);
            case 29:
               addr7662:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i24 = li32(this.i2 + 16);
               this.i10 = li32(this.i3 + 16);
               this.i14 = this.i24 - this.i10;
               this.i15 = this.i2 + 16;
               this.i16 = this.i1 + 48;
               this.i17 = this.i23 + this.i5;
               if(this.i24 != this.i10)
               {
                  this.i24 = this.i14;
               }
               else
               {
                  this.i24 = 0;
                  while(true)
                  {
                     this.i14 = this.i24 ^ -1;
                     this.i14 = this.i10 + this.i14;
                     this.i18 = this.i14 << 2;
                     this.i20 = this.i2 + this.i18;
                     this.i18 = this.i3 + this.i18;
                     this.i20 = li32(this.i20 + 20);
                     this.i18 = li32(this.i18 + 20);
                     if(this.i20 != this.i18)
                     {
                        this.i24 = uint(this.i20) < uint(this.i18) ? -1 : 1;
                        break;
                     }
                     this.i24 += 1;
                     if(this.i14 <= 0)
                     {
                        this.i24 = 0;
                        break;
                     }
                  }
               }
               mstate.esp -= 8;
               si32(this.i11,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               state = 30;
               mstate.esp -= 4;
               FSM___diff_D2A.start();
               return;
            case 13:
               this.i24 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               si32(this.i24,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               state = 14;
               mstate.esp -= 4;
               FSM___mult_D2A.start();
               return;
            case 24:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(this.i2 + 16);
               this.i4 = li32(this.i1 + 16);
               this.i11 = this.i3 - this.i4;
               if(this.i3 != this.i4)
               {
                  this.i3 = this.i11;
               }
               else
               {
                  this.i3 = 0;
                  while(true)
                  {
                     this.i11 = this.i3 ^ -1;
                     this.i11 = this.i4 + this.i11;
                     this.i13 = this.i11 << 2;
                     this.i19 = this.i2 + this.i13;
                     this.i13 = this.i1 + this.i13;
                     this.i19 = li32(this.i19 + 20);
                     this.i13 = li32(this.i13 + 20);
                     if(this.i19 != this.i13)
                     {
                        this.i3 = uint(this.i19) < uint(this.i13) ? -1 : 1;
                        break;
                     }
                     this.i3 += 1;
                     if(this.i11 <= 0)
                     {
                        this.i3 = 0;
                        break;
                     }
                  }
               }
               if(this.i3 >= 1)
               {
                  this.i3 = this.i24;
                  this.i4 = this.i8;
                  §§goto(addr3377);
               }
               else
               {
                  this.i3 = this.i24;
                  §§goto(addr3422);
               }
            case 27:
               this.i24 = mstate.eax;
               mstate.esp += 4;
               this.i5 = li32(this.i3 + 16);
               this.i9 = this.i24 + 12;
               this.i5 <<= 2;
               this.i10 = this.i3 + 12;
               this.i5 += 8;
               memcpy(this.i9,this.i10,this.i5);
               mstate.esp -= 8;
               si32(this.i24,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 28;
               mstate.esp -= 4;
               FSM___lshift_D2A.start();
               return;
            case 30:
               this.i10 = mstate.eax;
               mstate.esp += 8;
               this.i14 = li32(this.i10 + 12);
               if(this.i14 != 0)
               {
                  this.i14 = 1;
               }
               else
               {
                  this.i14 = li32(this.i15);
                  this.i18 = li32(this.i10 + 16);
                  this.i20 = this.i14 - this.i18;
                  if(this.i14 != this.i18)
                  {
                     this.i14 = this.i20;
                  }
                  else
                  {
                     this.i14 = 0;
                     while(true)
                     {
                        this.i20 = this.i14 ^ -1;
                        this.i20 = this.i18 + this.i20;
                        this.i21 = this.i20 << 2;
                        this.i22 = this.i2 + this.i21;
                        this.i21 = this.i10 + this.i21;
                        this.i22 = li32(this.i22 + 20);
                        this.i21 = li32(this.i21 + 20);
                        if(this.i22 != this.i21)
                        {
                           this.i14 = uint(this.i22) < uint(this.i21) ? -1 : 1;
                           break;
                        }
                        this.i14 += 1;
                        if(this.i20 <= 0)
                        {
                           this.i14 = 0;
                           break;
                        }
                     }
                  }
               }
               if(this.i10 != 0)
               {
                  this.i18 = _freelist;
                  this.i20 = li32(this.i10 + 4);
                  this.i20 <<= 2;
                  this.i18 += this.i20;
                  this.i20 = li32(this.i18);
                  si32(this.i20,this.i10);
                  si32(this.i10,this.i18);
               }
               if(this.i14 == 0)
               {
                  if(this.i19 == 0)
                  {
                     this.i10 = li32(this.i4);
                     this.i10 &= 1;
                     if(this.i10 == 0)
                     {
                        if(this.i16 == 57)
                        {
                           addr8641:
                           this.i1 = 57;
                           this.i13 = this.i5 + this.i12;
                           si8(this.i1,this.i17);
                           this.i1 = this.i13 + 1;
                           this.i13 = this.i23 + this.i5;
                           this.i4 = this.i9;
                           loop20:
                           while(true)
                           {
                              this.i24 = this.i4;
                              this.i5 = this.i1;
                              if(this.i13 == this.i12)
                              {
                                 this.i1 = 49;
                                 si8(this.i1,this.i13);
                                 this.i13 = 32;
                                 this.i8 += 1;
                                 this.i4 = this.i3;
                                 this.i3 = this.i24;
                                 this.i1 = this.i11;
                                 this.i24 = this.i5;
                                 this.i11 = this.i8;
                                 break;
                              }
                              this.i1 = this.i3;
                              this.i3 = this.i24;
                              while(true)
                              {
                                 this.i24 = this.i3;
                                 this.i3 = li8(this.i13 + -1);
                                 this.i5 = this.i13 + -1;
                                 if(this.i3 != 57)
                                 {
                                    this.i9 = 32;
                                    this.i3 += 1;
                                    si8(this.i3,this.i5);
                                    this.i4 = this.i1;
                                    this.i3 = this.i24;
                                 }
                                 continue loop20;
                                 this.i1 = this.i11;
                                 this.i24 = this.i13;
                                 this.i11 = this.i8;
                                 this.i13 = this.i9;
                                 break loop20;
                              }
                           }
                           addr8067:
                        }
                        else if(this.i24 <= 0)
                        {
                           this.i1 = li32(this.i15);
                           if(this.i1 <= 1)
                           {
                              this.i1 = li32(this.i2 + 20);
                              if(this.i1 == 0)
                              {
                                 this.i13 = 0;
                                 this.i1 = this.i5 + this.i12;
                                 si8(this.i16,this.i17);
                                 this.i24 = this.i1 + 1;
                                 this.i4 = this.i3;
                                 this.i3 = this.i9;
                                 this.i1 = this.i11;
                                 this.i11 = this.i8;
                                 §§goto(addr9604);
                              }
                              §§goto(addr3378);
                           }
                           this.i13 = 16;
                           this.i1 = this.i5 + this.i12;
                           si8(this.i16,this.i17);
                           this.i24 = this.i1 + 1;
                           this.i4 = this.i3;
                           this.i3 = this.i9;
                           this.i1 = this.i11;
                           this.i11 = this.i8;
                        }
                        else
                        {
                           this.i13 = 32;
                           this.i24 = this.i5 + this.i12;
                           this.i1 += 49;
                           si8(this.i1,this.i17);
                           this.i24 += 1;
                           this.i4 = this.i3;
                           this.i3 = this.i9;
                           this.i1 = this.i11;
                           this.i11 = this.i8;
                        }
                     }
                     else
                     {
                        addr8215:
                        if(this.i24 >= 0)
                        {
                           if(this.i24 == 0)
                           {
                              if(this.i19 == 0)
                              {
                                 this.i24 = li32(this.i4);
                                 this.i24 &= 1;
                                 if(this.i24 == 0)
                                 {
                                    addr8249:
                                    if(this.i14 > 0)
                                    {
                                       this.i13 = 1;
                                       mstate.esp -= 8;
                                       si32(this.i2,mstate.esp);
                                       si32(this.i13,mstate.esp + 4);
                                       state = 31;
                                       mstate.esp -= 4;
                                       FSM___lshift_D2A.start();
                                       return;
                                    }
                                    this.i1 = 0;
                                    this.i13 = this.i16;
                                    addr8472:
                                    this.i14 = this.i1;
                                    this.i1 = this.i13;
                                    this.i13 = li32(this.i2 + 16);
                                    if(this.i13 <= 1)
                                    {
                                       this.i13 = li32(this.i2 + 20);
                                       if(this.i13 == 0)
                                       {
                                          this.i13 = this.i5 + this.i12;
                                          si8(this.i1,this.i17);
                                          this.i13 += 1;
                                          this.i4 = this.i3;
                                          this.i3 = this.i9;
                                          this.i1 = this.i11;
                                          this.i24 = this.i13;
                                          this.i11 = this.i8;
                                          this.i13 = this.i14;
                                       }
                                       §§goto(addr3378);
                                    }
                                    this.i13 = 16;
                                    this.i4 = this.i5 + this.i12;
                                    si8(this.i1,this.i17);
                                    this.i24 = this.i4 + 1;
                                    this.i4 = this.i3;
                                    this.i3 = this.i9;
                                    this.i1 = this.i11;
                                    this.i11 = this.i8;
                                    §§goto(addr3378);
                                 }
                                 §§goto(addr3378);
                              }
                           }
                           if(this.i14 >= 1)
                           {
                              if(this.i16 != 57)
                              {
                                 this.i13 = 32;
                                 this.i1 = this.i5 + this.i12;
                                 this.i4 = this.i16 + 1;
                                 si8(this.i4,this.i17);
                                 this.i24 = this.i1 + 1;
                                 this.i4 = this.i3;
                                 this.i3 = this.i9;
                                 this.i1 = this.i11;
                                 this.i11 = this.i8;
                                 §§goto(addr3378);
                              }
                              else
                              {
                                 §§goto(addr8067);
                              }
                           }
                           else
                           {
                              si8(this.i16,this.i17);
                              this.i1 = li32(mstate.ebp + -4);
                              this.i24 = this.i5 + 1;
                              if(this.i1 != this.i13)
                              {
                                 this.i1 = 0;
                                 mstate.esp -= 12;
                                 this.i24 = 10;
                                 si32(this.i2,mstate.esp);
                                 si32(this.i24,mstate.esp + 4);
                                 si32(this.i1,mstate.esp + 8);
                                 state = 32;
                                 mstate.esp -= 4;
                                 FSM___multadd_D2A.start();
                                 return;
                              }
                              this.i13 = this.i12 + this.i24;
                              this.i1 = this.i16;
                              this.i4 = this.i9;
                              §§goto(addr9173);
                           }
                        }
                        §§goto(addr8249);
                     }
                     §§goto(addr3378);
                  }
               }
               §§goto(addr8215);
            case 31:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i13 = li32(this.i2 + 16);
               this.i4 = li32(this.i11 + 16);
               this.i24 = this.i13 - this.i4;
               if(this.i13 != this.i4)
               {
                  this.i13 = this.i24;
               }
               else
               {
                  this.i13 = 0;
                  while(true)
                  {
                     this.i24 = this.i13 ^ -1;
                     this.i24 = this.i4 + this.i24;
                     this.i14 = this.i24 << 2;
                     this.i19 = this.i2 + this.i14;
                     this.i14 = this.i11 + this.i14;
                     this.i19 = li32(this.i19 + 20);
                     this.i14 = li32(this.i14 + 20);
                     if(this.i19 != this.i14)
                     {
                        this.i13 = uint(this.i19) < uint(this.i14) ? -1 : 1;
                        break;
                     }
                     this.i13 += 1;
                     if(this.i24 <= 0)
                     {
                        this.i13 = 0;
                        break;
                     }
                  }
               }
               if(this.i13 <= 0)
               {
                  if(this.i13 == 0)
                  {
                     this.i13 = this.i16 & 1;
                     if(this.i13 != 0)
                     {
                        addr8457:
                        this.i13 = this.i1 + 49;
                        if(this.i13 != 58)
                        {
                           this.i1 = 32;
                           §§goto(addr8472);
                        }
                        else
                        {
                           §§goto(addr8641);
                        }
                     }
                     else
                     {
                        addr8438:
                        this.i1 = 32;
                        this.i13 = this.i16;
                     }
                     §§goto(addr8472);
                  }
                  §§goto(addr8438);
               }
               §§goto(addr8457);
            case 32:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i3 == this.i9)
               {
                  this.i1 = 0;
                  mstate.esp -= 12;
                  this.i3 = 10;
                  si32(this.i9,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  state = 33;
                  mstate.esp -= 4;
                  FSM___multadd_D2A.start();
                  return;
               }
               this.i1 = 0;
               mstate.esp -= 12;
               this.i24 = 10;
               si32(this.i3,mstate.esp);
               si32(this.i24,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 34;
               mstate.esp -= 4;
               FSM___multadd_D2A.start();
               return;
               break;
            case 34:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i9,mstate.esp);
               si32(this.i24,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 35;
               mstate.esp -= 4;
               FSM___multadd_D2A.start();
               return;
            case 36:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(mstate.ebp + -4);
               this.i3 += 1;
               si32(this.i3,mstate.ebp + -4);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               mstate.esp -= 4;
               FSM___quorem_D2A.start();
            case 37:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i3 += 48;
               this.i4 = this.i23 + this.i1;
               si8(this.i3,this.i4 + 1);
               this.i4 = li32(mstate.ebp + -4);
               this.i1 += 1;
               if(this.i4 < this.i13)
               {
                  addr8972:
                  this.i3 = 0;
                  mstate.esp -= 12;
                  this.i4 = 10;
                  si32(this.i2,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 36;
                  mstate.esp -= 4;
                  FSM___multadd_D2A.start();
                  return;
               }
               this.i9 = 0;
               this.i1 <<= 0;
               this.i1 += this.i12;
               this.i13 = this.i1 + 1;
               this.i1 = this.i3;
               this.i4 = this.i24;
               this.i3 = this.i9;
               addr9173:
               this.i24 = this.i4;
               this.i4 = 1;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 38;
               mstate.esp -= 4;
               FSM___lshift_D2A.start();
               return;
               break;
            case 38:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i2 + 16);
               this.i5 = li32(this.i11 + 16);
               this.i9 = this.i4 - this.i5;
               if(this.i4 != this.i5)
               {
                  this.i4 = this.i9;
               }
               else
               {
                  this.i4 = 0;
                  while(true)
                  {
                     this.i9 = this.i4 ^ -1;
                     this.i9 = this.i5 + this.i9;
                     this.i10 = this.i9 << 2;
                     this.i14 = this.i2 + this.i10;
                     this.i10 = this.i11 + this.i10;
                     this.i14 = li32(this.i14 + 20);
                     this.i10 = li32(this.i10 + 20);
                     if(this.i14 != this.i10)
                     {
                        this.i4 = uint(this.i14) < uint(this.i10) ? -1 : 1;
                        break;
                     }
                     this.i4 += 1;
                     if(this.i9 <= 0)
                     {
                        this.i4 = 0;
                        break;
                     }
                  }
               }
               if(this.i4 >= 1)
               {
                  addr9348:
                  this.i1 = this.i3;
                  this.i3 = this.i24;
                  §§goto(addr9357);
               }
               else
               {
                  if(this.i4 == 0)
                  {
                     this.i1 &= 1;
                     if(this.i1 != 0)
                     {
                        §§goto(addr9348);
                     }
                     §§goto(addr3378);
                  }
                  this.i1 = li32(this.i2 + 16);
                  if(this.i1 <= 1)
                  {
                     this.i1 = li32(this.i2 + 20);
                     if(this.i1 == 0)
                     {
                        this.i1 = 0;
                     }
                     else
                     {
                        addr9524:
                        this.i1 = 16;
                     }
                     this.i5 = this.i1;
                     this.i1 = 0;
                     do
                     {
                        this.i4 = this.i1 ^ -1;
                        this.i4 = this.i13 + this.i4;
                        this.i4 = li8(this.i4);
                        this.i1 += 1;
                     }
                     while(this.i4 == 48);
                     
                     this.i1 += -1;
                     this.i13 -= this.i1;
                     this.i4 = this.i3;
                     this.i3 = this.i24;
                     this.i1 = this.i11;
                     this.i24 = this.i13;
                     this.i11 = this.i8;
                     this.i13 = this.i5;
                     §§goto(addr3378);
                  }
                  §§goto(addr9524);
               }
            default:
               throw "Invalid state in ___gdtoa";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
