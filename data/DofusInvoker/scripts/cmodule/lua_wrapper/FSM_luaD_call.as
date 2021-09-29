package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaD_call extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaD_call()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaD_call = null;
         _loc1_ = new FSM_luaD_call();
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
               this.i1 = li16(this.i0 + 52);
               this.i1 += 1;
               si16(this.i1,this.i0 + 52);
               this.i2 = this.i0 + 52;
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = li32(mstate.ebp + 16);
               this.i5 = this.i1 & 65535;
               if(uint(this.i5) >= uint(200))
               {
                  this.i5 = this.i1 & 65535;
                  if(this.i5 == 200)
                  {
                     this.i1 = __2E_str616;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaG_runerror.start();
                     return;
                  }
                  this.i1 &= 65535;
                  if(uint(this.i1) >= uint(225))
                  {
                     this.i2 = 5;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               §§goto(addr250);
            case 1:
               mstate.esp += 8;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaD_precall.start();
               return;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               if(this.i1 != 0)
               {
                  addr344:
                  this.i1 = li16(this.i2);
                  this.i1 += -1;
                  si16(this.i1,this.i2);
                  this.i1 = li32(this.i0 + 16);
                  this.i2 = li32(this.i1 + 68);
                  this.i1 = li32(this.i1 + 64);
                  if(uint(this.i2) >= uint(this.i1))
                  {
                     mstate.esp -= 4;
                     si32(this.i0,mstate.esp);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  break;
               }
               §§goto(addr304);
               break;
            case 3:
               mstate.esp += 8;
               addr250:
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaD_precall.start();
               return;
            case 4:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               if(this.i1 == 0)
               {
                  addr304:
                  this.i1 = 1;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaV_execute.start();
                  return;
               }
               §§goto(addr344);
               break;
            case 5:
               mstate.esp += 8;
               §§goto(addr344);
            case 6:
               mstate.esp += 4;
               break;
            default:
               throw "Invalid state in _luaD_call";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
