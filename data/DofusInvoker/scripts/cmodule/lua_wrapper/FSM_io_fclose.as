package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_io_fclose extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public function FSM_io_fclose()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_io_fclose = null;
         _loc1_ = new FSM_io_fclose();
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
               this.i2 = li32(this.i0);
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 2;
               mstate.esp -= 4;
               FSM_fclose.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i3 = 0;
               si32(this.i3,this.i0);
               this.i0 = this.i2 == 0 ? 1 : 0;
               mstate.esp -= 12;
               this.i0 &= 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_pushresult.start();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _io_fclose";
         }
      }
   }
}
