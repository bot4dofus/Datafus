package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_subexpr extends Machine
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
      
      public function FSM_subexpr()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_subexpr = null;
         _loc1_ = new FSM_subexpr();
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
               mstate.esp -= 256;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 40);
               this.i2 = li16(this.i1 + 52);
               this.i2 += 1;
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = li32(mstate.ebp + 16);
               si16(this.i2,this.i1 + 52);
               this.i1 = this.i0 + 40;
               this.i2 &= 65535;
               if(uint(this.i2) >= uint(201))
               {
                  this.i2 = 80;
                  this.i5 = li32(this.i0 + 52);
                  mstate.esp -= 12;
                  this.i6 = mstate.ebp + -224;
                  this.i5 += 16;
                  si32(this.i6,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaO_chunkid.start();
               }
               else
               {
                  addr284:
                  this.i2 = li32(this.i0 + 12);
                  this.i5 = this.i0 + 12;
                  if(this.i2 != 35)
                  {
                     if(this.i2 != 45)
                     {
                        if(this.i2 == 270)
                        {
                           this.i6 = 1;
                        }
                        else
                        {
                           this.i6 = 3;
                        }
                        if(this.i6 == 3)
                        {
                           if(this.i2 <= 274)
                           {
                              if(this.i2 <= 264)
                              {
                                 if(this.i2 == 123)
                                 {
                                    mstate.esp -= 8;
                                    si32(this.i0,mstate.esp);
                                    si32(this.i3,mstate.esp + 4);
                                    state = 38;
                                    mstate.esp -= 4;
                                    FSM_constructor.start();
                                    return;
                                 }
                                 if(this.i2 != 263)
                                 {
                                    §§goto(addr4982);
                                 }
                                 else
                                 {
                                    this.i2 = -1;
                                    si32(this.i2,this.i3 + 12);
                                    si32(this.i2,this.i3 + 16);
                                    this.i2 = 3;
                                    si32(this.i2,this.i3);
                                    this.i2 = 0;
                                    si32(this.i2,this.i3 + 4);
                                    this.i2 = li32(this.i0 + 4);
                                    si32(this.i2,this.i0 + 8);
                                    this.i2 = li32(this.i0 + 24);
                                    this.i6 = this.i0 + 24;
                                    if(this.i2 == 287)
                                    {
                                       mstate.esp -= 8;
                                       this.i2 = this.i0 + 16;
                                       si32(this.i0,mstate.esp);
                                       si32(this.i2,mstate.esp + 4);
                                       state = 31;
                                       mstate.esp -= 4;
                                       FSM_llex.start();
                                       return;
                                    }
                                    this.i7 = 287;
                                    si32(this.i2,this.i5);
                                    this.f0 = lf64(this.i0 + 28);
                                    sf64(this.f0,this.i0 + 16);
                                    si32(this.i7,this.i6);
                                    addr3870:
                                    this.i2 = li32(this.i5);
                                    if(this.i2 <= 93)
                                    {
                                       if(this.i2 <= 44)
                                       {
                                          if(this.i2 != 37)
                                          {
                                             if(this.i2 != 42)
                                             {
                                                if(this.i2 != 43)
                                                {
                                                   addr2141:
                                                   this.i2 = 15;
                                                   addr2140:
                                                }
                                                else
                                                {
                                                   addr2019:
                                                   this.i2 = 0;
                                                   addr2018:
                                                   if(this.i2 != 15)
                                                   {
                                                      addr7705:
                                                      this.i6 = _priority;
                                                      this.i7 = this.i2 << 1;
                                                      this.i6 += this.i7;
                                                      this.i6 = li8(this.i6);
                                                      if(uint(this.i6) > uint(this.i4))
                                                      {
                                                         this.i6 = li32(this.i0 + 4);
                                                         si32(this.i6,this.i0 + 8);
                                                         this.i6 = li32(this.i0 + 24);
                                                         this.i7 = this.i0 + 24;
                                                         if(this.i6 == 287)
                                                         {
                                                            mstate.esp -= 8;
                                                            this.i6 = this.i0 + 16;
                                                            si32(this.i0,mstate.esp);
                                                            si32(this.i6,mstate.esp + 4);
                                                            state = 42;
                                                            mstate.esp -= 4;
                                                            FSM_llex.start();
                                                            return;
                                                         }
                                                         this.i8 = 287;
                                                         si32(this.i6,this.i5);
                                                         this.f0 = lf64(this.i0 + 28);
                                                         sf64(this.f0,this.i0 + 16);
                                                         si32(this.i8,this.i7);
                                                         §§goto(addr5277);
                                                      }
                                                   }
                                                   addr2018:
                                                }
                                                §§goto(addr7737);
                                             }
                                             else
                                             {
                                                addr5136:
                                                this.i2 = 2;
                                             }
                                          }
                                          else
                                          {
                                             addr5140:
                                             this.i2 = 4;
                                          }
                                       }
                                       else if(this.i2 <= 59)
                                       {
                                          if(this.i2 != 45)
                                          {
                                             if(this.i2 != 47)
                                             {
                                                §§goto(addr2140);
                                             }
                                             else
                                             {
                                                addr2041:
                                                this.i2 = 3;
                                                addr2040:
                                                §§goto(addr7705);
                                                addr2040:
                                             }
                                             §§goto(addr7737);
                                          }
                                          else
                                          {
                                             addr7701:
                                             this.i2 = 1;
                                          }
                                       }
                                       else if(this.i2 != 60)
                                       {
                                          if(this.i2 != 62)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             addr2058:
                                             this.i2 = 11;
                                             addr2057:
                                             §§goto(addr7705);
                                             addr2057:
                                          }
                                          §§goto(addr7737);
                                       }
                                       else
                                       {
                                          addr5152:
                                          this.i2 = 9;
                                       }
                                    }
                                    else if(this.i2 <= 279)
                                    {
                                       if(this.i2 <= 270)
                                       {
                                          if(this.i2 != 94)
                                          {
                                             if(this.i2 != 257)
                                             {
                                                §§goto(addr2140);
                                             }
                                             else
                                             {
                                                addr2085:
                                                this.i2 = 13;
                                                addr2084:
                                                §§goto(addr7705);
                                                addr2084:
                                             }
                                             §§goto(addr7737);
                                          }
                                          else
                                          {
                                             addr5144:
                                             this.i2 = 5;
                                          }
                                       }
                                       else if(this.i2 != 271)
                                       {
                                          if(this.i2 != 278)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             addr2102:
                                             this.i2 = 6;
                                             addr2101:
                                             §§goto(addr7705);
                                             addr2101:
                                          }
                                          §§goto(addr7737);
                                       }
                                       else
                                       {
                                          addr5160:
                                          this.i2 = 14;
                                       }
                                    }
                                    else if(this.i2 <= 281)
                                    {
                                       if(this.i2 != 280)
                                       {
                                          if(this.i2 != 281)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             addr2124:
                                             this.i2 = 12;
                                             addr2123:
                                             §§goto(addr7705);
                                             addr2123:
                                          }
                                          §§goto(addr7737);
                                       }
                                       else
                                       {
                                          addr5148:
                                          this.i2 = 8;
                                       }
                                    }
                                    else if(this.i2 != 282)
                                    {
                                       if(this.i2 != 283)
                                       {
                                          §§goto(addr2140);
                                       }
                                       else
                                       {
                                          addr3038:
                                          this.i2 = 7;
                                          addr3037:
                                          §§goto(addr7705);
                                          addr3037:
                                       }
                                       §§goto(addr7737);
                                    }
                                    else
                                    {
                                       addr5156:
                                       this.i2 = 10;
                                    }
                                    §§goto(addr7705);
                                 }
                              }
                              else if(this.i2 != 265)
                              {
                                 if(this.i2 != 269)
                                 {
                                    §§goto(addr4982);
                                 }
                                 else
                                 {
                                    this.i2 = -1;
                                    si32(this.i2,this.i3 + 12);
                                    si32(this.i2,this.i3 + 16);
                                    this.i2 = 1;
                                    si32(this.i2,this.i3);
                                    this.i2 = 0;
                                    si32(this.i2,this.i3 + 4);
                                    this.i2 = li32(this.i0 + 4);
                                    si32(this.i2,this.i0 + 8);
                                    this.i2 = li32(this.i0 + 24);
                                    this.i6 = this.i0 + 24;
                                    if(this.i2 == 287)
                                    {
                                       mstate.esp -= 8;
                                       this.i2 = this.i0 + 16;
                                       si32(this.i0,mstate.esp);
                                       si32(this.i2,mstate.esp + 4);
                                       state = 29;
                                       mstate.esp -= 4;
                                       FSM_llex.start();
                                       return;
                                    }
                                    this.i7 = 287;
                                    si32(this.i2,this.i5);
                                    this.f0 = lf64(this.i0 + 28);
                                    sf64(this.f0,this.i0 + 16);
                                    si32(this.i7,this.i6);
                                    addr3437:
                                    this.i2 = li32(this.i5);
                                    if(this.i2 <= 93)
                                    {
                                       if(this.i2 <= 44)
                                       {
                                          if(this.i2 != 37)
                                          {
                                             if(this.i2 != 42)
                                             {
                                                if(this.i2 != 43)
                                                {
                                                   §§goto(addr2140);
                                                }
                                                else
                                                {
                                                   §§goto(addr2018);
                                                }
                                             }
                                             else
                                             {
                                                §§goto(addr5136);
                                             }
                                          }
                                          else
                                          {
                                             §§goto(addr5140);
                                          }
                                       }
                                       else if(this.i2 <= 59)
                                       {
                                          if(this.i2 != 45)
                                          {
                                             if(this.i2 != 47)
                                             {
                                                §§goto(addr2140);
                                             }
                                             else
                                             {
                                                §§goto(addr2040);
                                             }
                                          }
                                          else
                                          {
                                             §§goto(addr7701);
                                          }
                                       }
                                       else if(this.i2 != 60)
                                       {
                                          if(this.i2 != 62)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             §§goto(addr2057);
                                          }
                                       }
                                       else
                                       {
                                          §§goto(addr5152);
                                       }
                                    }
                                    else if(this.i2 <= 279)
                                    {
                                       if(this.i2 <= 270)
                                       {
                                          if(this.i2 != 94)
                                          {
                                             if(this.i2 != 257)
                                             {
                                                §§goto(addr2140);
                                             }
                                             else
                                             {
                                                §§goto(addr2084);
                                             }
                                          }
                                          else
                                          {
                                             §§goto(addr5144);
                                          }
                                       }
                                       else if(this.i2 != 271)
                                       {
                                          if(this.i2 != 278)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             §§goto(addr2101);
                                          }
                                       }
                                       else
                                       {
                                          §§goto(addr5160);
                                       }
                                    }
                                    else if(this.i2 <= 281)
                                    {
                                       if(this.i2 != 280)
                                       {
                                          if(this.i2 != 281)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             §§goto(addr2123);
                                          }
                                       }
                                       else
                                       {
                                          §§goto(addr5148);
                                       }
                                    }
                                    else if(this.i2 != 282)
                                    {
                                       if(this.i2 != 283)
                                       {
                                          §§goto(addr2140);
                                       }
                                       else
                                       {
                                          §§goto(addr3037);
                                       }
                                    }
                                    else
                                    {
                                       §§goto(addr5156);
                                    }
                                    §§goto(addr7705);
                                 }
                              }
                              else
                              {
                                 this.i2 = li32(this.i0 + 4);
                                 si32(this.i2,this.i0 + 8);
                                 this.i2 = li32(this.i0 + 24);
                                 this.i6 = this.i0 + 24;
                                 this.i7 = this.i0 + 4;
                                 if(this.i2 == 287)
                                 {
                                    mstate.esp -= 8;
                                    this.i2 = this.i0 + 16;
                                    si32(this.i0,mstate.esp);
                                    si32(this.i2,mstate.esp + 4);
                                    state = 39;
                                    mstate.esp -= 4;
                                    FSM_llex.start();
                                    return;
                                 }
                                 this.i8 = 287;
                                 si32(this.i2,this.i5);
                                 this.f0 = lf64(this.i0 + 28);
                                 sf64(this.f0,this.i0 + 16);
                                 si32(this.i8,this.i6);
                                 §§goto(addr4806);
                              }
                              §§goto(addr5156);
                           }
                           else if(this.i2 <= 283)
                           {
                              if(this.i2 != 275)
                              {
                                 if(this.i2 == 279)
                                 {
                                    this.i6 = li32(this.i0 + 36);
                                    this.i7 = li32(this.i6);
                                    this.i7 = li8(this.i7 + 74);
                                    this.i8 = this.i6;
                                    if(this.i7 == 0)
                                    {
                                       this.i7 = 80;
                                       this.i9 = li32(this.i0 + 52);
                                       mstate.esp -= 12;
                                       this.i10 = mstate.ebp + -96;
                                       this.i9 += 16;
                                       si32(this.i10,mstate.esp);
                                       si32(this.i9,mstate.esp + 4);
                                       si32(this.i7,mstate.esp + 8);
                                       mstate.esp -= 4;
                                       FSM_luaO_chunkid.start();
                                       §§goto(addr2471);
                                    }
                                    else
                                    {
                                       §§goto(addr4183);
                                    }
                                 }
                              }
                              else
                              {
                                 this.i2 = -1;
                                 si32(this.i2,this.i3 + 12);
                                 si32(this.i2,this.i3 + 16);
                                 this.i2 = 2;
                                 si32(this.i2,this.i3);
                                 this.i2 = 0;
                                 si32(this.i2,this.i3 + 4);
                                 this.i2 = li32(this.i0 + 4);
                                 si32(this.i2,this.i0 + 8);
                                 this.i2 = li32(this.i0 + 24);
                                 this.i6 = this.i0 + 24;
                                 if(this.i2 == 287)
                                 {
                                    mstate.esp -= 8;
                                    this.i2 = this.i0 + 16;
                                    si32(this.i0,mstate.esp);
                                    si32(this.i2,mstate.esp + 4);
                                    state = 30;
                                    mstate.esp -= 4;
                                    FSM_llex.start();
                                    return;
                                 }
                                 this.i7 = 287;
                                 si32(this.i2,this.i5);
                                 this.f0 = lf64(this.i0 + 28);
                                 sf64(this.f0,this.i0 + 16);
                                 si32(this.i7,this.i6);
                                 addr3701:
                                 this.i2 = li32(this.i5);
                                 if(this.i2 <= 93)
                                 {
                                    if(this.i2 <= 44)
                                    {
                                       if(this.i2 != 37)
                                       {
                                          if(this.i2 != 42)
                                          {
                                             if(this.i2 != 43)
                                             {
                                                §§goto(addr2140);
                                             }
                                             else
                                             {
                                                §§goto(addr2018);
                                             }
                                          }
                                          else
                                          {
                                             §§goto(addr5136);
                                          }
                                       }
                                       else
                                       {
                                          §§goto(addr5140);
                                       }
                                    }
                                    else if(this.i2 <= 59)
                                    {
                                       if(this.i2 != 45)
                                       {
                                          if(this.i2 != 47)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             §§goto(addr2040);
                                          }
                                       }
                                       else
                                       {
                                          §§goto(addr7701);
                                       }
                                    }
                                    else if(this.i2 != 60)
                                    {
                                       if(this.i2 != 62)
                                       {
                                          §§goto(addr2140);
                                       }
                                       else
                                       {
                                          §§goto(addr2057);
                                       }
                                    }
                                    else
                                    {
                                       §§goto(addr5152);
                                    }
                                 }
                                 else if(this.i2 <= 279)
                                 {
                                    if(this.i2 <= 270)
                                    {
                                       if(this.i2 != 94)
                                       {
                                          if(this.i2 != 257)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             §§goto(addr2084);
                                          }
                                       }
                                       else
                                       {
                                          §§goto(addr5144);
                                       }
                                    }
                                    else if(this.i2 != 271)
                                    {
                                       if(this.i2 != 278)
                                       {
                                          §§goto(addr2140);
                                       }
                                       else
                                       {
                                          §§goto(addr2101);
                                       }
                                    }
                                    else
                                    {
                                       §§goto(addr5160);
                                    }
                                 }
                                 else if(this.i2 <= 281)
                                 {
                                    if(this.i2 != 280)
                                    {
                                       if(this.i2 != 281)
                                       {
                                          §§goto(addr2140);
                                       }
                                       else
                                       {
                                          §§goto(addr2123);
                                       }
                                    }
                                    else
                                    {
                                       §§goto(addr5148);
                                    }
                                 }
                                 else if(this.i2 != 282)
                                 {
                                    if(this.i2 != 283)
                                    {
                                       §§goto(addr2140);
                                    }
                                    else
                                    {
                                       §§goto(addr3037);
                                    }
                                 }
                                 else
                                 {
                                    §§goto(addr5156);
                                 }
                                 §§goto(addr7705);
                              }
                           }
                           else
                           {
                              if(this.i2 == 286)
                              {
                                 this.i2 = 4;
                                 this.i6 = li32(this.i0 + 16);
                                 this.i7 = li32(this.i0 + 36);
                                 si32(this.i6,mstate.ebp + -112);
                                 si32(this.i2,mstate.ebp + -104);
                                 mstate.esp -= 12;
                                 this.i6 = mstate.ebp + -112;
                                 si32(this.i7,mstate.esp);
                                 si32(this.i6,mstate.esp + 4);
                                 si32(this.i6,mstate.esp + 8);
                                 state = 27;
                                 mstate.esp -= 4;
                                 FSM_addk.start();
                                 return;
                              }
                              if(this.i2 == 284)
                              {
                                 this.i2 = -1;
                                 si32(this.i2,this.i3 + 12);
                                 si32(this.i2,this.i3 + 16);
                                 this.i2 = 5;
                                 si32(this.i2,this.i3);
                                 this.i2 = 0;
                                 si32(this.i2,this.i3 + 4);
                                 this.f0 = lf64(this.i0 + 16);
                                 sf64(this.f0,this.i3 + 4);
                                 this.i2 = li32(this.i0 + 4);
                                 si32(this.i2,this.i0 + 8);
                                 this.i2 = li32(this.i0 + 24);
                                 this.i6 = this.i0 + 16;
                                 this.i7 = this.i0 + 24;
                                 if(this.i2 == 287)
                                 {
                                    mstate.esp -= 8;
                                    this.i2 = this.i0 + 16;
                                    si32(this.i0,mstate.esp);
                                    si32(this.i2,mstate.esp + 4);
                                    state = 26;
                                    mstate.esp -= 4;
                                    FSM_llex.start();
                                    return;
                                 }
                                 this.i8 = 287;
                                 si32(this.i2,this.i5);
                                 this.f0 = lf64(this.i0 + 28);
                                 sf64(this.f0,this.i6);
                                 si32(this.i8,this.i7);
                                 addr2919:
                                 this.i2 = li32(this.i5);
                                 if(this.i2 <= 93)
                                 {
                                    if(this.i2 <= 44)
                                    {
                                       if(this.i2 != 37)
                                       {
                                          if(this.i2 != 42)
                                          {
                                             if(this.i2 != 43)
                                             {
                                                §§goto(addr2140);
                                             }
                                             else
                                             {
                                                §§goto(addr2018);
                                             }
                                          }
                                          else
                                          {
                                             §§goto(addr5136);
                                          }
                                       }
                                       else
                                       {
                                          §§goto(addr5140);
                                       }
                                    }
                                    else if(this.i2 <= 59)
                                    {
                                       if(this.i2 != 45)
                                       {
                                          if(this.i2 != 47)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             §§goto(addr2040);
                                          }
                                       }
                                       else
                                       {
                                          §§goto(addr7701);
                                       }
                                    }
                                    else if(this.i2 != 60)
                                    {
                                       if(this.i2 != 62)
                                       {
                                          §§goto(addr2140);
                                       }
                                       else
                                       {
                                          §§goto(addr2057);
                                       }
                                    }
                                    else
                                    {
                                       §§goto(addr5152);
                                    }
                                 }
                                 else if(this.i2 <= 279)
                                 {
                                    if(this.i2 <= 270)
                                    {
                                       if(this.i2 != 94)
                                       {
                                          if(this.i2 != 257)
                                          {
                                             §§goto(addr2140);
                                          }
                                          else
                                          {
                                             §§goto(addr2084);
                                          }
                                       }
                                       else
                                       {
                                          §§goto(addr5144);
                                       }
                                    }
                                    else if(this.i2 != 271)
                                    {
                                       if(this.i2 != 278)
                                       {
                                          §§goto(addr2140);
                                       }
                                       else
                                       {
                                          §§goto(addr2101);
                                       }
                                    }
                                    else
                                    {
                                       §§goto(addr5160);
                                    }
                                 }
                                 else if(this.i2 <= 281)
                                 {
                                    if(this.i2 != 280)
                                    {
                                       if(this.i2 != 281)
                                       {
                                          §§goto(addr2140);
                                       }
                                       else
                                       {
                                          §§goto(addr2123);
                                       }
                                    }
                                    else
                                    {
                                       §§goto(addr5148);
                                    }
                                 }
                                 else if(this.i2 != 282)
                                 {
                                    if(this.i2 != 283)
                                    {
                                       §§goto(addr2140);
                                    }
                                    else
                                    {
                                       §§goto(addr3038);
                                    }
                                 }
                                 else
                                 {
                                    §§goto(addr5156);
                                 }
                                 §§goto(addr7705);
                              }
                           }
                           addr4982:
                           mstate.esp -= 8;
                           si32(this.i0,mstate.esp);
                           si32(this.i3,mstate.esp + 4);
                           state = 41;
                           mstate.esp -= 4;
                           FSM_primaryexp.start();
                           return;
                        }
                        this.i2 = this.i6;
                     }
                     else
                     {
                        this.i2 = 0;
                     }
                  }
                  else
                  {
                     this.i2 = 2;
                  }
                  this.i6 = li32(this.i0 + 4);
                  si32(this.i6,this.i0 + 8);
                  this.i6 = li32(this.i0 + 24);
                  this.i7 = this.i0 + 24;
                  if(this.i6 == 287)
                  {
                     mstate.esp -= 8;
                     this.i6 = this.i0 + 16;
                     si32(this.i0,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  this.i8 = 287;
                  si32(this.i6,this.i5);
                  this.f0 = lf64(this.i0 + 28);
                  sf64(this.f0,this.i0 + 16);
                  si32(this.i8,this.i7);
                  §§goto(addr449);
               }
               break;
            case 3:
               mstate.esp += 8;
               §§goto(addr284);
            case 21:
               addr2471:
               mstate.esp += 12;
               this.i7 = li32(this.i0 + 4);
               this.i9 = li32(this.i1);
               mstate.esp -= 20;
               this.i11 = __2E_str15272;
               this.i12 = __2E_str22116;
               si32(this.i9,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               si32(this.i12,mstate.esp + 16);
               state = 22;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 1:
               mstate.esp += 12;
               this.i2 = li32(this.i0 + 4);
               this.i5 = li32(this.i1);
               mstate.esp -= 20;
               this.i7 = __2E_str15272;
               this.i8 = __2E_str8103;
               si32(this.i5,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               si32(this.i8,mstate.esp + 16);
               state = 2;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i1);
               mstate.esp -= 8;
               this.i5 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 4:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               si32(this.i6,this.i5);
               addr449:
               this.i6 = 8;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_subexpr.start();
               return;
            case 5:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               this.i6 = li32(this.i0 + 36);
               this.i7 = -1;
               si32(this.i7,mstate.ebp + -128);
               si32(this.i7,mstate.ebp + -132);
               this.i7 = 5;
               si32(this.i7,mstate.ebp + -144);
               this.i7 = 0;
               si32(this.i7,mstate.ebp + -140);
               si32(this.i7,mstate.ebp + -136);
               if(this.i2 == 2)
               {
                  mstate.esp -= 8;
                  si32(this.i6,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaK_dischargevars.start();
                  return;
               }
               if(this.i2 == 1)
               {
                  mstate.esp -= 8;
                  si32(this.i6,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaK_dischargevars.start();
                  return;
               }
               if(this.i2 == 0)
               {
                  this.i2 = li32(this.i3);
                  this.i7 = this.i3;
                  if(this.i2 == 5)
                  {
                     this.i2 = li32(this.i3 + 12);
                     if(this.i2 == -1)
                     {
                        this.i2 = li32(this.i3 + 16);
                        if(this.i2 == -1)
                        {
                           this.i2 = mstate.ebp + -144;
                           mstate.esp -= 16;
                           this.i7 = 18;
                           si32(this.i6,mstate.esp);
                           si32(this.i7,mstate.esp + 4);
                           si32(this.i3,mstate.esp + 8);
                           si32(this.i2,mstate.esp + 12);
                           state = 10;
                           mstate.esp -= 4;
                           FSM_codearith.start();
                           return;
                        }
                     }
                  }
                  mstate.esp -= 8;
                  si32(this.i6,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaK_dischargevars.start();
                  return;
               }
               addr1986:
               this.i2 = li32(this.i5);
               if(this.i2 <= 93)
               {
                  if(this.i2 <= 44)
                  {
                     if(this.i2 != 37)
                     {
                        if(this.i2 != 42)
                        {
                           if(this.i2 != 43)
                           {
                              §§goto(addr2141);
                           }
                           else
                           {
                              §§goto(addr2019);
                           }
                        }
                        else
                        {
                           §§goto(addr5136);
                        }
                     }
                     else
                     {
                        §§goto(addr5140);
                     }
                  }
                  else if(this.i2 <= 59)
                  {
                     if(this.i2 != 45)
                     {
                        if(this.i2 != 47)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2041);
                        }
                     }
                     else
                     {
                        §§goto(addr7701);
                     }
                  }
                  else if(this.i2 != 60)
                  {
                     if(this.i2 != 62)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2058);
                     }
                  }
                  else
                  {
                     §§goto(addr5152);
                  }
               }
               else if(this.i2 <= 279)
               {
                  if(this.i2 <= 270)
                  {
                     if(this.i2 != 94)
                     {
                        if(this.i2 != 257)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2085);
                        }
                     }
                     else
                     {
                        §§goto(addr5144);
                     }
                  }
                  else if(this.i2 != 271)
                  {
                     if(this.i2 != 278)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2102);
                     }
                  }
                  else
                  {
                     §§goto(addr5160);
                  }
               }
               else if(this.i2 <= 281)
               {
                  if(this.i2 != 280)
                  {
                     if(this.i2 != 281)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2124);
                     }
                  }
                  else
                  {
                     §§goto(addr5148);
                  }
               }
               else if(this.i2 != 282)
               {
                  if(this.i2 != 283)
                  {
                     §§goto(addr2141);
                  }
                  else
                  {
                     §§goto(addr3038);
                  }
               }
               else
               {
                  §§goto(addr5156);
               }
               §§goto(addr7705);
               break;
            case 6:
               mstate.esp += 8;
               this.i2 = li32(this.i7);
               if(this.i2 == 12)
               {
                  this.i2 = li32(this.i3 + 12);
                  this.i7 = li32(this.i3 + 16);
                  this.i8 = li32(this.i3 + 4);
                  if(this.i2 != this.i7)
                  {
                     this.i2 = li8(this.i6 + 50);
                     if(this.i8 >= this.i2)
                     {
                        mstate.esp -= 12;
                        si32(this.i6,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        si32(this.i8,mstate.esp + 8);
                        state = 7;
                        mstate.esp -= 4;
                        FSM_exp2reg.start();
                        return;
                     }
                  }
                  else
                  {
                     §§goto(addr777);
                  }
               }
               mstate.esp -= 8;
               si32(this.i6,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 7:
               mstate.esp += 12;
               §§goto(addr777);
            case 8:
               mstate.esp += 8;
               addr777:
               this.i2 = mstate.ebp + -144;
               mstate.esp -= 16;
               this.i7 = 18;
               si32(this.i6,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 9;
               mstate.esp -= 4;
               FSM_codearith.start();
               return;
            case 9:
               mstate.esp += 16;
               §§goto(addr1986);
            case 10:
               mstate.esp += 16;
               §§goto(addr1986);
            case 11:
               mstate.esp += 8;
               this.i2 = li32(this.i3);
               this.i7 = this.i3;
               if(this.i2 <= 3)
               {
                  if(this.i2 != 1)
                  {
                     if(this.i2 != 2)
                     {
                        if(this.i2 != 3)
                        {
                           addr1439:
                           this.i2 = li32(this.i3 + 16);
                           this.i7 = li32(this.i3 + 12);
                           si32(this.i7,this.i3 + 16);
                           si32(this.i2,this.i3 + 12);
                           this.i2 = this.i3 + 12;
                           if(this.i7 != -1)
                           {
                              this.i8 = this.i6;
                              loop0:
                              while(true)
                              {
                                 this.i9 = 255;
                                 this.i10 = li32(this.i8);
                                 this.i10 = li32(this.i10 + 12);
                                 mstate.esp -= 12;
                                 si32(this.i10,mstate.esp);
                                 si32(this.i7,mstate.esp + 4);
                                 si32(this.i9,mstate.esp + 8);
                                 mstate.esp -= 4;
                                 FSM_patchtestreg395396.start();
                                 addr1533:
                                 while(true)
                                 {
                                    this.i9 = mstate.eax;
                                    mstate.esp += 12;
                                    this.i9 = li32(this.i8);
                                    this.i9 = li32(this.i9 + 12);
                                    this.i10 = this.i7 << 2;
                                    this.i9 += this.i10;
                                    this.i9 = li32(this.i9);
                                    this.i9 >>>= 14;
                                    this.i9 += -131071;
                                    if(this.i9 == -1)
                                    {
                                       this.i7 = -1;
                                    }
                                    else
                                    {
                                       this.i7 += this.i9;
                                       this.i7 += 1;
                                    }
                                    if(this.i7 == -1)
                                    {
                                       break;
                                    }
                                    continue loop0;
                                 }
                              }
                           }
                           this.i2 = li32(this.i2);
                           if(this.i2 != -1)
                           {
                              loop1:
                              while(true)
                              {
                                 this.i7 = 255;
                                 this.i8 = li32(this.i6);
                                 this.i8 = li32(this.i8 + 12);
                                 mstate.esp -= 12;
                                 si32(this.i8,mstate.esp);
                                 si32(this.i2,mstate.esp + 4);
                                 si32(this.i7,mstate.esp + 8);
                                 mstate.esp -= 4;
                                 FSM_patchtestreg395396.start();
                                 addr1675:
                                 while(true)
                                 {
                                    this.i7 = mstate.eax;
                                    mstate.esp += 12;
                                    this.i7 = li32(this.i6);
                                    this.i7 = li32(this.i7 + 12);
                                    this.i8 = this.i2 << 2;
                                    this.i7 += this.i8;
                                    this.i7 = li32(this.i7);
                                    this.i7 >>>= 14;
                                    this.i7 += -131071;
                                    if(this.i7 == -1)
                                    {
                                       this.i2 = -1;
                                    }
                                    else
                                    {
                                       this.i2 += this.i7;
                                       this.i2 += 1;
                                    }
                                    if(this.i2 == -1)
                                    {
                                       break;
                                    }
                                    continue loop1;
                                 }
                              }
                           }
                           §§goto(addr1986);
                        }
                     }
                     else
                     {
                        addr1055:
                        this.i2 = 3;
                        si32(this.i2,this.i7);
                     }
                     §§goto(addr1439);
                  }
                  this.i2 = 2;
                  si32(this.i2,this.i7);
               }
               else if(this.i2 <= 10)
               {
                  this.i8 = this.i2 + -4;
                  if(uint(this.i8) >= uint(2))
                  {
                     if(this.i2 == 10)
                     {
                        this.i2 = li32(this.i3 + 4);
                        this.i7 = li32(this.i6);
                        this.i7 = li32(this.i7 + 12);
                        this.i8 = this.i2 << 2;
                        this.i8 = this.i7 + this.i8;
                        if(this.i2 <= 0)
                        {
                           this.i2 = this.i8;
                        }
                        else
                        {
                           this.i9 = _luaP_opmodes;
                           this.i2 <<= 2;
                           this.i2 += this.i7;
                           this.i7 = li32(this.i2 + -4);
                           this.i7 &= 63;
                           this.i7 = this.i9 + this.i7;
                           this.i7 = li8(this.i7);
                           this.i7 <<= 24;
                           this.i7 >>= 24;
                           this.i2 += -4;
                           this.i2 = this.i7 > -1 ? int(this.i8) : int(this.i2);
                        }
                        this.i7 = li32(this.i2);
                        this.i8 = this.i7 & 16320;
                        this.i8 = this.i8 == 0 ? 64 : 0;
                        this.i7 &= -16321;
                        this.i7 = this.i8 | this.i7;
                        si32(this.i7,this.i2);
                     }
                  }
                  else
                  {
                     §§goto(addr1055);
                  }
               }
               else
               {
                  if(this.i2 == 11)
                  {
                     this.i2 = 1;
                     mstate.esp -= 8;
                     si32(this.i6,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 12;
                     mstate.esp -= 4;
                     FSM_luaK_checkstack.start();
                     return;
                  }
                  if(this.i2 == 12)
                  {
                     §§goto(addr1280);
                  }
               }
               §§goto(addr1439);
            case 14:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,this.i3 + 4);
               si32(this.i2,this.i7);
               §§goto(addr1439);
            case 15:
               §§goto(addr1533);
            case 16:
               §§goto(addr1675);
            case 12:
               mstate.esp += 8;
               this.i2 = li32(this.i6 + 36);
               this.i8 = this.i2 + 1;
               si32(this.i8,this.i6 + 36);
               mstate.esp -= 12;
               si32(this.i6,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_discharge2reg.start();
               return;
            case 13:
               mstate.esp += 12;
               addr1280:
               this.i2 = li32(this.i7);
               if(this.i2 == 12)
               {
                  this.i2 = li32(this.i3 + 4);
                  this.i8 = this.i2 & 256;
                  if(this.i8 == 0)
                  {
                     this.i8 = li8(this.i6 + 50);
                     if(this.i8 <= this.i2)
                     {
                        this.i2 = li32(this.i6 + 36);
                        this.i2 += -1;
                        si32(this.i2,this.i6 + 36);
                     }
                  }
               }
               this.i2 = 11;
               this.i8 = li32(this.i6 + 12);
               this.i9 = li32(this.i3 + 4);
               this.i8 = li32(this.i8 + 8);
               this.i9 <<= 23;
               mstate.esp -= 12;
               this.i9 |= 19;
               si32(this.i6,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 17:
               mstate.esp += 8;
               this.i2 = li32(this.i3);
               if(this.i2 == 12)
               {
                  this.i2 = li32(this.i3 + 12);
                  this.i7 = li32(this.i3 + 16);
                  this.i8 = li32(this.i3 + 4);
                  if(this.i2 != this.i7)
                  {
                     this.i2 = li8(this.i6 + 50);
                     if(this.i8 >= this.i2)
                     {
                        mstate.esp -= 12;
                        si32(this.i6,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        si32(this.i8,mstate.esp + 8);
                        state = 18;
                        mstate.esp -= 4;
                        FSM_exp2reg.start();
                        return;
                     }
                  }
                  else
                  {
                     §§goto(addr1926);
                  }
               }
               mstate.esp -= 8;
               si32(this.i6,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 19;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 18:
               mstate.esp += 12;
               §§goto(addr1926);
            case 19:
               mstate.esp += 8;
               addr1926:
               this.i2 = mstate.ebp + -144;
               mstate.esp -= 16;
               this.i7 = 20;
               si32(this.i6,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 20;
               mstate.esp -= 4;
               FSM_codearith.start();
               return;
            case 20:
               mstate.esp += 16;
               §§goto(addr1986);
            case 22:
               this.i7 = mstate.eax;
               mstate.esp += 20;
               if(this.i2 != 0)
               {
                  this.i9 = this.i2 + -284;
                  if(uint(this.i9) <= uint(2))
                  {
                     this.i2 = 0;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 23;
                     mstate.esp -= 4;
                     FSM_save.start();
                     return;
                  }
                  this.i9 = __2E_str35292;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 32;
                  mstate.esp -= 4;
                  FSM_luaX_token2str.start();
                  return;
               }
               this.i2 = 3;
               this.i7 = li32(this.i1);
               mstate.esp -= 8;
               si32(this.i7,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 35;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
               break;
            case 23:
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 48);
               this.i2 = li32(this.i2);
               this.i9 = li32(this.i1);
               mstate.esp -= 16;
               this.i10 = __2E_str35292;
               si32(this.i9,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 24;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 24:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i1);
               mstate.esp -= 8;
               this.i7 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               state = 25;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 25:
               mstate.esp += 8;
               §§goto(addr4183);
            case 26:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               si32(this.i2,this.i5);
               §§goto(addr2919);
            case 27:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               this.i7 = -1;
               si32(this.i7,this.i3 + 12);
               si32(this.i7,this.i3 + 16);
               si32(this.i2,this.i3);
               si32(this.i6,this.i3 + 4);
               this.i2 = li32(this.i0 + 4);
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i0 + 24);
               this.i6 = this.i0 + 16;
               this.i7 = this.i0 + 24;
               if(this.i2 == 287)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 28;
                  mstate.esp -= 4;
                  FSM_llex.start();
                  return;
               }
               this.i6 = 287;
               si32(this.i2,this.i5);
               this.f0 = lf64(this.i0 + 28);
               sf64(this.f0,this.i0 + 16);
               si32(this.i6,this.i7);
               addr3268:
               this.i2 = li32(this.i5);
               if(this.i2 <= 93)
               {
                  if(this.i2 <= 44)
                  {
                     if(this.i2 != 37)
                     {
                        if(this.i2 != 42)
                        {
                           if(this.i2 != 43)
                           {
                              §§goto(addr2141);
                           }
                           else
                           {
                              §§goto(addr2019);
                           }
                        }
                        else
                        {
                           §§goto(addr5136);
                        }
                     }
                     else
                     {
                        §§goto(addr5140);
                     }
                  }
                  else if(this.i2 <= 59)
                  {
                     if(this.i2 != 45)
                     {
                        if(this.i2 != 47)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2041);
                        }
                     }
                     else
                     {
                        §§goto(addr7701);
                     }
                  }
                  else if(this.i2 != 60)
                  {
                     if(this.i2 != 62)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2058);
                     }
                  }
                  else
                  {
                     §§goto(addr5152);
                  }
               }
               else if(this.i2 <= 279)
               {
                  if(this.i2 <= 270)
                  {
                     if(this.i2 != 94)
                     {
                        if(this.i2 != 257)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2085);
                        }
                     }
                     else
                     {
                        §§goto(addr5144);
                     }
                  }
                  else if(this.i2 != 271)
                  {
                     if(this.i2 != 278)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2102);
                     }
                  }
                  else
                  {
                     §§goto(addr5160);
                  }
               }
               else if(this.i2 <= 281)
               {
                  if(this.i2 != 280)
                  {
                     if(this.i2 != 281)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2124);
                     }
                  }
                  else
                  {
                     §§goto(addr5148);
                  }
               }
               else if(this.i2 != 282)
               {
                  if(this.i2 != 283)
                  {
                     §§goto(addr2141);
                  }
                  else
                  {
                     §§goto(addr3038);
                  }
               }
               else
               {
                  §§goto(addr5156);
               }
               §§goto(addr7705);
               break;
            case 28:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               si32(this.i2,this.i5);
               §§goto(addr3268);
            case 29:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               si32(this.i2,this.i5);
               §§goto(addr3437);
            case 30:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               si32(this.i2,this.i5);
               §§goto(addr3701);
            case 31:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               si32(this.i2,this.i5);
               §§goto(addr3870);
            case 32:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i10 = li32(this.i1);
               mstate.esp -= 16;
               si32(this.i10,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 33;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 33:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i1);
               mstate.esp -= 8;
               this.i7 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               state = 34;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 34:
               mstate.esp += 8;
               §§goto(addr4183);
            case 35:
               mstate.esp += 8;
               addr4183:
               this.i2 = 8388645;
               this.i6 = li32(this.i6);
               this.i7 = li8(this.i6 + 74);
               this.i7 &= -5;
               si8(this.i7,this.i6 + 74);
               this.i6 = li32(this.i8 + 12);
               this.i6 = li32(this.i6 + 8);
               mstate.esp -= 12;
               si32(this.i8,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 36;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 36:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i6 = -1;
               si32(this.i6,this.i3 + 12);
               si32(this.i6,this.i3 + 16);
               this.i6 = 14;
               si32(this.i6,this.i3);
               si32(this.i2,this.i3 + 4);
               this.i2 = li32(this.i0 + 4);
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i0 + 24);
               this.i6 = this.i0 + 24;
               if(this.i2 == 287)
               {
                  mstate.esp -= 8;
                  this.i2 = this.i0 + 16;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 37;
                  mstate.esp -= 4;
                  FSM_llex.start();
                  return;
               }
               this.i7 = 287;
               si32(this.i2,this.i5);
               this.f0 = lf64(this.i0 + 28);
               sf64(this.f0,this.i0 + 16);
               si32(this.i7,this.i6);
               addr4417:
               this.i2 = li32(this.i5);
               if(this.i2 <= 93)
               {
                  if(this.i2 <= 44)
                  {
                     if(this.i2 != 37)
                     {
                        if(this.i2 != 42)
                        {
                           if(this.i2 != 43)
                           {
                              §§goto(addr2141);
                           }
                           else
                           {
                              §§goto(addr2019);
                           }
                        }
                        else
                        {
                           §§goto(addr5136);
                        }
                     }
                     else
                     {
                        §§goto(addr5140);
                     }
                  }
                  else if(this.i2 <= 59)
                  {
                     if(this.i2 != 45)
                     {
                        if(this.i2 != 47)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2041);
                        }
                     }
                     else
                     {
                        §§goto(addr7701);
                     }
                  }
                  else if(this.i2 != 60)
                  {
                     if(this.i2 != 62)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2058);
                     }
                  }
                  else
                  {
                     §§goto(addr5152);
                  }
               }
               else if(this.i2 <= 279)
               {
                  if(this.i2 <= 270)
                  {
                     if(this.i2 != 94)
                     {
                        if(this.i2 != 257)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2085);
                        }
                     }
                     else
                     {
                        §§goto(addr5144);
                     }
                  }
                  else if(this.i2 != 271)
                  {
                     if(this.i2 != 278)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2102);
                     }
                  }
                  else
                  {
                     §§goto(addr5160);
                  }
               }
               else if(this.i2 <= 281)
               {
                  if(this.i2 != 280)
                  {
                     if(this.i2 != 281)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2124);
                     }
                  }
                  else
                  {
                     §§goto(addr5148);
                  }
               }
               else if(this.i2 != 282)
               {
                  if(this.i2 != 283)
                  {
                     §§goto(addr2141);
                  }
                  else
                  {
                     §§goto(addr3038);
                  }
               }
               else
               {
                  §§goto(addr5156);
               }
               §§goto(addr7705);
               break;
            case 37:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               si32(this.i2,this.i5);
               §§goto(addr4417);
            case 38:
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               if(this.i2 <= 93)
               {
                  if(this.i2 <= 44)
                  {
                     if(this.i2 != 37)
                     {
                        if(this.i2 != 42)
                        {
                           if(this.i2 != 43)
                           {
                              §§goto(addr2141);
                           }
                           else
                           {
                              §§goto(addr2019);
                           }
                        }
                        else
                        {
                           §§goto(addr5136);
                        }
                     }
                     else
                     {
                        §§goto(addr5140);
                     }
                  }
                  else if(this.i2 <= 59)
                  {
                     if(this.i2 != 45)
                     {
                        if(this.i2 != 47)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2041);
                        }
                     }
                     else
                     {
                        §§goto(addr7701);
                     }
                  }
                  else if(this.i2 != 60)
                  {
                     if(this.i2 != 62)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2058);
                     }
                  }
                  else
                  {
                     §§goto(addr5152);
                  }
               }
               else if(this.i2 <= 279)
               {
                  if(this.i2 <= 270)
                  {
                     if(this.i2 != 94)
                     {
                        if(this.i2 != 257)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2085);
                        }
                     }
                     else
                     {
                        §§goto(addr5144);
                     }
                  }
                  else if(this.i2 != 271)
                  {
                     if(this.i2 != 278)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2102);
                     }
                  }
                  else
                  {
                     §§goto(addr5160);
                  }
               }
               else if(this.i2 <= 281)
               {
                  if(this.i2 != 280)
                  {
                     if(this.i2 != 281)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2124);
                     }
                  }
                  else
                  {
                     §§goto(addr5148);
                  }
               }
               else if(this.i2 != 282)
               {
                  if(this.i2 != 283)
                  {
                     §§goto(addr2141);
                  }
                  else
                  {
                     §§goto(addr3038);
                  }
               }
               else
               {
                  §§goto(addr5156);
               }
               §§goto(addr7705);
            case 39:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               si32(this.i2,this.i5);
               addr4806:
               this.i2 = 0;
               this.i6 = li32(this.i7);
               mstate.esp -= 16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 40;
               mstate.esp -= 4;
               FSM_body.start();
               return;
            case 40:
               mstate.esp += 16;
               this.i2 = li32(this.i5);
               if(this.i2 <= 93)
               {
                  if(this.i2 <= 44)
                  {
                     if(this.i2 != 37)
                     {
                        if(this.i2 != 42)
                        {
                           if(this.i2 != 43)
                           {
                              §§goto(addr2141);
                           }
                           else
                           {
                              §§goto(addr2019);
                           }
                        }
                        else
                        {
                           §§goto(addr5136);
                        }
                     }
                     else
                     {
                        §§goto(addr5140);
                     }
                  }
                  else if(this.i2 <= 59)
                  {
                     if(this.i2 != 45)
                     {
                        if(this.i2 != 47)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2041);
                        }
                     }
                     else
                     {
                        §§goto(addr7701);
                     }
                  }
                  else if(this.i2 != 60)
                  {
                     if(this.i2 != 62)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2058);
                     }
                  }
                  else
                  {
                     §§goto(addr5152);
                  }
               }
               else if(this.i2 <= 279)
               {
                  if(this.i2 <= 270)
                  {
                     if(this.i2 != 94)
                     {
                        if(this.i2 != 257)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2085);
                        }
                     }
                     else
                     {
                        §§goto(addr5144);
                     }
                  }
                  else if(this.i2 != 271)
                  {
                     if(this.i2 != 278)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2102);
                     }
                  }
                  else
                  {
                     §§goto(addr5160);
                  }
               }
               else if(this.i2 <= 281)
               {
                  if(this.i2 != 280)
                  {
                     if(this.i2 != 281)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2124);
                     }
                  }
                  else
                  {
                     §§goto(addr5148);
                  }
               }
               else if(this.i2 != 282)
               {
                  if(this.i2 != 283)
                  {
                     §§goto(addr2141);
                  }
                  else
                  {
                     §§goto(addr3038);
                  }
               }
               else
               {
                  §§goto(addr5156);
               }
               §§goto(addr7705);
            case 41:
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               if(this.i2 <= 93)
               {
                  if(this.i2 <= 44)
                  {
                     if(this.i2 != 37)
                     {
                        if(this.i2 != 42)
                        {
                           if(this.i2 != 43)
                           {
                              §§goto(addr2141);
                           }
                           else
                           {
                              §§goto(addr2019);
                           }
                        }
                        else
                        {
                           §§goto(addr5136);
                        }
                     }
                     else
                     {
                        §§goto(addr5140);
                     }
                  }
                  else if(this.i2 <= 59)
                  {
                     if(this.i2 != 45)
                     {
                        if(this.i2 != 47)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2041);
                        }
                     }
                     else
                     {
                        §§goto(addr7701);
                     }
                  }
                  else if(this.i2 != 60)
                  {
                     if(this.i2 != 62)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2058);
                     }
                  }
                  else
                  {
                     §§goto(addr5152);
                  }
               }
               else if(this.i2 <= 279)
               {
                  if(this.i2 <= 270)
                  {
                     if(this.i2 != 94)
                     {
                        if(this.i2 != 257)
                        {
                           §§goto(addr2141);
                        }
                        else
                        {
                           §§goto(addr2085);
                        }
                     }
                     else
                     {
                        §§goto(addr5144);
                     }
                  }
                  else if(this.i2 != 271)
                  {
                     if(this.i2 != 278)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2102);
                     }
                  }
                  else
                  {
                     §§goto(addr5160);
                  }
               }
               else if(this.i2 <= 281)
               {
                  if(this.i2 != 280)
                  {
                     if(this.i2 != 281)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr2124);
                     }
                  }
                  else
                  {
                     §§goto(addr5148);
                  }
               }
               else
               {
                  if(this.i2 != 282)
                  {
                     if(this.i2 != 283)
                     {
                        §§goto(addr2141);
                     }
                     else
                     {
                        §§goto(addr3038);
                     }
                     mstate.esp = mstate.ebp;
                     mstate.ebp = li32(mstate.esp);
                     mstate.esp += 4;
                     mstate.esp += 4;
                     mstate.gworker = caller;
                     return;
                  }
                  §§goto(addr5156);
               }
               §§goto(addr7705);
            case 42:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               si32(this.i6,this.i5);
               addr5277:
               this.i6 = li32(this.i0 + 36);
               this.i7 = this.i0 + 36;
               if(this.i2 <= 12)
               {
                  if(uint(this.i2) < uint(6))
                  {
                     this.i8 = li32(this.i3);
                     if(this.i8 == 5)
                     {
                        this.i8 = li32(this.i3 + 12);
                        if(this.i8 == -1)
                        {
                           this.i8 = li32(this.i3 + 16);
                           if(this.i8 == -1)
                           {
                              break;
                           }
                        }
                     }
                     mstate.esp -= 8;
                     si32(this.i6,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 51;
                     mstate.esp -= 4;
                     FSM_luaK_exp2RK.start();
                     return;
                  }
                  if(this.i2 == 6)
                  {
                     mstate.esp -= 8;
                     si32(this.i6,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 43;
                     mstate.esp -= 4;
                     FSM_luaK_exp2nextreg.start();
                     return;
                  }
               }
               else
               {
                  if(this.i2 == 14)
                  {
                     mstate.esp -= 8;
                     si32(this.i6,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 45;
                     mstate.esp -= 4;
                     FSM_luaK_dischargevars.start();
                     return;
                  }
                  if(this.i2 == 13)
                  {
                     mstate.esp -= 8;
                     si32(this.i6,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 44;
                     mstate.esp -= 4;
                     FSM_luaK_goiftrue.start();
                     return;
                  }
               }
               mstate.esp -= 8;
               si32(this.i6,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 52;
               mstate.esp -= 4;
               FSM_luaK_exp2RK.start();
               return;
            case 43:
               mstate.esp += 8;
               break;
            case 44:
               mstate.esp += 8;
               break;
            case 45:
               mstate.esp += 8;
               this.i8 = li32(this.i3);
               if(this.i8 <= 2)
               {
                  if(this.i8 != 1)
                  {
                     if(this.i8 == 2)
                     {
                        this.i8 = -1;
                        this.i9 = li32(this.i6 + 32);
                        si32(this.i8,this.i6 + 32);
                        this.i8 = li32(this.i6 + 12);
                        this.i8 = li32(this.i8 + 8);
                        mstate.esp -= 12;
                        this.i10 = 2147450902;
                        si32(this.i6,mstate.esp);
                        si32(this.i10,mstate.esp + 4);
                        si32(this.i8,mstate.esp + 8);
                        state = 46;
                        mstate.esp -= 4;
                        FSM_luaK_code.start();
                        return;
                     }
                     §§goto(addr5625);
                  }
                  else
                  {
                     addr5613:
                     this.i8 = -1;
                  }
               }
               else if(this.i8 != 10)
               {
                  if(this.i8 != 3)
                  {
                     addr5625:
                     this.i8 = 1;
                     mstate.esp -= 12;
                     si32(this.i6,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     si32(this.i8,mstate.esp + 8);
                     state = 48;
                     mstate.esp -= 4;
                     FSM_jumponcond.start();
                     return;
                  }
                  §§goto(addr5613);
               }
               else
               {
                  this.i8 = li32(this.i3 + 4);
               }
               §§goto(addr5676);
            case 46:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               si32(this.i8,mstate.ebp + -4);
               mstate.esp -= 12;
               this.i8 = mstate.ebp + -4;
               si32(this.i6,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 47;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 47:
               mstate.esp += 12;
               this.i8 = li32(mstate.ebp + -4);
               §§goto(addr5676);
            case 48:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               addr5676:
               this.i9 = -1;
               mstate.esp -= 12;
               this.i10 = this.i3 + 12;
               si32(this.i6,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 49;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 49:
               mstate.esp += 12;
               this.i8 = li32(this.i3 + 16);
               this.i10 = li32(this.i6 + 24);
               si32(this.i10,this.i6 + 28);
               mstate.esp -= 12;
               this.i10 = this.i6 + 32;
               si32(this.i6,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 50;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 50:
               mstate.esp += 12;
               si32(this.i9,this.i3 + 16);
               break;
            case 51:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               break;
            case 52:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               break;
            case 53:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               this.i7 = li32(this.i7);
               if(this.i2 <= 6)
               {
                  if(this.i2 <= 2)
                  {
                     if(this.i2 == 0)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 16;
                        this.i8 = 12;
                        si32(this.i7,mstate.esp);
                        si32(this.i8,mstate.esp + 4);
                        si32(this.i3,mstate.esp + 8);
                        si32(this.i2,mstate.esp + 12);
                        state = 66;
                        mstate.esp -= 4;
                        FSM_codearith.start();
                        return;
                     }
                     if(this.i2 == 1)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 16;
                        this.i8 = 13;
                        si32(this.i7,mstate.esp);
                        si32(this.i8,mstate.esp + 4);
                        si32(this.i3,mstate.esp + 8);
                        si32(this.i2,mstate.esp + 12);
                        state = 67;
                        mstate.esp -= 4;
                        FSM_codearith.start();
                        return;
                     }
                     if(this.i2 == 2)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 16;
                        this.i8 = 14;
                        si32(this.i7,mstate.esp);
                        si32(this.i8,mstate.esp + 4);
                        si32(this.i3,mstate.esp + 8);
                        si32(this.i2,mstate.esp + 12);
                        state = 54;
                        mstate.esp -= 4;
                        FSM_codearith.start();
                        return;
                     }
                  }
                  else if(this.i2 <= 4)
                  {
                     if(this.i2 == 3)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 16;
                        this.i8 = 15;
                        si32(this.i7,mstate.esp);
                        si32(this.i8,mstate.esp + 4);
                        si32(this.i3,mstate.esp + 8);
                        si32(this.i2,mstate.esp + 12);
                        state = 68;
                        mstate.esp -= 4;
                        FSM_codearith.start();
                        return;
                     }
                     if(this.i2 == 4)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 16;
                        this.i8 = 16;
                        si32(this.i7,mstate.esp);
                        si32(this.i8,mstate.esp + 4);
                        si32(this.i3,mstate.esp + 8);
                        si32(this.i2,mstate.esp + 12);
                        state = 55;
                        mstate.esp -= 4;
                        FSM_codearith.start();
                        return;
                     }
                  }
                  else
                  {
                     if(this.i2 == 5)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 16;
                        this.i8 = 17;
                        si32(this.i7,mstate.esp);
                        si32(this.i8,mstate.esp + 4);
                        si32(this.i3,mstate.esp + 8);
                        si32(this.i2,mstate.esp + 12);
                        state = 69;
                        mstate.esp -= 4;
                        FSM_codearith.start();
                        return;
                     }
                     if(this.i2 == 6)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 8;
                        si32(this.i7,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        state = 56;
                        mstate.esp -= 4;
                        FSM_luaK_exp2val.start();
                        return;
                     }
                  }
               }
               else if(this.i2 <= 10)
               {
                  if(this.i2 <= 8)
                  {
                     if(this.i2 == 7)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 20;
                        this.i8 = 0;
                        this.i9 = 23;
                        si32(this.i7,mstate.esp);
                        si32(this.i9,mstate.esp + 4);
                        si32(this.i8,mstate.esp + 8);
                        si32(this.i3,mstate.esp + 12);
                        si32(this.i2,mstate.esp + 16);
                        state = 70;
                        mstate.esp -= 4;
                        FSM_codecomp.start();
                        return;
                     }
                     if(this.i2 == 8)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 20;
                        this.i8 = 1;
                        this.i9 = 23;
                        si32(this.i7,mstate.esp);
                        si32(this.i9,mstate.esp + 4);
                        si32(this.i8,mstate.esp + 8);
                        si32(this.i3,mstate.esp + 12);
                        si32(this.i2,mstate.esp + 16);
                        state = 57;
                        mstate.esp -= 4;
                        FSM_codecomp.start();
                        return;
                     }
                  }
                  else
                  {
                     if(this.i2 == 9)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 20;
                        this.i8 = 1;
                        this.i9 = 24;
                        si32(this.i7,mstate.esp);
                        si32(this.i9,mstate.esp + 4);
                        si32(this.i8,mstate.esp + 8);
                        si32(this.i3,mstate.esp + 12);
                        si32(this.i2,mstate.esp + 16);
                        state = 71;
                        mstate.esp -= 4;
                        FSM_codecomp.start();
                        return;
                     }
                     if(this.i2 == 10)
                     {
                        this.i2 = mstate.ebp + -256;
                        mstate.esp -= 20;
                        this.i8 = 1;
                        this.i9 = 25;
                        si32(this.i7,mstate.esp);
                        si32(this.i9,mstate.esp + 4);
                        si32(this.i8,mstate.esp + 8);
                        si32(this.i3,mstate.esp + 12);
                        si32(this.i2,mstate.esp + 16);
                        state = 58;
                        mstate.esp -= 4;
                        FSM_codecomp.start();
                        return;
                     }
                  }
               }
               else if(this.i2 <= 12)
               {
                  if(this.i2 == 11)
                  {
                     this.i2 = mstate.ebp + -256;
                     mstate.esp -= 20;
                     this.i8 = 0;
                     this.i9 = 24;
                     si32(this.i7,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     si32(this.i8,mstate.esp + 8);
                     si32(this.i3,mstate.esp + 12);
                     si32(this.i2,mstate.esp + 16);
                     state = 72;
                     mstate.esp -= 4;
                     FSM_codecomp.start();
                     return;
                  }
                  if(this.i2 == 12)
                  {
                     this.i2 = mstate.ebp + -256;
                     mstate.esp -= 20;
                     this.i8 = 0;
                     this.i9 = 25;
                     si32(this.i7,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     si32(this.i8,mstate.esp + 8);
                     si32(this.i3,mstate.esp + 12);
                     si32(this.i2,mstate.esp + 16);
                     state = 59;
                     mstate.esp -= 4;
                     FSM_codecomp.start();
                     return;
                  }
               }
               else
               {
                  if(this.i2 == 13)
                  {
                     this.i2 = mstate.ebp + -256;
                     mstate.esp -= 8;
                     si32(this.i7,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 60;
                     mstate.esp -= 4;
                     FSM_luaK_dischargevars.start();
                     return;
                  }
                  if(this.i2 == 14)
                  {
                     this.i2 = mstate.ebp + -256;
                     mstate.esp -= 8;
                     si32(this.i7,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 62;
                     mstate.esp -= 4;
                     FSM_luaK_dischargevars.start();
                     return;
                  }
               }
               this.i2 = this.i6;
               §§goto(addr2019);
            case 54:
               mstate.esp += 16;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 55:
               mstate.esp += 16;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 56:
               mstate.esp += 8;
               this.i2 = li32(mstate.ebp + -256);
               if(this.i2 == 11)
               {
                  this.i2 = mstate.ebp + -256;
                  this.i8 = li32(this.i7);
                  this.i9 = li32(mstate.ebp + -252);
                  this.i10 = li32(this.i8 + 12);
                  this.i9 <<= 2;
                  this.i9 = this.i10 + this.i9;
                  this.i9 = li32(this.i9);
                  this.i2 += 4;
                  this.i8 += 12;
                  this.i9 &= 63;
                  if(this.i9 == 21)
                  {
                     this.i9 = li32(this.i3);
                     this.i10 = this.i3;
                     if(this.i9 == 12)
                     {
                        this.i9 = li32(this.i3 + 4);
                        this.i11 = this.i9 & 256;
                        if(this.i11 == 0)
                        {
                           this.i11 = li8(this.i7 + 50);
                           if(this.i11 <= this.i9)
                           {
                              this.i9 = li32(this.i7 + 36);
                              this.i9 += -1;
                              si32(this.i9,this.i7 + 36);
                           }
                        }
                     }
                     this.i7 = 11;
                     this.i9 = li32(this.i2);
                     this.i8 = li32(this.i8);
                     this.i9 <<= 2;
                     this.i8 += this.i9;
                     this.i9 = li32(this.i8);
                     this.i11 = li32(this.i3 + 4);
                     this.i11 <<= 23;
                     this.i9 &= 8388607;
                     this.i9 = this.i11 | this.i9;
                     si32(this.i9,this.i8);
                     si32(this.i7,this.i10);
                     this.i2 = li32(this.i2);
                     si32(this.i2,this.i3 + 4);
                     this.i2 = this.i6;
                     §§goto(addr2019);
                  }
               }
               this.i2 = mstate.ebp + -256;
               mstate.esp -= 8;
               si32(this.i7,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 64;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 57:
               mstate.esp += 20;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 58:
               mstate.esp += 20;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 59:
               mstate.esp += 20;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 60:
               mstate.esp += 8;
               this.i8 = li32(this.i3 + 16);
               mstate.esp -= 12;
               this.i2 += 16;
               si32(this.i7,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 61;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 61:
               mstate.esp += 12;
               this.i2 = li32(mstate.ebp + -256);
               si32(this.i2,this.i3);
               this.i2 = li32(mstate.ebp + -252);
               si32(this.i2,this.i3 + 4);
               this.i2 = li32(mstate.ebp + -248);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(mstate.ebp + -244);
               si32(this.i2,this.i3 + 12);
               this.i2 = li32(mstate.ebp + -240);
               si32(this.i2,this.i3 + 16);
               this.i2 = this.i6;
               §§goto(addr2019);
            case 62:
               mstate.esp += 8;
               this.i8 = li32(this.i3 + 12);
               mstate.esp -= 12;
               this.i2 += 12;
               si32(this.i7,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 63;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 63:
               mstate.esp += 12;
               this.i2 = li32(mstate.ebp + -256);
               si32(this.i2,this.i3);
               this.i2 = li32(mstate.ebp + -252);
               si32(this.i2,this.i3 + 4);
               this.i2 = li32(mstate.ebp + -248);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(mstate.ebp + -244);
               si32(this.i2,this.i3 + 12);
               this.i2 = li32(mstate.ebp + -240);
               si32(this.i2,this.i3 + 16);
               this.i2 = this.i6;
               §§goto(addr2019);
            case 64:
               mstate.esp += 8;
               mstate.esp -= 16;
               this.i8 = 21;
               si32(this.i7,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 65;
               mstate.esp -= 4;
               FSM_codearith.start();
               return;
            case 65:
               mstate.esp += 16;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 66:
               mstate.esp += 16;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 67:
               mstate.esp += 16;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 68:
               mstate.esp += 16;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 69:
               mstate.esp += 16;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 70:
               mstate.esp += 20;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 71:
               mstate.esp += 20;
               this.i2 = this.i6;
               §§goto(addr2019);
            case 72:
               mstate.esp += 20;
               this.i2 = this.i6;
               §§goto(addr2019);
            default:
               throw "Invalid state in _subexpr";
         }
         this.i6 = _priority;
         this.i8 = this.i2 << 1;
         this.i6 += this.i8;
         this.i6 = li8(this.i6 + 1);
         mstate.esp -= 12;
         this.i8 = mstate.ebp + -256;
         si32(this.i0,mstate.esp);
         si32(this.i8,mstate.esp + 4);
         si32(this.i6,mstate.esp + 8);
         state = 53;
         mstate.esp -= 4;
         FSM_subexpr.start();
      }
   }
}
