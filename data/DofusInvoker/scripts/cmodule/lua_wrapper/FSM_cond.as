package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_cond extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public function FSM_cond()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_cond = null;
         _loc1_ = new FSM_cond();
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
               mstate.esp -= 32;
               this.i0 = mstate.ebp + -32;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_subexpr.start();
               return;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(mstate.ebp + -32);
               this.i3 = this.i0 + 16;
               this.i1 += 36;
               if(this.i2 == 1)
               {
                  this.i2 = 3;
                  si32(this.i2,this.i0);
                  this.i1 = li32(this.i1);
                  mstate.esp -= 8;
                  this.i0 = mstate.ebp + -32;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaK_goiftrue.start();
                  return;
               }
               this.i0 = mstate.ebp + -32;
               this.i1 = li32(this.i1);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaK_goiftrue.start();
               return;
               break;
            case 2:
               mstate.esp += 8;
               this.i1 = li32(this.i3);
               mstate.eax = this.i1;
               break;
            case 3:
               mstate.esp += 8;
               this.i0 = li32(this.i3);
               mstate.eax = this.i0;
               break;
            default:
               throw "Invalid state in _cond";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
