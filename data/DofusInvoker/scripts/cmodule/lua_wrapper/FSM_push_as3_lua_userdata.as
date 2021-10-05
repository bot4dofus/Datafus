package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_push_as3_lua_userdata extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_push_as3_lua_userdata()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_push_as3_lua_userdata = null;
         _loc1_ = new FSM_push_as3_lua_userdata();
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
               this.i0 = 4;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               mstate.esp -= 4;
               this.i4 = li32(mstate.ebp + 12);
               si32(this.i4,mstate.esp);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Acquire]();
               return;
            case 1:
               mstate.esp += 4;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_lua_newuserdata.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i4,this.i0);
               mstate.esp -= 8;
               this.i0 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i0 = mstate.eax;
               this.i2 -= this.i3;
               mstate.esp += 8;
               this.i3 = __2E_str1143;
               this.i2 /= 12;
               this.i4 = this.i1 + 12;
               this.i5 = this.i1 + 8;
               while(true)
               {
                  this.i6 = li8(this.i3 + 1);
                  this.i3 += 1;
                  this.i7 = this.i3;
                  if(this.i6 == 0)
                  {
                     break;
                  }
                  this.i3 = this.i7;
               }
               this.i6 = __2E_str1143;
               mstate.esp -= 12;
               this.i3 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -16);
               this.i3 = 4;
               si32(this.i3,mstate.ebp + -8);
               this.i3 = li32(this.i5);
               mstate.esp -= 16;
               this.i6 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 5;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 5:
               mstate.esp += 16;
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 6:
               mstate.esp += 8;
               this.i0 = li32(this.i5);
               this.i3 = li32(this.i4);
               this.i6 = this.i2 + 1;
               this.i0 -= this.i3;
               this.i0 /= 12;
               if(this.i0 != this.i6)
               {
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr2159);
               break;
            case 7:
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 16);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               this.i7 = this.i1 + 16;
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr565);
               break;
            case 8:
               mstate.esp += 4;
               addr565:
               this.i0 = __2E_str2144;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 10;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr715);
               break;
            case 10:
               mstate.esp += 4;
               addr715:
               this.i0 = __2E_str1100;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 11:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i5);
               this.i3 = 1081135104;
               this.i8 = 0;
               si32(this.i8,this.i0 + 12);
               si32(this.i3,this.i0 + 16);
               this.i3 = 3;
               si32(this.i3,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 12;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr911);
               break;
            case 12:
               mstate.esp += 4;
               addr911:
               this.i0 = __2E_str2101;
               this.i3 = li32(this.i5);
               mstate.esp -= 12;
               this.i8 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 13:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               this.i0 = 4;
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i5);
               this.i3 = this.i0 + 12;
               si32(this.i3,this.i5);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 14;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1100);
               break;
            case 14:
               mstate.esp += 4;
               addr1100:
               this.i0 = __2E_str3102;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 15;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 15:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i5);
               this.i3 = li32(this.i4);
               this.i2 -= this.i3;
               this.i2 /= 12;
               this.i2 += -7;
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 16;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1313);
               break;
            case 16:
               mstate.esp += 4;
               addr1313:
               this.i0 = __2E_str4103;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 17;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 17:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i5);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 18;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1502);
               break;
            case 18:
               mstate.esp += 4;
               addr1502:
               this.i0 = __2E_str10143;
               this.i2 = li32(this.i5);
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 19:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 20;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1652);
               break;
            case 20:
               mstate.esp += 4;
               addr1652:
               this.i0 = 10;
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i4);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 21;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 21:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i0 += -108;
               si32(this.i0,this.i5);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 22:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               mstate.esp -= 8;
               this.i0 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 23:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.i3 = this.i0;
               this.i6 = this.i0 + 12;
               if(uint(this.i6) >= uint(this.i2))
               {
                  this.i0 = this.i2;
               }
               else
               {
                  this.i0 += 12;
                  this.i2 = this.i3;
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i3 = li32(this.i2 + 20);
                     si32(this.i3,this.i2 + 8);
                     this.i2 = li32(this.i5);
                     this.i3 = this.i0 + 12;
                     this.i6 = this.i0;
                     if(uint(this.i3) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i0 = this.i3;
                     this.i2 = this.i6;
                  }
                  this.i0 = this.i2;
               }
               this.i0 += -12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i7);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 24;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 24:
               mstate.esp += 4;
               break;
            case 25:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i0 += -12;
               si32(this.i0,this.i5);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 26;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 26:
               mstate.esp += 4;
               addr2159:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _push_as3_lua_userdata";
         }
         this.i0 = 2;
         this.i2 = li32(this.i5);
         this.i3 = li32(this.i4);
         this.i2 -= this.i3;
         this.i2 /= 12;
         mstate.esp -= 12;
         this.i2 += -1;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 25;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
