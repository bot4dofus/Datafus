package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_loader_Lua extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_loader_Lua()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_loader_Lua = null;
         _loc1_ = new FSM_loader_Lua();
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
               this.i0 = 0;
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
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i2 = __2E_str19489;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_findfile.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 != 0)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaL_loadfile.start();
                  return;
               }
               addr362:
               this.i0 = 1;
               mstate.eax = this.i0;
               break;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               if(this.i2 != 0)
               {
                  this.i2 = 0;
                  mstate.esp -= 12;
                  this.i3 = -1;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_lua_tolstring.start();
                  return;
               }
               §§goto(addr362);
               break;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 20;
               this.i5 = __2E_str18488;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               si32(this.i3,mstate.esp + 16);
               state = 6;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
            case 6:
               mstate.esp += 20;
               mstate.eax = this.i4;
               break;
            default:
               throw "Invalid state in _loader_Lua";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
