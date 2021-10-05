package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaV_concat extends Machine
   {
      
      public static const intRegCount:int = 25;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i21:int;
      
      public var f0:Number;
      
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
      
      public var i20:int;
      
      public var i9:int;
      
      public function FSM_luaV_concat()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaV_concat = null;
         _loc1_ = new FSM_luaV_concat();
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
               mstate.esp -= 96;
               this.i0 = mstate.ebp + -96;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = this.i1 + 44;
               this.i5 = this.i1 + 28;
               this.i6 = this.i1 + 8;
               this.i7 = this.i1 + 32;
               this.i8 = this.i1 + 16;
               this.i9 = this.i1 + 12;
               this.i10 = mstate.ebp + -64;
               this.i11 = mstate.ebp + -32;
               this.i12 = this.i11;
               this.i13 = this.i10;
               this.i14 = this.i0;
               loop0:
               while(true)
               {
                  this.i15 = this.i3 + -1;
                  this.i16 = li32(this.i9);
                  this.i17 = this.i15 * 12;
                  this.i17 = this.i16 + this.i17;
                  this.i18 = li32(this.i17 + 8);
                  this.i17 += 8;
                  this.i19 = this.i3 + 1;
                  this.i20 = this.i16;
                  this.i18 += -3;
                  if(uint(this.i18) <= uint(1))
                  {
                     this.i18 = this.i3 * 12;
                     this.i18 = this.i20 + this.i18;
                     this.i21 = li32(this.i18 + 8);
                     this.i18 += 8;
                     if(this.i21 != 4)
                     {
                        this.i22 = this.i3 * 12;
                        this.i22 = this.i20 + this.i22;
                        if(this.i21 == 3)
                        {
                           this.i21 = __2E_str1166;
                           this.i23 = this.i3 * 12;
                           this.i23 = this.i20 + this.i23;
                           this.f0 = lf64(this.i23);
                           mstate.esp -= 16;
                           si32(this.i14,mstate.esp);
                           si32(this.i21,mstate.esp + 4);
                           sf64(this.f0,mstate.esp + 8);
                           state = 1;
                           mstate.esp -= 4;
                           FSM_sprintf.start();
                           return;
                        }
                     }
                     else
                     {
                        while(true)
                        {
                           this.i18 = this.i3 * 12;
                           this.i18 = this.i20 + this.i18;
                           this.i18 = li32(this.i18);
                           this.i18 = li32(this.i18 + 12);
                           if(this.i18 != 0)
                           {
                              if(this.i2 <= 1)
                              {
                                 this.i15 = 1;
                              }
                              else
                              {
                                 this.i15 = 1;
                                 this.i17 = this.i3 * 12;
                                 this.i17 = this.i16 + this.i17;
                                 loop1:
                                 while(true)
                                 {
                                    this.i21 = li32(this.i17 + -4);
                                    this.i22 = this.i17 + -4;
                                    if(this.i21 != 4)
                                    {
                                       if(this.i21 != 3)
                                       {
                                          break;
                                       }
                                       this.i21 = __2E_str1166;
                                       this.f0 = lf64(this.i17 + -12);
                                       mstate.esp -= 16;
                                       si32(this.i12,mstate.esp);
                                       si32(this.i21,mstate.esp + 4);
                                       sf64(this.f0,mstate.esp + 8);
                                       state = 11;
                                       mstate.esp -= 4;
                                       FSM_sprintf.start();
                                       return;
                                    }
                                    addr1200:
                                    while(true)
                                    {
                                       this.i21 = li32(this.i17 + -12);
                                       this.i21 = li32(this.i21 + 12);
                                       this.i22 = -3 - this.i18;
                                       if(uint(this.i22) <= uint(this.i21))
                                       {
                                          this.i22 = __2E_str5170;
                                          mstate.esp -= 8;
                                          si32(this.i1,mstate.esp);
                                          si32(this.i22,mstate.esp + 4);
                                          state = 10;
                                          mstate.esp -= 4;
                                          FSM_luaG_runerror.start();
                                          return;
                                       }
                                       addr1271:
                                       while(true)
                                       {
                                          this.i17 += -12;
                                          this.i15 += 1;
                                          this.i18 = this.i21 + this.i18;
                                          if(this.i15 >= this.i2)
                                          {
                                             break loop1;
                                          }
                                          continue loop1;
                                       }
                                    }
                                 }
                              }
                              this.i17 = this.i18;
                              this.i18 = li32(this.i8);
                              mstate.esp -= 12;
                              this.i18 += 52;
                              si32(this.i1,mstate.esp);
                              si32(this.i18,mstate.esp + 4);
                              si32(this.i17,mstate.esp + 8);
                              state = 9;
                              mstate.esp -= 4;
                              FSM_luaZ_openspace.start();
                              return;
                           }
                           this.i3 = li32(this.i17);
                           if(this.i3 == 4)
                           {
                              this.i3 = 2;
                              addr1588:
                              while(true)
                              {
                                 this.i2 -= this.i3;
                                 this.i3 = this.i19 - this.i3;
                                 this.i2 += 1;
                                 if(this.i2 < 2)
                                 {
                                    break loop0;
                                 }
                                 continue loop0;
                              }
                              addr1588:
                           }
                           else
                           {
                              this.i16 = this.i15 * 12;
                              this.i16 = this.i20 + this.i16;
                              if(this.i3 == 3)
                              {
                                 this.i3 = __2E_str1166;
                                 this.i18 = this.i15 * 12;
                                 this.i18 = this.i20 + this.i18;
                                 this.f0 = lf64(this.i18);
                                 mstate.esp -= 16;
                                 si32(this.i13,mstate.esp);
                                 si32(this.i3,mstate.esp + 4);
                                 sf64(this.f0,mstate.esp + 8);
                                 state = 8;
                                 mstate.esp -= 4;
                                 FSM_sprintf.start();
                                 return;
                              }
                              addr1836:
                              while(true)
                              {
                                 this.i2 += -1;
                                 if(this.i2 < 2)
                                 {
                                    break loop0;
                                 }
                                 this.i3 = this.i15;
                                 continue loop0;
                              }
                           }
                        }
                        addr1714:
                     }
                  }
                  this.i16 = 15;
                  this.i18 = this.i15 * 12;
                  mstate.esp -= 12;
                  this.i18 = this.i20 + this.i18;
                  si32(this.i1,mstate.esp);
                  si32(this.i18,mstate.esp + 4);
                  si32(this.i16,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaT_gettmbyobj.start();
               }
               §§goto(addr1615);
            case 2:
               this.i16 = mstate.eax;
               mstate.esp += 12;
               this.i21 = this.i3 * 12;
               this.i22 = li32(this.i16 + 8);
               this.i21 = this.i20 + this.i21;
               if(this.i22 == 0)
               {
                  this.i16 = 15;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i21,mstate.esp + 4);
                  si32(this.i16,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaT_gettmbyobj.start();
                  addr460:
                  this.i16 = mstate.eax;
                  mstate.esp += 12;
               }
               this.i22 = li32(this.i16 + 8);
               this.i23 = this.i16 + 8;
               if(this.i22 != 0)
               {
                  this.i21 = li32(this.i7);
                  this.i22 = li32(this.i6);
                  this.f0 = lf64(this.i16);
                  sf64(this.f0,this.i22);
                  this.i16 = li32(this.i23);
                  this.i15 *= 12;
                  si32(this.i16,this.i22 + 8);
                  this.i15 = this.i20 + this.i15;
                  this.i16 = li32(this.i6);
                  this.f0 = lf64(this.i15);
                  sf64(this.f0,this.i16 + 12);
                  this.i15 = li32(this.i17);
                  this.i3 *= 12;
                  si32(this.i15,this.i16 + 20);
                  this.i3 = this.i20 + this.i3;
                  this.i15 = li32(this.i6);
                  this.f0 = lf64(this.i3);
                  sf64(this.f0,this.i15 + 24);
                  this.i3 = li32(this.i3 + 8);
                  si32(this.i3,this.i15 + 32);
                  this.i3 = li32(this.i5);
                  this.i15 = li32(this.i6);
                  this.i16 = this.i18 - this.i21;
                  this.i3 -= this.i15;
                  if(this.i3 <= 36)
                  {
                     this.i3 = li32(this.i4);
                     if(this.i3 >= 3)
                     {
                        mstate.esp -= 8;
                        this.i3 <<= 1;
                        si32(this.i1,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        state = 4;
                        mstate.esp -= 4;
                        FSM_luaD_reallocstack.start();
                        return;
                     }
                     mstate.esp -= 8;
                     this.i3 += 3;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  break;
               }
               this.i3 = __2E_str2110;
               this.i16 = li32(this.i17);
               this.i16 += -3;
               mstate.esp -= 12;
               this.i16 = uint(this.i16) < uint(2) ? int(this.i21) : int(this.i18);
               si32(this.i1,mstate.esp);
               si32(this.i16,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaG_typeerror.start();
               return;
               break;
            case 6:
               mstate.esp += 12;
               this.i3 = li32(this.i6);
               this.i15 = li32(this.i7);
               this.i17 = this.i3 + -12;
               si32(this.i17,this.i6);
               this.f0 = lf64(this.i3 + -12);
               this.i15 += this.i16;
               sf64(this.f0,this.i15);
               this.i3 = li32(this.i3 + -4);
               si32(this.i3,this.i15 + 8);
               this.i3 = 2;
               §§goto(addr1588);
            case 7:
               mstate.esp += 12;
               this.i2 += -1;
               if(this.i2 >= 2)
               {
                  this.i3 = this.i15;
                  §§goto(addr114);
               }
               addr1615:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 12:
               this.i17 = mstate.eax;
               this.i3 *= 12;
               mstate.esp += 12;
               this.i3 = this.i20 + this.i3;
               si32(this.i17,this.i3);
               si32(this.i16,this.i3 + 8);
               this.i3 = this.i15;
               §§goto(addr1588);
            case 13:
               this.i21 = mstate.eax;
               mstate.esp += 12;
               si32(this.i21,this.i22);
               si32(this.i23,this.i18);
               §§goto(addr1714);
            case 14:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i16);
               si32(this.i18,this.i17);
               §§goto(addr1836);
            case 3:
               §§goto(addr460);
            case 1:
               mstate.esp += 16;
               this.i21 = li8(this.i14);
               if(this.i21 != 0)
               {
                  this.i21 = this.i0;
                  while(true)
                  {
                     this.i23 = li8(this.i21 + 1);
                     this.i21 += 1;
                     this.i24 = this.i21;
                     if(this.i23 == 0)
                     {
                        break;
                     }
                     this.i21 = this.i24;
                  }
               }
               else
               {
                  this.i21 = this.i14;
               }
               this.i23 = 4;
               mstate.esp -= 12;
               this.i21 -= this.i0;
               si32(this.i1,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               si32(this.i21,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 4:
               mstate.esp += 8;
               break;
            case 5:
               mstate.esp += 8;
               break;
            case 8:
               mstate.esp += 16;
               this.i3 = li8(this.i13);
               if(this.i3 != 0)
               {
                  this.i3 = this.i10;
                  while(true)
                  {
                     this.i18 = li8(this.i3 + 1);
                     this.i3 += 1;
                     this.i19 = this.i3;
                     if(this.i18 == 0)
                     {
                        break;
                     }
                     this.i3 = this.i19;
                  }
               }
               else
               {
                  this.i3 = this.i13;
               }
               this.i18 = 4;
               mstate.esp -= 12;
               this.i3 -= this.i10;
               si32(this.i1,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 9:
               this.i17 = mstate.eax;
               mstate.esp += 12;
               if(this.i15 <= 0)
               {
                  this.i3 = 0;
               }
               else
               {
                  this.i18 = 0;
                  this.i3 -= this.i15;
                  this.i3 *= 12;
                  this.i3 += this.i16;
                  this.i3 += 12;
                  this.i16 = this.i15;
                  do
                  {
                     this.i21 = li32(this.i3);
                     this.i22 = li32(this.i21 + 12);
                     this.i23 = this.i17 + this.i18;
                     this.i21 += 16;
                     memcpy(this.i23,this.i21,this.i22);
                     this.i3 += 12;
                     this.i16 += -1;
                     this.i18 = this.i22 + this.i18;
                  }
                  while(this.i16 > 0);
                  
                  this.i3 = this.i18;
               }
               this.i16 = 4;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i17,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               this.i3 = this.i19 - this.i15;
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               mstate.esp += 8;
               §§goto(addr1271);
            case 11:
               mstate.esp += 16;
               this.i21 = li8(this.i12);
               if(this.i21 != 0)
               {
                  this.i21 = this.i11;
                  while(true)
                  {
                     this.i23 = li8(this.i21 + 1);
                     this.i21 += 1;
                     this.i24 = this.i21;
                     if(this.i23 == 0)
                     {
                        break;
                     }
                     this.i21 = this.i24;
                  }
               }
               else
               {
                  this.i21 = this.i12;
               }
               this.i23 = 4;
               mstate.esp -= 12;
               this.i21 -= this.i11;
               si32(this.i1,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i21,mstate.esp + 8);
               state = 15;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 15:
               this.i21 = mstate.eax;
               mstate.esp += 12;
               si32(this.i21,this.i17 + -12);
               si32(this.i23,this.i22);
               §§goto(addr1200);
            default:
               throw "Invalid state in _luaV_concat";
         }
         this.i3 = 1;
         this.i15 = li32(this.i6);
         this.i17 = this.i15 + 36;
         si32(this.i17,this.i6);
         mstate.esp -= 12;
         si32(this.i1,mstate.esp);
         si32(this.i15,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 6;
         mstate.esp -= 4;
         FSM_luaD_call.start();
      }
   }
}
