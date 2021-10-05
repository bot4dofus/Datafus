package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM__fseeko extends Machine
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
      
      public function FSM__fseeko()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM__fseeko = null;
         _loc1_ = new FSM__fseeko();
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
               mstate.esp -= 8200;
               this.i2 = li32(mstate.ebp + 8);
               this.i0 = li32(this.i2 + 40);
               this.i1 = li32(mstate.ebp + 20);
               this.i3 = li32(mstate.ebp + 24);
               this.i4 = li32(mstate.ebp + 12);
               this.i5 = li32(mstate.ebp + 16);
               if(this.i0 == 0)
               {
                  addr76:
                  this.i0 = 29;
                  addr81:
                  si32(this.i0,_val_2E_1440);
                  this.i0 = -1;
               }
               else
               {
                  if(this.i1 == 0)
                  {
                     if(this.i5 <= -1)
                     {
                        addr336:
                        this.i0 = 22;
                        addr80:
                        §§goto(addr81);
                        addr405:
                     }
                     addr2583:
                     mstate.eax = this.i0;
                     break;
                  }
                  if(this.i1 != 2)
                  {
                     if(this.i1 == 1)
                     {
                        this.i1 = mstate.ebp + -8200;
                        mstate.esp -= 8;
                        si32(this.i2,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 1;
                        mstate.esp -= 4;
                        FSM__ftello.start();
                        return;
                     }
                     this.i1 = 22;
                     si32(this.i1,_val_2E_1440);
                     this.i1 = -1;
                     mstate.eax = this.i1;
                     break;
                  }
                  this.i6 = 0;
                  si32(this.i6,mstate.ebp + -8200);
                  si32(this.i6,mstate.ebp + -8196);
                  this.i6 = li32(this.i2 + 16);
                  if(this.i6 != 0)
                  {
                     this.i6 = 1;
                     this.i7 = this.i1;
                     this.i1 = this.i4;
                     this.i4 = this.i5;
                     §§goto(addr540);
                  }
                  else
                  {
                     this.i6 = 1;
                     this.i7 = this.i1;
                     this.i1 = this.i4;
                     this.i4 = this.i5;
                     §§goto(addr510);
                  }
               }
               §§goto(addr2583);
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               if(this.i1 != 0)
               {
                  addr162:
                  this.i0 = -1;
               }
               else
               {
                  this.i1 = li32(mstate.ebp + -8200);
                  this.i6 = li32(mstate.ebp + -8196);
                  if(this.i6 <= -1)
                  {
                     §§goto(addr76);
                  }
                  else
                  {
                     this.i7 = this.i5 < 0 ? 1 : 0;
                     this.i8 = this.i4 == 0 ? 1 : 0;
                     this.i9 = this.i5 == 0 ? 1 : 0;
                     this.i7 = this.i9 != 0 ? int(this.i8) : int(this.i7);
                     if(this.i7 == 0)
                     {
                        this.i7 = 2147483647;
                        this.i8 = -1;
                        this.i8 = __subc(this.i8,this.i4);
                        this.i7 = __sube(this.i7,this.i5);
                        this.i9 = this.i7 >= this.i6 ? 1 : 0;
                        this.i8 = uint(this.i8) >= uint(this.i1) ? 1 : 0;
                        this.i7 = this.i7 == this.i6 ? 1 : 0;
                        this.i7 = this.i7 != 0 ? int(this.i8) : int(this.i9);
                        if(this.i7 == 0)
                        {
                           §§goto(addr309);
                        }
                        §§goto(addr2583);
                     }
                     this.i1 = __addc(this.i1,this.i4);
                     this.i4 = __adde(this.i6,this.i5);
                     if(this.i4 <= -1)
                     {
                        §§goto(addr336);
                     }
                     else
                     {
                        this.i5 = this.i4 < 0 ? 1 : 0;
                        this.i6 = uint(this.i1) < uint(-2147483648) ? 1 : 0;
                        this.i7 = this.i4 == 0 ? 1 : 0;
                        this.i5 = this.i7 != 0 ? int(this.i6) : int(this.i5);
                        if(this.i5 == 0)
                        {
                           if(this.i3 != 0)
                           {
                              §§goto(addr397);
                           }
                           §§goto(addr2583);
                        }
                        this.i6 = li32(this.i2 + 16);
                        if(this.i6 == 0)
                        {
                           this.i6 = 0;
                           this.i7 = this.i6;
                           addr510:
                           mstate.esp -= 4;
                           si32(this.i2,mstate.esp);
                           state = 2;
                           mstate.esp -= 4;
                           FSM___smakebuf.start();
                           return;
                        }
                        this.i6 = 0;
                        this.i7 = this.i6;
                        §§goto(addr540);
                     }
                  }
               }
               §§goto(addr2583);
            case 2:
               mstate.esp += 4;
               addr540:
               this.i5 = this.i6;
               this.i6 = this.i7;
               this.i7 = this.i1;
               this.i1 = li16(this.i2 + 12);
               this.i8 = this.i2 + 12;
               this.i9 = this.i1 & 2074;
               if(this.i9 == 0)
               {
                  this.i1 &= 1024;
                  if(this.i1 == 0)
                  {
                     this.i5 = ___sseek;
                     if(this.i0 == this.i5)
                     {
                        this.i0 = li16(this.i2 + 14);
                        this.i5 = this.i0 << 16;
                        this.i5 >>= 16;
                        if(this.i5 >= 2)
                        {
                           this.i0 <<= 16;
                           this.i0 >>= 16;
                           state = 3;
                           addr639:
                           this.i0 = mstate.system.fsize(this.i0);
                           if(this.i0 <= -1)
                           {
                              this.i0 = __2E_str96;
                              mstate.esp -= 20;
                              this.i5 = __2E_str251;
                              this.i1 = 59;
                              this.i9 = 2;
                              this.i10 = mstate.ebp + -4096;
                              si32(this.i10,mstate.esp);
                              si32(this.i0,mstate.esp + 4);
                              si32(this.i9,mstate.esp + 8);
                              si32(this.i5,mstate.esp + 12);
                              si32(this.i1,mstate.esp + 16);
                              state = 4;
                              mstate.esp -= 4;
                              FSM_sprintf.start();
                              return;
                           }
                        }
                     }
                     §§goto(addr754);
                  }
                  else
                  {
                     if(this.i6 == 0)
                     {
                        this.i0 = this.i7;
                        this.i1 = this.i4;
                     }
                     else
                     {
                        this.i0 = li16(this.i2 + 14);
                        this.i1 = this.i0 << 16;
                        this.i1 >>= 16;
                        if(this.i1 <= 1)
                        {
                           this.i1 = 1;
                           this.i9 = this.i0;
                        }
                        else
                        {
                           this.i0 <<= 16;
                           this.i0 >>= 16;
                           state = 6;
                           addr872:
                           this.i0 = mstate.system.fsize(this.i0);
                           if(this.i0 <= -1)
                           {
                              this.i0 = __2E_str96;
                              mstate.esp -= 20;
                              this.i1 = __2E_str251;
                              this.i9 = 59;
                              this.i10 = 2;
                              this.i11 = mstate.ebp + -8192;
                              si32(this.i11,mstate.esp);
                              si32(this.i0,mstate.esp + 4);
                              si32(this.i10,mstate.esp + 8);
                              si32(this.i1,mstate.esp + 12);
                              si32(this.i9,mstate.esp + 16);
                              state = 7;
                              mstate.esp -= 4;
                              FSM_sprintf.start();
                              return;
                           }
                           this.i1 = 1;
                           this.i10 = this.i0 >> 31;
                           this.i9 = this.i0;
                           this.i0 = this.i10;
                        }
                        addr1008:
                        this.i1 ^= 1;
                        this.i1 &= 1;
                        if(this.i1 == 0)
                        {
                           this.i1 = this.i4 < 0 ? 1 : 0;
                           this.i10 = this.i7 == 0 ? 1 : 0;
                           this.i11 = this.i4 == 0 ? 1 : 0;
                           this.i1 = this.i11 != 0 ? int(this.i10) : int(this.i1);
                           if(this.i1 == 0)
                           {
                              this.i1 = 2147483647;
                              this.i10 = -1;
                              this.i10 = __subc(this.i10,this.i7);
                              this.i1 = __sube(this.i1,this.i4);
                              this.i11 = this.i0 <= this.i1 ? 1 : 0;
                              this.i10 = uint(this.i9) <= uint(this.i10) ? 1 : 0;
                              this.i1 = this.i0 == this.i1 ? 1 : 0;
                              this.i1 = this.i1 != 0 ? int(this.i10) : int(this.i11);
                              if(this.i1 == 0)
                              {
                                 addr309:
                                 this.i0 = 84;
                                 §§goto(addr80);
                                 addr1149:
                                 addr397:
                              }
                              §§goto(addr2583);
                           }
                           this.i1 = __addc(this.i9,this.i7);
                           this.i9 = __adde(this.i0,this.i4);
                           if(this.i9 <= -1)
                           {
                              §§goto(addr405);
                           }
                           else
                           {
                              this.i0 = this.i9 < 0 ? 1 : 0;
                              this.i10 = uint(this.i1) < uint(-2147483648) ? 1 : 0;
                              this.i11 = this.i9 == 0 ? 1 : 0;
                              this.i0 = this.i11 != 0 ? int(this.i10) : int(this.i0);
                              if(this.i0 == 0)
                              {
                                 if(this.i3 != 0)
                                 {
                                    §§goto(addr1149);
                                 }
                                 §§goto(addr2583);
                              }
                              this.i0 = this.i1;
                              this.i1 = this.i9;
                           }
                           §§goto(addr2583);
                        }
                        else
                        {
                           §§goto(addr2268);
                        }
                     }
                     this.i5 ^= 1;
                     this.i5 &= 1;
                     if(this.i5 == 0)
                     {
                        this.i5 = mstate.ebp + -8200;
                        mstate.esp -= 8;
                        si32(this.i2,mstate.esp);
                        si32(this.i5,mstate.esp + 4);
                        state = 8;
                        mstate.esp -= 4;
                        FSM__ftello.start();
                        return;
                     }
                     §§goto(addr1308);
                  }
               }
               §§goto(addr2268);
            case 3:
               §§goto(addr639);
            case 6:
               §§goto(addr872);
            case 4:
               mstate.esp += 20;
               this.i5 = 3;
               this.i0 = this.i10;
               this.i1 = this.i5;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i9,_val_2E_1440);
               addr754:
               this.i0 = li16(this.i8);
               this.i0 |= 2048;
               si16(this.i0,this.i8);
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 5;
               mstate.esp -= 4;
               FSM___sflush.start();
               return;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               if(this.i0 != 0)
               {
                  addr161:
                  §§goto(addr162);
               }
               else
               {
                  §§goto(addr2308);
               }
            case 7:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i11;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i10,_val_2E_1440);
               this.i1 = 0;
               this.i9 = this.i0;
               §§goto(addr1008);
            case 8:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               if(this.i5 == 0)
               {
                  addr1308:
                  this.i5 = li16(this.i8);
                  this.i5 &= 8192;
                  if(this.i5 == 0)
                  {
                     this.i5 = li32(this.i2 + 48);
                     this.i9 = this.i2 + 48;
                     if(this.i5 != 0)
                     {
                        this.i10 = 0;
                        this.i11 = li32(this.i2 + 4);
                        this.i12 = li32(mstate.ebp + -8200);
                        this.i13 = li32(mstate.ebp + -8196);
                        this.i14 = this.i11 >> 31;
                        this.i11 = __addc(this.i11,this.i12);
                        this.i12 = __adde(this.i14,this.i13);
                        si32(this.i11,mstate.ebp + -8200);
                        si32(this.i12,mstate.ebp + -8196);
                        this.i13 = li32(this.i2 + 56);
                        this.i13 = li32(this.i13);
                        this.i14 = li32(this.i2 + 16);
                        this.i13 -= this.i14;
                        this.i11 = __subc(this.i11,this.i13);
                        this.i10 = __sube(this.i12,this.i10);
                        si32(this.i11,mstate.ebp + -8200);
                        si32(this.i10,mstate.ebp + -8196);
                        this.i12 = this.i2 + 60;
                        this.i14 = this.i1 < this.i10 ? 1 : 0;
                        this.i15 = uint(this.i0) < uint(this.i11) ? 1 : 0;
                        this.i16 = this.i1 == this.i10 ? 1 : 0;
                        this.i14 = this.i16 != 0 ? int(this.i15) : int(this.i14);
                        if(this.i14 == 0)
                        {
                           addr1648:
                           this.i14 = 0;
                           this.i12 = li32(this.i12);
                           this.i12 += this.i13;
                           this.i13 = __addc(this.i12,this.i11);
                           this.i10 = __adde(this.i10,this.i14);
                           this.i14 = this.i10 <= this.i1 ? 1 : 0;
                           this.i13 = uint(this.i13) <= uint(this.i0) ? 1 : 0;
                           this.i10 = this.i10 == this.i1 ? 1 : 0;
                           this.i10 = this.i10 != 0 ? int(this.i13) : int(this.i14);
                           if(this.i10 == 0)
                           {
                              this.i1 = li32(this.i2 + 16);
                              this.i0 -= this.i11;
                              this.i1 += this.i0;
                              si32(this.i1,this.i2);
                              this.i0 = this.i12 - this.i0;
                              si32(this.i0,this.i2 + 4);
                              if(this.i5 != 0)
                              {
                                 this.i0 = this.i2 + 64;
                                 if(this.i5 != this.i0)
                                 {
                                    this.i0 = 0;
                                    mstate.esp -= 8;
                                    si32(this.i5,mstate.esp);
                                    si32(this.i0,mstate.esp + 4);
                                    state = 9;
                                    mstate.esp -= 4;
                                    FSM_pubrealloc.start();
                                    return;
                                 }
                                 addr1833:
                                 this.i0 = 0;
                                 si32(this.i0,this.i9);
                              }
                              this.i0 = 0;
                              this.i1 = li16(this.i8);
                              this.i1 &= -33;
                              si16(this.i1,this.i8);
                              this.i1 = li32(this.i2 + 56);
                              this.i1 += 20;
                              this.i2 = 128;
                              memset(this.i1,this.i0,this.i2);
                              §§goto(addr2583);
                           }
                        }
                     }
                     else
                     {
                        this.i10 = 0;
                        this.i11 = li32(this.i2);
                        this.i12 = li32(this.i2 + 16);
                        this.i13 = li32(mstate.ebp + -8200);
                        this.i14 = li32(mstate.ebp + -8196);
                        this.i15 = this.i11 - this.i12;
                        this.i11 = __subc(this.i13,this.i15);
                        this.i10 = __sube(this.i14,this.i10);
                        si32(this.i11,mstate.ebp + -8200);
                        si32(this.i10,mstate.ebp + -8196);
                        this.i12 = this.i2 + 4;
                        this.i13 = this.i1 < this.i10 ? 1 : 0;
                        this.i14 = uint(this.i0) < uint(this.i11) ? 1 : 0;
                        this.i16 = this.i1 == this.i10 ? 1 : 0;
                        this.i13 = this.i16 != 0 ? int(this.i14) : int(this.i13);
                        if(this.i13 == 0)
                        {
                           this.i13 = this.i15;
                           §§goto(addr1648);
                        }
                     }
                  }
                  this.i5 = 0;
                  this.i9 = li32(this.i2 + 76);
                  this.i9 = 0 - this.i9;
                  this.i10 = this.i9 >> 31;
                  this.i1 = this.i10 & this.i1;
                  this.i9 &= this.i0;
                  si32(this.i9,mstate.ebp + -8200);
                  si32(this.i1,mstate.ebp + -8196);
                  mstate.esp -= 16;
                  si32(this.i2,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i5,mstate.esp + 12);
                  state = 10;
                  mstate.esp -= 4;
                  FSM__sseek.start();
                  return;
               }
               §§goto(addr2268);
               break;
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr1833);
            case 10:
               this.i1 = mstate.eax;
               this.i5 = mstate.edx;
               mstate.esp += 16;
               this.i1 &= this.i5;
               if(this.i1 != -1)
               {
                  this.i1 = 0;
                  si32(this.i1,this.i2 + 4);
                  this.i1 = li32(this.i2 + 16);
                  si32(this.i1,this.i2);
                  this.i1 = li32(this.i2 + 48);
                  this.i5 = this.i2 + 48;
                  this.i9 = this.i2 + 4;
                  this.i10 = this.i2;
                  if(this.i1 != 0)
                  {
                     this.i11 = this.i2 + 64;
                     if(this.i1 != this.i11)
                     {
                        this.i11 = 0;
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i11,mstate.esp + 4);
                        state = 11;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     addr2112:
                     this.i1 = 0;
                     si32(this.i1,this.i5);
                  }
                  this.i1 = li32(mstate.ebp + -8200);
                  this.i5 = this.i0 - this.i1;
                  if(this.i0 != this.i1)
                  {
                     mstate.esp -= 4;
                     si32(this.i2,mstate.esp);
                     state = 12;
                     mstate.esp -= 4;
                     FSM___srefill.start();
                     return;
                  }
                  this.i0 = 0;
                  this.i2 = li16(this.i8);
                  this.i2 &= -33;
                  si16(this.i2,this.i8);
                  §§goto(addr76);
               }
               else
               {
                  §§goto(addr2268);
               }
               break;
            case 11:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr2112);
            case 12:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               if(this.i0 == 0)
               {
                  this.i0 = li32(this.i9);
                  if(uint(this.i0) >= uint(this.i5))
                  {
                     this.i2 = 0;
                     this.i3 = li32(this.i10);
                     this.i3 += this.i5;
                     si32(this.i3,this.i10);
                     this.i0 -= this.i5;
                     si32(this.i0,this.i9);
                     this.i0 = li16(this.i8);
                     this.i0 &= -33;
                     si16(this.i0,this.i8);
                     mstate.eax = this.i2;
                     break;
                  }
               }
               addr2268:
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 13;
               mstate.esp -= 4;
               FSM___sflush.start();
               return;
            case 13:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               if(this.i0 == 0)
               {
                  addr2308:
                  mstate.esp -= 16;
                  si32(this.i2,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i4,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 14;
                  mstate.esp -= 4;
                  FSM__sseek.start();
                  return;
               }
               §§goto(addr161);
               break;
            case 14:
               this.i0 = mstate.eax;
               this.i1 = mstate.edx;
               mstate.esp += 16;
               this.i4 = this.i0 & this.i1;
               if(this.i4 != -1)
               {
                  this.i4 = li32(this.i2 + 48);
                  this.i5 = this.i2 + 48;
                  if(this.i4 != 0)
                  {
                     this.i6 = this.i2 + 64;
                     if(this.i4 != this.i6)
                     {
                        this.i6 = 0;
                        mstate.esp -= 8;
                        si32(this.i4,mstate.esp);
                        si32(this.i6,mstate.esp + 4);
                        state = 15;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     addr2453:
                     this.i4 = 0;
                     si32(this.i4,this.i5);
                  }
                  this.i4 = 0;
                  this.i5 = li32(this.i2 + 16);
                  si32(this.i5,this.i2);
                  si32(this.i4,this.i2 + 4);
                  this.i5 = li16(this.i8);
                  this.i5 &= -33;
                  si16(this.i5,this.i8);
                  this.i2 = li32(this.i2 + 56);
                  this.i2 += 20;
                  this.i5 = 128;
                  this.i6 = this.i1 < 0 ? 1 : 0;
                  this.i0 = uint(this.i0) < uint(-2147483648) ? 1 : 0;
                  this.i1 = this.i1 == 0 ? 1 : 0;
                  memset(this.i2,this.i4,this.i5);
                  this.i0 = this.i1 != 0 ? int(this.i0) : int(this.i6);
                  if(this.i0 == 0)
                  {
                     if(this.i3 != 0)
                     {
                        this.i0 = 84;
                        this.i1 = li16(this.i8);
                        this.i1 |= 64;
                        si16(this.i1,this.i8);
                        §§goto(addr336);
                     }
                     §§goto(addr2583);
                  }
                  this.i0 = 0;
               }
               else
               {
                  §§goto(addr161);
               }
               §§goto(addr2583);
            case 15:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr2453);
            default:
               throw "Invalid state in __fseeko";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
