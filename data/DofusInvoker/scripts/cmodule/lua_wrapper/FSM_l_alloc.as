package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_l_alloc extends Machine
   {
      
      public static const intRegCount:int = 2;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public function FSM_l_alloc()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_l_alloc = null;
         _loc1_ = new FSM_l_alloc();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(mstate.ebp + 20);
               if(this.i1 == 0)
               {
                  this.i1 = 0;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
               break;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.eax = this.i1;
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.eax = this.i0;
               break;
            default:
               throw "Invalid state in _l_alloc";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
