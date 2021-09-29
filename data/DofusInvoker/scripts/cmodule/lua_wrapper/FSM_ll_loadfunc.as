package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_ll_loadfunc extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_ll_loadfunc()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_ll_loadfunc = null;
         _loc1_ = new FSM_ll_loadfunc();
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
               mstate.esp -= 16;
               this.i0 = __2E_str5476;
               this.i1 = li32(mstate.ebp + 8);
               mstate.esp -= 16;
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = __2E_str6477;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 8;
               this.i0 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i3 += -12;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 3;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 3:
               mstate.esp += 16;
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = this.i1 + 8;
               this.i4 = _luaO_nilobject_;
               if(this.i0 != this.i4)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 0)
                  {
                     this.i0 = 4;
                     this.i4 = li32(this.i3);
                     this.i4 += -12;
                     si32(this.i4,this.i3);
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_lua_newuserdata.start();
                     return;
                  }
               }
               this.i2 = -1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i2 + 8);
               if(this.i0 != 2)
               {
                  if(this.i0 != 7)
                  {
                     this.i2 = 0;
                  }
                  else
                  {
                     this.i2 = li32(this.i2);
                     this.i2 += 20;
                  }
               }
               else
               {
                  this.i2 = li32(this.i2);
               }
               this.i0 = li32(this.i2);
               if(this.i0 != 0)
               {
                  addr1144:
                  this.i0 = this.i2;
                  this.i0 = li32(this.i0);
                  if(this.i0 == 0)
                  {
                     this.i0 = 1;
                     break;
                  }
                  this.i0 = li32(this.i1 + 16);
                  this.i2 = li32(this.i0 + 68);
                  this.i0 = li32(this.i0 + 64);
                  if(uint(this.i2) >= uint(this.i0))
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 17;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  §§goto(addr1219);
               }
               else
               {
                  addr984:
                  this.i0 = li32(this.i1 + 16);
                  this.i4 = li32(this.i0 + 68);
                  this.i0 = li32(this.i0 + 64);
                  if(uint(this.i4) >= uint(this.i0))
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 15;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  §§goto(addr1045);
               }
               break;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i4 = 0;
               si32(this.i4,this.i0);
               mstate.esp -= 8;
               this.i4 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 7:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = __2E_str4475;
               while(true)
               {
                  this.i6 = li8(this.i5 + 1);
                  this.i5 += 1;
                  this.i7 = this.i5;
                  if(this.i6 == 0)
                  {
                     break;
                  }
                  this.i5 = this.i7;
               }
               this.i6 = __2E_str4475;
               mstate.esp -= 12;
               this.i5 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 8:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -16);
               this.i5 = 4;
               si32(this.i5,mstate.ebp + -8);
               this.i5 = li32(this.i3);
               mstate.esp -= 16;
               this.i6 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 9;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 9:
               mstate.esp += 16;
               this.i4 = li32(this.i3);
               this.i4 += 12;
               si32(this.i4,this.i3);
               mstate.esp -= 8;
               this.i4 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 10:
               mstate.esp += 8;
               mstate.esp -= 16;
               this.i5 = __2E_str5476;
               this.i6 = __2E_str6477;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 11;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
            case 11:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 12:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i3);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i4);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i3);
               this.i2 += 12;
               si32(this.i2,this.i3);
               mstate.esp -= 8;
               this.i2 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 13:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i3);
               mstate.esp -= 16;
               this.i5 = this.i4 + -24;
               this.i4 += -12;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 14;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 14:
               mstate.esp += 16;
               this.i2 = li32(this.i3);
               this.i2 += -24;
               si32(this.i2,this.i3);
               this.i2 = li32(this.i0);
               if(this.i2 != 0)
               {
                  this.i2 = this.i0;
                  §§goto(addr1144);
               }
               else
               {
                  this.i2 = this.i0;
                  §§goto(addr984);
               }
            case 15:
               mstate.esp += 4;
               addr1045:
               this.i0 = __2E_str7478;
               this.i4 = li32(this.i3);
               mstate.esp -= 12;
               this.i5 = 58;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               this.i0 = 4;
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               this.i0 = 0;
               si32(this.i0,this.i2);
               §§goto(addr1144);
            case 17:
               mstate.esp += 4;
               addr1219:
               this.i0 = __2E_str7478;
               this.i2 = li32(this.i3);
               mstate.esp -= 12;
               this.i4 = 58;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 18:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               this.i0 = 2;
               break;
            default:
               throw "Invalid state in _ll_loadfunc";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
