package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___swhatbuf extends Machine
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
      
      public function FSM___swhatbuf()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___swhatbuf = null;
         _loc1_ = new FSM___swhatbuf();
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
               this.i0 = li32(mstate.ebp + 8);
               this.i0 = li16(this.i0 + 14);
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               this.i1 = this.i0 << 16;
               this.i1 >>= 16;
               if(this.i1 >= 0)
               {
                  this.i1 = this.i0 << 16;
                  this.i1 >>= 16;
                  if(this.i1 >= 2)
                  {
                     this.i0 <<= 16;
                     this.i0 >>= 16;
                     state = 1;
                     addr103:
                     this.i0 = mstate.system.fsize(this.i0);
                     if(this.i0 <= -1)
                     {
                        this.i0 = __2E_str96;
                        mstate.esp -= 20;
                        this.i1 = __2E_str251;
                        this.i4 = 59;
                        this.i5 = 2;
                        this.i6 = mstate.ebp + -4096;
                        si32(this.i6,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i5,mstate.esp + 8);
                        si32(this.i1,mstate.esp + 12);
                        si32(this.i4,mstate.esp + 16);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_sprintf.start();
                        return;
                     }
                  }
                  this.i0 = 0;
                  si32(this.i0,this.i3);
                  this.i0 = 1024;
                  si32(this.i0,this.i2);
                  this.i0 = 2048;
                  mstate.eax = this.i0;
                  break;
               }
               addr214:
               this.i0 = 0;
               si32(this.i0,this.i3);
               this.i3 = 1024;
               si32(this.i3,this.i2);
               this.i2 = 2048;
               mstate.eax = this.i2;
               break;
            case 1:
               §§goto(addr103);
            case 2:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i6;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i5,_val_2E_1440);
               §§goto(addr214);
            default:
               throw "Invalid state in ___swhatbuf";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
