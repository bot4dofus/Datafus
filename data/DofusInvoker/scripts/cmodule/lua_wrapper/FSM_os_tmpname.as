package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_os_tmpname extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_os_tmpname()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_os_tmpname = null;
         _loc1_ = new FSM_os_tmpname();
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
               mstate.esp -= 48;
               this.i0 = mstate.ebp + -48;
               this.i1 = __2E_str12394;
               this.i2 = 16;
               memcpy(this.i0,this.i1,this.i2);
               mstate.esp -= 8;
               this.i1 = mstate.ebp + -4;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM__gettemp.start();
               return;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(mstate.ebp + -4);
               this.i1 = this.i1 == 0 ? -1 : int(this.i2);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = this.i0;
               if(this.i1 != -1)
               {
                  this.i4 = 1;
                  this.i0 = this.i1;
                  state = 2;
                  break;
               }
               this.i0 = __2E_str13395;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
            case 2:
               break;
            case 3:
               mstate.esp += 8;
               mstate.eax = this.i4;
               §§goto(addr235);
            case 4:
               mstate.esp += 8;
               this.i0 = 0;
               mstate.eax = this.i0;
               addr235:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _os_tmpname";
         }
         this.i0 = mstate.system.close(this.i0);
         mstate.esp -= 8;
         si32(this.i2,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         state = 3;
         mstate.esp -= 4;
         FSM_lua_pushstring.start();
      }
   }
}
