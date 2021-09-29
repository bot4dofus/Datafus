package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM___gethex_D2A extends Machine
   {
      
      public static const intRegCount:int = 17;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
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
      
      public function FSM___gethex_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___gethex_D2A = null;
         _loc1_ = new FSM___gethex_D2A();
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
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = li32(mstate.ebp + 20);
               this.i4 = li32(mstate.ebp + 24);
               this.i5 = li8(___mlocale_changed_2E_b);
               if(this.i5 == 0)
               {
                  this.i5 = 1;
                  si8(this.i5,___mlocale_changed_2E_b);
               }
               this.i5 = li8(___nlocale_changed_2E_b);
               if(this.i5 == 0)
               {
                  this.i5 = __C_numeric_locale;
                  this.i6 = li32(__numeric_using_locale);
                  this.i7 = __numeric_locale;
                  this.i5 = this.i6 == 0 ? int(this.i5) : int(this.i7);
                  this.i6 = li32(this.i5);
                  si32(this.i6,_ret_2E_1494_2E_0);
                  this.i6 = li32(this.i5 + 4);
                  si32(this.i6,_ret_2E_1494_2E_1);
                  this.i5 = li32(this.i5 + 8);
                  si32(this.i5,_ret_2E_1494_2E_2);
                  this.i5 = 1;
                  si8(this.i5,___nlocale_changed_2E_b);
               }
               this.i5 = li32(_ret_2E_1494_2E_0);
               this.i5 = li8(this.i5);
               this.i6 = li8(___hexdig_D2A + 48);
               if(this.i6 == 0)
               {
                  mstate.esp -= 4;
                  FSM___hexdig_init_D2A.start();
                  addr191:
                  this.i6 = li32(this.i0);
                  this.i7 = li8(this.i6 + 2);
                  if(this.i7 != 48)
                  {
                     this.i7 = 0;
                  }
                  else
                  {
                     this.i7 = 0;
                     loop6:
                     while(true)
                     {
                        this.i8 = this.i7 + 1;
                        this.i7 = this.i6;
                        this.i6 = this.i8;
                        addr241:
                        while(true)
                        {
                           this.i8 = this.i6;
                           this.i6 = this.i8 + this.i7;
                           this.i6 = li8(this.i6 + 2);
                           if(this.i6 != 48)
                           {
                              break;
                           }
                           this.i6 = this.i7;
                           this.i7 = this.i8;
                           continue loop6;
                        }
                        this.i6 = this.i7;
                        this.i7 = this.i8;
                     }
                  }
                  this.i8 = ___hexdig_D2A;
                  this.i9 = this.i7 + this.i6;
                  this.i10 = li8(this.i9 + 2);
                  this.i8 += this.i10;
                  this.i8 = li8(this.i8);
                  this.i9 += 2;
                  this.i11 = this.i6;
                  if(this.i8 == 0)
                  {
                     this.i8 = this.i5 & 255;
                     this.i10 &= 255;
                     if(this.i10 != this.i8)
                     {
                        this.i6 = this.i7;
                        this.i7 = this.i9;
                     }
                     else
                     {
                        this.i9 = ___hexdig_D2A;
                        this.i6 = this.i7 + this.i6;
                        this.i8 = li8(this.i6 + 3);
                        this.i9 += this.i8;
                        this.i9 = li8(this.i9);
                        this.i10 = this.i6 + 3;
                        if(this.i9 == 0)
                        {
                           this.i6 = this.i7;
                           this.i7 = this.i10;
                        }
                        else
                        {
                           this.i6 = this.i8 & 255;
                           if(this.i6 != 48)
                           {
                              this.i7 = this.i10;
                           }
                           else
                           {
                              this.i7 += this.i11;
                              do
                              {
                                 this.i6 = li8(this.i7 + 4);
                                 this.i7 += 1;
                              }
                              while(this.i6 == 48);
                              
                              this.i7 += 3;
                           }
                           this.i9 = this.i7;
                           this.i6 = ___hexdig_D2A;
                           this.i7 = li8(this.i9);
                           this.i6 += this.i7;
                           this.i6 = li8(this.i6);
                           if(this.i6 != 0)
                           {
                              this.i7 = this.i9;
                              this.i6 = this.i10;
                              addr516:
                              this.i8 = this.i9;
                              this.i9 = ___hexdig_D2A;
                              this.i10 = li8(this.i7);
                              this.i9 += this.i10;
                              this.i9 = li8(this.i9);
                              this.i10 = this.i7;
                              if(this.i9 != 0)
                              {
                                 this.i7 = this.i10;
                                 while(true)
                                 {
                                    this.i9 = ___hexdig_D2A;
                                    this.i10 = li8(this.i7 + 1);
                                    this.i9 += this.i10;
                                    this.i9 = li8(this.i9);
                                    this.i7 += 1;
                                    this.i10 = this.i7;
                                    if(this.i9 == 0)
                                    {
                                       break;
                                    }
                                    this.i7 = this.i10;
                                 }
                              }
                              this.i9 = li8(this.i7);
                              this.i10 = this.i5 & 255;
                              this.i11 = this.i7;
                              if(this.i9 == this.i10)
                              {
                                 if(this.i6 != 0)
                                 {
                                    addr2969:
                                    this.i11 = this.i6;
                                 }
                                 else
                                 {
                                    this.i6 = ___hexdig_D2A;
                                    this.i9 = li8(this.i7 + 1);
                                    this.i6 += this.i9;
                                    this.i6 = li8(this.i6);
                                    this.i9 = this.i7 + 1;
                                    if(this.i6 != 0)
                                    {
                                       this.i7 = this.i11;
                                       do
                                       {
                                          this.i11 = ___hexdig_D2A;
                                          this.i6 = li8(this.i7 + 2);
                                          this.i11 += this.i6;
                                          this.i11 = li8(this.i11);
                                          this.i7 += 1;
                                       }
                                       while(this.i11 != 0);
                                       
                                       this.i7 += 1;
                                       this.i11 = this.i9;
                                    }
                                    else
                                    {
                                       this.i7 = this.i9;
                                       this.i11 = this.i9;
                                       addr688:
                                    }
                                    this.i6 = this.i7;
                                    this.i7 = this.i11;
                                    if(this.i7 == 0)
                                    {
                                       this.i7 = 0;
                                    }
                                    else
                                    {
                                       this.i7 = this.i6 - this.i7;
                                       this.i7 <<= 2;
                                       this.i7 = 0 - this.i7;
                                    }
                                    this.i9 = li8(this.i6);
                                    if(this.i9 != 80)
                                    {
                                       if(this.i9 == 112)
                                       {
                                          addr742:
                                          this.i9 = li8(this.i6 + 1);
                                          this.i10 = this.i6 + 1;
                                          if(this.i9 != 45)
                                          {
                                             if(this.i9 == 43)
                                             {
                                                this.i10 = 0;
                                                addr777:
                                                this.i9 = this.i10;
                                                this.i10 = this.i6 + 2;
                                             }
                                             else
                                             {
                                                this.i9 = 0;
                                             }
                                             this.i11 = ___hexdig_D2A;
                                             this.i12 = li8(this.i10);
                                             this.i11 += this.i12;
                                             this.i11 = li8(this.i11);
                                             this.i12 = this.i10;
                                             this.i13 = this.i11;
                                             if(this.i11 <= 25)
                                             {
                                                this.i13 &= 255;
                                                if(this.i13 != 0)
                                                {
                                                   this.i13 = ___hexdig_D2A;
                                                   this.i14 = li8(this.i10 + 1);
                                                   this.i13 += this.i14;
                                                   this.i13 = li8(this.i13);
                                                   this.i10 += 1;
                                                   this.i14 = this.i11 + -16;
                                                   this.i15 = this.i13;
                                                   if(this.i13 <= 25)
                                                   {
                                                      this.i15 &= 255;
                                                      if(this.i15 == 0)
                                                      {
                                                         addr888:
                                                         this.i12 = this.i10;
                                                         this.i13 = this.i14;
                                                         this.i14 = this.i11;
                                                      }
                                                      else
                                                      {
                                                         while(true)
                                                         {
                                                            this.i10 = ___hexdig_D2A;
                                                            this.i11 = li8(this.i12 + 2);
                                                            this.i10 += this.i11;
                                                            this.i14 *= 10;
                                                            this.i10 = li8(this.i10);
                                                            this.i14 = this.i13 + this.i14;
                                                            this.i12 += 1;
                                                            this.i11 = this.i14 + -16;
                                                            this.i13 = this.i10;
                                                            if(this.i10 > 25)
                                                            {
                                                               break;
                                                            }
                                                            this.i13 &= 255;
                                                            if(this.i13 == 0)
                                                            {
                                                               break;
                                                            }
                                                            this.i13 = this.i10;
                                                            this.i14 = this.i11;
                                                         }
                                                         this.i12 += 1;
                                                         this.i13 = this.i11;
                                                      }
                                                      this.i10 = this.i12;
                                                      this.i11 = this.i13;
                                                      this.i12 = this.i14;
                                                      this.i12 = 16 - this.i12;
                                                      this.i13 = this.i6 - this.i8;
                                                      this.i9 = this.i9 == 0 ? int(this.i11) : int(this.i12);
                                                      si32(this.i10,this.i0);
                                                      this.i0 = this.i13 + -1;
                                                      this.i7 = this.i9 + this.i7;
                                                      if(this.i0 <= 7)
                                                      {
                                                         this.i0 = 0;
                                                      }
                                                      else
                                                      {
                                                         addr1057:
                                                         this.i9 = 0;
                                                         do
                                                         {
                                                            this.i9 += 1;
                                                            this.i0 >>= 1;
                                                         }
                                                         while(this.i0 > 7);
                                                         
                                                         this.i0 = this.i9;
                                                      }
                                                      §§goto(addr1113);
                                                   }
                                                   §§goto(addr888);
                                                }
                                                else
                                                {
                                                   §§goto(addr1086);
                                                }
                                             }
                                             §§goto(addr1086);
                                          }
                                          else
                                          {
                                             this.i10 = 1;
                                          }
                                          §§goto(addr777);
                                       }
                                       addr1086:
                                       this.i9 = this.i6 - this.i8;
                                       si32(this.i6,this.i0);
                                       this.i0 = this.i9 + -1;
                                       if(this.i0 <= 7)
                                       {
                                          this.i0 = 0;
                                       }
                                       else
                                       {
                                          §§goto(addr1057);
                                       }
                                       addr1113:
                                       mstate.esp -= 4;
                                       si32(this.i0,mstate.esp);
                                       state = 2;
                                       mstate.esp -= 4;
                                       FSM___Balloc_D2A.start();
                                       return;
                                    }
                                    §§goto(addr742);
                                 }
                                 §§goto(addr688);
                              }
                              §§goto(addr2969);
                           }
                           else
                           {
                              this.i6 = 1;
                              this.i7 = this.i9;
                           }
                        }
                     }
                     si32(this.i7,this.i0);
                     this.i7 = this.i6 == 0 ? 6 : 0;
                     mstate.eax = this.i7;
                     break;
                  }
                  this.i6 = 0;
                  this.i7 = this.i9;
                  §§goto(addr516);
               }
               else
               {
                  this.i6 = 0;
                  this.i7 = li32(this.i0);
               }
               §§goto(addr241);
            case 1:
               §§goto(addr191);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i9 = this.i0 + 20;
               if(uint(this.i6) <= uint(this.i8))
               {
                  this.i5 = 0;
                  this.i6 = this.i9;
               }
               else
               {
                  this.i10 = 0;
                  this.i11 = this.i10;
                  this.i12 = this.i10;
                  this.i13 = this.i9;
                  do
                  {
                     this.i14 = this.i11 ^ -1;
                     this.i14 = this.i6 + this.i14;
                     this.i15 = li8(this.i14);
                     this.i16 = this.i5 & 255;
                     if(this.i15 != this.i16)
                     {
                        if(this.i12 == 32)
                        {
                           this.i15 = 0;
                           si32(this.i10,this.i13);
                           this.i13 += 4;
                           this.i12 = this.i15;
                           this.i10 = this.i15;
                        }
                        this.i15 = ___hexdig_D2A;
                        this.i16 = li8(this.i14);
                        this.i15 += this.i16;
                        this.i15 = li8(this.i15);
                        this.i15 &= 15;
                        this.i15 <<= this.i12;
                        this.i12 += 4;
                        this.i10 = this.i15 | this.i10;
                     }
                     this.i11 += 1;
                  }
                  while(uint(this.i14) > uint(this.i8));
                  
                  this.i5 = this.i10;
                  this.i6 = this.i13;
               }
               this.i8 = uint(this.i5) < uint(65536) ? 16 : 0;
               this.i10 = this.i5 << this.i8;
               this.i11 = uint(this.i10) < uint(16777216) ? 8 : 0;
               this.i10 <<= this.i11;
               this.i12 = uint(this.i10) < uint(268435456) ? 4 : 0;
               this.i13 = this.i0 + 20;
               this.i14 = this.i6 + 4;
               this.i13 = this.i14 - this.i13;
               this.i8 = this.i11 | this.i8;
               this.i10 <<= this.i12;
               this.i11 = uint(this.i10) < uint(1073741824) ? 2 : 0;
               this.i8 |= this.i12;
               this.i12 = this.i13 << 3;
               si32(this.i5,this.i6);
               this.i5 = this.i13 >> 2;
               si32(this.i5,this.i0 + 16);
               this.i5 = this.i8 | this.i11;
               this.i6 = this.i10 << this.i11;
               this.i8 = this.i12 & -32;
               if(this.i6 > -1)
               {
                  this.i6 &= 1073741824;
                  this.i5 += 1;
                  this.i5 = this.i6 == 0 ? 32 : int(this.i5);
               }
               this.i6 = li32(this.i1);
               this.i5 = this.i8 - this.i5;
               this.i8 = this.i1;
               if(this.i5 > this.i6)
               {
                  mstate.esp -= 8;
                  this.i5 -= this.i6;
                  si32(this.i0,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM___any_on_D2A.start();
                  addr1555:
                  this.i10 = mstate.eax;
                  mstate.esp += 8;
                  if(this.i10 == 0)
                  {
                     this.i10 = 0;
                  }
                  else
                  {
                     this.i10 = 1;
                     this.i11 = this.i5 + -1;
                     this.i12 = this.i11 >> 5;
                     this.i12 <<= 2;
                     this.i13 = this.i11 & 31;
                     this.i12 = this.i0 + this.i12;
                     this.i12 = li32(this.i12 + 20);
                     this.i10 <<= this.i13;
                     this.i10 = this.i12 & this.i10;
                     if(this.i10 == 0)
                     {
                        this.i10 = 1;
                     }
                     else
                     {
                        if(this.i11 > 1)
                        {
                           mstate.esp -= 8;
                           this.i10 = this.i5 + -2;
                           si32(this.i0,mstate.esp);
                           si32(this.i10,mstate.esp + 4);
                           mstate.esp -= 4;
                           FSM___any_on_D2A.start();
                           addr1727:
                           this.i10 = mstate.eax;
                           mstate.esp += 8;
                           if(this.i10 != 0)
                           {
                              mstate.esp -= 8;
                              si32(this.i0,mstate.esp);
                              si32(this.i5,mstate.esp + 4);
                              mstate.esp -= 4;
                              FSM___rshift_D2A.start();
                              addr1769:
                              mstate.esp += 8;
                              this.i10 = li32(this.i1 + 8);
                              this.i5 += this.i7;
                              if(this.i10 >= this.i5)
                              {
                                 this.i7 = 3;
                                 addr1801:
                                 this.i10 = li32(this.i1 + 4);
                                 this.i11 = this.i1 + 4;
                                 if(this.i10 <= this.i5)
                                 {
                                    this.i10 = 1;
                                 }
                                 else
                                 {
                                    this.i5 = this.i10 - this.i5;
                                    if(this.i5 >= this.i6)
                                    {
                                       this.i7 = li32(this.i1 + 12);
                                       if(this.i7 != 3)
                                       {
                                          if(this.i7 != 2)
                                          {
                                             if(this.i7 == 1)
                                             {
                                                if(this.i5 == this.i6)
                                                {
                                                   if(this.i5 >= 2)
                                                   {
                                                      mstate.esp -= 8;
                                                      this.i5 += -1;
                                                      si32(this.i0,mstate.esp);
                                                      si32(this.i5,mstate.esp + 4);
                                                      mstate.esp -= 4;
                                                      FSM___any_on_D2A.start();
                                                      addr2081:
                                                      this.i5 = mstate.eax;
                                                      mstate.esp += 8;
                                                      if(this.i5 == 0)
                                                      {
                                                         addr2139:
                                                         if(this.i0 != 0)
                                                         {
                                                            this.i5 = _freelist;
                                                            this.i6 = li32(this.i0 + 4);
                                                            this.i6 <<= 2;
                                                            this.i5 += this.i6;
                                                            this.i6 = li32(this.i5);
                                                            si32(this.i6,this.i0);
                                                            si32(this.i0,this.i5);
                                                         }
                                                         this.i5 = 0;
                                                         si32(this.i5,this.i3);
                                                         this.i5 = 80;
                                                         addr2194:
                                                         mstate.eax = this.i5;
                                                         break;
                                                      }
                                                      §§goto(addr2194);
                                                   }
                                                }
                                             }
                                          }
                                          else if(this.i4 != 0)
                                          {
                                          }
                                          §§goto(addr2139);
                                          si32(this.i5,this.i9);
                                          si32(this.i0,this.i3);
                                          this.i5 = 98;
                                       }
                                       else if(this.i4 != 0)
                                       {
                                          §§goto(addr2104);
                                       }
                                       §§goto(addr2139);
                                    }
                                    else
                                    {
                                       this.i10 = this.i5 + -1;
                                       if(this.i7 != 0)
                                       {
                                          this.i7 = 1;
                                       }
                                       else if(this.i10 > 0)
                                       {
                                          mstate.esp -= 8;
                                          si32(this.i0,mstate.esp);
                                          si32(this.i10,mstate.esp + 4);
                                          mstate.esp -= 4;
                                          FSM___any_on_D2A.start();
                                          addr2247:
                                          this.i7 = mstate.eax;
                                          mstate.esp += 8;
                                       }
                                       this.i12 = 1;
                                       this.i13 = this.i10 >> 5;
                                       this.i13 <<= 2;
                                       this.i13 = this.i9 + this.i13;
                                       this.i13 = li32(this.i13);
                                       mstate.esp -= 8;
                                       this.i10 &= 31;
                                       si32(this.i0,mstate.esp);
                                       si32(this.i5,mstate.esp + 4);
                                       this.i10 = this.i12 << this.i10;
                                       mstate.esp -= 4;
                                       FSM___rshift_D2A.start();
                                       addr2324:
                                       this.i10 = this.i13 & this.i10;
                                       mstate.esp += 8;
                                       this.i10 = this.i10 == 0 ? 0 : 2;
                                       this.i11 = li32(this.i11);
                                       this.i5 = this.i6 - this.i5;
                                       this.i7 = this.i10 | this.i7;
                                       this.i6 = 2;
                                       this.i10 = this.i6;
                                       this.i6 = this.i5;
                                       this.i5 = this.i11;
                                    }
                                 }
                                 if(this.i7 != 0)
                                 {
                                    this.i11 = li32(this.i1 + 12);
                                    if(this.i11 != 3)
                                    {
                                       if(this.i11 != 2)
                                       {
                                          if(this.i11 == 1)
                                          {
                                             this.i4 = this.i7 & 2;
                                             if(this.i4 != 0)
                                             {
                                                this.i4 = li32(this.i9);
                                                this.i4 |= this.i7;
                                                this.i4 &= 1;
                                                if(this.i4 != 0)
                                                {
                                                   §§goto(addr2450);
                                                }
                                             }
                                          }
                                       }
                                       else if(this.i4 != 1)
                                       {
                                          §§goto(addr2450);
                                       }
                                    }
                                    else if(this.i4 != 0)
                                    {
                                       addr2450:
                                       this.i4 = li32(this.i0 + 16);
                                       mstate.esp -= 4;
                                       si32(this.i0,mstate.esp);
                                       state = 11;
                                       mstate.esp -= 4;
                                       FSM___increment_D2A.start();
                                       return;
                                    }
                                    si32(this.i0,this.i3);
                                    si32(this.i5,this.i2);
                                    this.i0 = this.i10 | 16;
                                    addr2853:
                                    mstate.eax = this.i0;
                                    break;
                                 }
                                 si32(this.i0,this.i3);
                                 si32(this.i5,this.i2);
                                 mstate.eax = this.i10;
                                 break;
                              }
                              this.i5 = this.i0;
                              addr1944:
                              if(this.i5 != 0)
                              {
                                 this.i0 = _freelist;
                                 this.i1 = li32(this.i5 + 4);
                                 this.i1 <<= 2;
                                 this.i0 += this.i1;
                                 this.i1 = li32(this.i0);
                                 si32(this.i1,this.i5);
                                 si32(this.i5,this.i0);
                              }
                              this.i5 = 0;
                              si32(this.i5,this.i3);
                              this.i5 = 163;
                              §§goto(addr2139);
                           }
                           else
                           {
                              addr1690:
                              this.i10 = 2;
                              addr1577:
                              mstate.esp -= 8;
                              si32(this.i0,mstate.esp);
                              si32(this.i5,mstate.esp + 4);
                              mstate.esp -= 4;
                              FSM___rshift_D2A.start();
                              addr1604:
                              mstate.esp += 8;
                              this.i5 += this.i7;
                              this.i7 = this.i10;
                              this.i10 = li32(this.i1 + 8);
                              if(this.i10 >= this.i5)
                              {
                                 §§goto(addr1801);
                              }
                              else
                              {
                                 this.i5 = this.i0;
                                 §§goto(addr1944);
                              }
                              addr1576:
                           }
                           §§goto(addr1944);
                        }
                        §§goto(addr1690);
                     }
                     §§goto(addr1576);
                  }
                  §§goto(addr1577);
               }
               else
               {
                  if(this.i5 < this.i6)
                  {
                     this.i9 = 0;
                     mstate.esp -= 8;
                     this.i5 = this.i6 - this.i5;
                     si32(this.i0,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 7;
                     mstate.esp -= 4;
                     FSM___lshift_D2A.start();
                     return;
                  }
                  this.i5 = 0;
                  this.i10 = this.i5;
                  this.i5 = this.i7;
               }
               §§goto(addr1690);
            case 3:
               §§goto(addr1555);
            case 5:
               §§goto(addr1727);
            case 6:
               §§goto(addr1769);
            case 4:
               §§goto(addr1604);
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i11 = this.i0 + 20;
               this.i5 = this.i7 - this.i5;
               this.i10 = this.i9;
               this.i9 = this.i11;
               §§goto(addr1690);
            case 8:
               §§goto(addr2081);
            case 9:
               §§goto(addr2247);
            case 10:
               §§goto(addr2324);
            case 11:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               if(this.i10 == 2)
               {
                  this.i1 = li32(this.i8);
                  this.i1 += -1;
                  if(this.i1 == this.i6)
                  {
                     this.i1 = 1;
                     this.i4 = this.i6 >> 5;
                     this.i4 <<= 2;
                     this.i6 &= 31;
                     this.i4 = this.i0 + this.i4;
                     this.i4 = li32(this.i4 + 20);
                     this.i1 <<= this.i6;
                     this.i1 = this.i4 & this.i1;
                     if(this.i1 != 0)
                     {
                        this.i1 = 33;
                        si32(this.i0,this.i3);
                        si32(this.i5,this.i2);
                        mstate.eax = this.i1;
                        break;
                     }
                     addr2515:
                  }
               }
               else
               {
                  this.i7 = li32(this.i0 + 16);
                  if(this.i7 <= this.i4)
                  {
                     this.i6 &= 31;
                     if(this.i6 != 0)
                     {
                        this.i4 <<= 2;
                        this.i4 += this.i0;
                        this.i4 = li32(this.i4 + 16);
                        this.i7 = uint(this.i4) < uint(65536) ? 16 : 0;
                        this.i4 <<= this.i7;
                        this.i8 = uint(this.i4) < uint(16777216) ? 8 : 0;
                        this.i4 <<= this.i8;
                        this.i9 = uint(this.i4) < uint(268435456) ? 4 : 0;
                        this.i7 = this.i8 | this.i7;
                        this.i4 <<= this.i9;
                        this.i8 = uint(this.i4) < uint(1073741824) ? 2 : 0;
                        this.i7 |= this.i9;
                        this.i7 |= this.i8;
                        this.i4 <<= this.i8;
                        if(this.i4 <= -1)
                        {
                           this.i4 = this.i7;
                        }
                        else
                        {
                           this.i4 &= 1073741824;
                           this.i7 += 1;
                           this.i4 = this.i4 == 0 ? 32 : int(this.i7);
                        }
                        this.i6 = 32 - this.i6;
                        if(this.i4 < this.i6)
                        {
                           addr2779:
                           this.i4 = 1;
                           mstate.esp -= 8;
                           si32(this.i0,mstate.esp);
                           si32(this.i4,mstate.esp + 4);
                           mstate.esp -= 4;
                           FSM___rshift_D2A.start();
                           mstate.esp += 8;
                           this.i1 = li32(this.i1 + 8);
                           this.i5 += 1;
                           if(this.i5 <= this.i1)
                           {
                              addr2835:
                              si32(this.i0,this.i3);
                              si32(this.i5,this.i2);
                              this.i0 = this.i10 | 32;
                              §§goto(addr2853);
                           }
                           else
                           {
                              this.i5 = this.i0;
                              §§goto(addr1944);
                           }
                        }
                        §§goto(addr2835);
                     }
                     §§goto(addr2515);
                  }
                  §§goto(addr2779);
               }
               §§goto(addr2835);
            case 12:
               §§goto(addr2779);
            default:
               throw "Invalid state in ___gethex_D2A";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
