package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi16;
   
   public final class FSM___smakebuf extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM___smakebuf()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___smakebuf = null;
         _loc1_ = new FSM___smakebuf();
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
               mstate.esp -= 56;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li16(this.i0 + 12);
               this.i2 = this.i0 + 12;
               this.i1 &= 2;
               if(this.i1 != 0)
               {
                  this.i2 = 1;
                  this.i1 = this.i0 + 67;
                  si32(this.i1,this.i0);
                  si32(this.i1,this.i0 + 16);
                  si32(this.i2,this.i0 + 20);
                  break;
               }
               this.i1 = mstate.ebp + -52;
               mstate.esp -= 12;
               this.i3 = mstate.ebp + -56;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM___swhatbuf.start();
               return;
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(mstate.ebp + -56);
               mstate.esp -= 8;
               this.i4 = 0;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
            case 2:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               if(this.i4 == 0)
               {
                  this.i1 = 1;
                  this.i3 = li16(this.i2);
                  this.i3 |= 2;
                  si16(this.i3,this.i2);
                  this.i2 = this.i0 + 67;
                  si32(this.i2,this.i0);
                  si32(this.i2,this.i0 + 16);
                  si32(this.i1,this.i0 + 20);
                  break;
               }
               this.i5 = 1;
               si8(this.i5,___cleanup_2E_b);
               si32(this.i4,this.i0);
               si32(this.i4,this.i0 + 16);
               si32(this.i3,this.i0 + 20);
               this.i3 = li32(mstate.ebp + -52);
               this.i4 = this.i1 | 128;
               if(this.i3 == 0)
               {
                  addr296:
                  this.i0 = this.i4;
                  this.i1 = li16(this.i2);
                  this.i0 = this.i1 | this.i0;
                  si16(this.i0,this.i2);
                  break;
               }
               this.i3 = mstate.ebp + -48;
               this.i0 = si16(li16(this.i0 + 14));
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_ioctl.start();
               return;
               break;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != -1)
               {
                  this.i0 = this.i1 | 129;
               }
               else
               {
                  §§goto(addr296);
               }
               §§goto(addr296);
            default:
               throw "Invalid state in ___smakebuf";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
