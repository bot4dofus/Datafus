package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_stack_init extends Machine
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
      
      public function FSM_stack_init()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_stack_init = null;
         _loc1_ = new FSM_stack_init();
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
               this.i0 = 192;
               this.i1 = li32(mstate.ebp + 12);
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
               this.i4 = li32(mstate.ebp + 8);
               if(this.i0 == 0)
               {
                  this.i5 = 4;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               §§goto(addr179);
               break;
            case 2:
               mstate.esp += 8;
               addr179:
               this.i5 = 8;
               this.i6 = li32(this.i2 + 68);
               this.i6 += 192;
               si32(this.i6,this.i2 + 68);
               si32(this.i0,this.i4 + 40);
               si32(this.i0,this.i4 + 20);
               si32(this.i5,this.i4 + 48);
               this.i0 += 168;
               si32(this.i0,this.i4 + 36);
               this.i0 = li32(this.i3);
               this.i2 = li32(this.i0 + 12);
               this.i3 = li32(this.i0 + 16);
               mstate.esp -= 16;
               this.i5 = 0;
               this.i6 = 540;
               si32(this.i3,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 3;
               mstate.esp -= 4;
               mstate.funcs[this.i2]();
               return;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i3 = this.i4 + 20;
               if(this.i2 == 0)
               {
                  this.i5 = 4;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               break;
            case 4:
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _stack_init";
         }
         this.i1 = 45;
         this.i5 = li32(this.i0 + 68);
         this.i5 += 540;
         si32(this.i5,this.i0 + 68);
         si32(this.i2,this.i4 + 32);
         si32(this.i1,this.i4 + 44);
         si32(this.i2,this.i4 + 8);
         this.i0 = this.i2 + 468;
         si32(this.i0,this.i4 + 28);
         this.i0 = li32(this.i3);
         si32(this.i2,this.i0 + 4);
         this.i0 = li32(this.i4 + 8);
         this.i1 = 0;
         si32(this.i1,this.i0 + 8);
         this.i0 += 12;
         si32(this.i0,this.i4 + 8);
         this.i1 = li32(this.i3);
         si32(this.i0,this.i1);
         si32(this.i0,this.i4 + 12);
         this.i0 = li32(this.i4 + 8);
         this.i1 = li32(this.i3);
         this.i0 += 240;
         si32(this.i0,this.i1 + 8);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
