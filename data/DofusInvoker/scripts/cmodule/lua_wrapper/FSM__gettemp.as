package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM__gettemp extends Machine
   {
      
      public static const intRegCount:int = 21;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i17:int;
      
      public var i19:int;
      
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
      
      public var i18:int;
      
      public var i20:int;
      
      public function FSM__gettemp()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM__gettemp = null;
         _loc1_ = new FSM__gettemp();
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
               mstate.esp -= 10368;
               this.i3 = li32(mstate.ebp + 8);
               this.i0 = li8(this.i3);
               this.i4 = li32(mstate.ebp + 12);
               this.i1 = this.i3;
               if(this.i0 != 0)
               {
                  this.i0 = this.i1;
                  while(true)
                  {
                     this.i1 = li8(this.i0 + 1);
                     this.i0 += 1;
                     this.i2 = this.i0;
                     if(this.i1 == 0)
                     {
                        break;
                     }
                     this.i0 = this.i2;
                  }
               }
               else
               {
                  this.i0 = this.i3;
               }
               this.i5 = this.i0;
               this.i6 = this.i5;
               this.i0 = this.i5 + -1;
               if(uint(this.i0) >= uint(this.i3))
               {
                  this.i7 = mstate.ebp + -5248;
                  this.i0 = 0;
                  this.i8 = this.i7 + 12;
                  this.i9 = this.i7 + 8;
                  this.i10 = this.i7 + 4;
                  this.i11 = this.i7;
                  loop1:
                  while(true)
                  {
                     this.i13 = this.i0;
                     this.i2 = this.i13 ^ -1;
                     this.i12 = this.i5 + this.i2;
                     if(uint(this.i12) < uint(this.i3))
                     {
                        break;
                     }
                     this.i0 = li8(this.i12);
                     if(this.i0 != 88)
                     {
                        break;
                     }
                     this.i0 = li8(_rs_initialized_2E_b);
                     if(this.i0 == 0)
                     {
                        this.i0 = _rs_2E_2;
                        this.i1 = 0;
                        this.i2 = this.i1;
                        do
                        {
                           this.i14 = this.i0 + this.i2;
                           si8(this.i1,this.i14);
                           this.i1 += 1;
                           this.i2 += 1;
                        }
                        while(this.i2 != 256);
                        
                        this.i0 = 0;
                        si8(this.i0,_rs_2E_0);
                        si8(this.i0,_rs_2E_1);
                        this.i0 = 1;
                        si8(this.i0,_rs_initialized_2E_b);
                     }
                     this.i0 = li8(_rs_stired_2E_b);
                     if(this.i0 == 0)
                     {
                        this.i1 = __2E_str977;
                        this.i0 = mstate.gworker.getSecsSetMS();
                        this.i2 = this.i0;
                        this.i0 = Machine.sMS;
                        si32(this.i2,this.i11);
                        this.i0 *= 1000;
                        si32(this.i0,this.i10);
                        this.i2 = 4;
                        this.i14 = 1;
                        this.i0 = this.i1;
                        this.i1 = this.i2;
                        log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i14,this.i9);
                        mstate.esp -= 12;
                        this.i0 = 0;
                        this.i1 = __2E_str468;
                        si32(this.i1,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i0,mstate.esp + 8);
                        state = 1;
                        mstate.esp -= 4;
                        FSM_open.start();
                        return;
                     }
                     addr632:
                     while(true)
                     {
                        this.i0 = _rs_2E_2;
                        this.i1 = li8(_rs_2E_0);
                        this.i2 = this.i1 + 1;
                        this.i2 &= 255;
                        this.i2 = this.i0 + this.i2;
                        this.i14 = li8(_rs_2E_1);
                        this.i15 = li8(this.i2);
                        this.i14 += this.i15;
                        this.i16 = this.i14 & 255;
                        this.i16 = this.i0 + this.i16;
                        this.i17 = li8(this.i16);
                        this.i18 = this.i1 + 2;
                        si8(this.i17,this.i2);
                        this.i2 = this.i18 & 255;
                        si8(this.i15,this.i16);
                        this.i2 = this.i0 + this.i2;
                        this.i16 = li8(this.i2);
                        this.i14 += this.i16;
                        this.i15 = this.i17 + this.i15;
                        this.i17 = this.i14 & 255;
                        this.i15 &= 255;
                        this.i17 = this.i0 + this.i17;
                        this.i15 = this.i0 + this.i15;
                        this.i15 = li8(this.i15);
                        this.i18 = li8(this.i17);
                        this.i19 = this.i1 + 3;
                        si8(this.i18,this.i2);
                        this.i2 = this.i19 & 255;
                        si8(this.i16,this.i17);
                        this.i2 = this.i0 + this.i2;
                        this.i17 = li8(this.i2);
                        this.i14 += this.i17;
                        this.i16 = this.i18 + this.i16;
                        this.i18 = this.i14 & 255;
                        this.i16 &= 255;
                        this.i18 = this.i0 + this.i18;
                        this.i16 = this.i0 + this.i16;
                        this.i16 = li8(this.i16);
                        this.i19 = li8(this.i18);
                        this.i20 = this.i19 + this.i17;
                        si8(this.i19,this.i2);
                        this.i2 = this.i20 & 255;
                        this.i1 += 4;
                        si8(this.i17,this.i18);
                        this.i2 = this.i0 + this.i2;
                        this.i2 = li8(this.i2);
                        this.i17 = this.i1 & 255;
                        si8(this.i1,_rs_2E_0);
                        this.i1 = this.i0 + this.i17;
                        this.i17 = li8(this.i1);
                        this.i14 += this.i17;
                        this.i18 = this.i14 & 255;
                        si8(this.i14,_rs_2E_1);
                        this.i14 = this.i0 + this.i18;
                        this.i18 = li8(this.i14);
                        this.i19 = this.i18 + this.i17;
                        si8(this.i18,this.i1);
                        this.i1 = this.i19 & 255;
                        this.i16 <<= 16;
                        this.i15 <<= 24;
                        si8(this.i17,this.i14);
                        this.i0 += this.i1;
                        this.i1 = this.i16 | this.i15;
                        this.i2 <<= 8;
                        this.i0 = li8(this.i0);
                        this.i1 |= this.i2;
                        this.i0 = this.i1 | this.i0;
                        this.i1 = uint(this.i0) / uint(62);
                        this.i1 *= 62;
                        this.i2 = _padchar;
                        this.i0 -= this.i1;
                        this.i0 = this.i2 + this.i0;
                        this.i0 = li8(this.i0);
                        si8(this.i0,this.i12);
                        this.i0 = this.i13 + 1;
                        continue loop1;
                     }
                  }
                  if(this.i4 != 0)
                  {
                     this.i0 = this.i2 + this.i6;
                     while(true)
                     {
                        this.i7 = this.i0;
                        if(uint(this.i0) <= uint(this.i3))
                        {
                           break;
                        }
                        this.i1 = li8(this.i7);
                        if(this.i1 == 47)
                        {
                           this.i0 = 0;
                           si8(this.i0,this.i7);
                           this.i0 = this.i3;
                           state = 4;
                           §§goto(addr1160);
                        }
                        this.i0 += -1;
                     }
                     if(this.i4 == 0)
                     {
                        while(true)
                        {
                           this.i0 = this.i3;
                           state = 9;
                           §§goto(addr1573);
                        }
                        addr1566:
                     }
                     this.i0 = 384;
                     mstate.esp -= 12;
                     this.i1 = 2562;
                     si32(this.i3,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 8;
                     mstate.esp -= 4;
                     FSM_open.start();
                     return;
                  }
                  §§goto(addr1566);
               }
               else
               {
                  this.i0 = 22;
               }
               §§goto(addr94);
            case 1:
               this.i14 = mstate.eax;
               mstate.esp += 12;
               if(this.i14 >= 0)
               {
                  this.i2 = 116;
                  this.i0 = this.i14;
                  this.i1 = this.i8;
                  state = 2;
                  addr326:
                  this.i0 = mstate.system.read(this.i0,this.i1,this.i2);
                  this.i0 = this.i14;
                  state = 3;
                  this.i0 = mstate.system.close(this.i0);
               }
               this.i0 = 0;
               this.i1 = li8(_rs_2E_0);
               this.i2 = this.i1 + -1;
               si8(this.i2,_rs_2E_0);
               this.i14 = li8(_rs_2E_1);
               this.i15 = this.i1;
               do
               {
                  this.i16 = _rs_2E_2;
                  this.i17 = this.i0 >> 31;
                  this.i17 >>>= 25;
                  this.i17 = this.i0 + this.i17;
                  this.i18 = this.i15 & 255;
                  this.i17 &= -128;
                  this.i17 = this.i0 - this.i17;
                  this.i18 = this.i16 + this.i18;
                  this.i19 = li8(this.i18);
                  this.i17 = this.i7 + this.i17;
                  this.i17 = li8(this.i17);
                  this.i14 += this.i19;
                  this.i14 += this.i17;
                  this.i17 = this.i14 & 255;
                  this.i16 += this.i17;
                  this.i17 = li8(this.i16);
                  si8(this.i17,this.i18);
                  si8(this.i19,this.i16);
                  this.i15 += 1;
                  this.i0 += 1;
               }
               while(this.i0 != 256);
               
               this.i0 = 0;
               si8(this.i2,_rs_2E_0);
               si8(this.i14,_rs_2E_1);
               this.i15 = this.i1;
               this.i1 = this.i14;
               while(true)
               {
                  this.i14 = this.i15;
                  this.i15 = _rs_2E_2;
                  this.i16 = this.i14 & 255;
                  this.i16 = this.i15 + this.i16;
                  this.i17 = li8(this.i16);
                  this.i1 += this.i17;
                  this.i18 = this.i1 & 255;
                  this.i15 += this.i18;
                  this.i18 = li8(this.i15);
                  si8(this.i18,this.i16);
                  si8(this.i17,this.i15);
                  this.i14 += 1;
                  this.i0 += 1;
                  if(this.i0 == 1024)
                  {
                     break;
                  }
                  this.i15 = this.i14;
               }
               this.i0 = 1;
               si8(this.i2,_rs_2E_0);
               si8(this.i1,_rs_2E_1);
               si8(this.i0,_rs_stired_2E_b);
               §§goto(addr632);
            case 2:
               §§goto(addr326);
            case 3:
               §§goto(addr326);
            case 4:
               addr1160:
               this.i0 = mstate.system.psize(this.i0);
               if(this.i0 >= 0)
               {
                  this.i0 = 1;
                  this.i1 = 0;
                  addr1386:
                  this.i8 = 47;
                  si8(this.i8,this.i7);
                  this.i0 &= 1;
                  if(this.i0 == 0)
                  {
                     addr1408:
                     this.i0 = 0;
                     break;
                  }
                  this.i0 = this.i1 & 1;
                  if(this.i0 == 0)
                  {
                     this.i0 = 20;
                     addr94:
                     si32(this.i0,_val_2E_1440);
                     this.i0 = 0;
                     break;
                  }
                  break loop3;
               }
               this.i0 = __2E_str655;
               mstate.esp -= 16;
               this.i1 = 1024;
               this.i8 = mstate.ebp + -5120;
               si32(this.i8,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 5;
               mstate.esp -= 4;
               FSM_snprintf.start();
               return;
            case 5:
               mstate.esp += 16;
               this.i0 = 0;
               si8(this.i0,mstate.ebp + -4097);
               this.i0 = this.i8;
               state = 6;
            case 6:
               this.i0 = mstate.system.psize(this.i0);
               if(this.i0 < 0)
               {
                  this.i0 = __2E_str96;
                  mstate.esp -= 20;
                  this.i1 = __2E_str251;
                  this.i8 = 28;
                  this.i9 = 2;
                  this.i10 = mstate.ebp + -4096;
                  si32(this.i10,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i9,mstate.esp + 8);
                  si32(this.i1,mstate.esp + 12);
                  si32(this.i8,mstate.esp + 16);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_sprintf.start();
                  return;
               }
               this.i0 = 1;
               this.i1 = this.i0;
               §§goto(addr1386);
               break;
            case 7:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i10;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i9,_val_2E_1440);
               this.i0 = 0;
               this.i1 = this.i0;
               §§goto(addr1386);
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               if(this.i0 >= 0)
               {
                  this.i0 = 1;
                  addr1413:
                  break;
               }
               this.i0 = li32(_val_2E_1440);
               if(this.i0 == 17)
               {
                  §§goto(addr1796);
               }
               §§goto(addr1407);
               break;
            case 10:
               mstate.esp += 16;
               this.i0 = 0;
               si8(this.i0,mstate.ebp + -9345);
               this.i0 = this.i7;
               state = 11;
            case 11:
               this.i0 = mstate.system.psize(this.i0);
               if(this.i0 <= -1)
               {
                  this.i0 = __2E_str96;
                  mstate.esp -= 20;
                  this.i2 = __2E_str251;
                  this.i3 = 28;
                  this.i4 = 2;
                  this.i5 = mstate.ebp + -9344;
                  si32(this.i5,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i4,mstate.esp + 8);
                  si32(this.i2,mstate.esp + 12);
                  si32(this.i3,mstate.esp + 16);
                  state = 12;
                  mstate.esp -= 4;
                  FSM_sprintf.start();
                  return;
               }
               §§goto(addr1796);
            case 9:
               addr1573:
               while(true)
               {
                  this.i0 = mstate.system.psize(this.i0);
                  if(this.i0 <= -1)
                  {
                     break;
                  }
                  addr1796:
                  loop8:
                  while(true)
                  {
                     this.i0 = this.i5 - this.i13;
                     this.i0 = li8(this.i0);
                     if(this.i0 != 0)
                     {
                        if(this.i13 != 0)
                        {
                           this.i0 = this.i2;
                           while(true)
                           {
                              this.i1 = _padchar;
                              this.i7 = this.i6 + this.i0;
                              this.i8 = li8(this.i7 + 1);
                              this.i9 = 64;
                              this.i7 += 1;
                              while(true)
                              {
                                 this.i10 = li8(this.i1);
                                 this.i11 = this.i8 & 255;
                                 this.i12 = this.i1;
                                 if(this.i10 == this.i11)
                                 {
                                    this.i1 = this.i12;
                                    break;
                                 }
                                 this.i9 += -1;
                                 this.i1 += 1;
                                 if(this.i9 == 1)
                                 {
                                    this.i1 = 0;
                                 }
                              }
                              if(this.i1 != 0)
                              {
                                 this.i1 = li8(this.i1 + 1);
                                 if(this.i1 != 0)
                                 {
                                    si8(this.i1,this.i7);
                                    if(this.i4 != 0)
                                    {
                                       break loop8;
                                    }
                                    continue loop4;
                                 }
                              }
                              this.i1 = 48;
                              si8(this.i1,this.i7);
                              this.i1 = this.i6 + this.i0;
                              this.i1 = li8(this.i1 + 2);
                              this.i7 = this.i0 + 1;
                              this.i0 += 2;
                              if(this.i1 == 0)
                              {
                                 break;
                              }
                              if(this.i0 == 0)
                              {
                                 break;
                              }
                              this.i0 = this.i7;
                           }
                        }
                     }
                     addr1407:
                     §§goto(addr1408);
                  }
               }
               this.i0 = __2E_str655;
               mstate.esp -= 16;
               this.i1 = 1024;
               this.i7 = mstate.ebp + -10368;
               si32(this.i7,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 10;
               mstate.esp -= 4;
               FSM_snprintf.start();
               return;
            case 12:
               mstate.esp += 20;
               this.i2 = 3;
               this.i0 = this.i5;
               this.i1 = this.i2;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i4,_val_2E_1440);
               this.i0 = 1;
               §§goto(addr1413);
            default:
               throw "Invalid state in __gettemp";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
