package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_error extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaL_error()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_error = null;
         _loc1_ = new FSM_luaL_error();
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
               mstate.esp -= 4;
               this.i0 = mstate.ebp + 16;
               si32(this.i0,mstate.ebp + -4);
               this.i0 = li32(mstate.ebp + 8);
               mstate.esp -= 8;
               this.i1 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_where.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i1 = li32(this.i0 + 16);
               this.i2 = li32(mstate.ebp + -4);
               this.i3 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               this.i4 = this.i0 + 16;
               this.i5 = mstate.ebp + -4;
               this.i5 = li32(mstate.ebp + 12);
               if(uint(this.i3) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaO_pushvfstring.start();
               return;
               break;
            case 2:
               mstate.esp += 4;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaO_pushvfstring.start();
               return;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               addr270:
               this.i1 = li32(this.i4);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 4:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr270);
            case 5:
               mstate.esp += 4;
               break;
            case 6:
               mstate.esp += 12;
               this.i1 = li32(this.i0 + 8);
               this.i1 += -12;
               si32(this.i1,this.i0 + 8);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 7;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 7:
               mstate.esp += 4;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaL_error";
         }
         this.i1 = 2;
         this.i2 = li32(this.i0 + 8);
         this.i3 = li32(this.i0 + 12);
         this.i2 -= this.i3;
         this.i2 /= 12;
         mstate.esp -= 12;
         this.i2 += -1;
         si32(this.i0,mstate.esp);
         si32(this.i1,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 6;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
