package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_callallgcTM392 extends Machine
   {
      
      public static const intRegCount:int = 3;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public function FSM_callallgcTM392()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_callallgcTM392 = null;
         _loc1_ = new FSM_callallgcTM392();
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
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 16);
               this.i1 = li32(this.i1 + 48);
               this.i2 = this.i0 + 16;
               if(this.i1 == 0)
               {
                  break;
               }
               §§goto(addr60);
               break;
            case 1:
               mstate.esp += 4;
               this.i1 = li32(this.i2);
               this.i1 = li32(this.i1 + 48);
               if(this.i1 == 0)
               {
                  break;
               }
               addr60:
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 1;
               mstate.esp -= 4;
               FSM_GCTM.start();
               return;
               break;
            default:
               throw "Invalid state in _callallgcTM392";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
