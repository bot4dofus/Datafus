package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaK_goiftrue extends Machine
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
      
      public function FSM_luaK_goiftrue()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaK_goiftrue = null;
         _loc1_ = new FSM_luaK_goiftrue();
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
               mstate.esp -= 4;
               this.i0 = li32(mstate.ebp + 8);
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 12);
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_dischargevars.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i2 = li32(this.i1);
               if(this.i2 <= 3)
               {
                  if(this.i2 == 2)
                  {
                     addr265:
                     this.i2 = -1;
                     break;
                  }
                  if(this.i2 == 3)
                  {
                     this.i2 = -1;
                     this.i3 = li32(this.i0 + 32);
                     si32(this.i2,this.i0 + 32);
                     this.i2 = li32(this.i0 + 12);
                     this.i2 = li32(this.i2 + 8);
                     mstate.esp -= 12;
                     this.i4 = 2147450902;
                     si32(this.i0,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     si32(this.i2,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaK_code.start();
                     return;
                  }
               }
               else
               {
                  if(this.i2 == 10)
                  {
                     this.i2 = li32(this.i1 + 4);
                     this.i3 = li32(this.i0);
                     this.i3 = li32(this.i3 + 12);
                     this.i4 = this.i2 << 2;
                     this.i4 = this.i3 + this.i4;
                     this.i5 = this.i1 + 4;
                     if(this.i2 <= 0)
                     {
                        this.i2 = this.i4;
                     }
                     else
                     {
                        this.i6 = _luaP_opmodes;
                        this.i2 <<= 2;
                        this.i2 += this.i3;
                        this.i3 = li32(this.i2 + -4);
                        this.i3 &= 63;
                        this.i3 = this.i6 + this.i3;
                        this.i3 = li8(this.i3);
                        this.i3 <<= 24;
                        this.i3 >>= 24;
                        this.i2 += -4;
                        this.i2 = this.i3 > -1 ? int(this.i4) : int(this.i2);
                     }
                     this.i3 = li32(this.i2);
                     this.i4 = this.i3 & 16320;
                     this.i4 = this.i4 == 0 ? 64 : 0;
                     this.i3 &= -16321;
                     this.i3 = this.i4 | this.i3;
                     si32(this.i3,this.i2);
                     this.i2 = li32(this.i5);
                     break;
                  }
                  this.i2 += -4;
                  if(uint(this.i2) <= uint(1))
                  {
                     §§goto(addr265);
                  }
               }
               this.i2 = 0;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_jumponcond.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -4);
               mstate.esp -= 12;
               this.i2 = mstate.ebp + -4;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 3:
               mstate.esp += 12;
               this.i2 = li32(mstate.ebp + -4);
               break;
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               break;
            case 5:
               mstate.esp += 12;
               this.i2 = li32(this.i1 + 12);
               this.i4 = li32(this.i0 + 24);
               si32(this.i4,this.i0 + 28);
               mstate.esp -= 12;
               this.i4 = this.i0 + 32;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 6:
               mstate.esp += 12;
               si32(this.i3,this.i1 + 12);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaK_goiftrue";
         }
         this.i3 = -1;
         mstate.esp -= 12;
         this.i4 = this.i1 + 16;
         si32(this.i0,mstate.esp);
         si32(this.i4,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 5;
         mstate.esp -= 4;
         FSM_luaK_concat.start();
      }
   }
}
