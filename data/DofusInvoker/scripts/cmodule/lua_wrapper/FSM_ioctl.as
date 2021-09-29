package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_ioctl extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public function FSM_ioctl()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_ioctl = null;
         _loc1_ = new FSM_ioctl();
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
               this.i0 = mstate.ebp + 12;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i0,mstate.ebp + -4);
               this.i0 = mstate.ebp + -4;
               if(this.i1 == 0)
               {
                  this.i1 = ___sF;
                  mstate.esp -= 12;
                  this.i0 = __2E_str7403;
                  this.i2 = 1076655123;
                  this.i1 += 176;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_fprintf.start();
                  return;
               }
               this.i2 = 1076655123;
               this.i3 = li32(mstate.ebp + -4);
               this.i0 = this.i1;
               this.i1 = this.i2;
               this.i2 = this.i3;
               state = 2;
            case 2:
               this.i0 = mstate.system.ioctl(this.i0,this.i1,this.i2);
               mstate.eax = this.i0;
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i1 = -1;
               mstate.eax = this.i1;
               break;
            default:
               throw "Invalid state in _ioctl";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
