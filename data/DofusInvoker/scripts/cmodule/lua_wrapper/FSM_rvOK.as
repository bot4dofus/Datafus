package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_rvOK extends Machine
   {
      
      public static const intRegCount:int = 13;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var f0:Number;
      
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
      
      public function FSM_rvOK()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_rvOK = null;
         _loc1_ = new FSM_rvOK();
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
               mstate.esp -= 8;
               this.i0 = mstate.ebp + -8;
               mstate.esp -= 16;
               this.f0 = lf64(mstate.ebp + 8);
               this.i1 = mstate.ebp + -4;
               sf64(this.f0,mstate.esp);
               si32(this.i1,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               FSM___d2b_D2A.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(mstate.ebp + -8);
               this.i2 = li32(_fpi_2E_3615);
               this.i1 -= this.i2;
               si32(this.i1,mstate.ebp + -8);
               this.i3 = li32(mstate.ebp + -4);
               this.i3 = this.i1 + this.i3;
               si32(this.i3,mstate.ebp + -4);
               this.i3 = li32(mstate.ebp + 20);
               this.i4 = li32(mstate.ebp + 16);
               this.i5 = li32(mstate.ebp + 24);
               this.i6 = li32(mstate.ebp + 28);
               this.i7 = li32(mstate.ebp + 32);
               this.i8 = this.i3;
               if(this.i1 <= 0)
               {
                  if(this.i5 != 0)
                  {
                     addr191:
                     this.i6 = 0;
                     addr394:
                     if(this.i1 >= 1)
                     {
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM___any_on_D2A.start();
                        addr426:
                        this.i9 = mstate.eax;
                        mstate.esp += 8;
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM___rshift_D2A.start();
                        mstate.esp += 8;
                        this.i1 = this.i9 == 0 ? 0 : 16;
                        this.i6 &= 1;
                        if(this.i6 != 0)
                        {
                           mstate.esp -= 4;
                           si32(this.i0,mstate.esp);
                           state = 4;
                           mstate.esp -= 4;
                           FSM___increment_D2A.start();
                           return;
                        }
                        this.i6 = this.i9;
                     }
                     else
                     {
                        if(this.i1 < 0)
                        {
                           this.i9 = 0;
                           mstate.esp -= 8;
                           this.i6 = 0 - this.i1;
                           si32(this.i0,mstate.esp);
                           si32(this.i6,mstate.esp + 4);
                           state = 7;
                           mstate.esp -= 4;
                           FSM___lshift_D2A.start();
                           return;
                        }
                        this.i1 = 0;
                        this.i6 = this.i1;
                     }
                     this.i10 = this.i1;
                     this.i1 = li32(_fpi_2E_3615 + 4);
                     this.i11 = li32(mstate.ebp + -4);
                     if(this.i1 <= this.i11)
                     {
                        this.i1 = this.i11;
                        this.i6 = this.i10;
                        addr824:
                        this.i5 = li32(_fpi_2E_3615 + 8);
                        if(this.i5 >= this.i1)
                        {
                           break;
                        }
                        this.i6 = 163;
                        this.i1 = this.i5 + 1;
                        si32(this.i1,mstate.ebp + -4);
                        si32(this.i6,this.i7);
                        this.i6 = 34;
                        si32(this.i6,_val_2E_1440);
                        this.i6 = 0;
                        si32(this.i6,this.i0 + 16);
                        break;
                     }
                     this.i9 = this.i1;
                     this.i1 = this.i11;
                     addr1019:
                     si32(this.i9,mstate.ebp + -4);
                     this.i1 = this.i9 - this.i1;
                     if(this.i1 <= this.i2)
                     {
                        this.i9 = li32(_fpi_2E_3615 + 16);
                        if(this.i9 == 0)
                        {
                           this.i9 = this.i1 + -1;
                           if(this.i9 >= 1)
                           {
                              if(this.i6 == 0)
                              {
                                 mstate.esp -= 8;
                                 si32(this.i0,mstate.esp);
                                 si32(this.i9,mstate.esp + 4);
                                 mstate.esp -= 4;
                                 FSM___any_on_D2A.start();
                                 addr1114:
                                 this.i6 = mstate.eax;
                                 mstate.esp += 8;
                              }
                              else
                              {
                                 addr1086:
                              }
                              if(this.i6 == 0)
                              {
                                 if(this.i5 == 0)
                                 {
                                    this.i6 = this.i0;
                                    §§goto(addr228);
                                 }
                              }
                              this.i5 = 1;
                              this.i11 = this.i9 >> 5;
                              this.i11 <<= 2;
                              this.i11 = this.i0 + this.i11;
                              this.i11 = li32(this.i11 + 20);
                              mstate.esp -= 8;
                              si32(this.i0,mstate.esp);
                              si32(this.i1,mstate.esp + 4);
                              mstate.esp -= 4;
                              FSM___rshift_D2A.start();
                              addr1197:
                              this.i1 = this.i9 & 31;
                              this.i1 = this.i5 << this.i1;
                              mstate.esp += 8;
                              this.i5 = 2;
                              si32(this.i5,this.i7);
                              this.i1 = this.i11 & this.i1;
                              if(this.i1 != 0)
                              {
                                 this.i6 = 96;
                                 mstate.esp -= 4;
                                 si32(this.i0,mstate.esp);
                                 state = 10;
                                 mstate.esp -= 4;
                                 FSM___increment_D2A.start();
                                 return;
                              }
                              this.i6 = this.i1 | this.i6;
                              if(this.i6 == 0)
                              {
                                 this.i6 = this.i10;
                                 break;
                              }
                              this.i6 = 80;
                              break;
                           }
                           §§goto(addr1086);
                        }
                     }
                     this.i6 = 0;
                     si32(this.i6,this.i0 + 16);
                     this.i1 = 80;
                     si32(this.i1,this.i7);
                     break;
                  }
                  addr221:
                  this.i6 = this.i0;
                  §§goto(addr228);
               }
               else
               {
                  if(this.i2 == 53)
                  {
                     if(this.i5 != 0)
                     {
                        this.i6 = li32(_fpi_2E_3615 + 12);
                        if(this.i6 != 1)
                        {
                           §§goto(addr221);
                        }
                        else
                        {
                           addr190:
                           §§goto(addr191);
                        }
                     }
                     §§goto(addr221);
                  }
                  else if(this.i6 != 1)
                  {
                     if(this.i6 != 2)
                     {
                        this.i6 = this.i1 + -1;
                        if(this.i6 >= 0)
                        {
                           if(this.i1 == 1)
                           {
                              if(this.i5 != 0)
                              {
                                 this.i6 = li32(this.i0 + 20);
                                 this.i6 &= 2;
                                 if(this.i6 != 0)
                                 {
                                    addr391:
                                    this.i6 = 1;
                                 }
                                 else
                                 {
                                    §§goto(addr190);
                                 }
                                 §§goto(addr394);
                              }
                              else
                              {
                                 §§goto(addr221);
                              }
                           }
                           else
                           {
                              this.i9 = 1;
                              this.i10 = this.i6 >> 5;
                              this.i10 <<= 2;
                              this.i6 &= 31;
                              this.i10 = this.i0 + this.i10;
                              this.i10 = li32(this.i10 + 20);
                              this.i6 = this.i9 << this.i6;
                              this.i6 = this.i10 & this.i6;
                              if(this.i6 != 0)
                              {
                                 §§goto(addr391);
                              }
                              else
                              {
                                 §§goto(addr190);
                              }
                           }
                        }
                        §§goto(addr190);
                     }
                     §§goto(addr391);
                  }
                  §§goto(addr190);
               }
            case 2:
               §§goto(addr426);
            case 3:
               §§goto(addr426);
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i1 = li32(this.i0 + 16);
               this.i1 <<= 2;
               this.i1 += this.i0;
               this.i1 = li32(this.i1 + 16);
               this.i6 = uint(this.i1) < uint(65536) ? 16 : 0;
               this.i1 <<= this.i6;
               this.i10 = uint(this.i1) < uint(16777216) ? 8 : 0;
               this.i1 <<= this.i10;
               this.i11 = uint(this.i1) < uint(268435456) ? 4 : 0;
               this.i6 = this.i10 | this.i6;
               this.i1 <<= this.i11;
               this.i10 = this.i2 & 31;
               this.i12 = uint(this.i1) < uint(1073741824) ? 2 : 0;
               this.i6 |= this.i11;
               this.i11 = 32 - this.i10;
               this.i10 = this.i10 == 0 ? int(this.i10) : int(this.i11);
               this.i6 |= this.i12;
               this.i1 <<= this.i12;
               if(this.i1 <= -1)
               {
                  this.i1 = this.i6;
               }
               else
               {
                  this.i1 &= 1073741824;
                  this.i6 += 1;
                  this.i1 = this.i1 == 0 ? 32 : int(this.i6);
               }
               if(this.i1 == this.i10)
               {
                  this.i1 = 32;
                  this.i6 = this.i9;
               }
               else
               {
                  if(this.i9 == 0)
                  {
                     this.i1 = 1;
                     this.i6 = li32(this.i0 + 20);
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM___rshift_D2A.start();
                     addr773:
                     mstate.esp += 8;
                     this.i1 = li32(mstate.ebp + -4);
                     this.i1 += 1;
                     si32(this.i1,mstate.ebp + -4);
                     this.i9 = li32(_fpi_2E_3615 + 4);
                     this.i6 &= 1;
                     if(this.i9 <= this.i1)
                     {
                        this.i6 = 32;
                        §§goto(addr824);
                     }
                     else
                     {
                        this.i10 = 32;
                     }
                  }
                  else
                  {
                     this.i1 = 1;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM___rshift_D2A.start();
                     addr873:
                     mstate.esp += 8;
                     this.i1 = li32(mstate.ebp + -4);
                     this.i1 += 1;
                     si32(this.i1,mstate.ebp + -4);
                     this.i1 = 32;
                     this.i6 = this.i9;
                     §§goto(addr191);
                  }
                  §§goto(addr1019);
               }
               §§goto(addr191);
            case 5:
               §§goto(addr773);
            case 6:
               §§goto(addr873);
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i6 = this.i9;
               this.i1 = this.i9;
               §§goto(addr191);
            case 8:
               §§goto(addr1114);
            case 9:
               §§goto(addr1197);
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               break;
            default:
               throw "Invalid state in _rvOK";
         }
         this.i1 = this.i2 + -1;
         this.i1 >>= 5;
         this.i2 = li32(mstate.ebp + -4);
         this.i1 <<= 2;
         this.i1 += this.i3;
         si32(this.i2,this.i4);
         this.i2 = li32(this.i0 + 16);
         this.i1 += 4;
         this.i4 = this.i0;
         if(this.i2 <= 0)
         {
            this.i2 = this.i3;
         }
         else
         {
            this.i5 = 0;
            this.i9 = this.i5;
            do
            {
               this.i10 = this.i4 + this.i9;
               this.i10 = li32(this.i10 + 20);
               this.i11 = this.i8 + this.i9;
               si32(this.i10,this.i11);
               this.i9 += 4;
               this.i5 += 1;
            }
            while(this.i5 < this.i2);
            
            this.i2 = this.i5 << 2;
            this.i2 = this.i3 + this.i2;
         }
         this.i3 = this.i2;
         if(uint(this.i2) < uint(this.i1))
         {
            this.i2 = this.i3;
            do
            {
               this.i3 = 0;
               si32(this.i3,this.i2);
               this.i2 += 4;
            }
            while(uint(this.i2) < uint(this.i1));
            
         }
         this.i1 = li32(this.i7);
         this.i6 = this.i1 | this.i6;
         si32(this.i6,this.i7);
         if(this.i0 != 0)
         {
            this.i6 = _freelist;
            this.i1 = li32(this.i0 + 4);
            this.i1 <<= 2;
            this.i6 += this.i1;
            this.i1 = li32(this.i6);
            si32(this.i1,this.i0);
            si32(this.i0,this.i6);
         }
         this.i6 = 1;
         mstate.eax = this.i6;
         addr228:
         this.i0 = this.i6;
         if(this.i0 != 0)
         {
            this.i1 = _freelist;
            this.i2 = li32(this.i0 + 4);
            this.i2 <<= 2;
            this.i1 += this.i2;
            this.i2 = li32(this.i1);
            si32(this.i2,this.i0);
            si32(this.i0,this.i1);
         }
         this.i0 = 0;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
