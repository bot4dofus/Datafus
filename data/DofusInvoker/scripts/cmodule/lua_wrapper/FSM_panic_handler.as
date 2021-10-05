package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_panic_handler extends Machine
   {
      
      public static const intRegCount:int = 3;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public function FSM_panic_handler()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_panic_handler = null;
         _loc1_ = new FSM_panic_handler();
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
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i0 = __2E_str157;
               trace(mstate.gworker.stringFromPtr(this.i0));
               if(this.i1 != 0)
               {
                  this.i0 = __2E_str21178;
                  trace(mstate.gworker.stringFromPtr(this.i0));
                  this.i0 = this.i1;
               }
               else
               {
                  this.i0 = __2E_str22179;
               }
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               this.i0 = -1;
               si32(this.i0,mstate.esp);
               state = 2;
               mstate.esp -= 4;
               FSM_exit.start();
               return;
            case 2:
               mstate.esp += 4;
         }
         throw "Invalid state in _panic_handler";
      }
   }
}
