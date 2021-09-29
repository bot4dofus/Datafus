package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_GCTM extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_GCTM()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_GCTM = null;
         _loc1_ = new FSM_GCTM();
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
               this.i1 = li32(this.i0 + 16);
               this.i2 = li32(this.i1 + 48);
               this.i3 = li32(this.i2);
               this.i4 = this.i1 + 48;
               this.i5 = this.i0 + 16;
               this.i6 = this.i3;
               if(this.i2 == this.i3)
               {
                  this.i2 = 0;
                  si32(this.i2,this.i4);
               }
               else
               {
                  this.i4 = li32(this.i6);
                  si32(this.i4,this.i2);
               }
               this.i2 = li32(this.i1 + 104);
               this.i2 = li32(this.i2);
               si32(this.i2,this.i6);
               this.i2 = li32(this.i1 + 104);
               si32(this.i6,this.i2);
               this.i2 = li8(this.i6 + 5);
               this.i4 = li8(this.i1 + 20);
               this.i2 &= -8;
               this.i4 &= 3;
               this.i2 = this.i4 | this.i2;
               si8(this.i2,this.i6 + 5);
               this.i2 = li32(this.i3 + 8);
               if(this.i2 != 0)
               {
                  this.i3 = li8(this.i2 + 6);
                  this.i3 &= 4;
                  if(this.i3 == 0)
                  {
                     this.i3 = 2;
                     this.i4 = li32(this.i5);
                     this.i4 = li32(this.i4 + 176);
                     mstate.esp -= 12;
                     si32(this.i2,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     si32(this.i4,mstate.esp + 8);
                     mstate.esp -= 4;
                     FSM_luaT_gettm.start();
                     addr250:
                     this.i2 = mstate.eax;
                     mstate.esp += 12;
                  }
                  else
                  {
                     addr178:
                     this.i2 = 0;
                  }
                  if(this.i2 != 0)
                  {
                     this.i3 = 0;
                     this.i4 = li8(this.i0 + 57);
                     this.i5 = li32(this.i1 + 64);
                     si8(this.i3,this.i0 + 57);
                     this.i7 = li32(this.i1 + 68);
                     this.i7 <<= 1;
                     si32(this.i7,this.i1 + 64);
                     this.i7 = li32(this.i0 + 8);
                     this.f0 = lf64(this.i2);
                     sf64(this.f0,this.i7);
                     this.i2 = li32(this.i2 + 8);
                     si32(this.i2,this.i7 + 8);
                     this.i2 = li32(this.i0 + 8);
                     si32(this.i6,this.i2 + 12);
                     this.i6 = 7;
                     si32(this.i6,this.i2 + 20);
                     this.i2 = li32(this.i0 + 8);
                     this.i6 = this.i2 + 24;
                     si32(this.i6,this.i0 + 8);
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i3,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaD_call.start();
                     return;
                  }
                  break;
               }
               §§goto(addr178);
            case 1:
               §§goto(addr250);
            case 2:
               mstate.esp += 12;
               si8(this.i4,this.i0 + 57);
               si32(this.i5,this.i1 + 64);
               break;
            default:
               throw "Invalid state in _GCTM";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
