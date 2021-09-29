package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_g_read extends Machine
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
      
      public function FSM_g_read()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_g_read = null;
         _loc1_ = new FSM_g_read();
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
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li16(this.i1 + 12);
               this.i3 = li32(this.i0 + 8);
               this.i4 = li32(this.i0 + 12);
               this.i3 -= this.i4;
               this.i2 &= -97;
               this.i4 = li32(mstate.ebp + 16);
               si16(this.i2,this.i1 + 12);
               this.i2 = this.i1 + 12;
               this.i5 = this.i3 / 12;
               this.i6 = this.i0 + 8;
               this.i3 += -12;
               if(uint(this.i3) <= uint(11))
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_read_line.start();
                  return;
               }
               mstate.esp -= 8;
               this.i3 = this.i5 + 19;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_lua_checkstack.start();
               return;
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i5 = this.i4;
               addr1415:
               this.i3 = this.i5;
               this.i2 = li16(this.i2);
               this.i3 += 1;
               this.i2 &= 64;
               if(this.i2 != 0)
               {
                  this.i1 = 0;
                  this.i3 = li32(_val_2E_1440);
                  this.i4 = li32(this.i6);
                  si32(this.i1,this.i4 + 8);
                  this.i1 = li32(this.i6);
                  this.i1 += 12;
                  si32(this.i1,this.i6);
                  mstate.esp -= 12;
                  this.i1 = _ebuf_2E_1986;
                  this.i4 = 2048;
                  si32(this.i3,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i4,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_strerror_r.start();
               }
               else
               {
                  if(this.i1 == 0)
                  {
                     this.i0 = 0;
                     this.i1 = li32(this.i6);
                     this.i2 = this.i1 + -12;
                     si32(this.i2,this.i6);
                     si32(this.i0,this.i1 + -4);
                     this.i0 = li32(this.i6);
                     this.i0 += 12;
                     si32(this.i0,this.i6);
                     this.i3 -= this.i4;
                     addr1695:
                     mstate.eax = this.i3;
                  }
                  else
                  {
                     this.i0 = this.i3 - this.i4;
                     mstate.eax = this.i0;
                  }
                  §§goto(addr1701);
               }
               break;
            case 9:
               this.i10 = mstate.eax;
               mstate.esp += 12;
               si32(this.i10,this.i12);
               this.i10 = 4;
               si32(this.i10,this.i12 + 8);
               this.i10 = li32(this.i6);
               this.i11 = this.i11 != -1 ? 1 : 0;
               this.i10 += 12;
               si32(this.i10,this.i6);
               this.i11 &= 1;
               addr1368:
               this.i10 = this.i11;
               this.i11 = this.i3 + 1;
               if(this.i10 != 0)
               {
                  if(this.i5 != this.i3)
                  {
                     this.i3 = this.i11;
                     addr299:
                     this.i10 = _luaO_nilobject_;
                     mstate.esp -= 8;
                     this.i11 = this.i4 + this.i3;
                     si32(this.i0,mstate.esp);
                     si32(this.i11,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     break;
                  }
               }
               this.i1 = this.i4 + this.i11;
               this.i1 += -1;
               this.i5 = this.i1;
               this.i1 = this.i10;
               §§goto(addr1415);
            case 2:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               if(this.i3 == 0)
               {
                  this.i3 = __2E_str10185328;
                  mstate.esp -= 12;
                  this.i7 = __2E_str28331;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i7,mstate.esp + 8);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               addr272:
               this.i3 = 0;
               this.i7 = this.i0 + 16;
               this.i5 += -2;
               this.i8 = this.i1 + 4;
               this.i9 = this.i1;
               §§goto(addr299);
               break;
            case 3:
               mstate.esp += 12;
               §§goto(addr272);
            case 12:
               this.i11 = mstate.eax;
               mstate.esp += 12;
               si32(this.i11,this.i10);
               this.i11 = 4;
               si32(this.i11,this.i10 + 8);
               this.i11 = li32(this.i6);
               this.i11 += 12;
               si32(this.i11,this.i6);
               this.i11 = 1;
               §§goto(addr1368);
            case 15:
               this.i11 = mstate.eax;
               mstate.esp += 8;
               if(this.i11 != 1)
               {
                  this.i11 = 0;
               }
               else
               {
                  this.i11 = 3;
                  this.f0 = lf64(mstate.ebp + -8);
                  this.i10 = li32(this.i6);
                  sf64(this.f0,this.i10);
                  si32(this.i11,this.i10 + 8);
                  this.i11 = li32(this.i6);
                  this.i11 += 12;
                  si32(this.i11,this.i6);
                  this.i11 = 1;
               }
               §§goto(addr1368);
            case 16:
               this.i11 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr1368);
            case 17:
               this.i11 = mstate.eax;
               mstate.esp += 12;
               this.i11 = 1;
               §§goto(addr1368);
            case 19:
               this.i11 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr1368);
            case 20:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               if(this.i1 != 0)
               {
                  this.i1 = 22;
                  si32(this.i1,_val_2E_1440);
               }
               this.i1 = __2E_str54344;
               mstate.esp -= 12;
               this.i4 = _ebuf_2E_1986;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 21;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
            case 4:
               break;
            case 5:
               this.i11 = mstate.eax;
               mstate.esp += 8;
               if(this.i11 == 0)
               {
                  this.i11 = li32(this.i8);
                  this.i11 += -1;
                  si32(this.i11,this.i8);
                  if(this.i11 <= -1)
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 6;
                     mstate.esp -= 4;
                     FSM___srefill.start();
                     return;
                  }
                  this.i11 = li32(this.i9);
                  this.i10 = li8(this.i11);
                  this.i11 += 1;
                  si32(this.i11,this.i9);
                  mstate.esp -= 8;
                  si32(this.i10,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 10;
                  mstate.esp -= 4;
                  FSM_ungetc.start();
                  return;
               }
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               FSM_read_chars.start();
               return;
               break;
            case 6:
               this.i11 = mstate.eax;
               mstate.esp += 4;
               if(this.i11 != 0)
               {
                  this.i11 = -1;
               }
               else
               {
                  this.i11 = li32(this.i8);
                  this.i11 += -1;
                  si32(this.i11,this.i8);
                  this.i11 = li32(this.i9);
                  this.i10 = li8(this.i11);
                  this.i11 += 1;
                  si32(this.i11,this.i9);
                  this.i11 = this.i10;
               }
               mstate.esp -= 8;
               si32(this.i11,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 7;
               mstate.esp -= 4;
               FSM_ungetc.start();
               return;
            case 7:
               mstate.esp += 8;
               this.i10 = li32(this.i7);
               this.i12 = li32(this.i10 + 68);
               this.i10 = li32(this.i10 + 64);
               if(uint(this.i12) >= uint(this.i10))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr614);
               break;
            case 8:
               mstate.esp += 4;
               addr614:
               this.i10 = 0;
               this.i12 = li32(this.i6);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               mstate.esp += 8;
               this.i11 = li32(this.i7);
               this.i10 = li32(this.i11 + 68);
               this.i11 = li32(this.i11 + 64);
               if(uint(this.i10) >= uint(this.i11))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr834);
               break;
            case 11:
               mstate.esp += 4;
               addr834:
               this.i11 = 0;
               this.i10 = li32(this.i6);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 13:
               this.i10 = mstate.eax;
               mstate.esp += 12;
               if(this.i10 != 0)
               {
                  this.i12 = li8(this.i10);
                  if(this.i12 == 42)
                  {
                     addr1039:
                     this.i10 = si8(li8(this.i10 + 1));
                     if(this.i10 != 97)
                     {
                        if(this.i10 != 108)
                        {
                           if(this.i10 == 110)
                           {
                              this.i11 = mstate.ebp + -8;
                              mstate.esp -= 8;
                              si32(this.i1,mstate.esp);
                              si32(this.i11,mstate.esp + 4);
                              state = 15;
                              mstate.esp -= 4;
                              FSM_fscanf.start();
                              return;
                           }
                           this.i1 = __2E_str31334;
                           mstate.esp -= 12;
                           si32(this.i0,mstate.esp);
                           si32(this.i11,mstate.esp + 4);
                           si32(this.i1,mstate.esp + 8);
                           state = 18;
                           mstate.esp -= 4;
                           FSM_luaL_argerror.start();
                           return;
                        }
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 16;
                        mstate.esp -= 4;
                        FSM_read_line.start();
                        return;
                     }
                     this.i11 = -1;
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i11,mstate.esp + 8);
                     state = 17;
                     mstate.esp -= 4;
                     FSM_read_chars.start();
                     return;
                  }
               }
               this.i12 = __2E_str19269;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 14:
               mstate.esp += 12;
               §§goto(addr1039);
            case 18:
               mstate.esp += 12;
               this.i1 = 0;
               mstate.eax = this.i1;
               addr1701:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 21:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i1 = li32(this.i6);
               this.f0 = Number(this.i3);
               sf64(this.f0,this.i1);
               this.i3 = 3;
               si32(this.i3,this.i1 + 8);
               this.i1 = li32(this.i6);
               this.i1 += 12;
               si32(this.i1,this.i6);
               §§goto(addr1695);
            default:
               throw "Invalid state in _g_read";
         }
         this.i12 = mstate.eax;
         mstate.esp += 8;
         if(this.i12 != this.i10)
         {
            this.i10 = li32(this.i12 + 8);
            if(this.i10 == 3)
            {
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_lua_tointeger.start();
               return;
            }
         }
         this.i10 = 0;
         mstate.esp -= 12;
         si32(this.i0,mstate.esp);
         si32(this.i11,mstate.esp + 4);
         si32(this.i10,mstate.esp + 8);
         state = 13;
         mstate.esp -= 4;
         FSM_lua_tolstring.start();
      }
   }
}
