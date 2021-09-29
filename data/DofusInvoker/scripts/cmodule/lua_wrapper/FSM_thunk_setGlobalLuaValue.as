package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_thunk_setGlobalLuaValue extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public function FSM_thunk_setGlobalLuaValue()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_thunk_setGlobalLuaValue = null;
         _loc1_ = new FSM_thunk_setGlobalLuaValue();
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
               mstate.esp -= 28;
               this.i0 = __2E_str15114;
               mstate.esp -= 20;
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = mstate.ebp + -28;
               this.i3 = mstate.ebp + -24;
               this.i4 = mstate.ebp + -20;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               si32(this.i2,mstate.esp + 16);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[_AS3_ArrayValue]();
               return;
            case 1:
               mstate.esp += 20;
               this.i0 = li32(mstate.ebp + -28);
               this.i1 = li32(mstate.ebp + -24);
               this.i2 = li32(mstate.ebp + -20);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_push_as3_to_lua_stack.start();
               return;
            case 2:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i0 = -10002;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 3:
               break;
            case 4:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,mstate.ebp + -16);
               si32(this.i5,mstate.ebp + -8);
               this.i1 = li32(this.i2 + 8);
               mstate.esp -= 16;
               this.i1 += -12;
               this.i3 = mstate.ebp + -16;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 5;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 5:
               mstate.esp += 16;
               this.i0 = li32(this.i2 + 8);
               this.i0 += -12;
               si32(this.i0,this.i2 + 8);
               this.i0 = 0;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _thunk_setGlobalLuaValue";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i3 = li8(this.i1);
         this.i4 = this.i1;
         if(this.i3 != 0)
         {
            this.i3 = this.i1;
            while(true)
            {
               this.i5 = li8(this.i3 + 1);
               this.i3 += 1;
               this.i6 = this.i3;
               if(this.i5 == 0)
               {
                  break;
               }
               this.i3 = this.i6;
            }
         }
         else
         {
            this.i3 = this.i4;
         }
         this.i5 = 4;
         mstate.esp -= 12;
         this.i1 = this.i3 - this.i1;
         si32(this.i2,mstate.esp);
         si32(this.i4,mstate.esp + 4);
         si32(this.i1,mstate.esp + 8);
         state = 4;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
