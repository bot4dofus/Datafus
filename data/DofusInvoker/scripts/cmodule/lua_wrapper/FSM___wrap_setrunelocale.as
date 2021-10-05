package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM___wrap_setrunelocale extends Machine
   {
      
      public static const intRegCount:int = 26;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i21:int;
      
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
      
      public var i20:int;
      
      public var i9:int;
      
      public function FSM___wrap_setrunelocale()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___wrap_setrunelocale = null;
         _loc1_ = new FSM___wrap_setrunelocale();
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
               mstate.esp -= 5120;
               this.i0 = mstate.ebp + -5120;
               this.i2 = li32(mstate.ebp + 8);
               this.i1 = li8(this.i2);
               this.i3 = this.i2;
               if(this.i1 != 67)
               {
                  this.i4 = __2E_str3149;
                  this.i5 = this.i1;
               }
               else
               {
                  this.i4 = __2E_str3149;
                  this.i5 = 0;
                  this.i6 = this.i1;
                  loop0:
                  while(true)
                  {
                     this.i7 = this.i4 + this.i5;
                     this.i7 += 1;
                     this.i6 &= 255;
                     if(this.i6 != 0)
                     {
                        this.i6 = this.i3 + this.i5;
                        this.i6 = li8(this.i6 + 1);
                        this.i7 = li8(this.i7);
                        this.i5 += 1;
                        if(this.i6 != this.i7)
                        {
                           this.i4 = __2E_str3149;
                           this.i4 += this.i5;
                           this.i5 = this.i6;
                           this.i4 = li8(this.i4);
                        }
                        else
                        {
                           addr147:
                        }
                        continue;
                        this.i5 &= 255;
                        if(this.i5 != this.i4)
                        {
                           this.i4 = this.i1 & 255;
                           if(this.i4 != 80)
                           {
                              this.i4 = __2E_str4150;
                              this.i5 = this.i1;
                           }
                           else
                           {
                              this.i4 = __2E_str4150;
                              this.i5 = 0;
                              this.i6 = this.i1;
                              while(true)
                              {
                                 this.i7 = this.i4 + this.i5;
                                 this.i7 += 1;
                                 this.i6 &= 255;
                                 if(this.i6 != 0)
                                 {
                                    this.i6 = this.i3 + this.i5;
                                    this.i6 = li8(this.i6 + 1);
                                    this.i7 = li8(this.i7);
                                    this.i5 += 1;
                                    if(this.i6 == this.i7)
                                    {
                                       continue;
                                    }
                                    this.i4 = __2E_str4150;
                                    this.i4 += this.i5;
                                    this.i5 = this.i6;
                                 }
                                 break loop0;
                              }
                           }
                           this.i4 = li8(this.i4);
                           this.i5 &= 255;
                           if(this.i5 == this.i4)
                           {
                              break;
                           }
                           this.i4 = li32(_CachedRuneLocale_2E_3155);
                           if(this.i4 != 0)
                           {
                              this.i5 = li8(_ctype_encoding_2E_3154);
                              this.i6 = this.i1 & 255;
                              if(this.i6 == this.i5)
                              {
                                 this.i5 = _ctype_encoding_2E_3154;
                                 this.i6 = 0;
                                 while(true)
                                 {
                                    this.i7 = this.i5 + this.i6;
                                    this.i7 += 1;
                                    this.i1 &= 255;
                                    if(this.i1 != 0)
                                    {
                                       this.i1 = this.i3 + this.i6;
                                       this.i1 = li8(this.i1 + 1);
                                       this.i7 = li8(this.i7);
                                       this.i6 += 1;
                                       if(this.i1 != this.i7)
                                       {
                                          this.i5 = _ctype_encoding_2E_3154;
                                          this.i5 += this.i6;
                                          this.i5 = li8(this.i5);
                                          this.i1 &= 255;
                                          if(this.i1 == this.i5)
                                          {
                                             break;
                                          }
                                          addr521:
                                          this.i1 = mstate.ebp + -5120;
                                          this.i4 = li32(__PathLocale);
                                          this.i5 = li8(this.i4);
                                          si8(this.i5,mstate.ebp + -5120);
                                          if(this.i5 != 0)
                                          {
                                             this.i5 = 1;
                                             do
                                             {
                                                this.i6 = this.i4 + this.i5;
                                                this.i6 = li8(this.i6);
                                                this.i7 = this.i0 + this.i5;
                                                si8(this.i6,this.i7);
                                                this.i5 += 1;
                                             }
                                             while(this.i6 != 0);
                                             
                                          }
                                          this.i4 = li8(this.i1);
                                          if(this.i4 != 0)
                                          {
                                             this.i4 = this.i0;
                                             while(true)
                                             {
                                                this.i5 = li8(this.i4 + 1);
                                                this.i4 += 1;
                                                this.i6 = this.i4;
                                                if(this.i5 == 0)
                                                {
                                                   break;
                                                }
                                                this.i4 = this.i6;
                                             }
                                          }
                                          else
                                          {
                                             this.i4 = this.i1;
                                          }
                                          this.i5 = mstate.ebp + -5120;
                                          this.i4 -= this.i0;
                                          this.i6 = 47;
                                          this.i7 = 0;
                                          this.i4 = this.i5 + this.i4;
                                          si8(this.i6,this.i4);
                                          si8(this.i7,this.i4 + 1);
                                          this.i4 = li8(this.i1);
                                          if(this.i4 != 0)
                                          {
                                             this.i4 = this.i0;
                                             while(true)
                                             {
                                                this.i5 = li8(this.i4 + 1);
                                                this.i4 += 1;
                                                this.i6 = this.i4;
                                                if(this.i5 == 0)
                                                {
                                                   break;
                                                }
                                                this.i4 = this.i6;
                                             }
                                          }
                                          else
                                          {
                                             this.i4 = this.i1;
                                          }
                                          this.i5 = 0;
                                       }
                                       else
                                       {
                                          addr434:
                                       }
                                       continue;
                                       do
                                       {
                                          this.i6 = this.i3 + this.i5;
                                          this.i6 = li8(this.i6);
                                          this.i7 = this.i4 + this.i5;
                                          si8(this.i6,this.i7);
                                          this.i5 += 1;
                                       }
                                       while(this.i6 != 0);
                                       
                                       this.i4 = li8(this.i1);
                                       if(this.i4 != 0)
                                       {
                                          this.i4 = this.i0;
                                          while(true)
                                          {
                                             this.i5 = li8(this.i4 + 1);
                                             this.i4 += 1;
                                             this.i6 = this.i4;
                                             if(this.i5 == 0)
                                             {
                                                break;
                                             }
                                             this.i4 = this.i6;
                                          }
                                       }
                                       else
                                       {
                                          this.i4 = this.i1;
                                       }
                                       this.i5 = mstate.ebp + -5120;
                                       this.i0 = this.i4 - this.i0;
                                       this.i0 = this.i5 + this.i0;
                                       this.i4 = __2E_str345;
                                       this.i5 = 10;
                                       memcpy(this.i0,this.i4,this.i5);
                                       this.i0 = li8(__2E_str19170 + 2);
                                       mstate.esp -= 16;
                                       this.i4 = 114;
                                       this.i5 = 0;
                                       si32(this.i1,mstate.esp);
                                       si32(this.i4,mstate.esp + 4);
                                       si32(this.i5,mstate.esp + 8);
                                       si32(this.i0,mstate.esp + 12);
                                       state = 21;
                                       mstate.esp -= 4;
                                       FSM_fopen387.start();
                                       return;
                                    }
                                    break;
                                 }
                                 this.i0 = 0;
                                 si32(this.i4,__CurrentRuneLocale);
                                 this.i2 = li32(_Cached__mb_cur_max_2E_3156);
                                 si32(this.i2,___mb_cur_max);
                                 this.i2 = li32(_Cached__mbrtowc_2E_3161);
                                 si32(this.i2,___mbrtowc);
                                 this.i2 = li32(_Cached__mbsinit_2E_3167);
                                 si32(this.i2,___mbsinit);
                                 this.i2 = li32(_Cached__mbsnrtowcs_2E_3173);
                                 si32(this.i2,___mbsnrtowcs);
                                 this.i2 = li32(_Cached__wcrtomb_2E_3165);
                                 si32(this.i2,___wcrtomb);
                                 this.i2 = li32(_Cached__wcsnrtombs_2E_3179);
                                 si32(this.i2,___wcsnrtombs);
                                 §§goto(addr294);
                              }
                              this.i5 = _ctype_encoding_2E_3154;
                              §§goto(addr434);
                           }
                           §§goto(addr521);
                        }
                        break;
                     }
                     break;
                  }
                  §§goto(addr289);
               }
               §§goto(addr147);
            case 21:
               this.i4 = mstate.eax;
               mstate.esp += 16;
               if(this.i4 != 0)
               {
                  this.i0 = li16(this.i4 + 14);
                  this.i1 = this.i0 << 16;
                  this.i1 >>= 16;
                  if(this.i1 <= 1)
                  {
                     this.i0 = 0;
                  }
                  else
                  {
                     this.i0 <<= 16;
                     this.i0 >>= 16;
                     state = 1;
                     addr787:
                     this.i0 = mstate.system.fsize(this.i0);
                     if(this.i0 < 0)
                     {
                        this.i0 = __2E_str96;
                        mstate.esp -= 20;
                        this.i1 = __2E_str251;
                        this.i5 = 59;
                        this.i6 = 2;
                        this.i7 = mstate.ebp + -4096;
                        si32(this.i7,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i6,mstate.esp + 8);
                        si32(this.i1,mstate.esp + 12);
                        si32(this.i5,mstate.esp + 16);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_sprintf.start();
                        return;
                     }
                     this.i5 = 0;
                     this.i1 = this.i0;
                     this.i0 = this.i5;
                  }
                  addr913:
                  this.i0 ^= 1;
                  this.i0 &= 1;
                  if(this.i0 == 0)
                  {
                     addr933:
                     this.i1 = 0;
                     break;
                  }
                  if(uint(this.i1) <= uint(3127))
                  {
                     this.i1 = 79;
                     si32(this.i1,_val_2E_1440);
                     this.i1 = 0;
                     break;
                  }
                  this.i0 = 0;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               this.i2 = li32(_val_2E_1440);
               if(this.i2 != 0)
               {
                  addr5341:
                  this.i0 = this.i2;
                  this.i1 = -1;
                  si32(this.i0,_val_2E_1440);
                  mstate.eax = this.i1;
               }
               else
               {
                  this.i2 = 2;
                  addr734:
                  if(this.i2 != 0)
                  {
                     §§goto(addr5341);
                  }
                  else
                  {
                     addr289:
                     this.i0 = 0;
                     addr294:
                     mstate.eax = this.i0;
                     mstate.esp = mstate.ebp;
                     mstate.ebp = li32(mstate.esp);
                     mstate.esp += 4;
                     mstate.esp += 4;
                     mstate.gworker = caller;
                     return;
                     addr742:
                  }
               }
               §§goto(addr294);
            case 1:
               §§goto(addr787);
            case 2:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i7;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i6,_val_2E_1440);
               this.i0 = 1;
               §§goto(addr913);
            case 3:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i0 = this.i5;
               if(this.i5 != 0)
               {
                  this.i6 = 0;
                  si32(this.i6,_val_2E_1440);
                  mstate.esp -= 4;
                  si32(this.i4,mstate.esp);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_rewind.start();
                  return;
               }
               §§goto(addr933);
               break;
            case 4:
               mstate.esp += 4;
               this.i6 = li32(_val_2E_1440);
               if(this.i6 != 0)
               {
                  this.i1 = 0;
                  mstate.esp -= 8;
                  si32(this.i5,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               this.i6 = 1;
               mstate.esp -= 16;
               si32(this.i5,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               FSM___fread.start();
               return;
               break;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i6,_val_2E_1440);
               break;
            case 6:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               if(this.i6 != 1)
               {
                  this.i1 = 0;
                  this.i0 = li32(_val_2E_1440);
                  mstate.esp -= 8;
                  si32(this.i5,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               this.i6 = __2E_str29160;
               this.i7 = 9;
               this.i8 = this.i5 + this.i1;
               this.i1 = 0;
               this.i9 = this.i5;
               this.i10 = this.i5;
               while(true)
               {
                  this.i11 = this.i6 + this.i1;
                  this.i12 = this.i0 + this.i1;
                  this.i12 = li8(this.i12);
                  this.i11 = li8(this.i11);
                  if(this.i12 == this.i11)
                  {
                     this.i7 += -1;
                     this.i1 += 1;
                     if(this.i7 == 1)
                     {
                        this.i6 = __2E_str16;
                        this.i7 = 4;
                        this.i11 = 0;
                        this.i0 = this.i6;
                        this.i1 = this.i7;
                        log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i11,this.i10 + 3124);
                        this.i0 = this.i6;
                        this.i1 = this.i7;
                        log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i11,this.i10 + 3112);
                        this.i0 = this.i6;
                        this.i1 = this.i7;
                        log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i11,this.i10 + 3116);
                        this.i0 = this.i6;
                        this.i1 = this.i7;
                        log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i11,this.i10 + 3120);
                        this.i6 = this.i10 + 3120;
                        this.i7 = this.i10 + 3116;
                        this.i12 = this.i10 + 3112;
                        this.i13 = this.i10 + 3124;
                        this.i1 = this.i9;
                        this.i0 = this.i11;
                        do
                        {
                           this.i11 = this.i1;
                           this.i14 = this.i0;
                           this.i15 = __2E_str16;
                           this.i16 = 4;
                           this.i17 = 0;
                           this.i0 = this.i15;
                           this.i1 = this.i16;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i17,this.i11 + 40);
                           this.i0 = this.i15;
                           this.i1 = this.i16;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i17,this.i11 + 1064);
                           this.i0 = this.i15;
                           this.i1 = this.i16;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i17,this.i11 + 2088);
                           this.i1 = this.i11 + 4;
                           this.i0 = this.i14 + 1;
                        }
                        while(this.i0 != 256);
                        
                        this.i11 = li32(this.i12);
                        this.i14 = this.i5 + 3128;
                        this.i1 = this.i11 * 12;
                        this.i15 = this.i14;
                        this.i1 = this.i14 + this.i1;
                        if(uint(this.i1) > uint(this.i8))
                        {
                           this.i1 = 0;
                           mstate.esp -= 8;
                           si32(this.i5,mstate.esp);
                           si32(this.i1,mstate.esp + 4);
                           state = 9;
                           mstate.esp -= 4;
                           FSM_pubrealloc.start();
                           return;
                        }
                        this.i16 = li32(this.i7);
                        this.i17 = this.i16 + this.i11;
                        this.i1 = this.i17 * 12;
                        this.i1 = this.i15 + this.i1;
                     }
                     continue;
                     if(uint(this.i1) > uint(this.i8))
                     {
                        this.i1 = 0;
                        mstate.esp -= 8;
                        si32(this.i5,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 10;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     this.i1 = li32(this.i6);
                     this.i1 = this.i17 + this.i1;
                     this.i1 *= 12;
                     this.i1 = this.i15 + this.i1;
                     if(uint(this.i1) > uint(this.i8))
                     {
                        this.i1 = 0;
                        mstate.esp -= 8;
                        si32(this.i5,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 11;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     if(this.i11 > 0)
                     {
                        this.i0 = 0;
                        this.i19 = this.i14;
                        this.i18 = this.i0;
                        while(true)
                        {
                           this.i20 = this.i1;
                           this.i21 = this.i0;
                           this.i22 = __2E_str16;
                           this.i23 = 4;
                           this.i24 = 0;
                           this.i0 = this.i22;
                           this.i1 = this.i23;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i24,this.i19);
                           this.i0 = this.i22;
                           this.i1 = this.i23;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i24,this.i19 + 4);
                           this.i0 = this.i22;
                           this.i1 = this.i23;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i24,this.i19 + 8);
                           this.i1 = li32(this.i19 + 4);
                           this.i0 = li32(this.i19);
                           this.i22 = this.i1 - this.i0;
                           this.i22 += 1;
                           this.i23 = this.i22 << 2;
                           this.i21 = this.i22 + this.i21;
                           this.i23 = this.i20 + this.i23;
                           if(uint(this.i23) > uint(this.i8))
                           {
                              break;
                           }
                           if(this.i22 >= 1)
                           {
                              this.i1 -= this.i0;
                              this.i0 = this.i1 << 2;
                              this.i0 = this.i20 + this.i0;
                              this.i1 += 1;
                              while(true)
                              {
                                 this.i20 = this.i0;
                                 this.i22 = this.i1;
                                 this.i1 = __2E_str16;
                                 this.i24 = 4;
                                 this.i25 = 0;
                                 this.i0 = this.i1;
                                 this.i1 = this.i24;
                                 log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                                 si32(this.i25,this.i20);
                                 this.i1 = this.i20 + -4;
                                 this.i20 = this.i22 + -1;
                                 if(this.i20 < 1)
                                 {
                                    break;
                                 }
                                 this.i0 = this.i1;
                                 this.i1 = this.i20;
                              }
                           }
                           this.i1 = li32(this.i12);
                           this.i0 = this.i19 + 12;
                           this.i18 += 1;
                           if(this.i1 > this.i18)
                           {
                              continue;
                           }
                           this.i1 = this.i23;
                           this.i0 = this.i21;
                        }
                        this.i1 = 0;
                        mstate.esp -= 8;
                        si32(this.i5,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 22;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     this.i0 = 0;
                     this.i19 = this.i1;
                     this.i18 = this.i0;
                     this.i1 = li32(this.i7);
                     if(this.i1 >= 1)
                     {
                        this.i0 = 0;
                        this.i1 = this.i11 * 12;
                        this.i1 = this.i14 + this.i1;
                        while(true)
                        {
                           this.i20 = this.i1;
                           this.i21 = this.i0;
                           this.i22 = __2E_str16;
                           this.i23 = 4;
                           this.i24 = 0;
                           this.i0 = this.i22;
                           this.i1 = this.i23;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i24,this.i20);
                           this.i0 = this.i22;
                           this.i1 = this.i23;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i24,this.i20 + 4);
                           this.i0 = this.i22;
                           this.i1 = this.i23;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i24,this.i20 + 8);
                           this.i1 = li32(this.i7);
                           this.i0 = this.i20 + 12;
                           this.i20 = this.i21 + 1;
                           if(this.i1 <= this.i20)
                           {
                              break;
                           }
                           this.i1 = this.i0;
                           this.i0 = this.i20;
                        }
                     }
                     this.i0 = li32(this.i6);
                     if(this.i0 > 0)
                     {
                        this.i1 = 0;
                        this.i0 = this.i11 + this.i16;
                        this.i0 *= 12;
                        this.i0 = this.i14 + this.i0;
                        while(true)
                        {
                           this.i20 = this.i0;
                           this.i21 = this.i1;
                           this.i22 = __2E_str16;
                           this.i23 = 4;
                           this.i24 = 0;
                           this.i0 = this.i22;
                           this.i1 = this.i23;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i24,this.i20);
                           this.i0 = this.i22;
                           this.i1 = this.i23;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i24,this.i20 + 4);
                           this.i0 = this.i22;
                           this.i1 = this.i23;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           si32(this.i24,this.i20 + 8);
                           this.i1 = li32(this.i6);
                           this.i0 = this.i20 + 12;
                           this.i20 = this.i21 + 1;
                           if(this.i1 <= this.i20)
                           {
                              break;
                           }
                           this.i1 = this.i20;
                        }
                        this.i0 = this.i1;
                     }
                     this.i1 = this.i0;
                     this.i0 = li32(this.i13);
                     this.i19 += this.i0;
                     if(uint(this.i19) > uint(this.i8))
                     {
                        this.i1 = 0;
                        mstate.esp -= 8;
                        si32(this.i5,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 12;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     this.i8 = 0;
                     this.i19 = li32(this.i12);
                     this.i20 = li32(this.i7);
                     this.i19 = this.i20 + this.i19;
                     this.i1 = this.i19 + this.i1;
                     this.i1 <<= 2;
                     this.i1 += this.i18;
                     this.i1 <<= 2;
                     this.i1 = this.i0 + this.i1;
                     mstate.esp -= 8;
                     this.i1 += 3156;
                     si32(this.i8,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     state = 13;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
                  break;
               }
               this.i1 = 0;
               mstate.esp -= 8;
               si32(this.i5,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
               break;
            case 7:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,_val_2E_1440);
               break;
            case 8:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i5 = 79;
               si32(this.i5,_val_2E_1440);
               break;
            case 9:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i5 = 79;
               si32(this.i5,_val_2E_1440);
               break;
            case 10:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i5 = 79;
               si32(this.i5,_val_2E_1440);
               break;
            case 11:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i5 = 79;
               si32(this.i5,_val_2E_1440);
               break;
            case 12:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = 79;
               si32(this.i0,_val_2E_1440);
               break;
            case 13:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               if(this.i1 == 0)
               {
                  this.i1 = 0;
                  this.i6 = li32(_val_2E_1440);
                  mstate.esp -= 8;
                  si32(this.i5,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 14;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               this.i0 = 82;
               this.i8 = this.i1 + 3156;
               si32(this.i8,this.i1 + 3148);
               this.i8 = 117;
               this.i18 = 110;
               this.i19 = 101;
               this.i20 = 77;
               this.i21 = 97;
               this.i22 = 103;
               this.i23 = 105;
               si8(this.i0,this.i1);
               si8(this.i8,this.i1 + 1);
               si8(this.i18,this.i1 + 2);
               si8(this.i19,this.i1 + 3);
               si8(this.i20,this.i1 + 4);
               si8(this.i21,this.i1 + 5);
               si8(this.i22,this.i1 + 6);
               si8(this.i23,this.i1 + 7);
               this.i0 = this.i1 + 8;
               this.i8 = this.i10 + 8;
               this.i10 = 32;
               memcpy(this.i0,this.i8,this.i10);
               this.i0 = 0;
               si32(this.i0,this.i1 + 48);
               this.i8 = li32(this.i13);
               si32(this.i8,this.i1 + 3152);
               this.i8 = li32(this.i12);
               si32(this.i8,this.i1 + 3124);
               this.i7 = li32(this.i7);
               si32(this.i7,this.i1 + 3132);
               this.i6 = li32(this.i6);
               si32(this.i6,this.i1 + 3140);
               this.i10 = this.i1 + 3140;
               this.i12 = this.i1 + 3132;
               this.i13 = this.i1 + 3124;
               this.i18 = this.i1 + 3152;
               this.i19 = this.i1 + 3148;
               this.i20 = this.i1;
               this.i21 = this.i0;
               do
               {
                  this.i22 = this.i9 + this.i21;
                  this.i23 = li32(this.i22 + 40);
                  this.i24 = this.i20 + this.i21;
                  si32(this.i23,this.i24 + 52);
                  this.i23 = li32(this.i22 + 1064);
                  si32(this.i23,this.i24 + 1076);
                  this.i22 = li32(this.i22 + 2088);
                  si32(this.i22,this.i24 + 2100);
                  this.i21 += 4;
                  this.i0 += 1;
               }
               while(this.i0 != 256);
               
               this.i0 = li32(this.i19);
               this.i9 = this.i7 + this.i6;
               this.i7 = this.i8 + this.i7;
               this.i20 = this.i8 << 4;
               this.i9 = this.i8 + this.i9;
               this.i7 <<= 4;
               si32(this.i0,this.i1 + 3128);
               this.i20 = this.i0 + this.i20;
               this.i6 = this.i17 + this.i6;
               this.i9 <<= 4;
               si32(this.i20,this.i1 + 3136);
               this.i7 = this.i0 + this.i7;
               si32(this.i7,this.i1 + 3144);
               this.i7 = this.i0 + this.i9;
               this.i6 *= 12;
               si32(this.i7,this.i19);
               this.i7 = this.i1 + 3128;
               this.i9 = this.i1 + 3136;
               this.i17 = this.i1 + 3144;
               this.i6 = this.i15 + this.i6;
               if(this.i8 <= 0)
               {
                  this.i0 = this.i6;
               }
               else
               {
                  this.i8 = 0;
                  this.i15 = this.i14;
                  do
                  {
                     this.i20 = li32(this.i15);
                     si32(this.i20,this.i0);
                     this.i21 = li32(this.i15 + 4);
                     si32(this.i21,this.i0 + 4);
                     this.i22 = li32(this.i15 + 8);
                     si32(this.i22,this.i0 + 8);
                     if(this.i22 == 0)
                     {
                        this.i22 = this.i21 - this.i20;
                        this.i22 += 1;
                        this.i23 = li32(this.i19);
                        this.i24 = this.i22 << 2;
                        si32(this.i23,this.i0 + 12);
                        this.i23 += this.i24;
                        si32(this.i23,this.i19);
                        this.i23 = this.i0 + 12;
                        this.i24 = this.i6 + this.i24;
                        if(this.i22 > 0)
                        {
                           this.i20 = this.i21 - this.i20;
                           this.i21 = this.i20 << 2;
                           this.i20 += 1;
                           do
                           {
                              this.i22 = this.i6 + this.i21;
                              this.i25 = li32(this.i23);
                              this.i22 = li32(this.i22);
                              this.i25 += this.i21;
                              si32(this.i22,this.i25);
                              this.i21 += -4;
                              this.i20 += -1;
                           }
                           while(this.i20 >= 1);
                           
                        }
                        this.i6 = this.i24;
                     }
                     else
                     {
                        this.i20 = 0;
                        si32(this.i20,this.i0 + 12);
                     }
                     this.i20 = li32(this.i13);
                     this.i0 += 16;
                     this.i15 += 12;
                     this.i8 += 1;
                  }
                  while(this.i20 > this.i8);
                  
                  this.i0 = this.i6;
               }
               this.i6 = li32(this.i9);
               this.i8 = li32(this.i12);
               if(this.i8 >= 1)
               {
                  this.i8 = 0;
                  this.i15 = this.i11 * 12;
                  this.i15 = this.i14 + this.i15;
                  do
                  {
                     this.i20 = li32(this.i15);
                     si32(this.i20,this.i6);
                     this.i20 = li32(this.i15 + 4);
                     si32(this.i20,this.i6 + 4);
                     this.i20 = li32(this.i15 + 8);
                     si32(this.i20,this.i6 + 8);
                     this.i20 = li32(this.i12);
                     this.i6 += 16;
                     this.i15 += 12;
                     this.i8 += 1;
                  }
                  while(this.i20 > this.i8);
                  
               }
               this.i6 = li32(this.i17);
               this.i8 = li32(this.i10);
               if(this.i8 >= 1)
               {
                  this.i8 = 0;
                  this.i11 += this.i16;
                  this.i11 *= 12;
                  this.i11 = this.i14 + this.i11;
                  do
                  {
                     this.i14 = li32(this.i11);
                     si32(this.i14,this.i6);
                     this.i14 = li32(this.i11 + 4);
                     si32(this.i14,this.i6 + 4);
                     this.i14 = li32(this.i11 + 8);
                     si32(this.i14,this.i6 + 8);
                     this.i14 = li32(this.i10);
                     this.i6 += 16;
                     this.i11 += 12;
                     this.i8 += 1;
                  }
                  while(this.i14 > this.i8);
                  
               }
               this.i6 = 0;
               this.i8 = li32(this.i18);
               this.i11 = li32(this.i19);
               memcpy(this.i11,this.i0,this.i8);
               mstate.esp -= 8;
               si32(this.i5,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               state = 15;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
               break;
            case 14:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               si32(this.i6,_val_2E_1440);
               break;
            case 15:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i18);
               if(this.i0 == 0)
               {
                  this.i0 = 0;
                  si32(this.i0,this.i19);
               }
               this.i0 = li32(this.i13);
               if(this.i0 == 0)
               {
                  this.i0 = 0;
                  si32(this.i0,this.i7);
               }
               this.i0 = li32(this.i12);
               if(this.i0 == 0)
               {
                  this.i0 = 0;
                  si32(this.i0,this.i9);
               }
               this.i0 = li32(this.i10);
               if(this.i0 != 0)
               {
                  break;
               }
               this.i0 = 0;
               si32(this.i0,this.i17);
               break;
            case 16:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i2 == 0 ? 79 : int(this.i2);
               §§goto(addr5341);
            case 17:
               this.i4 = mstate.eax;
               mstate.esp += 4;
               si32(this.i5,___mbrtowc);
               si32(this.i5,___mbsinit);
               this.i4 = ___mbsnrtowcs_std;
               si32(this.i4,___mbsnrtowcs);
               si32(this.i5,___wcrtomb);
               this.i4 = ___wcsnrtombs_std;
               si32(this.i4,___wcsnrtombs);
               si32(this.i5,this.i0 + 44);
               si32(this.i5,this.i0 + 40);
               this.i4 = li8(this.i0 + 8);
               if(this.i4 != 78)
               {
                  this.i5 = __2E_str547;
                  this.i6 = this.i4;
               }
               else
               {
                  this.i5 = __2E_str547;
                  this.i6 = 0;
                  this.i7 = this.i4;
                  while(true)
                  {
                     this.i8 = this.i5 + this.i6;
                     this.i8 += 1;
                     this.i7 &= 255;
                     if(this.i7 == 0)
                     {
                        break;
                     }
                     this.i7 = this.i1 + this.i6;
                     this.i7 = li8(this.i7 + 9);
                     this.i8 = li8(this.i8);
                     this.i6 += 1;
                     if(this.i7 == this.i8)
                     {
                        continue;
                     }
                     this.i5 = __2E_str547;
                     this.i5 += this.i6;
                     this.i6 = this.i7;
                  }
                  §§goto(addr3936);
               }
               this.i5 = li8(this.i5);
               this.i6 &= 255;
               if(this.i6 != this.i5)
               {
                  this.i5 = this.i4 & 255;
                  if(this.i5 != 85)
                  {
                     this.i5 = __2E_str648;
                     this.i6 = this.i4;
                  }
                  else
                  {
                     this.i5 = __2E_str648;
                     this.i6 = 0;
                     this.i7 = this.i4;
                     while(true)
                     {
                        this.i8 = this.i5 + this.i6;
                        this.i8 += 1;
                        this.i7 &= 255;
                        if(this.i7 != 0)
                        {
                           this.i7 = this.i1 + this.i6;
                           this.i7 = li8(this.i7 + 9);
                           this.i8 = li8(this.i8);
                           this.i6 += 1;
                           if(this.i7 == this.i8)
                           {
                              continue;
                           }
                           addr4157:
                           this.i5 = __2E_str648;
                           this.i5 += this.i6;
                           this.i6 = this.i7;
                           this.i5 = li8(this.i5);
                           this.i6 &= 255;
                           if(this.i6 == this.i5)
                           {
                              break;
                           }
                           this.i5 = this.i4 & 255;
                           if(this.i5 != 69)
                           {
                              this.i5 = __2E_str749;
                              this.i6 = this.i4;
                           }
                           else
                           {
                              this.i5 = __2E_str749;
                              this.i6 = 0;
                              this.i7 = this.i4;
                              while(true)
                              {
                                 this.i8 = this.i5 + this.i6;
                                 this.i8 += 1;
                                 this.i7 &= 255;
                                 if(this.i7 != 0)
                                 {
                                    this.i7 = this.i1 + this.i6;
                                    this.i7 = li8(this.i7 + 9);
                                    this.i8 = li8(this.i8);
                                    this.i6 += 1;
                                    if(this.i7 == this.i8)
                                    {
                                       continue;
                                    }
                                    this.i5 = __2E_str749;
                                    this.i5 += this.i6;
                                    this.i6 = this.i7;
                                 }
                                 break;
                              }
                              addr3935:
                              §§goto(addr3936);
                           }
                           this.i5 = li8(this.i5);
                           this.i6 &= 255;
                           if(this.i6 != this.i5)
                           {
                              this.i5 = this.i4 & 255;
                              if(this.i5 != 71)
                              {
                                 this.i5 = __2E_str850;
                                 this.i6 = this.i4;
                                 addr4464:
                                 this.i5 = li8(this.i5);
                                 this.i6 &= 255;
                                 if(this.i6 != this.i5)
                                 {
                                    this.i5 = this.i4 & 255;
                                    if(this.i5 != 71)
                                    {
                                       this.i5 = __2E_str951;
                                       this.i6 = this.i4;
                                       addr4586:
                                       this.i5 = li8(this.i5);
                                       this.i6 &= 255;
                                       if(this.i6 != this.i5)
                                       {
                                          this.i5 = this.i4 & 255;
                                          if(this.i5 != 71)
                                          {
                                             this.i5 = __2E_str1052;
                                             this.i6 = this.i4;
                                             addr4708:
                                             this.i5 = li8(this.i5);
                                             this.i6 &= 255;
                                             if(this.i6 != this.i5)
                                             {
                                                this.i5 = this.i4 & 255;
                                                if(this.i5 != 66)
                                                {
                                                   this.i5 = __2E_str1153;
                                                   this.i6 = this.i4;
                                                   §§goto(addr4830);
                                                }
                                                else
                                                {
                                                   this.i5 = __2E_str1153;
                                                   this.i6 = 0;
                                                   this.i7 = this.i4;
                                                   while(true)
                                                   {
                                                      this.i8 = this.i5 + this.i6;
                                                      this.i8 += 1;
                                                      this.i7 &= 255;
                                                      if(this.i7 != 0)
                                                      {
                                                         this.i7 = this.i1 + this.i6;
                                                         this.i7 = li8(this.i7 + 9);
                                                         this.i8 = li8(this.i8);
                                                         this.i6 += 1;
                                                         if(this.i7 != this.i8)
                                                         {
                                                            this.i5 = __2E_str1153;
                                                            this.i5 += this.i6;
                                                            this.i6 = this.i7;
                                                            addr4830:
                                                            this.i5 = li8(this.i5);
                                                            this.i6 &= 255;
                                                         }
                                                         continue;
                                                         if(this.i6 != this.i5)
                                                         {
                                                            this.i5 = this.i4 & 255;
                                                            if(this.i5 != 77)
                                                            {
                                                               this.i1 = __2E_str12163;
                                                            }
                                                            else
                                                            {
                                                               this.i5 = __2E_str12163;
                                                               this.i6 = 0;
                                                               while(true)
                                                               {
                                                                  this.i7 = this.i5 + this.i6;
                                                                  this.i7 += 1;
                                                                  this.i4 &= 255;
                                                                  if(this.i4 != 0)
                                                                  {
                                                                     this.i4 = this.i1 + this.i6;
                                                                     this.i4 = li8(this.i4 + 9);
                                                                     this.i7 = li8(this.i7);
                                                                     this.i6 += 1;
                                                                     if(this.i4 == this.i7)
                                                                     {
                                                                        continue;
                                                                     }
                                                                     addr4940:
                                                                     this.i1 = __2E_str12163;
                                                                     this.i1 += this.i6;
                                                                     this.i1 = li8(this.i1);
                                                                     this.i4 &= 255;
                                                                     if(this.i4 == this.i1)
                                                                     {
                                                                        break;
                                                                     }
                                                                     this.i1 = 79;
                                                                     if(this.i1 != 0)
                                                                     {
                                                                        this.i2 = this.i1;
                                                                        §§goto(addr3936);
                                                                     }
                                                                     else
                                                                     {
                                                                        this.i0 = this.i1;
                                                                        addr4978:
                                                                        this.i1 = li32(_CachedRuneLocale_2E_3155);
                                                                        this.i4 = this.i1;
                                                                        if(this.i1 != 0)
                                                                        {
                                                                           this.i5 = li8(this.i4 + 8);
                                                                           if(this.i5 == 69)
                                                                           {
                                                                              this.i6 = __2E_str749;
                                                                              this.i7 = 0;
                                                                              while(true)
                                                                              {
                                                                                 this.i8 = this.i6 + this.i7;
                                                                                 this.i8 += 1;
                                                                                 this.i5 &= 255;
                                                                                 if(this.i5 != 0)
                                                                                 {
                                                                                    this.i5 = this.i1 + this.i7;
                                                                                    this.i5 = li8(this.i5 + 9);
                                                                                    this.i8 = li8(this.i8);
                                                                                    this.i7 += 1;
                                                                                    if(this.i5 != this.i8)
                                                                                    {
                                                                                       this.i1 = __2E_str749;
                                                                                       this.i1 += this.i7;
                                                                                       this.i1 = li8(this.i1);
                                                                                       this.i5 &= 255;
                                                                                       if(this.i5 == this.i1)
                                                                                       {
                                                                                          break;
                                                                                       }
                                                                                       addr5155:
                                                                                       this.i1 = 0;
                                                                                       mstate.esp -= 8;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       addr5086:
                                                                                    }
                                                                                    continue;
                                                                                    si32(this.i4,mstate.esp);
                                                                                    si32(this.i1,mstate.esp + 4);
                                                                                    state = 20;
                                                                                    mstate.esp -= 4;
                                                                                    FSM_pubrealloc.start();
                                                                                    return;
                                                                                 }
                                                                                 break;
                                                                              }
                                                                              this.i1 = 0;
                                                                              this.i5 = li32(this.i4 + 3148);
                                                                              mstate.esp -= 8;
                                                                              si32(this.i5,mstate.esp);
                                                                              si32(this.i1,mstate.esp + 4);
                                                                              state = 19;
                                                                              mstate.esp -= 4;
                                                                              FSM_pubrealloc.start();
                                                                              return;
                                                                           }
                                                                           this.i1 = __2E_str749;
                                                                           §§goto(addr5086);
                                                                        }
                                                                        else
                                                                        {
                                                                           addr5199:
                                                                           this.i1 = li32(__CurrentRuneLocale);
                                                                           si32(this.i1,_CachedRuneLocale_2E_3155);
                                                                           this.i1 = li32(___mb_cur_max);
                                                                           si32(this.i1,_Cached__mb_cur_max_2E_3156);
                                                                           this.i1 = li32(___mbrtowc);
                                                                           si32(this.i1,_Cached__mbrtowc_2E_3161);
                                                                           this.i1 = li32(___mbsinit);
                                                                           si32(this.i1,_Cached__mbsinit_2E_3167);
                                                                           this.i1 = li32(___mbsnrtowcs);
                                                                           si32(this.i1,_Cached__mbsnrtowcs_2E_3173);
                                                                           this.i1 = li32(___wcrtomb);
                                                                           si32(this.i1,_Cached__wcrtomb_2E_3165);
                                                                           this.i1 = li32(___wcsnrtombs);
                                                                           si32(this.i1,_Cached__wcsnrtombs_2E_3179);
                                                                           this.i2 = li8(this.i2);
                                                                           si8(this.i2,_ctype_encoding_2E_3154);
                                                                           if(this.i2 != 0)
                                                                           {
                                                                              this.i2 = _ctype_encoding_2E_3154;
                                                                              this.i1 = 1;
                                                                              do
                                                                              {
                                                                                 this.i4 = this.i3 + this.i1;
                                                                                 this.i4 = li8(this.i4);
                                                                                 this.i5 = this.i2 + this.i1;
                                                                                 si8(this.i4,this.i5);
                                                                                 this.i1 += 1;
                                                                              }
                                                                              while(this.i4 != 0);
                                                                              
                                                                           }
                                                                           if(this.i0 != 0)
                                                                           {
                                                                              this.i2 = this.i0;
                                                                              §§goto(addr5341);
                                                                           }
                                                                           else
                                                                           {
                                                                              §§goto(addr742);
                                                                           }
                                                                        }
                                                                     }
                                                                  }
                                                                  break;
                                                               }
                                                               this.i1 = -1;
                                                               §§goto(addr4964);
                                                            }
                                                            §§goto(addr4940);
                                                         }
                                                         else
                                                         {
                                                            §§goto(addr3935);
                                                         }
                                                         si32(this.i1,mstate.esp + 4);
                                                         state = 18;
                                                         mstate.esp -= 4;
                                                         FSM_pubrealloc.start();
                                                         return;
                                                      }
                                                      §§goto(addr3935);
                                                   }
                                                }
                                             }
                                             §§goto(addr3935);
                                          }
                                          else
                                          {
                                             this.i5 = __2E_str1052;
                                             this.i6 = 0;
                                             this.i7 = this.i4;
                                             while(true)
                                             {
                                                this.i8 = this.i5 + this.i6;
                                                this.i8 += 1;
                                                this.i7 &= 255;
                                                if(this.i7 != 0)
                                                {
                                                   this.i7 = this.i1 + this.i6;
                                                   this.i7 = li8(this.i7 + 9);
                                                   this.i8 = li8(this.i8);
                                                   this.i6 += 1;
                                                   if(this.i7 == this.i8)
                                                   {
                                                      continue;
                                                   }
                                                   this.i5 = __2E_str1052;
                                                   this.i5 += this.i6;
                                                   this.i6 = this.i7;
                                                   §§goto(addr4708);
                                                }
                                                §§goto(addr3935);
                                             }
                                          }
                                       }
                                       §§goto(addr3935);
                                    }
                                    else
                                    {
                                       this.i5 = __2E_str951;
                                       this.i6 = 0;
                                       this.i7 = this.i4;
                                       while(true)
                                       {
                                          this.i8 = this.i5 + this.i6;
                                          this.i8 += 1;
                                          this.i7 &= 255;
                                          if(this.i7 != 0)
                                          {
                                             this.i7 = this.i1 + this.i6;
                                             this.i7 = li8(this.i7 + 9);
                                             this.i8 = li8(this.i8);
                                             this.i6 += 1;
                                             if(this.i7 == this.i8)
                                             {
                                                continue;
                                             }
                                             this.i5 = __2E_str951;
                                             this.i5 += this.i6;
                                             this.i6 = this.i7;
                                             §§goto(addr4586);
                                          }
                                          §§goto(addr3935);
                                       }
                                    }
                                 }
                                 §§goto(addr3935);
                              }
                              else
                              {
                                 this.i5 = __2E_str850;
                                 this.i6 = 0;
                                 this.i7 = this.i4;
                                 while(true)
                                 {
                                    this.i8 = this.i5 + this.i6;
                                    this.i8 += 1;
                                    this.i7 &= 255;
                                    if(this.i7 != 0)
                                    {
                                       this.i7 = this.i1 + this.i6;
                                       this.i7 = li8(this.i7 + 9);
                                       this.i8 = li8(this.i8);
                                       this.i6 += 1;
                                       if(this.i7 == this.i8)
                                       {
                                          continue;
                                       }
                                       this.i5 = __2E_str850;
                                       this.i5 += this.i6;
                                       this.i6 = this.i7;
                                       §§goto(addr4464);
                                    }
                                    §§goto(addr3935);
                                 }
                              }
                           }
                           §§goto(addr3935);
                        }
                        break;
                     }
                     this.i1 = __UTF8_mbrtowc;
                     si32(this.i1,___mbrtowc);
                     this.i1 = __UTF8_wcrtomb;
                     si32(this.i1,___wcrtomb);
                     this.i1 = __UTF8_mbsinit;
                     si32(this.i1,___mbsinit);
                     this.i1 = __UTF8_mbsnrtowcs;
                     si32(this.i1,___mbsnrtowcs);
                     this.i1 = __UTF8_wcsnrtombs;
                     si32(this.i1,___wcsnrtombs);
                     si32(this.i0,__CurrentRuneLocale);
                     this.i0 = 6;
                     si32(this.i0,___mb_cur_max);
                     this.i0 = 0;
                     §§goto(addr4978);
                  }
                  §§goto(addr4157);
               }
               §§goto(addr3935);
            case 18:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr734);
            case 19:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr5155);
            case 20:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr5199);
            case 22:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = 79;
               si32(this.i0,_val_2E_1440);
               break;
            default:
               throw "Invalid state in ___wrap_setrunelocale";
         }
         this.i0 = this.i1;
         this.i1 = this.i0;
         if(this.i0 == 0)
         {
            this.i2 = li32(_val_2E_1440);
            mstate.esp -= 4;
            si32(this.i4,mstate.esp);
            state = 16;
            mstate.esp -= 4;
            FSM_fclose.start();
            return;
         }
         this.i5 = 0;
         mstate.esp -= 4;
         si32(this.i4,mstate.esp);
         state = 17;
         mstate.esp -= 4;
         FSM_fclose.start();
      }
   }
}
