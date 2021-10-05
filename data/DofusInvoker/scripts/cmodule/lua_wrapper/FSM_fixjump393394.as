package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_fixjump393394 extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public function FSM_fixjump393394()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_fixjump393394 = null;
         _loc1_ = new FSM_fixjump393394();
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
               mstate.esp -= 80;
               this.i0 = li32(mstate.ebp + 16);
               this.i1 = li32(mstate.ebp + 20);
               this.i1 -= this.i0;
               this.i2 = li32(mstate.ebp + 8);
               this.i0 <<= 2;
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = this.i1 + -1;
               this.i0 = this.i2 + this.i0;
               this.i1 = 1 - this.i1;
               this.i1 = this.i4 > -1 ? int(this.i4) : int(this.i1);
               if(this.i1 < 131072)
               {
                  break;
               }
               this.i1 = 80;
               this.i2 = li32(this.i3 + 52);
               this.i5 = li32(this.i3 + 12);
               mstate.esp -= 12;
               this.i6 = mstate.ebp + -80;
               this.i2 += 16;
               si32(this.i6,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 1:
               mstate.esp += 12;
               this.i1 = li32(this.i3 + 4);
               this.i2 = li32(this.i3 + 40);
               mstate.esp -= 20;
               this.i7 = __2E_str15272;
               this.i8 = __2E_str254;
               si32(this.i2,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               si32(this.i8,mstate.esp + 16);
               state = 2;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 20;
               this.i2 = this.i3 + 40;
               if(this.i5 != 0)
               {
                  this.i6 = this.i5 + -284;
                  if(uint(this.i6) <= uint(2))
                  {
                     this.i5 = 0;
                     mstate.esp -= 8;
                     si32(this.i3,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_save.start();
                     return;
                  }
                  this.i6 = __2E_str35292;
                  mstate.esp -= 8;
                  si32(this.i3,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaX_token2str.start();
                  return;
               }
               this.i1 = 3;
               this.i2 = li32(this.i2);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
               break;
            case 3:
               mstate.esp += 8;
               this.i3 = li32(this.i3 + 48);
               this.i3 = li32(this.i3);
               this.i5 = li32(this.i2);
               mstate.esp -= 16;
               this.i6 = __2E_str35292;
               si32(this.i5,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 4:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(this.i2);
               mstate.esp -= 8;
               this.i2 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 5:
               mstate.esp += 8;
               break;
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i2);
               mstate.esp -= 16;
               si32(this.i5,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 7:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i2);
               mstate.esp -= 8;
               this.i1 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 8:
               mstate.esp += 8;
               break;
            case 9:
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _fixjump393394";
         }
         this.i1 = li32(this.i0);
         this.i2 = this.i4 << 14;
         this.i2 += 2147467264;
         this.i1 &= 16383;
         this.i1 |= this.i2;
         si32(this.i1,this.i0);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
