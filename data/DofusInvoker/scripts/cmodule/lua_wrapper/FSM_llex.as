package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_llex extends Machine
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
      
      public function FSM_llex()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_llex = null;
         _loc1_ = new FSM_llex();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop14:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 436;
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 48);
               si32(this.i0,this.i2 + 4);
               this.i0 = this.i1 + 44;
               this.i2 = this.i1 + 48;
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = this.i1;
               loop0:
               while(true)
               {
                  this.i5 = li32(this.i4);
                  if(this.i5 <= 45)
                  {
                     if(this.i5 <= 33)
                     {
                        if(this.i5 != -1)
                        {
                           if(this.i5 != 10)
                           {
                              if(this.i5 != 13)
                              {
                                 addr302:
                                 this.i6 = this.i5;
                                 loop1:
                                 while(true)
                                 {
                                    if(uint(this.i5) >= uint(256))
                                    {
                                       mstate.esp -= 4;
                                       si32(this.i5,mstate.esp);
                                       mstate.esp -= 4;
                                       FSM____runetype.start();
                                       do
                                       {
                                          this.i5 = mstate.eax;
                                          mstate.esp += 4;
                                          this.i5 &= 16384;
                                       }
                                       while(this.i5 != 0);
                                       
                                       addr363:
                                       if(uint(this.i6) <= uint(255))
                                       {
                                          this.i5 = __DefaultRuneLocale;
                                          this.i7 = this.i6 << 2;
                                          this.i5 += this.i7;
                                          this.i5 = li32(this.i5 + 52);
                                          this.i5 &= 1024;
                                          if(this.i5 == 0)
                                          {
                                             if(uint(this.i6) <= uint(255))
                                             {
                                                this.i5 = li32(__CurrentRuneLocale);
                                                this.i7 = this.i6 << 2;
                                                this.i5 += this.i7;
                                                this.i5 = li32(this.i5 + 52);
                                                this.i5 &= 256;
                                                if(this.i6 != 95)
                                                {
                                                   if(this.i5 == 0)
                                                   {
                                                      §§goto(addr7927);
                                                   }
                                                }
                                             }
                                             else
                                             {
                                                addr420:
                                                mstate.esp -= 4;
                                                si32(this.i6,mstate.esp);
                                                mstate.esp -= 4;
                                                FSM____runetype.start();
                                                this.i5 = mstate.eax;
                                                mstate.esp += 4;
                                                this.i5 &= 256;
                                                if(this.i6 != 95)
                                                {
                                                   if(this.i5 == 0)
                                                   {
                                                      addr7927:
                                                      this.i2 = li32(this.i0);
                                                      this.i1 = li32(this.i2);
                                                      this.i3 = this.i1 + -1;
                                                      si32(this.i3,this.i2);
                                                      this.i2 = li32(this.i0);
                                                      if(this.i1 != 0)
                                                      {
                                                         this.i0 = li32(this.i2 + 4);
                                                         this.i1 = li8(this.i0);
                                                         this.i0 += 1;
                                                         si32(this.i0,this.i2 + 4);
                                                         si32(this.i1,this.i4);
                                                         addr8568:
                                                         mstate.eax = this.i6;
                                                         break loop14;
                                                      }
                                                      this.i0 = mstate.ebp + -432;
                                                      this.i1 = li32(this.i2 + 16);
                                                      this.i3 = li32(this.i2 + 8);
                                                      this.i5 = li32(this.i2 + 12);
                                                      mstate.esp -= 12;
                                                      si32(this.i1,mstate.esp);
                                                      si32(this.i5,mstate.esp + 4);
                                                      si32(this.i0,mstate.esp + 8);
                                                      state = 69;
                                                      mstate.esp -= 4;
                                                      mstate.funcs[this.i3]();
                                                      return;
                                                   }
                                                }
                                             }
                                             §§goto(addr473);
                                          }
                                          else
                                          {
                                             addr7408:
                                          }
                                          this.i2 = 284;
                                          mstate.esp -= 8;
                                          si32(this.i1,mstate.esp);
                                          si32(this.i3,mstate.esp + 4);
                                          state = 63;
                                          mstate.esp -= 4;
                                          FSM_read_numeral.start();
                                          return;
                                       }
                                       §§goto(addr420);
                                       addr339:
                                    }
                                    else
                                    {
                                       this.i7 = li32(__CurrentRuneLocale);
                                       this.i5 <<= 2;
                                       this.i5 = this.i7 + this.i5;
                                       this.i5 = li32(this.i5 + 52);
                                       this.i5 &= 16384;
                                       if(this.i5 == 0)
                                       {
                                          §§goto(addr363);
                                       }
                                    }
                                    while(true)
                                    {
                                       this.i5 = li32(this.i0);
                                       this.i6 = li32(this.i5);
                                       this.i7 = this.i6 + -1;
                                       si32(this.i7,this.i5);
                                       this.i5 = li32(this.i0);
                                       if(this.i6 == 0)
                                       {
                                          this.i6 = mstate.ebp + -324;
                                          this.i7 = li32(this.i5 + 16);
                                          this.i8 = li32(this.i5 + 8);
                                          this.i9 = li32(this.i5 + 12);
                                          mstate.esp -= 12;
                                          si32(this.i7,mstate.esp);
                                          si32(this.i9,mstate.esp + 4);
                                          si32(this.i6,mstate.esp + 8);
                                          state = 64;
                                          mstate.esp -= 4;
                                          mstate.funcs[this.i8]();
                                          return;
                                       }
                                       this.i6 = li32(this.i5 + 4);
                                       this.i7 = li8(this.i6);
                                       this.i6 += 1;
                                       si32(this.i6,this.i5 + 4);
                                       si32(this.i7,this.i4);
                                       if(this.i7 > 45)
                                       {
                                          if(this.i7 <= 61)
                                          {
                                             if(this.i7 == 46)
                                             {
                                                this.i2 = this.i7;
                                                addr6945:
                                                mstate.esp -= 8;
                                                si32(this.i1,mstate.esp);
                                                si32(this.i2,mstate.esp + 4);
                                                state = 58;
                                                mstate.esp -= 4;
                                                FSM_save.start();
                                                return;
                                                addr6944:
                                             }
                                             if(this.i7 != 60)
                                             {
                                                if(this.i7 != 61)
                                                {
                                                   §§goto(addr7625);
                                                }
                                                else
                                                {
                                                   addr1926:
                                                   this.i2 = li32(this.i0);
                                                   this.i5 = li32(this.i2);
                                                   this.i1 = this.i5 + -1;
                                                   si32(this.i1,this.i2);
                                                   this.i2 = li32(this.i0);
                                                   if(this.i5 == 0)
                                                   {
                                                      this.i5 = mstate.ebp + -328;
                                                      this.i1 = li32(this.i2 + 16);
                                                      this.i3 = li32(this.i2 + 8);
                                                      this.i6 = li32(this.i2 + 12);
                                                      mstate.esp -= 12;
                                                      si32(this.i1,mstate.esp);
                                                      si32(this.i6,mstate.esp + 4);
                                                      si32(this.i5,mstate.esp + 8);
                                                      state = 17;
                                                      mstate.esp -= 4;
                                                      mstate.funcs[this.i3]();
                                                      return;
                                                   }
                                                   this.i5 = li32(this.i2 + 4);
                                                   this.i1 = li8(this.i5);
                                                   this.i5 += 1;
                                                   si32(this.i5,this.i2 + 4);
                                                   si32(this.i1,this.i4);
                                                   if(this.i1 != 61)
                                                   {
                                                      addr1994:
                                                      this.i2 = 61;
                                                      §§goto(addr8603);
                                                   }
                                                   else
                                                   {
                                                      addr2153:
                                                      this.i2 = li32(this.i0);
                                                      this.i5 = li32(this.i2);
                                                      this.i1 = this.i5 + -1;
                                                      si32(this.i1,this.i2);
                                                      this.i2 = li32(this.i0);
                                                      if(this.i5 == 0)
                                                      {
                                                         this.i5 = mstate.ebp + -320;
                                                         this.i0 = li32(this.i2 + 16);
                                                         this.i1 = li32(this.i2 + 8);
                                                         this.i3 = li32(this.i2 + 12);
                                                         mstate.esp -= 12;
                                                         si32(this.i0,mstate.esp);
                                                         si32(this.i3,mstate.esp + 4);
                                                         si32(this.i5,mstate.esp + 8);
                                                         state = 18;
                                                         mstate.esp -= 4;
                                                         mstate.funcs[this.i1]();
                                                         return;
                                                      }
                                                      this.i5 = 280;
                                                   }
                                                   addr1925:
                                                }
                                             }
                                             else
                                             {
                                                addr2337:
                                                this.i2 = li32(this.i0);
                                                this.i5 = li32(this.i2);
                                                this.i1 = this.i5 + -1;
                                                si32(this.i1,this.i2);
                                                this.i2 = li32(this.i0);
                                                if(this.i5 == 0)
                                                {
                                                   this.i5 = mstate.ebp + -316;
                                                   this.i1 = li32(this.i2 + 16);
                                                   this.i3 = li32(this.i2 + 8);
                                                   this.i6 = li32(this.i2 + 12);
                                                   mstate.esp -= 12;
                                                   si32(this.i1,mstate.esp);
                                                   si32(this.i6,mstate.esp + 4);
                                                   si32(this.i5,mstate.esp + 8);
                                                   state = 19;
                                                   mstate.esp -= 4;
                                                   mstate.funcs[this.i3]();
                                                   return;
                                                }
                                                this.i5 = li32(this.i2 + 4);
                                                this.i1 = li8(this.i5);
                                                this.i5 += 1;
                                                si32(this.i5,this.i2 + 4);
                                                si32(this.i1,this.i4);
                                                if(this.i1 != 61)
                                                {
                                                   addr2405:
                                                   this.i2 = 60;
                                                   §§goto(addr8603);
                                                }
                                                else
                                                {
                                                   addr2564:
                                                   this.i2 = li32(this.i0);
                                                   this.i5 = li32(this.i2);
                                                   this.i1 = this.i5 + -1;
                                                   si32(this.i1,this.i2);
                                                   this.i2 = li32(this.i0);
                                                   if(this.i5 == 0)
                                                   {
                                                      this.i5 = mstate.ebp + -312;
                                                      this.i0 = li32(this.i2 + 16);
                                                      this.i1 = li32(this.i2 + 8);
                                                      this.i3 = li32(this.i2 + 12);
                                                      mstate.esp -= 12;
                                                      si32(this.i0,mstate.esp);
                                                      si32(this.i3,mstate.esp + 4);
                                                      si32(this.i5,mstate.esp + 8);
                                                      state = 20;
                                                      mstate.esp -= 4;
                                                      mstate.funcs[this.i1]();
                                                      return;
                                                   }
                                                   this.i5 = 282;
                                                }
                                                addr2336:
                                             }
                                          }
                                          else
                                          {
                                             if(this.i7 == 62)
                                             {
                                                addr2747:
                                                break loop0;
                                             }
                                             if(this.i7 == 91)
                                             {
                                                addr1518:
                                                mstate.esp -= 4;
                                                si32(this.i1,mstate.esp);
                                                state = 10;
                                                mstate.esp -= 4;
                                                FSM_skip_sep.start();
                                                return;
                                                addr1517:
                                             }
                                             if(this.i7 != 126)
                                             {
                                                §§goto(addr7625);
                                             }
                                             else
                                             {
                                                addr3204:
                                                this.i2 = li32(this.i0);
                                                this.i5 = li32(this.i2);
                                                this.i1 = this.i5 + -1;
                                                si32(this.i1,this.i2);
                                                this.i2 = li32(this.i0);
                                                if(this.i5 == 0)
                                                {
                                                   this.i5 = mstate.ebp + -296;
                                                   this.i1 = li32(this.i2 + 16);
                                                   this.i3 = li32(this.i2 + 8);
                                                   this.i6 = li32(this.i2 + 12);
                                                   mstate.esp -= 12;
                                                   si32(this.i1,mstate.esp);
                                                   si32(this.i6,mstate.esp + 4);
                                                   si32(this.i5,mstate.esp + 8);
                                                   state = 23;
                                                   mstate.esp -= 4;
                                                   mstate.funcs[this.i3]();
                                                   return;
                                                }
                                                this.i5 = li32(this.i2 + 4);
                                                this.i1 = li8(this.i5);
                                                this.i5 += 1;
                                                si32(this.i5,this.i2 + 4);
                                                si32(this.i1,this.i4);
                                                if(this.i1 != 61)
                                                {
                                                   addr3272:
                                                   this.i2 = 126;
                                                   §§goto(addr8603);
                                                }
                                                else
                                                {
                                                   addr3431:
                                                   this.i2 = li32(this.i0);
                                                   this.i5 = li32(this.i2);
                                                   this.i1 = this.i5 + -1;
                                                   si32(this.i1,this.i2);
                                                   this.i2 = li32(this.i0);
                                                   if(this.i5 == 0)
                                                   {
                                                      this.i5 = mstate.ebp + -288;
                                                      this.i0 = li32(this.i2 + 16);
                                                      this.i1 = li32(this.i2 + 8);
                                                      this.i3 = li32(this.i2 + 12);
                                                      mstate.esp -= 12;
                                                      si32(this.i0,mstate.esp);
                                                      si32(this.i3,mstate.esp + 4);
                                                      si32(this.i5,mstate.esp + 8);
                                                      state = 24;
                                                      mstate.esp -= 4;
                                                      mstate.funcs[this.i1]();
                                                      return;
                                                   }
                                                   this.i5 = 283;
                                                }
                                                addr3203:
                                             }
                                          }
                                          addr3011:
                                          this.i0 = li32(this.i2 + 4);
                                          this.i1 = li8(this.i0);
                                          this.i0 += 1;
                                          si32(this.i0,this.i2 + 4);
                                          si32(this.i1,this.i4);
                                          mstate.eax = this.i5;
                                          break loop14;
                                       }
                                       if(this.i7 > 33)
                                       {
                                          if(this.i7 != 34)
                                          {
                                             if(this.i7 != 39)
                                             {
                                                if(this.i7 != 45)
                                                {
                                                   §§goto(addr7625);
                                                }
                                                else
                                                {
                                                   addr190:
                                                   while(true)
                                                   {
                                                      addr191:
                                                      while(true)
                                                      {
                                                         this.i5 = li32(this.i0);
                                                         this.i6 = li32(this.i5);
                                                         this.i7 = this.i6 + -1;
                                                         si32(this.i7,this.i5);
                                                         this.i5 = li32(this.i0);
                                                         if(this.i6 == 0)
                                                         {
                                                            this.i6 = mstate.ebp + -436;
                                                            this.i7 = li32(this.i5 + 16);
                                                            this.i8 = li32(this.i5 + 8);
                                                            this.i9 = li32(this.i5 + 12);
                                                            mstate.esp -= 12;
                                                            si32(this.i7,mstate.esp);
                                                            si32(this.i9,mstate.esp + 4);
                                                            si32(this.i6,mstate.esp + 8);
                                                            state = 5;
                                                            mstate.esp -= 4;
                                                            mstate.funcs[this.i8]();
                                                            return;
                                                         }
                                                         this.i6 = li32(this.i5 + 4);
                                                         this.i7 = li8(this.i6);
                                                         this.i6 += 1;
                                                         si32(this.i6,this.i5 + 4);
                                                         si32(this.i7,this.i4);
                                                         if(this.i7 != 45)
                                                         {
                                                            addr261:
                                                            this.i2 = 45;
                                                            addr8603:
                                                            this.i0 = this.i2;
                                                            addr8607:
                                                            mstate.eax = this.i0;
                                                            break loop14;
                                                         }
                                                         addr840:
                                                         while(true)
                                                         {
                                                            this.i5 = li32(this.i0);
                                                            this.i6 = li32(this.i5);
                                                            this.i7 = this.i6 + -1;
                                                            si32(this.i7,this.i5);
                                                            this.i5 = li32(this.i0);
                                                            if(this.i6 == 0)
                                                            {
                                                               this.i6 = mstate.ebp + -428;
                                                               this.i7 = li32(this.i5 + 16);
                                                               this.i8 = li32(this.i5 + 8);
                                                               this.i9 = li32(this.i5 + 12);
                                                               mstate.esp -= 12;
                                                               si32(this.i7,mstate.esp);
                                                               si32(this.i9,mstate.esp + 4);
                                                               si32(this.i6,mstate.esp + 8);
                                                               state = 6;
                                                               mstate.esp -= 4;
                                                               mstate.funcs[this.i8]();
                                                               return;
                                                            }
                                                            this.i6 = li32(this.i5 + 4);
                                                            this.i7 = li8(this.i6);
                                                            this.i6 += 1;
                                                            si32(this.i6,this.i5 + 4);
                                                            si32(this.i7,this.i4);
                                                            if(this.i7 == 91)
                                                            {
                                                               §§goto(addr1062);
                                                            }
                                                            while(true)
                                                            {
                                                               this.i5 = li32(this.i4);
                                                               if(this.i5 != 10)
                                                               {
                                                                  if(this.i5 != 13)
                                                                  {
                                                                     while(this.i5 != -1)
                                                                     {
                                                                        this.i5 = li32(this.i0);
                                                                        this.i6 = li32(this.i5);
                                                                        this.i7 = this.i6 + -1;
                                                                        si32(this.i7,this.i5);
                                                                        this.i5 = li32(this.i0);
                                                                        if(this.i6 == 0)
                                                                        {
                                                                           this.i6 = mstate.ebp + -420;
                                                                           this.i7 = li32(this.i5 + 16);
                                                                           this.i8 = li32(this.i5 + 8);
                                                                           this.i9 = li32(this.i5 + 12);
                                                                           mstate.esp -= 12;
                                                                           si32(this.i7,mstate.esp);
                                                                        }
                                                                        this.i6 = li32(this.i5 + 4);
                                                                        this.i7 = li8(this.i6);
                                                                        this.i6 += 1;
                                                                        si32(this.i6,this.i5 + 4);
                                                                        si32(this.i7,this.i4);
                                                                        if(this.i7 == 10)
                                                                        {
                                                                           break;
                                                                        }
                                                                        continue;
                                                                        si32(this.i9,mstate.esp + 4);
                                                                        si32(this.i6,mstate.esp + 8);
                                                                        state = 9;
                                                                        mstate.esp -= 4;
                                                                        mstate.funcs[this.i8]();
                                                                        if(this.i7 == 13)
                                                                        {
                                                                           break;
                                                                        }
                                                                        this.i5 = this.i7;
                                                                        continue;
                                                                        return;
                                                                     }
                                                                  }
                                                               }
                                                               continue loop0;
                                                            }
                                                         }
                                                      }
                                                   }
                                                   addr190:
                                                }
                                             }
                                          }
                                          this.i5 = this.i7;
                                          addr3617:
                                          mstate.esp -= 8;
                                          si32(this.i1,mstate.esp);
                                          si32(this.i5,mstate.esp + 4);
                                          state = 25;
                                          mstate.esp -= 4;
                                          FSM_save.start();
                                          return;
                                          addr3616:
                                       }
                                       if(this.i7 != -1)
                                       {
                                          if(this.i7 != 10)
                                          {
                                             if(this.i7 != 13)
                                             {
                                                addr7625:
                                                this.i6 = this.i7;
                                                this.i5 = this.i7;
                                                continue loop1;
                                             }
                                          }
                                          addr108:
                                          mstate.esp -= 4;
                                          si32(this.i1,mstate.esp);
                                          state = 1;
                                          mstate.esp -= 4;
                                          FSM_inclinenumber.start();
                                          return;
                                          addr107:
                                       }
                                       else
                                       {
                                          addr8599:
                                       }
                                       addr8599:
                                       this.i2 = 287;
                                       §§goto(addr8603);
                                    }
                                 }
                                 break loop14;
                              }
                           }
                           §§goto(addr108);
                        }
                        §§goto(addr8599);
                     }
                     else if(this.i5 != 34)
                     {
                        if(this.i5 != 39)
                        {
                           if(this.i5 != 45)
                           {
                              §§goto(addr302);
                           }
                           §§goto(addr191);
                        }
                        §§goto(addr3617);
                     }
                     §§goto(addr3617);
                  }
                  else
                  {
                     if(this.i5 > 61)
                     {
                        if(this.i5 != 62)
                        {
                           if(this.i5 != 91)
                           {
                              if(this.i5 != 126)
                              {
                                 §§goto(addr302);
                              }
                              §§goto(addr3204);
                           }
                           §§goto(addr1518);
                        }
                        break;
                     }
                     if(this.i5 != 46)
                     {
                        if(this.i5 != 60)
                        {
                           if(this.i5 != 61)
                           {
                              §§goto(addr302);
                           }
                           §§goto(addr1926);
                        }
                        §§goto(addr2337);
                     }
                     else
                     {
                        this.i2 = this.i5;
                     }
                     §§goto(addr6945);
                  }
               }
               addr2748:
               this.i2 = li32(this.i0);
               this.i5 = li32(this.i2);
               this.i1 = this.i5 + -1;
               si32(this.i1,this.i2);
               this.i2 = li32(this.i0);
               if(this.i5 == 0)
               {
                  this.i5 = mstate.ebp + -308;
                  this.i1 = li32(this.i2 + 16);
                  this.i3 = li32(this.i2 + 8);
                  this.i6 = li32(this.i2 + 12);
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  state = 21;
                  mstate.esp -= 4;
                  mstate.funcs[this.i3]();
                  return;
               }
               this.i5 = li32(this.i2 + 4);
               this.i1 = li8(this.i5);
               this.i5 += 1;
               si32(this.i5,this.i2 + 4);
               si32(this.i1,this.i4);
               if(this.i1 != 61)
               {
                  addr2816:
                  this.i2 = 62;
                  §§goto(addr8603);
               }
               else
               {
                  addr2975:
                  this.i2 = li32(this.i0);
                  this.i5 = li32(this.i2);
                  this.i1 = this.i5 + -1;
                  si32(this.i1,this.i2);
                  this.i2 = li32(this.i0);
                  if(this.i5 == 0)
                  {
                     this.i5 = mstate.ebp + -300;
                     this.i0 = li32(this.i2 + 16);
                     this.i1 = li32(this.i2 + 8);
                     this.i3 = li32(this.i2 + 12);
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     si32(this.i5,mstate.esp + 8);
                     state = 22;
                     mstate.esp -= 4;
                     mstate.funcs[this.i1]();
                     return;
                  }
                  this.i5 = 281;
                  §§goto(addr3011);
               }
               break;
            case 1:
               mstate.esp += 4;
               this.i5 = li32(this.i4);
               if(this.i5 <= 45)
               {
                  if(this.i5 <= 33)
                  {
                     if(this.i5 != -1)
                     {
                        if(this.i5 != 10)
                        {
                           if(this.i5 != 13)
                           {
                              addr674:
                              this.i6 = this.i5;
                              §§goto(addr308);
                           }
                        }
                        §§goto(addr107);
                     }
                     §§goto(addr8599);
                  }
                  else if(this.i5 != 34)
                  {
                     if(this.i5 != 39)
                     {
                        if(this.i5 != 45)
                        {
                           §§goto(addr674);
                        }
                        §§goto(addr190);
                     }
                     §§goto(addr3617);
                  }
                  §§goto(addr3617);
               }
               else if(this.i5 <= 61)
               {
                  if(this.i5 != 46)
                  {
                     if(this.i5 != 60)
                     {
                        if(this.i5 != 61)
                        {
                           §§goto(addr674);
                        }
                        §§goto(addr1926);
                     }
                     §§goto(addr2337);
                  }
                  else
                  {
                     this.i2 = this.i5;
                  }
                  §§goto(addr6945);
               }
               else if(this.i5 != 62)
               {
                  if(this.i5 != 91)
                  {
                     if(this.i5 != 126)
                     {
                        §§goto(addr674);
                     }
                     §§goto(addr3204);
                  }
                  §§goto(addr1518);
               }
               §§goto(addr2748);
            case 5:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               if(this.i6 != 0)
               {
                  this.i7 = li32(mstate.ebp + -436);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i5);
                     si32(this.i6,this.i5 + 4);
                     this.i7 = li8(this.i6);
                     this.i6 += 1;
                     si32(this.i6,this.i5 + 4);
                     this.i5 = this.i7;
                  }
                  else
                  {
                     addr773:
                     this.i5 = -1;
                  }
                  si32(this.i5,this.i4);
                  if(this.i5 == 45)
                  {
                     §§goto(addr840);
                  }
                  §§goto(addr261);
               }
               §§goto(addr773);
            case 6:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               if(this.i6 != 0)
               {
                  this.i7 = li32(mstate.ebp + -428);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i5);
                     si32(this.i6,this.i5 + 4);
                     this.i7 = li8(this.i6);
                     this.i6 += 1;
                     si32(this.i6,this.i5 + 4);
                     this.i5 = this.i7;
                  }
                  else
                  {
                     addr995:
                     this.i5 = -1;
                  }
                  si32(this.i5,this.i4);
                  if(this.i5 != 91)
                  {
                     §§goto(addr1496);
                  }
                  addr1062:
                  this.i5 = 0;
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_skip_sep.start();
                  return;
               }
               §§goto(addr995);
            case 7:
               this.i6 = mstate.eax;
               mstate.esp += 4;
               this.i7 = li32(this.i2);
               si32(this.i5,this.i7 + 4);
               if(this.i6 >= 0)
               {
                  this.i5 = 0;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_read_long_string.start();
                  return;
               }
               §§goto(addr1496);
               break;
            case 8:
               mstate.esp += 12;
               this.i6 = li32(this.i2);
               si32(this.i5,this.i6 + 4);
               this.i5 = li32(this.i4);
               if(this.i5 <= 45)
               {
                  if(this.i5 <= 33)
                  {
                     if(this.i5 != -1)
                     {
                        if(this.i5 != 10)
                        {
                           if(this.i5 != 13)
                           {
                              addr1259:
                              this.i6 = this.i5;
                              §§goto(addr308);
                           }
                        }
                        §§goto(addr108);
                     }
                     §§goto(addr8599);
                  }
                  else if(this.i5 != 34)
                  {
                     if(this.i5 != 39)
                     {
                        if(this.i5 != 45)
                        {
                           §§goto(addr1259);
                        }
                        §§goto(addr190);
                     }
                     §§goto(addr3617);
                  }
                  §§goto(addr3617);
               }
               else if(this.i5 <= 61)
               {
                  if(this.i5 != 46)
                  {
                     if(this.i5 != 60)
                     {
                        if(this.i5 != 61)
                        {
                           §§goto(addr1259);
                        }
                        §§goto(addr1926);
                     }
                     §§goto(addr2337);
                  }
                  else
                  {
                     this.i2 = this.i5;
                  }
                  §§goto(addr6945);
               }
               else if(this.i5 != 62)
               {
                  if(this.i5 != 91)
                  {
                     if(this.i5 != 126)
                     {
                        §§goto(addr1259);
                     }
                     §§goto(addr3204);
                  }
                  §§goto(addr1518);
               }
               §§goto(addr2748);
            case 9:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               if(this.i6 != 0)
               {
                  this.i7 = li32(mstate.ebp + -420);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i5);
                     si32(this.i6,this.i5 + 4);
                     this.i7 = li8(this.i6);
                     this.i6 += 1;
                     si32(this.i6,this.i5 + 4);
                     this.i5 = this.i7;
                  }
                  else
                  {
                     addr1435:
                     this.i5 = -1;
                  }
                  si32(this.i5,this.i4);
                  §§goto(addr1496);
               }
               §§goto(addr1435);
            case 64:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               if(this.i6 != 0)
               {
                  this.i7 = li32(mstate.ebp + -324);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i5);
                     si32(this.i6,this.i5 + 4);
                     this.i7 = li8(this.i6);
                     this.i6 += 1;
                     si32(this.i6,this.i5 + 4);
                     this.i5 = this.i7;
                  }
                  else
                  {
                     addr7732:
                     this.i5 = -1;
                  }
                  si32(this.i5,this.i4);
                  if(this.i5 <= 45)
                  {
                     if(this.i5 <= 33)
                     {
                        if(this.i5 != -1)
                        {
                           if(this.i5 != 10)
                           {
                              if(this.i5 != 13)
                              {
                                 addr7872:
                                 this.i6 = this.i5;
                                 §§goto(addr308);
                              }
                           }
                           §§goto(addr108);
                        }
                        §§goto(addr8599);
                     }
                     else if(this.i5 != 34)
                     {
                        if(this.i5 != 39)
                        {
                           if(this.i5 != 45)
                           {
                              §§goto(addr7872);
                           }
                           §§goto(addr190);
                        }
                        §§goto(addr3616);
                     }
                     §§goto(addr3617);
                  }
                  else if(this.i5 <= 61)
                  {
                     if(this.i5 != 46)
                     {
                        if(this.i5 != 60)
                        {
                           if(this.i5 != 61)
                           {
                              §§goto(addr7872);
                           }
                           §§goto(addr1925);
                        }
                        §§goto(addr2336);
                     }
                     else
                     {
                        this.i2 = this.i5;
                     }
                     §§goto(addr6944);
                  }
                  else if(this.i5 != 62)
                  {
                     if(this.i5 != 91)
                     {
                        if(this.i5 != 126)
                        {
                           §§goto(addr7872);
                        }
                        §§goto(addr3203);
                     }
                     §§goto(addr1517);
                  }
                  §§goto(addr2747);
               }
               §§goto(addr7732);
            case 2:
               §§goto(addr339);
            case 3:
               §§goto(addr420);
            case 4:
               mstate.esp += 8;
               this.i6 = li32(this.i0);
               this.i5 = li32(this.i6);
               this.i7 = this.i5 + -1;
               si32(this.i7,this.i6);
               this.i6 = li32(this.i0);
               if(this.i5 == 0)
               {
                  this.i5 = mstate.ebp + -424;
                  this.i7 = li32(this.i6 + 16);
                  this.i8 = li32(this.i6 + 8);
                  this.i9 = li32(this.i6 + 12);
                  mstate.esp -= 12;
                  si32(this.i7,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  state = 65;
                  mstate.esp -= 4;
                  mstate.funcs[this.i8]();
                  return;
               }
               this.i5 = li32(this.i6 + 4);
               this.i7 = li8(this.i5);
               this.i5 += 1;
               si32(this.i5,this.i6 + 4);
               si32(this.i7,this.i4);
               this.i6 = this.i7;
               this.i5 = this.i7;
               §§goto(addr583);
               break;
            case 10:
               this.i5 = mstate.eax;
               mstate.esp += 4;
               if(this.i5 >= 0)
               {
                  this.i2 = 286;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_read_long_string.start();
                  return;
               }
               if(this.i5 == -1)
               {
                  this.i2 = 91;
                  §§goto(addr261);
               }
               else
               {
                  this.i5 = 80;
                  this.i3 = li32(this.i1 + 52);
                  mstate.esp -= 12;
                  this.i6 = mstate.ebp + -416;
                  this.i3 += 16;
                  si32(this.i6,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaO_chunkid.start();
               }
            case 12:
               mstate.esp += 12;
               this.i5 = li32(this.i1 + 4);
               this.i3 = li32(this.i1 + 40);
               mstate.esp -= 20;
               this.i7 = __2E_str15272;
               this.i8 = __2E_str44299;
               si32(this.i3,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               si32(this.i8,mstate.esp + 16);
               state = 13;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 11:
               mstate.esp += 12;
               addr8414:
               mstate.eax = this.i2;
               break;
            case 13:
               this.i5 = mstate.eax;
               mstate.esp += 20;
               mstate.esp -= 8;
               this.i3 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 14;
               mstate.esp -= 4;
               FSM_save.start();
               return;
            case 14:
               mstate.esp += 8;
               this.i2 = li32(this.i2);
               this.i2 = li32(this.i2);
               this.i3 = li32(this.i1 + 40);
               mstate.esp -= 16;
               this.i6 = __2E_str35292;
               si32(this.i3,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 15;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 15:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i1 + 40);
               mstate.esp -= 8;
               this.i5 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 16;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 16:
               mstate.esp += 8;
               §§goto(addr1926);
            case 17:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i1 = li32(mstate.ebp + -328);
                  if(this.i1 != 0)
                  {
                     this.i1 += -1;
                     si32(this.i1,this.i2);
                     si32(this.i5,this.i2 + 4);
                     this.i1 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i2 + 4);
                     this.i2 = this.i1;
                  }
                  else
                  {
                     addr2086:
                     this.i2 = -1;
                  }
                  si32(this.i2,this.i4);
                  if(this.i2 == 61)
                  {
                     §§goto(addr2153);
                  }
                  else
                  {
                     §§goto(addr1994);
                  }
               }
               §§goto(addr2086);
            case 18:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i0 = li32(mstate.ebp + -320);
                  if(this.i0 != 0)
                  {
                     this.i0 += -1;
                     si32(this.i0,this.i2);
                     si32(this.i5,this.i2 + 4);
                     this.i0 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i2 + 4);
                     this.i2 = this.i0;
                  }
                  else
                  {
                     addr2276:
                     this.i2 = -1;
                  }
                  this.i5 = 280;
                  addr3191:
                  si32(this.i2,this.i4);
                  §§goto(addr3011);
               }
               §§goto(addr2276);
            case 19:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i1 = li32(mstate.ebp + -316);
                  if(this.i1 != 0)
                  {
                     this.i1 += -1;
                     si32(this.i1,this.i2);
                     si32(this.i5,this.i2 + 4);
                     this.i1 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i2 + 4);
                     this.i2 = this.i1;
                  }
                  else
                  {
                     addr2497:
                     this.i2 = -1;
                  }
                  si32(this.i2,this.i4);
                  if(this.i2 == 61)
                  {
                     §§goto(addr2564);
                  }
                  else
                  {
                     §§goto(addr2405);
                  }
               }
               §§goto(addr2497);
            case 20:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i0 = li32(mstate.ebp + -312);
                  if(this.i0 != 0)
                  {
                     this.i0 += -1;
                     si32(this.i0,this.i2);
                     si32(this.i5,this.i2 + 4);
                     this.i0 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i2 + 4);
                     this.i2 = this.i0;
                  }
                  else
                  {
                     addr2687:
                     this.i2 = -1;
                  }
                  this.i5 = 282;
                  §§goto(addr3191);
               }
               §§goto(addr2687);
            case 21:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i1 = li32(mstate.ebp + -308);
                  if(this.i1 != 0)
                  {
                     this.i1 += -1;
                     si32(this.i1,this.i2);
                     si32(this.i5,this.i2 + 4);
                     this.i1 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i2 + 4);
                     this.i2 = this.i1;
                  }
                  else
                  {
                     addr2908:
                     this.i2 = -1;
                  }
                  si32(this.i2,this.i4);
                  if(this.i2 == 61)
                  {
                     §§goto(addr2975);
                  }
                  else
                  {
                     §§goto(addr2816);
                  }
               }
               §§goto(addr2908);
            case 22:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i0 = li32(mstate.ebp + -300);
                  if(this.i0 != 0)
                  {
                     this.i0 += -1;
                     si32(this.i0,this.i2);
                     si32(this.i5,this.i2 + 4);
                     this.i0 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i2 + 4);
                     this.i2 = this.i0;
                  }
                  else
                  {
                     addr3130:
                     this.i2 = -1;
                  }
                  this.i5 = 281;
                  §§goto(addr3191);
               }
               §§goto(addr3130);
            case 23:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i1 = li32(mstate.ebp + -296);
                  if(this.i1 != 0)
                  {
                     this.i1 += -1;
                     si32(this.i1,this.i2);
                     si32(this.i5,this.i2 + 4);
                     this.i1 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i2 + 4);
                     this.i2 = this.i1;
                  }
                  else
                  {
                     addr3364:
                     this.i2 = -1;
                  }
                  si32(this.i2,this.i4);
                  if(this.i2 == 61)
                  {
                     §§goto(addr3431);
                  }
                  else
                  {
                     §§goto(addr3272);
                  }
               }
               §§goto(addr3364);
            case 24:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i0 = li32(mstate.ebp + -288);
                  if(this.i0 != 0)
                  {
                     this.i0 += -1;
                     si32(this.i0,this.i2);
                     si32(this.i5,this.i2 + 4);
                     this.i0 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i2 + 4);
                     this.i2 = this.i0;
                  }
                  else
                  {
                     addr3554:
                     this.i2 = -1;
                  }
                  this.i5 = 283;
                  §§goto(addr3191);
               }
               §§goto(addr3554);
            case 25:
               mstate.esp += 8;
               this.i6 = li32(this.i0);
               this.i7 = li32(this.i6);
               this.i8 = this.i7 + -1;
               si32(this.i8,this.i6);
               this.i6 = li32(this.i0);
               if(this.i7 == 0)
               {
                  this.i8 = mstate.ebp + -280;
                  this.i7 = li32(this.i6 + 16);
                  this.i9 = li32(this.i6 + 8);
                  this.i10 = li32(this.i6 + 12);
                  mstate.esp -= 12;
                  si32(this.i7,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  si32(this.i8,mstate.esp + 8);
                  state = 31;
                  mstate.esp -= 4;
                  mstate.funcs[this.i9]();
                  return;
               }
               this.i7 = li32(this.i6 + 4);
               this.i8 = li8(this.i7);
               this.i7 += 1;
               si32(this.i7,this.i6 + 4);
               si32(this.i8,this.i4);
               if(this.i8 != this.i5)
               {
                  this.i6 = this.i8;
                  loop10:
                  while(true)
                  {
                     if(this.i8 <= 12)
                     {
                        if(this.i8 == -1)
                        {
                           this.i6 = 80;
                           this.i8 = li32(this.i1 + 52);
                           mstate.esp -= 12;
                           this.i7 = mstate.ebp + -272;
                           this.i8 += 16;
                           si32(this.i7,mstate.esp);
                           si32(this.i8,mstate.esp + 4);
                           si32(this.i6,mstate.esp + 8);
                           mstate.esp -= 4;
                           FSM_luaO_chunkid.start();
                           §§goto(addr4439);
                        }
                        if(this.i8 == 10)
                        {
                           break;
                        }
                     }
                     else
                     {
                        if(this.i8 == 13)
                        {
                           break;
                        }
                        if(this.i8 == 92)
                        {
                           this.i6 = li32(this.i0);
                           this.i8 = li32(this.i6);
                           this.i7 = this.i8 + -1;
                           si32(this.i7,this.i6);
                           this.i6 = li32(this.i0);
                           if(this.i8 == 0)
                           {
                              this.i8 = mstate.ebp + -100;
                              this.i7 = li32(this.i6 + 16);
                              this.i9 = li32(this.i6 + 8);
                              this.i10 = li32(this.i6 + 12);
                              mstate.esp -= 12;
                              si32(this.i7,mstate.esp);
                              si32(this.i10,mstate.esp + 4);
                              si32(this.i8,mstate.esp + 8);
                              state = 39;
                              mstate.esp -= 4;
                              mstate.funcs[this.i9]();
                              return;
                           }
                           this.i8 = li32(this.i6 + 4);
                           this.i7 = li8(this.i8);
                           this.i8 += 1;
                           si32(this.i8,this.i6 + 4);
                           si32(this.i7,this.i4);
                           if(this.i7 <= 101)
                           {
                              if(this.i7 <= 12)
                              {
                                 if(this.i7 != -1)
                                 {
                                    if(this.i7 != 10)
                                    {
                                       §§goto(addr4747);
                                    }
                                 }
                                 else
                                 {
                                    addr6484:
                                    while(true)
                                    {
                                       this.i8 = li32(this.i4);
                                       if(this.i8 == this.i5)
                                       {
                                          this.i5 = this.i8;
                                          mstate.esp -= 8;
                                          si32(this.i1,mstate.esp);
                                          si32(this.i5,mstate.esp + 4);
                                       }
                                       else
                                       {
                                          addr6504:
                                       }
                                       continue loop10;
                                       state = 54;
                                       mstate.esp -= 4;
                                       FSM_save.start();
                                       return;
                                    }
                                    addr6484:
                                 }
                              }
                              else if(this.i7 != 13)
                              {
                                 if(this.i7 != 97)
                                 {
                                    if(this.i7 == 98)
                                    {
                                       addr4705:
                                       this.i6 = 8;
                                       §§goto(addr5987);
                                    }
                                    §§goto(addr4747);
                                 }
                                 else
                                 {
                                    addr5983:
                                    this.i6 = 7;
                                    §§goto(addr5987);
                                 }
                              }
                              else
                              {
                                 addr4311:
                              }
                              this.i6 = 10;
                              mstate.esp -= 8;
                              si32(this.i1,mstate.esp);
                              si32(this.i6,mstate.esp + 4);
                              state = 32;
                              mstate.esp -= 4;
                              FSM_save.start();
                              return;
                           }
                           if(this.i7 <= 113)
                           {
                              if(this.i7 != 102)
                              {
                                 if(this.i7 != 110)
                                 {
                                    §§goto(addr4747);
                                 }
                                 else
                                 {
                                    addr4727:
                                    this.i6 = 10;
                                 }
                              }
                              else
                              {
                                 addr5119:
                                 this.i6 = 12;
                              }
                           }
                           else if(this.i7 != 114)
                           {
                              if(this.i7 != 116)
                              {
                                 if(this.i7 != 118)
                                 {
                                    addr4747:
                                    this.i6 = this.i7;
                                    §§goto(addr4754);
                                 }
                                 else
                                 {
                                    addr5131:
                                    this.i6 = 11;
                                 }
                              }
                              else
                              {
                                 addr5127:
                                 this.i6 = 9;
                              }
                           }
                           else
                           {
                              addr5123:
                              this.i6 = 13;
                           }
                           addr5987:
                           mstate.esp -= 8;
                           si32(this.i1,mstate.esp);
                           si32(this.i6,mstate.esp + 4);
                           state = 50;
                           mstate.esp -= 4;
                           FSM_save.start();
                           return;
                        }
                     }
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     state = 52;
                     mstate.esp -= 4;
                     FSM_save.start();
                     return;
                  }
                  this.i6 = 80;
                  this.i8 = li32(this.i1 + 52);
                  mstate.esp -= 12;
                  this.i7 = mstate.ebp + -192;
                  this.i8 += 16;
                  si32(this.i7,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaO_chunkid.start();
                  §§goto(addr3804);
               }
               else
               {
                  this.i5 = this.i8;
               }
               §§goto(addr6504);
               break;
            case 30:
               mstate.esp += 8;
               §§goto(addr6484);
            case 31:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               if(this.i8 != 0)
               {
                  this.i7 = li32(mstate.ebp + -280);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i6);
                     si32(this.i8,this.i6 + 4);
                     this.i7 = li8(this.i8);
                     this.i8 += 1;
                     si32(this.i8,this.i6 + 4);
                     this.i6 = this.i7;
                  }
                  else
                  {
                     addr4151:
                     this.i6 = -1;
                  }
                  si32(this.i6,this.i4);
                  §§goto(addr6484);
               }
               §§goto(addr4151);
            case 33:
               mstate.esp += 4;
               §§goto(addr6484);
            case 38:
               mstate.esp += 8;
               §§goto(addr6484);
            case 39:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               if(this.i8 != 0)
               {
                  this.i7 = li32(mstate.ebp + -100);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i6);
                     si32(this.i8,this.i6 + 4);
                     this.i7 = li8(this.i8);
                     this.i8 += 1;
                     si32(this.i8,this.i6 + 4);
                     this.i6 = this.i7;
                  }
                  else
                  {
                     addr4989:
                     this.i6 = -1;
                  }
                  si32(this.i6,this.i4);
                  if(this.i6 <= 101)
                  {
                     if(this.i6 <= 12)
                     {
                        if(this.i6 != -1)
                        {
                           if(this.i6 == 10)
                           {
                              §§goto(addr4311);
                           }
                           else
                           {
                              addr5118:
                           }
                        }
                        else
                        {
                           §§goto(addr6484);
                        }
                        addr4754:
                        if(uint(this.i6) <= uint(255))
                        {
                           this.i8 = __DefaultRuneLocale;
                           this.i7 = this.i6 << 2;
                           this.i8 += this.i7;
                           this.i8 = li32(this.i8 + 52);
                           this.i8 &= 1024;
                           if(this.i8 != 0)
                           {
                              this.i8 = 0;
                              this.i7 = 1;
                              loop11:
                              while(true)
                              {
                                 this.i9 = li32(this.i0);
                                 this.i10 = li32(this.i9);
                                 this.i11 = this.i10 + -1;
                                 this.i8 *= 10;
                                 si32(this.i11,this.i9);
                                 this.i6 = this.i8 + this.i6;
                                 this.i8 = li32(this.i0);
                                 this.i9 = this.i6 + -48;
                                 if(this.i10 != 0)
                                 {
                                    this.i6 = li32(this.i8 + 4);
                                    this.i10 = li8(this.i6);
                                    this.i6 += 1;
                                    si32(this.i6,this.i8 + 4);
                                    si32(this.i10,this.i4);
                                    if(this.i7 <= 2)
                                    {
                                       this.i6 = this.i10;
                                       while(true)
                                       {
                                          if(uint(this.i6) > uint(255))
                                          {
                                             break loop11;
                                          }
                                          this.i8 = __DefaultRuneLocale;
                                          this.i10 = this.i6 << 2;
                                          this.i8 += this.i10;
                                          this.i8 = li32(this.i8 + 52);
                                          this.i7 += 1;
                                          this.i8 &= 1024;
                                          if(this.i8 == 0)
                                          {
                                             break loop11;
                                          }
                                          continue loop11;
                                       }
                                       addr5538:
                                    }
                                    break;
                                 }
                                 this.i6 = mstate.ebp + -8;
                                 this.i10 = li32(this.i8 + 16);
                                 this.i11 = li32(this.i8 + 8);
                                 this.i12 = li32(this.i8 + 12);
                                 mstate.esp -= 12;
                                 si32(this.i10,mstate.esp);
                                 si32(this.i12,mstate.esp + 4);
                                 si32(this.i6,mstate.esp + 8);
                                 state = 42;
                                 mstate.esp -= 4;
                                 mstate.funcs[this.i11]();
                                 return;
                              }
                              §§goto(addr5593);
                           }
                        }
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i6,mstate.esp + 4);
                        state = 40;
                        mstate.esp -= 4;
                        FSM_save.start();
                        return;
                     }
                     if(this.i6 != 13)
                     {
                        if(this.i6 != 97)
                        {
                           if(this.i6 != 98)
                           {
                              §§goto(addr5118);
                           }
                           else
                           {
                              §§goto(addr4705);
                           }
                        }
                        else
                        {
                           §§goto(addr5983);
                        }
                        §§goto(addr4705);
                     }
                     §§goto(addr4311);
                  }
                  else
                  {
                     if(this.i6 <= 113)
                     {
                        if(this.i6 != 102)
                        {
                           if(this.i6 != 110)
                           {
                              §§goto(addr5118);
                           }
                           else
                           {
                              §§goto(addr4727);
                           }
                        }
                        else
                        {
                           §§goto(addr5119);
                        }
                     }
                     else if(this.i6 != 114)
                     {
                        if(this.i6 != 116)
                        {
                           if(this.i6 != 118)
                           {
                              §§goto(addr5118);
                           }
                           else
                           {
                              §§goto(addr5131);
                           }
                        }
                        else
                        {
                           §§goto(addr5127);
                        }
                     }
                     else
                     {
                        §§goto(addr5123);
                     }
                     §§goto(addr4705);
                  }
               }
               §§goto(addr4989);
            case 40:
               mstate.esp += 8;
               this.i6 = li32(this.i0);
               this.i8 = li32(this.i6);
               this.i7 = this.i8 + -1;
               si32(this.i7,this.i6);
               this.i6 = li32(this.i0);
               if(this.i8 == 0)
               {
                  this.i8 = mstate.ebp + -4;
                  this.i7 = li32(this.i6 + 16);
                  this.i9 = li32(this.i6 + 8);
                  this.i10 = li32(this.i6 + 12);
                  mstate.esp -= 12;
                  si32(this.i7,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  si32(this.i8,mstate.esp + 8);
                  state = 41;
                  mstate.esp -= 4;
                  mstate.funcs[this.i9]();
                  return;
               }
               this.i8 = li32(this.i6 + 4);
               this.i7 = li8(this.i8);
               this.i8 += 1;
               si32(this.i8,this.i6 + 4);
               si32(this.i7,this.i4);
               §§goto(addr6484);
               break;
            case 41:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               if(this.i8 != 0)
               {
                  this.i7 = li32(mstate.ebp + -4);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i6);
                     si32(this.i8,this.i6 + 4);
                     this.i7 = li8(this.i8);
                     this.i8 += 1;
                     si32(this.i8,this.i6 + 4);
                     this.i6 = this.i7;
                  }
                  else
                  {
                     addr5322:
                     this.i6 = -1;
                  }
                  si32(this.i6,this.i4);
                  §§goto(addr6484);
               }
               §§goto(addr5322);
            case 48:
               mstate.esp += 8;
               §§goto(addr6484);
            case 49:
               mstate.esp += 8;
               §§goto(addr6484);
            case 50:
               mstate.esp += 8;
               this.i6 = li32(this.i0);
               this.i8 = li32(this.i6);
               this.i7 = this.i8 + -1;
               si32(this.i7,this.i6);
               this.i6 = li32(this.i0);
               if(this.i8 == 0)
               {
                  this.i8 = mstate.ebp + -276;
                  this.i7 = li32(this.i6 + 16);
                  this.i9 = li32(this.i6 + 8);
                  this.i10 = li32(this.i6 + 12);
                  mstate.esp -= 12;
                  si32(this.i7,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  si32(this.i8,mstate.esp + 8);
                  state = 51;
                  mstate.esp -= 4;
                  mstate.funcs[this.i9]();
                  return;
               }
               this.i8 = li32(this.i6 + 4);
               this.i7 = li8(this.i8);
               this.i8 += 1;
               si32(this.i8,this.i6 + 4);
               si32(this.i7,this.i4);
               §§goto(addr6484);
               break;
            case 51:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               if(this.i8 != 0)
               {
                  this.i7 = li32(mstate.ebp + -276);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i6);
                     si32(this.i8,this.i6 + 4);
                     this.i7 = li8(this.i8);
                     this.i8 += 1;
                     si32(this.i8,this.i6 + 4);
                     this.i6 = this.i7;
                  }
                  else
                  {
                     addr6174:
                     this.i6 = -1;
                  }
                  si32(this.i6,this.i4);
                  §§goto(addr6484);
               }
               §§goto(addr6174);
            case 52:
               mstate.esp += 8;
               this.i6 = li32(this.i0);
               this.i8 = li32(this.i6);
               this.i7 = this.i8 + -1;
               si32(this.i7,this.i6);
               this.i6 = li32(this.i0);
               if(this.i8 == 0)
               {
                  this.i8 = mstate.ebp + -284;
                  this.i7 = li32(this.i6 + 16);
                  this.i9 = li32(this.i6 + 8);
                  this.i10 = li32(this.i6 + 12);
                  mstate.esp -= 12;
                  si32(this.i7,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  si32(this.i8,mstate.esp + 8);
                  state = 53;
                  mstate.esp -= 4;
                  mstate.funcs[this.i9]();
                  return;
               }
               this.i8 = li32(this.i6 + 4);
               this.i7 = li8(this.i8);
               this.i8 += 1;
               si32(this.i8,this.i6 + 4);
               si32(this.i7,this.i4);
               §§goto(addr6484);
               break;
            case 53:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               if(this.i8 != 0)
               {
                  this.i7 = li32(mstate.ebp + -284);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i6);
                     si32(this.i8,this.i6 + 4);
                     this.i7 = li8(this.i8);
                     this.i8 += 1;
                     si32(this.i8,this.i6 + 4);
                     this.i6 = this.i7;
                  }
                  else
                  {
                     addr6423:
                     this.i6 = -1;
                  }
                  si32(this.i6,this.i4);
                  §§goto(addr6484);
               }
               §§goto(addr6423);
            case 26:
               addr3804:
               mstate.esp += 12;
               this.i6 = li32(this.i1 + 4);
               this.i8 = li32(this.i1 + 40);
               mstate.esp -= 20;
               this.i9 = __2E_str15272;
               this.i10 = __2E_str45300;
               si32(this.i8,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               si32(this.i10,mstate.esp + 16);
               state = 27;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 34:
               addr4439:
               mstate.esp += 12;
               this.i6 = li32(this.i1 + 4);
               this.i8 = li32(this.i1 + 40);
               mstate.esp -= 20;
               this.i9 = __2E_str15272;
               this.i10 = __2E_str45300;
               si32(this.i8,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               si32(this.i10,mstate.esp + 16);
               state = 35;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 27:
               this.i6 = mstate.eax;
               mstate.esp += 20;
               mstate.esp -= 8;
               this.i8 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 28;
               mstate.esp -= 4;
               FSM_save.start();
               return;
            case 28:
               mstate.esp += 8;
               this.i8 = li32(this.i2);
               this.i8 = li32(this.i8);
               this.i7 = li32(this.i1 + 40);
               mstate.esp -= 16;
               this.i9 = __2E_str35292;
               si32(this.i7,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               state = 29;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 29:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               this.i6 = li32(this.i1 + 40);
               mstate.esp -= 8;
               this.i8 = 3;
               si32(this.i6,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 30;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 32:
               mstate.esp += 8;
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 33;
               mstate.esp -= 4;
               FSM_inclinenumber.start();
               return;
            case 35:
               this.i6 = mstate.eax;
               mstate.esp += 20;
               mstate.esp -= 8;
               this.i8 = 287;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 36;
               mstate.esp -= 4;
               FSM_luaX_token2str.start();
               return;
            case 36:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i1 + 40);
               mstate.esp -= 16;
               this.i9 = __2E_str35292;
               si32(this.i7,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               state = 37;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 37:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               this.i6 = li32(this.i1 + 40);
               mstate.esp -= 8;
               this.i8 = 3;
               si32(this.i6,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 38;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 42:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               if(this.i6 != 0)
               {
                  this.i10 = li32(mstate.ebp + -8);
                  if(this.i10 != 0)
                  {
                     this.i10 += -1;
                     si32(this.i10,this.i8);
                     si32(this.i6,this.i8 + 4);
                     this.i10 = li8(this.i6);
                     this.i6 += 1;
                     si32(this.i6,this.i8 + 4);
                     this.i6 = this.i10;
                  }
                  else
                  {
                     addr5472:
                     this.i6 = -1;
                  }
                  si32(this.i6,this.i4);
                  if(this.i7 <= 2)
                  {
                     §§goto(addr5538);
                  }
                  addr5593:
                  if(this.i9 >= 256)
                  {
                     this.i6 = 80;
                     this.i8 = li32(this.i1 + 52);
                     mstate.esp -= 12;
                     this.i7 = mstate.ebp + -96;
                     this.i8 += 16;
                     si32(this.i7,mstate.esp);
                     si32(this.i8,mstate.esp + 4);
                     si32(this.i6,mstate.esp + 8);
                     mstate.esp -= 4;
                     FSM_luaO_chunkid.start();
                     §§goto(addr5654);
                  }
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  state = 49;
                  mstate.esp -= 4;
                  FSM_save.start();
                  return;
               }
               §§goto(addr5472);
            case 43:
               addr5654:
               mstate.esp += 12;
               this.i6 = li32(this.i1 + 4);
               this.i8 = li32(this.i1 + 40);
               mstate.esp -= 20;
               this.i10 = __2E_str15272;
               this.i11 = __2E_str46301;
               si32(this.i8,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               si32(this.i11,mstate.esp + 16);
               state = 44;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 44:
               this.i6 = mstate.eax;
               mstate.esp += 20;
               mstate.esp -= 8;
               this.i8 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 45;
               mstate.esp -= 4;
               FSM_save.start();
               return;
            case 45:
               mstate.esp += 8;
               this.i8 = li32(this.i2);
               this.i8 = li32(this.i8);
               this.i7 = li32(this.i1 + 40);
               mstate.esp -= 16;
               this.i10 = __2E_str35292;
               si32(this.i7,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               state = 46;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 46:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               this.i6 = li32(this.i1 + 40);
               mstate.esp -= 8;
               this.i8 = 3;
               si32(this.i6,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 47;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 47:
               mstate.esp += 8;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               state = 48;
               mstate.esp -= 4;
               FSM_save.start();
               return;
            case 54:
               mstate.esp += 8;
               this.i5 = li32(this.i0);
               this.i6 = li32(this.i5);
               this.i7 = this.i6 + -1;
               si32(this.i7,this.i5);
               this.i5 = li32(this.i0);
               if(this.i6 == 0)
               {
                  this.i0 = mstate.ebp + -292;
                  this.i6 = li32(this.i5 + 16);
                  this.i7 = li32(this.i5 + 8);
                  this.i8 = li32(this.i5 + 12);
                  mstate.esp -= 12;
                  si32(this.i6,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 55;
                  mstate.esp -= 4;
                  mstate.funcs[this.i7]();
                  return;
               }
               this.i0 = li32(this.i5 + 4);
               this.i6 = li8(this.i0);
               this.i0 += 1;
               si32(this.i0,this.i5 + 4);
               this.i5 = this.i6;
               §§goto(addr6746);
               break;
            case 55:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 != 0)
               {
                  this.i6 = li32(mstate.ebp + -292);
                  if(this.i6 != 0)
                  {
                     this.i6 += -1;
                     si32(this.i6,this.i5);
                     si32(this.i0,this.i5 + 4);
                     this.i6 = li8(this.i0);
                     this.i0 += 1;
                     si32(this.i0,this.i5 + 4);
                     this.i5 = this.i6;
                  }
                  else
                  {
                     addr6690:
                     this.i5 = -1;
                  }
                  addr6746:
                  si32(this.i5,this.i4);
                  this.i2 = li32(this.i2);
                  this.i5 = li32(this.i2 + 4);
                  this.i2 = li32(this.i2);
                  this.i0 = li32(this.i1 + 40);
                  mstate.esp -= 12;
                  this.i2 += 1;
                  this.i5 += -2;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  state = 56;
                  mstate.esp -= 4;
                  FSM_luaS_newlstr.start();
                  return;
               }
               §§goto(addr6690);
            case 56:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i5 = li32(this.i1 + 36);
               this.i5 = li32(this.i5 + 4);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 57;
               mstate.esp -= 4;
               FSM_luaH_setstr.start();
               return;
            case 57:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i5 + 8);
               this.i1 = this.i5 + 8;
               if(this.i0 == 0)
               {
                  this.i0 = 1;
                  si32(this.i0,this.i5);
                  si32(this.i0,this.i1);
               }
               this.i5 = 286;
               si32(this.i2,this.i3);
               §§goto(addr3011);
            case 58:
               mstate.esp += 8;
               this.i2 = li32(this.i0);
               this.i5 = li32(this.i2);
               this.i6 = this.i5 + -1;
               si32(this.i6,this.i2);
               this.i2 = li32(this.i0);
               if(this.i5 != 0)
               {
                  this.i5 = __2E_str20159;
                  this.i0 = li32(this.i2 + 4);
                  this.i6 = li8(this.i0);
                  this.i0 += 1;
                  si32(this.i0,this.i2 + 4);
                  si32(this.i6,this.i4);
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 59;
                  mstate.esp -= 4;
                  FSM_check_next.start();
                  return;
               }
               this.i5 = mstate.ebp + -304;
               this.i0 = li32(this.i2 + 16);
               this.i6 = li32(this.i2 + 8);
               this.i7 = li32(this.i2 + 12);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 60;
               mstate.esp -= 4;
               mstate.funcs[this.i6]();
               return;
               break;
            case 59:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               if(this.i2 != 0)
               {
                  §§goto(addr7316);
               }
               else
               {
                  addr7096:
                  this.i2 = li32(this.i4);
                  if(uint(this.i2) < uint(256))
                  {
                     this.i5 = __DefaultRuneLocale;
                     this.i2 <<= 2;
                     this.i2 = this.i5 + this.i2;
                     this.i2 = li32(this.i2 + 52);
                     this.i2 &= 1024;
                     if(this.i2 != 0)
                     {
                        §§goto(addr7408);
                     }
                  }
                  this.i2 = 46;
                  §§goto(addr261);
               }
            case 60:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i0 = li32(mstate.ebp + -304);
                  if(this.i0 != 0)
                  {
                     this.i0 += -1;
                     si32(this.i0,this.i2);
                     si32(this.i5,this.i2 + 4);
                     this.i0 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i2 + 4);
                     this.i2 = this.i0;
                  }
                  else
                  {
                     addr7205:
                     this.i2 = -1;
                  }
                  this.i5 = __2E_str20159;
                  si32(this.i2,this.i4);
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 61;
                  mstate.esp -= 4;
                  FSM_check_next.start();
                  return;
               }
               §§goto(addr7205);
            case 61:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               if(this.i2 != 0)
               {
                  addr7316:
                  this.i2 = __2E_str20159;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 62;
                  mstate.esp -= 4;
                  FSM_check_next.start();
                  return;
               }
               §§goto(addr7096);
               break;
            case 62:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i2 = this.i2 == 0 ? 278 : 279;
               §§goto(addr8414);
            case 63:
               mstate.esp += 8;
               §§goto(addr8414);
            case 65:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i7 = li32(mstate.ebp + -424);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i6);
                     si32(this.i5,this.i6 + 4);
                     this.i7 = li8(this.i5);
                     this.i5 += 1;
                     si32(this.i5,this.i6 + 4);
                     this.i6 = this.i7;
                  }
                  else
                  {
                     addr8078:
                     this.i6 = -1;
                  }
                  this.i5 = this.i6;
                  si32(this.i5,this.i4);
                  if(uint(this.i5) <= uint(255))
                  {
                     this.i6 = this.i5;
                     §§goto(addr583);
                  }
                  else
                  {
                     mstate.esp -= 4;
                     si32(this.i5,mstate.esp);
                     mstate.esp -= 4;
                     FSM____runetype.start();
                     §§goto(addr8177);
                  }
               }
               §§goto(addr8078);
            case 66:
               addr8177:
               this.i6 = mstate.eax;
               mstate.esp += 4;
               this.i6 &= 1280;
               if(this.i6 != 0)
               {
                  this.i6 = this.i5;
               }
               else
               {
                  this.i6 = this.i5;
                  §§goto(addr8208);
               }
               addr583:
               this.i7 = li32(__CurrentRuneLocale);
               this.i5 <<= 2;
               this.i5 = this.i7 + this.i5;
               this.i5 = li32(this.i5 + 52);
               this.i5 &= 1280;
               if(this.i5 == 0)
               {
                  addr8208:
                  if(this.i6 != 95)
                  {
                     this.i0 = li32(this.i2);
                     this.i2 = li32(this.i0 + 4);
                     this.i0 = li32(this.i0);
                     this.i4 = li32(this.i1 + 40);
                     mstate.esp -= 12;
                     si32(this.i4,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     si32(this.i2,mstate.esp + 8);
                     state = 67;
                     mstate.esp -= 4;
                     FSM_luaS_newlstr.start();
                     return;
                  }
               }
               addr473:
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_save.start();
               return;
            case 67:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i1 + 36);
               this.i2 = li32(this.i2 + 4);
               mstate.esp -= 12;
               si32(this.i4,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 68;
               mstate.esp -= 4;
               FSM_luaH_setstr.start();
               return;
            case 68:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i4 = li32(this.i2 + 8);
               this.i6 = this.i2 + 8;
               if(this.i4 == 0)
               {
                  this.i4 = 1;
                  si32(this.i4,this.i2);
                  si32(this.i4,this.i6);
               }
               this.i2 = li8(this.i0 + 6);
               if(this.i2 != 0)
               {
                  this.i0 = this.i2 | 256;
                  this.i0 &= 511;
                  §§goto(addr8607);
               }
               else
               {
                  this.i2 = 285;
                  si32(this.i0,this.i3);
                  §§goto(addr8414);
               }
            case 69:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 != 0)
               {
                  this.i1 = li32(mstate.ebp + -432);
                  if(this.i1 != 0)
                  {
                     this.i1 += -1;
                     si32(this.i1,this.i2);
                     si32(this.i0,this.i2 + 4);
                     this.i1 = li8(this.i0);
                     this.i0 += 1;
                     si32(this.i0,this.i2 + 4);
                     this.i2 = this.i1;
                  }
                  else
                  {
                     addr8507:
                     this.i2 = -1;
                  }
                  si32(this.i2,this.i4);
                  §§goto(addr8568);
               }
               §§goto(addr8507);
            default:
               throw "Invalid state in _llex";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
