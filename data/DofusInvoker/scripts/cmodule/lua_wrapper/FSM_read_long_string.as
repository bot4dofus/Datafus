package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_read_long_string extends Machine
   {
      
      public static const intRegCount:int = 17;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
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
      
      public function FSM_read_long_string()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_read_long_string = null;
         _loc1_ = new FSM_read_long_string();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop2:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 200;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_save.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i1 = li32(this.i0 + 44);
               this.i2 = li32(this.i1);
               this.i3 = this.i2 + -1;
               si32(this.i3,this.i1);
               this.i1 = li32(this.i0 + 44);
               this.i3 = this.i0 + 44;
               this.i4 = li32(mstate.ebp + 12);
               this.i5 = li32(mstate.ebp + 16);
               this.i6 = this.i0;
               if(this.i2 == 0)
               {
                  this.i2 = mstate.ebp + -200;
                  this.i7 = li32(this.i1 + 16);
                  this.i8 = li32(this.i1 + 8);
                  this.i9 = li32(this.i1 + 12);
                  mstate.esp -= 12;
                  si32(this.i7,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  mstate.funcs[this.i8]();
                  return;
               }
               this.i2 = li32(this.i1 + 4);
               this.i7 = li8(this.i2);
               this.i2 += 1;
               si32(this.i2,this.i1 + 4);
               si32(this.i7,this.i6);
               if(this.i7 != 10)
               {
                  if(this.i7 != 13)
                  {
                     addr365:
                     this.i1 = __2E_str39295;
                     this.i2 = __2E_str38294;
                     this.i1 = this.i4 == 0 ? int(this.i1) : int(this.i2);
                     this.i2 = mstate.ebp + -192;
                     this.i7 = this.i0 + 40;
                     this.i8 = this.i0 + 4;
                     this.i9 = mstate.ebp + -96;
                     this.i10 = this.i0 + 52;
                     this.i11 = this.i0 + 48;
                     this.i12 = li32(this.i6);
                     if(this.i12 <= 12)
                     {
                        if(this.i12 != -1)
                        {
                           if(this.i12 != 10)
                           {
                              addr2392:
                              if(this.i4 != 0)
                              {
                                 §§goto(addr2400);
                              }
                              else
                              {
                                 while(true)
                                 {
                                    this.i12 = li32(this.i3);
                                    this.i13 = li32(this.i12);
                                    this.i14 = this.i13 + -1;
                                    si32(this.i14,this.i12);
                                    this.i12 = li32(this.i3);
                                    if(this.i13 != 0)
                                    {
                                       this.i13 = li32(this.i12 + 4);
                                       this.i14 = li8(this.i13);
                                       this.i13 += 1;
                                       si32(this.i13,this.i12 + 4);
                                       si32(this.i14,this.i6);
                                       if(this.i14 <= 12)
                                       {
                                          if(this.i14 == -1)
                                          {
                                             this.i12 = 80;
                                             this.i13 = li32(this.i10);
                                             mstate.esp -= 12;
                                             this.i13 += 16;
                                             si32(this.i2,mstate.esp);
                                          }
                                          else
                                          {
                                             addr581:
                                             addr580:
                                          }
                                          if(this.i14 == 10)
                                          {
                                             break;
                                          }
                                          continue;
                                          si32(this.i13,mstate.esp + 4);
                                          si32(this.i12,mstate.esp + 8);
                                          mstate.esp -= 4;
                                          FSM_luaO_chunkid.start();
                                          break loop2;
                                       }
                                       if(this.i14 != 13)
                                       {
                                          if(this.i14 != 91)
                                          {
                                             if(this.i14 == 93)
                                             {
                                                mstate.esp -= 4;
                                                si32(this.i0,mstate.esp);
                                                state = 22;
                                             }
                                             else
                                             {
                                                addr1840:
                                                addr1839:
                                             }
                                             continue;
                                             mstate.esp -= 4;
                                             FSM_skip_sep.start();
                                             return;
                                          }
                                          addr908:
                                          addr907:
                                          if(this.i5 == 0)
                                          {
                                             §§goto(addr916);
                                          }
                                          mstate.esp -= 4;
                                          si32(this.i0,mstate.esp);
                                          state = 19;
                                          mstate.esp -= 4;
                                          FSM_skip_sep.start();
                                          return;
                                       }
                                       break;
                                    }
                                    this.i13 = mstate.ebp + -100;
                                    this.i14 = li32(this.i12 + 16);
                                    this.i15 = li32(this.i12 + 8);
                                    this.i16 = li32(this.i12 + 12);
                                    mstate.esp -= 12;
                                    si32(this.i14,mstate.esp);
                                    si32(this.i16,mstate.esp + 4);
                                    si32(this.i13,mstate.esp + 8);
                                    state = 28;
                                    mstate.esp -= 4;
                                    mstate.funcs[this.i15]();
                                    return;
                                 }
                                 addr446:
                              }
                              addr579:
                           }
                           if(this.i4 != 0)
                           {
                              this.i12 = 10;
                              mstate.esp -= 8;
                              si32(this.i0,mstate.esp);
                              si32(this.i12,mstate.esp + 4);
                              state = 30;
                              mstate.esp -= 4;
                              FSM_save.start();
                              return;
                           }
                           §§goto(addr456);
                        }
                        §§goto(addr581);
                     }
                     else if(this.i12 != 13)
                     {
                        if(this.i12 != 91)
                        {
                           if(this.i12 != 93)
                           {
                              §§goto(addr579);
                           }
                           §§goto(addr1840);
                        }
                        §§goto(addr908);
                     }
                     §§goto(addr446);
                  }
               }
               §§goto(addr335);
               break;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i2 != 0)
               {
                  this.i7 = li32(mstate.ebp + -200);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i1);
                     si32(this.i2,this.i1 + 4);
                     this.i7 = li8(this.i2);
                     this.i2 += 1;
                     si32(this.i2,this.i1 + 4);
                     this.i1 = this.i7;
                  }
                  else
                  {
                     addr263:
                     this.i1 = -1;
                  }
                  si32(this.i1,this.i6);
                  if(this.i1 != 10)
                  {
                     if(this.i1 != 13)
                     {
                        §§goto(addr365);
                     }
                  }
                  addr335:
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_inclinenumber.start();
                  return;
               }
               §§goto(addr263);
            case 3:
               mstate.esp += 4;
               §§goto(addr365);
            case 5:
               mstate.esp += 4;
               this.i12 = li32(this.i11);
               this.i13 = 0;
               si32(this.i13,this.i12 + 4);
               this.i12 = li32(this.i6);
               if(this.i12 > 12)
               {
                  if(this.i12 != 13)
                  {
                     if(this.i12 != 91)
                     {
                        if(this.i12 != 93)
                        {
                           §§goto(addr2391);
                        }
                        §§goto(addr1839);
                     }
                     §§goto(addr907);
                  }
                  else
                  {
                     §§goto(addr455);
                  }
                  state = 4;
                  mstate.esp -= 4;
                  FSM_save.start();
                  return;
               }
               if(this.i12 != -1)
               {
                  if(this.i12 != 10)
                  {
                     addr2391:
                     §§goto(addr2392);
                  }
                  else
                  {
                     addr455:
                  }
                  §§goto(addr456);
               }
               §§goto(addr581);
               §§goto(addr455);
            case 10:
               mstate.esp += 8;
               this.i12 = li32(this.i6);
               if(this.i12 <= 12)
               {
                  if(this.i12 != -1)
                  {
                     if(this.i12 != 10)
                     {
                        addr906:
                        §§goto(addr2392);
                     }
                     §§goto(addr446);
                  }
                  §§goto(addr580);
               }
               else if(this.i12 != 13)
               {
                  if(this.i12 != 91)
                  {
                     if(this.i12 != 93)
                     {
                        §§goto(addr906);
                     }
                     §§goto(addr1840);
                  }
                  §§goto(addr908);
               }
               §§goto(addr446);
            case 11:
               this.i12 = mstate.eax;
               mstate.esp += 4;
               if(this.i12 == this.i5)
               {
                  this.i12 = li32(this.i6);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i12,mstate.esp + 4);
                  state = 12;
                  mstate.esp -= 4;
                  FSM_save.start();
                  return;
               }
               addr423:
               §§goto(addr365);
               break;
            case 17:
               mstate.esp += 8;
               this.i12 = li32(this.i6);
               if(this.i12 <= 12)
               {
                  if(this.i12 != -1)
                  {
                     if(this.i12 != 10)
                     {
                        addr1398:
                        §§goto(addr2392);
                     }
                     §§goto(addr446);
                  }
                  §§goto(addr581);
               }
               else if(this.i12 != 13)
               {
                  if(this.i12 != 91)
                  {
                     if(this.i12 != 93)
                     {
                        §§goto(addr1398);
                     }
                     §§goto(addr1840);
                  }
                  addr916:
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_skip_sep.start();
                  return;
               }
               §§goto(addr446);
            case 19:
               this.i12 = mstate.eax;
               mstate.esp += 4;
               if(this.i12 == this.i5)
               {
                  this.i12 = li32(this.i6);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i12,mstate.esp + 4);
                  state = 20;
                  mstate.esp -= 4;
                  FSM_save.start();
                  return;
               }
               §§goto(addr423);
               break;
            case 20:
               mstate.esp += 8;
               this.i12 = li32(this.i3);
               this.i13 = li32(this.i12);
               this.i14 = this.i13 + -1;
               si32(this.i14,this.i12);
               this.i12 = li32(this.i3);
               if(this.i13 == 0)
               {
                  this.i13 = mstate.ebp + -8;
                  this.i14 = li32(this.i12 + 16);
                  this.i15 = li32(this.i12 + 8);
                  this.i16 = li32(this.i12 + 12);
                  mstate.esp -= 12;
                  si32(this.i14,mstate.esp);
                  si32(this.i16,mstate.esp + 4);
                  si32(this.i13,mstate.esp + 8);
                  state = 21;
                  mstate.esp -= 4;
                  mstate.funcs[this.i15]();
                  return;
               }
               this.i13 = li32(this.i12 + 4);
               this.i14 = li8(this.i13);
               this.i13 += 1;
               si32(this.i13,this.i12 + 4);
               si32(this.i14,this.i6);
               §§goto(addr423);
               break;
            case 21:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               if(this.i13 != 0)
               {
                  this.i14 = li32(mstate.ebp + -8);
                  if(this.i14 != 0)
                  {
                     this.i14 += -1;
                     si32(this.i14,this.i12);
                     si32(this.i13,this.i12 + 4);
                     this.i14 = li8(this.i13);
                     this.i13 += 1;
                     si32(this.i13,this.i12 + 4);
                     this.i12 = this.i14;
                  }
                  else
                  {
                     addr1777:
                     this.i12 = -1;
                  }
                  si32(this.i12,this.i6);
                  §§goto(addr423);
               }
               §§goto(addr1777);
            case 22:
               this.i12 = mstate.eax;
               mstate.esp += 4;
               if(this.i12 == this.i5)
               {
                  this.i1 = li32(this.i6);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 23;
                  mstate.esp -= 4;
                  FSM_save.start();
                  return;
               }
               §§goto(addr423);
               break;
            case 27:
               mstate.esp += 8;
               this.i12 = li32(this.i3);
               this.i13 = li32(this.i12);
               this.i14 = this.i13 + -1;
               si32(this.i14,this.i12);
               this.i12 = li32(this.i3);
               if(this.i13 == 0)
               {
                  this.i13 = mstate.ebp + -196;
                  this.i14 = li32(this.i12 + 16);
                  this.i15 = li32(this.i12 + 8);
                  this.i16 = li32(this.i12 + 12);
                  mstate.esp -= 12;
                  si32(this.i14,mstate.esp);
                  si32(this.i16,mstate.esp + 4);
                  si32(this.i13,mstate.esp + 8);
                  state = 29;
                  mstate.esp -= 4;
                  mstate.funcs[this.i15]();
                  return;
               }
               this.i13 = li32(this.i12 + 4);
               this.i14 = li8(this.i13);
               this.i13 += 1;
               si32(this.i13,this.i12 + 4);
               si32(this.i14,this.i6);
               if(this.i14 <= 12)
               {
                  if(this.i14 != -1)
                  {
                     if(this.i14 != 10)
                     {
                        §§goto(addr2807);
                     }
                  }
                  else
                  {
                     §§goto(addr581);
                  }
               }
               else if(this.i14 != 13)
               {
                  if(this.i14 != 91)
                  {
                     if(this.i14 != 93)
                     {
                        §§goto(addr2807);
                     }
                     else
                     {
                        §§goto(addr1840);
                     }
                  }
                  else
                  {
                     §§goto(addr908);
                  }
               }
               §§goto(addr446);
               break;
            case 28:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               if(this.i13 != 0)
               {
                  this.i14 = li32(mstate.ebp + -100);
                  if(this.i14 != 0)
                  {
                     this.i14 += -1;
                     si32(this.i14,this.i12);
                     si32(this.i13,this.i12 + 4);
                     this.i14 = li8(this.i13);
                     this.i13 += 1;
                     si32(this.i13,this.i12 + 4);
                     this.i12 = this.i14;
                  }
                  else
                  {
                     addr2699:
                     this.i12 = -1;
                  }
                  si32(this.i12,this.i6);
                  if(this.i12 <= 12)
                  {
                     if(this.i12 != -1)
                     {
                        if(this.i12 != 10)
                        {
                           §§goto(addr2517);
                        }
                        §§goto(addr446);
                     }
                     §§goto(addr581);
                  }
                  else if(this.i12 != 13)
                  {
                     if(this.i12 != 91)
                     {
                        if(this.i12 != 93)
                        {
                           §§goto(addr2517);
                        }
                        §§goto(addr1840);
                     }
                     §§goto(addr908);
                  }
                  §§goto(addr446);
               }
               §§goto(addr2699);
            case 29:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               if(this.i13 != 0)
               {
                  this.i14 = li32(mstate.ebp + -196);
                  if(this.i14 != 0)
                  {
                     this.i14 += -1;
                     si32(this.i14,this.i12);
                     si32(this.i13,this.i12 + 4);
                     this.i14 = li8(this.i13);
                     this.i13 += 1;
                     si32(this.i13,this.i12 + 4);
                     this.i12 = this.i14;
                  }
                  else
                  {
                     addr2900:
                     this.i12 = -1;
                  }
                  si32(this.i12,this.i6);
                  if(this.i12 <= 12)
                  {
                     if(this.i12 != -1)
                     {
                        if(this.i12 != 10)
                        {
                           §§goto(addr2992);
                        }
                     }
                     else
                     {
                        §§goto(addr581);
                     }
                  }
                  else if(this.i12 != 13)
                  {
                     if(this.i12 != 91)
                     {
                        if(this.i12 != 93)
                        {
                           addr2992:
                           addr2807:
                           this.i12 = this.i14;
                           addr2400:
                           mstate.esp -= 8;
                           si32(this.i0,mstate.esp);
                           si32(this.i12,mstate.esp + 4);
                           state = 27;
                           mstate.esp -= 4;
                           FSM_save.start();
                           return;
                        }
                        §§goto(addr1840);
                     }
                     else
                     {
                        §§goto(addr908);
                     }
                  }
                  §§goto(addr446);
               }
               §§goto(addr2900);
            case 31:
               mstate.esp += 4;
               §§goto(addr423);
            case 6:
               break;
            case 4:
               mstate.esp += 8;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 5;
               mstate.esp -= 4;
               FSM_inclinenumber.start();
               return;
            case 7:
               this.i12 = mstate.eax;
               mstate.esp += 20;
               mstate.esp -= 8;
               this.i13 = 287;
               si32(this.i0,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_luaX_token2str.start();
               return;
            case 8:
               this.i13 = mstate.eax;
               mstate.esp += 8;
               this.i14 = li32(this.i7);
               mstate.esp -= 16;
               this.i15 = __2E_str35292;
               si32(this.i14,mstate.esp);
               si32(this.i15,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               si32(this.i13,mstate.esp + 12);
               state = 9;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 9:
               this.i12 = mstate.eax;
               mstate.esp += 16;
               this.i12 = li32(this.i7);
               mstate.esp -= 8;
               this.i13 = 3;
               si32(this.i12,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               state = 10;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 12:
               mstate.esp += 8;
               this.i12 = li32(this.i3);
               this.i13 = li32(this.i12);
               this.i14 = this.i13 + -1;
               si32(this.i14,this.i12);
               this.i12 = li32(this.i3);
               if(this.i13 == 0)
               {
                  this.i13 = mstate.ebp + -12;
                  this.i14 = li32(this.i12 + 16);
                  this.i15 = li32(this.i12 + 8);
                  this.i16 = li32(this.i12 + 12);
                  mstate.esp -= 12;
                  si32(this.i14,mstate.esp);
                  si32(this.i16,mstate.esp + 4);
                  si32(this.i13,mstate.esp + 8);
                  state = 18;
                  mstate.esp -= 4;
                  mstate.funcs[this.i15]();
                  return;
               }
               this.i13 = li32(this.i12 + 4);
               this.i14 = li8(this.i13);
               this.i13 += 1;
               si32(this.i13,this.i12 + 4);
               this.i12 = this.i14;
               addr1064:
               this.i13 = 80;
               si32(this.i12,this.i6);
               this.i12 = li32(this.i10);
               mstate.esp -= 12;
               this.i12 += 16;
               si32(this.i9,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i13,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
               break;
            case 18:
               this.i13 = mstate.eax;
               mstate.esp += 12;
               if(this.i13 != 0)
               {
                  this.i14 = li32(mstate.ebp + -12);
                  if(this.i14 != 0)
                  {
                     this.i14 += -1;
                     si32(this.i14,this.i12);
                     si32(this.i13,this.i12 + 4);
                     this.i14 = li8(this.i13);
                     this.i13 += 1;
                     si32(this.i13,this.i12 + 4);
                     this.i12 = this.i14;
                  }
                  else
                  {
                     addr1487:
                     this.i12 = -1;
                  }
                  §§goto(addr1064);
               }
               §§goto(addr1487);
            case 13:
               mstate.esp += 12;
               this.i12 = li32(this.i8);
               this.i13 = li32(this.i7);
               mstate.esp -= 20;
               this.i14 = __2E_str15272;
               this.i15 = __2E_str40296;
               this.i16 = mstate.ebp + -96;
               si32(this.i13,mstate.esp);
               si32(this.i14,mstate.esp + 4);
               si32(this.i16,mstate.esp + 8);
               si32(this.i12,mstate.esp + 12);
               si32(this.i15,mstate.esp + 16);
               state = 14;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 14:
               this.i12 = mstate.eax;
               mstate.esp += 20;
               mstate.esp -= 8;
               this.i13 = 91;
               si32(this.i0,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               state = 15;
               mstate.esp -= 4;
               FSM_luaX_token2str.start();
               return;
            case 15:
               this.i13 = mstate.eax;
               mstate.esp += 8;
               this.i14 = li32(this.i7);
               mstate.esp -= 16;
               this.i15 = __2E_str35292;
               si32(this.i14,mstate.esp);
               si32(this.i15,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               si32(this.i13,mstate.esp + 12);
               state = 16;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 16:
               this.i12 = mstate.eax;
               mstate.esp += 16;
               this.i12 = li32(this.i7);
               mstate.esp -= 8;
               this.i13 = 3;
               si32(this.i12,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               state = 17;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 23:
               mstate.esp += 8;
               this.i1 = li32(this.i3);
               this.i2 = li32(this.i1);
               this.i8 = this.i2 + -1;
               si32(this.i8,this.i1);
               this.i1 = li32(this.i3);
               if(this.i2 == 0)
               {
                  this.i2 = mstate.ebp + -4;
                  this.i3 = li32(this.i1 + 16);
                  this.i8 = li32(this.i1 + 8);
                  this.i9 = li32(this.i1 + 12);
                  mstate.esp -= 12;
                  si32(this.i3,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 26;
                  mstate.esp -= 4;
                  mstate.funcs[this.i8]();
                  return;
               }
               this.i2 = li32(this.i1 + 4);
               this.i3 = li8(this.i2);
               this.i2 += 1;
               si32(this.i2,this.i1 + 4);
               si32(this.i3,this.i6);
               if(this.i4 != 0)
               {
                  §§goto(addr1992);
               }
               else
               {
                  §§goto(addr2351);
               }
               break;
            case 24:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i0 + 36);
               this.i0 = li32(this.i0 + 4);
               mstate.esp -= 12;
               si32(this.i3,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 25;
               mstate.esp -= 4;
               FSM_luaH_setstr.start();
               return;
            case 25:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i0 + 8);
               this.i3 = this.i0 + 8;
               if(this.i2 == 0)
               {
                  this.i2 = 1;
                  si32(this.i2,this.i0);
                  si32(this.i2,this.i3);
               }
               si32(this.i1,this.i4);
               §§goto(addr2351);
            case 26:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i2 != 0)
               {
                  this.i3 = li32(mstate.ebp + -4);
                  if(this.i3 != 0)
                  {
                     this.i3 += -1;
                     si32(this.i3,this.i1);
                     si32(this.i2,this.i1 + 4);
                     this.i3 = li8(this.i2);
                     this.i2 += 1;
                     si32(this.i2,this.i1 + 4);
                     this.i1 = this.i3;
                  }
                  else
                  {
                     addr2284:
                     this.i1 = -1;
                  }
                  si32(this.i1,this.i6);
                  if(this.i4 != 0)
                  {
                     addr1992:
                     this.i1 = li32(this.i11);
                     this.i2 = li32(this.i1);
                     this.i1 = li32(this.i1 + 4);
                     this.i3 = li32(this.i7);
                     this.i6 = this.i5 << 1;
                     this.i1 -= this.i6;
                     this.i2 = this.i5 + this.i2;
                     mstate.esp -= 12;
                     this.i1 += -4;
                     this.i2 += 2;
                     si32(this.i3,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i1,mstate.esp + 8);
                     state = 24;
                     mstate.esp -= 4;
                     FSM_luaS_newlstr.start();
                     return;
                  }
                  addr2351:
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  mstate.gworker = caller;
                  return;
               }
               §§goto(addr2284);
            case 30:
               mstate.esp += 8;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 31;
               mstate.esp -= 4;
               FSM_inclinenumber.start();
               return;
            default:
               throw "Invalid state in _read_long_string";
         }
         mstate.esp += 12;
         this.i12 = li32(this.i8);
         this.i13 = li32(this.i7);
         mstate.esp -= 20;
         this.i14 = __2E_str15272;
         this.i15 = mstate.ebp + -192;
         si32(this.i13,mstate.esp);
         si32(this.i14,mstate.esp + 4);
         si32(this.i15,mstate.esp + 8);
         si32(this.i12,mstate.esp + 12);
         si32(this.i1,mstate.esp + 16);
         state = 7;
         mstate.esp -= 4;
         FSM_luaO_pushfstring.start();
      }
   }
}
