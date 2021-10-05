package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_DumpFunction extends Machine
   {
      
      public static const intRegCount:int = 19;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i17:int;
      
      public var f0:Number;
      
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
      
      public function FSM_DumpFunction()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_DumpFunction = null;
         _loc1_ = new FSM_DumpFunction();
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
               mstate.esp -= 64;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 32);
               this.i2 = this.i0 + 32;
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = li32(mstate.ebp + 12);
               if(this.i1 == this.i4)
               {
                  addr69:
                  this.i1 = 0;
               }
               else
               {
                  this.i4 = li32(this.i3 + 12);
                  if(this.i4 != 0)
                  {
                     §§goto(addr69);
                  }
               }
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_DumpString.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i1 = li32(this.i0 + 60);
               si32(this.i1,mstate.ebp + -52);
               this.i1 = li32(this.i3 + 16);
               this.i4 = this.i3 + 16;
               if(this.i1 == 0)
               {
                  this.i1 = 4;
                  this.i5 = li32(this.i3 + 4);
                  this.i6 = li32(this.i3 + 8);
                  this.i7 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i8 = mstate.ebp + -52;
                  si32(this.i7,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 2;
                  mstate.esp -= 4;
                  mstate.funcs[this.i5]();
                  return;
               }
               addr249:
               this.i5 = li32(this.i0 + 64);
               si32(this.i5,mstate.ebp + -32);
               if(this.i1 == 0)
               {
                  this.i1 = 4;
                  this.i5 = li32(this.i3 + 4);
                  this.i6 = li32(this.i3 + 8);
                  this.i7 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i8 = mstate.ebp + -32;
                  si32(this.i7,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 3;
                  mstate.esp -= 4;
                  mstate.funcs[this.i5]();
                  return;
               }
               addr362:
               this.i5 = li8(this.i0 + 72);
               si8(this.i5,mstate.ebp + -18);
               if(this.i1 == 0)
               {
                  this.i1 = 1;
                  this.i5 = li32(this.i3 + 4);
                  this.i6 = li32(this.i3 + 8);
                  this.i7 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i8 = mstate.ebp + -18;
                  si32(this.i7,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 4;
                  mstate.esp -= 4;
                  mstate.funcs[this.i5]();
                  return;
               }
               addr475:
               this.i5 = li8(this.i0 + 73);
               si8(this.i5,mstate.ebp + -17);
               if(this.i1 == 0)
               {
                  this.i1 = 1;
                  this.i5 = li32(this.i3 + 4);
                  this.i6 = li32(this.i3 + 8);
                  this.i7 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i8 = mstate.ebp + -17;
                  si32(this.i7,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 5;
                  mstate.esp -= 4;
                  mstate.funcs[this.i5]();
                  return;
               }
               addr588:
               this.i5 = li8(this.i0 + 74);
               si8(this.i5,mstate.ebp + -11);
               if(this.i1 == 0)
               {
                  this.i1 = 1;
                  this.i5 = li32(this.i3 + 4);
                  this.i6 = li32(this.i3 + 8);
                  this.i7 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i8 = mstate.ebp + -11;
                  si32(this.i7,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 6;
                  mstate.esp -= 4;
                  mstate.funcs[this.i5]();
                  return;
               }
               addr701:
               this.i5 = li8(this.i0 + 75);
               si8(this.i5,mstate.ebp + -1);
               if(this.i1 == 0)
               {
                  this.i1 = 1;
                  this.i5 = li32(this.i3 + 4);
                  this.i6 = li32(this.i3 + 8);
                  this.i7 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i8 = mstate.ebp + -1;
                  si32(this.i7,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 7;
                  mstate.esp -= 4;
                  mstate.funcs[this.i5]();
                  return;
               }
               §§goto(addr814);
               break;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               si32(this.i1,this.i4);
               §§goto(addr249);
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               si32(this.i1,this.i4);
               §§goto(addr362);
            case 4:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               si32(this.i1,this.i4);
               §§goto(addr475);
            case 5:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               si32(this.i1,this.i4);
               §§goto(addr588);
            case 6:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               si32(this.i1,this.i4);
               §§goto(addr701);
            case 7:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               si32(this.i1,this.i4);
               addr814:
               this.i1 = li32(this.i0 + 44);
               this.i5 = li32(this.i0 + 12);
               mstate.esp -= 12;
               si32(this.i5,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_DumpVector.start();
               return;
            case 8:
               mstate.esp += 12;
               this.i1 = li32(this.i0 + 40);
               si32(this.i1,mstate.ebp + -8);
               this.i5 = li32(this.i4);
               if(this.i5 == 0)
               {
                  this.i5 = 4;
                  this.i6 = li32(this.i3 + 4);
                  this.i7 = li32(this.i3 + 8);
                  this.i8 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i9 = mstate.ebp + -8;
                  si32(this.i8,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  si32(this.i7,mstate.esp + 12);
                  state = 9;
                  mstate.esp -= 4;
                  mstate.funcs[this.i6]();
                  return;
               }
               addr990:
               if(this.i1 >= 1)
               {
                  this.i5 = 0;
                  this.i6 = this.i3 + 8;
                  this.i7 = this.i3 + 4;
                  this.i8 = mstate.ebp + -64;
                  this.i9 = this.i0 + 8;
                  this.i10 = this.i3;
                  loop0:
                  while(true)
                  {
                     this.i11 = li32(this.i9);
                     this.i12 = this.i5 * 12;
                     this.i12 = this.i11 + this.i12;
                     this.i13 = li8(this.i12 + 8);
                     si8(this.i13,mstate.ebp + -9);
                     this.i13 = li32(this.i4);
                     this.i14 = this.i12 + 8;
                     if(this.i13 == 0)
                     {
                        this.i13 = 1;
                        this.i15 = li32(this.i7);
                        this.i16 = li32(this.i6);
                        this.i17 = li32(this.i10);
                        mstate.esp -= 16;
                        this.i18 = mstate.ebp + -9;
                        si32(this.i17,mstate.esp);
                        si32(this.i18,mstate.esp + 4);
                        si32(this.i13,mstate.esp + 8);
                        si32(this.i16,mstate.esp + 12);
                        state = 10;
                        mstate.esp -= 4;
                        mstate.funcs[this.i15]();
                        return;
                     }
                     while(true)
                     {
                        this.i14 = li32(this.i14);
                        if(this.i14 == 4)
                        {
                           this.i11 = li32(this.i12);
                           mstate.esp -= 8;
                           si32(this.i11,mstate.esp);
                           si32(this.i3,mstate.esp + 4);
                           state = 13;
                           mstate.esp -= 4;
                           FSM_DumpString.start();
                           return;
                        }
                        if(this.i14 != 3)
                        {
                           if(this.i14 == 1)
                           {
                              this.i11 = li8(this.i12);
                              si8(this.i11,mstate.ebp + -10);
                              if(this.i13 == 0)
                              {
                                 this.i11 = 1;
                                 this.i12 = li32(this.i7);
                                 this.i13 = li32(this.i6);
                                 this.i14 = li32(this.i10);
                                 mstate.esp -= 16;
                                 this.i15 = mstate.ebp + -10;
                                 si32(this.i14,mstate.esp);
                                 si32(this.i15,mstate.esp + 4);
                                 si32(this.i11,mstate.esp + 8);
                                 si32(this.i13,mstate.esp + 12);
                                 state = 11;
                                 mstate.esp -= 4;
                                 mstate.funcs[this.i12]();
                                 return;
                              }
                              addr1294:
                              while(true)
                              {
                                 this.i5 += 1;
                                 if(this.i5 >= this.i1)
                                 {
                                    break loop0;
                                 }
                                 continue loop0;
                              }
                           }
                           else
                           {
                              while(true)
                              {
                                 this.i5 += 1;
                                 if(this.i5 >= this.i1)
                                 {
                                    break loop0;
                                 }
                                 continue loop0;
                              }
                              addr1476:
                           }
                        }
                        else
                        {
                           this.i12 = this.i5 * 12;
                           this.i12 = this.i11 + this.i12;
                           this.f0 = lf64(this.i12);
                           sf64(this.f0,mstate.ebp + -64);
                           if(this.i13 == 0)
                           {
                              this.i12 = 8;
                              this.i11 = li32(this.i7);
                              this.i13 = li32(this.i6);
                              this.i14 = li32(this.i10);
                              mstate.esp -= 16;
                              si32(this.i14,mstate.esp);
                              si32(this.i8,mstate.esp + 4);
                              si32(this.i12,mstate.esp + 8);
                              si32(this.i13,mstate.esp + 12);
                              state = 12;
                              mstate.esp -= 4;
                              mstate.funcs[this.i11]();
                              return;
                           }
                           addr1421:
                           while(true)
                           {
                              this.i5 += 1;
                              if(this.i5 >= this.i1)
                              {
                                 break loop0;
                              }
                              continue loop0;
                           }
                        }
                     }
                  }
               }
               this.i1 = li32(this.i0 + 52);
               si32(this.i1,mstate.ebp + -16);
               this.i5 = li32(this.i4);
               if(this.i5 == 0)
               {
                  this.i5 = 4;
                  this.i6 = li32(this.i3 + 4);
                  this.i7 = li32(this.i3 + 8);
                  this.i8 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i9 = mstate.ebp + -16;
                  si32(this.i8,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  si32(this.i7,mstate.esp + 12);
                  state = 14;
                  mstate.esp -= 4;
                  mstate.funcs[this.i6]();
                  return;
               }
               addr1607:
               if(this.i1 >= 1)
               {
                  this.i5 = 0;
                  this.i6 = this.i0 + 16;
                  this.i7 = this.i5;
                  §§goto(addr1627);
               }
               else
               {
                  §§goto(addr1712);
               }
               break;
            case 9:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               si32(this.i5,this.i4);
               §§goto(addr990);
            case 10:
               this.i13 = mstate.eax;
               mstate.esp += 16;
               si32(this.i13,this.i4);
               §§goto(addr1166);
            case 11:
               this.i11 = mstate.eax;
               mstate.esp += 16;
               si32(this.i11,this.i4);
               §§goto(addr1294);
            case 12:
               this.i12 = mstate.eax;
               mstate.esp += 16;
               si32(this.i12,this.i4);
               §§goto(addr1421);
            case 13:
               mstate.esp += 8;
               §§goto(addr1476);
            case 14:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               si32(this.i5,this.i4);
               §§goto(addr1607);
            case 15:
               mstate.esp += 12;
               this.i7 += 4;
               this.i5 += 1;
               if(this.i5 != this.i1)
               {
                  addr1627:
                  this.i8 = li32(this.i6);
                  this.i8 += this.i7;
                  this.i9 = li32(this.i2);
                  this.i8 = li32(this.i8);
                  mstate.esp -= 12;
                  si32(this.i8,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_DumpFunction.start();
                  return;
               }
               addr1712:
               this.i1 = li32(this.i3 + 12);
               this.i2 = this.i3 + 12;
               if(this.i1 != 0)
               {
                  this.i1 = 0;
               }
               else
               {
                  this.i1 = li32(this.i0 + 48);
               }
               this.i5 = li32(this.i0 + 20);
               mstate.esp -= 12;
               si32(this.i5,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_DumpVector.start();
               return;
               break;
            case 16:
               mstate.esp += 12;
               this.i1 = li32(this.i2);
               if(this.i1 == 0)
               {
                  this.i1 = li32(this.i0 + 56);
                  si32(this.i1,mstate.ebp + -24);
                  this.i5 = li32(this.i4);
                  if(this.i5 == 0)
                  {
                     this.i5 = 4;
                     this.i6 = li32(this.i3 + 4);
                     this.i7 = li32(this.i3 + 8);
                     this.i8 = li32(this.i3);
                     mstate.esp -= 16;
                     this.i9 = mstate.ebp + -24;
                     si32(this.i8,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     si32(this.i5,mstate.esp + 8);
                     si32(this.i7,mstate.esp + 12);
                     state = 17;
                     mstate.esp -= 4;
                     mstate.funcs[this.i6]();
                     return;
                  }
                  addr1921:
                  if(this.i1 <= 0)
                  {
                     this.i1 = this.i5;
                  }
                  else
                  {
                     this.i5 = 0;
                     this.i6 = mstate.ebp + -40;
                     this.i7 = this.i3 + 8;
                     this.i8 = this.i3 + 4;
                     this.i9 = mstate.ebp + -36;
                     this.i10 = this.i0 + 24;
                     this.i11 = this.i3;
                     this.i12 = this.i5;
                     §§goto(addr2090);
                  }
               }
               else
               {
                  this.i1 = 0;
                  si32(this.i1,mstate.ebp + -28);
                  this.i1 = li32(this.i4);
                  if(this.i1 == 0)
                  {
                     this.i1 = 4;
                     this.i5 = li32(this.i3 + 4);
                     this.i6 = li32(this.i3 + 8);
                     this.i7 = li32(this.i3);
                     mstate.esp -= 16;
                     this.i8 = mstate.ebp + -28;
                     si32(this.i7,mstate.esp);
                     si32(this.i8,mstate.esp + 4);
                     si32(this.i1,mstate.esp + 8);
                     si32(this.i6,mstate.esp + 12);
                     state = 18;
                     mstate.esp -= 4;
                     mstate.funcs[this.i5]();
                     return;
                  }
               }
               addr2402:
               this.i2 = li32(this.i2);
               if(this.i2 != 0)
               {
                  this.i0 = 0;
                  si32(this.i0,mstate.ebp + -48);
                  if(this.i1 == 0)
                  {
                     this.i0 = 4;
                     this.i1 = li32(this.i3 + 4);
                     this.i2 = li32(this.i3 + 8);
                     this.i3 = li32(this.i3);
                     mstate.esp -= 16;
                     this.i5 = mstate.ebp + -48;
                     si32(this.i3,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     si32(this.i2,mstate.esp + 12);
                     state = 24;
                     mstate.esp -= 4;
                     mstate.funcs[this.i1]();
                     return;
                  }
                  break;
               }
               this.i2 = li32(this.i0 + 36);
               si32(this.i2,mstate.ebp + -44);
               if(this.i1 == 0)
               {
                  this.i1 = 4;
                  this.i5 = li32(this.i3 + 4);
                  this.i6 = li32(this.i3 + 8);
                  this.i7 = li32(this.i3);
                  mstate.esp -= 16;
                  this.i8 = mstate.ebp + -44;
                  si32(this.i7,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 22;
                  mstate.esp -= 4;
                  mstate.funcs[this.i5]();
                  return;
               }
               addr2526:
               if(this.i2 >= 1)
               {
                  this.i1 = 0;
                  this.i4 = this.i0 + 28;
                  this.i0 = this.i1;
                  §§goto(addr2547);
               }
               else
               {
                  break;
                  addr2757:
               }
               break;
            case 17:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               si32(this.i5,this.i4);
               §§goto(addr1921);
            case 18:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               si32(this.i1,this.i4);
               §§goto(addr2402);
            case 19:
               mstate.esp += 8;
               this.i13 = li32(this.i10);
               this.i13 += this.i12;
               this.i13 = li32(this.i13 + 4);
               si32(this.i13,mstate.ebp + -36);
               this.i13 = li32(this.i4);
               if(this.i13 == 0)
               {
                  this.i13 = 4;
                  this.i14 = li32(this.i8);
                  this.i15 = li32(this.i7);
                  this.i16 = li32(this.i11);
                  mstate.esp -= 16;
                  si32(this.i16,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i13,mstate.esp + 8);
                  si32(this.i15,mstate.esp + 12);
                  state = 20;
                  mstate.esp -= 4;
                  mstate.funcs[this.i14]();
                  return;
               }
               addr2264:
               this.i14 = li32(this.i10);
               this.i14 += this.i12;
               this.i14 = li32(this.i14 + 8);
               si32(this.i14,mstate.ebp + -40);
               if(this.i13 == 0)
               {
                  this.i13 = 4;
                  this.i14 = li32(this.i8);
                  this.i15 = li32(this.i7);
                  this.i16 = li32(this.i11);
                  mstate.esp -= 16;
                  si32(this.i16,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  si32(this.i13,mstate.esp + 8);
                  si32(this.i15,mstate.esp + 12);
                  state = 21;
                  mstate.esp -= 4;
                  mstate.funcs[this.i14]();
                  return;
               }
               addr2379:
               this.i12 += 12;
               this.i5 += 1;
               if(this.i5 != this.i1)
               {
                  addr2090:
                  this.i13 = li32(this.i10);
                  this.i13 += this.i12;
                  this.i13 = li32(this.i13);
                  mstate.esp -= 8;
                  si32(this.i13,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 19;
                  mstate.esp -= 4;
                  FSM_DumpString.start();
                  return;
               }
               this.i1 = this.i13;
               §§goto(addr2402);
               break;
            case 20:
               this.i13 = mstate.eax;
               mstate.esp += 16;
               si32(this.i13,this.i4);
               §§goto(addr2264);
            case 21:
               this.i13 = mstate.eax;
               mstate.esp += 16;
               si32(this.i13,this.i4);
               §§goto(addr2379);
            case 22:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               si32(this.i1,this.i4);
               §§goto(addr2526);
            case 23:
               mstate.esp += 8;
               this.i0 += 4;
               this.i1 += 1;
               if(this.i1 != this.i2)
               {
                  addr2547:
                  this.i5 = li32(this.i4);
                  this.i5 += this.i0;
                  this.i5 = li32(this.i5);
                  mstate.esp -= 8;
                  si32(this.i5,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 23;
                  mstate.esp -= 4;
                  FSM_DumpString.start();
                  return;
               }
               §§goto(addr2757);
               break;
            case 24:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               si32(this.i0,this.i4);
               break;
            default:
               throw "Invalid state in _DumpFunction";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
