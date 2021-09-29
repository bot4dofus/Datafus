package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_math_ldexp extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
      
      public function FSM_math_ldexp()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_math_ldexp = null;
         _loc1_ = new FSM_math_ldexp();
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
               mstate.esp -= 88;
               this.i0 = 2;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checkinteger.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_checknumber.start();
               return;
            case 2:
               this.f0 = mstate.st0;
               sf64(this.f0,mstate.ebp + -8);
               this.i2 = li32(mstate.ebp + -4);
               this.i3 = this.i2 >>> 20;
               mstate.esp += 8;
               this.i4 = li32(mstate.ebp + -8);
               this.i3 &= 2047;
               this.i5 = this.i2;
               this.i2 &= 2146435072;
               if(this.i2 != 0)
               {
                  this.i4 = this.i5;
                  this.i5 = this.i3;
                  addr242:
                  this.i2 = this.i4;
                  this.i3 = this.i5;
                  if(this.i3 == 2047)
                  {
                     this.f0 += this.f0;
                  }
                  else
                  {
                     this.i3 += this.i0;
                     if(this.i3 >= 2047)
                     {
                        this.i0 = -2013235812;
                        sf64(this.f0,mstate.ebp + -24);
                        this.i2 = li32(mstate.ebp + -20);
                        this.i2 |= 2117592124;
                        this.i2 &= -29891524;
                        si32(this.i0,mstate.ebp + -32);
                        si32(this.i2,mstate.ebp + -28);
                        this.f0 = lf64(mstate.ebp + -32);
                        this.f0 *= 1e+300;
                     }
                     else if(this.i3 >= 1)
                     {
                        sf64(this.f0,mstate.ebp + -40);
                        this.i0 = this.i3 << 20;
                        this.i2 &= -2146435073;
                        this.i3 = li32(mstate.ebp + -40);
                        this.i0 |= this.i2;
                        si32(this.i3,mstate.ebp + -48);
                        si32(this.i0,mstate.ebp + -44);
                        this.f0 = lf64(mstate.ebp + -48);
                     }
                     else if(this.i3 <= -54)
                     {
                        sf64(this.f0,mstate.ebp + -56);
                        this.i2 = li32(mstate.ebp + -56);
                        this.i2 = li32(mstate.ebp + -52);
                        if(this.i0 >= 50001)
                        {
                           this.i3 = -2013235812;
                           this.i2 |= 2117592124;
                           this.i2 &= -29891524;
                           si32(this.i3,mstate.ebp + -64);
                           si32(this.i2,mstate.ebp + -60);
                           this.f0 = lf64(mstate.ebp + -64);
                           this.f0 *= 1e+300;
                        }
                        else
                        {
                           this.i3 = -1023872167;
                           this.i2 |= 27618847;
                           this.i2 &= -2119864801;
                           si32(this.i3,mstate.ebp + -72);
                           si32(this.i2,mstate.ebp + -68);
                           this.f0 = lf64(mstate.ebp + -72);
                           this.f0 *= 1e-300;
                        }
                     }
                     else
                     {
                        this.i0 = this.i3 << 20;
                        sf64(this.f0,mstate.ebp + -80);
                        this.i0 += 56623104;
                        this.i2 &= -2146435073;
                        this.i3 = li32(mstate.ebp + -80);
                        this.i0 |= this.i2;
                        si32(this.i3,mstate.ebp + -88);
                        si32(this.i0,mstate.ebp + -84);
                        this.f0 = lf64(mstate.ebp + -88);
                        this.f0 *= 5.55112e-17;
                     }
                  }
               }
               else
               {
                  this.i5 &= 2147483647;
                  this.i4 = this.i5 | this.i4;
                  if(this.i4 != 0)
                  {
                     this.f0 *= 18014400000000000;
                     sf64(this.f0,mstate.ebp + -16);
                     this.i4 = li32(mstate.ebp + -12);
                     this.i5 = this.i4 >>> 20;
                     this.i5 &= 2047;
                     this.i5 += -54;
                     if(this.i0 >= -50000)
                     {
                        §§goto(addr242);
                     }
                     else
                     {
                        this.f0 *= 1e-300;
                     }
                  }
               }
               this.i0 = 3;
               this.i2 = li32(this.i1 + 8);
               sf64(this.f0,this.i2);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _math_ldexp";
         }
      }
   }
}
