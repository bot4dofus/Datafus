package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_newproxy extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
      
      public function FSM_luaB_newproxy()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_newproxy = null;
         _loc1_ = new FSM_luaB_newproxy();
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
               this.i1 = li32(this.i0 + 12);
               this.i2 = li32(this.i0 + 8);
               this.i3 = this.i0 + 12;
               this.i4 = this.i0 + 8;
               this.i5 = this.i1 + 12;
               if(uint(this.i2) >= uint(this.i5))
               {
                  this.i2 = this.i1;
               }
               else
               {
                  while(true)
                  {
                     this.i1 = 0;
                     si32(this.i1,this.i2 + 8);
                     this.i1 = this.i2 + 12;
                     si32(this.i1,this.i4);
                     this.i5 = li32(this.i3);
                     if(this.i2 >= this.i5)
                     {
                        break;
                     }
                     this.i2 = this.i1;
                  }
                  this.i2 = this.i5;
               }
               this.i1 = this.i2;
               this.i2 = 0;
               this.i1 += 12;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_lua_newuserdata.start();
               return;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i1 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 8);
               if(this.i2 != 0)
               {
                  if(this.i2 == 1)
                  {
                     this.i1 = li32(this.i1);
                     if(this.i1 == 0)
                     {
                        addr556:
                        this.i0 = 1;
                        mstate.eax = this.i0;
                        break;
                     }
                  }
                  this.i1 = 1;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  §§goto(addr281);
               }
               §§goto(addr556);
            case 3:
               §§goto(addr281);
            case 8:
               addr281:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i1 != this.i2)
               {
                  this.i1 = li32(this.i1 + 8);
                  if(this.i1 == 1)
                  {
                     this.i1 = 0;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_lua_createtable.start();
                     return;
                  }
               }
               this.i1 = 1;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_getmetatable.start();
               this.i1 = mstate.eax;
               mstate.esp += 8;
               if(this.i1 != 0)
               {
                  this.i1 = -10003;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  addr665:
                  this.i1 = mstate.eax;
                  mstate.esp += 8;
                  this.i2 = li32(this.i4);
                  this.i1 = li32(this.i1);
                  mstate.esp -= 8;
                  this.i3 = this.i2 + -12;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_luaH_get.start();
                  addr718:
                  this.i1 = mstate.eax;
                  mstate.esp += 8;
                  this.f0 = lf64(this.i1);
                  sf64(this.f0,this.i2 + -12);
                  this.i1 = li32(this.i1 + 8);
                  si32(this.i1,this.i2 + -4);
                  mstate.esp -= 8;
                  this.i1 = -1;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  this.i1 = mstate.eax;
                  mstate.esp += 8;
                  this.i2 = li32(this.i1 + 8);
                  if(this.i2 != 0)
                  {
                     if(this.i2 == 1)
                     {
                        this.i2 = li32(this.i4);
                        this.i1 = li32(this.i1);
                        this.i2 += -12;
                        si32(this.i2,this.i4);
                        if(this.i1 == 0)
                        {
                           §§goto(addr855);
                        }
                     }
                     else
                     {
                        this.i1 = li32(this.i4);
                        this.i1 += -12;
                        si32(this.i1,this.i4);
                     }
                     addr923:
                     this.i1 = 1;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_lua_getmetatable.start();
                     addr953:
                     this.i2 = mstate.eax;
                     mstate.esp += 8;
                     mstate.esp -= 8;
                     this.i2 = 2;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_lua_setmetatable.start();
                     addr993:
                     mstate.esp += 8;
                     mstate.eax = this.i1;
                     break;
                  }
                  this.i1 = li32(this.i4);
                  this.i1 += -12;
                  si32(this.i1,this.i4);
               }
               addr855:
               this.i4 = __2E_str62351;
               mstate.esp -= 12;
               this.i1 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 9:
               §§goto(addr665);
            case 10:
               §§goto(addr718);
            case 11:
               §§goto(addr665);
            case 12:
               mstate.esp += 12;
               §§goto(addr923);
            case 13:
               §§goto(addr953);
            case 14:
               §§goto(addr993);
            case 4:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i1 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i2);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i4);
               this.i2 = this.i1 + 12;
               si32(this.i2,this.i4);
               this.i2 = 1;
               si32(this.i2,this.i1 + 12);
               si32(this.i2,this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i1 += 12;
               si32(this.i1,this.i4);
               mstate.esp -= 8;
               this.i4 = -10003;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 6;
               mstate.esp -= 4;
               FSM_lua_rawset.start();
               return;
            case 6:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i4 = 2;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 7:
               mstate.esp += 8;
               mstate.eax = this.i2;
               break;
            default:
               throw "Invalid state in _luaB_newproxy";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
