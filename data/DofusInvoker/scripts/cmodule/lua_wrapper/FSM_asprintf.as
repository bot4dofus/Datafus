package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_asprintf extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_asprintf()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_asprintf = null;
         _loc1_ = new FSM_asprintf();
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
               mstate.esp -= 260;
               this.i0 = -1;
               si16(this.i0,mstate.ebp + -242);
               this.i0 = 16904;
               si16(this.i0,mstate.ebp + -244);
               mstate.esp -= 8;
               this.i0 = 128;
               this.i1 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,mstate.ebp + -256);
               this.i1 = mstate.ebp + -256;
               si32(this.i0,mstate.ebp + -240);
               this.i2 = this.i1 + 16;
               this.i3 = li32(mstate.ebp + 8);
               if(this.i0 == 0)
               {
                  this.i1 = 0;
                  addr137:
                  si32(this.i1,this.i3);
                  this.i1 = 12;
                  si32(this.i1,_val_2E_1440);
                  break;
               }
               this.i0 = 127;
               si32(this.i0,mstate.ebp + -248);
               this.i4 = mstate.ebp + -160;
               si32(this.i0,mstate.ebp + -236);
               si32(this.i4,mstate.ebp + -200);
               this.i0 = 0;
               si32(this.i0,mstate.ebp + -160);
               si32(this.i0,mstate.ebp + -156);
               si32(this.i0,mstate.ebp + -152);
               si32(this.i0,mstate.ebp + -148);
               si32(this.i0,mstate.ebp + -144);
               this.i4 += 20;
               this.i5 = 128;
               memset(this.i4,this.i0,this.i5);
               this.i0 = mstate.ebp + 12;
               si32(this.i0,mstate.ebp + -260);
               mstate.esp -= 12;
               this.i4 = __2E_str412;
               this.i5 = mstate.ebp + -256;
               si32(this.i5,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM___vfprintf.start();
               return;
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 <= -1)
               {
                  this.i1 = 0;
                  this.i2 = li32(this.i2);
                  mstate.esp -= 8;
                  si32(this.i2,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               this.i0 = 0;
               this.i1 = li32(this.i1);
               si8(this.i0,this.i1);
               this.i0 = li32(this.i2);
               si32(this.i0,this.i3);
               break;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr137);
            default:
               throw "Invalid state in _asprintf";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
