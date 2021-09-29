package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_adjust_assign397 extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_adjust_assign397()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_adjust_assign397 = null;
         _loc1_ = new FSM_adjust_assign397();
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
               this.i0 = li32(mstate.ebp + 20);
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = li32(this.i0);
               this.i1 -= this.i2;
               this.i2 = li32(mstate.ebp + 8);
               this.i4 = this.i3 + -13;
               if(uint(this.i4) <= uint(1))
               {
                  this.i1 += 1;
                  mstate.esp -= 12;
                  this.i1 = this.i1 < 0 ? 0 : int(this.i1);
                  si32(this.i2,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaK_setreturns.start();
                  return;
               }
               if(this.i3 != 0)
               {
                  mstate.esp -= 8;
                  si32(this.i2,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaK_exp2nextreg.start();
                  return;
               }
               addr254:
               if(this.i1 >= 1)
               {
                  this.i0 = li32(this.i2 + 36);
                  mstate.esp -= 8;
                  si32(this.i2,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaK_checkstack.start();
                  return;
               }
               break;
            case 1:
               mstate.esp += 12;
               if(this.i1 >= 2)
               {
                  mstate.esp -= 8;
                  this.i0 = this.i1 + -1;
                  si32(this.i2,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaK_checkstack.start();
                  return;
               }
               break;
            case 2:
               mstate.esp += 8;
               this.i1 = li32(this.i2 + 36);
               this.i0 = this.i1 + this.i0;
               si32(this.i0,this.i2 + 36);
               break;
            case 3:
               mstate.esp += 8;
               §§goto(addr254);
            case 4:
               mstate.esp += 8;
               this.i3 = li32(this.i2 + 36);
               this.i3 += this.i1;
               si32(this.i3,this.i2 + 36);
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_luaK_nil.start();
               return;
            case 5:
               mstate.esp += 12;
               break;
            default:
               throw "Invalid state in _adjust_assign397";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
