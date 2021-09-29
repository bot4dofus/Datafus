package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_tostring382 extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i3:int;
      
      public function FSM_luaB_tostring382()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_tostring382 = null;
         _loc1_ = new FSM_luaB_tostring382();
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
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 != -1)
                  {
                     §§goto(addr147);
                  }
               }
               this.i0 = __2E_str11186329;
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 2:
               mstate.esp += 12;
               addr147:
               this.i0 = __2E_str13170;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaL_getmetafield.start();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = 1;
                  this.i3 = li32(this.i1 + 8);
                  this.f0 = lf64(this.i2);
                  sf64(this.f0,this.i3);
                  this.i2 = li32(this.i2 + 8);
                  si32(this.i2,this.i3 + 8);
                  this.i2 = li32(this.i1 + 8);
                  this.i3 = this.i2 + 12;
                  si32(this.i3,this.i1 + 8);
                  mstate.esp -= 12;
                  this.i2 += -12;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaD_call.start();
                  return;
               }
               this.i0 = _luaO_nilobject_;
               if(this.i2 == this.i0)
               {
                  this.i2 = -1;
               }
               else
               {
                  this.i2 = li32(this.i2 + 8);
               }
               this.i0 = this.i2;
               if(this.i0 <= 2)
               {
                  if(this.i0 != 0)
                  {
                     if(this.i0 == 1)
                     {
                        this.i0 = 1;
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM_index2adr.start();
                        §§goto(addr414);
                     }
                  }
                  else
                  {
                     this.i0 = li32(this.i1 + 16);
                     this.i2 = li32(this.i0 + 68);
                     this.i0 = li32(this.i0 + 64);
                     if(uint(this.i2) >= uint(this.i0))
                     {
                        mstate.esp -= 4;
                        si32(this.i1,mstate.esp);
                        state = 11;
                        mstate.esp -= 4;
                        FSM_luaC_step.start();
                        return;
                     }
                     §§goto(addr799);
                  }
               }
               else
               {
                  if(this.i0 == 4)
                  {
                     this.i0 = 1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr584:
                     this.i2 = mstate.eax;
                     mstate.esp += 8;
                     this.i3 = li32(this.i1 + 8);
                     this.f0 = lf64(this.i2);
                     sf64(this.f0,this.i3);
                     this.i2 = li32(this.i2 + 8);
                     si32(this.i2,this.i3 + 8);
                     this.i2 = li32(this.i1 + 8);
                     this.i2 += 12;
                     si32(this.i2,this.i1 + 8);
                     mstate.eax = this.i0;
                     break;
                  }
                  if(this.i0 == 3)
                  {
                     this.i0 = 0;
                     mstate.esp -= 12;
                     this.i2 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_lua_tolstring.start();
                     return;
                  }
               }
               this.i0 = 1;
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               mstate.esp -= 4;
               FSM_lua_topointer.start();
            case 9:
               §§goto(addr584);
            case 6:
               addr414:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 8);
               if(this.i2 != 0)
               {
                  if(this.i2 != 1)
                  {
                     this.i0 = 0;
                  }
                  else
                  {
                     this.i0 = li32(this.i0);
                     this.i0 = this.i0 == 0 ? 1 : 0;
                  }
               }
               else
               {
                  this.i0 = 1;
               }
               this.i2 = __2E_str15172;
               this.i0 &= 1;
               this.i3 = __2E_str14171;
               mstate.esp -= 8;
               this.i0 = this.i0 != 0 ? int(this.i2) : int(this.i3);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 10;
               mstate.esp -= 4;
               FSM_lua_pushstring.start();
               return;
            case 5:
               mstate.esp += 12;
               §§goto(addr584);
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_lua_pushstring.start();
               return;
            case 8:
               mstate.esp += 8;
               mstate.eax = this.i2;
               break;
            case 10:
               mstate.esp += 8;
               addr730:
               this.i1 = 1;
               mstate.eax = this.i1;
               break;
            case 11:
               mstate.esp += 4;
               addr799:
               this.i0 = __2E_str16173;
               this.i2 = li32(this.i1 + 8);
               mstate.esp -= 12;
               this.i3 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 12:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               §§goto(addr730);
            case 13:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 14:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i0 == this.i3)
               {
                  this.i0 = -1;
               }
               else
               {
                  this.i0 = li32(this.i0 + 8);
               }
               if(this.i0 == -1)
               {
                  this.i0 = __2E_str2251;
               }
               else
               {
                  this.i3 = _luaT_typenames;
                  this.i0 <<= 2;
                  this.i0 = this.i3 + this.i0;
                  this.i0 = li32(this.i0);
               }
               this.i3 = __2E_str17174;
               mstate.esp -= 16;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 15;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
            case 15:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = 1;
               §§goto(addr584);
            default:
               throw "Invalid state in _luaB_tostring382";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
