package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM___part_load_locale extends Machine
   {
      
      public static const intRegCount:int = 18;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i17:int;
      
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
      
      public function FSM___part_load_locale()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___part_load_locale = null;
         _loc1_ = new FSM___part_load_locale();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop16:
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
               this.i3 = li32(mstate.ebp + 20);
               this.i4 = li32(mstate.ebp + 32);
               this.i5 = li32(mstate.ebp + 12);
               this.i6 = li32(mstate.ebp + 16);
               this.i7 = li32(mstate.ebp + 24);
               this.i8 = li32(mstate.ebp + 28);
               this.i9 = this.i2;
               if(this.i1 != 67)
               {
                  this.i10 = __2E_str3149;
                  this.i11 = this.i1;
               }
               else
               {
                  this.i10 = __2E_str3149;
                  this.i11 = 0;
                  this.i12 = this.i1;
                  loop0:
                  while(true)
                  {
                     this.i13 = this.i10 + this.i11;
                     this.i13 += 1;
                     this.i12 &= 255;
                     if(this.i12 != 0)
                     {
                        this.i12 = this.i9 + this.i11;
                        this.i12 = li8(this.i12 + 1);
                        this.i13 = li8(this.i13);
                        this.i11 += 1;
                        if(this.i12 != this.i13)
                        {
                           this.i10 = __2E_str3149;
                           this.i10 += this.i11;
                           this.i11 = this.i12;
                           this.i10 = li8(this.i10);
                        }
                        else
                        {
                           addr189:
                        }
                        continue;
                        this.i11 &= 255;
                        if(this.i11 != this.i10)
                        {
                           this.i10 = this.i1 & 255;
                           if(this.i10 != 80)
                           {
                              this.i10 = __2E_str4150;
                              this.i11 = this.i1;
                           }
                           else
                           {
                              this.i10 = __2E_str4150;
                              this.i11 = 0;
                              this.i12 = this.i1;
                              while(true)
                              {
                                 this.i13 = this.i10 + this.i11;
                                 this.i13 += 1;
                                 this.i12 &= 255;
                                 if(this.i12 != 0)
                                 {
                                    this.i12 = this.i9 + this.i11;
                                    this.i12 = li8(this.i12 + 1);
                                    this.i13 = li8(this.i13);
                                    this.i11 += 1;
                                    if(this.i12 == this.i13)
                                    {
                                       continue;
                                    }
                                    this.i10 = __2E_str4150;
                                    this.i10 += this.i11;
                                    this.i11 = this.i12;
                                 }
                                 break loop0;
                              }
                           }
                           this.i10 = li8(this.i10);
                           this.i11 &= 255;
                           if(this.i11 == this.i10)
                           {
                              break;
                           }
                           this.i10 = li32(this.i6);
                           this.i11 = this.i10;
                           if(this.i10 != 0)
                           {
                              this.i12 = li8(this.i11);
                              this.i13 = this.i1 & 255;
                              if(this.i13 == this.i12)
                              {
                                 this.i11 = 0;
                                 this.i12 = this.i1;
                                 while(true)
                                 {
                                    this.i13 = this.i10 + this.i11;
                                    this.i13 += 1;
                                    this.i12 &= 255;
                                    if(this.i12 != 0)
                                    {
                                       this.i12 = this.i9 + this.i11;
                                       this.i12 = li8(this.i12 + 1);
                                       this.i13 = li8(this.i13);
                                       this.i11 += 1;
                                       if(this.i12 != this.i13)
                                       {
                                          this.i10 += this.i11;
                                          this.i11 = this.i12;
                                          this.i10 = li8(this.i10);
                                          this.i11 &= 255;
                                          if(this.i11 == this.i10)
                                          {
                                             break;
                                          }
                                          addr485:
                                          this.i1 &= 255;
                                          if(this.i1 != 0)
                                          {
                                             this.i1 = this.i9;
                                             while(true)
                                             {
                                                this.i10 = li8(this.i1 + 1);
                                                this.i1 += 1;
                                                this.i11 = this.i1;
                                                if(this.i10 == 0)
                                                {
                                                   break;
                                                }
                                                this.i1 = this.i11;
                                             }
                                          }
                                          else
                                          {
                                             this.i1 = this.i2;
                                          }
                                          this.i10 = mstate.ebp + -5120;
                                          this.i11 = li32(__PathLocale);
                                          this.i12 = li8(this.i11);
                                          this.i13 = this.i1 - this.i9;
                                          si8(this.i12,mstate.ebp + -5120);
                                          this.i13 += 1;
                                          this.i14 = this.i1;
                                          if(this.i12 != 0)
                                          {
                                             this.i1 = 1;
                                             do
                                             {
                                                this.i12 = this.i11 + this.i1;
                                                this.i12 = li8(this.i12);
                                                this.i15 = this.i0 + this.i1;
                                                si8(this.i12,this.i15);
                                                this.i1 += 1;
                                             }
                                             while(this.i12 != 0);
                                             
                                          }
                                          this.i1 = li8(this.i10);
                                          if(this.i1 != 0)
                                          {
                                             this.i1 = this.i0;
                                             while(true)
                                             {
                                                this.i11 = li8(this.i1 + 1);
                                                this.i1 += 1;
                                                this.i12 = this.i1;
                                                if(this.i11 == 0)
                                                {
                                                   break;
                                                }
                                                this.i1 = this.i12;
                                             }
                                          }
                                          else
                                          {
                                             this.i1 = this.i10;
                                          }
                                          this.i11 = mstate.ebp + -5120;
                                          this.i1 -= this.i0;
                                          this.i12 = 47;
                                          this.i15 = 0;
                                          this.i1 = this.i11 + this.i1;
                                          si8(this.i12,this.i1);
                                          si8(this.i15,this.i1 + 1);
                                          this.i1 = li8(this.i10);
                                       }
                                       else
                                       {
                                          addr458:
                                       }
                                       continue;
                                       if(this.i1 != 0)
                                       {
                                          this.i1 = this.i0;
                                          while(true)
                                          {
                                             this.i11 = li8(this.i1 + 1);
                                             this.i1 += 1;
                                             this.i12 = this.i1;
                                             if(this.i11 == 0)
                                             {
                                                break;
                                             }
                                             this.i1 = this.i12;
                                          }
                                       }
                                       else
                                       {
                                          this.i1 = this.i10;
                                       }
                                       this.i11 = 0;
                                       do
                                       {
                                          this.i12 = this.i9 + this.i11;
                                          this.i12 = li8(this.i12);
                                          this.i15 = this.i1 + this.i11;
                                          si8(this.i12,this.i15);
                                          this.i11 += 1;
                                       }
                                       while(this.i12 != 0);
                                       
                                       this.i1 = li8(this.i10);
                                       if(this.i1 != 0)
                                       {
                                          this.i1 = this.i0;
                                          while(true)
                                          {
                                             this.i11 = li8(this.i1 + 1);
                                             this.i1 += 1;
                                             this.i12 = this.i1;
                                             if(this.i11 == 0)
                                             {
                                                break;
                                             }
                                             this.i1 = this.i12;
                                          }
                                       }
                                       else
                                       {
                                          this.i1 = this.i10;
                                       }
                                       this.i11 = mstate.ebp + -5120;
                                       this.i1 -= this.i0;
                                       this.i12 = 47;
                                       this.i15 = 0;
                                       this.i1 = this.i11 + this.i1;
                                       si8(this.i12,this.i1);
                                       si8(this.i15,this.i1 + 1);
                                       this.i1 = li8(this.i10);
                                       if(this.i1 != 0)
                                       {
                                          while(true)
                                          {
                                             this.i1 = li8(this.i0 + 1);
                                             this.i0 += 1;
                                             this.i11 = this.i0;
                                             if(this.i1 == 0)
                                             {
                                                break;
                                             }
                                             this.i0 = this.i11;
                                          }
                                       }
                                       else
                                       {
                                          this.i0 = this.i10;
                                       }
                                       this.i1 = 0;
                                       do
                                       {
                                          this.i11 = this.i3 + this.i1;
                                          this.i11 = li8(this.i11);
                                          this.i12 = this.i0 + this.i1;
                                          si8(this.i11,this.i12);
                                          this.i1 += 1;
                                       }
                                       while(this.i11 != 0);
                                       
                                       this.i0 = 0;
                                       mstate.esp -= 8;
                                       si32(this.i10,mstate.esp);
                                       si32(this.i0,mstate.esp + 4);
                                       state = 1;
                                       mstate.esp -= 4;
                                       FSM_open.start();
                                       return;
                                    }
                                    break;
                                 }
                                 this.i0 = 1;
                                 si32(this.i0,this.i5);
                                 addr1930:
                                 mstate.eax = this.i0;
                                 break loop16;
                              }
                              this.i10 = this.i11;
                              this.i11 = this.i1;
                              §§goto(addr458);
                           }
                           §§goto(addr485);
                        }
                        break;
                     }
                     break;
                  }
                  this.i0 = 0;
                  si32(this.i0,this.i5);
                  this.i0 = 1;
                  §§goto(addr1930);
               }
               §§goto(addr189);
            case 1:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               if(this.i3 >= 0)
               {
                  if(this.i3 <= 1)
                  {
                     this.i1 = 1;
                     this.i10 = this.i0;
                  }
                  else
                  {
                     this.i0 = this.i3;
                     state = 2;
                     addr786:
                     this.i0 = mstate.system.fsize(this.i0);
                     if(this.i0 <= -1)
                     {
                        this.i0 = __2E_str96;
                        mstate.esp -= 20;
                        this.i1 = __2E_str251;
                        this.i10 = 59;
                        this.i11 = 2;
                        this.i12 = mstate.ebp + -4096;
                        si32(this.i12,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i11,mstate.esp + 8);
                        si32(this.i1,mstate.esp + 12);
                        si32(this.i10,mstate.esp + 16);
                        state = 3;
                        mstate.esp -= 4;
                        FSM_sprintf.start();
                        return;
                     }
                     this.i1 = 1;
                     this.i11 = this.i0 >> 31;
                     this.i10 = this.i0;
                     this.i0 = this.i11;
                  }
                  addr922:
                  this.i11 = this.i0;
                  this.i0 = this.i1;
                  this.i0 ^= 1;
                  this.i0 &= 1;
                  if(this.i0 == 0)
                  {
                     this.i0 = this.i11 > 0 ? 1 : 0;
                     this.i1 = this.i10 != 0 ? 1 : 0;
                     this.i12 = this.i11 == 0 ? 1 : 0;
                     this.i0 = this.i12 != 0 ? int(this.i1) : int(this.i0);
                     if(this.i0 != 0)
                     {
                        this.i0 = 0;
                        mstate.esp -= 8;
                        this.i12 = this.i10 + this.i13;
                        si32(this.i0,mstate.esp);
                        si32(this.i12,mstate.esp + 4);
                        state = 5;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     this.i2 = 79;
                     addr999:
                     si32(this.i2,_val_2E_1440);
                     this.i0 = this.i3;
                     state = 4;
                  }
                  else
                  {
                     this.i1 = -1;
                     this.i2 = li32(_val_2E_1440);
                     this.i0 = this.i3;
                     state = 13;
                  }
               }
               else
               {
                  addr1927:
                  this.i0 = -1;
                  §§goto(addr1930);
               }
            case 2:
               §§goto(addr786);
            case 3:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i12;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i11,_val_2E_1440);
               this.i1 = 0;
               this.i10 = this.i0;
               §§goto(addr922);
            case 5:
               this.i15 = mstate.eax;
               mstate.esp += 8;
               this.i16 = this.i15;
               this.i17 = this.i10;
               if(this.i15 == 0)
               {
                  this.i2 = 12;
                  §§goto(addr999);
               }
               else
               {
                  this.i0 = li8(this.i2);
                  si8(this.i0,this.i15);
                  if(this.i0 != 0)
                  {
                     this.i0 = 1;
                     do
                     {
                        this.i1 = this.i9 + this.i0;
                        this.i1 = li8(this.i1);
                        this.i2 = this.i16 + this.i0;
                        si8(this.i1,this.i2);
                        this.i0 += 1;
                     }
                     while(this.i1 != 0);
                     
                  }
                  this.i1 = this.i15 + this.i13;
                  this.i0 = this.i3;
                  this.i2 = this.i17;
                  state = 6;
               }
            case 6:
               this.i0 = mstate.system.read(this.i0,this.i1,this.i2);
               this.i1 = this.i0 >> 31;
               this.i1 ^= this.i11;
               this.i0 ^= this.i10;
               this.i0 |= this.i1;
               if(this.i0 != 0)
               {
                  this.i0 = 0;
                  this.i1 = li32(_val_2E_1440);
                  mstate.esp -= 8;
                  si32(this.i15,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               this.i0 = this.i12 + this.i15;
               this.i0 = li8(this.i0 + -1);
               if(this.i0 != 10)
               {
                  this.i9 = 79;
                  si32(this.i9,_val_2E_1440);
                  mstate.esp -= 8;
                  this.i0 = 0;
                  si32(this.i15,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               if(this.i13 >= this.i12)
               {
                  this.i9 = 0;
               }
               else
               {
                  this.i0 = 0;
                  this.i9 = this.i14 - this.i9;
                  this.i9 += 1;
                  do
                  {
                     this.i1 = this.i16 + this.i9;
                     this.i2 = li8(this.i1);
                     if(this.i2 == 10)
                     {
                        this.i2 = 0;
                        si8(this.i2,this.i1);
                        this.i0 += 1;
                     }
                     this.i9 += 1;
                  }
                  while(this.i9 < this.i12);
                  
                  this.i9 = this.i0;
               }
               this.i0 = this.i9;
               if(this.i0 >= this.i7)
               {
                  this.i0 = this.i7;
               }
               else
               {
                  if(this.i0 < this.i8)
                  {
                     this.i4 = 79;
                     si32(this.i4,_val_2E_1440);
                     mstate.esp -= 8;
                     this.i0 = 0;
                     si32(this.i15,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 14;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
                  this.i0 = this.i8;
               }
               this.i1 = this.i0;
               this.i0 = this.i3;
               state = 9;
            case 9:
               this.i0 = mstate.system.close(this.i0);
               this.i3 = this.i0;
               this.i3 = li32(this.i6);
               if(this.i3 != 0)
               {
                  this.i0 = 0;
                  mstate.esp -= 8;
                  si32(this.i3,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 10;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               si32(this.i15,this.i6);
               if(this.i1 > 0)
               {
                  addr1518:
                  this.i3 = 0;
                  this.i6 = this.i4;
                  this.i0 = this.i3;
                  do
                  {
                     this.i2 = this.i15 + this.i3;
                     this.i8 = li8(this.i2);
                     this.i9 = this.i6;
                     if(this.i8 == 0)
                     {
                        this.i8 = this.i2;
                     }
                     else
                     {
                        this.i8 = this.i3 + this.i16;
                        while(true)
                        {
                           this.i10 = li8(this.i8 + 1);
                           this.i8 += 1;
                           this.i11 = this.i8;
                           if(this.i10 == 0)
                           {
                              break;
                           }
                           this.i8 = this.i11;
                        }
                     }
                     this.i2 = this.i8 - this.i2;
                     this.i3 = this.i2 + this.i3;
                     this.i3 += 1;
                     this.i2 = this.i15 + this.i3;
                     si32(this.i2,this.i9);
                     this.i6 += 4;
                     this.i0 += 1;
                  }
                  while(this.i0 < this.i1);
                  
               }
               addr1713:
               if(this.i1 < this.i7)
               {
                  this.i3 = 0;
                  this.i15 = this.i1 << 2;
                  this.i4 += this.i15;
                  this.i1 = this.i7 - this.i1;
                  do
                  {
                     this.i7 = 0;
                     si32(this.i7,this.i4);
                     this.i4 += 4;
                     this.i3 += 1;
                  }
                  while(this.i3 != this.i1);
                  
               }
               this.i3 = 1;
               si32(this.i3,this.i5);
               this.i3 = 0;
               mstate.eax = this.i3;
               break;
            case 4:
               this.i0 = mstate.system.close(this.i0);
               this.i3 = this.i0;
               si32(this.i2,_val_2E_1440);
               this.i2 = -1;
               mstate.eax = this.i2;
               break;
            case 13:
               this.i0 = mstate.system.close(this.i0);
               si32(this.i2,_val_2E_1440);
               mstate.eax = this.i1;
               break;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i9,_val_2E_1440);
               this.i0 = this.i3;
               state = 8;
            case 8:
               this.i0 = mstate.system.close(this.i0);
               si32(this.i9,_val_2E_1440);
               this.i9 = -1;
               mstate.eax = this.i9;
               break;
            case 10:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               si32(this.i15,this.i6);
               if(this.i1 >= 1)
               {
                  §§goto(addr1518);
               }
               §§goto(addr1713);
            case 11:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i1,_val_2E_1440);
               this.i0 = this.i3;
               state = 12;
            case 12:
               this.i0 = mstate.system.close(this.i0);
               this.i3 = this.i0;
               si32(this.i1,_val_2E_1440);
               this.i3 = -1;
               §§goto(addr1713);
            case 14:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i4,_val_2E_1440);
               this.i0 = this.i3;
               state = 15;
            case 15:
               this.i0 = mstate.system.close(this.i0);
               si32(this.i4,_val_2E_1440);
               §§goto(addr1927);
            default:
               throw "Invalid state in ___part_load_locale";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
