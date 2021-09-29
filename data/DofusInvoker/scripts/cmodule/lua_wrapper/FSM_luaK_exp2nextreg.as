package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaK_exp2nextreg extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public function FSM_luaK_exp2nextreg()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaK_exp2nextreg = null;
         _loc1_ = new FSM_luaK_exp2nextreg();
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
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 12);
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_dischargevars.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i2 = li32(this.i1);
               if(this.i2 == 12)
               {
                  this.i2 = li32(this.i1 + 4);
                  this.i3 = this.i2 & 256;
                  if(this.i3 == 0)
                  {
                     this.i3 = li8(this.i0 + 50);
                     if(this.i3 <= this.i2)
                     {
                        this.i2 = li32(this.i0 + 36);
                        this.i2 += -1;
                        si32(this.i2,this.i0 + 36);
                     }
                  }
               }
               this.i2 = 1;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaK_checkstack.start();
               return;
            case 2:
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 36);
               this.i3 = this.i2 + 1;
               si32(this.i3,this.i0 + 36);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_exp2reg.start();
               return;
            case 3:
               mstate.esp += 12;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaK_exp2nextreg";
         }
      }
   }
}
