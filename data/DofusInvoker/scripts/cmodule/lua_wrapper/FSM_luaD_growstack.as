package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaD_growstack extends Machine
   {
      
      public static const intRegCount:int = 3;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public function FSM_luaD_growstack()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaD_growstack = null;
         _loc1_ = new FSM_luaD_growstack();
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
               this.i1 = li32(this.i0 + 44);
               this.i2 = li32(mstate.ebp + 12);
               if(this.i1 >= this.i2)
               {
                  mstate.esp -= 8;
                  this.i1 <<= 1;
               }
               else
               {
                  mstate.esp -= 8;
                  this.i1 += this.i2;
               }
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaD_reallocstack.start();
               return;
            case 1:
               mstate.esp += 8;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaD_growstack";
         }
      }
   }
}
