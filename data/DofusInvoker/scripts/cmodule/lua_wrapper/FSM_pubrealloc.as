package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_pubrealloc extends Machine
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
      
      public function FSM_pubrealloc()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_pubrealloc = null;
         _loc1_ = new FSM_pubrealloc();
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
               mstate.esp -= 4096;
               this.i0 = li32(_malloc_active_2E_3509);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 12);
               if(this.i0 >= 1)
               {
                  if(this.i0 == 1)
                  {
                     this.i2 = 2;
                     si32(this.i2,_malloc_active_2E_3509);
                  }
                  this.i2 = 88;
                  si32(this.i2,_val_2E_1440);
                  this.i2 = 0;
               }
               else
               {
                  this.i0 = 1;
                  si32(this.i0,_malloc_active_2E_3509);
                  this.i0 = li8(_malloc_started_2E_3510_2E_b);
                  if(this.i0 == 0)
                  {
                     if(this.i2 == 0)
                     {
                        this.i0 = 0;
                        this.i4 = li32(_val_2E_1440);
                        this.i5 = mstate.ebp + -4096;
                        loop0:
                        while(true)
                        {
                           this.i6 = this.i0;
                           if(this.i6 != 1)
                           {
                              if(this.i6 == 0)
                              {
                                 break;
                              }
                           }
                           else
                           {
                              this.i0 = __2E_str876;
                              this.i1 = 4;
                              log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                              mstate.esp -= 4;
                              this.i0 = __2E_str113335;
                              si32(this.i0,mstate.esp);
                              mstate.esp -= 4;
                              FSM_getenv.start();
                              while(true)
                              {
                                 this.i0 = mstate.eax;
                                 mstate.esp += 4;
                                 if(this.i0 != 0)
                                 {
                                    this.i1 = li32(_malloc_cache);
                                    this.i7 = li8(_malloc_hint_2E_b);
                                    this.i8 = li8(_malloc_realloc_2E_b);
                                    this.i9 = li8(_malloc_junk_2E_b);
                                    this.i10 = li8(_malloc_sysv_2E_b);
                                    this.i11 = li8(_malloc_zero_2E_b);
                                    while(true)
                                    {
                                       this.i12 = this.i1;
                                       this.i1 = li8(this.i0);
                                       if(this.i1 == 0)
                                       {
                                          this.i0 = this.i11;
                                          this.i1 = this.i12;
                                          break;
                                       }
                                       this.i1 <<= 24;
                                       this.i1 >>= 24;
                                       if(this.i1 <= 89)
                                       {
                                          if(this.i1 <= 73)
                                          {
                                             if(this.i1 == 60)
                                             {
                                                this.i0 += 1;
                                                this.i1 = this.i12 >>> 1;
                                                if(this.i0 == 0)
                                                {
                                                   this.i0 = this.i11;
                                                }
                                                continue;
                                                break;
                                             }
                                             if(this.i1 == 62)
                                             {
                                                this.i0 += 1;
                                                this.i1 = this.i12 << 1;
                                                if(this.i0 == 0)
                                                {
                                                   this.i0 = this.i11;
                                                }
                                                continue;
                                                break;
                                             }
                                             if(this.i1 == 72)
                                             {
                                                this.i0 += 1;
                                                if(this.i0 == 0)
                                                {
                                                   this.i1 = 1;
                                                   this.i0 = this.i11;
                                                   this.i7 = this.i1;
                                                }
                                                this.i1 = 1;
                                                this.i7 = this.i1;
                                                this.i1 = this.i12;
                                                continue;
                                                this.i1 = this.i12;
                                                break;
                                             }
                                          }
                                          else
                                          {
                                             if(this.i1 == 74)
                                             {
                                                this.i0 += 1;
                                                if(this.i0 == 0)
                                                {
                                                   this.i1 = 1;
                                                   this.i0 = this.i11;
                                                   this.i9 = this.i1;
                                                }
                                                this.i1 = 1;
                                                this.i9 = this.i1;
                                                this.i1 = this.i12;
                                                continue;
                                                this.i1 = this.i12;
                                                break;
                                             }
                                             if(this.i1 == 82)
                                             {
                                                this.i0 += 1;
                                                if(this.i0 == 0)
                                                {
                                                   this.i1 = 1;
                                                   this.i0 = this.i11;
                                                   this.i8 = this.i1;
                                                }
                                                this.i1 = 1;
                                                this.i8 = this.i1;
                                                this.i1 = this.i12;
                                                continue;
                                                this.i1 = this.i12;
                                                break;
                                             }
                                             if(this.i1 == 86)
                                             {
                                                this.i0 += 1;
                                                if(this.i0 == 0)
                                                {
                                                   this.i1 = 1;
                                                   this.i0 = this.i11;
                                                   this.i10 = this.i1;
                                                }
                                                this.i1 = 1;
                                                this.i10 = this.i1;
                                                this.i1 = this.i12;
                                                continue;
                                                this.i1 = this.i12;
                                                break;
                                             }
                                          }
                                       }
                                       else
                                       {
                                          if(this.i1 <= 113)
                                          {
                                             if(this.i1 != 90)
                                             {
                                                if(this.i1 == 104)
                                                {
                                                   this.i0 += 1;
                                                   if(this.i0 == 0)
                                                   {
                                                      this.i1 = 0;
                                                      this.i0 = this.i11;
                                                      this.i7 = this.i1;
                                                   }
                                                   this.i1 = 0;
                                                   this.i7 = this.i1;
                                                   this.i1 = this.i12;
                                                   continue;
                                                   this.i1 = this.i12;
                                                   break;
                                                }
                                                if(this.i1 == 106)
                                                {
                                                   this.i0 += 1;
                                                   if(this.i0 == 0)
                                                   {
                                                      this.i1 = 0;
                                                      this.i0 = this.i11;
                                                      this.i9 = this.i1;
                                                   }
                                                   this.i1 = 0;
                                                   this.i9 = this.i1;
                                                   this.i1 = this.i12;
                                                   continue;
                                                   this.i1 = this.i12;
                                                   break;
                                                }
                                                addr497:
                                                this.i1 = this.i11;
                                             }
                                             else
                                             {
                                                this.i1 = 1;
                                             }
                                             this.i0 += 1;
                                             if(this.i0 == 0)
                                             {
                                                this.i0 = this.i1;
                                                this.i1 = this.i12;
                                             }
                                             this.i11 = this.i1;
                                             this.i1 = this.i12;
                                             continue;
                                             break;
                                          }
                                          if(this.i1 == 114)
                                          {
                                             this.i0 += 1;
                                             if(this.i0 == 0)
                                             {
                                                this.i1 = 0;
                                                this.i0 = this.i11;
                                                this.i8 = this.i1;
                                             }
                                             this.i1 = 0;
                                             this.i8 = this.i1;
                                             this.i1 = this.i12;
                                             continue;
                                             this.i1 = this.i12;
                                             break;
                                          }
                                          if(this.i1 == 118)
                                          {
                                             this.i0 += 1;
                                             if(this.i0 == 0)
                                             {
                                                this.i1 = 0;
                                                this.i0 = this.i11;
                                                this.i10 = this.i1;
                                             }
                                             this.i1 = 0;
                                             this.i10 = this.i1;
                                             this.i1 = this.i12;
                                             continue;
                                             this.i1 = this.i12;
                                             break;
                                          }
                                          if(this.i1 == 122)
                                          {
                                             this.i0 += 1;
                                             if(this.i0 == 0)
                                             {
                                                this.i0 = 0;
                                                this.i1 = this.i12;
                                             }
                                             this.i1 = 0;
                                             this.i11 = this.i1;
                                             this.i1 = this.i12;
                                             continue;
                                             break;
                                          }
                                       }
                                       §§goto(addr497);
                                    }
                                    si32(this.i1,_malloc_cache);
                                    si8(this.i7,_malloc_hint_2E_b);
                                    si8(this.i8,_malloc_realloc_2E_b);
                                    si8(this.i9,_malloc_junk_2E_b);
                                    si8(this.i10,_malloc_sysv_2E_b);
                                    si8(this.i0,_malloc_zero_2E_b);
                                 }
                              }
                              addr288:
                           }
                           addr900:
                           while(true)
                           {
                              this.i0 = this.i6 + 1;
                              if(this.i0 != 3)
                              {
                                 continue loop0;
                              }
                              addr1103:
                              this.i0 = li8(_malloc_zero_2E_b);
                              this.i0 ^= 1;
                              this.i0 &= 1;
                              if(this.i0 == 0)
                              {
                                 this.i0 = 1;
                                 si8(this.i0,_malloc_junk_2E_b);
                              }
                              this.i0 = __2E_str210;
                              this.i1 = 4;
                              this.i5 = 0;
                              log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                              this.i0 = _sbrk(this.i5);
                              this.i0 &= 4095;
                              this.i0 = 4096 - this.i0;
                              this.i0 &= 4095;
                              this.i0 = _sbrk(this.i0);
                              this.i0 = 4096;
                              this.i0 = _sbrk(this.i0);
                              si32(this.i0,_page_dir);
                              this.i0 = this.i5;
                              this.i0 = _sbrk(this.i0);
                              this.i0 += 4095;
                              this.i0 >>>= 12;
                              this.i0 += -12;
                              si32(this.i0,_malloc_origo);
                              this.i0 = 1024;
                              si32(this.i0,_malloc_ninfo);
                              this.i0 = li32(_malloc_cache);
                              if(this.i0 == 0)
                              {
                                 this.i0 += 1;
                                 si32(this.i0,_malloc_cache);
                              }
                              this.i1 = 20;
                              this.i0 <<= 12;
                              si32(this.i0,_malloc_cache);
                              mstate.esp -= 4;
                              si32(this.i1,mstate.esp);
                              mstate.esp -= 4;
                              FSM_imalloc.start();
                              this.i0 = mstate.eax;
                              mstate.esp += 4;
                              si32(this.i0,_px);
                              si32(this.i4,_val_2E_1440);
                              this.i0 = 1;
                              si8(this.i0,_malloc_started_2E_3510_2E_b);
                           }
                        }
                        this.i0 = __2E_str96;
                        mstate.esp -= 20;
                        this.i1 = __2E_str13;
                        this.i7 = 99;
                        this.i8 = 22;
                        si32(this.i5,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i8,mstate.esp + 8);
                        si32(this.i1,mstate.esp + 12);
                        si32(this.i7,mstate.esp + 16);
                        state = 1;
                        mstate.esp -= 4;
                        FSM_sprintf.start();
                        return;
                     }
                     this.i2 = 0;
                     si32(this.i2,_malloc_active_2E_3509);
                     this.i3 = 88;
                     si32(this.i3,_val_2E_1440);
                     §§goto(addr77);
                  }
                  this.i0 = li8(_malloc_sysv_2E_b);
                  this.i1 = this.i2 == 2048 ? 0 : int(this.i2);
                  this.i0 ^= 1;
                  this.i0 &= 1;
                  if(this.i0 == 0)
                  {
                     if(this.i3 == 0)
                     {
                        if(this.i1 != 0)
                        {
                           this.i3 = 0;
                           mstate.esp -= 4;
                           si32(this.i1,mstate.esp);
                           mstate.esp -= 4;
                           FSM_ifree.start();
                           addr1208:
                           mstate.esp += 4;
                           si32(this.i3,_malloc_active_2E_3509);
                           this.i1 = this.i3;
                           this.i0 = this.i1;
                           this.i1 = this.i3;
                           break;
                        }
                        this.i1 = 0;
                        this.i3 = this.i1;
                     }
                     else
                     {
                        addr1232:
                        if(this.i3 == 0)
                        {
                           if(this.i1 != 0)
                           {
                              this.i3 = 0;
                              mstate.esp -= 4;
                              si32(this.i1,mstate.esp);
                              mstate.esp -= 4;
                              FSM_ifree.start();
                              addr1274:
                              mstate.esp += 4;
                              si32(this.i3,_malloc_active_2E_3509);
                              this.i1 = 2048;
                              this.i0 = this.i3;
                              break;
                           }
                           this.i3 = 2048;
                           this.i1 = 0;
                        }
                        else
                        {
                           if(this.i1 == 0)
                           {
                              this.i1 = 0;
                              mstate.esp -= 4;
                              si32(this.i3,mstate.esp);
                              mstate.esp -= 4;
                              FSM_imalloc.start();
                              addr1322:
                              this.i3 = mstate.eax;
                              mstate.esp += 4;
                              this.i0 = this.i3 == 0 ? 1 : 0;
                              si32(this.i1,_malloc_active_2E_3509);
                              this.i1 = this.i0 & 1;
                              this.i0 = this.i1;
                              this.i1 = this.i3;
                              break;
                           }
                           this.i0 = li32(_malloc_origo);
                           this.i2 = this.i1 >>> 12;
                           this.i4 = this.i2 - this.i0;
                           this.i5 = this.i1;
                           if(uint(this.i4) > uint(11))
                           {
                              this.i6 = li32(_last_index);
                              if(uint(this.i4) <= uint(this.i6))
                              {
                                 this.i6 = li32(_page_dir);
                                 this.i7 = this.i4 << 2;
                                 this.i7 = this.i6 + this.i7;
                                 this.i7 = li32(this.i7);
                                 this.i8 = this.i6;
                                 if(this.i7 == 2)
                                 {
                                    this.i5 &= 4095;
                                    if(this.i5 == 0)
                                    {
                                       this.i5 = this.i4 << 2;
                                       this.i5 += this.i8;
                                       this.i5 = li32(this.i5 + 4);
                                       if(this.i5 != 3)
                                       {
                                          this.i0 = 4096;
                                       }
                                       else
                                       {
                                          this.i5 = -1;
                                          this.i0 = this.i2 - this.i0;
                                          this.i0 <<= 2;
                                          this.i0 += this.i6;
                                          this.i0 += 8;
                                          do
                                          {
                                             this.i7 = li32(this.i0);
                                             this.i0 += 4;
                                             this.i5 += 1;
                                          }
                                          while(this.i7 == 3);
                                          
                                          this.i0 = this.i5 << 12;
                                          this.i0 += 8192;
                                       }
                                       this.i5 = li8(_malloc_realloc_2E_b);
                                       if(this.i5 == 0)
                                       {
                                          if(uint(this.i0) >= uint(this.i3))
                                          {
                                             this.i5 = this.i0 + -4096;
                                             if(uint(this.i5) < uint(this.i3))
                                             {
                                                this.i5 = li8(_malloc_junk_2E_b);
                                                if(this.i5 != 0)
                                                {
                                                   this.i5 = -48;
                                                   this.i7 = this.i1 + this.i3;
                                                   this.i0 -= this.i3;
                                                   this.i3 = this.i1 == 0 ? 1 : 0;
                                                   memset(this.i7,this.i5,this.i0);
                                                   this.i0 = 0;
                                                   si32(this.i0,_malloc_active_2E_3509);
                                                   this.i0 = this.i3 & 1;
                                                   break;
                                                }
                                                addr2095:
                                                this.i0 = this.i1;
                                                this.i1 = this.i0 == 0 ? 1 : 0;
                                                this.i1 &= 1;
                                                this.i3 = this.i0;
                                                this.i0 = this.i1;
                                                this.i1 = this.i3;
                                                this.i2 = 0;
                                                si32(this.i2,_malloc_active_2E_3509);
                                                break;
                                                addr1651:
                                             }
                                             §§goto(addr2095);
                                          }
                                       }
                                       addr1580:
                                       mstate.esp -= 4;
                                       si32(this.i3,mstate.esp);
                                       mstate.esp -= 4;
                                       FSM_imalloc.start();
                                       this.i2 = mstate.eax;
                                       mstate.esp += 4;
                                       if(this.i2 == 0)
                                       {
                                          this.i1 = this.i2;
                                       }
                                       else
                                       {
                                          if(this.i0 != 0)
                                          {
                                             if(this.i3 != 0)
                                             {
                                                if(uint(this.i0) < uint(this.i3))
                                                {
                                                   this.i3 = 0;
                                                   this.i4 = this.i2;
                                                   this.i5 = this.i1;
                                                   memcpy(this.i4,this.i5,this.i0);
                                                   mstate.esp -= 4;
                                                   si32(this.i1,mstate.esp);
                                                   mstate.esp -= 4;
                                                   FSM_ifree.start();
                                                   addr2014:
                                                   mstate.esp += 4;
                                                   this.i1 = this.i2 == 0 ? 1 : 0;
                                                   si32(this.i3,_malloc_active_2E_3509);
                                                   this.i1 &= 1;
                                                   this.i0 = this.i1;
                                                   this.i1 = this.i2;
                                                   break;
                                                }
                                                this.i0 = this.i2;
                                                this.i4 = this.i1;
                                                memcpy(this.i0,this.i4,this.i3);
                                             }
                                          }
                                          mstate.esp -= 4;
                                          si32(this.i1,mstate.esp);
                                          mstate.esp -= 4;
                                          FSM_ifree.start();
                                          addr2085:
                                          mstate.esp += 4;
                                          this.i1 = this.i2;
                                       }
                                    }
                                    else
                                    {
                                       addr1394:
                                       this.i1 = 0;
                                       addr1393:
                                    }
                                    §§goto(addr2095);
                                 }
                                 else if(uint(this.i7) >= uint(4))
                                 {
                                    this.i0 = li16(this.i7 + 8);
                                    this.i2 = this.i0;
                                    this.i4 = this.i0 + -1;
                                    this.i4 &= this.i5;
                                    if(this.i4 == 0)
                                    {
                                       this.i4 = 1;
                                       this.i6 = li16(this.i7 + 10);
                                       this.i5 &= 4095;
                                       this.i5 >>>= this.i6;
                                       this.i6 = this.i5 & -32;
                                       this.i6 >>>= 3;
                                       this.i5 &= 31;
                                       this.i6 = this.i7 + this.i6;
                                       this.i6 = li32(this.i6 + 16);
                                       this.i4 <<= this.i5;
                                       this.i4 &= this.i6;
                                       if(this.i4 == 0)
                                       {
                                          this.i4 = li8(_malloc_realloc_2E_b);
                                          if(uint(this.i2) >= uint(this.i3))
                                          {
                                             this.i4 ^= 1;
                                             this.i4 &= 1;
                                             if(this.i4 != 0)
                                             {
                                                this.i4 = this.i2 >>> 1;
                                                if(uint(this.i4) >= uint(this.i3))
                                                {
                                                   this.i0 &= 65535;
                                                   if(this.i0 != 16)
                                                   {
                                                      addr1850:
                                                      this.i0 = this.i2;
                                                      §§goto(addr1580);
                                                   }
                                                   §§goto(addr2095);
                                                }
                                                this.i0 = li8(_malloc_junk_2E_b);
                                                this.i0 ^= 1;
                                                this.i0 &= 1;
                                                if(this.i0 == 0)
                                                {
                                                   this.i0 = -48;
                                                   this.i4 = this.i1 + this.i3;
                                                   this.i3 = this.i2 - this.i3;
                                                   this.i2 = this.i1 == 0 ? 1 : 0;
                                                   memset(this.i4,this.i0,this.i3);
                                                   this.i0 = 0;
                                                   si32(this.i0,_malloc_active_2E_3509);
                                                   this.i0 = this.i2 & 1;
                                                   break;
                                                }
                                                §§goto(addr1651);
                                             }
                                             §§goto(addr2095);
                                          }
                                          §§goto(addr1850);
                                       }
                                       else
                                       {
                                          §§goto(addr1393);
                                       }
                                    }
                                 }
                              }
                              §§goto(addr1393);
                           }
                           §§goto(addr1394);
                        }
                     }
                     §§goto(addr2095);
                  }
                  §§goto(addr1232);
               }
               §§goto(addr77);
            case 1:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i5;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i8,_val_2E_1440);
               §§goto(addr900);
            case 2:
               §§goto(addr288);
            case 3:
               §§goto(addr1103);
            case 5:
               §§goto(addr1274);
            case 4:
               §§goto(addr1208);
            case 6:
               §§goto(addr1322);
            case 7:
               §§goto(addr1580);
            case 9:
               §§goto(addr2085);
            case 8:
               §§goto(addr2014);
            default:
               throw "Invalid state in _pubrealloc";
         }
         if(this.i0 != 0)
         {
            this.i0 = 12;
            si32(this.i0,_val_2E_1440);
         }
         mstate.eax = this.i1;
         addr77:
         mstate.eax = this.i2;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
