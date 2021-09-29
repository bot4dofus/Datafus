package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_recfield extends Machine
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
      
      public function FSM_recfield()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_recfield = null;
         _loc1_ = new FSM_recfield();
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
               this.i1 = li32(this.i0 + 36);
               this.i2 = li32(this.i1 + 36);
               this.i3 = li32(this.i0 + 12);
               this.i4 = this.i0 + 12;
               this.i5 = this.i1 + 36;
               this.i6 = this.i0 + 36;
               this.i7 = li32(mstate.ebp + 12);
               if(this.i3 == 285)
               {
                  this.i4 = li32(this.i7 + 24);
                  if(this.i4 >= 2147483646)
                  {
                     this.i4 = li32(this.i1);
                     this.i4 = li32(this.i4 + 60);
                     this.i3 = li32(this.i1 + 16);
                     this.i8 = this.i1 + 12;
                     if(this.i4 == 0)
                     {
                        this.i4 = __2E_str196;
                        mstate.esp -= 16;
                        this.i9 = __2E_str23117;
                        this.i10 = 2147483645;
                        si32(this.i3,mstate.esp);
                        si32(this.i4,mstate.esp + 4);
                        si32(this.i10,mstate.esp + 8);
                        si32(this.i9,mstate.esp + 12);
                        state = 1;
                        mstate.esp -= 4;
                        FSM_luaO_pushfstring.start();
                        return;
                     }
                     this.i9 = __2E_str297;
                     mstate.esp -= 20;
                     this.i10 = __2E_str23117;
                     this.i11 = 2147483645;
                     si32(this.i3,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     si32(this.i4,mstate.esp + 8);
                     si32(this.i11,mstate.esp + 12);
                     si32(this.i10,mstate.esp + 16);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaO_pushfstring.start();
                     return;
                  }
                  this.i4 = 4;
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_str_checkname.start();
                  return;
               }
               this.i3 = li32(this.i0 + 4);
               si32(this.i3,this.i0 + 8);
               this.i3 = li32(this.i0 + 24);
               this.i8 = this.i0 + 24;
               if(this.i3 == 287)
               {
                  mstate.esp -= 8;
                  this.i3 = this.i0 + 16;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_llex.start();
                  return;
               }
               this.i9 = 287;
               si32(this.i3,this.i4);
               this.f0 = lf64(this.i0 + 28);
               sf64(this.f0,this.i0 + 16);
               si32(this.i9,this.i8);
               §§goto(addr1052);
               break;
            case 1:
               this.i4 = mstate.eax;
               mstate.esp += 16;
               this.i3 = li32(this.i8);
               this.i8 = li32(this.i3 + 52);
               mstate.esp -= 12;
               this.i9 = 80;
               this.i10 = mstate.ebp + -192;
               this.i8 += 16;
               si32(this.i10,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 2:
               mstate.esp += 12;
               this.i8 = li32(this.i3 + 4);
               this.i9 = li32(this.i3 + 40);
               mstate.esp -= 20;
               this.i11 = __2E_str15272;
               si32(this.i9,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               si32(this.i4,mstate.esp + 16);
               state = 3;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 20;
               this.i4 = li32(this.i3 + 40);
               mstate.esp -= 8;
               this.i3 = 3;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 4:
               mstate.esp += 8;
               §§goto(addr656);
            case 5:
               this.i4 = mstate.eax;
               mstate.esp += 20;
               this.i3 = li32(this.i8);
               this.i8 = li32(this.i3 + 52);
               mstate.esp -= 12;
               this.i9 = 80;
               this.i10 = mstate.ebp + -112;
               this.i8 += 16;
               si32(this.i10,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 6:
               mstate.esp += 12;
               this.i8 = li32(this.i3 + 4);
               this.i9 = li32(this.i3 + 40);
               mstate.esp -= 20;
               this.i11 = __2E_str15272;
               si32(this.i9,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               si32(this.i4,mstate.esp + 16);
               state = 7;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 7:
               this.i4 = mstate.eax;
               mstate.esp += 20;
               this.i4 = li32(this.i3 + 40);
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
               addr656:
               this.i4 = 4;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 9;
               mstate.esp -= 4;
               FSM_str_checkname.start();
               return;
            case 9:
               this.i3 = mstate.eax;
               mstate.esp += 4;
               this.i6 = li32(this.i6);
               si32(this.i3,mstate.ebp + -32);
               si32(this.i4,mstate.ebp + -24);
               mstate.esp -= 12;
               this.i3 = mstate.ebp + -32;
               si32(this.i6,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_addk.start();
               return;
            case 10:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               this.i3 = -1;
               si32(this.i3,mstate.ebp + -212);
               si32(this.i3,mstate.ebp + -208);
               si32(this.i4,mstate.ebp + -224);
               si32(this.i6,mstate.ebp + -220);
               break;
            case 11:
               this.i3 = mstate.eax;
               mstate.esp += 4;
               this.i6 = li32(this.i6);
               si32(this.i3,mstate.ebp + -16);
               si32(this.i4,mstate.ebp + -8);
               mstate.esp -= 12;
               this.i3 = mstate.ebp + -16;
               si32(this.i6,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_addk.start();
               return;
            case 12:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               this.i3 = -1;
               si32(this.i3,mstate.ebp + -212);
               si32(this.i3,mstate.ebp + -208);
               si32(this.i4,mstate.ebp + -224);
               si32(this.i6,mstate.ebp + -220);
               break;
            case 13:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               si32(this.i3,this.i4);
               addr1052:
               this.i3 = 0;
               mstate.esp -= 12;
               this.i4 = mstate.ebp + -224;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_subexpr.start();
               return;
            case 14:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(this.i6);
               mstate.esp -= 8;
               si32(this.i3,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 15;
               mstate.esp -= 4;
               FSM_luaK_exp2val.start();
               return;
            case 15:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i3 = 93;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 16;
               mstate.esp -= 4;
               FSM_checknext.start();
               return;
            case 16:
               mstate.esp += 8;
               break;
            case 17:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i3 = mstate.ebp + -224;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 18;
               mstate.esp -= 4;
               FSM_luaK_exp2RK.start();
               return;
            case 18:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i4 = mstate.ebp + -256;
               this.i6 = 0;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               FSM_subexpr.start();
               return;
            case 19:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 20;
               mstate.esp -= 4;
               FSM_luaK_exp2RK.start();
               return;
            case 20:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i7 + 20);
               this.i4 = li32(this.i4 + 4);
               this.i6 = li32(this.i1 + 12);
               this.i3 <<= 23;
               this.i4 <<= 6;
               this.i6 = li32(this.i6 + 8);
               this.i3 = this.i4 | this.i3;
               this.i0 <<= 14;
               this.i0 = this.i3 | this.i0;
               mstate.esp -= 12;
               this.i0 |= 9;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 21;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 21:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i5);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _recfield";
         }
         this.i3 = 61;
         this.i4 = li32(this.i7 + 24);
         this.i4 += 1;
         si32(this.i4,this.i7 + 24);
         mstate.esp -= 8;
         si32(this.i0,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         state = 17;
         mstate.esp -= 4;
         FSM_checknext.start();
      }
   }
}
