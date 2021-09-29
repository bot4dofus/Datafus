package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_math_frexp extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_math_frexp()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_math_frexp = null;
         _loc1_ = new FSM_math_frexp();
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
               mstate.esp -= 32;
               this.i0 = 1;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checknumber.start();
               return;
            case 1:
               this.f0 = mstate.st0;
               sf64(this.f0,mstate.ebp + -8);
               this.i0 = li32(mstate.ebp + -4);
               this.i2 = this.i0 >>> 20;
               mstate.esp += 8;
               this.i3 = li32(mstate.ebp + -8);
               this.i2 &= 2047;
               this.i4 = this.i0;
               if(this.i2 != 0)
               {
                  if(this.i2 != 2047)
                  {
                     this.i0 |= 1071644672;
                     this.i0 &= -1074790401;
                     si32(this.i3,mstate.ebp + -32);
                     si32(this.i0,mstate.ebp + -28);
                     this.f0 = lf64(mstate.ebp + -32);
                     this.i0 = this.i2 + -1022;
                  }
               }
               else
               {
                  this.i0 = this.i4 & 1048575;
                  this.i0 |= this.i3;
                  if(this.i0 == 0)
                  {
                     this.i0 = 0;
                  }
                  else
                  {
                     this.f0 *= 5.36312e+154;
                     sf64(this.f0,mstate.ebp + -16);
                     this.i0 = li32(mstate.ebp + -12);
                     this.i2 = this.i0 | 1071644672;
                     this.i3 = li32(mstate.ebp + -16);
                     this.i2 &= -1074790401;
                     this.i0 >>>= 20;
                     si32(this.i3,mstate.ebp + -24);
                     si32(this.i2,mstate.ebp + -20);
                     this.i0 &= 2047;
                     this.f0 = lf64(mstate.ebp + -24);
                     this.i0 += -1536;
                  }
               }
               this.i2 = 3;
               this.i3 = li32(this.i1 + 8);
               sf64(this.f0,this.i3);
               si32(this.i2,this.i3 + 8);
               this.i3 = li32(this.i1 + 8);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i1 + 8);
               this.f0 = Number(this.i0);
               sf64(this.f0,this.i3 + 12);
               si32(this.i2,this.i3 + 20);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               this.i0 = 2;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _math_frexp";
         }
      }
   }
}
