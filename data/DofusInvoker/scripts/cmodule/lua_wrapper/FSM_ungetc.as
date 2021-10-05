package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_ungetc extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_ungetc()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_ungetc = null;
         _loc1_ = new FSM_ungetc();
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
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li8(___sdidinit_2E_b);
               if(this.i2 == 0)
               {
                  this.i2 = _usual;
                  this.i3 = _usual_extra;
                  this.i4 = 0;
                  this.i2 += 56;
                  do
                  {
                     si32(this.i3,this.i2);
                     this.i3 += 148;
                     this.i2 += 88;
                     this.i4 += 1;
                  }
                  while(this.i4 != 17);
                  
                  this.i2 = 1;
                  si8(this.i2,___cleanup_2E_b);
                  si8(this.i2,___sdidinit_2E_b);
               }
               this.i2 = li32(this.i1 + 56);
               this.i3 = li32(this.i2 + 16);
               this.i2 += 16;
               if(this.i3 == 0)
               {
                  this.i3 = -1;
                  si32(this.i3,this.i2);
               }
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM___ungetc.start();
               return;
            case 1:
               mstate.esp += 8;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _ungetc";
         }
      }
   }
}
