package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_math_random extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 2;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public function FSM_math_random()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_math_random = null;
         _loc1_ = new FSM_math_random();
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
               mstate.esp -= 0;
               this.i0 = li32(_next);
               this.i1 = li32(mstate.ebp + 8);
               if(this.i0 == 0)
               {
                  this.i0 = 123459876;
                  si32(this.i0,_next);
               }
               this.i2 = uint(this.i0) / uint(127773);
               this.i3 = this.i2 * 127773;
               this.i0 -= this.i3;
               this.i2 *= 2836;
               this.i0 *= 16807;
               this.i0 -= this.i2;
               this.i2 = this.i0 + 2147483647;
               this.i0 = this.i0 > -1 ? int(this.i0) : int(this.i2);
               this.i2 = this.i0 & 2147483647;
               this.i3 = uint(this.i2) / uint(2147483647);
               this.i3 *= 2147483647;
               si32(this.i0,_next);
               this.i0 = this.i2 - this.i3;
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               this.i3 = this.i2 - this.i3;
               this.f0 = Number(this.i0);
               this.i0 = this.i3 / 12;
               this.i3 = this.i1 + 8;
               this.f0 /= 2147480000;
               if(this.i0 != 2)
               {
                  if(this.i0 != 1)
                  {
                     if(this.i0 == 0)
                     {
                        this.i1 = 3;
                        sf64(this.f0,this.i2);
                        si32(this.i1,this.i2 + 8);
                        addr424:
                        this.i1 = li32(this.i3);
                        this.i1 += 12;
                        si32(this.i1,this.i3);
                        this.i1 = 1;
                        mstate.eax = this.i1;
                        break;
                     }
                     this.i0 = __2E_str29377;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_luaL_error.start();
                     return;
                  }
                  this.i0 = 1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaL_checkinteger.start();
                  return;
               }
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaL_checkinteger.start();
               return;
               break;
            case 1:
               this.i0 = mstate.eax;
               this.f1 = Number(this.i0);
               mstate.esp += 8;
               this.f0 = this.f1 * this.f0;
               if(this.i0 <= 0)
               {
                  this.i0 = __2E_str28376;
                  mstate.esp -= 12;
                  this.i2 = 1;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               this.i1 = 3;
               this.f0 = Math.floor(this.f0);
               this.i0 = li32(this.i3);
               this.f0 += 1;
               addr412:
               sf64(this.f0,this.i0);
               si32(this.i1,this.i0 + 8);
               §§goto(addr424);
               break;
            case 2:
               mstate.esp += 12;
               this.f0 = Math.floor(this.f0);
               this.i1 = li32(this.i3);
               this.f0 += 1;
               sf64(this.f0,this.i1);
               this.i0 = 3;
               si32(this.i0,this.i1 + 8);
               this.i1 = li32(this.i3);
               this.i1 += 12;
               si32(this.i1,this.i3);
               mstate.eax = this.i2;
               break;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaL_checkinteger.start();
               return;
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 > this.i2)
               {
                  this.i4 = __2E_str28376;
                  mstate.esp -= 12;
                  this.i5 = 2;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i4,mstate.esp + 8);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               addr619:
               this.i1 = 3;
               this.i4 = 1 - this.i0;
               this.i2 = this.i4 + this.i2;
               this.f1 = Number(this.i2);
               this.f0 = this.f1 * this.f0;
               this.f0 = Math.floor(this.f0);
               this.f1 = Number(this.i0);
               this.i0 = li32(this.i3);
               this.f0 += this.f1;
               §§goto(addr412);
               break;
            case 5:
               mstate.esp += 12;
               §§goto(addr619);
            case 6:
               mstate.esp += 8;
               this.i0 = 0;
               mstate.eax = this.i0;
               break;
            default:
               throw "Invalid state in _math_random";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
