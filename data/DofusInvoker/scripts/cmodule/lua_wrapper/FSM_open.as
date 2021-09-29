package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_open extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_open()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_open = null;
         _loc1_ = new FSM_open();
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
               mstate.esp -= 4100;
               this.i1 = li32(mstate.ebp + 12);
               this.i0 = li32(mstate.ebp + 8);
               this.i2 = this.i1 & 512;
               if(this.i2 == 0)
               {
                  this.i2 = 0;
               }
               else
               {
                  this.i2 = mstate.ebp + 16;
                  si32(this.i2,mstate.ebp + -4100);
                  this.i2 = mstate.ebp + 20;
                  si32(this.i2,mstate.ebp + -4100);
                  this.i2 = li32(mstate.ebp + 16);
               }
               state = 1;
            case 1:
               this.i0 = mstate.system.open(this.i0,this.i1,this.i2);
               this.i2 = this.i0;
               if(this.i2 <= -1)
               {
                  this.i0 = __2E_str96;
                  mstate.esp -= 20;
                  this.i1 = __2E_str13;
                  this.i3 = 73;
                  this.i4 = 2;
                  this.i5 = mstate.ebp + -4096;
                  si32(this.i5,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i4,mstate.esp + 8);
                  si32(this.i1,mstate.esp + 12);
                  si32(this.i3,mstate.esp + 16);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_sprintf.start();
                  return;
               }
               break;
            case 2:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i5;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i4,_val_2E_1440);
               break;
            default:
               throw "Invalid state in _open";
         }
         mstate.eax = this.i2;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
