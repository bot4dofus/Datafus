package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_sweeplist extends Machine
   {
      
      public static const intRegCount:int = 14;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
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
      
      public function FSM_sweeplist()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_sweeplist = null;
         _loc1_ = new FSM_sweeplist();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop3:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 16);
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li8(this.i1 + 20);
               this.i4 = li32(this.i2);
               this.i3 ^= 3;
               this.i5 = this.i1 + 20;
               this.i6 = this.i0 + 16;
               this.i7 = li32(mstate.ebp + 16);
               if(this.i4 == 0)
               {
                  this.i0 = this.i2;
               }
               else
               {
                  this.i8 = 0;
                  this.i1 += 28;
                  loop0:
                  while(true)
                  {
                     this.i9 = this.i2;
                     this.i2 = this.i4;
                     if(this.i8 == this.i7)
                     {
                        this.i0 = this.i9;
                        break;
                     }
                     this.i4 = li8(this.i2 + 4);
                     this.i10 = this.i2 + 4;
                     this.i11 = this.i2;
                     if(this.i4 == 8)
                     {
                        this.i4 = -3;
                        mstate.esp -= 12;
                        this.i12 = this.i2 + 96;
                        si32(this.i0,mstate.esp);
                        si32(this.i12,mstate.esp + 4);
                        si32(this.i4,mstate.esp + 8);
                        state = 1;
                        mstate.esp -= 4;
                        FSM_sweeplist.start();
                        return;
                     }
                     addr176:
                     while(true)
                     {
                        this.i4 = li8(this.i11 + 5);
                        this.i11 += 5;
                        this.i12 = this.i4 ^ 3;
                        this.i12 &= this.i3;
                        this.i12 &= 255;
                        if(this.i12 != 0)
                        {
                           this.i9 = li8(this.i5);
                           this.i4 &= -8;
                           this.i9 &= 3;
                           this.i4 = this.i9 | this.i4;
                           si8(this.i4,this.i11);
                        }
                        else
                        {
                           this.i4 = li32(this.i2);
                           si32(this.i4,this.i9);
                           this.i4 = li32(this.i1);
                           this.i11 = this.i2;
                           if(this.i4 == this.i2)
                           {
                              this.i4 = li32(this.i11);
                              si32(this.i4,this.i1);
                           }
                           this.i4 = li8(this.i10);
                           if(this.i4 <= 6)
                           {
                              if(this.i4 == 4)
                              {
                                 this.i4 = 0;
                                 this.i10 = li32(this.i6);
                                 this.i11 = li32(this.i10 + 4);
                                 this.i11 += -1;
                                 si32(this.i11,this.i10 + 4);
                                 this.i10 = li32(this.i6);
                                 this.i11 = li32(this.i2 + 12);
                                 this.i12 = li32(this.i10 + 12);
                                 this.i13 = li32(this.i10 + 16);
                                 mstate.esp -= 16;
                                 this.i11 += 17;
                                 si32(this.i13,mstate.esp);
                                 si32(this.i2,mstate.esp + 4);
                                 si32(this.i11,mstate.esp + 8);
                                 si32(this.i4,mstate.esp + 12);
                                 state = 19;
                                 mstate.esp -= 4;
                                 mstate.funcs[this.i12]();
                                 return;
                              }
                              if(this.i4 == 5)
                              {
                                 this.i4 = _dummynode_;
                                 this.i10 = li32(this.i2 + 16);
                                 this.i11 = this.i2;
                                 if(this.i10 != this.i4)
                                 {
                                    this.i4 = 28;
                                    this.i12 = li8(this.i11 + 7);
                                    mstate.esp -= 16;
                                    this.i13 = 0;
                                    this.i4 <<= this.i12;
                                    si32(this.i0,mstate.esp);
                                    si32(this.i10,mstate.esp + 4);
                                    si32(this.i4,mstate.esp + 8);
                                    si32(this.i13,mstate.esp + 12);
                                    state = 16;
                                    mstate.esp -= 4;
                                    FSM_luaM_realloc_.start();
                                    return;
                                 }
                                 break loop3;
                              }
                              if(this.i4 == 6)
                              {
                                 this.i4 = li8(this.i2 + 6);
                                 this.i10 = this.i2;
                                 this.i11 = this.i2;
                                 if(this.i4 != 0)
                                 {
                                    this.i2 = 0;
                                    this.i4 = li8(this.i11 + 7);
                                    this.i4 *= 12;
                                    mstate.esp -= 16;
                                    this.i4 += 20;
                                    si32(this.i0,mstate.esp);
                                    si32(this.i10,mstate.esp + 4);
                                    si32(this.i4,mstate.esp + 8);
                                    si32(this.i2,mstate.esp + 12);
                                    state = 2;
                                    mstate.esp -= 4;
                                    FSM_luaM_realloc_.start();
                                    return;
                                 }
                                 this.i4 = 0;
                                 this.i2 = li8(this.i2 + 7);
                                 this.i2 <<= 2;
                                 mstate.esp -= 16;
                                 this.i2 += 20;
                                 si32(this.i0,mstate.esp);
                                 si32(this.i10,mstate.esp + 4);
                                 si32(this.i2,mstate.esp + 8);
                                 si32(this.i4,mstate.esp + 12);
                                 state = 13;
                                 mstate.esp -= 4;
                                 FSM_luaM_realloc_.start();
                                 return;
                              }
                           }
                           else if(this.i4 <= 8)
                           {
                              if(this.i4 == 7)
                              {
                                 this.i4 = 0;
                                 this.i10 = li32(this.i6);
                                 this.i11 = li32(this.i2 + 16);
                                 this.i12 = li32(this.i10 + 12);
                                 this.i13 = li32(this.i10 + 16);
                                 mstate.esp -= 16;
                                 this.i11 += 20;
                                 si32(this.i13,mstate.esp);
                                 si32(this.i2,mstate.esp + 4);
                                 si32(this.i11,mstate.esp + 8);
                                 si32(this.i4,mstate.esp + 12);
                                 state = 20;
                                 mstate.esp -= 4;
                                 mstate.funcs[this.i12]();
                                 return;
                              }
                              if(this.i4 == 8)
                              {
                                 this.i4 = 112;
                                 this.i10 = li32(this.i2 + 32);
                                 mstate.esp -= 8;
                                 si32(this.i2,mstate.esp);
                                 si32(this.i10,mstate.esp + 4);
                                 state = 3;
                                 mstate.esp -= 4;
                                 FSM_luaF_close.start();
                                 return;
                              }
                           }
                           else
                           {
                              if(this.i4 == 9)
                              {
                                 this.i4 = 0;
                                 this.i10 = li32(this.i2 + 44);
                                 this.i11 = li32(this.i2 + 12);
                                 mstate.esp -= 16;
                                 this.i10 <<= 2;
                                 si32(this.i0,mstate.esp);
                                 si32(this.i11,mstate.esp + 4);
                                 si32(this.i10,mstate.esp + 8);
                                 si32(this.i4,mstate.esp + 12);
                                 state = 6;
                                 mstate.esp -= 4;
                                 FSM_luaM_realloc_.start();
                                 return;
                              }
                              if(this.i4 == 10)
                              {
                                 this.i4 = li32(this.i2 + 8);
                                 this.i10 = this.i2;
                                 this.i11 = this.i2;
                                 this.i2 += 12;
                                 if(this.i4 != this.i2)
                                 {
                                    this.i2 = 0;
                                    this.i4 = li32(this.i11 + 16);
                                    this.i12 = li32(this.i11 + 12);
                                    si32(this.i12,this.i4 + 12);
                                    this.i4 = li32(this.i11 + 12);
                                    this.i11 = li32(this.i11 + 16);
                                    si32(this.i11,this.i4 + 16);
                                    this.i4 = li32(this.i6);
                                    this.i11 = li32(this.i4 + 12);
                                    this.i12 = li32(this.i4 + 16);
                                    mstate.esp -= 16;
                                    this.i13 = 24;
                                    si32(this.i12,mstate.esp);
                                    si32(this.i10,mstate.esp + 4);
                                    si32(this.i13,mstate.esp + 8);
                                    si32(this.i2,mstate.esp + 12);
                                    state = 14;
                                    mstate.esp -= 4;
                                    mstate.funcs[this.i11]();
                                    return;
                                 }
                                 this.i2 = 0;
                                 this.i4 = li32(this.i6);
                                 this.i11 = li32(this.i4 + 12);
                                 this.i12 = li32(this.i4 + 16);
                                 mstate.esp -= 16;
                                 this.i13 = 24;
                                 si32(this.i12,mstate.esp);
                                 si32(this.i10,mstate.esp + 4);
                                 si32(this.i13,mstate.esp + 8);
                                 si32(this.i2,mstate.esp + 12);
                                 state = 15;
                                 mstate.esp -= 4;
                                 mstate.funcs[this.i11]();
                                 return;
                              }
                           }
                           this.i2 = this.i9;
                        }
                        addr1976:
                        while(true)
                        {
                           this.i4 = li32(this.i2);
                           this.i8 += 1;
                           if(this.i4 == 0)
                           {
                              this.i0 = this.i2;
                           }
                           continue loop0;
                        }
                     }
                  }
               }
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 1:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr176);
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = this.i9;
               §§goto(addr1976);
            case 3:
               mstate.esp += 8;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_freestack.start();
               return;
            case 4:
               mstate.esp += 8;
               mstate.esp -= 16;
               this.i10 = 0;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i10,mstate.esp + 12);
               state = 5;
               mstate.esp -= 4;
               FSM_luaM_realloc_.start();
               return;
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = this.i9;
               §§goto(addr1976);
            case 6:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               this.i10 = li32(this.i2 + 52);
               this.i11 = li32(this.i2 + 16);
               mstate.esp -= 16;
               this.i10 <<= 2;
               si32(this.i0,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaM_realloc_.start();
               return;
            case 7:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               this.i10 = li32(this.i2 + 40);
               this.i11 = li32(this.i2 + 8);
               mstate.esp -= 16;
               this.i10 *= 12;
               si32(this.i0,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 8;
               mstate.esp -= 4;
               FSM_luaM_realloc_.start();
               return;
            case 8:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               this.i10 = li32(this.i2 + 48);
               this.i11 = li32(this.i2 + 20);
               mstate.esp -= 16;
               this.i10 <<= 2;
               si32(this.i0,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 9;
               mstate.esp -= 4;
               FSM_luaM_realloc_.start();
               return;
            case 9:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               this.i10 = li32(this.i2 + 56);
               this.i11 = li32(this.i2 + 24);
               mstate.esp -= 16;
               this.i10 *= 12;
               si32(this.i0,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 10;
               mstate.esp -= 4;
               FSM_luaM_realloc_.start();
               return;
            case 10:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               this.i10 = li32(this.i2 + 36);
               this.i11 = li32(this.i2 + 28);
               mstate.esp -= 16;
               this.i10 <<= 2;
               si32(this.i0,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 11;
               mstate.esp -= 4;
               FSM_luaM_realloc_.start();
               return;
            case 11:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 16;
               this.i10 = 76;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 12;
               mstate.esp -= 4;
               FSM_luaM_realloc_.start();
               return;
            case 12:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = this.i9;
               §§goto(addr1976);
            case 13:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = this.i9;
               §§goto(addr1976);
            case 14:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i4 + 68);
               this.i2 += -24;
               si32(this.i2,this.i4 + 68);
               this.i2 = this.i9;
               §§goto(addr1976);
            case 15:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i4 + 68);
               this.i2 += -24;
               si32(this.i2,this.i4 + 68);
               this.i2 = this.i9;
               §§goto(addr1976);
            case 16:
               this.i4 = mstate.eax;
               mstate.esp += 16;
               break;
            case 17:
               this.i10 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 16;
               this.i10 = 32;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 18;
               mstate.esp -= 4;
               FSM_luaM_realloc_.start();
               return;
            case 18:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = this.i9;
               §§goto(addr1976);
            case 19:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i10 + 68);
               this.i2 -= this.i11;
               si32(this.i2,this.i10 + 68);
               this.i2 = this.i9;
               §§goto(addr1976);
            case 20:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i10 + 68);
               this.i2 -= this.i11;
               si32(this.i2,this.i10 + 68);
               this.i2 = this.i9;
               §§goto(addr1976);
            default:
               throw "Invalid state in _sweeplist";
         }
         this.i4 = 0;
         this.i10 = li32(this.i11 + 28);
         this.i11 = li32(this.i11 + 12);
         mstate.esp -= 16;
         this.i10 *= 12;
         si32(this.i0,mstate.esp);
         si32(this.i11,mstate.esp + 4);
         si32(this.i10,mstate.esp + 8);
         si32(this.i4,mstate.esp + 12);
         state = 17;
         mstate.esp -= 4;
         FSM_luaM_realloc_.start();
      }
   }
}
