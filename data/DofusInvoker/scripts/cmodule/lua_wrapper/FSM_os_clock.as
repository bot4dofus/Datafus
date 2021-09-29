package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_os_clock extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_os_clock()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_os_clock = null;
         _loc1_ = new FSM_os_clock();
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
               mstate.esp -= 4096;
               this.i0 = __2E_str424;
               this.i1 = 4;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 20;
               this.i0 = __2E_str96;
               this.i1 = __2E_str121;
               this.i2 = 12;
               this.i3 = 78;
               this.i4 = mstate.ebp + -4096;
               si32(this.i4,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               si32(this.i2,mstate.esp + 16);
               state = 1;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 1:
               mstate.esp += 20;
               this.i2 = 3;
               this.i0 = this.i4;
               this.i1 = this.i2;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i3,_val_2E_1440);
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 8);
               this.i3 = 1098907647;
               this.i4 = -2097152;
               si32(this.i4,this.i1);
               si32(this.i3,this.i1 + 4);
               si32(this.i2,this.i1 + 8);
               this.i1 = li32(this.i0 + 8);
               this.i1 += 12;
               si32(this.i1,this.i0 + 8);
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _os_clock";
         }
      }
   }
}
