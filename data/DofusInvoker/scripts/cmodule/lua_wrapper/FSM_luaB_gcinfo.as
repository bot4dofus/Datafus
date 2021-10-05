package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_gcinfo extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i3:int;
      
      public function FSM_luaB_gcinfo()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_gcinfo = null;
         _loc1_ = new FSM_luaB_gcinfo();
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
               this.i2 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_lua_gc.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(this.i1 + 8);
               this.f0 = Number(this.i0);
               sf64(this.f0,this.i3);
               si32(this.i2,this.i3 + 8);
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
               throw "Invalid state in _luaB_gcinfo";
         }
      }
   }
}
