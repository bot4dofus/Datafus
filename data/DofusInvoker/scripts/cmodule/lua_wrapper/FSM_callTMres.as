package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_callTMres extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public function FSM_callTMres()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_callTMres = null;
         _loc1_ = new FSM_callTMres();
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
               this.i1 = li32(mstate.ebp + 16);
               this.i2 = li32(this.i0 + 32);
               this.i3 = li32(this.i0 + 8);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i3);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i3 + 8);
               this.i1 = li32(mstate.ebp + 20);
               this.i3 = li32(this.i0 + 8);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i3 + 12);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i3 + 20);
               this.i1 = li32(mstate.ebp + 24);
               this.i3 = li32(this.i0 + 8);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i3 + 24);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i3 + 32);
               this.i1 = li32(mstate.ebp + 12);
               this.i3 = li32(this.i0 + 28);
               this.i4 = li32(this.i0 + 8);
               this.i5 = this.i0 + 8;
               this.i1 -= this.i2;
               this.i2 = this.i0 + 32;
               this.i3 -= this.i4;
               if(this.i3 <= 36)
               {
                  this.i3 = li32(this.i0 + 44);
                  if(this.i3 >= 3)
                  {
                     mstate.esp -= 8;
                     this.i3 <<= 1;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  mstate.esp -= 8;
                  this.i3 += 3;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaD_reallocstack.start();
                  return;
               }
               break;
            case 1:
               mstate.esp += 8;
               break;
            case 2:
               mstate.esp += 8;
               break;
            case 3:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i2 = li32(this.i2);
               this.i3 = this.i0 + -12;
               si32(this.i3,this.i5);
               this.f0 = lf64(this.i0 + -12);
               this.i1 = this.i2 + this.i1;
               sf64(this.f0,this.i1);
               this.i0 = li32(this.i0 + -4);
               si32(this.i0,this.i1 + 8);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _callTMres";
         }
         this.i3 = 1;
         this.i4 = li32(this.i5);
         this.i6 = this.i4 + 36;
         si32(this.i6,this.i5);
         mstate.esp -= 12;
         si32(this.i0,mstate.esp);
         si32(this.i4,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 3;
         mstate.esp -= 4;
         FSM_luaD_call.start();
      }
   }
}
