package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaM_realloc_ extends Machine
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
      
      public function FSM_luaM_realloc_()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaM_realloc_ = null;
         _loc1_ = new FSM_luaM_realloc_();
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
               this.i1 = li32(this.i0 + 16);
               this.i2 = li32(this.i1 + 12);
               this.i3 = li32(this.i1 + 16);
               mstate.esp -= 16;
               this.i4 = li32(mstate.ebp + 16);
               this.i5 = li32(mstate.ebp + 20);
               this.i6 = li32(mstate.ebp + 12);
               si32(this.i3,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[this.i2]();
               return;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               if(this.i2 == 0)
               {
                  if(this.i5 != 0)
                  {
                     this.i3 = 4;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
                  break;
               }
               break;
            case 2:
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _luaM_realloc_";
         }
         this.i0 = li32(this.i1 + 68);
         this.i3 = this.i5 - this.i4;
         this.i0 = this.i3 + this.i0;
         si32(this.i0,this.i1 + 68);
         mstate.eax = this.i2;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
