package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_tonumber extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_luaB_tonumber()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_tonumber = null;
         _loc1_ = new FSM_luaB_tonumber();
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
               mstate.esp -= 4;
               this.i0 = 2;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 >= 1)
                  {
                     this.i0 = 2;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaL_checkinteger.start();
                     return;
                  }
               }
               this.i0 = 10;
               addr146:
               if(this.i0 != 10)
               {
                  this.i2 = 0;
                  mstate.esp -= 12;
                  this.i3 = 1;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaL_checklstring.start();
                  return;
               }
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr146);
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 != -1)
                  {
                     §§goto(addr266);
                  }
               }
               this.i0 = __2E_str11186329;
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 4:
               mstate.esp += 12;
               addr266:
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_lua_isnumber.start();
               return;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = 1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_lua_tonumber.start();
                  return;
               }
               addr832:
               this.i0 = 0;
               this.i2 = li32(this.i1 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               this.i0 = 1;
               break;
            case 6:
               this.f0 = mstate.st0;
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 8);
               sf64(this.f0,this.i2);
               this.i3 = 3;
               si32(this.i3,this.i2 + 8);
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               break;
            case 7:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i3 = this.i0 + -2;
               if(uint(this.i3) >= uint(35))
               {
                  this.i3 = __2E_str34234;
                  mstate.esp -= 12;
                  this.i4 = 2;
                  si32(this.i1,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               this.i3 = mstate.ebp + -4;
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_strtoul.start();
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(mstate.ebp + -4);
               if(this.i2 != this.i3)
               {
                  this.i2 = this.i3;
                  addr657:
                  this.i3 = li8(this.i2);
                  this.i4 = li32(__CurrentRuneLocale);
                  this.i3 <<= 2;
                  this.i3 = this.i4 + this.i3;
                  this.i3 = li32(this.i3 + 52);
                  this.i3 &= 16384;
                  if(this.i3 != 0)
                  {
                     while(true)
                     {
                        this.i3 = this.i2 + 1;
                        si32(this.i3,mstate.ebp + -4);
                        this.i2 = li8(this.i2 + 1);
                        this.i2 <<= 2;
                        this.i2 = this.i4 + this.i2;
                        this.i2 = li32(this.i2 + 52);
                        this.i2 &= 16384;
                        if(this.i2 == 0)
                        {
                           break;
                        }
                        this.i2 = this.i3;
                     }
                     this.i2 = this.i3;
                  }
                  this.i2 = li8(this.i2);
                  if(this.i2 == 0)
                  {
                     this.i2 = 3;
                     this.i3 = li32(this.i1 + 8);
                     this.f0 = Number(uint(this.i0));
                     sf64(this.f0,this.i3);
                     si32(this.i2,this.i3 + 8);
                     this.i0 = li32(this.i1 + 8);
                     this.i0 += 12;
                     si32(this.i0,this.i1 + 8);
                     this.i1 = 1;
                     mstate.eax = this.i1;
                     §§goto(addr876);
                  }
               }
               §§goto(addr832);
            case 8:
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i3 = mstate.ebp + -4;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_strtoul.start();
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(mstate.ebp + -4);
               if(this.i2 != this.i3)
               {
                  this.i2 = this.i3;
                  §§goto(addr657);
               }
               §§goto(addr832);
            default:
               throw "Invalid state in _luaB_tonumber";
         }
         mstate.eax = this.i0;
         addr876:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
