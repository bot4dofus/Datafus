package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaB_yield extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaB_yield()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_yield = null;
         _loc1_ = new FSM_luaB_yield();
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
               this.i1 = li32(this.i0 + 8);
               this.i2 = li32(this.i0 + 12);
               this.i3 = li16(this.i0 + 52);
               this.i4 = li16(this.i0 + 54);
               this.i1 -= this.i2;
               this.i2 = this.i0 + 12;
               this.i5 = this.i0 + 8;
               if(uint(this.i3) > uint(this.i4))
               {
                  this.i3 = __2E_str818;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               break;
            case 1:
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _luaB_yield";
         }
         this.i3 = 1;
         this.i1 /= -12;
         this.i4 = li32(this.i5);
         this.i1 *= 12;
         this.i1 = this.i4 + this.i1;
         si32(this.i1,this.i2);
         si8(this.i3,this.i0 + 6);
         this.i0 = -1;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
