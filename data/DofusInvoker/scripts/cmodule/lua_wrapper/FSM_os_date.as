package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_os_date extends Machine
   {
      
      public static const intRegCount:int = 32;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i21:int;
      
      public var i30:int;
      
      public var i31:int;
      
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
      
      public var i25:int;
      
      public var i26:int;
      
      public var i27:int;
      
      public var i20:int;
      
      public var i9:int;
      
      public var i28:int;
      
      public var i29:int;
      
      public function FSM_os_date()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_os_date = null;
         _loc1_ = new FSM_os_date();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop13:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 1548;
               this.i0 = 1;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 >= 1)
                  {
                     this.i0 = 0;
                     mstate.esp -= 12;
                     this.i2 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaL_checklstring.start();
                     return;
                  }
               }
               this.i0 = __2E_str19367;
               addr157:
               this.i2 = 2;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr157);
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 > 0)
                  {
                     this.i2 = 2;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_luaL_checknumber.start();
                     return;
                  }
               }
               mstate.esp -= 4;
               FSM_time.start();
            case 4:
               this.i2 = mstate.eax;
               this.i3 = li8(this.i0);
               if(this.i3 != 33)
               {
                  §§goto(addr245);
               }
               else
               {
                  addr376:
                  this.i3 = li8(_gmt_is_set_2E_b);
                  if(this.i3 == 0)
                  {
                     this.i3 = 1;
                     si8(this.i3,_gmt_is_set_2E_b);
                     mstate.esp -= 8;
                     this.i3 = _gmt;
                     this.i4 = _gmtmem;
                     si32(this.i3,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     state = 8;
                     mstate.esp -= 4;
                     FSM_tzload.start();
                     return;
                  }
                  addr508:
                  this.i3 = _gmtmem;
                  mstate.esp -= 16;
                  this.i4 = _tm;
                  this.i5 = 0;
                  si32(this.i2,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  si32(this.i4,mstate.esp + 12);
                  mstate.esp -= 4;
                  FSM_timesub398.start();
               }
               break;
            case 7:
               this.f0 = mstate.st0;
               mstate.esp += 8;
               this.i2 = li8(this.i0);
               this.i3 = int(this.f0);
               if(this.i2 != 33)
               {
                  this.i2 = this.i3;
                  addr245:
                  this.i3 = _tm;
                  state = 5;
                  mstate.esp -= 4;
                  FSM_tzset_basic.start();
                  return;
               }
               this.i2 = this.i3;
               §§goto(addr376);
               break;
            case 8:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               if(this.i3 != 0)
               {
                  this.i3 = _gmt;
                  mstate.esp -= 12;
                  this.i4 = _gmtmem;
                  this.i5 = 1;
                  si32(this.i3,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_tzparse.start();
                  return;
               }
               §§goto(addr508);
               break;
            case 9:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr508);
            case 10:
               mstate.esp += 16;
               this.i2 = this.i3 + 6988;
               si32(this.i2,_tm + 40);
               this.i0 += 1;
               addr586:
               this.i2 = li8(this.i0);
               this.i3 = this.i0;
               if(this.i2 == 42)
               {
                  this.i4 = __2E_str16398;
                  this.i5 = 0;
                  while(true)
                  {
                     this.i6 = this.i4 + this.i5;
                     this.i6 += 1;
                     this.i2 &= 255;
                     if(this.i2 != 0)
                     {
                        this.i2 = this.i3 + this.i5;
                        this.i2 = li8(this.i2 + 1);
                        this.i6 = li8(this.i6);
                        this.i5 += 1;
                        if(this.i2 != this.i6)
                        {
                           this.i3 = __2E_str16398;
                           this.i3 += this.i5;
                           this.i3 = li8(this.i3);
                           this.i2 &= 255;
                           if(this.i2 == this.i3)
                           {
                              break;
                           }
                           this.i2 = 37;
                           si8(this.i2,mstate.ebp + -288);
                           this.i2 = 0;
                           this.i3 = mstate.ebp + -1328;
                           si8(this.i2,mstate.ebp + -286);
                           si32(this.i1,mstate.ebp + -1320);
                        }
                        else
                        {
                           addr682:
                        }
                        continue;
                        this.i1 = this.i3 + 12;
                        si32(this.i1,mstate.ebp + -1328);
                        si32(this.i2,mstate.ebp + -1324);
                        this.i1 = li8(this.i0);
                        this.i2 = this.i3 + 4;
                        si32(this.i2,mstate.ebp + -1548);
                        this.i2 = this.i3 + 8;
                        this.i4 = mstate.ebp + -288;
                        if(this.i1 != 0)
                        {
                           this.i1 = mstate.ebp + -272;
                           this.i5 = mstate.ebp + -240;
                           this.i6 = mstate.ebp + -208;
                           this.i7 = mstate.ebp + -176;
                           this.i8 = mstate.ebp + -248;
                           this.i9 = mstate.ebp + -216;
                           this.i10 = mstate.ebp + -184;
                           this.i11 = mstate.ebp + -152;
                           this.i12 = mstate.ebp + -1328;
                           this.i13 = mstate.ebp + -1536;
                           this.i14 = mstate.ebp + -288;
                           this.i12 += 1036;
                           this.i15 = this.i1 + 4;
                           this.i16 = this.i1 + 8;
                           this.i17 = this.i8 + 4;
                           this.i18 = this.i5 + 4;
                           this.i19 = this.i5 + 8;
                           this.i20 = this.i9 + 4;
                           this.i21 = this.i6 + 4;
                           this.i22 = this.i6 + 8;
                           this.i23 = this.i10 + 4;
                           this.i24 = this.i7 + 4;
                           this.i25 = this.i7 + 8;
                           this.i26 = this.i11 + 4;
                           this.i27 = this.i13 + 200;
                           this.i14 += 1;
                           this.i28 = this.i13;
                           loop1:
                           while(true)
                           {
                              this.i29 = li8(this.i0);
                              if(this.i29 == 37)
                              {
                                 this.i29 = li8(this.i0 + 1);
                                 if(this.i29 != 0)
                                 {
                                    this.i30 = 0;
                                    si8(this.i29,this.i14);
                                    state = 41;
                                    mstate.esp -= 4;
                                    FSM_tzset_basic.start();
                                    return;
                                 }
                              }
                              this.i29 = li32(this.i3);
                              if(uint(this.i29) >= uint(this.i12))
                              {
                                 this.i29 = mstate.ebp + -1328;
                                 mstate.esp -= 4;
                                 si32(this.i29,mstate.esp);
                                 state = 39;
                                 mstate.esp -= 4;
                                 FSM_emptybuffer.start();
                                 return;
                              }
                              addr3671:
                              while(true)
                              {
                                 this.i29 = li32(this.i3);
                                 this.i30 = li8(this.i0);
                                 si8(this.i30,this.i29);
                                 this.i29 += 1;
                                 si32(this.i29,this.i3);
                                 this.i29 = li8(this.i0 + 1);
                                 this.i0 += 1;
                                 if(this.i29 == 0)
                                 {
                                    break loop13;
                                 }
                                 continue loop1;
                              }
                           }
                           break loop13;
                        }
                        break loop13;
                     }
                     break;
                  }
                  this.i0 = 9;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_lua_createtable.start();
                  return;
               }
               this.i3 = __2E_str16398;
               §§goto(addr682);
            case 5:
               mstate.esp -= 12;
               this.i4 = 0;
               si32(this.i2,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_localsub399.start();
            case 6:
               mstate.esp += 12;
               §§goto(addr586);
            case 11:
               mstate.esp += 8;
               this.i0 = li32(_tm);
               this.i2 = li32(this.i1 + 8);
               this.f0 = Number(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = 3;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 12:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str17399;
               this.i3 = this.i1 + 8;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str17399;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 13:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -16);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -8);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 14;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 14:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i2 = this.i0 + -12;
               si32(this.i2,this.i3);
               this.i2 = li32(_tm + 4);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + -12);
               this.i2 = 3;
               si32(this.i2,this.i0 + -4);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 15:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str17365;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str17365;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -32);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -24);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 17;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 17:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i2 = this.i0 + -12;
               si32(this.i2,this.i3);
               this.i2 = li32(_tm + 8);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + -12);
               this.i2 = 3;
               si32(this.i2,this.i0 + -4);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 18:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str19401;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str19401;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 19:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -48);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -40);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -48;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 20;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 20:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i2 = this.i0 + -12;
               si32(this.i2,this.i3);
               this.i2 = li32(_tm + 12);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + -12);
               this.i2 = 3;
               si32(this.i2,this.i0 + -4);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 21:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str20402;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str20402;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 22:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -64);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -56);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -64;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 23;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 23:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i2 = this.i0 + -12;
               si32(this.i2,this.i3);
               this.i2 = li32(_tm + 16);
               this.i2 += 1;
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + -12);
               this.i2 = 3;
               si32(this.i2,this.i0 + -4);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 24:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str21403;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str21403;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 25;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 25:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -80);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -72);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -80;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 26;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 26:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i2 = this.i0 + -12;
               si32(this.i2,this.i3);
               this.i2 = li32(_tm + 20);
               this.i2 += 1900;
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + -12);
               this.i2 = 3;
               si32(this.i2,this.i0 + -4);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 27:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str22404;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str22404;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 28;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 28:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -96);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -88);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -96;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 29;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 29:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i2 = this.i0 + -12;
               si32(this.i2,this.i3);
               this.i2 = li32(_tm + 24);
               this.i2 += 1;
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + -12);
               this.i2 = 3;
               si32(this.i2,this.i0 + -4);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 30:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str23405;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str23405;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 31;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 31:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -112);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -104);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -112;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 32;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 32:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i2 = this.i0 + -12;
               si32(this.i2,this.i3);
               this.i2 = li32(_tm + 28);
               this.i2 += 1;
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + -12);
               this.i2 = 3;
               si32(this.i2,this.i0 + -4);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 33:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str24406;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str24406;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 34;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 34:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -128);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -120);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -128;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 35;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 35:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i2 = this.i0 + -12;
               si32(this.i2,this.i3);
               this.i4 = li32(_tm + 32);
               if(this.i4 >= 0)
               {
                  this.i5 = 1;
                  this.i4 = this.i4 != 0 ? 1 : 0;
                  this.i4 &= 1;
                  si32(this.i4,this.i2);
                  si32(this.i5,this.i0 + -4);
                  this.i0 = li32(this.i3);
                  this.i0 += 12;
                  si32(this.i0,this.i3);
                  mstate.esp -= 8;
                  this.i0 = -2;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  §§goto(addr5584);
               }
            case 36:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str25407;
               while(true)
               {
                  this.i4 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i5 = this.i2;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i5;
               }
               this.i4 = __2E_str25407;
               mstate.esp -= 12;
               this.i2 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 37;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 37:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -144);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -136);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -144;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 38;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 38:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i0 += -12;
               si32(this.i0,this.i3);
               §§goto(addr5584);
            case 39:
               this.i29 = mstate.eax;
               mstate.esp += 4;
               if(this.i29 != 0)
               {
                  this.i29 = mstate.ebp + -1328;
                  mstate.esp -= 4;
                  si32(this.i29,mstate.esp);
                  state = 40;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr3671);
               break;
            case 40:
               mstate.esp += 4;
               §§goto(addr3671);
            case 41:
               si32(this.i30,mstate.ebp + -276);
               mstate.esp -= 16;
               this.i29 = mstate.ebp + -276;
               si32(this.i4,mstate.esp);
               si32(this.i28,mstate.esp + 4);
               si32(this.i27,mstate.esp + 8);
               si32(this.i29,mstate.esp + 12);
               state = 42;
               mstate.esp -= 4;
               FSM__fmt.start();
               return;
            case 42:
               this.i29 = mstate.eax;
               mstate.esp += 16;
               this.i30 = li32(mstate.ebp + -276);
               if(this.i30 != 0)
               {
                  this.i30 = __2E_str20368;
                  mstate.esp -= 4;
                  si32(this.i30,mstate.esp);
                  mstate.esp -= 4;
                  FSM_getenv.start();
                  addr3841:
                  this.i30 = mstate.eax;
                  mstate.esp += 4;
                  if(this.i30 != 0)
                  {
                     this.i30 = li32(___sF + 184);
                     this.i30 += -1;
                     si32(this.i30,___sF + 184);
                     if(this.i30 <= -1)
                     {
                        this.i31 = li32(___sF + 200);
                        if(this.i30 < this.i31)
                        {
                           this.i30 = ___sF;
                           mstate.esp -= 8;
                           this.i30 += 176;
                           this.i31 = 10;
                           si32(this.i31,mstate.esp);
                           si32(this.i30,mstate.esp + 4);
                           state = 45;
                           mstate.esp -= 4;
                           FSM___swbuf.start();
                           return;
                        }
                        this.i30 = 10;
                        this.i31 = li32(___sF + 176);
                        si8(this.i30,this.i31);
                        this.i30 = li32(___sF + 176);
                        this.i31 = li8(this.i30);
                        if(this.i31 == 10)
                        {
                           this.i30 = ___sF;
                           mstate.esp -= 8;
                           this.i30 += 176;
                           this.i31 = 10;
                           si32(this.i31,mstate.esp);
                           si32(this.i30,mstate.esp + 4);
                           state = 44;
                           mstate.esp -= 4;
                           FSM___swbuf.start();
                           return;
                        }
                        this.i30 += 1;
                        si32(this.i30,___sF + 176);
                     }
                     else
                     {
                        this.i30 = 10;
                        this.i31 = li32(___sF + 176);
                        si8(this.i30,this.i31);
                        this.i30 = li32(___sF + 176);
                        this.i30 += 1;
                        si32(this.i30,___sF + 176);
                     }
                     §§goto(addr4085);
                  }
               }
               addr5400:
               if(this.i27 != this.i29)
               {
                  addr5406:
                  this.i30 = 0;
                  si8(this.i30,this.i29);
                  this.i29 -= this.i13;
               }
               else
               {
                  addr4667:
                  this.i29 = 0;
                  addr4666:
               }
               §§goto(addr5421);
            case 43:
               §§goto(addr3841);
            case 44:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr4085);
            case 45:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               addr4085:
               this.i30 = ___sF;
               mstate.esp -= 12;
               this.i31 = __2E_str22370;
               this.i30 += 176;
               si32(this.i30,mstate.esp);
               si32(this.i31,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 46;
               mstate.esp -= 4;
               FSM_fprintf.start();
               return;
            case 46:
               this.i30 = mstate.eax;
               mstate.esp += 12;
               this.i30 = __2E_str23371;
               si32(this.i30,this.i11);
               this.i30 = 35;
               si32(this.i30,this.i26);
               si32(this.i30,this.i25);
               this.i30 = mstate.ebp + -152;
               si32(this.i30,this.i7);
               this.i30 = 1;
               si32(this.i30,this.i24);
               this.i30 = li32(___sF + 232);
               this.i31 = li32(this.i30 + 16);
               this.i30 += 16;
               if(this.i31 == 0)
               {
                  this.i31 = -1;
                  si32(this.i31,this.i30);
               }
               this.i30 = ___sF;
               mstate.esp -= 8;
               this.i31 = mstate.ebp + -176;
               this.i30 += 176;
               si32(this.i30,mstate.esp);
               si32(this.i31,mstate.esp + 4);
               state = 47;
               mstate.esp -= 4;
               FSM___sfvwrite.start();
               return;
            case 47:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               this.i30 = li32(mstate.ebp + -276);
               if(this.i30 != 2)
               {
                  if(this.i30 == 1)
                  {
                     this.i30 = __2E_str2415;
                     si32(this.i30,this.i10);
                     this.i30 = 12;
                     si32(this.i30,this.i23);
                     si32(this.i30,this.i22);
                     this.i30 = mstate.ebp + -184;
                     si32(this.i30,this.i6);
                     this.i30 = 1;
                     si32(this.i30,this.i21);
                     this.i30 = li32(___sF + 232);
                     this.i31 = li32(this.i30 + 16);
                     this.i30 += 16;
                     if(this.i31 == 0)
                     {
                        this.i31 = -1;
                        si32(this.i31,this.i30);
                     }
                     this.i30 = ___sF;
                     mstate.esp -= 8;
                     this.i31 = mstate.ebp + -208;
                     this.i30 += 176;
                     si32(this.i30,mstate.esp);
                     si32(this.i31,mstate.esp + 4);
                     state = 48;
                     mstate.esp -= 4;
                     FSM___sfvwrite.start();
                     return;
                  }
                  this.i30 = __2E_str26373;
                  si32(this.i30,this.i8);
                  this.i30 = 11;
                  si32(this.i30,this.i17);
                  si32(this.i30,this.i16);
                  this.i30 = mstate.ebp + -248;
                  si32(this.i30,this.i1);
                  this.i30 = 1;
                  si32(this.i30,this.i15);
                  this.i30 = li32(___sF + 232);
                  this.i31 = li32(this.i30 + 16);
                  this.i30 += 16;
                  if(this.i31 == 0)
                  {
                     this.i31 = -1;
                     si32(this.i31,this.i30);
                  }
                  this.i30 = ___sF;
                  mstate.esp -= 8;
                  this.i31 = mstate.ebp + -272;
                  this.i30 += 176;
                  si32(this.i30,mstate.esp);
                  si32(this.i31,mstate.esp + 4);
                  state = 54;
                  mstate.esp -= 4;
                  FSM___sfvwrite.start();
                  return;
               }
               this.i30 = __2E_str25372;
               si32(this.i30,this.i9);
               this.i30 = 18;
               si32(this.i30,this.i20);
               si32(this.i30,this.i19);
               this.i30 = mstate.ebp + -216;
               si32(this.i30,this.i5);
               this.i30 = 1;
               si32(this.i30,this.i18);
               this.i30 = li32(___sF + 232);
               this.i31 = li32(this.i30 + 16);
               this.i30 += 16;
               if(this.i31 == 0)
               {
                  this.i31 = -1;
                  si32(this.i31,this.i30);
               }
               this.i30 = ___sF;
               mstate.esp -= 8;
               this.i31 = mstate.ebp + -240;
               this.i30 += 176;
               si32(this.i30,mstate.esp);
               si32(this.i31,mstate.esp + 4);
               state = 51;
               mstate.esp -= 4;
               FSM___sfvwrite.start();
               return;
               break;
            case 48:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               this.i30 = li32(___sF + 184);
               this.i30 += -1;
               si32(this.i30,___sF + 184);
               if(this.i30 <= -1)
               {
                  this.i31 = li32(___sF + 200);
                  if(this.i30 < this.i31)
                  {
                     this.i30 = ___sF;
                     mstate.esp -= 8;
                     this.i30 += 176;
                     this.i31 = 10;
                     si32(this.i31,mstate.esp);
                     si32(this.i30,mstate.esp + 4);
                     state = 50;
                     mstate.esp -= 4;
                     FSM___swbuf.start();
                     return;
                  }
                  this.i30 = 10;
                  this.i31 = li32(___sF + 176);
                  si8(this.i30,this.i31);
                  this.i30 = li32(___sF + 176);
                  this.i31 = li8(this.i30);
                  if(this.i31 == 10)
                  {
                     this.i30 = ___sF;
                     mstate.esp -= 8;
                     this.i30 += 176;
                     this.i31 = 10;
                     si32(this.i31,mstate.esp);
                     si32(this.i30,mstate.esp + 4);
                     state = 49;
                     mstate.esp -= 4;
                     FSM___swbuf.start();
                     return;
                  }
                  this.i30 += 1;
                  si32(this.i30,___sF + 176);
               }
               else
               {
                  this.i30 = 10;
                  this.i31 = li32(___sF + 176);
                  si8(this.i30,this.i31);
                  this.i30 = li32(___sF + 176);
                  this.i30 += 1;
                  si32(this.i30,___sF + 176);
               }
               §§goto(addr4658);
            case 49:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr4658);
            case 50:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               addr4658:
               if(this.i27 == this.i29)
               {
                  §§goto(addr4667);
               }
               else
               {
                  §§goto(addr5406);
               }
            case 51:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               this.i30 = li32(___sF + 184);
               this.i30 += -1;
               si32(this.i30,___sF + 184);
               if(this.i30 <= -1)
               {
                  this.i31 = li32(___sF + 200);
                  if(this.i30 < this.i31)
                  {
                     this.i30 = ___sF;
                     mstate.esp -= 8;
                     this.i30 += 176;
                     this.i31 = 10;
                     si32(this.i31,mstate.esp);
                     si32(this.i30,mstate.esp + 4);
                     state = 53;
                     mstate.esp -= 4;
                     FSM___swbuf.start();
                     return;
                  }
                  this.i30 = 10;
                  this.i31 = li32(___sF + 176);
                  si8(this.i30,this.i31);
                  this.i30 = li32(___sF + 176);
                  this.i31 = li8(this.i30);
                  if(this.i31 == 10)
                  {
                     this.i30 = ___sF;
                     mstate.esp -= 8;
                     this.i30 += 176;
                     this.i31 = 10;
                     si32(this.i31,mstate.esp);
                     si32(this.i30,mstate.esp + 4);
                     state = 52;
                     mstate.esp -= 4;
                     FSM___swbuf.start();
                     return;
                  }
                  this.i30 += 1;
                  si32(this.i30,___sF + 176);
               }
               else
               {
                  this.i30 = 10;
                  this.i31 = li32(___sF + 176);
                  si8(this.i30,this.i31);
                  this.i30 = li32(___sF + 176);
                  this.i30 += 1;
                  si32(this.i30,___sF + 176);
               }
               §§goto(addr5032);
            case 52:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr5032);
            case 53:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               addr5032:
               if(this.i27 != this.i29)
               {
                  §§goto(addr5406);
               }
               else
               {
                  §§goto(addr4666);
               }
               si32(this.i29,mstate.esp + 8);
               state = 57;
               mstate.esp -= 4;
               FSM_luaL_addlstring.start();
               return;
            case 54:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               this.i30 = li32(___sF + 184);
               this.i30 += -1;
               si32(this.i30,___sF + 184);
               if(this.i30 <= -1)
               {
                  this.i31 = li32(___sF + 200);
                  if(this.i30 < this.i31)
                  {
                     this.i30 = ___sF;
                     mstate.esp -= 8;
                     this.i30 += 176;
                     this.i31 = 10;
                     si32(this.i31,mstate.esp);
                     si32(this.i30,mstate.esp + 4);
                     state = 56;
                     mstate.esp -= 4;
                     FSM___swbuf.start();
                     return;
                  }
                  this.i30 = 10;
                  this.i31 = li32(___sF + 176);
                  si8(this.i30,this.i31);
                  this.i30 = li32(___sF + 176);
                  this.i31 = li8(this.i30);
                  if(this.i31 == 10)
                  {
                     this.i30 = ___sF;
                     mstate.esp -= 8;
                     this.i30 += 176;
                     this.i31 = 10;
                     si32(this.i31,mstate.esp);
                     si32(this.i30,mstate.esp + 4);
                     state = 55;
                     mstate.esp -= 4;
                     FSM___swbuf.start();
                     return;
                  }
                  this.i30 += 1;
                  si32(this.i30,___sF + 176);
               }
               else
               {
                  this.i30 = 10;
                  this.i31 = li32(___sF + 176);
                  si8(this.i30,this.i31);
                  this.i30 = li32(___sF + 176);
                  this.i30 += 1;
                  si32(this.i30,___sF + 176);
               }
               §§goto(addr5400);
            case 55:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr5400);
            case 56:
               this.i30 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr5400);
            case 57:
               mstate.esp += 12;
               this.i29 = li8(this.i0 + 2);
               this.i0 += 2;
               if(this.i29 != 0)
               {
                  §§goto(addr3550);
               }
               break;
            case 58:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i0 = li32(mstate.ebp + -1548);
               this.i0 = li32(this.i0);
               this.i1 = li32(this.i2);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 59;
               mstate.esp -= 4;
               FSM_lua_concat.start();
               return;
            case 59:
               mstate.esp += 8;
               addr5584:
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _os_date";
         }
         this.i0 = mstate.ebp + -1328;
         mstate.esp -= 4;
         si32(this.i0,mstate.esp);
         state = 58;
         mstate.esp -= 4;
         FSM_emptybuffer.start();
      }
   }
}
