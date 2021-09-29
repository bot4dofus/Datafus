package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_fopen387 extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_fopen387()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_fopen387 = null;
         _loc1_ = new FSM_fopen387();
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
               this.i0 = mstate.ebp + -4;
               mstate.esp -= 16;
               this.i1 = si8(li8(mstate.ebp + 12));
               this.i2 = si8(li8(mstate.ebp + 16));
               this.i3 = si8(li8(mstate.ebp + 20));
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               mstate.esp -= 4;
               FSM___sflags386.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i1 = li32(mstate.ebp + 8);
               if(this.i0 == 0)
               {
                  addr122:
                  this.i0 = 0;
                  mstate.eax = this.i0;
                  break;
               }
               state = 2;
               mstate.esp -= 4;
               FSM___sfp.start();
               return;
               break;
            case 2:
               this.i2 = mstate.eax;
               if(this.i2 != 0)
               {
                  this.i3 = 438;
                  this.i4 = li32(mstate.ebp + -4);
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_open.start();
                  return;
               }
               §§goto(addr122);
               break;
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               if(this.i1 <= -1)
               {
                  this.i0 = 0;
                  si16(this.i0,this.i2 + 12);
               }
               else
               {
                  this.i3 = ___sread;
                  si16(this.i1,this.i2 + 14);
                  si16(this.i0,this.i2 + 12);
                  si32(this.i2,this.i2 + 28);
                  si32(this.i3,this.i2 + 36);
                  this.i0 = ___swrite;
                  si32(this.i0,this.i2 + 44);
                  this.i0 = ___sseek;
                  si32(this.i0,this.i2 + 40);
                  this.i0 = ___sclose;
                  si32(this.i0,this.i2 + 32);
                  this.i0 = li32(mstate.ebp + -4);
                  this.i0 &= 8;
                  if(this.i0 != 0)
                  {
                     this.i0 = 0;
                     mstate.esp -= 16;
                     this.i1 = 2;
                     si32(this.i2,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     si32(this.i1,mstate.esp + 12);
                     state = 4;
                     mstate.esp -= 4;
                     FSM__sseek.start();
                     return;
                  }
                  this.i0 = this.i2;
               }
               §§goto(addr122);
            case 4:
               this.i0 = mstate.eax;
               this.i0 = mstate.edx;
               mstate.esp += 16;
               mstate.eax = this.i2;
               break;
            default:
               throw "Invalid state in _fopen387";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
