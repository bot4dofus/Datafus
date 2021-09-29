package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaG_errormsg extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_luaG_errormsg()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaG_errormsg = null;
         _loc1_ = new FSM_luaG_errormsg();
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
               this.i1 = li32(this.i0 + 108);
               if(this.i1 != 0)
               {
                  this.i2 = li32(this.i0 + 32);
                  this.i1 = this.i2 + this.i1;
                  this.i2 = li32(this.i1 + 8);
                  this.i3 = this.i1 + 8;
                  if(this.i2 != 6)
                  {
                     this.i2 = 5;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
                  addr117:
                  this.i2 = li32(this.i0 + 8);
                  this.f0 = lf64(this.i2 + -12);
                  sf64(this.f0,this.i2);
                  this.i4 = li32(this.i2 + -4);
                  si32(this.i4,this.i2 + 8);
                  this.i2 = li32(this.i0 + 8);
                  this.f0 = lf64(this.i1);
                  sf64(this.f0,this.i2 + -12);
                  this.i1 = li32(this.i3);
                  si32(this.i1,this.i2 + -4);
                  this.i1 = li32(this.i0 + 28);
                  this.i2 = li32(this.i0 + 8);
                  this.i3 = this.i0 + 8;
                  this.i1 -= this.i2;
                  if(this.i1 <= 12)
                  {
                     this.i1 = li32(this.i0 + 44);
                     if(this.i1 >= 1)
                     {
                        mstate.esp -= 8;
                        this.i1 <<= 1;
                        si32(this.i0,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_luaD_reallocstack.start();
                        return;
                     }
                     mstate.esp -= 8;
                     this.i1 += 1;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  break;
               }
               this.i1 = 2;
               mstate.esp -= 8;
               §§goto(addr400);
               break;
            case 1:
               mstate.esp += 8;
               §§goto(addr117);
            case 2:
               mstate.esp += 8;
               break;
            case 3:
               mstate.esp += 8;
               break;
            case 4:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i1 = 2;
               addr400:
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 5:
               mstate.esp += 8;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaG_errormsg";
         }
         this.i1 = 1;
         this.i2 = li32(this.i3);
         this.i4 = this.i2 + 12;
         si32(this.i4,this.i3);
         mstate.esp -= 12;
         this.i2 += -12;
         si32(this.i0,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i1,mstate.esp + 8);
         state = 4;
         mstate.esp -= 4;
         FSM_luaD_call.start();
      }
   }
}
