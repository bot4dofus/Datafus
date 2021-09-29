package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaD_precall extends Machine
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
      
      public function FSM_luaD_precall()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaD_precall = null;
         _loc1_ = new FSM_luaD_precall();
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
               mstate.esp -= 16;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = li32(this.i1 + 8);
               if(this.i3 != 6)
               {
                  this.i3 = 16;
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaT_gettmbyobj.start();
                  addr98:
                  this.i3 = mstate.eax;
                  mstate.esp += 12;
                  this.i4 = li32(this.i0 + 32);
                  this.i5 = li32(this.i3 + 8);
                  this.i6 = this.i0 + 8;
                  this.i7 = this.i3 + 8;
                  this.i4 = this.i1 - this.i4;
                  this.i8 = this.i0 + 32;
                  if(this.i5 != 6)
                  {
                     this.i5 = __2E_str9216;
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i5,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaG_typeerror.start();
                     return;
                  }
                  this.i5 = li32(this.i6);
                  if(uint(this.i5) > uint(this.i1))
                  {
                     addr231:
                     this.i9 = 0;
                     this.i10 = this.i5;
                     do
                     {
                        this.i11 = this.i9 ^ -1;
                        this.i11 *= 12;
                        this.i11 = this.i5 + this.i11;
                        this.f0 = lf64(this.i11);
                        sf64(this.f0,this.i10);
                        this.i12 = li32(this.i11 + 8);
                        si32(this.i12,this.i10 + 8);
                        this.i10 += -12;
                        this.i9 += 1;
                     }
                     while(uint(this.i11) > uint(this.i1));
                     
                  }
                  addr306:
                  this.i1 = li32(this.i0 + 28);
                  this.i5 = li32(this.i6);
                  this.i1 -= this.i5;
                  if(this.i1 <= 12)
                  {
                     this.i1 = li32(this.i0 + 44);
                     if(this.i1 >= 1)
                     {
                        mstate.esp -= 8;
                        this.i1 <<= 1;
                        si32(this.i0,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 3;
                        mstate.esp -= 4;
                        FSM_luaD_reallocstack.start();
                        return;
                     }
                     mstate.esp -= 8;
                     this.i1 += 1;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  addr429:
                  this.i1 = li32(this.i6);
                  this.i1 += 12;
                  si32(this.i1,this.i6);
                  this.i1 = li32(this.i8);
                  this.f0 = lf64(this.i3);
                  this.i1 += this.i4;
                  sf64(this.f0,this.i1);
                  this.i3 = li32(this.i7);
                  si32(this.i3,this.i1 + 8);
               }
               this.i3 = li32(this.i0 + 32);
               this.i4 = li32(this.i1);
               this.i5 = li32(this.i0 + 20);
               this.i6 = li32(this.i0 + 24);
               si32(this.i6,this.i5 + 12);
               this.i5 = li8(this.i4 + 6);
               this.i6 = this.i0 + 24;
               this.i7 = this.i0 + 20;
               this.i1 -= this.i3;
               this.i3 = this.i0 + 32;
               if(this.i5 == 0)
               {
                  this.i4 = li32(this.i4 + 16);
                  this.i5 = li8(this.i4 + 75);
                  this.i8 = li32(this.i0 + 28);
                  this.i9 = li32(this.i0 + 8);
                  this.i10 = this.i4 + 75;
                  this.i11 = this.i0 + 8;
                  this.i12 = this.i5 * 12;
                  this.i8 -= this.i9;
                  if(this.i8 <= this.i12)
                  {
                     this.i8 = li32(this.i0 + 44);
                     if(this.i8 >= this.i5)
                     {
                        mstate.esp -= 8;
                        this.i5 = this.i8 << 1;
                        si32(this.i0,mstate.esp);
                        si32(this.i5,mstate.esp + 4);
                        state = 5;
                        mstate.esp -= 4;
                        FSM_luaD_reallocstack.start();
                        return;
                     }
                     mstate.esp -= 8;
                     this.i5 = this.i8 + this.i5;
                     si32(this.i0,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  addr710:
                  this.i5 = li32(this.i3);
                  this.i8 = li8(this.i4 + 74);
                  this.i5 += this.i1;
                  this.i9 = this.i4 + 74;
                  this.i12 = this.i5;
                  if(this.i8 == 0)
                  {
                     this.i1 = li8(this.i4 + 73);
                     this.i1 *= 12;
                     this.i3 = li32(this.i11);
                     this.i1 += this.i12;
                     this.i1 += 12;
                     this.i5 = this.i12 + 12;
                     if(uint(this.i3) <= uint(this.i1))
                     {
                        this.i1 = this.i5;
                        this.i5 = this.i12;
                        addr2882:
                        this.i3 = this.i1;
                        this.i8 = this.i5;
                        this.i1 = li32(this.i7);
                        this.i5 = li32(this.i0 + 36);
                        if(this.i1 != this.i5)
                        {
                           this.i5 = this.i3;
                           this.i3 = this.i8;
                           addr831:
                           this.i9 = this.i1 + 24;
                           this.i8 = this.i9;
                           this.i1 = this.i5;
                           this.i5 = this.i9;
                           addr3099:
                           this.i9 = 0;
                           si32(this.i8,this.i7);
                           si32(this.i3,this.i5 + 4);
                           si32(this.i1,this.i5);
                           si32(this.i1,this.i0 + 12);
                           this.i3 = li8(this.i10);
                           this.i3 *= 12;
                           this.i1 += this.i3;
                           si32(this.i1,this.i5 + 8);
                           this.i1 = li32(this.i4 + 12);
                           si32(this.i1,this.i6);
                           si32(this.i9,this.i5 + 20);
                           si32(this.i2,this.i5 + 16);
                           this.i1 = li32(this.i11);
                           this.i2 = li32(this.i5 + 8);
                           this.i3 = this.i5 + 8;
                           if(uint(this.i2) <= uint(this.i1))
                           {
                              this.i1 = this.i2;
                           }
                           else
                           {
                              do
                              {
                                 this.i2 = 0;
                                 si32(this.i2,this.i1 + 8);
                                 this.i2 = li32(this.i3);
                                 this.i1 += 12;
                              }
                              while(uint(this.i2) > uint(this.i1));
                              
                              this.i1 = this.i2;
                           }
                           si32(this.i1,this.i11);
                           this.i1 = li8(this.i0 + 56);
                           this.i1 &= 1;
                           if(this.i1 == 0)
                           {
                              this.i0 = 0;
                              addr3278:
                              mstate.eax = this.i0;
                              break;
                           }
                           this.i1 = -1;
                           this.i2 = li32(this.i6);
                           this.i2 += 4;
                           si32(this.i2,this.i6);
                           mstate.esp -= 12;
                           this.i2 = 0;
                           si32(this.i0,mstate.esp);
                           si32(this.i2,mstate.esp + 4);
                           si32(this.i1,mstate.esp + 8);
                           state = 27;
                           mstate.esp -= 4;
                           FSM_luaD_callhook.start();
                           return;
                        }
                        this.i1 = this.i3;
                        this.i5 = this.i8;
                     }
                     else
                     {
                        si32(this.i1,this.i11);
                        this.i1 = li32(this.i7);
                        this.i3 = li32(this.i0 + 36);
                        if(this.i1 != this.i3)
                        {
                           this.i3 = this.i12;
                           §§goto(addr831);
                        }
                        else
                        {
                           this.i1 = this.i5;
                           this.i5 = this.i12;
                        }
                     }
                     this.i3 = this.i5;
                     this.i5 = li32(this.i0 + 48);
                     this.i8 = this.i0 + 48;
                     if(this.i5 >= 20001)
                     {
                        this.i1 = 5;
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        §§goto(addr2970);
                     }
                     else
                     {
                        §§goto(addr2989);
                     }
                  }
                  else
                  {
                     this.i8 = li32(this.i11);
                     this.i5 = this.i8 - this.i5;
                     this.i12 = li8(this.i4 + 73);
                     this.i5 /= 12;
                     this.i13 = this.i5 + -1;
                     this.i14 = this.i12;
                     if(this.i13 >= this.i12)
                     {
                        this.i5 = this.i8;
                        this.i8 = this.i13;
                     }
                     else
                     {
                        this.i13 = 0;
                        this.i5 = this.i12 - this.i5;
                        this.i5 += 1;
                        do
                        {
                           this.i15 = 0;
                           si32(this.i15,this.i8 + 8);
                           this.i8 += 12;
                           si32(this.i8,this.i11);
                           this.i13 += 1;
                        }
                        while(this.i13 != this.i5);
                        
                        this.i5 = this.i8;
                        this.i8 = this.i12;
                     }
                     this.i9 = li8(this.i9);
                     this.i9 &= 4;
                     if(this.i9 != 0)
                     {
                        this.i5 = li32(this.i0 + 16);
                        this.i9 = li32(this.i5 + 68);
                        this.i13 = li32(this.i5 + 64);
                        this.i15 = this.i5 + 68;
                        this.i16 = this.i0 + 16;
                        this.i17 = this.i8 - this.i12;
                        if(uint(this.i9) >= uint(this.i13))
                        {
                           this.i5 = 32;
                           mstate.esp -= 4;
                           si32(this.i0,mstate.esp);
                           state = 7;
                           mstate.esp -= 4;
                           FSM_luaC_step.start();
                           return;
                        }
                        this.i9 = 32;
                        this.i13 = li32(this.i5 + 12);
                        this.i5 = li32(this.i5 + 16);
                        mstate.esp -= 16;
                        this.i18 = 0;
                        si32(this.i5,mstate.esp);
                        si32(this.i18,mstate.esp + 4);
                        si32(this.i18,mstate.esp + 8);
                        si32(this.i9,mstate.esp + 12);
                        state = 15;
                        mstate.esp -= 4;
                        mstate.funcs[this.i13]();
                        return;
                     }
                     if(this.i12 <= 0)
                     {
                        this.i8 = 0;
                     }
                     else
                     {
                        this.i14 = 0;
                        this.i13 = this.i5;
                        addr2723:
                        this.i9 = this.i13;
                        this.i13 = this.i14;
                        this.i14 = 0;
                        this.i8 *= -12;
                        this.i8 = this.i9 + this.i8;
                        this.i9 = this.i14;
                        do
                        {
                           this.i14 = 0;
                           this.i15 = li32(this.i11);
                           this.i16 = this.i15 + 12;
                           si32(this.i16,this.i11);
                           this.f0 = lf64(this.i8);
                           sf64(this.f0,this.i15);
                           this.i16 = li32(this.i8 + 8);
                           si32(this.i16,this.i15 + 8);
                           si32(this.i14,this.i8 + 8);
                           this.i8 += 12;
                           this.i9 += 1;
                        }
                        while(this.i9 < this.i12);
                        
                        this.i8 = this.i13;
                     }
                     addr2826:
                     if(this.i8 != 0)
                     {
                        this.i9 = 5;
                        this.i12 = li32(this.i11);
                        this.i13 = this.i12 + 12;
                        si32(this.i13,this.i11);
                        si32(this.i8,this.i12);
                        si32(this.i9,this.i12 + 8);
                     }
                     this.i3 = li32(this.i3);
                     this.i3 += this.i1;
                     this.i1 = this.i5;
                     this.i5 = this.i3;
                  }
                  §§goto(addr2882);
               }
               else
               {
                  this.i4 = li32(this.i0 + 28);
                  this.i5 = li32(this.i0 + 8);
                  this.i6 = this.i0 + 8;
                  this.i4 -= this.i5;
                  if(this.i4 <= 240)
                  {
                     this.i4 = li32(this.i0 + 44);
                     if(this.i4 >= 20)
                     {
                        mstate.esp -= 8;
                        this.i4 <<= 1;
                        si32(this.i0,mstate.esp);
                        si32(this.i4,mstate.esp + 4);
                        state = 28;
                        mstate.esp -= 4;
                        FSM_luaD_reallocstack.start();
                        return;
                     }
                     mstate.esp -= 8;
                     this.i4 += 20;
                     si32(this.i0,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     state = 29;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  addr3497:
                  this.i4 = li32(this.i7);
                  this.i5 = li32(this.i0 + 36);
                  if(this.i4 == this.i5)
                  {
                     this.i4 = li32(this.i0 + 48);
                     this.i5 = this.i0 + 48;
                     if(this.i4 < 20001)
                     {
                        mstate.esp -= 8;
                        this.i4 <<= 1;
                        si32(this.i0,mstate.esp);
                        si32(this.i4,mstate.esp + 4);
                        state = 30;
                        mstate.esp -= 4;
                        FSM_luaD_reallocCI.start();
                        return;
                     }
                     this.i4 = 5;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                  }
                  else
                  {
                     this.i4 += 24;
                     this.i5 = this.i4;
                     addr3676:
                     si32(this.i5,this.i7);
                     this.i3 = li32(this.i3);
                     this.i1 = this.i3 + this.i1;
                     si32(this.i1,this.i4 + 4);
                     this.i1 += 12;
                     si32(this.i1,this.i4);
                     si32(this.i1,this.i0 + 12);
                     this.i1 = li32(this.i6);
                     this.i1 += 240;
                     si32(this.i1,this.i4 + 8);
                     si32(this.i2,this.i4 + 16);
                     this.i1 = li8(this.i0 + 56);
                     this.i1 &= 1;
                     if(this.i1 != 0)
                     {
                        this.i1 = -1;
                        mstate.esp -= 12;
                        this.i2 = 0;
                        si32(this.i0,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        si32(this.i1,mstate.esp + 8);
                        state = 32;
                        mstate.esp -= 4;
                        FSM_luaD_callhook.start();
                        return;
                     }
                     §§goto(addr3811);
                  }
               }
               addr2970:
               state = 24;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 1:
               §§goto(addr98);
            case 2:
               mstate.esp += 12;
               this.i5 = li32(this.i6);
               if(uint(this.i5) > uint(this.i1))
               {
                  §§goto(addr231);
               }
               §§goto(addr306);
            case 3:
               mstate.esp += 8;
               §§goto(addr429);
            case 4:
               mstate.esp += 8;
               §§goto(addr429);
            case 5:
               mstate.esp += 8;
               §§goto(addr710);
            case 6:
               mstate.esp += 8;
               §§goto(addr710);
            case 7:
               mstate.esp += 4;
               this.i15 = li32(this.i16);
               this.i9 = li32(this.i15 + 12);
               this.i13 = li32(this.i15 + 16);
               mstate.esp -= 16;
               this.i18 = 0;
               si32(this.i13,mstate.esp);
               si32(this.i18,mstate.esp + 4);
               si32(this.i18,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 8;
               mstate.esp -= 4;
               mstate.funcs[this.i9]();
               return;
            case 8:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               if(this.i5 == 0)
               {
                  this.i9 = 4;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               addr1196:
               this.i9 = 5;
               this.i13 = li32(this.i15 + 68);
               this.i13 += 32;
               si32(this.i13,this.i15 + 68);
               this.i15 = li32(this.i16);
               this.i13 = li32(this.i15 + 28);
               si32(this.i13,this.i5);
               si32(this.i5,this.i15 + 28);
               this.i15 = li8(this.i15 + 20);
               this.i15 &= 3;
               si8(this.i15,this.i5 + 5);
               si8(this.i9,this.i5 + 4);
               this.i15 = 0;
               si32(this.i15,this.i5 + 8);
               this.i9 = -1;
               si8(this.i9,this.i5 + 6);
               si32(this.i15,this.i5 + 12);
               si32(this.i15,this.i5 + 28);
               si8(this.i15,this.i5 + 7);
               this.i15 = _dummynode_;
               si32(this.i15,this.i5 + 16);
               this.i15 = this.i5 + 28;
               this.i9 = this.i5 + 12;
               this.i13 = this.i17 + 1;
               if(uint(this.i13) <= uint(357913941))
               {
                  this.i13 = 0;
                  this.i16 = li32(this.i16);
                  this.i18 = li32(this.i16 + 12);
                  this.i19 = li32(this.i16 + 16);
                  mstate.esp -= 16;
                  this.i20 = this.i17 * 12;
                  si32(this.i19,mstate.esp);
                  si32(this.i13,mstate.esp + 4);
                  si32(this.i13,mstate.esp + 8);
                  si32(this.i20,mstate.esp + 12);
                  state = 10;
                  mstate.esp -= 4;
                  mstate.funcs[this.i18]();
                  return;
               }
               this.i16 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i16,mstate.esp + 4);
               state = 12;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 9:
               mstate.esp += 8;
               §§goto(addr1196);
            case 10:
               this.i13 = mstate.eax;
               mstate.esp += 16;
               if(this.i13 == 0)
               {
                  if(this.i20 != 0)
                  {
                     this.i18 = 4;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i18,mstate.esp + 4);
                     state = 11;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               §§goto(addr1488);
            case 11:
               mstate.esp += 8;
               §§goto(addr1488);
            case 12:
               mstate.esp += 8;
               this.i16 = 0;
               si32(this.i16,this.i9);
               this.i16 = li32(this.i15);
               if(this.i16 < this.i17)
               {
                  §§goto(addr1586);
               }
               addr1488:
               this.i18 = li32(this.i16 + 68);
               this.i18 = this.i20 + this.i18;
               si32(this.i18,this.i16 + 68);
               si32(this.i13,this.i9);
               this.i16 = li32(this.i15);
               if(this.i16 < this.i17)
               {
                  addr1586:
                  this.i13 = this.i16 * 12;
                  this.i13 += 8;
                  do
                  {
                     this.i18 = 0;
                     this.i19 = li32(this.i9);
                     this.i19 += this.i13;
                     si32(this.i18,this.i19);
                     this.i13 += 12;
                     this.i16 += 1;
                  }
                  while(this.i16 < this.i17);
                  
               }
               this.i16 = 1;
               si32(this.i17,this.i15);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i16,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_setnodevector.start();
               return;
            case 13:
               mstate.esp += 12;
               if(this.i17 > 0)
               {
                  addr1700:
                  this.i9 = mstate.ebp + -16;
                  this.i13 = this.i14 & 255;
                  this.i13 = this.i8 - this.i13;
                  this.i13 *= -12;
                  this.i14 = 0;
                  this.i15 = this.i9 + 8;
                  while(true)
                  {
                     this.i16 = _luaO_nilobject_;
                     this.i18 = li32(this.i11);
                     mstate.esp -= 8;
                     this.i19 = this.i14 + 1;
                     si32(this.i5,mstate.esp);
                     si32(this.i19,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_luaH_getnum.start();
                     §§goto(addr1779);
                  }
               }
               §§goto(addr2551);
            case 20:
               mstate.esp += 12;
               if(this.i17 > 0)
               {
                  §§goto(addr1700);
               }
               addr2551:
               this.i9 = __2E_str515;
               mstate.esp -= 12;
               this.i13 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 21:
               this.i19 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr2497);
            case 14:
               addr1779:
               while(true)
               {
                  this.i20 = mstate.eax;
                  mstate.esp += 8;
                  if(this.i20 == this.i16)
                  {
                     break;
                  }
                  this.i19 = this.i20;
                  while(true)
                  {
                     this.i16 = this.i19;
                     this.i18 += this.i13;
                     this.f0 = lf64(this.i18);
                     sf64(this.f0,this.i16);
                     this.i18 = li32(this.i18 + 8);
                     si32(this.i18,this.i16 + 8);
                     this.i13 += 12;
                     this.i14 += 1;
                     if(this.i14 < this.i17)
                     {
                        continue loop5;
                     }
                  }
                  continue loop5;
               }
               this.i16 = 3;
               this.f0 = Number(this.i19);
               sf64(this.f0,this.i9);
               si32(this.i16,this.i15);
               mstate.esp -= 12;
               this.i19 = mstate.ebp + -16;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i19,mstate.esp + 8);
               state = 21;
               mstate.esp -= 4;
               FSM_newkey.start();
               return;
            case 15:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               if(this.i5 == 0)
               {
                  this.i9 = 4;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  state = 16;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               addr1927:
               this.i9 = 5;
               this.i13 = li32(this.i15);
               this.i13 += 32;
               si32(this.i13,this.i15);
               this.i13 = li32(this.i16);
               this.i15 = li32(this.i13 + 28);
               si32(this.i15,this.i5);
               si32(this.i5,this.i13 + 28);
               this.i13 = li8(this.i13 + 20);
               this.i13 &= 3;
               si8(this.i13,this.i5 + 5);
               si8(this.i9,this.i5 + 4);
               this.i9 = 0;
               si32(this.i9,this.i5 + 8);
               this.i13 = -1;
               si8(this.i13,this.i5 + 6);
               si32(this.i9,this.i5 + 12);
               si32(this.i9,this.i5 + 28);
               si8(this.i9,this.i5 + 7);
               this.i9 = _dummynode_;
               si32(this.i9,this.i5 + 16);
               this.i9 = this.i5 + 28;
               this.i13 = this.i5 + 12;
               this.i15 = this.i17 + 1;
               if(uint(this.i15) <= uint(357913941))
               {
                  this.i15 = 0;
                  this.i16 = li32(this.i16);
                  this.i18 = li32(this.i16 + 12);
                  this.i19 = li32(this.i16 + 16);
                  mstate.esp -= 16;
                  this.i20 = this.i17 * 12;
                  si32(this.i19,mstate.esp);
                  si32(this.i15,mstate.esp + 4);
                  si32(this.i15,mstate.esp + 8);
                  si32(this.i20,mstate.esp + 12);
                  state = 17;
                  mstate.esp -= 4;
                  mstate.funcs[this.i18]();
                  return;
               }
               this.i15 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i15,mstate.esp + 4);
               state = 19;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 16:
               mstate.esp += 8;
               §§goto(addr1927);
            case 17:
               this.i15 = mstate.eax;
               mstate.esp += 16;
               if(this.i15 == 0)
               {
                  if(this.i20 != 0)
                  {
                     this.i18 = 4;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i18,mstate.esp + 4);
                     state = 18;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               §§goto(addr2215);
            case 18:
               mstate.esp += 8;
               §§goto(addr2215);
            case 19:
               mstate.esp += 8;
               this.i15 = 0;
               si32(this.i15,this.i13);
               this.i15 = li32(this.i9);
               if(this.i15 < this.i17)
               {
                  §§goto(addr2313);
               }
               addr2215:
               this.i18 = li32(this.i16 + 68);
               this.i18 = this.i20 + this.i18;
               si32(this.i18,this.i16 + 68);
               si32(this.i15,this.i13);
               this.i15 = li32(this.i9);
               if(this.i15 < this.i17)
               {
                  addr2313:
                  this.i16 = this.i15 * 12;
                  this.i16 += 8;
                  do
                  {
                     this.i18 = 0;
                     this.i19 = li32(this.i13);
                     this.i19 += this.i16;
                     si32(this.i18,this.i19);
                     this.i16 += 12;
                     this.i15 += 1;
                  }
                  while(this.i15 < this.i17);
                  
               }
               this.i13 = 1;
               si32(this.i17,this.i9);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_setnodevector.start();
               return;
            case 22:
               this.i9 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 23;
               mstate.esp -= 4;
               FSM_luaH_setstr.start();
               return;
            case 23:
               this.i9 = mstate.eax;
               mstate.esp += 12;
               this.f0 = Number(this.i17);
               sf64(this.f0,this.i9);
               this.i13 = 3;
               si32(this.i13,this.i9 + 8);
               this.i9 = li32(this.i11);
               if(this.i12 <= 0)
               {
                  this.i8 = this.i5;
                  this.i5 = this.i9;
               }
               else
               {
                  this.i13 = this.i9;
                  this.i14 = this.i5;
                  this.i5 = this.i9;
                  §§goto(addr2723);
               }
               §§goto(addr2826);
            case 24:
               mstate.esp += 8;
               addr2989:
               mstate.esp -= 8;
               this.i5 <<= 1;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 25;
               mstate.esp -= 4;
               FSM_luaD_reallocCI.start();
               return;
            case 25:
               mstate.esp += 8;
               this.i5 = li32(this.i8);
               if(this.i5 >= 20001)
               {
                  this.i5 = __2E_str313;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 26;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               addr3083:
               this.i5 = li32(this.i7);
               this.i5 += 24;
               this.i8 = this.i5;
               §§goto(addr3099);
               break;
            case 26:
               mstate.esp += 8;
               §§goto(addr3083);
            case 27:
               mstate.esp += 12;
               this.i0 = li32(this.i6);
               this.i0 += -4;
               si32(this.i0,this.i6);
               addr3951:
               mstate.eax = this.i2;
               break;
            case 28:
               mstate.esp += 8;
               §§goto(addr3497);
            case 29:
               mstate.esp += 8;
               §§goto(addr3497);
            case 30:
               mstate.esp += 8;
               this.i4 = li32(this.i5);
               if(this.i4 >= 20001)
               {
                  this.i4 = __2E_str313;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  state = 31;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               addr3650:
               this.i4 = li32(this.i7);
               this.i4 += 24;
               this.i5 = this.i4;
               §§goto(addr3676);
               break;
            case 31:
               mstate.esp += 8;
               §§goto(addr3650);
            case 32:
               mstate.esp += 12;
               addr3811:
               this.i1 = li32(this.i7);
               this.i1 = li32(this.i1 + 4);
               this.i1 = li32(this.i1);
               this.i1 = li32(this.i1 + 16);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 33;
               mstate.esp -= 4;
               mstate.funcs[this.i1]();
               return;
            case 33:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               if(this.i1 > -1)
               {
                  this.i2 = 1;
                  this.i1 = 0 - this.i1;
                  this.i3 = li32(this.i6);
                  this.i1 *= 12;
                  mstate.esp -= 8;
                  this.i1 = this.i3 + this.i1;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 34;
                  mstate.esp -= 4;
                  FSM_luaD_poscall.start();
                  return;
               }
               this.i0 = 2;
               §§goto(addr3278);
               break;
            case 34:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr3951);
            default:
               throw "Invalid state in _luaD_precall";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
