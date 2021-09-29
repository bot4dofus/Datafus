package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaK_exp2val extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaK_exp2val()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaK_exp2val = null;
         _loc1_ = new FSM_luaK_exp2val();
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
               this.i1 = li32(this.i0 + 12);
               this.i2 = li32(this.i0 + 16);
               mstate.esp -= 8;
               this.i3 = li32(mstate.ebp + 8);
               si32(this.i3,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_dischargevars.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i4 = this.i0 + 16;
               this.i5 = this.i0 + 12;
               if(this.i1 != this.i2)
               {
                  this.i1 = li32(this.i0);
                  if(this.i1 == 12)
                  {
                     this.i1 = li32(this.i5);
                     this.i2 = li32(this.i4);
                     this.i4 = li32(this.i0 + 4);
                     if(this.i1 == this.i2)
                     {
                        break;
                     }
                     this.i1 = li8(this.i3 + 50);
                     if(this.i4 >= this.i1)
                     {
                        mstate.esp -= 12;
                        si32(this.i3,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i4,mstate.esp + 8);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_exp2reg.start();
                        return;
                     }
                  }
                  mstate.esp -= 8;
                  si32(this.i3,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaK_exp2nextreg.start();
                  return;
               }
               break;
            case 2:
               mstate.esp += 12;
               break;
            case 3:
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _luaK_exp2val";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
