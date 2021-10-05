package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_close_state extends Machine
   {
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_close_state()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_close_state = null;
         _loc1_ = new FSM_close_state();
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
               this.i0 = 67;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 16);
               this.i3 = li32(this.i1 + 32);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaF_close.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 16);
               si8(this.i0,this.i3 + 20);
               mstate.esp -= 12;
               this.i0 = -3;
               this.i4 = this.i3 + 28;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_sweeplist.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i3 + 8);
               this.i4 = this.i3 + 8;
               this.i5 = this.i1 + 32;
               this.i6 = this.i1 + 16;
               if(this.i0 < 1)
               {
                  break;
               }
               this.i0 = 0;
               this.i7 = this.i0;
               §§goto(addr197);
               break;
            case 3:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               this.i8 = li32(this.i4);
               this.i7 += 4;
               this.i0 += 1;
               if(this.i8 > this.i0)
               {
                  addr197:
                  this.i8 = -3;
                  this.i9 = li32(this.i3);
                  mstate.esp -= 12;
                  this.i9 += this.i7;
                  si32(this.i1,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i8,mstate.esp + 8);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_sweeplist.start();
                  return;
               }
               break;
            case 4:
               this.i7 = mstate.eax;
               mstate.esp += 16;
               this.i7 = li32(this.i3 + 68);
               this.i4 = this.i7 - this.i4;
               si32(this.i4,this.i3 + 68);
               this.i3 = li32(this.i6);
               this.i4 = li32(this.i2 + 60);
               this.i7 = li32(this.i2 + 52);
               this.i8 = li32(this.i3 + 12);
               this.i9 = li32(this.i3 + 16);
               mstate.esp -= 16;
               si32(this.i9,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 5;
               mstate.esp -= 4;
               mstate.funcs[this.i8]();
               return;
            case 5:
               this.i7 = mstate.eax;
               mstate.esp += 16;
               this.i8 = li32(this.i3 + 68);
               this.i4 = this.i8 - this.i4;
               si32(this.i4,this.i3 + 68);
               si32(this.i7,this.i2 + 52);
               si32(this.i0,this.i2 + 60);
               this.i3 = li32(this.i6);
               this.i4 = li32(this.i1 + 48);
               this.i7 = li32(this.i1 + 40);
               this.i8 = li32(this.i3 + 12);
               this.i9 = li32(this.i3 + 16);
               mstate.esp -= 16;
               this.i4 *= 24;
               si32(this.i9,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               mstate.funcs[this.i8]();
               return;
            case 6:
               this.i7 = mstate.eax;
               mstate.esp += 16;
               this.i7 = li32(this.i3 + 68);
               this.i4 = this.i7 - this.i4;
               si32(this.i4,this.i3 + 68);
               this.i3 = li32(this.i6);
               this.i4 = li32(this.i1 + 44);
               this.i5 = li32(this.i5);
               this.i6 = li32(this.i3 + 12);
               this.i7 = li32(this.i3 + 16);
               mstate.esp -= 16;
               this.i4 *= 12;
               si32(this.i7,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               mstate.funcs[this.i6]();
               return;
            case 7:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               this.i5 = li32(this.i3 + 68);
               this.i4 = this.i5 - this.i4;
               si32(this.i4,this.i3 + 68);
               this.i3 = li32(this.i2 + 12);
               this.i2 = li32(this.i2 + 16);
               mstate.esp -= 16;
               this.i4 = 348;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 8;
               mstate.esp -= 4;
               mstate.funcs[this.i3]();
               return;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _close_state";
         }
         this.i0 = 0;
         this.i3 = li32(this.i6);
         this.i4 = li32(this.i3 + 8);
         this.i7 = li32(this.i3);
         this.i8 = li32(this.i3 + 12);
         this.i9 = li32(this.i3 + 16);
         mstate.esp -= 16;
         this.i4 <<= 2;
         si32(this.i9,mstate.esp);
         si32(this.i7,mstate.esp + 4);
         si32(this.i4,mstate.esp + 8);
         si32(this.i0,mstate.esp + 12);
         state = 4;
         mstate.esp -= 4;
         mstate.funcs[this.i8]();
      }
   }
}
