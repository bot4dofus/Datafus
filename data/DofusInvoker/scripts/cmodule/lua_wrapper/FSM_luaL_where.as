package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_where extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_luaL_where()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_where = null;
         _loc1_ = new FSM_luaL_where();
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
               mstate.esp -= 112;
               this.i0 = mstate.ebp + -112;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 20);
               this.i3 = li32(this.i1 + 40);
               mstate.esp -= 16;
               this.i4 = li32(mstate.ebp + 12);
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               mstate.esp -= 4;
               FSM_lua_getstack390.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               if(this.i0 != 0)
               {
                  this.i0 = __2E_str175318;
                  mstate.esp -= 12;
                  this.i2 = mstate.ebp + -112;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_lua_getinfo.start();
                  return;
               }
               addr284:
               this.i0 = li32(this.i1 + 16);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(mstate.ebp + -92);
               if(this.i0 >= 1)
               {
                  this.i2 = mstate.ebp + -112;
                  mstate.esp -= 16;
                  this.i3 = __2E_str1176319;
                  this.i2 += 36;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  si32(this.i0,mstate.esp + 12);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_lua_pushfstring.start();
                  return;
               }
               §§goto(addr284);
               break;
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               §§goto(addr259);
            case 4:
               mstate.esp += 4;
               break;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               addr259:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaL_where";
         }
         this.i0 = __2E_str45;
         this.i2 = li32(this.i1 + 8);
         mstate.esp -= 12;
         this.i3 = 0;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 5;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
