package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_codecomp extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_codecomp()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_codecomp = null;
         _loc1_ = new FSM_codecomp();
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
               this.i1 = li32(mstate.ebp + 20);
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_exp2RK.start();
               return;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i3 = li32(mstate.ebp + 24);
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaK_exp2RK.start();
               return;
            case 2:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i3);
               this.i6 = li32(mstate.ebp + 12);
               this.i7 = li32(mstate.ebp + 16);
               if(this.i5 == 12)
               {
                  this.i3 = li32(this.i3 + 4);
                  this.i5 = this.i3 & 256;
                  if(this.i5 == 0)
                  {
                     this.i5 = li8(this.i0 + 50);
                     if(this.i5 <= this.i3)
                     {
                        this.i3 = li32(this.i0 + 36);
                        this.i3 += -1;
                        si32(this.i3,this.i0 + 36);
                     }
                  }
               }
               this.i3 = li32(this.i1);
               this.i5 = this.i1;
               if(this.i3 == 12)
               {
                  this.i3 = li32(this.i1 + 4);
                  this.i8 = this.i3 & 256;
                  if(this.i8 == 0)
                  {
                     this.i8 = li8(this.i0 + 50);
                     if(this.i8 <= this.i3)
                     {
                        this.i3 = li32(this.i0 + 36);
                        this.i3 += -1;
                        si32(this.i3,this.i0 + 36);
                     }
                  }
               }
               this.i3 = -1;
               this.i8 = this.i6 != 23 ? 1 : 0;
               this.i9 = this.i7 == 0 ? 1 : 0;
               this.i8 = this.i9 & this.i8;
               this.i8 &= 1;
               this.i7 <<= 6;
               this.i9 = this.i8 != 0 ? int(this.i4) : int(this.i2);
               this.i7 = this.i8 != 0 ? 64 : int(this.i7);
               this.i10 = li32(this.i0 + 12);
               this.i10 = li32(this.i10 + 8);
               this.i2 = this.i8 != 0 ? int(this.i2) : int(this.i4);
               this.i4 = this.i7 | this.i6;
               this.i6 = this.i9 << 23;
               this.i4 |= this.i6;
               this.i2 <<= 14;
               mstate.esp -= 12;
               this.i2 = this.i4 | this.i2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i0 + 32);
               si32(this.i3,this.i0 + 32);
               this.i3 = li32(this.i0 + 12);
               this.i3 = li32(this.i3 + 8);
               mstate.esp -= 12;
               this.i4 = 2147450902;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -4);
               mstate.esp -= 12;
               this.i3 = mstate.ebp + -4;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 5:
               mstate.esp += 12;
               this.i0 = li32(mstate.ebp + -4);
               si32(this.i0,this.i1 + 4);
               this.i0 = 10;
               si32(this.i0,this.i5);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _codecomp";
         }
      }
   }
}
