package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_strtod extends Machine
   {
      
      public static const intRegCount:int = 23;
      
      public static const NumberRegCount:int = 4;
       
      
      public var i21:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var f2:Number;
      
      public var f3:Number;
      
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
      
      public var i20:int;
      
      public var i9:int;
      
      public function FSM_strtod()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_strtod = null;
         _loc1_ = new FSM_strtod();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop19:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 88;
               this.i0 = 0;
               si32(this.i0,mstate.ebp + -32);
               si32(this.i0,mstate.ebp + -28);
               this.i0 = li32(mstate.ebp + 8);
               si32(this.i0,mstate.ebp + -36);
               this.i1 = si8(li8(this.i0));
               this.i2 = mstate.ebp + -16;
               this.i3 = li32(mstate.ebp + 12);
               if(this.i1 <= 31)
               {
                  if(this.i1 != 0)
                  {
                     this.i1 += -9;
                     if(uint(this.i1) >= uint(5))
                     {
                        addr7832:
                        this.i1 = 0;
                        this.i4 = this.i0;
                        addr286:
                        this.i5 = li8(this.i4);
                        if(this.i5 == 48)
                        {
                           this.i5 = si8(li8(this.i4 + 1));
                           if(this.i5 != 88)
                           {
                              if(this.i5 != 120)
                              {
                                 this.i2 = this.i4;
                                 while(true)
                                 {
                                    this.i4 = this.i2 + 1;
                                    si32(this.i4,mstate.ebp + -36);
                                    this.i2 = li8(this.i2 + 1);
                                    if(this.i2 != 0)
                                    {
                                       this.i2 &= 255;
                                       if(this.i2 == 48)
                                       {
                                          continue;
                                       }
                                       addr895:
                                       this.i2 = 1;
                                       this.i5 = li8(this.i4);
                                       this.i6 = this.i5 << 24;
                                       this.i6 >>= 24;
                                       this.i7 = this.i5 + -48;
                                       this.i7 &= 255;
                                       if(uint(this.i7) >= uint(10))
                                       {
                                          this.i7 = 0;
                                          this.i8 = this.i7;
                                          this.i9 = this.i7;
                                       }
                                       else
                                       {
                                          this.i5 = 0;
                                          this.i7 = this.i5;
                                          this.i8 = this.i4;
                                          this.i9 = this.i5;
                                          while(true)
                                          {
                                             if(this.i7 <= 8)
                                             {
                                                this.i9 *= 10;
                                                this.i6 = this.i9 + this.i6;
                                                this.i6 += -48;
                                             }
                                             else if(this.i7 >= 16)
                                             {
                                                this.i6 = this.i9;
                                             }
                                             else
                                             {
                                                this.i5 *= 10;
                                                this.i5 = this.i6 + this.i5;
                                                this.i5 += -48;
                                                this.i6 = this.i9;
                                             }
                                             this.i9 = this.i8 + 1;
                                             si32(this.i9,mstate.ebp + -36);
                                             this.i10 = li8(this.i8 + 1);
                                             this.i8 = this.i10 << 24;
                                             this.i11 = this.i8 >> 24;
                                             this.i7 += 1;
                                             this.i8 = this.i10 + -48;
                                             this.i8 &= 255;
                                             if(uint(this.i8) >= uint(10))
                                             {
                                                break;
                                             }
                                             this.i8 = this.i9;
                                             this.i9 = this.i6;
                                             this.i6 = this.i11;
                                          }
                                          this.i8 = this.i6;
                                          this.i9 = this.i5;
                                          this.i5 = this.i10;
                                          this.i6 = this.i11;
                                       }
                                       mstate.esp -= 4;
                                       FSM_localeconv.start();
                                       this.i10 = li32(_ret_2E_1494_2E_0);
                                       this.i10 = li8(this.i10);
                                       this.i5 &= 255;
                                       if(this.i10 != this.i5)
                                       {
                                          this.i5 = 0;
                                          this.i10 = this.i7;
                                          this.i11 = this.i5;
                                       }
                                       else
                                       {
                                          this.i5 = li32(mstate.ebp + -36);
                                          this.i6 = this.i5 + 1;
                                          si32(this.i6,mstate.ebp + -36);
                                          this.i5 = li8(this.i5 + 1);
                                          this.i10 = this.i5 << 24;
                                          this.i10 >>= 24;
                                          if(this.i7 != 0)
                                          {
                                             this.i5 = 0;
                                             this.i11 = this.i7;
                                             this.i12 = this.i5;
                                             while(true)
                                             {
                                                this.i13 = this.i11;
                                                this.i14 = this.i12;
                                                this.i15 = this.i5;
                                                this.i16 = this.i4;
                                                this.i4 = this.i10 + -48;
                                                if(uint(this.i4) >= uint(10))
                                                {
                                                   this.i6 = this.i10;
                                                   this.i10 = this.i13;
                                                   this.i11 = this.i14;
                                                   this.i5 = this.i15;
                                                   this.i4 = this.i16;
                                                   break;
                                                }
                                                this.i11 = this.i6;
                                                this.i12 = this.i13;
                                                this.i5 = this.i14;
                                                this.i4 = this.i15;
                                                this.i6 = this.i16;
                                                addr1693:
                                                this.i14 = this.i11;
                                                this.i15 = this.i6;
                                                this.i16 = this.i8;
                                                this.i6 = this.i9 + 1;
                                                si32(this.i6,mstate.ebp + -36);
                                                this.i8 = si8(li8(this.i9 + 1));
                                                this.i10 = this.i8;
                                                this.i11 = this.i4;
                                                this.i12 = this.i5;
                                                this.i5 = this.i14;
                                                this.i4 = this.i13;
                                                this.i8 = this.i15;
                                                this.i9 = this.i16;
                                             }
                                             addr1806:
                                             if(this.i6 != 69)
                                             {
                                                if(this.i6 != 101)
                                                {
                                                   this.i12 = 0;
                                                   addr1822:
                                                   if(this.i10 == 0)
                                                   {
                                                      addr2361:
                                                      this.i4 = this.i6;
                                                      this.i7 = this.i0;
                                                      if(this.i5 == 0)
                                                      {
                                                         if(this.i2 != 0)
                                                         {
                                                            break;
                                                         }
                                                         if(this.i4 <= 104)
                                                         {
                                                            if(this.i4 != 73)
                                                            {
                                                               if(this.i4 == 78)
                                                               {
                                                                  addr2399:
                                                                  this.i2 = __2E_str237;
                                                                  this.i4 = li32(mstate.ebp + -36);
                                                                  this.i8 = 97;
                                                                  this.i9 = 0;
                                                                  this.i10 = this.i4;
                                                                  while(true)
                                                                  {
                                                                     this.i11 = this.i10 + this.i9;
                                                                     this.i11 = li8(this.i11 + 1);
                                                                     this.i0 = this.i11 << 24;
                                                                     this.i0 >>= 24;
                                                                     this.i11 += -65;
                                                                     this.i8 <<= 24;
                                                                     this.i11 &= 255;
                                                                     this.i5 = this.i0 + 32;
                                                                     this.i11 = uint(this.i11) > uint(25) ? int(this.i0) : int(this.i5);
                                                                     this.i8 >>= 24;
                                                                     if(this.i11 != this.i8)
                                                                     {
                                                                        this.i2 = 1;
                                                                        this.i9 = this.i4;
                                                                        break;
                                                                     }
                                                                     this.i8 = this.i2 + this.i9;
                                                                     this.i8 = li8(this.i8 + 1);
                                                                     this.i9 += 1;
                                                                     if(this.i8 == 0)
                                                                     {
                                                                        this.i2 = 0;
                                                                        this.i9 <<= 0;
                                                                        this.i9 += this.i4;
                                                                     }
                                                                     continue;
                                                                     this.i9 += 1;
                                                                     si32(this.i9,mstate.ebp + -36);
                                                                     break;
                                                                  }
                                                                  this.i4 = this.i9;
                                                                  this.i2 &= 1;
                                                                  if(this.i2 == 0)
                                                                  {
                                                                     this.i2 = li8(this.i4);
                                                                     if(this.i2 == 40)
                                                                     {
                                                                        this.i2 = _fpinan_2E_3736;
                                                                        mstate.esp -= 12;
                                                                        this.i4 = mstate.ebp + -36;
                                                                        this.i7 = mstate.ebp + -8;
                                                                        si32(this.i4,mstate.esp);
                                                                        si32(this.i2,mstate.esp + 4);
                                                                        si32(this.i7,mstate.esp + 8);
                                                                        mstate.esp -= 4;
                                                                        FSM___hexnan_D2A.start();
                                                                        addr3081:
                                                                        this.i2 = mstate.eax;
                                                                        mstate.esp += 12;
                                                                        if(this.i2 == 5)
                                                                        {
                                                                           this.i2 = li32(mstate.ebp + -4);
                                                                           this.i2 |= 2146435072;
                                                                           si32(this.i2,mstate.ebp + -28);
                                                                           this.i2 = li32(this.i7);
                                                                           si32(this.i2,mstate.ebp + -32);
                                                                           if(this.i3 != 0)
                                                                           {
                                                                              §§goto(addr819);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           addr3135:
                                                                           this.i2 = 2146959360;
                                                                           si32(this.i2,mstate.ebp + -28);
                                                                           this.i2 = 0;
                                                                           si32(this.i2,mstate.ebp + -32);
                                                                           if(this.i3 != 0)
                                                                           {
                                                                              §§goto(addr489);
                                                                           }
                                                                        }
                                                                        §§goto(addr886);
                                                                     }
                                                                     §§goto(addr3135);
                                                                  }
                                                                  else
                                                                  {
                                                                     addr2523:
                                                                     this.i1 = this.i7;
                                                                     this.i2 = this.i1;
                                                                     si32(this.i2,mstate.ebp + -36);
                                                                     if(this.i3 != 0)
                                                                     {
                                                                        §§goto(addr483);
                                                                     }
                                                                     else
                                                                     {
                                                                        §§goto(addr3185);
                                                                     }
                                                                  }
                                                                  §§goto(addr3185);
                                                               }
                                                               §§goto(addr2523);
                                                            }
                                                            else
                                                            {
                                                               addr2528:
                                                               this.i2 = __2E_str3562;
                                                               this.i4 = li32(mstate.ebp + -36);
                                                               this.i8 = 110;
                                                               this.i9 = 0;
                                                               this.i10 = this.i4;
                                                               while(true)
                                                               {
                                                                  this.i11 = this.i10 + this.i9;
                                                                  this.i11 = li8(this.i11 + 1);
                                                                  this.i0 = this.i11 << 24;
                                                                  this.i0 >>= 24;
                                                                  this.i11 += -65;
                                                                  this.i8 <<= 24;
                                                                  this.i11 &= 255;
                                                                  this.i5 = this.i0 + 32;
                                                                  this.i11 = uint(this.i11) > uint(25) ? int(this.i0) : int(this.i5);
                                                                  this.i8 >>= 24;
                                                                  if(this.i11 != this.i8)
                                                                  {
                                                                     this.i2 = 1;
                                                                     this.i9 = this.i4;
                                                                     break;
                                                                  }
                                                                  this.i8 = this.i2 + this.i9;
                                                                  this.i8 = li8(this.i8 + 1);
                                                                  this.i9 += 1;
                                                                  if(this.i8 == 0)
                                                                  {
                                                                     this.i2 = 0;
                                                                     this.i9 <<= 0;
                                                                     this.i9 += this.i4;
                                                                  }
                                                                  continue;
                                                                  this.i9 += 1;
                                                                  si32(this.i9,mstate.ebp + -36);
                                                                  break;
                                                               }
                                                               this.i4 = this.i9;
                                                               this.i2 &= 1;
                                                               this.i8 = this.i4;
                                                               if(this.i2 == 0)
                                                               {
                                                                  this.i2 = __2E_str136;
                                                                  this.i7 = this.i4 + -1;
                                                                  si32(this.i7,mstate.ebp + -36);
                                                                  this.i9 = 105;
                                                                  this.i10 = 0;
                                                                  while(true)
                                                                  {
                                                                     this.i11 = this.i8 + this.i10;
                                                                     this.i11 = li8(this.i11);
                                                                     this.i0 = this.i11 << 24;
                                                                     this.i0 >>= 24;
                                                                     this.i11 += -65;
                                                                     this.i9 <<= 24;
                                                                     this.i11 &= 255;
                                                                     this.i5 = this.i0 + 32;
                                                                     this.i11 = uint(this.i11) > uint(25) ? int(this.i0) : int(this.i5);
                                                                     this.i9 >>= 24;
                                                                     if(this.i11 != this.i9)
                                                                     {
                                                                        this.i2 = 1;
                                                                        break;
                                                                     }
                                                                     this.i9 = this.i2 + this.i10;
                                                                     this.i9 = li8(this.i9 + 1);
                                                                     this.i10 += 1;
                                                                     if(this.i9 == 0)
                                                                     {
                                                                        this.i2 = 0;
                                                                        this.i7 = this.i4 + this.i10;
                                                                     }
                                                                     continue;
                                                                     si32(this.i7,mstate.ebp + -36);
                                                                     break;
                                                                  }
                                                                  this.i4 = mstate.ebp + -32;
                                                                  this.i8 = this.i4 + 4;
                                                                  this.i2 ^= 1;
                                                                  this.i2 &= 1;
                                                                  if(this.i2 == 0)
                                                                  {
                                                                     this.i2 = 2146435072;
                                                                     this.i7 += 1;
                                                                     si32(this.i7,mstate.ebp + -36);
                                                                     si32(this.i2,this.i8);
                                                                     this.i2 = 0;
                                                                     si32(this.i2,this.i4);
                                                                     if(this.i3 != 0)
                                                                     {
                                                                        §§goto(addr489);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     this.i2 = 2146435072;
                                                                     si32(this.i2,this.i8);
                                                                     this.i2 = 0;
                                                                     si32(this.i2,this.i4);
                                                                     if(this.i3 != 0)
                                                                     {
                                                                        §§goto(addr489);
                                                                     }
                                                                  }
                                                                  §§goto(addr886);
                                                               }
                                                               else
                                                               {
                                                                  §§goto(addr2522);
                                                               }
                                                            }
                                                            §§goto(addr2523);
                                                         }
                                                         else if(this.i4 != 105)
                                                         {
                                                            if(this.i4 == 110)
                                                            {
                                                               §§goto(addr2399);
                                                            }
                                                            §§goto(addr2523);
                                                         }
                                                         else
                                                         {
                                                            §§goto(addr2528);
                                                         }
                                                         §§goto(addr2528);
                                                      }
                                                      break;
                                                   }
                                                   this.i2 = this.i12;
                                                   addr2299:
                                                   this.f0 = Number(uint(this.i8));
                                                   sf64(this.f0,mstate.ebp + -32);
                                                   this.i0 = this.i7 == 0 ? int(this.i10) : int(this.i7);
                                                   this.i5 = this.i10 < 17 ? int(this.i10) : 16;
                                                   this.i6 = this.i2 - this.i11;
                                                   if(this.i5 <= 9)
                                                   {
                                                      this.f1 = this.f0;
                                                   }
                                                   else
                                                   {
                                                      this.i7 = ___tens_D2A;
                                                      this.i12 = this.i5 << 3;
                                                      this.i7 = this.i12 + this.i7;
                                                      this.f1 = lf64(this.i7 + -72);
                                                      this.f2 = Number(uint(this.i9));
                                                      this.f0 = this.f1 * this.f0;
                                                      this.f0 += this.f2;
                                                      sf64(this.f0,mstate.ebp + -32);
                                                      this.f1 = this.f0;
                                                   }
                                                   if(this.i10 <= 15)
                                                   {
                                                      if(this.i2 != this.i11)
                                                      {
                                                         if(this.i6 >= 1)
                                                         {
                                                            if(this.i6 <= 22)
                                                            {
                                                               this.i2 = ___tens_D2A;
                                                               this.i0 = this.i6 << 3;
                                                               this.i2 += this.i0;
                                                               if(this.i1 != 0)
                                                               {
                                                                  this.f1 = lf64(this.i2);
                                                                  this.f0 = -this.f0;
                                                                  this.f0 = this.f1 * this.f0;
                                                                  sf64(this.f0,mstate.ebp + -32);
                                                                  if(this.i3 == 0)
                                                                  {
                                                                     addr3185:
                                                                     this.i2 = 0;
                                                                     §§goto(addr3191);
                                                                  }
                                                                  this.i2 = 0;
                                                                  addr483:
                                                                  §§goto(addr3191);
                                                               }
                                                               else
                                                               {
                                                                  this.f1 = lf64(this.i2);
                                                                  this.f0 *= this.f1;
                                                                  sf64(this.f0,mstate.ebp + -32);
                                                                  if(this.i3 == 0)
                                                                  {
                                                                     addr886:
                                                                     break loop19;
                                                                  }
                                                                  this.i2 = this.i1;
                                                                  addr489:
                                                                  addr819:
                                                               }
                                                               addr490:
                                                               this.i0 = li32(mstate.ebp + -36);
                                                               si32(this.i0,this.i3);
                                                            }
                                                            else
                                                            {
                                                               this.i2 = 15 - this.i10;
                                                               this.i7 = 37 - this.i10;
                                                               if(this.i7 >= this.i6)
                                                               {
                                                                  if(this.i1 == 0)
                                                                  {
                                                                     this.i0 = this.i1;
                                                                  }
                                                                  else
                                                                  {
                                                                     this.i0 = 0;
                                                                     this.f0 = -this.f0;
                                                                     sf64(this.f0,mstate.ebp + -32);
                                                                  }
                                                                  this.i1 = ___tens_D2A;
                                                                  this.i4 = this.i2 << 3;
                                                                  this.i2 = this.i6 - this.i2;
                                                                  this.i2 <<= 3;
                                                                  this.i4 = this.i1 + this.i4;
                                                                  this.f1 = lf64(this.i4);
                                                                  this.i2 = this.i1 + this.i2;
                                                                  this.f2 = lf64(this.i2);
                                                                  this.f0 *= this.f1;
                                                                  this.f0 *= this.f2;
                                                                  sf64(this.f0,mstate.ebp + -32);
                                                                  if(this.i3 != 0)
                                                                  {
                                                                     this.i2 = this.i0;
                                                                     §§goto(addr489);
                                                                  }
                                                                  else
                                                                  {
                                                                     this.i2 = this.i0;
                                                                     addr3190:
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  addr3609:
                                                                  this.i2 = this.i10 - this.i5;
                                                                  this.i2 = this.i6 + this.i2;
                                                                  if(this.i2 >= 1)
                                                                  {
                                                                     this.i5 = this.i2 & 15;
                                                                     if(this.i5 != 0)
                                                                     {
                                                                        this.i7 = ___tens_D2A;
                                                                        this.i5 <<= 3;
                                                                        this.i5 = this.i7 + this.i5;
                                                                        this.f0 = lf64(this.i5);
                                                                        this.f1 *= this.f0;
                                                                        sf64(this.f1,mstate.ebp + -32);
                                                                     }
                                                                     this.i5 = this.i2 & -16;
                                                                     if(uint(this.i2) > uint(15))
                                                                     {
                                                                        if(this.i5 < 309)
                                                                        {
                                                                           this.i2 = this.i5 >> 4;
                                                                           if(this.i2 <= 1)
                                                                           {
                                                                              this.i2 = 0;
                                                                           }
                                                                           else
                                                                           {
                                                                              this.i5 = ___bigtens_D2A;
                                                                              this.i7 = 0;
                                                                              do
                                                                              {
                                                                                 this.i9 = this.i5;
                                                                                 this.i11 = this.i2 & 1;
                                                                                 if(this.i11 != 0)
                                                                                 {
                                                                                    this.f0 = lf64(this.i9);
                                                                                    this.f1 *= this.f0;
                                                                                 }
                                                                                 this.i5 += 8;
                                                                                 this.i7 += 1;
                                                                                 this.i2 >>= 1;
                                                                              }
                                                                              while(this.i2 >= 2);
                                                                              
                                                                              sf64(this.f1,mstate.ebp + -32);
                                                                              this.i2 = this.i7;
                                                                           }
                                                                           this.i5 = ___bigtens_D2A;
                                                                           this.i7 = li32(mstate.ebp + -28);
                                                                           this.i2 <<= 3;
                                                                           this.i7 += -55574528;
                                                                           si32(this.i7,mstate.ebp + -28);
                                                                           this.i2 = this.i5 + this.i2;
                                                                           this.f1 = lf64(mstate.ebp + -32);
                                                                           this.f0 = lf64(this.i2);
                                                                           this.f1 *= this.f0;
                                                                           sf64(this.f1,mstate.ebp + -32);
                                                                           this.i2 = li32(mstate.ebp + -28);
                                                                           this.i5 = mstate.ebp + -32;
                                                                           this.i7 = this.i2 & 2146435072;
                                                                           this.i5 += 4;
                                                                           if(uint(this.i7) <= uint(2090860544))
                                                                           {
                                                                              if(uint(this.i7) >= uint(2089811969))
                                                                              {
                                                                                 this.i2 = 2146435071;
                                                                                 si32(this.i2,this.i5);
                                                                                 this.i2 = -1;
                                                                                 si32(this.i2,mstate.ebp + -32);
                                                                                 mstate.esp -= 16;
                                                                                 si32(this.i4,mstate.esp);
                                                                                 si32(this.i0,mstate.esp + 4);
                                                                                 si32(this.i10,mstate.esp + 8);
                                                                                 si32(this.i8,mstate.esp + 12);
                                                                                 state = 7;
                                                                                 mstate.esp -= 4;
                                                                                 FSM___s2b_D2A.start();
                                                                                 return;
                                                                              }
                                                                              this.i7 = 0;
                                                                              this.i2 += 55574528;
                                                                              si32(this.i2,this.i5);
                                                                              mstate.esp -= 16;
                                                                              si32(this.i4,mstate.esp);
                                                                              si32(this.i0,mstate.esp + 4);
                                                                              si32(this.i10,mstate.esp + 8);
                                                                              si32(this.i8,mstate.esp + 12);
                                                                              state = 10;
                                                                              mstate.esp -= 4;
                                                                              FSM___s2b_D2A.start();
                                                                              return;
                                                                           }
                                                                        }
                                                                        this.i2 = 0;
                                                                        this.i4 = this.i0;
                                                                        this.i5 = this.i0;
                                                                        addr3784:
                                                                        this.i6 = 34;
                                                                        si32(this.i6,_val_2E_1440);
                                                                        this.i6 = 2146435072;
                                                                        si32(this.i6,mstate.ebp + -28);
                                                                        this.i6 = 0;
                                                                        si32(this.i6,mstate.ebp + -32);
                                                                        if(this.i2 != 0)
                                                                        {
                                                                           addr7599:
                                                                           this.i6 = li32(mstate.ebp + -24);
                                                                           if(this.i6 != 0)
                                                                           {
                                                                              this.i7 = _freelist;
                                                                              this.i8 = li32(this.i6 + 4);
                                                                              this.i8 <<= 2;
                                                                              this.i7 += this.i8;
                                                                              this.i8 = li32(this.i7);
                                                                              si32(this.i8,this.i6);
                                                                              si32(this.i6,this.i7);
                                                                           }
                                                                           if(this.i4 != 0)
                                                                           {
                                                                              this.i6 = _freelist;
                                                                              this.i7 = li32(this.i4 + 4);
                                                                              this.i7 <<= 2;
                                                                              this.i6 += this.i7;
                                                                              this.i7 = li32(this.i6);
                                                                              si32(this.i7,this.i4);
                                                                              si32(this.i4,this.i6);
                                                                           }
                                                                           if(this.i5 != 0)
                                                                           {
                                                                              this.i4 = _freelist;
                                                                              this.i6 = li32(this.i5 + 4);
                                                                              this.i6 <<= 2;
                                                                              this.i4 += this.i6;
                                                                              this.i6 = li32(this.i4);
                                                                              si32(this.i6,this.i5);
                                                                              si32(this.i5,this.i4);
                                                                           }
                                                                           if(this.i2 != 0)
                                                                           {
                                                                              this.i4 = _freelist;
                                                                              this.i5 = li32(this.i2 + 4);
                                                                              this.i5 <<= 2;
                                                                              this.i4 += this.i5;
                                                                              this.i5 = li32(this.i4);
                                                                              si32(this.i5,this.i2);
                                                                              si32(this.i2,this.i4);
                                                                           }
                                                                           if(this.i0 != 0)
                                                                           {
                                                                              this.i2 = _freelist;
                                                                              this.i4 = li32(this.i0 + 4);
                                                                              this.i4 <<= 2;
                                                                              this.i2 += this.i4;
                                                                              this.i4 = li32(this.i2);
                                                                              si32(this.i4,this.i0);
                                                                              si32(this.i0,this.i2);
                                                                              break;
                                                                           }
                                                                           break;
                                                                        }
                                                                        break;
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     if(this.i2 <= -1)
                                                                     {
                                                                        this.i2 = 0 - this.i2;
                                                                        this.i5 = this.i2 & 15;
                                                                        if(this.i5 != 0)
                                                                        {
                                                                           this.i7 = ___tens_D2A;
                                                                           this.i5 <<= 3;
                                                                           this.i5 = this.i7 + this.i5;
                                                                           this.f0 = lf64(this.i5);
                                                                           this.f1 /= this.f0;
                                                                           sf64(this.f1,mstate.ebp + -32);
                                                                        }
                                                                        this.f0 = this.f1;
                                                                        this.i5 = this.i2 >> 4;
                                                                        if(uint(this.i2) >= uint(16))
                                                                        {
                                                                           if(this.i5 < 32)
                                                                           {
                                                                              this.i2 = this.i5 & 16;
                                                                              this.i2 = this.i2 == 0 ? 0 : 106;
                                                                              if(this.i5 >= 1)
                                                                              {
                                                                                 this.i7 = _tinytens;
                                                                                 do
                                                                                 {
                                                                                    this.i9 = this.i7;
                                                                                    this.i11 = this.i5 & 1;
                                                                                    if(this.i11 != 0)
                                                                                    {
                                                                                       this.f1 = lf64(this.i9);
                                                                                       this.f0 *= this.f1;
                                                                                    }
                                                                                    this.i7 += 8;
                                                                                    this.i5 >>= 1;
                                                                                 }
                                                                                 while(this.i5 >= 1);
                                                                                 
                                                                                 sf64(this.f0,mstate.ebp + -32);
                                                                              }
                                                                              if(this.i2 != 0)
                                                                              {
                                                                                 this.i5 = mstate.ebp + -32;
                                                                                 this.i7 = li32(mstate.ebp + -28);
                                                                                 this.i9 = this.i7 >>> 20;
                                                                                 this.i9 &= 2047;
                                                                                 this.i9 = 107 - this.i9;
                                                                                 this.i5 += 4;
                                                                                 if(this.i9 >= 1)
                                                                                 {
                                                                                    this.i11 = mstate.ebp + -32;
                                                                                    if(this.i9 >= 32)
                                                                                    {
                                                                                       this.i12 = 0;
                                                                                       si32(this.i12,this.i11);
                                                                                       if(this.i9 >= 53)
                                                                                       {
                                                                                          this.i7 = 57671680;
                                                                                          si32(this.i7,this.i5);
                                                                                          this.f0 = lf64(mstate.ebp + -32);
                                                                                          this.f1 = 0;
                                                                                          if(this.f0 != this.f1)
                                                                                          {
                                                                                             addr3700:
                                                                                             mstate.esp -= 16;
                                                                                             si32(this.i4,mstate.esp);
                                                                                             si32(this.i0,mstate.esp + 4);
                                                                                             si32(this.i10,mstate.esp + 8);
                                                                                             si32(this.i8,mstate.esp + 12);
                                                                                             state = 6;
                                                                                             mstate.esp -= 4;
                                                                                             FSM___s2b_D2A.start();
                                                                                             return;
                                                                                             addr4687:
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          this.i11 = -1;
                                                                                          this.i9 += -32;
                                                                                          this.i9 = this.i11 << this.i9;
                                                                                          this.i9 = this.i7 & this.i9;
                                                                                          si32(this.i9,this.i5);
                                                                                          this.f0 = lf64(mstate.ebp + -32);
                                                                                          this.f1 = 0;
                                                                                          if(this.f0 != this.f1)
                                                                                          {
                                                                                             addr4686:
                                                                                             §§goto(addr4687);
                                                                                          }
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       this.i5 = -1;
                                                                                       this.i7 = li32(this.i11);
                                                                                       this.i5 <<= this.i9;
                                                                                       this.i5 = this.i7 & this.i5;
                                                                                       si32(this.i5,this.i11);
                                                                                       addr4760:
                                                                                       this.f0 = 0;
                                                                                       this.f1 = lf64(mstate.ebp + -32);
                                                                                       if(this.f1 != this.f0)
                                                                                       {
                                                                                          §§goto(addr4686);
                                                                                       }
                                                                                    }
                                                                                    addr4464:
                                                                                    this.i2 = 0;
                                                                                    this.i4 = this.i0;
                                                                                    this.i5 = this.i0;
                                                                                    this.i6 = 0;
                                                                                    si32(this.i6,mstate.ebp + -32);
                                                                                    si32(this.i6,mstate.ebp + -28);
                                                                                    this.i6 = 34;
                                                                                    si32(this.i6,_val_2E_1440);
                                                                                    if(this.i2 != 0)
                                                                                    {
                                                                                       §§goto(addr7599);
                                                                                    }
                                                                                    break;
                                                                                 }
                                                                              }
                                                                              §§goto(addr4760);
                                                                           }
                                                                           §§goto(addr4464);
                                                                        }
                                                                        else
                                                                        {
                                                                           addr3694:
                                                                           this.i2 = 0;
                                                                           addr3693:
                                                                        }
                                                                        §§goto(addr3700);
                                                                     }
                                                                     §§goto(addr3693);
                                                                  }
                                                                  §§goto(addr3694);
                                                               }
                                                            }
                                                            §§goto(addr3191);
                                                         }
                                                         else if(this.i6 >= -22)
                                                         {
                                                            if(this.i1 == 0)
                                                            {
                                                               this.i2 = this.i1;
                                                            }
                                                            else
                                                            {
                                                               this.i2 = 0;
                                                               this.f0 = -this.f0;
                                                               sf64(this.f0,mstate.ebp + -32);
                                                            }
                                                            this.f1 = this.f0;
                                                            this.i0 = ___tens_D2A;
                                                            this.i1 = 0 - this.i6;
                                                            this.i1 <<= 3;
                                                            this.i0 += this.i1;
                                                            this.f0 = lf64(this.i0);
                                                            this.f1 /= this.f0;
                                                            sf64(this.f1,mstate.ebp + -32);
                                                            if(this.i3 != 0)
                                                            {
                                                               §§goto(addr489);
                                                            }
                                                            else
                                                            {
                                                               §§goto(addr3190);
                                                            }
                                                            mstate.ebp = li32(mstate.esp);
                                                            mstate.esp += 4;
                                                            mstate.esp += 4;
                                                            mstate.gworker = caller;
                                                            return;
                                                         }
                                                      }
                                                      break;
                                                   }
                                                   §§goto(addr3609);
                                                   §§goto(addr3185);
                                                }
                                                else
                                                {
                                                   addr1833:
                                                   if(this.i10 == 0)
                                                   {
                                                      if(this.i2 == 0)
                                                      {
                                                         if(this.i5 != 0)
                                                         {
                                                            addr1850:
                                                            this.i0 = li32(mstate.ebp + -36);
                                                            this.i6 = this.i0 + 1;
                                                            si32(this.i6,mstate.ebp + -36);
                                                            this.i12 = si8(li8(this.i0 + 1));
                                                            if(this.i12 != 45)
                                                            {
                                                               if(this.i12 == 43)
                                                               {
                                                                  this.i6 = 0;
                                                                  addr1896:
                                                                  this.i12 = this.i0 + 2;
                                                                  si32(this.i12,mstate.ebp + -36);
                                                                  this.i13 = si8(li8(this.i0 + 2));
                                                                  this.i14 = this.i13 + -48;
                                                                  if(uint(this.i14) >= uint(10))
                                                                  {
                                                                     this.i6 = this.i13;
                                                                     addr1939:
                                                                     this.i12 = 0;
                                                                     si32(this.i0,mstate.ebp + -36);
                                                                     §§goto(addr1822);
                                                                  }
                                                                  else
                                                                  {
                                                                     this.i14 = this.i12;
                                                                     this.i12 = this.i13;
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  this.i14 = this.i12 + -48;
                                                                  if(uint(this.i14) >= uint(10))
                                                                  {
                                                                     this.i6 = this.i12;
                                                                     §§goto(addr1939);
                                                                  }
                                                                  else
                                                                  {
                                                                     this.i13 = 0;
                                                                     this.i14 = this.i6;
                                                                     this.i6 = this.i13;
                                                                  }
                                                               }
                                                               §§goto(addr2361);
                                                               if(uint(this.i14) >= uint(9))
                                                               {
                                                                  this.i13 = 0;
                                                                  this.i6 = this.i12;
                                                                  this.i12 = this.i13;
                                                                  §§goto(addr1939);
                                                               }
                                                               else
                                                               {
                                                                  this.i14 = this.i13 + 1;
                                                                  si32(this.i14,mstate.ebp + -36);
                                                                  this.i15 = li8(this.i13 + 1);
                                                                  this.i16 = this.i15 << 24;
                                                                  this.i16 >>= 24;
                                                                  this.i12 += -48;
                                                                  this.i15 += -48;
                                                                  this.i15 &= 255;
                                                                  if(uint(this.i15) < uint(10))
                                                                  {
                                                                     while(true)
                                                                     {
                                                                        this.i15 = this.i14 + 1;
                                                                        si32(this.i15,mstate.ebp + -36);
                                                                        this.i14 = li8(this.i14 + 1);
                                                                        this.i12 *= 10;
                                                                        this.i17 = this.i14 << 24;
                                                                        this.i12 = this.i16 + this.i12;
                                                                        this.i16 = this.i17 >> 24;
                                                                        this.i12 += -48;
                                                                        this.i14 += -48;
                                                                        this.i14 &= 255;
                                                                        if(uint(this.i14) >= uint(10))
                                                                        {
                                                                           break;
                                                                        }
                                                                        this.i14 = this.i15;
                                                                     }
                                                                     this.i14 = this.i15;
                                                                  }
                                                                  this.i15 = this.i16;
                                                                  this.i13 = this.i14 - this.i13;
                                                                  this.i13 = this.i13 > 8 ? 1 : 0;
                                                                  this.i14 = this.i12 > 19999 ? 1 : 0;
                                                                  this.i13 |= this.i14;
                                                                  this.i13 &= 1;
                                                                  this.i12 = this.i13 != 0 ? 19999 : int(this.i12);
                                                                  if(this.i6 == 0)
                                                                  {
                                                                     this.i6 = this.i15;
                                                                     §§goto(addr1939);
                                                                  }
                                                                  else
                                                                  {
                                                                     this.i6 = 0 - this.i12;
                                                                     if(this.i10 != 0)
                                                                     {
                                                                        this.i2 = this.i6;
                                                                        §§goto(addr2299);
                                                                     }
                                                                     else
                                                                     {
                                                                        this.i6 = this.i15;
                                                                        §§goto(addr2361);
                                                                     }
                                                                  }
                                                                  §§goto(addr2361);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               this.i6 = 1;
                                                            }
                                                            §§goto(addr1896);
                                                         }
                                                         else
                                                         {
                                                            addr3161:
                                                            this.i1 = this.i0;
                                                         }
                                                         §§goto(addr2523);
                                                      }
                                                   }
                                                   §§goto(addr1850);
                                                }
                                             }
                                             §§goto(addr1833);
                                          }
                                          else
                                          {
                                             this.i5 &= 255;
                                             if(this.i5 != 48)
                                             {
                                                this.i5 = 0;
                                             }
                                             else
                                             {
                                                this.i5 = 0;
                                                while(true)
                                                {
                                                   this.i10 = this.i6 + 1;
                                                   si32(this.i10,mstate.ebp + -36);
                                                   this.i6 = li8(this.i6 + 1);
                                                   this.i5 += 1;
                                                   if(this.i6 != 48)
                                                   {
                                                      break;
                                                   }
                                                   this.i6 = this.i10;
                                                }
                                                this.i6 <<= 24;
                                                this.i11 = this.i6 >> 24;
                                                this.i6 = this.i10;
                                                this.i10 = this.i11;
                                             }
                                             this.i11 = this.i10 + -49;
                                             if(uint(this.i11) >= uint(9))
                                             {
                                                this.i11 = 0;
                                                this.i6 = this.i10;
                                                this.i10 = this.i7;
                                                §§goto(addr1806);
                                             }
                                             else
                                             {
                                                this.i4 = 0;
                                                this.i11 = this.i6;
                                                this.i12 = this.i7;
                                             }
                                             §§goto(addr1806);
                                          }
                                       }
                                       §§goto(addr1806);
                                    }
                                    break;
                                 }
                                 addr7826:
                                 if(this.i3 != 0)
                                 {
                                    §§goto(addr489);
                                 }
                                 else
                                 {
                                    §§goto(addr886);
                                 }
                              }
                           }
                           this.i4 = _fpi_2E_3700;
                           mstate.esp -= 20;
                           this.i5 = mstate.ebp + -24;
                           this.i6 = mstate.ebp + -20;
                           this.i7 = mstate.ebp + -36;
                           si32(this.i7,mstate.esp);
                           si32(this.i4,mstate.esp + 4);
                           si32(this.i6,mstate.esp + 8);
                           si32(this.i5,mstate.esp + 12);
                           si32(this.i1,mstate.esp + 16);
                           state = 1;
                           mstate.esp -= 4;
                           FSM___gethex_D2A.start();
                           return;
                        }
                        this.i2 = 0;
                        §§goto(addr895);
                     }
                     else
                     {
                        addr104:
                        this.i1 = this.i0;
                        while(true)
                        {
                           this.i4 = this.i1 + 1;
                           si32(this.i4,mstate.ebp + -36);
                           this.i1 = si8(li8(this.i1 + 1));
                           if(this.i1 <= 31)
                           {
                              if(this.i1 != 0)
                              {
                                 this.i1 += -9;
                                 if(uint(this.i1) < uint(5))
                                 {
                                    continue;
                                 }
                                 addr281:
                                 this.i1 = 0;
                              }
                              break;
                           }
                           if(this.i1 == 32)
                           {
                              continue;
                           }
                           if(this.i1 == 43)
                           {
                              this.i1 = this.i4;
                              addr226:
                              this.i4 = this.i1 + 1;
                              si32(this.i4,mstate.ebp + -36);
                              this.i1 = li8(this.i1 + 1);
                              if(this.i1 != 0)
                              {
                                 this.i1 = 0;
                              }
                              break;
                           }
                           if(this.i1 == 45)
                           {
                              this.i1 = this.i4;
                              addr190:
                              this.i4 = this.i1 + 1;
                              si32(this.i4,mstate.ebp + -36);
                              this.i1 = li8(this.i1 + 1);
                              if(this.i1 != 0)
                              {
                                 this.i1 = 1;
                              }
                              break;
                           }
                           §§goto(addr281);
                           §§goto(addr286);
                        }
                     }
                  }
                  §§goto(addr3161);
               }
               else if(this.i1 != 32)
               {
                  if(this.i1 != 43)
                  {
                     if(this.i1 == 45)
                     {
                        this.i1 = this.i0;
                        §§goto(addr190);
                     }
                     else
                     {
                        §§goto(addr7832);
                     }
                  }
                  else
                  {
                     this.i1 = this.i0;
                     §§goto(addr226);
                  }
                  §§goto(addr3161);
               }
               else
               {
                  §§goto(addr104);
               }
               §§goto(addr104);
            case 4:
               §§goto(addr895);
            case 5:
               §§goto(addr3081);
            case 1:
               this.i4 = mstate.eax;
               mstate.esp += 20;
               this.i5 = this.i4 & 7;
               if(this.i5 != 0)
               {
                  if(this.i5 == 6)
                  {
                     si32(this.i0,mstate.ebp + -36);
                     if(this.i3 != 0)
                     {
                        §§goto(addr484);
                     }
                     else
                     {
                        §§goto(addr3185);
                     }
                  }
                  else
                  {
                     this.i0 = mstate.ebp + -16;
                     this.i5 = li32(mstate.ebp + -24);
                     this.i6 = mstate.ebp + -32;
                     this.i7 = this.i5;
                     if(this.i5 != 0)
                     {
                        this.i8 = mstate.ebp + -16;
                        this.i9 = li32(_fpi_2E_3700);
                        this.i9 += -1;
                        this.i9 >>= 5;
                        this.i9 <<= 2;
                        this.i7 = li32(this.i7 + 16);
                        this.i8 = this.i9 + this.i8;
                        this.i8 += 4;
                        if(this.i7 <= 0)
                        {
                           this.i2 = this.i0;
                        }
                        else
                        {
                           this.i9 = 0;
                           this.i10 = this.i9;
                           do
                           {
                              this.i11 = this.i5 + this.i10;
                              this.i11 = li32(this.i11 + 20);
                              this.i12 = this.i2 + this.i10;
                              si32(this.i11,this.i12);
                              this.i10 += 4;
                              this.i9 += 1;
                           }
                           while(this.i9 < this.i7);
                           
                           this.i2 = mstate.ebp + -16;
                           this.i5 = this.i9 << 2;
                           this.i2 += this.i5;
                        }
                        this.i5 = this.i2;
                        if(uint(this.i2) < uint(this.i8))
                        {
                           this.i2 = this.i5;
                           do
                           {
                              this.i9 = 0;
                              si32(this.i9,this.i2);
                              this.i2 += 4;
                           }
                           while(uint(this.i2) < uint(this.i8));
                           
                        }
                        this.i2 = li32(mstate.ebp + -24);
                        if(this.i2 != 0)
                        {
                           this.i5 = _freelist;
                           this.i7 = li32(this.i2 + 4);
                           this.i7 <<= 2;
                           this.i5 += this.i7;
                           this.i7 = li32(this.i5);
                           si32(this.i7,this.i2);
                           si32(this.i2,this.i5);
                        }
                        this.i2 = li32(mstate.ebp + -20);
                        mstate.esp -= 16;
                        si32(this.i6,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i2,mstate.esp + 8);
                        si32(this.i4,mstate.esp + 12);
                        mstate.esp -= 4;
                        FSM___ULtod_D2A.start();
                        addr807:
                        mstate.esp += 16;
                        if(this.i3 == 0)
                        {
                           break;
                        }
                     }
                     else
                     {
                        this.i2 = li32(mstate.ebp + -20);
                        mstate.esp -= 16;
                        si32(this.i6,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i2,mstate.esp + 8);
                        si32(this.i4,mstate.esp + 12);
                        mstate.esp -= 4;
                        FSM___ULtod_D2A.start();
                        addr873:
                        mstate.esp += 16;
                        if(this.i3 == 0)
                        {
                           break;
                        }
                        §§goto(addr489);
                     }
                     §§goto(addr820);
                  }
                  §§goto(addr490);
               }
               else
               {
                  §§goto(addr7826);
               }
            case 3:
               §§goto(addr873);
            case 2:
               §§goto(addr807);
            case 6:
               this.i4 = mstate.eax;
               mstate.esp += 16;
               this.i0 = this.i2;
               this.i2 = this.i4;
               §§goto(addr4091);
            case 7:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i0 = 0;
               §§goto(addr4091);
            case 8:
               this.i12 = mstate.eax;
               mstate.esp += 4;
               this.i13 = li32(this.i9);
               this.i14 = this.i12 + 12;
               this.i13 <<= 2;
               this.i15 = this.i8;
               this.i13 += 8;
               memcpy(this.i14,this.i15,this.i13);
               this.f0 = lf64(mstate.ebp + -32);
               mstate.esp -= 16;
               this.i13 = mstate.ebp + -44;
               sf64(this.f0,mstate.esp);
               si32(this.i13,mstate.esp + 8);
               si32(this.i11,mstate.esp + 12);
               state = 9;
               mstate.esp -= 4;
               FSM___d2b_D2A.start();
               return;
            case 9:
               this.i11 = mstate.eax;
               mstate.esp += 16;
               si32(this.i11,mstate.ebp + -24);
               this.i11 = li32(_freelist + 4);
               if(this.i11 != 0)
               {
                  this.i13 = li32(this.i11);
                  si32(this.i13,_freelist + 4);
               }
               else
               {
                  this.i11 = _private_mem;
                  this.i13 = li32(_pmem_next);
                  this.i11 = this.i13 - this.i11;
                  this.i11 >>= 3;
                  this.i11 += 4;
                  if(uint(this.i11) > uint(288))
                  {
                     this.i11 = 32;
                     mstate.esp -= 8;
                     this.i13 = 0;
                     si32(this.i13,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     state = 11;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
                  this.i11 = 1;
                  this.i14 = this.i13 + 32;
                  si32(this.i14,_pmem_next);
                  si32(this.i11,this.i13 + 4);
                  this.i11 = 2;
                  si32(this.i11,this.i13 + 8);
                  this.i11 = this.i13;
               }
               addr4917:
               this.i13 = 0;
               si32(this.i13,this.i11 + 12);
               this.i13 = 1;
               si32(this.i13,this.i11 + 20);
               si32(this.i13,this.i11 + 16);
               if(this.i6 >= 0)
               {
                  this.i13 = 0;
                  this.i14 = this.i13;
                  this.i15 = this.i6;
                  this.i16 = this.i6;
               }
               else
               {
                  this.i16 = 0;
                  this.i14 = this.i7;
                  this.i13 = this.i7;
                  this.i15 = this.i16;
               }
               this.i17 = li32(mstate.ebp + -44);
               this.i18 = li32(mstate.ebp + -40);
               this.i19 = this.i17 - this.i0;
               this.i20 = this.i18 + this.i19;
               this.i15 += this.i0;
               this.i21 = this.i15 - this.i17;
               this.i22 = this.i14 + this.i17;
               this.i20 += -1;
               this.i19 += 1075;
               this.i18 = 54 - this.i18;
               this.i14 = this.i17 < 0 ? int(this.i14) : int(this.i22);
               this.i18 = this.i20 < -1022 ? int(this.i19) : int(this.i18);
               this.i15 = this.i17 > -1 ? int(this.i15) : int(this.i21);
               this.i15 += this.i18;
               this.i17 = this.i18 + this.i14;
               this.i18 = this.i15 <= this.i17 ? int(this.i15) : int(this.i17);
               this.i18 = this.i18 > this.i14 ? int(this.i14) : int(this.i18);
               this.i18 = this.i18 > 0 ? int(this.i18) : 0;
               this.i14 -= this.i18;
               this.i15 -= this.i18;
               this.i17 -= this.i18;
               if(this.i13 > 0)
               {
                  mstate.esp -= 8;
                  si32(this.i11,mstate.esp);
                  si32(this.i13,mstate.esp + 4);
                  state = 12;
                  mstate.esp -= 4;
                  FSM___pow5mult_D2A.start();
                  return;
               }
               addr5313:
               if(this.i17 >= 1)
               {
                  this.i13 = li32(mstate.ebp + -24);
                  mstate.esp -= 8;
                  si32(this.i13,mstate.esp);
                  si32(this.i17,mstate.esp + 4);
                  state = 14;
                  mstate.esp -= 4;
                  FSM___lshift_D2A.start();
                  return;
               }
               addr5373:
               if(this.i16 > 0)
               {
                  mstate.esp -= 8;
                  si32(this.i12,mstate.esp);
                  si32(this.i16,mstate.esp + 4);
                  state = 15;
                  mstate.esp -= 4;
                  FSM___pow5mult_D2A.start();
                  return;
               }
               addr5420:
               if(this.i15 > 0)
               {
                  mstate.esp -= 8;
                  si32(this.i12,mstate.esp);
                  si32(this.i15,mstate.esp + 4);
                  state = 16;
                  mstate.esp -= 4;
                  FSM___lshift_D2A.start();
                  return;
               }
               addr5467:
               if(this.i14 > 0)
               {
                  mstate.esp -= 8;
                  si32(this.i11,mstate.esp);
                  si32(this.i14,mstate.esp + 4);
                  state = 17;
                  mstate.esp -= 4;
                  FSM___lshift_D2A.start();
                  return;
               }
               §§goto(addr5514);
               break;
            case 10:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i0 = this.i7;
               §§goto(addr4091);
            case 11:
               this.i11 = mstate.eax;
               mstate.esp += 8;
               this.i13 = 1;
               si32(this.i13,this.i11 + 4);
               this.i13 = 2;
               si32(this.i13,this.i11 + 8);
               §§goto(addr4917);
            case 12:
               this.i11 = mstate.eax;
               mstate.esp += 8;
               this.i13 = li32(mstate.ebp + -24);
               mstate.esp -= 8;
               si32(this.i11,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               state = 13;
               mstate.esp -= 4;
               FSM___mult_D2A.start();
               return;
            case 13:
               this.i13 = mstate.eax;
               mstate.esp += 8;
               this.i18 = li32(mstate.ebp + -24);
               if(this.i18 != 0)
               {
                  this.i19 = _freelist;
                  this.i20 = li32(this.i18 + 4);
                  this.i20 <<= 2;
                  this.i19 += this.i20;
                  this.i20 = li32(this.i19);
                  si32(this.i20,this.i18);
                  si32(this.i18,this.i19);
               }
               si32(this.i13,mstate.ebp + -24);
               §§goto(addr5313);
            case 14:
               this.i13 = mstate.eax;
               mstate.esp += 8;
               si32(this.i13,mstate.ebp + -24);
               §§goto(addr5373);
            case 15:
               this.i12 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr5420);
            case 16:
               this.i12 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr5467);
            case 17:
               this.i11 = mstate.eax;
               mstate.esp += 8;
               addr5514:
               this.i13 = 0;
               this.i14 = li32(mstate.ebp + -24);
               mstate.esp -= 8;
               si32(this.i14,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               state = 18;
               mstate.esp -= 4;
               FSM___diff_D2A.start();
               return;
            case 18:
               this.i14 = mstate.eax;
               mstate.esp += 8;
               this.i15 = li32(this.i14 + 12);
               si32(this.i13,this.i14 + 12);
               this.i13 = li32(this.i14 + 16);
               this.i16 = li32(this.i11 + 16);
               this.i17 = this.i13 - this.i16;
               this.i18 = this.i11 + 16;
               if(this.i13 != this.i16)
               {
                  this.i16 = this.i17;
               }
               else
               {
                  this.i17 = 0;
                  while(true)
                  {
                     this.i19 = this.i17 ^ -1;
                     this.i19 = this.i16 + this.i19;
                     this.i20 = this.i19 << 2;
                     this.i21 = this.i14 + this.i20;
                     this.i20 = this.i11 + this.i20;
                     this.i21 = li32(this.i21 + 20);
                     this.i20 = li32(this.i20 + 20);
                     if(this.i21 != this.i20)
                     {
                        this.i16 = uint(this.i21) < uint(this.i20) ? -1 : 1;
                        break;
                     }
                     this.i17 += 1;
                     if(this.i19 <= 0)
                     {
                        this.i16 = 0;
                        break;
                     }
                  }
               }
               if(this.i16 <= -1)
               {
                  if(this.i15 == 0)
                  {
                     this.i6 = li32(this.i4);
                     if(this.i6 == 0)
                     {
                        this.i6 = li32(this.i5);
                        this.i7 = this.i6 & 1048575;
                        if(this.i7 == 0)
                        {
                           this.i6 &= 2146435072;
                           if(uint(this.i6) >= uint(112197633))
                           {
                              this.i6 = li32(this.i14 + 20);
                              if(this.i6 == 0)
                              {
                                 if(this.i13 < 2)
                                 {
                                    addr5717:
                                    this.i6 = this.i14;
                                    addr5716:
                                    if(this.i0 != 0)
                                    {
                                       this.i0 = this.i6;
                                       addr7529:
                                       this.f0 = lf64(mstate.ebp + -32);
                                       this.f0 *= 1.2326e-32;
                                       sf64(this.f0,mstate.ebp + -32);
                                       this.i5 = li32(this.i5);
                                       if(this.i5 == 0)
                                       {
                                          this.i4 = li32(this.i4);
                                          if(this.i4 == 0)
                                          {
                                             this.i4 = 34;
                                             si32(this.i4,_val_2E_1440);
                                             this.i4 = this.i12;
                                             this.i5 = this.i11;
                                          }
                                          §§goto(addr7599);
                                       }
                                       this.i4 = this.i12;
                                       this.i5 = this.i11;
                                    }
                                    else
                                    {
                                       this.i4 = this.i12;
                                       this.i5 = this.i11;
                                       this.i0 = this.i6;
                                    }
                                    §§goto(addr7599);
                                    addr5716:
                                 }
                              }
                              this.i6 = 1;
                              mstate.esp -= 8;
                              si32(this.i14,mstate.esp);
                              si32(this.i6,mstate.esp + 4);
                              state = 19;
                              mstate.esp -= 4;
                              FSM___lshift_D2A.start();
                              return;
                           }
                        }
                     }
                     §§goto(addr5716);
                  }
                  §§goto(addr5717);
               }
               else if(this.i16 == 0)
               {
                  this.i6 = li32(this.i5);
                  this.i7 = this.i6 & 1048575;
                  if(this.i15 != 0)
                  {
                     if(this.i7 == 1048575)
                     {
                        this.i7 = li32(this.i4);
                        if(this.i0 != 0)
                        {
                           this.i8 = this.i6 & 2146435072;
                           if(uint(this.i8) <= uint(111149056))
                           {
                              this.i9 = -1;
                              this.i8 >>>= 20;
                              this.i8 = 107 - this.i8;
                              this.i8 = this.i9 << this.i8;
                           }
                           else
                           {
                              addr6005:
                              this.i8 = -1;
                           }
                           if(this.i7 == this.i8)
                           {
                              this.i7 = 0;
                              this.i6 &= 2146435072;
                              this.i6 += 1048576;
                              si32(this.i6,this.i5);
                              si32(this.i7,this.i4);
                              if(this.i0 != 0)
                              {
                                 addr6085:
                                 this.i0 = this.i14;
                                 §§goto(addr7529);
                              }
                              else
                              {
                                 addr6314:
                                 this.i4 = this.i12;
                                 this.i5 = this.i11;
                                 this.i0 = this.i14;
                              }
                           }
                           else
                           {
                              addr6236:
                              this.i6 = li32(this.i4);
                              this.i6 &= 1;
                              if(this.i6 != 0)
                              {
                                 this.f0 = lf64(mstate.ebp + -32);
                                 mstate.esp -= 8;
                                 sf64(this.f0,mstate.esp);
                                 mstate.esp -= 4;
                                 FSM___ulp_D2A.start();
                                 addr6279:
                                 this.f1 = mstate.st0;
                                 mstate.esp += 8;
                                 if(this.i15 != 0)
                                 {
                                    this.f0 += this.f1;
                                    sf64(this.f0,mstate.ebp + -32);
                                    if(this.i0 != 0)
                                    {
                                       §§goto(addr6085);
                                    }
                                    else
                                    {
                                       §§goto(addr6314);
                                    }
                                 }
                                 else
                                 {
                                    this.f2 = 0;
                                    this.f0 -= this.f1;
                                    sf64(this.f0,mstate.ebp + -32);
                                    if(this.f0 == this.f2)
                                    {
                                       addr6353:
                                       this.i4 = this.i12;
                                       this.i5 = this.i11;
                                       this.i0 = this.i14;
                                       addr4477:
                                       §§goto(addr4464);
                                    }
                                    else
                                    {
                                       §§goto(addr5717);
                                    }
                                 }
                              }
                              §§goto(addr5717);
                           }
                           §§goto(addr7599);
                        }
                        §§goto(addr6005);
                     }
                  }
                  else if(this.i7 == 0)
                  {
                     this.i6 = li32(this.i4);
                     if(this.i6 == 0)
                     {
                        this.i6 = this.i14;
                        addr6111:
                        this.i7 = li32(this.i5);
                        this.i7 &= 2146435072;
                        if(this.i0 != 0)
                        {
                           if(this.i7 <= 112197632)
                           {
                              if(this.i7 <= 57671680)
                              {
                                 this.i4 = this.i12;
                                 this.i5 = this.i11;
                                 this.i0 = this.i6;
                                 §§goto(addr4477);
                              }
                              else
                              {
                                 §§goto(addr5717);
                              }
                           }
                           else
                           {
                              this.i8 = -1;
                              this.i7 += -1048576;
                              this.i7 |= 1048575;
                              si32(this.i7,this.i5);
                              si32(this.i8,this.i4);
                              if(this.i0 != 0)
                              {
                                 this.i0 = this.i6;
                                 §§goto(addr7529);
                              }
                              else
                              {
                                 this.i4 = this.i12;
                                 this.i5 = this.i11;
                                 this.i0 = this.i6;
                              }
                           }
                        }
                        else
                        {
                           this.i0 = -1;
                           this.i7 += -1048576;
                           this.i7 |= 1048575;
                           si32(this.i7,this.i5);
                           si32(this.i0,this.i4);
                           this.i4 = this.i12;
                           this.i5 = this.i11;
                           this.i0 = this.i6;
                        }
                        §§goto(addr7599);
                     }
                     else
                     {
                        §§goto(addr6236);
                     }
                  }
                  §§goto(addr6236);
               }
               else
               {
                  this.f0 = 2;
                  mstate.esp -= 8;
                  si32(this.i14,mstate.esp);
                  si32(this.i11,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM___ratio_D2A.start();
                  addr6396:
                  this.f1 = mstate.st0;
                  mstate.esp += 8;
                  if(this.f1 <= this.f0)
                  {
                     if(this.i15 != 0)
                     {
                        this.f1 = 1;
                        this.i13 = 1072693248;
                        this.i16 = 0;
                        §§goto(addr6632);
                     }
                     else
                     {
                        this.i13 = li32(this.i4);
                        if(this.i13 != 0)
                        {
                           if(this.i13 != 1)
                           {
                              §§goto(addr6444);
                           }
                           else
                           {
                              addr6476:
                              this.i16 = li32(this.i5);
                              if(this.i16 != 0)
                              {
                                 §§goto(addr6443);
                              }
                              else
                              {
                                 §§goto(addr6353);
                              }
                           }
                           §§goto(addr7826);
                        }
                        else
                        {
                           this.i16 = li32(this.i5);
                           this.i17 = this.i16 & 1048575;
                           if(this.i17 != 0)
                           {
                              if(this.i13 == 1)
                              {
                                 §§goto(addr6476);
                              }
                              addr6443:
                              addr6444:
                              this.f1 = 1;
                              this.i13 = -1074790400;
                              this.i16 = 0;
                              §§goto(addr6632);
                           }
                           else
                           {
                              this.f0 = 1;
                              if(this.f1 >= this.f0)
                              {
                                 this.f1 *= 0.5;
                                 this.f0 = -this.f1;
                                 sf64(this.f0,mstate.ebp + -56);
                                 this.i13 = li32(mstate.ebp + -56);
                                 this.i17 = li32(mstate.ebp + -52);
                                 this.i18 = this.i16 & 2146435072;
                                 if(this.i18 != 2145386496)
                                 {
                                    this.i16 = this.i17;
                                    this.i17 = this.i18;
                                    §§goto(addr6560);
                                 }
                                 else
                                 {
                                    §§goto(addr6685);
                                 }
                                 this.i9 = this.i2 + 16;
                                 this.i10 = this.i2 + 4;
                                 this.i11 = mstate.ebp + -40;
                                 this.i12 = li32(this.i10);
                                 mstate.esp -= 4;
                                 si32(this.i12,mstate.esp);
                                 state = 8;
                                 mstate.esp -= 4;
                                 FSM___Balloc_D2A.start();
                                 return;
                              }
                              this.f1 = 0.5;
                              this.i13 = -1075838976;
                              this.i16 = 0;
                              addr6632:
                              this.i17 = this.i16;
                              this.i18 = this.i13;
                              this.i13 = li32(this.i5);
                              this.i19 = this.i13 & 2146435072;
                              if(this.i19 != 2145386496)
                              {
                                 this.i13 = this.i17;
                                 this.i16 = this.i18;
                                 this.i17 = this.i19;
                                 addr6560:
                                 if(uint(this.i17) <= uint(111149056))
                                 {
                                    if(this.i0 != 0)
                                    {
                                       this.f0 = 2147480000;
                                       if(this.f1 <= this.f0)
                                       {
                                          this.f0 = 1;
                                          this.i13 = uint(this.f1);
                                          this.f1 = Number(uint(this.i13));
                                          this.f1 = this.i13 == 0 ? Number(this.f0) : Number(this.f1);
                                          this.f0 = -this.f1;
                                          this.f0 = this.i15 == 0 ? Number(this.f0) : Number(this.f1);
                                          sf64(this.f0,mstate.ebp + -80);
                                          this.i13 = li32(mstate.ebp + -80);
                                          this.i16 = li32(mstate.ebp + -76);
                                       }
                                       this.i18 = 112197632 - this.i17;
                                       this.i16 = this.i18 + this.i16;
                                    }
                                    else
                                    {
                                       addr6577:
                                    }
                                    this.f0 = lf64(mstate.ebp + -32);
                                    mstate.esp -= 8;
                                    si32(this.i13,mstate.ebp + -88);
                                    si32(this.i16,mstate.ebp + -84);
                                    sf64(this.f0,mstate.esp);
                                    mstate.esp -= 4;
                                    FSM___ulp_D2A.start();
                                    addr7189:
                                    this.f2 = mstate.st0;
                                    this.f3 = lf64(mstate.ebp + -88);
                                    this.f2 *= this.f3;
                                    mstate.esp += 8;
                                    this.f0 += this.f2;
                                    sf64(this.f0,mstate.ebp + -32);
                                    if(this.i0 == 0)
                                    {
                                       this.i13 = this.i17;
                                       addr7237:
                                       this.f0 = this.f1;
                                       this.i16 = li32(this.i5);
                                       this.i17 = this.i16 & 2146435072;
                                       if(this.i13 == this.i17)
                                       {
                                          this.i13 = int(this.f0);
                                          this.f1 = Number(this.i13);
                                          this.f0 -= this.f1;
                                          if(this.i15 == 0)
                                          {
                                             this.i13 = li32(this.i4);
                                             if(this.i13 == 0)
                                             {
                                                this.i13 = this.i16 & 1048575;
                                                if(this.i13 == 0)
                                                {
                                                   this.f1 = 0.25;
                                                   if(this.f0 >= this.f1)
                                                   {
                                                      §§goto(addr7334);
                                                   }
                                                   else
                                                   {
                                                      §§goto(addr5717);
                                                   }
                                                }
                                                §§goto(addr5717);
                                             }
                                          }
                                          this.f1 = 0.5;
                                          if(this.f0 >= this.f1)
                                          {
                                             this.f1 = 0.5;
                                             if(this.f0 <= this.f1)
                                             {
                                                §§goto(addr7334);
                                             }
                                             else
                                             {
                                                §§goto(addr5717);
                                             }
                                          }
                                          §§goto(addr5717);
                                       }
                                    }
                                    §§goto(addr7334);
                                 }
                                 §§goto(addr6577);
                              }
                              else
                              {
                                 this.i16 = this.i13;
                                 this.i13 = this.i17;
                                 this.i17 = this.i18;
                                 this.i18 = this.i19;
                                 addr6685:
                                 this.i19 = li32(mstate.ebp + -32);
                                 this.i20 = li32(mstate.ebp + -28);
                                 this.i16 += -55574528;
                                 si32(this.i16,this.i5);
                                 this.f0 = lf64(mstate.ebp + -32);
                                 mstate.esp -= 8;
                                 si32(this.i13,mstate.ebp + -72);
                                 si32(this.i17,mstate.ebp + -68);
                                 sf64(this.f0,mstate.esp);
                                 mstate.esp -= 4;
                                 FSM___ulp_D2A.start();
                                 this.f2 = mstate.st0;
                                 this.f3 = lf64(mstate.ebp + -72);
                                 this.f2 *= this.f3;
                                 mstate.esp += 8;
                                 this.f0 += this.f2;
                                 sf64(this.f0,mstate.ebp + -32);
                                 this.i13 = li32(this.i5);
                                 this.i16 = this.i13 & 2146435072;
                                 if(uint(this.i16) >= uint(2090860544))
                                 {
                                    if(this.i20 == 2146435071)
                                    {
                                       if(this.i19 == -1)
                                       {
                                          this.i4 = this.i12;
                                          this.i5 = this.i11;
                                          this.i0 = this.i14;
                                          §§goto(addr3784);
                                       }
                                    }
                                    this.i13 = 2146435071;
                                    si32(this.i13,this.i5);
                                    this.i13 = -1;
                                    si32(this.i13,this.i4);
                                    this.i13 = li32(mstate.ebp + -24);
                                    if(this.i13 != 0)
                                    {
                                       this.i15 = _freelist;
                                       this.i16 = li32(this.i13 + 4);
                                       this.i16 <<= 2;
                                       this.i15 += this.i16;
                                       this.i16 = li32(this.i15);
                                       si32(this.i16,this.i13);
                                       si32(this.i13,this.i15);
                                    }
                                    if(this.i12 != 0)
                                    {
                                       this.i13 = _freelist;
                                       this.i15 = li32(this.i12 + 4);
                                       this.i15 <<= 2;
                                       this.i13 += this.i15;
                                       this.i15 = li32(this.i13);
                                       si32(this.i15,this.i12);
                                       si32(this.i12,this.i13);
                                    }
                                    if(this.i11 != 0)
                                    {
                                       this.i13 = _freelist;
                                       this.i12 = li32(this.i11 + 4);
                                       this.i12 <<= 2;
                                       this.i13 += this.i12;
                                       this.i12 = li32(this.i13);
                                       si32(this.i12,this.i11);
                                       si32(this.i11,this.i13);
                                    }
                                    if(this.i14 != 0)
                                    {
                                       this.i13 = _freelist;
                                       this.i11 = li32(this.i14 + 4);
                                       this.i11 <<= 2;
                                       this.i13 += this.i11;
                                       this.i11 = li32(this.i13);
                                       si32(this.i11,this.i14);
                                       si32(this.i14,this.i13);
                                    }
                                 }
                                 else
                                 {
                                    this.i13 += 55574528;
                                    si32(this.i13,this.i5);
                                    if(this.i0 == 0)
                                    {
                                       this.i13 = this.i18;
                                       §§goto(addr7237);
                                    }
                                    §§goto(addr7334);
                                 }
                                 §§goto(addr7334);
                              }
                           }
                        }
                     }
                     §§goto(addr6685);
                  }
                  else
                  {
                     this.f1 *= 0.5;
                     this.f0 = -this.f1;
                     this.f0 = this.i15 == 0 ? Number(this.f0) : Number(this.f1);
                     sf64(this.f0,mstate.ebp + -64);
                     this.i13 = li32(mstate.ebp + -64);
                     this.i17 = li32(mstate.ebp + -60);
                     this.i16 = this.i13;
                     this.i13 = this.i17;
                  }
                  §§goto(addr6632);
               }
               §§goto(addr5717);
            case 20:
               §§goto(addr6279);
            case 19:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i6 + 16);
               this.i8 = li32(this.i18);
               this.i9 = this.i7 - this.i8;
               if(this.i7 != this.i8)
               {
                  this.i8 = this.i9;
               }
               else
               {
                  this.i7 = 0;
                  while(true)
                  {
                     this.i9 = this.i7 ^ -1;
                     this.i9 = this.i8 + this.i9;
                     this.i10 = this.i9 << 2;
                     this.i14 = this.i6 + this.i10;
                     this.i10 = this.i11 + this.i10;
                     this.i14 = li32(this.i14 + 20);
                     this.i10 = li32(this.i10 + 20);
                     if(this.i14 != this.i10)
                     {
                        this.i7 = uint(this.i14) < uint(this.i10) ? -1 : 1;
                        this.i8 = this.i7;
                        break;
                     }
                     this.i7 += 1;
                     if(this.i9 <= 0)
                     {
                        this.i7 = 0;
                        this.i8 = this.i7;
                        break;
                     }
                  }
               }
               this.i7 = this.i8;
               if(this.i7 <= 0)
               {
                  §§goto(addr5717);
               }
               else
               {
                  §§goto(addr6111);
               }
            case 21:
               §§goto(addr6396);
            case 23:
               §§goto(addr7189);
            case 22:
               §§goto(addr6685);
            default:
               throw "Invalid state in _strtod";
         }
         this.i2 = this.i1;
         §§goto(addr3185);
      }
   }
}
