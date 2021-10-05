package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_jumponcond extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public function FSM_jumponcond()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_jumponcond = null;
         _loc1_ = new FSM_jumponcond();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(this.i0);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = this.i0;
               if(this.i1 != 12)
               {
                  if(this.i1 == 11)
                  {
                     this.i5 = li32(this.i0 + 4);
                     this.i6 = li32(this.i2);
                     this.i6 = li32(this.i6 + 12);
                     this.i5 <<= 2;
                     this.i5 = this.i6 + this.i5;
                     this.i5 = li32(this.i5);
                     this.i6 = this.i5 & 63;
                     if(this.i6 == 19)
                     {
                        this.i0 = -1;
                        this.i1 = li32(this.i2 + 24);
                        this.i1 += -1;
                        si32(this.i1,this.i2 + 24);
                        this.i1 = li32(this.i2 + 12);
                        this.i3 = this.i3 == 0 ? 1 : 0;
                        this.i4 = this.i5 >>> 17;
                        this.i1 = li32(this.i1 + 8);
                        this.i3 &= 1;
                        this.i4 |= 26;
                        this.i4 &= 32730;
                        this.i3 <<= 14;
                        mstate.esp -= 12;
                        this.i3 = this.i4 | this.i3;
                        si32(this.i2,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        si32(this.i1,mstate.esp + 8);
                        state = 1;
                        mstate.esp -= 4;
                        FSM_luaK_code.start();
                        return;
                     }
                     if(this.i1 == 12)
                     {
                        §§goto(addr500);
                     }
                  }
                  this.i1 = 1;
                  mstate.esp -= 8;
                  si32(this.i2,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaK_checkstack.start();
                  return;
               }
               §§goto(addr500);
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i1 = li32(this.i2 + 32);
               si32(this.i0,this.i2 + 32);
               this.i0 = li32(this.i2 + 12);
               this.i0 = li32(this.i0 + 8);
               mstate.esp -= 12;
               this.i3 = 2147450902;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,mstate.ebp + -8);
               mstate.esp -= 12;
               this.i0 = mstate.ebp + -8;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 3:
               mstate.esp += 12;
               this.i0 = li32(mstate.ebp + -8);
               break;
            case 4:
               mstate.esp += 8;
               this.i1 = li32(this.i2 + 36);
               this.i5 = this.i1 + 1;
               si32(this.i5,this.i2 + 36);
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_discharge2reg.start();
               return;
            case 5:
               mstate.esp += 12;
               addr500:
               this.i1 = li32(this.i4);
               if(this.i1 == 12)
               {
                  this.i1 = li32(this.i0 + 4);
                  this.i4 = this.i1 & 256;
                  if(this.i4 == 0)
                  {
                     this.i4 = li8(this.i2 + 50);
                     if(this.i4 <= this.i1)
                     {
                        this.i1 = li32(this.i2 + 36);
                        this.i1 += -1;
                        si32(this.i1,this.i2 + 36);
                     }
                  }
               }
               this.i1 = -1;
               this.i0 = li32(this.i0 + 4);
               this.i4 = li32(this.i2 + 12);
               this.i4 = li32(this.i4 + 8);
               this.i3 <<= 14;
               this.i0 <<= 23;
               this.i0 |= this.i3;
               mstate.esp -= 12;
               this.i0 |= 16347;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i2 + 32);
               si32(this.i1,this.i2 + 32);
               this.i1 = li32(this.i2 + 12);
               this.i1 = li32(this.i1 + 8);
               mstate.esp -= 12;
               this.i3 = 2147450902;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 7:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,mstate.ebp + -4);
               mstate.esp -= 12;
               this.i1 = mstate.ebp + -4;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 8:
               mstate.esp += 12;
               this.i0 = li32(mstate.ebp + -4);
               break;
            default:
               throw "Invalid state in _jumponcond";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
