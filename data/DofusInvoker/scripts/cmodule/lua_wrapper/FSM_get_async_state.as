package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_get_async_state extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_get_async_state()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_get_async_state = null;
         _loc1_ = new FSM_get_async_state();
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
               mstate.esp -= 32;
               this.i0 = -10002;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = __2E_str18175;
               while(true)
               {
                  this.i3 = li8(this.i2 + 1);
                  this.i2 += 1;
                  this.i4 = this.i2;
                  if(this.i3 == 0)
                  {
                     break;
                  }
                  this.i2 = this.i4;
               }
               this.i3 = __2E_str18175;
               mstate.esp -= 12;
               this.i2 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -32);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -24);
               this.i2 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i3 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 3;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 3:
               mstate.esp += 16;
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = this.i1 + 8;
               this.i3 = _luaO_nilobject_;
               if(this.i0 != this.i3)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 5)
                  {
                     this.i0 = -1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr403);
                  }
               }
               this.i1 = __2E_str19176;
               this.i0 = li32(this.i2);
               this.i0 += -12;
               si32(this.i0,this.i2);
               this.i2 = 0;
               this.i0 = this.i1;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.eax = this.i2;
               break;
            case 5:
               addr403:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = __2E_str20177;
               while(true)
               {
                  this.i4 = li8(this.i3 + 1);
                  this.i3 += 1;
                  this.i5 = this.i3;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i3 = this.i5;
               }
               this.i4 = __2E_str20177;
               mstate.esp -= 12;
               this.i3 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -16);
               this.i3 = 4;
               si32(this.i3,mstate.ebp + -8);
               this.i3 = li32(this.i2);
               mstate.esp -= 16;
               this.i4 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 7:
               mstate.esp += 16;
               this.i0 = li32(this.i2);
               this.i0 += 12;
               si32(this.i0,this.i2);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i1 = li32(this.i0 + 8);
               if(this.i1 != 0)
               {
                  if(this.i1 != 1)
                  {
                     this.i0 = 1;
                  }
                  else
                  {
                     this.i0 = li32(this.i0);
                     this.i0 = this.i0 != 0 ? 1 : 0;
                     this.i0 &= 1;
                  }
               }
               else
               {
                  this.i0 = 0;
               }
               this.i1 = li32(this.i2);
               this.i1 += -24;
               si32(this.i1,this.i2);
               this.i0 &= 255;
               mstate.eax = this.i0;
               break;
            default:
               throw "Invalid state in _get_async_state";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
