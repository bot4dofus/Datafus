package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaK_setreturns extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaK_setreturns()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaK_setreturns = null;
         _loc1_ = new FSM_luaK_setreturns();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(this.i0);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 16);
               if(this.i1 != 14)
               {
                  if(this.i1 == 13)
                  {
                     this.i0 = li32(this.i0 + 4);
                     this.i2 = li32(this.i2);
                     this.i2 = li32(this.i2 + 12);
                     this.i0 <<= 2;
                     this.i3 <<= 14;
                     this.i0 = this.i2 + this.i0;
                     this.i2 = li32(this.i0);
                     this.i3 += 16384;
                     this.i3 &= 8372224;
                     this.i2 &= -8372225;
                     this.i2 |= this.i3;
                     si32(this.i2,this.i0);
                     break;
                  }
                  break;
               }
               this.i1 = 1;
               this.i4 = li32(this.i0 + 4);
               this.i5 = li32(this.i2);
               this.i5 = li32(this.i5 + 12);
               this.i4 <<= 2;
               this.i4 = this.i5 + this.i4;
               this.i5 = li32(this.i4);
               this.i3 <<= 23;
               this.i3 += 8388608;
               this.i5 &= 8388607;
               this.i3 = this.i5 | this.i3;
               si32(this.i3,this.i4);
               this.i3 = li32(this.i2);
               this.i0 = li32(this.i0 + 4);
               this.i3 = li32(this.i3 + 12);
               this.i0 <<= 2;
               this.i4 = li32(this.i2 + 36);
               this.i0 = this.i3 + this.i0;
               this.i3 = li32(this.i0);
               this.i4 <<= 6;
               this.i4 &= 16320;
               this.i3 &= -16321;
               this.i3 = this.i4 | this.i3;
               si32(this.i3,this.i0);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_checkstack.start();
               return;
               break;
            case 1:
               mstate.esp += 8;
               this.i0 = li32(this.i2 + 36);
               this.i0 += 1;
               si32(this.i0,this.i2 + 36);
               break;
            default:
               throw "Invalid state in _luaK_setreturns";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
