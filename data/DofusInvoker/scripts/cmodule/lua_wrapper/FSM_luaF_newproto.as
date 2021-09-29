package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaF_newproto extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaF_newproto()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaF_newproto = null;
         _loc1_ = new FSM_luaF_newproto();
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
               this.i0 = 76;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 16);
               this.i3 = li32(this.i2 + 12);
               this.i4 = li32(this.i2 + 16);
               mstate.esp -= 16;
               this.i5 = 0;
               si32(this.i4,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[this.i3]();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i3 = this.i1 + 16;
               if(this.i0 == 0)
               {
                  this.i4 = 4;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               break;
            case 2:
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _luaF_newproto";
         }
         this.i1 = 9;
         this.i4 = li32(this.i2 + 68);
         this.i4 += 76;
         si32(this.i4,this.i2 + 68);
         this.i2 = li32(this.i3);
         this.i3 = li32(this.i2 + 28);
         si32(this.i3,this.i0);
         si32(this.i0,this.i2 + 28);
         this.i2 = li8(this.i2 + 20);
         this.i2 &= 3;
         si8(this.i2,this.i0 + 5);
         si8(this.i1,this.i0 + 4);
         this.i1 = 0;
         si32(this.i1,this.i0 + 8);
         si32(this.i1,this.i0 + 40);
         si32(this.i1,this.i0 + 16);
         si32(this.i1,this.i0 + 52);
         si32(this.i1,this.i0 + 12);
         si32(this.i1,this.i0 + 44);
         si32(this.i1,this.i0 + 48);
         si32(this.i1,this.i0 + 36);
         si8(this.i1,this.i0 + 72);
         si32(this.i1,this.i0 + 28);
         si8(this.i1,this.i0 + 73);
         si8(this.i1,this.i0 + 74);
         si8(this.i1,this.i0 + 75);
         si32(this.i1,this.i0 + 20);
         si32(this.i1,this.i0 + 56);
         si32(this.i1,this.i0 + 24);
         si32(this.i1,this.i0 + 60);
         si32(this.i1,this.i0 + 64);
         si32(this.i1,this.i0 + 32);
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
