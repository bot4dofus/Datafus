package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_io_gc extends Machine
   {
      
      public static const intRegCount:int = 2;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public function FSM_io_gc()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_io_gc = null;
         _loc1_ = new FSM_io_gc();
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
               this.i0 = __2E_str17320;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checkudata.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               if(this.i0 != 0)
               {
                  this.i0 = 0;
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_aux_close.start();
                  return;
               }
               this.i0 = 0;
               break;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               break;
            default:
               throw "Invalid state in _io_gc";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
