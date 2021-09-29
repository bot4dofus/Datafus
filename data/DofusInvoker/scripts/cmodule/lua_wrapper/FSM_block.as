package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_block extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public function FSM_block()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_block = null;
         _loc1_ = new FSM_block();
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
               mstate.esp -= 16;
               this.i0 = -1;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 36);
               si32(this.i0,mstate.ebp + -12);
               this.i0 = 0;
               si8(this.i0,mstate.ebp + -6);
               this.i3 = li8(this.i2 + 50);
               si8(this.i3,mstate.ebp + -8);
               si8(this.i0,mstate.ebp + -7);
               this.i0 = li32(this.i2 + 20);
               si32(this.i0,mstate.ebp + -16);
               this.i0 = mstate.ebp + -16;
               si32(this.i0,this.i2 + 20);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 1;
               mstate.esp -= 4;
               FSM_chunk.start();
               return;
            case 1:
               mstate.esp += 4;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 2;
               mstate.esp -= 4;
               FSM_leaveblock.start();
               return;
            case 2:
               mstate.esp += 4;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _block";
         }
      }
   }
}
