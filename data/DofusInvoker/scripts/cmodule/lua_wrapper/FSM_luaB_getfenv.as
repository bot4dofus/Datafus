package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_getfenv extends Machine
   {
      
      public static const intRegCount:int = 3;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public function FSM_luaB_getfenv()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_getfenv = null;
         _loc1_ = new FSM_luaB_getfenv();
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
               this.i0 = 1;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_getfunc.start();
               return;
            case 1:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 8);
               if(this.i2 == 6)
               {
                  this.i0 = li32(this.i0);
                  this.i0 = li8(this.i0 + 6);
                  if(this.i0 != 0)
                  {
                     this.i0 = -10002;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr173:
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     this.i2 = li32(this.i1 + 8);
                     this.f0 = lf64(this.i0);
                     sf64(this.f0,this.i2);
                     this.i0 = li32(this.i0 + 8);
                     si32(this.i0,this.i2 + 8);
                     this.i0 = li32(this.i1 + 8);
                     this.i0 += 12;
                     si32(this.i0,this.i1 + 8);
                     this.i1 = 1;
                     mstate.eax = this.i1;
                     break;
                  }
               }
               this.i0 = -1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_getfenv.start();
            case 4:
               mstate.esp += 8;
               this.i0 = 1;
               mstate.eax = this.i0;
               break;
            case 3:
               §§goto(addr173);
            default:
               throw "Invalid state in _luaB_getfenv";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
