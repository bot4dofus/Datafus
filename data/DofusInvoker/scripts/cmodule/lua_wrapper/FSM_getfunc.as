package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_getfunc extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_getfunc()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_getfunc = null;
         _loc1_ = new FSM_getfunc();
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
               this.i0 = 1;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = _luaO_nilobject_;
               if(this.i0 != this.i3)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 6)
                  {
                     this.i2 = 1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr133);
                  }
               }
               if(this.i2 == 0)
               {
                  this.i0 = 1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaL_checkinteger.start();
                  return;
               }
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 >= 1)
                  {
                     this.i0 = 1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaL_checkinteger.start();
                     return;
                  }
               }
               this.i0 = 1;
               addr313:
               if(this.i0 <= -1)
               {
                  §§goto(addr370);
               }
               else
               {
                  addr423:
                  this.i2 = mstate.ebp + -112;
                  this.i3 = li32(this.i1 + 20);
                  this.i4 = li32(this.i1 + 40);
                  mstate.esp -= 16;
                  si32(this.i3,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  si32(this.i2,mstate.esp + 12);
                  mstate.esp -= 4;
                  FSM_lua_getstack390.start();
               }
               break;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr313);
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 <= -1)
               {
                  addr370:
                  this.i2 = __2E_str38238;
                  mstate.esp -= 12;
                  this.i3 = 1;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               §§goto(addr423);
               break;
            case 6:
               mstate.esp += 12;
               §§goto(addr423);
            case 7:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               if(this.i2 == 0)
               {
                  this.i2 = __2E_str39239;
                  mstate.esp -= 12;
                  this.i3 = 1;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               break;
            case 2:
               §§goto(addr133);
            case 8:
               mstate.esp += 12;
               break;
            case 9:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i2 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 10:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 == 0)
                  {
                     this.i2 = __2E_str41241;
                     mstate.esp -= 12;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 11;
                     mstate.esp -= 4;
                     FSM_luaL_error.start();
                     return;
                  }
               }
               §§goto(addr133);
            case 11:
               mstate.esp += 12;
               addr133:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i0);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _getfunc";
         }
         this.i2 = __2E_str40240;
         mstate.esp -= 12;
         this.i3 = mstate.ebp + -112;
         si32(this.i1,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 9;
         mstate.esp -= 4;
         FSM_lua_getinfo.start();
      }
   }
}
