package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaC_step extends Machine
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
      
      public function FSM_luaC_step()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaC_step = null;
         _loc1_ = new FSM_luaC_step();
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
               this.i2 = li32(this.i1 + 76);
               this.i3 = li32(this.i1 + 68);
               this.i4 = li32(this.i1 + 84);
               this.i5 = li32(this.i1 + 64);
               this.i2 = this.i3 + this.i2;
               this.i3 = this.i4 * 10;
               this.i2 -= this.i5;
               si32(this.i2,this.i1 + 76);
               this.i2 = this.i3 == 0 ? 2147483646 : int(this.i3);
               this.i3 = this.i1 + 21;
               this.i4 = this.i1 + 64;
               this.i5 = this.i1 + 68;
               this.i6 = this.i1 + 76;
               break;
            case 1:
               this.i7 = mstate.eax;
               mstate.esp += 4;
               this.i8 = li8(this.i3);
               this.i2 -= this.i7;
               if(this.i2 >= 1)
               {
                  this.i7 = this.i8 & 255;
                  if(this.i7 != 0)
                  {
                     break;
                  }
               }
               this.i0 = this.i8 & 255;
               if(this.i0 != 0)
               {
                  this.i1 = li32(this.i6);
                  if(uint(this.i1) <= uint(1023))
                  {
                     this.i1 = li32(this.i5);
                     this.i1 += 1024;
                  }
                  else
                  {
                     this.i1 += -1024;
                     si32(this.i1,this.i6);
                     this.i1 = li32(this.i5);
                  }
                  si32(this.i1,this.i4);
               }
               else
               {
                  this.i0 = li32(this.i1 + 72);
                  this.i1 = li32(this.i1 + 80);
                  this.i0 = uint(this.i0) / uint(100);
                  this.i0 = this.i1 * this.i0;
                  si32(this.i0,this.i4);
               }
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaC_step";
         }
         mstate.esp -= 4;
         si32(this.i0,mstate.esp);
         state = 1;
         mstate.esp -= 4;
         FSM_singlestep.start();
      }
   }
}
