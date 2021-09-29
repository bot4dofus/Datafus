package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_freestack extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public function FSM_freestack()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_freestack = null;
         _loc1_ = new FSM_freestack();
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
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(this.i1 + 16);
               this.i4 = li32(this.i2 + 48);
               this.i5 = li32(this.i2 + 40);
               this.i6 = li32(this.i3 + 12);
               this.i7 = li32(this.i3 + 16);
               mstate.esp -= 16;
               this.i4 *= 24;
               si32(this.i7,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[this.i6]();
               return;
            case 1:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               this.i5 = li32(this.i3 + 68);
               this.i4 = this.i5 - this.i4;
               si32(this.i4,this.i3 + 68);
               this.i1 = li32(this.i1 + 16);
               this.i3 = li32(this.i2 + 44);
               this.i2 = li32(this.i2 + 32);
               this.i4 = li32(this.i1 + 12);
               this.i5 = li32(this.i1 + 16);
               mstate.esp -= 16;
               this.i3 *= 12;
               si32(this.i5,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 2;
               mstate.esp -= 4;
               mstate.funcs[this.i4]();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = li32(this.i1 + 68);
               this.i0 -= this.i3;
               si32(this.i0,this.i1 + 68);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _freestack";
         }
      }
   }
}
