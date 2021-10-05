package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_restore_stack_limit extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_restore_stack_limit()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_restore_stack_limit = null;
         _loc1_ = new FSM_restore_stack_limit();
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
               this.i1 = li32(this.i0 + 48);
               this.i2 = this.i0 + 48;
               if(this.i1 >= 20001)
               {
                  this.i3 = li32(this.i0 + 20);
                  this.i4 = li32(this.i0 + 40);
                  this.i3 -= this.i4;
                  this.i5 = this.i0 + 40;
                  this.i6 = this.i0 + 20;
                  this.i3 /= 24;
                  this.i7 = this.i4;
                  this.i3 += 1;
                  if(this.i3 <= 19999)
                  {
                     this.i3 = 480000;
                     this.i8 = li32(this.i0 + 16);
                     this.i9 = li32(this.i8 + 12);
                     this.i10 = li32(this.i8 + 16);
                     mstate.esp -= 16;
                     this.i1 *= 24;
                     si32(this.i10,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     si32(this.i1,mstate.esp + 8);
                     si32(this.i3,mstate.esp + 12);
                     state = 1;
                     mstate.esp -= 4;
                     mstate.funcs[this.i9]();
                     return;
                  }
                  break;
               }
               break;
            case 1:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               if(this.i3 == 0)
               {
                  this.i7 = 4;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               addr241:
               this.i7 = 20000;
               this.i9 = li32(this.i8 + 68);
               this.i1 = 480000 - this.i1;
               this.i1 += this.i9;
               si32(this.i1,this.i8 + 68);
               si32(this.i3,this.i5);
               si32(this.i7,this.i2);
               this.i1 = li32(this.i6);
               this.i1 -= this.i4;
               this.i1 /= 24;
               this.i1 *= 24;
               this.i1 = this.i3 + this.i1;
               si32(this.i1,this.i6);
               this.i1 = this.i3 + 479976;
               si32(this.i1,this.i0 + 36);
               break;
            case 2:
               mstate.esp += 8;
               §§goto(addr241);
            default:
               throw "Invalid state in _restore_stack_limit";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
