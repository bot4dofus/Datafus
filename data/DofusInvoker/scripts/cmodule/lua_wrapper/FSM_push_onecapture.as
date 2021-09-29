package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_push_onecapture extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_push_onecapture()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_push_onecapture = null;
         _loc1_ = new FSM_push_onecapture();
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
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = li32(mstate.ebp + 20);
               this.i4 = li32(this.i0 + 12);
               if(this.i4 <= this.i1)
               {
                  if(this.i1 != 0)
                  {
                     this.i1 = __2E_str21451;
                     this.i0 = li32(this.i0 + 8);
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaL_error.start();
                     return;
                  }
                  this.i0 = li32(this.i0 + 8);
                  this.i1 = li32(this.i0 + 16);
                  this.i4 = li32(this.i1 + 68);
                  this.i1 = li32(this.i1 + 64);
                  this.i3 -= this.i2;
                  if(uint(this.i4) >= uint(this.i1))
                  {
                     mstate.esp -= 4;
                     si32(this.i0,mstate.esp);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  §§goto(addr148);
               }
               else
               {
                  this.i1 <<= 3;
                  this.i1 = this.i0 + this.i1;
                  this.i2 = li32(this.i1 + 20);
                  this.i1 += 16;
                  this.i3 = this.i0 + 8;
                  if(this.i2 == -2)
                  {
                     this.i2 = 3;
                     this.i1 = li32(this.i1);
                     this.i0 = li32(this.i0);
                     this.i1 += 1;
                     this.i3 = li32(this.i3);
                     this.i4 = li32(this.i3 + 8);
                     this.i1 -= this.i0;
                     this.f0 = Number(this.i1);
                     sf64(this.f0,this.i4);
                     si32(this.i2,this.i4 + 8);
                     this.i1 = li32(this.i3 + 8);
                     this.i1 += 12;
                     si32(this.i1,this.i3 + 8);
                     addr241:
                     break;
                  }
                  if(this.i2 == -1)
                  {
                     this.i0 = __2E_str22452;
                     this.i4 = li32(this.i3);
                     mstate.esp -= 8;
                     si32(this.i4,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaL_error.start();
                     return;
                  }
                  this.i0 = li32(this.i3);
                  this.i3 = li32(this.i0 + 16);
                  this.i1 = li32(this.i1);
                  this.i4 = li32(this.i3 + 68);
                  this.i3 = li32(this.i3 + 64);
                  if(uint(this.i4) >= uint(this.i3))
                  {
                     mstate.esp -= 4;
                     si32(this.i0,mstate.esp);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  addr478:
                  this.i3 = 4;
                  this.i4 = li32(this.i0 + 8);
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaS_newlstr.start();
                  return;
                  addr697:
               }
               break;
            case 1:
               mstate.esp += 4;
               addr148:
               this.i1 = 4;
               this.i4 = li32(this.i0 + 8);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i4);
               si32(this.i1,this.i4 + 8);
               addr220:
               this.i1 = li32(this.i0 + 8);
               this.i1 += 12;
               si32(this.i1,this.i0 + 8);
               break;
            case 3:
               mstate.esp += 8;
               §§goto(addr241);
            case 4:
               mstate.esp += 8;
               this.i0 = li32(this.i3);
               this.i3 = li32(this.i0 + 16);
               this.i1 = li32(this.i1);
               this.i4 = li32(this.i3 + 68);
               this.i3 = li32(this.i3 + 64);
               if(uint(this.i4) >= uint(this.i3))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr478);
               break;
            case 5:
               mstate.esp += 4;
               §§goto(addr478);
            case 6:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i4);
               si32(this.i3,this.i4 + 8);
               §§goto(addr220);
            case 7:
               mstate.esp += 4;
               §§goto(addr697);
            default:
               throw "Invalid state in _push_onecapture";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
