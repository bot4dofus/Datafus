package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_math_min extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 2;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var i3:int;
      
      public function FSM_math_min()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_math_min = null;
         _loc1_ = new FSM_math_min();
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
               this.i0 = 1;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checknumber.start();
               return;
            case 1:
               this.f0 = mstate.st0;
               this.i0 = this.i2 - this.i3;
               mstate.esp += 8;
               this.i2 = this.i0 / 12;
               this.i3 = this.i1 + 8;
               if(this.i0 < 24)
               {
                  break;
               }
               this.i0 = 2;
               §§goto(addr121);
               break;
            case 2:
               this.f1 = mstate.st0;
               mstate.esp += 8;
               this.f0 = this.f1 < this.f0 ? Number(this.f1) : Number(this.f0);
               this.i0 += 1;
               if(this.i0 <= this.i2)
               {
                  addr121:
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaL_checknumber.start();
                  return;
               }
               break;
            default:
               throw "Invalid state in _math_min";
         }
         this.i0 = 3;
         this.i1 = li32(this.i3);
         sf64(this.f0,this.i1);
         si32(this.i0,this.i1 + 8);
         this.i0 = li32(this.i3);
         this.i0 += 12;
         si32(this.i0,this.i3);
         this.i0 = 1;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
