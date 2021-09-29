package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_funcargs extends Machine
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
      
      public function FSM_funcargs()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_funcargs = null;
         _loc1_ = new FSM_funcargs();
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
               mstate.esp -= 208;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 36);
               this.i2 = li32(this.i0 + 4);
               this.i3 = li32(this.i0 + 12);
               this.i4 = this.i0 + 12;
               this.i5 = this.i0 + 4;
               this.i6 = li32(mstate.ebp + 12);
               if(this.i3 == 286)
               {
                  this.i3 = 4;
                  this.i7 = li32(this.i0 + 16);
                  si32(this.i7,mstate.ebp + -96);
                  si32(this.i3,mstate.ebp + -88);
                  mstate.esp -= 12;
                  this.i7 = mstate.ebp + -96;
                  si32(this.i1,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i7,mstate.esp + 8);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_addk.start();
                  return;
               }
               if(this.i3 == 123)
               {
                  this.i3 = mstate.ebp + -208;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 24;
                  mstate.esp -= 4;
                  FSM_constructor.start();
                  return;
               }
               if(this.i3 == 40)
               {
                  this.i7 = li32(this.i0 + 8);
                  this.i8 = this.i0 + 8;
                  if(this.i7 == this.i2)
                  {
                     addr636:
                     this.i3 = li32(this.i5);
                     si32(this.i3,this.i8);
                     this.i3 = li32(this.i0 + 24);
                     this.i5 = this.i0 + 24;
                     if(this.i3 != 287)
                     {
                        this.i7 = 287;
                        si32(this.i3,this.i4);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0,this.i0 + 16);
                        si32(this.i7,this.i5);
                        addr744:
                        this.i3 = li32(this.i4);
                        if(this.i3 == 41)
                        {
                           this.i3 = 0;
                           si32(this.i3,mstate.ebp + -208);
                           mstate.esp -= 16;
                           this.i3 = 40;
                           this.i4 = 41;
                           si32(this.i0,mstate.esp);
                           si32(this.i4,mstate.esp + 4);
                           si32(this.i3,mstate.esp + 8);
                           si32(this.i2,mstate.esp + 12);
                           state = 11;
                           mstate.esp -= 4;
                           FSM_check_match.start();
                           return;
                        }
                        this.i3 = mstate.ebp + -208;
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        state = 12;
                        mstate.esp -= 4;
                        FSM_explist1.start();
                        return;
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
                  this.i7 = 80;
                  this.i9 = li32(this.i0 + 52);
                  mstate.esp -= 12;
                  this.i10 = mstate.ebp + -176;
                  this.i9 += 16;
                  si32(this.i10,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i7,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaO_chunkid.start();
               }
               else
               {
                  this.i1 = 80;
                  this.i2 = li32(this.i0 + 52);
                  mstate.esp -= 12;
                  this.i6 = mstate.ebp + -80;
                  this.i2 += 16;
                  si32(this.i6,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaO_chunkid.start();
               }
            case 17:
               mstate.esp += 12;
               this.i1 = li32(this.i5);
               this.i2 = li32(this.i0 + 40);
               mstate.esp -= 20;
               this.i4 = __2E_str15272;
               this.i5 = __2E_str25119;
               si32(this.i2,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               si32(this.i5,mstate.esp + 16);
               state = 18;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 1:
               mstate.esp += 12;
               this.i7 = li32(this.i5);
               this.i9 = li32(this.i0 + 40);
               mstate.esp -= 20;
               this.i11 = __2E_str15272;
               this.i12 = __2E_str24118;
               si32(this.i9,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               si32(this.i12,mstate.esp + 16);
               state = 2;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 2:
               this.i7 = mstate.eax;
               mstate.esp += 20;
               this.i9 = this.i0 + 40;
               if(this.i3 != 0)
               {
                  this.i10 = this.i3 + -284;
                  if(uint(this.i10) <= uint(2))
                  {
                     this.i3 = 0;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_save.start();
                     return;
                  }
                  this.i10 = __2E_str35292;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaX_token2str.start();
                  return;
               }
               this.i3 = 3;
               this.i7 = li32(this.i9);
               mstate.esp -= 8;
               si32(this.i7,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
               break;
            case 3:
               mstate.esp += 8;
               this.i3 = li32(this.i0 + 48);
               this.i3 = li32(this.i3);
               this.i10 = li32(this.i9);
               mstate.esp -= 16;
               this.i11 = __2E_str35292;
               si32(this.i10,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               this.i3 = li32(this.i9);
               mstate.esp -= 8;
               this.i7 = 3;
               si32(this.i3,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 5:
               mstate.esp += 8;
               §§goto(addr636);
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i11 = li32(this.i9);
               mstate.esp -= 16;
               si32(this.i11,mstate.esp);
               si32(this.i10,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 7:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               this.i3 = li32(this.i9);
               mstate.esp -= 8;
               this.i9 = 3;
               si32(this.i3,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 8:
               mstate.esp += 8;
               §§goto(addr636);
            case 9:
               mstate.esp += 8;
               §§goto(addr636);
            case 10:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               si32(this.i3,this.i4);
               §§goto(addr744);
            case 11:
               mstate.esp += 16;
               addr1946:
               this.i0 = li32(mstate.ebp + -208);
               this.i3 = li32(this.i6 + 4);
               this.i4 = this.i6 + 4;
               this.i5 = this.i0 + -13;
               if(uint(this.i5) > uint(1))
               {
                  if(this.i0 != 0)
                  {
                     this.i0 = mstate.ebp + -208;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 25;
                     mstate.esp -= 4;
                     FSM_luaK_exp2nextreg.start();
                     return;
                  }
                  break;
               }
               this.i0 = 0;
               §§goto(addr2053);
               break;
            case 12:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(mstate.ebp + -208);
               if(this.i3 == 14)
               {
                  this.i3 = 1;
                  this.i4 = li32(mstate.ebp + -204);
                  this.i5 = li32(this.i1);
                  this.i5 = li32(this.i5 + 12);
                  this.i4 <<= 2;
                  this.i4 = this.i5 + this.i4;
                  this.i5 = li32(this.i4);
                  this.i5 &= 8388607;
                  si32(this.i5,this.i4);
                  this.i4 = li32(this.i1);
                  this.i5 = li32(mstate.ebp + -204);
                  this.i4 = li32(this.i4 + 12);
                  this.i5 <<= 2;
                  this.i7 = li32(this.i1 + 36);
                  this.i4 += this.i5;
                  this.i5 = li32(this.i4);
                  this.i7 <<= 6;
                  this.i7 &= 16320;
                  this.i5 &= -16321;
                  this.i5 = this.i7 | this.i5;
                  si32(this.i5,this.i4);
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaK_checkstack.start();
                  return;
               }
               if(this.i3 == 13)
               {
                  this.i3 = li32(mstate.ebp + -204);
                  this.i4 = li32(this.i1);
                  this.i4 = li32(this.i4 + 12);
                  this.i3 <<= 2;
                  this.i3 = this.i4 + this.i3;
                  this.i4 = li32(this.i3);
                  this.i4 &= -8372225;
                  si32(this.i4,this.i3);
               }
               §§goto(addr1119);
               break;
            case 13:
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 36);
               this.i3 += 1;
               si32(this.i3,this.i1 + 36);
               addr1119:
               this.i3 = 40;
               mstate.esp -= 16;
               this.i4 = 41;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 14;
               mstate.esp -= 4;
               FSM_check_match.start();
               return;
            case 14:
               mstate.esp += 16;
               §§goto(addr1946);
            case 15:
               this.i7 = mstate.eax;
               mstate.esp += 12;
               this.i8 = -1;
               si32(this.i8,mstate.ebp + -196);
               si32(this.i8,mstate.ebp + -192);
               si32(this.i3,mstate.ebp + -208);
               si32(this.i7,mstate.ebp + -204);
               this.i3 = li32(this.i5);
               si32(this.i3,this.i0 + 8);
               this.i3 = li32(this.i0 + 24);
               this.i5 = this.i0 + 16;
               this.i7 = this.i0 + 24;
               if(this.i3 == 287)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 16;
                  mstate.esp -= 4;
                  FSM_llex.start();
                  return;
               }
               this.i5 = 287;
               si32(this.i3,this.i4);
               this.f0 = lf64(this.i0 + 28);
               sf64(this.f0,this.i0 + 16);
               si32(this.i5,this.i7);
               §§goto(addr1946);
               break;
            case 16:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,this.i4);
               §§goto(addr1946);
            case 18:
               this.i1 = mstate.eax;
               mstate.esp += 20;
               this.i2 = this.i0 + 40;
               if(this.i3 != 0)
               {
                  this.i6 = this.i3 + -284;
                  if(uint(this.i6) <= uint(1))
                  {
                     this.i3 = 0;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 19;
                     mstate.esp -= 4;
                     FSM_save.start();
                     return;
                  }
                  this.i6 = __2E_str35292;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 21;
                  mstate.esp -= 4;
                  FSM_luaX_token2str.start();
                  return;
               }
               this.i1 = 3;
               this.i2 = li32(this.i2);
               mstate.esp -= 8;
               addr1844:
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               §§goto(addr1856);
               break;
            case 19:
               mstate.esp += 8;
               this.i0 = li32(this.i0 + 48);
               this.i0 = li32(this.i0);
               this.i3 = li32(this.i2);
               mstate.esp -= 16;
               this.i6 = __2E_str35292;
               si32(this.i3,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 20;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 20:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i2);
               mstate.esp -= 8;
               this.i2 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               addr1856:
               state = 23;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 21:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i2);
               mstate.esp -= 16;
               si32(this.i3,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 22;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 22:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i2);
               mstate.esp -= 8;
               this.i1 = 3;
               §§goto(addr1844);
            case 23:
               mstate.esp += 8;
               §§goto(addr1877);
            case 24:
               mstate.esp += 8;
               §§goto(addr1946);
            case 25:
               mstate.esp += 8;
               break;
            case 26:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,this.i6 + 12);
               si32(this.i5,this.i6 + 16);
               this.i5 = 13;
               si32(this.i5,this.i6);
               si32(this.i0,this.i4);
               this.i0 = li32(this.i1);
               this.i4 = li32(this.i1 + 24);
               this.i0 = li32(this.i0 + 20);
               this.i4 <<= 2;
               this.i0 = this.i4 + this.i0;
               si32(this.i2,this.i0 + -4);
               this.i0 = this.i3 + 1;
               si32(this.i0,this.i1 + 36);
               addr1877:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _funcargs";
         }
         this.i0 = li32(this.i1 + 36);
         this.i0 -= this.i3;
         this.i0 <<= 23;
         addr2053:
         this.i5 = -1;
         this.i7 = li32(this.i1 + 12);
         this.i7 = li32(this.i7 + 8);
         this.i8 = this.i3 << 6;
         this.i0 = this.i8 | this.i0;
         mstate.esp -= 12;
         this.i0 |= 32796;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i7,mstate.esp + 8);
         state = 26;
         mstate.esp -= 4;
         FSM_luaK_code.start();
      }
   }
}
