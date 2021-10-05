package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaU_undump extends Machine
   {
      
      public static const intRegCount:int = 12;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
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
      
      public function FSM_luaU_undump()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaU_undump = null;
         _loc1_ = new FSM_luaU_undump();
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
               mstate.esp -= 48;
               this.i0 = mstate.ebp + -48;
               this.i1 = li32(mstate.ebp + 20);
               this.i2 = li8(this.i1);
               this.i3 = mstate.ebp + -32;
               this.i4 = li32(mstate.ebp + 8);
               this.i5 = li32(mstate.ebp + 12);
               this.i6 = li32(mstate.ebp + 16);
               if(this.i2 != 61)
               {
                  this.i7 = this.i2 & 255;
                  if(this.i7 == 64)
                  {
                     addr88:
                     this.i1 += 1;
                     si32(this.i1,mstate.ebp + -4);
                  }
                  else
                  {
                     this.i7 = mstate.ebp + -16;
                     this.i7 += 12;
                     this.i2 &= 255;
                     if(this.i2 == 27)
                     {
                        this.i1 = __2E_str8163;
                        si32(this.i1,this.i7);
                     }
                     else
                     {
                        si32(this.i1,this.i7);
                     }
                  }
                  this.i1 = 27;
                  si32(this.i4,mstate.ebp + -16);
                  si32(this.i5,mstate.ebp + -12);
                  si32(this.i6,mstate.ebp + -8);
                  this.i2 = 76;
                  this.i5 = 117;
                  this.i6 = 97;
                  si8(this.i1,mstate.ebp + -32);
                  si8(this.i2,mstate.ebp + -31);
                  si8(this.i5,mstate.ebp + -30);
                  si8(this.i6,mstate.ebp + -29);
                  this.i1 = 81;
                  si8(this.i1,mstate.ebp + -28);
                  this.i1 = 0;
                  si8(this.i1,mstate.ebp + -27);
                  this.i2 = 1;
                  si8(this.i2,mstate.ebp + -26);
                  this.i2 = 4;
                  si8(this.i2,mstate.ebp + -25);
                  si8(this.i2,mstate.ebp + -24);
                  si8(this.i2,mstate.ebp + -23);
                  this.i2 = 8;
                  si8(this.i2,mstate.ebp + -22);
                  si8(this.i1,mstate.ebp + -21);
                  this.i2 = li32(mstate.ebp + -12);
                  this.i5 = 12;
                  this.i6 = this.i2 + 4;
                  this.i7 = mstate.ebp + -16;
                  this.i8 = this.i2;
                  §§goto(addr301);
               }
               §§goto(addr88);
            case 1:
               this.i9 = mstate.eax;
               mstate.esp += 4;
               if(this.i9 == -1)
               {
                  this.i1 = this.i5;
               }
               else
               {
                  this.i9 = mstate.ebp + -48;
                  this.i10 = li32(this.i2);
                  this.i11 = li32(this.i6);
                  this.i9 += this.i1;
                  this.i10 = uint(this.i10) <= uint(this.i5) ? int(this.i10) : int(this.i5);
                  memcpy(this.i9,this.i11,this.i10);
                  this.i9 = li32(this.i2);
                  this.i9 -= this.i10;
                  si32(this.i9,this.i2);
                  this.i9 = li32(this.i6);
                  this.i9 += this.i10;
                  si32(this.i9,this.i6);
                  this.i9 = this.i5 - this.i10;
                  this.i1 += this.i10;
                  if(this.i5 != this.i10)
                  {
                     this.i5 = this.i9;
                     addr301:
                     mstate.esp -= 4;
                     si32(this.i8,mstate.esp);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaZ_lookahead.start();
                     return;
                  }
                  this.i1 = 0;
               }
               if(this.i1 == 0)
               {
                  this.i1 = 0;
                  this.i2 = 13;
                  break;
               }
               this.i1 = __2E_str156317;
               this.i2 = li32(mstate.ebp + -4);
               this.i5 = li32(this.i7);
               mstate.esp -= 16;
               this.i6 = __2E_str1157;
               si32(this.i5,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 2;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
               break;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i7);
               mstate.esp -= 8;
               this.i2 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 3:
               mstate.esp += 8;
               this.i1 = 13;
               this.i5 = 0;
               this.i2 = this.i1;
               this.i1 = this.i5;
               break;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = li32(this.i7);
               mstate.esp -= 8;
               this.i1 = 3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 5:
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i0 = __2E_str10165;
               this.i1 = 2;
               si32(this.i4,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i0 = mstate.ebp + -16;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 7;
               mstate.esp -= 4;
               FSM_LoadFunction.start();
               return;
            case 7:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               mstate.eax = this.i4;
               §§goto(addr988);
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i1 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               FSM_LoadFunction.start();
               return;
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.eax = this.i0;
               addr988:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaU_undump";
         }
         continue loop0;
      }
   }
}
