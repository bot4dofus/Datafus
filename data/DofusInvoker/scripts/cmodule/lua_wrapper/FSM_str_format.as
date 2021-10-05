package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_str_format extends Machine
   {
      
      public static const intRegCount:int = 21;
      
      public static const NumberRegCount:int = 1;
       
      
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
      
      public var f0:Number;
      
      public function FSM_str_format()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_str_format = null;
         _loc1_ = new FSM_str_format();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop25:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 1592;
               this.i0 = mstate.ebp + -4;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i2 = mstate.ebp + -1040;
               this.i3 = li32(mstate.ebp + -4);
               si32(this.i1,mstate.ebp + -1032);
               this.i4 = this.i2 + 12;
               si32(this.i4,mstate.ebp + -1040);
               this.i4 = 0;
               si32(this.i4,mstate.ebp + -1036);
               this.i4 = this.i2 + 4;
               this.i5 = this.i2 + 8;
               this.i3 = this.i0 + this.i3;
               this.i6 = mstate.ebp + -1584;
               this.i7 = mstate.ebp + -1072;
               if(uint(this.i0) < uint(this.i3))
               {
                  this.i8 = mstate.ebp + -1040;
                  this.i8 += 1036;
                  this.i9 = 1;
                  this.i10 = this.i1 + 8;
                  this.i11 = mstate.ebp + -1584;
                  this.i12 = mstate.ebp + -1072;
                  loop0:
                  while(true)
                  {
                     this.i13 = li8(this.i0);
                     this.i14 = this.i0;
                     if(this.i13 != 37)
                     {
                        this.i14 = li32(this.i2);
                        if(uint(this.i14) >= uint(this.i8))
                        {
                           this.i14 = mstate.ebp + -1040;
                           mstate.esp -= 4;
                           si32(this.i14,mstate.esp);
                           state = 2;
                           mstate.esp -= 4;
                           FSM_emptybuffer.start();
                           return;
                        }
                        addr319:
                        while(true)
                        {
                           this.i14 = li32(this.i2);
                           this.i13 = li8(this.i0);
                           si8(this.i13,this.i14);
                           this.i14 += 1;
                           si32(this.i14,this.i2);
                           this.i0 += 1;
                           if(uint(this.i0) >= uint(this.i3))
                           {
                              break loop0;
                           }
                           continue loop0;
                        }
                     }
                     else
                     {
                        this.i13 = li8(this.i0 + 1);
                        this.i15 = this.i0 + 1;
                        if(this.i13 != 37)
                        {
                           this.i9 += 1;
                           this.i0 = this.i13 & 255;
                           if(this.i0 != 0)
                           {
                              this.i0 = this.i14;
                              while(true)
                              {
                                 this.i13 = __2E_str28458;
                                 this.i16 = li8(this.i0 + 1);
                                 this.i17 = 7;
                                 while(true)
                                 {
                                    this.i18 = li8(this.i13);
                                    this.i19 = this.i16 & 255;
                                    this.i20 = this.i13;
                                    if(this.i18 == this.i19)
                                    {
                                       this.i13 = this.i20;
                                       break;
                                    }
                                    this.i17 += -1;
                                    this.i13 += 1;
                                    if(this.i17 == 1)
                                    {
                                       this.i13 = 0;
                                    }
                                 }
                                 if(this.i13 == 0)
                                 {
                                    this.i0 += 1;
                                    break;
                                 }
                                 this.i13 = li8(this.i0 + 2);
                                 this.i0 += 1;
                                 if(this.i13 == 0)
                                 {
                                    this.i0 += 1;
                                 }
                              }
                           }
                           else
                           {
                              this.i0 = this.i15;
                           }
                           this.i13 = this.i15;
                           this.i15 = this.i0 - this.i15;
                           if(uint(this.i15) >= uint(6))
                           {
                              this.i15 = __2E_str29459;
                              mstate.esp -= 8;
                              si32(this.i1,mstate.esp);
                              si32(this.i15,mstate.esp + 4);
                              state = 6;
                              mstate.esp -= 4;
                              FSM_luaL_error.start();
                              return;
                           }
                           addr706:
                           this.i15 = __DefaultRuneLocale;
                           this.i16 = li8(this.i0);
                           this.i16 <<= 2;
                           this.i15 += this.i16;
                           this.i15 = li32(this.i15 + 52);
                           this.i15 &= 1024;
                           if(this.i15 != 0)
                           {
                              this.i0 += 1;
                           }
                           this.i15 = __DefaultRuneLocale;
                           this.i16 = li8(this.i0);
                           this.i16 <<= 2;
                           this.i15 += this.i16;
                           this.i15 = li32(this.i15 + 52);
                           this.i15 &= 1024;
                           if(this.i15 != 0)
                           {
                              this.i0 += 1;
                           }
                           this.i15 = li8(this.i0);
                           if(this.i15 == 46)
                           {
                              this.i15 = __DefaultRuneLocale;
                              this.i16 = li8(this.i0 + 1);
                              this.i16 <<= 2;
                              this.i15 += this.i16;
                              this.i15 = li32(this.i15 + 52);
                              this.i16 = this.i0 + 1;
                              this.i15 &= 1024;
                              if(this.i15 == 0)
                              {
                                 this.i0 = this.i16;
                              }
                              else
                              {
                                 this.i0 += 2;
                              }
                              this.i15 = __DefaultRuneLocale;
                              this.i16 = li8(this.i0);
                              this.i16 <<= 2;
                              this.i15 += this.i16;
                              this.i15 = li32(this.i15 + 52);
                              this.i15 &= 1024;
                              if(this.i15 != 0)
                              {
                                 this.i0 += 1;
                              }
                           }
                           this.i15 = __DefaultRuneLocale;
                           this.i16 = li8(this.i0);
                           this.i16 <<= 2;
                           this.i15 += this.i16;
                           this.i15 = li32(this.i15 + 52);
                           this.i15 &= 1024;
                           if(this.i15 != 0)
                           {
                              this.i15 = __2E_str30460;
                              mstate.esp -= 8;
                              si32(this.i1,mstate.esp);
                              si32(this.i15,mstate.esp + 4);
                              state = 7;
                              mstate.esp -= 4;
                              FSM_luaL_error.start();
                              return;
                           }
                           break loop25;
                        }
                        this.i13 = li32(this.i2);
                        if(uint(this.i13) >= uint(this.i8))
                        {
                           this.i13 = mstate.ebp + -1040;
                           mstate.esp -= 4;
                           si32(this.i13,mstate.esp);
                           state = 4;
                           mstate.esp -= 4;
                           FSM_emptybuffer.start();
                           return;
                        }
                        addr477:
                        while(true)
                        {
                           this.i13 = li32(this.i2);
                           this.i14 = li8(this.i15);
                           si8(this.i14,this.i13);
                           this.i13 += 1;
                           si32(this.i13,this.i2);
                           this.i0 += 2;
                           if(uint(this.i0) >= uint(this.i3))
                           {
                              break loop0;
                           }
                           continue loop0;
                        }
                     }
                  }
               }
               §§goto(addr2161);
            case 2:
               this.i14 = mstate.eax;
               mstate.esp += 4;
               if(this.i14 != 0)
               {
                  this.i14 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i14,mstate.esp);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr319);
               break;
            case 3:
               mstate.esp += 4;
               §§goto(addr319);
            case 4:
               this.i13 = mstate.eax;
               mstate.esp += 4;
               if(this.i13 != 0)
               {
                  this.i13 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i13,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr477);
               break;
            case 5:
               mstate.esp += 4;
               §§goto(addr477);
            case 6:
               mstate.esp += 8;
               §§goto(addr706);
            case 7:
               mstate.esp += 8;
               break;
            case 8:
               mstate.esp += 12;
               this.i4 = 0;
               mstate.eax = this.i4;
               §§goto(addr1282);
            case 9:
               this.f0 = mstate.st0;
               mstate.esp += 8;
               mstate.esp -= 16;
               si32(this.i11,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               sf64(this.f0,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 10:
               mstate.esp += 16;
               this.i13 = li8(this.i11);
               if(this.i13 != 0)
               {
                  this.i13 = this.i6;
                  while(true)
                  {
                     this.i14 = li8(this.i13 + 1);
                     this.i13 += 1;
                     this.i15 = this.i13;
                     if(this.i14 == 0)
                     {
                        break;
                     }
                     this.i13 = this.i15;
                  }
               }
               else
               {
                  this.i13 = this.i11;
               }
               this.i14 = mstate.ebp + -1040;
               mstate.esp -= 12;
               this.i13 -= this.i6;
               si32(this.i14,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 23;
               mstate.esp -= 4;
               FSM_luaL_addlstring.start();
               return;
            case 11:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               this.i14 = li32(this.i2);
               if(uint(this.i14) >= uint(this.i8))
               {
                  this.i14 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i14,mstate.esp);
                  state = 12;
                  mstate.esp -= 4;
                  FSM_emptybuffer.start();
                  return;
               }
               addr1638:
               this.i14 = 34;
               this.i15 = li32(this.i2);
               si8(this.i14,this.i15);
               this.i14 = this.i15 + 1;
               si32(this.i14,this.i2);
               this.i15 = li32(mstate.ebp + -1588);
               this.i16 = this.i15 + -1;
               si32(this.i16,mstate.ebp + -1588);
               if(this.i15 != 0)
               {
                  loop7:
                  while(true)
                  {
                     this.i15 = si8(li8(this.i13));
                     this.i16 = this.i13;
                     if(this.i15 <= 12)
                     {
                        if(this.i15 == 0)
                        {
                           this.i16 = __2E_str32462;
                           this.i15 = 0;
                           loop9:
                           while(true)
                           {
                              this.i17 = this.i16 + this.i15;
                              if(uint(this.i14) >= uint(this.i8))
                              {
                                 break;
                              }
                              addr3042:
                              while(true)
                              {
                                 this.i14 = li32(this.i2);
                                 this.i17 = li8(this.i17);
                                 si8(this.i17,this.i14);
                                 this.i14 += 1;
                                 si32(this.i14,this.i2);
                                 this.i15 += 1;
                                 if(this.i15 != 4)
                                 {
                                    continue loop9;
                                 }
                              }
                           }
                           this.i14 = mstate.ebp + -1040;
                           mstate.esp -= 4;
                           si32(this.i14,mstate.esp);
                           state = 30;
                           mstate.esp -= 4;
                           FSM_emptybuffer.start();
                           return;
                        }
                        if(this.i15 != 10)
                        {
                           addr1721:
                           if(uint(this.i14) >= uint(this.i8))
                           {
                              this.i14 = mstate.ebp + -1040;
                              mstate.esp -= 4;
                              si32(this.i14,mstate.esp);
                              state = 14;
                              mstate.esp -= 4;
                              FSM_emptybuffer.start();
                              return;
                           }
                           addr1815:
                           while(true)
                           {
                              this.i14 = li32(this.i2);
                              this.i15 = li8(this.i16);
                              si8(this.i15,this.i14);
                              this.i14 += 1;
                              si32(this.i14,this.i2);
                           }
                        }
                        else
                        {
                           addr2554:
                           if(uint(this.i14) >= uint(this.i8))
                           {
                              break;
                           }
                           addr2645:
                           while(true)
                           {
                              this.i14 = 92;
                              this.i15 = li32(this.i2);
                              si8(this.i14,this.i15);
                              this.i14 = this.i15 + 1;
                              si32(this.i14,this.i2);
                              if(uint(this.i14) >= uint(this.i8))
                              {
                                 this.i14 = mstate.ebp + -1040;
                                 mstate.esp -= 4;
                                 si32(this.i14,mstate.esp);
                                 state = 26;
                                 mstate.esp -= 4;
                                 FSM_emptybuffer.start();
                                 return;
                              }
                              addr2760:
                              while(true)
                              {
                                 this.i14 = li32(this.i2);
                                 this.i16 = li8(this.i16);
                                 si8(this.i16,this.i14);
                                 this.i14 += 1;
                                 si32(this.i14,this.i2);
                              }
                           }
                        }
                     }
                     else
                     {
                        if(this.i15 == 13)
                        {
                           this.i16 = __2E_str31461;
                           this.i15 = 0;
                           loop8:
                           while(true)
                           {
                              this.i17 = this.i16 + this.i15;
                              if(uint(this.i14) >= uint(this.i8))
                              {
                                 break;
                              }
                              addr2895:
                              while(true)
                              {
                                 this.i14 = li32(this.i2);
                                 this.i17 = li8(this.i17);
                                 si8(this.i17,this.i14);
                                 this.i14 += 1;
                                 si32(this.i14,this.i2);
                                 this.i15 += 1;
                                 if(this.i15 != 2)
                                 {
                                    continue loop8;
                                 }
                              }
                           }
                           this.i14 = mstate.ebp + -1040;
                           mstate.esp -= 4;
                           si32(this.i14,mstate.esp);
                           state = 28;
                           mstate.esp -= 4;
                           FSM_emptybuffer.start();
                           return;
                        }
                        if(this.i15 != 34)
                        {
                           if(this.i15 != 92)
                           {
                              §§goto(addr1721);
                           }
                           while(true)
                           {
                              this.i15 = li32(mstate.ebp + -1588);
                              this.i16 = this.i15 + -1;
                              si32(this.i16,mstate.ebp + -1588);
                              this.i13 += 1;
                              if(this.i15 != 0)
                              {
                                 continue loop7;
                              }
                              addr3117:
                              this.i13 = this.i14;
                              if(uint(this.i13) >= uint(this.i8))
                              {
                                 this.i13 = mstate.ebp + -1040;
                                 mstate.esp -= 4;
                                 si32(this.i13,mstate.esp);
                                 state = 32;
                                 mstate.esp -= 4;
                                 FSM_emptybuffer.start();
                                 return;
                              }
                              addr3208:
                              this.i13 = 34;
                              this.i14 = li32(this.i2);
                              si8(this.i13,this.i14);
                              this.i13 = this.i14 + 1;
                              si32(this.i13,this.i2);
                              if(uint(this.i0) < uint(this.i3))
                              {
                                 addr3527:
                                 §§goto(addr208);
                              }
                              else
                              {
                                 addr2160:
                              }
                              §§goto(addr2161);
                           }
                           addr3081:
                        }
                        §§goto(addr2554);
                     }
                     §§goto(addr3081);
                  }
                  this.i14 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i14,mstate.esp);
                  state = 24;
                  mstate.esp -= 4;
                  FSM_emptybuffer.start();
                  return;
               }
               this.i13 = this.i14;
               §§goto(addr3117);
               break;
            case 12:
               this.i14 = mstate.eax;
               mstate.esp += 4;
               if(this.i14 != 0)
               {
                  this.i14 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i14,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr1638);
               break;
            case 13:
               mstate.esp += 4;
               §§goto(addr1638);
            case 14:
               this.i14 = mstate.eax;
               mstate.esp += 4;
               if(this.i14 != 0)
               {
                  this.i14 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i14,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr1815);
               break;
            case 15:
               mstate.esp += 4;
               §§goto(addr1815);
            case 16:
               this.f0 = mstate.st0;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i13 = int(this.f0);
               si32(this.i11,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 17;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 17:
               mstate.esp += 12;
               this.i13 = li8(this.i11);
               if(this.i13 != 0)
               {
                  this.i13 = this.i6;
                  while(true)
                  {
                     this.i14 = li8(this.i13 + 1);
                     this.i13 += 1;
                     this.i15 = this.i13;
                     if(this.i14 == 0)
                     {
                        break;
                     }
                     this.i13 = this.i15;
                  }
               }
               else
               {
                  this.i13 = this.i11;
               }
               this.i14 = mstate.ebp + -1040;
               mstate.esp -= 12;
               this.i13 -= this.i6;
               si32(this.i14,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 36;
               mstate.esp -= 4;
               FSM_luaL_addlstring.start();
               return;
            case 18:
               mstate.esp += 12;
               if(uint(this.i0) < uint(this.i3))
               {
                  §§goto(addr3527);
               }
               §§goto(addr2161);
            case 19:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i0 = li32(this.i4);
               this.i1 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 20;
               mstate.esp -= 4;
               FSM_lua_concat.start();
               return;
            case 20:
               mstate.esp += 8;
               this.i0 = 1;
               mstate.eax = this.i0;
               addr1282:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 21:
               this.f0 = mstate.st0;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i13 = uint(this.f0);
               si32(this.i11,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 22:
               mstate.esp += 12;
               this.i13 = li8(this.i11);
               if(this.i13 != 0)
               {
                  this.i13 = this.i6;
                  while(true)
                  {
                     this.i14 = li8(this.i13 + 1);
                     this.i13 += 1;
                     this.i15 = this.i13;
                     if(this.i14 == 0)
                     {
                        break;
                     }
                     this.i13 = this.i15;
                  }
               }
               else
               {
                  this.i13 = this.i11;
               }
               this.i14 = mstate.ebp + -1040;
               mstate.esp -= 12;
               this.i13 -= this.i6;
               si32(this.i14,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 39;
               mstate.esp -= 4;
               FSM_luaL_addlstring.start();
               return;
            case 23:
               mstate.esp += 12;
               if(uint(this.i0) >= uint(this.i3))
               {
                  §§goto(addr2160);
               }
               else
               {
                  §§goto(addr3527);
               }
            case 24:
               this.i14 = mstate.eax;
               mstate.esp += 4;
               if(this.i14 != 0)
               {
                  this.i14 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i14,mstate.esp);
                  state = 25;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr2645);
               break;
            case 25:
               mstate.esp += 4;
               §§goto(addr2645);
            case 26:
               this.i14 = mstate.eax;
               mstate.esp += 4;
               if(this.i14 != 0)
               {
                  this.i14 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i14,mstate.esp);
                  state = 27;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr2760);
               break;
            case 27:
               mstate.esp += 4;
               §§goto(addr2760);
            case 28:
               this.i14 = mstate.eax;
               mstate.esp += 4;
               if(this.i14 != 0)
               {
                  this.i14 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i14,mstate.esp);
                  state = 29;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr2895);
               break;
            case 29:
               mstate.esp += 4;
               §§goto(addr2895);
            case 30:
               this.i14 = mstate.eax;
               mstate.esp += 4;
               if(this.i14 != 0)
               {
                  this.i14 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i14,mstate.esp);
                  state = 31;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr3042);
               break;
            case 31:
               mstate.esp += 4;
               §§goto(addr3042);
            case 32:
               this.i13 = mstate.eax;
               mstate.esp += 4;
               if(this.i13 != 0)
               {
                  this.i13 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i13,mstate.esp);
                  state = 33;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr3208);
               break;
            case 33:
               mstate.esp += 4;
               §§goto(addr3208);
            case 34:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               this.i14 = li8(this.i12);
               if(this.i14 != 46)
               {
                  this.i14 = this.i7;
                  while(true)
                  {
                     this.i15 = li8(this.i14);
                     if(this.i15 == 0)
                     {
                        this.i14 = 0;
                        break;
                     }
                     this.i15 = li8(this.i14 + 1);
                     this.i14 += 1;
                     this.i16 = this.i14;
                     if(this.i15 == 46)
                     {
                        break;
                     }
                     this.i14 = this.i16;
                  }
               }
               else
               {
                  this.i14 = this.i12;
               }
               if(this.i14 == 0)
               {
                  this.i14 = li32(mstate.ebp + -1592);
                  if(uint(this.i14) >= uint(100))
                  {
                     this.i13 = mstate.ebp + -1040;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr3869);
                  }
               }
               mstate.esp -= 12;
               si32(this.i11,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 35;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 40:
               addr3869:
               this.i14 = mstate.eax;
               mstate.esp += 8;
               this.i15 = li32(this.i10);
               this.f0 = lf64(this.i14);
               sf64(this.f0,this.i15);
               this.i14 = li32(this.i14 + 8);
               si32(this.i14,this.i15 + 8);
               this.i14 = li32(this.i10);
               this.i14 += 12;
               si32(this.i14,this.i10);
               mstate.esp -= 4;
               si32(this.i13,mstate.esp);
               state = 41;
               mstate.esp -= 4;
               FSM_luaL_addvalue.start();
               return;
            case 35:
               mstate.esp += 12;
               this.i13 = li8(this.i11);
               if(this.i13 != 0)
               {
                  this.i13 = this.i6;
                  while(true)
                  {
                     this.i14 = li8(this.i13 + 1);
                     this.i13 += 1;
                     this.i15 = this.i13;
                     if(this.i14 == 0)
                     {
                        break;
                     }
                     this.i13 = this.i15;
                  }
               }
               else
               {
                  this.i13 = this.i11;
               }
               this.i14 = mstate.ebp + -1040;
               mstate.esp -= 12;
               this.i13 -= this.i6;
               si32(this.i14,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 42;
               mstate.esp -= 4;
               FSM_luaL_addlstring.start();
               return;
            case 36:
               mstate.esp += 12;
               if(uint(this.i0) < uint(this.i3))
               {
                  §§goto(addr3527);
               }
               else
               {
                  §§goto(addr2160);
               }
            case 37:
               this.f0 = mstate.st0;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i13 = int(this.f0);
               si32(this.i11,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 38;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 38:
               mstate.esp += 12;
               this.i13 = li8(this.i11);
               if(this.i13 != 0)
               {
                  this.i13 = this.i6;
                  while(true)
                  {
                     this.i14 = li8(this.i13 + 1);
                     this.i13 += 1;
                     this.i15 = this.i13;
                     if(this.i14 == 0)
                     {
                        break;
                     }
                     this.i13 = this.i15;
                  }
               }
               else
               {
                  this.i13 = this.i11;
               }
               this.i14 = mstate.ebp + -1040;
               mstate.esp -= 12;
               this.i13 -= this.i6;
               si32(this.i14,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaL_addlstring.start();
               return;
            case 39:
               mstate.esp += 12;
               if(uint(this.i0) >= uint(this.i3))
               {
                  §§goto(addr2160);
               }
               else
               {
                  addr3526:
                  §§goto(addr3527);
               }
            case 41:
               mstate.esp += 4;
               if(uint(this.i0) >= uint(this.i3))
               {
                  §§goto(addr2160);
               }
               else
               {
                  §§goto(addr3526);
               }
            case 42:
               mstate.esp += 12;
               if(uint(this.i0) >= uint(this.i3))
               {
                  §§goto(addr2160);
               }
               else
               {
                  §§goto(addr3526);
               }
               state = 19;
               mstate.esp -= 4;
               FSM_emptybuffer.start();
               return;
            default:
               throw "Invalid state in _str_format";
         }
         this.i15 = 37;
         this.i16 = 1 - this.i13;
         si8(this.i15,this.i12);
         this.i15 = this.i0 + this.i16;
         if(this.i15 != 0)
         {
            this.i16 = 1;
            loop21:
            while(true)
            {
               this.i17 = this.i14 + this.i16;
               this.i17 = li8(this.i17);
               this.i18 = this.i7 + this.i16;
               si8(this.i17,this.i18);
               if(this.i17 == 0)
               {
                  if(this.i15 != 1)
                  {
                     this.i14 = 0;
                     while(true)
                     {
                        this.i17 = mstate.ebp + -1072;
                        this.i18 = this.i16 + this.i14;
                        this.i17 = this.i18 + this.i17;
                        this.i18 = 0;
                        si8(this.i18,this.i17 + 1);
                        this.i17 = this.i14 + 1;
                        this.i14 = this.i15 - this.i14;
                        if(this.i14 == 2)
                        {
                           break loop21;
                        }
                        this.i14 = this.i17;
                     }
                  }
               }
               this.i17 = this.i15 + -1;
               this.i16 += 1;
               if(this.i15 == 1)
               {
                  break;
               }
               this.i15 = this.i17;
            }
         }
         this.i14 = mstate.ebp + -1072;
         this.i13 = 2 - this.i13;
         this.i13 = this.i0 + this.i13;
         this.i15 = 0;
         this.i13 = this.i14 + this.i13;
         si8(this.i15,this.i13);
         this.i13 = si8(li8(this.i0));
         this.i0 += 1;
         if(this.i13 <= 104)
         {
            if(this.i13 <= 98)
            {
               if(this.i13 != 69)
               {
                  if(this.i13 != 71)
                  {
                     if(this.i13 != 88)
                     {
                        §§goto(addr1224);
                     }
                     else
                     {
                        §§goto(addr1858);
                     }
                  }
               }
            }
            else
            {
               if(this.i13 == 99)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  state = 16;
                  mstate.esp -= 4;
                  FSM_luaL_checknumber.start();
                  return;
               }
               if(this.i13 != 100)
               {
                  this.i14 = this.i13 + -101;
                  if(uint(this.i14) >= uint(3))
                  {
                     §§goto(addr1223);
                  }
               }
               else
               {
                  §§goto(addr2039);
               }
            }
            mstate.esp -= 8;
            si32(this.i1,mstate.esp);
            si32(this.i9,mstate.esp + 4);
            state = 9;
            mstate.esp -= 4;
            FSM_luaL_checknumber.start();
            return;
         }
         if(this.i13 <= 114)
         {
            if(this.i13 == 105)
            {
               addr2039:
               this.i13 = li8(this.i12);
               if(this.i13 != 0)
               {
                  this.i13 = this.i7;
                  while(true)
                  {
                     this.i14 = li8(this.i13 + 1);
                     this.i13 += 1;
                     this.i15 = this.i13;
                     if(this.i14 == 0)
                     {
                        break;
                     }
                     this.i13 = this.i15;
                  }
               }
               else
               {
                  this.i13 = this.i12;
               }
               this.i14 = mstate.ebp + -1072;
               this.i13 -= this.i7;
               this.i15 = this.i13 + this.i14;
               this.i16 = li8(this.i15 + -1);
               this.i17 = 108;
               this.i18 = 0;
               si8(this.i17,this.i15 + -1);
               si8(this.i18,this.i15);
               this.i13 = this.i14 + this.i13;
               si8(this.i16,this.i13);
               si8(this.i18,this.i15 + 1);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               state = 37;
               mstate.esp -= 4;
               FSM_luaL_checknumber.start();
               return;
            }
            if(this.i13 != 111)
            {
               if(this.i13 == 113)
               {
                  this.i13 = mstate.ebp + -1588;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i13,mstate.esp + 8);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaL_checklstring.start();
                  return;
               }
               §§goto(addr1223);
            }
         }
         else
         {
            if(this.i13 == 115)
            {
               this.i13 = mstate.ebp + -1592;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 34;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            }
            if(this.i13 != 117)
            {
               if(this.i13 != 120)
               {
                  addr1223:
                  addr1224:
                  this.i4 = __2E_str33463;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i13,mstate.esp + 8);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
            }
         }
         addr1858:
         this.i13 = li8(this.i12);
         if(this.i13 != 0)
         {
            this.i13 = this.i7;
            while(true)
            {
               this.i14 = li8(this.i13 + 1);
               this.i13 += 1;
               this.i15 = this.i13;
               if(this.i14 == 0)
               {
                  break;
               }
               this.i13 = this.i15;
            }
         }
         else
         {
            this.i13 = this.i12;
         }
         this.i14 = mstate.ebp + -1072;
         this.i13 -= this.i7;
         this.i15 = this.i13 + this.i14;
         this.i16 = li8(this.i15 + -1);
         this.i17 = 108;
         this.i18 = 0;
         si8(this.i17,this.i15 + -1);
         si8(this.i18,this.i15);
         this.i13 = this.i14 + this.i13;
         si8(this.i16,this.i13);
         si8(this.i18,this.i15 + 1);
         mstate.esp -= 8;
         si32(this.i1,mstate.esp);
         si32(this.i9,mstate.esp + 4);
         state = 21;
         mstate.esp -= 4;
         FSM_luaL_checknumber.start();
      }
   }
}
