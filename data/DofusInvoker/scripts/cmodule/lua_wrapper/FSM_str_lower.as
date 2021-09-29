package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_str_lower extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public function FSM_str_lower()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_str_lower = null;
         _loc1_ = new FSM_str_lower();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop2:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 1040;
               this.i0 = mstate.ebp + -4;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               this.i2 = mstate.ebp + -1040;
               mstate.esp += 12;
               si32(this.i1,mstate.ebp + -1032);
               this.i1 = this.i2 + 12;
               si32(this.i1,mstate.ebp + -1040);
               this.i3 = 0;
               si32(this.i3,mstate.ebp + -1036);
               this.i3 = li32(mstate.ebp + -4);
               this.i4 = this.i2 + 4;
               this.i5 = this.i2 + 8;
               if(this.i3 != 0)
               {
                  this.i3 = mstate.ebp + -1040;
                  this.i3 += 1036;
                  this.i6 = 0;
                  while(uint(this.i1) < uint(this.i3))
                  {
                     break loop2;
                  }
                  this.i1 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_emptybuffer.start();
                  return;
               }
               this.i0 = mstate.ebp + -1040;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 4;
               mstate.esp -= 4;
               FSM_emptybuffer.start();
               return;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               if(this.i1 != 0)
               {
                  this.i1 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               break;
            case 3:
               mstate.esp += 4;
               break;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i0 = li32(this.i4);
               this.i1 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_lua_concat.start();
               return;
            case 5:
               mstate.esp += 8;
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _str_lower";
         }
         continue loop1;
      }
   }
}
