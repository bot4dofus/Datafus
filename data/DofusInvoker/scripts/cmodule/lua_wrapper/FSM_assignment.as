package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_assignment extends Machine
   {
      
      public static const intRegCount:int = 12;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
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
      
      public function FSM_assignment()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_assignment = null;
         _loc1_ = new FSM_assignment();
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
               mstate.esp -= 304;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = li32(this.i1 + 4);
               this.i3 += -6;
               if(uint(this.i3) < uint(4))
               {
                  addr606:
                  this.i3 = li32(this.i0 + 12);
                  this.i4 = this.i0 + 12;
                  if(this.i3 == 44)
                  {
                     this.i3 = li32(this.i0 + 4);
                     si32(this.i3,this.i0 + 8);
                     this.i3 = li32(this.i0 + 24);
                     this.i5 = this.i0 + 24;
                     if(this.i3 != 287)
                     {
                        this.i6 = 287;
                        si32(this.i3,this.i4);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0,this.i0 + 16);
                        si32(this.i6,this.i5);
                        break;
                     }
                     mstate.esp -= 8;
                     this.i3 = this.i0 + 16;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 10;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  this.i3 = 61;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 23;
                  mstate.esp -= 4;
                  FSM_checknext.start();
                  return;
               }
               this.i3 = 80;
               this.i4 = li32(this.i0 + 52);
               this.i5 = li32(this.i0 + 12);
               mstate.esp -= 12;
               this.i6 = mstate.ebp + -240;
               this.i4 += 16;
               si32(this.i6,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 1:
               mstate.esp += 12;
               this.i3 = li32(this.i0 + 4);
               this.i4 = li32(this.i0 + 40);
               mstate.esp -= 20;
               this.i7 = __2E_str15272;
               this.i8 = __2E_str27121;
               si32(this.i4,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               si32(this.i8,mstate.esp + 16);
               state = 2;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 2:
               this.i3 = mstate.eax;
               mstate.esp += 20;
               this.i4 = this.i0 + 40;
               if(this.i5 != 0)
               {
                  this.i6 = this.i5 + -284;
                  if(uint(this.i6) <= uint(2))
                  {
                     this.i5 = 0;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_save.start();
                     return;
                  }
                  this.i6 = __2E_str35292;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaX_token2str.start();
                  return;
               }
               this.i3 = 3;
               this.i4 = li32(this.i4);
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
               break;
            case 3:
               mstate.esp += 8;
               this.i5 = li32(this.i0 + 48);
               this.i5 = li32(this.i5);
               this.i6 = li32(this.i4);
               mstate.esp -= 16;
               this.i7 = __2E_str35292;
               si32(this.i6,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               this.i3 = li32(this.i4);
               mstate.esp -= 8;
               this.i4 = 3;
               si32(this.i3,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 5:
               mstate.esp += 8;
               §§goto(addr606);
            case 6:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i4);
               mstate.esp -= 16;
               si32(this.i7,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 7:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               this.i4 = li32(this.i4);
               mstate.esp -= 8;
               this.i3 = 3;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 8:
               mstate.esp += 8;
               §§goto(addr606);
            case 9:
               mstate.esp += 8;
               §§goto(addr606);
            case 10:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               si32(this.i3,this.i4);
               break;
            case 11:
               mstate.esp += 8;
               this.i3 = li32(mstate.ebp + -300);
               if(this.i3 == 6)
               {
                  this.i3 = li32(this.i0 + 36);
                  this.i4 = li32(this.i3 + 36);
                  this.i5 = this.i3 + 36;
                  if(this.i1 == 0)
                  {
                     this.i4 = 0;
                  }
                  else
                  {
                     this.i6 = mstate.ebp + -304;
                     this.i6 += 8;
                     this.i7 = 0;
                     this.i8 = this.i1;
                     do
                     {
                        this.i9 = li32(this.i8 + 4);
                        if(this.i9 == 9)
                        {
                           this.i9 = li32(this.i8 + 8);
                           this.i10 = li32(this.i6);
                           this.i11 = this.i8 + 8;
                           if(this.i9 == this.i10)
                           {
                              this.i7 = 1;
                              si32(this.i4,this.i11);
                           }
                           this.i9 = li32(this.i8 + 12);
                           this.i10 = li32(this.i6);
                           this.i11 = this.i8 + 12;
                           if(this.i9 == this.i10)
                           {
                              this.i7 = 1;
                              si32(this.i4,this.i11);
                           }
                        }
                        this.i8 = li32(this.i8);
                     }
                     while(this.i8 != 0);
                     
                     this.i4 = this.i7;
                  }
                  if(this.i4 != 0)
                  {
                     this.i4 = 1;
                     this.i6 = li32(this.i3 + 12);
                     this.i7 = li32(mstate.ebp + -296);
                     this.i8 = li32(this.i5);
                     this.i6 = li32(this.i6 + 8);
                     this.i7 <<= 23;
                     this.i8 <<= 6;
                     mstate.esp -= 12;
                     this.i7 = this.i8 | this.i7;
                     si32(this.i3,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     si32(this.i6,mstate.esp + 8);
                     state = 12;
                     mstate.esp -= 4;
                     FSM_luaK_code.start();
                     return;
                  }
               }
               addr1105:
               this.i3 = li32(this.i0 + 40);
               this.i3 = li16(this.i3 + 52);
               this.i4 = this.i2 + 1;
               this.i3 = 200 - this.i3;
               if(this.i3 < this.i2)
               {
                  this.i2 = li32(this.i0 + 36);
                  this.i5 = li32(this.i2);
                  this.i5 = li32(this.i5 + 60);
                  this.i6 = li32(this.i2 + 16);
                  this.i2 += 12;
                  if(this.i5 == 0)
                  {
                     this.i5 = __2E_str196;
                     mstate.esp -= 16;
                     this.i7 = __2E_str28122;
                     si32(this.i6,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     si32(this.i3,mstate.esp + 8);
                     si32(this.i7,mstate.esp + 12);
                     state = 14;
                     mstate.esp -= 4;
                     FSM_luaO_pushfstring.start();
                     return;
                  }
                  this.i7 = __2E_str297;
                  mstate.esp -= 20;
                  this.i8 = __2E_str28122;
                  si32(this.i6,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  si32(this.i3,mstate.esp + 12);
                  si32(this.i8,mstate.esp + 16);
                  state = 18;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               this.i2 = mstate.ebp + -304;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 27;
               mstate.esp -= 4;
               FSM_assignment.start();
               return;
               break;
            case 12:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i3,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 13;
               mstate.esp -= 4;
               FSM_luaK_checkstack.start();
               return;
            case 13:
               mstate.esp += 8;
               this.i3 = li32(this.i5);
               this.i3 += 1;
               si32(this.i3,this.i5);
               §§goto(addr1105);
            case 14:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i2);
               this.i5 = li32(this.i2 + 52);
               mstate.esp -= 12;
               this.i6 = 80;
               this.i7 = mstate.ebp + -160;
               this.i5 += 16;
               si32(this.i7,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 15:
               mstate.esp += 12;
               this.i5 = li32(this.i2 + 4);
               this.i6 = li32(this.i2 + 40);
               mstate.esp -= 20;
               this.i8 = __2E_str15272;
               si32(this.i6,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               si32(this.i3,mstate.esp + 16);
               state = 16;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 16:
               this.i3 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i2 + 40);
               mstate.esp -= 8;
               this.i3 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 17;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 17:
               mstate.esp += 8;
               §§goto(addr1697);
            case 18:
               this.i3 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i2);
               this.i5 = li32(this.i2 + 52);
               mstate.esp -= 12;
               this.i6 = 80;
               this.i7 = mstate.ebp + -80;
               this.i5 += 16;
               si32(this.i7,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 19:
               mstate.esp += 12;
               this.i5 = li32(this.i2 + 4);
               this.i6 = li32(this.i2 + 40);
               mstate.esp -= 20;
               this.i8 = __2E_str15272;
               si32(this.i6,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               si32(this.i3,mstate.esp + 16);
               state = 20;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 20:
               this.i3 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i2 + 40);
               mstate.esp -= 8;
               this.i3 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 21;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 21:
               mstate.esp += 8;
               addr1697:
               this.i2 = mstate.ebp + -304;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_assignment.start();
               return;
            case 22:
               mstate.esp += 12;
               addr2241:
               this.i2 = -1;
               this.i0 = li32(this.i0 + 36);
               this.i3 = li32(this.i0 + 36);
               si32(this.i2,mstate.ebp + -260);
               si32(this.i2,mstate.ebp + -256);
               this.i2 = 12;
               si32(this.i2,mstate.ebp + -272);
               this.i2 = this.i3 + -1;
               si32(this.i2,mstate.ebp + -268);
               mstate.esp -= 12;
               this.i1 += 4;
               this.i2 = mstate.ebp + -272;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               §§goto(addr2146);
            case 23:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i3 = mstate.ebp + -272;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 24;
               mstate.esp -= 4;
               FSM_explist1.start();
               return;
            case 24:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i0 + 36);
               this.i5 = this.i0 + 36;
               if(this.i3 != this.i2)
               {
                  this.i6 = mstate.ebp + -272;
                  mstate.esp -= 16;
                  si32(this.i4,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 25;
                  mstate.esp -= 4;
                  FSM_adjust_assign397.start();
                  return;
               }
               this.i0 = mstate.ebp + -272;
               this.i2 = li32(mstate.ebp + -272);
               if(this.i2 != 14)
               {
                  if(this.i2 == 13)
                  {
                     this.i2 = 12;
                     si32(this.i2,this.i0);
                     this.i0 = li32(this.i4);
                     this.i4 = li32(mstate.ebp + -268);
                     this.i0 = li32(this.i0 + 12);
                     this.i4 <<= 2;
                     this.i0 += this.i4;
                     this.i0 = li32(this.i0);
                     this.i0 >>>= 6;
                     this.i0 &= 255;
                     si32(this.i0,mstate.ebp + -268);
                  }
               }
               else
               {
                  this.i2 = 11;
                  this.i3 = li32(mstate.ebp + -268);
                  this.i4 = li32(this.i4);
                  this.i4 = li32(this.i4 + 12);
                  this.i3 <<= 2;
                  this.i3 = this.i4 + this.i3;
                  this.i4 = li32(this.i3);
                  this.i4 |= 16777216;
                  this.i4 &= 25165823;
                  si32(this.i4,this.i3);
                  si32(this.i2,this.i0);
               }
               this.i0 = mstate.ebp + -272;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i1 += 4;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               addr2146:
               state = 26;
               mstate.esp -= 4;
               FSM_luaK_storevar.start();
               return;
               break;
            case 25:
               mstate.esp += 16;
               if(this.i3 > this.i2)
               {
                  this.i4 = li32(this.i5);
                  this.i5 = li32(this.i4 + 36);
                  this.i2 -= this.i3;
                  this.i5 = this.i2 + this.i5;
                  si32(this.i5,this.i4 + 36);
               }
               §§goto(addr2241);
            case 26:
               mstate.esp += 12;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 27:
               mstate.esp += 12;
               §§goto(addr2241);
            default:
               throw "Invalid state in _assignment";
         }
         this.i3 = mstate.ebp + -304;
         si32(this.i1,mstate.ebp + -304);
         mstate.esp -= 8;
         this.i3 += 4;
         si32(this.i0,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         state = 11;
         mstate.esp -= 4;
         FSM_primaryexp.start();
      }
   }
}
