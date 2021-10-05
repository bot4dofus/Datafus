package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_rewind extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_rewind()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_rewind = null;
         _loc1_ = new FSM_rewind();
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
               this.i0 = li32(_val_2E_1440);
               this.i1 = li8(___sdidinit_2E_b);
               this.i2 = li32(mstate.ebp + 8);
               if(this.i1 == 0)
               {
                  this.i1 = _usual;
                  this.i3 = _usual_extra;
                  this.i4 = 0;
                  this.i1 += 56;
                  do
                  {
                     si32(this.i3,this.i1);
                     this.i3 += 148;
                     this.i1 += 88;
                     this.i4 += 1;
                  }
                  while(this.i4 != 17);
                  
                  this.i1 = 1;
                  si8(this.i1,___cleanup_2E_b);
                  si8(this.i1,___sdidinit_2E_b);
               }
               this.i1 = 1;
               mstate.esp -= 20;
               this.i3 = 0;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               si32(this.i1,mstate.esp + 16);
               state = 1;
               mstate.esp -= 4;
               FSM__fseeko.start();
               return;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 20;
               if(this.i1 == 0)
               {
                  this.i1 = li16(this.i2 + 12);
                  this.i1 &= -97;
                  si16(this.i1,this.i2 + 12);
                  si32(this.i0,_val_2E_1440);
               }
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _rewind";
         }
      }
   }
}
