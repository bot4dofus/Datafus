package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_DumpVector extends Machine
   {
      
      public static const intRegCount:int = 9;
      
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
      
      public function FSM_DumpVector()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_DumpVector = null;
         _loc1_ = new FSM_DumpVector();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(mstate.ebp + 16);
               si32(this.i0,mstate.ebp + -4);
               this.i2 = li32(this.i1 + 16);
               this.i3 = this.i1 + 16;
               this.i4 = li32(mstate.ebp + 8);
               if(this.i2 != 0)
               {
                  addr166:
                  if(this.i2 == 0)
                  {
                     this.i2 = li32(this.i1 + 4);
                     this.i5 = li32(this.i1 + 8);
                     this.i1 = li32(this.i1);
                     mstate.esp -= 16;
                     this.i0 <<= 2;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     si32(this.i5,mstate.esp + 12);
                     state = 2;
                     mstate.esp -= 4;
                     mstate.funcs[this.i2]();
                     return;
                  }
                  break;
               }
               this.i2 = 4;
               this.i5 = li32(this.i1 + 4);
               this.i6 = li32(this.i1 + 8);
               this.i7 = li32(this.i1);
               mstate.esp -= 16;
               this.i8 = mstate.ebp + -4;
               si32(this.i7,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[this.i5]();
               return;
               break;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               si32(this.i2,this.i3);
               §§goto(addr166);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               si32(this.i0,this.i3);
               break;
            default:
               throw "Invalid state in _DumpVector";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
