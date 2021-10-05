package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_as3_isas3value extends Machine
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
      
      public function FSM_as3_isas3value()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_as3_isas3value = null;
         _loc1_ = new FSM_as3_isas3value();
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
               this.i0 = _luaO_nilobject_;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               this.i0 = uint(this.i2) > uint(this.i3) ? int(this.i3) : int(this.i0);
               this.i0 = li32(this.i0 + 8);
               this.i2 -= this.i3;
               this.i2 /= 12;
               this.i3 = this.i1 + 12;
               this.i4 = this.i1 + 8;
               if(this.i0 != 2)
               {
                  if(this.i0 == 7)
                  {
                     addr112:
                     this.i0 = 1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_lua_getmetatable.start();
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     if(this.i0 != 0)
                     {
                        this.i0 = -10000;
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM_index2adr.start();
                        §§goto(addr250);
                     }
                  }
                  this.i0 = 0;
                  this.i5 = li32(this.i4);
                  si32(this.i0,this.i5 + 8);
                  this.i0 = li32(this.i4);
                  this.i0 += 12;
                  si32(this.i0,this.i4);
                  this.i5 = li32(this.i3);
                  this.i0 -= this.i5;
                  this.i5 = this.i2 + 1;
                  this.i0 /= 12;
                  if(this.i0 == this.i5)
                  {
                     break;
                  }
                  §§goto(addr744);
               }
               §§goto(addr112);
            case 1:
               §§goto(addr112);
            case 2:
               addr250:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i5 = __2E_str1143;
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
               this.i6 = __2E_str1143;
               mstate.esp -= 12;
               this.i5 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 3:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -16);
               this.i5 = 4;
               si32(this.i5,mstate.ebp + -8);
               this.i5 = li32(this.i4);
               mstate.esp -= 16;
               this.i6 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 4:
               mstate.esp += 16;
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i5 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 6:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i6 = _luaO_nilobject_;
               if(this.i5 != this.i6)
               {
                  this.i6 = _luaO_nilobject_;
                  if(this.i0 == this.i6)
                  {
                     addr548:
                     this.i0 = 1;
                  }
                  else
                  {
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_luaO_rawequalObj.start();
                     addr579:
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     this.i0 = this.i0 == 0 ? 1 : 0;
                  }
                  this.i5 = li32(this.i4);
                  this.i6 = this.i5 + -24;
                  si32(this.i6,this.i4);
                  this.i7 = this.i2 + 1;
                  this.i0 ^= 1;
                  this.i0 &= 1;
                  if(this.i0 == 0)
                  {
                     this.i6 = 0;
                     si32(this.i6,this.i5 + -16);
                     this.i5 = li32(this.i4);
                     this.i5 += 12;
                     si32(this.i5,this.i4);
                     this.i6 = li32(this.i3);
                     this.i5 -= this.i6;
                     this.i5 /= 12;
                     if(this.i5 == this.i7)
                     {
                        break;
                     }
                  }
                  else
                  {
                     this.i0 = 1;
                     si32(this.i0,this.i6);
                     si32(this.i0,this.i5 + -16);
                     this.i0 = li32(this.i4);
                     this.i0 += 12;
                     si32(this.i0,this.i4);
                     this.i5 = li32(this.i3);
                     this.i0 -= this.i5;
                     this.i0 /= 12;
                     if(this.i0 == this.i7)
                     {
                        break;
                     }
                  }
                  addr744:
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_dump_lua_stack.start();
                  return;
               }
               §§goto(addr548);
            case 7:
               §§goto(addr579);
            case 8:
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 16);
               this.i5 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               this.i6 = this.i1 + 16;
               if(uint(this.i5) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr848);
               break;
            case 9:
               mstate.esp += 4;
               addr848:
               this.i0 = __2E_str19226;
               this.i5 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 19;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i5);
               this.i0 = 4;
               si32(this.i0,this.i5 + 8);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               this.i0 = li32(this.i6);
               this.i5 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i5) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr998);
               break;
            case 11:
               mstate.esp += 4;
               addr998:
               this.i0 = __2E_str1100;
               this.i5 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 12:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i5);
               this.i0 = 4;
               si32(this.i0,this.i5 + 8);
               this.i0 = li32(this.i4);
               this.i5 = this.i0 + 12;
               si32(this.i5,this.i4);
               this.i5 = 1082263552;
               this.i7 = 0;
               si32(this.i7,this.i0 + 12);
               si32(this.i5,this.i0 + 16);
               this.i5 = 3;
               si32(this.i5,this.i0 + 20);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               this.i0 = li32(this.i6);
               this.i5 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i5) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1194);
               break;
            case 13:
               mstate.esp += 4;
               addr1194:
               this.i0 = __2E_str2101;
               this.i5 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 38;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i5);
               this.i0 = 4;
               si32(this.i0,this.i5 + 8);
               this.i0 = li32(this.i4);
               this.i5 = this.i0 + 12;
               si32(this.i5,this.i4);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i5 = 3;
               si32(this.i5,this.i0 + 20);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               this.i0 = li32(this.i6);
               this.i5 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i5) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1383);
               break;
            case 15:
               mstate.esp += 4;
               addr1383:
               this.i0 = __2E_str3102;
               this.i5 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i5);
               this.i0 = 4;
               si32(this.i0,this.i5 + 8);
               this.i0 = li32(this.i4);
               this.i5 = this.i0 + 12;
               si32(this.i5,this.i4);
               this.i7 = li32(this.i3);
               this.i5 -= this.i7;
               this.i5 /= 12;
               this.i5 += -7;
               this.f0 = Number(this.i5);
               sf64(this.f0,this.i0 + 12);
               this.i5 = 3;
               si32(this.i5,this.i0 + 20);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               this.i0 = li32(this.i6);
               this.i5 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i5) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1596);
               break;
            case 17:
               mstate.esp += 4;
               addr1596:
               this.i0 = __2E_str4103;
               this.i5 = li32(this.i4);
               mstate.esp -= 12;
               this.i7 = 18;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 18:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i5);
               this.i0 = 4;
               si32(this.i0,this.i5 + 8);
               this.i0 = li32(this.i4);
               this.i2 += 1;
               this.i5 = this.i0 + 12;
               si32(this.i5,this.i4);
               this.f0 = Number(this.i2);
               sf64(this.f0,this.i0 + 12);
               this.i2 = 3;
               si32(this.i2,this.i0 + 20);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               this.i0 = li32(this.i6);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 19;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1791);
               break;
            case 19:
               mstate.esp += 4;
               addr1791:
               this.i0 = __2E_str10143;
               this.i2 = li32(this.i4);
               mstate.esp -= 12;
               this.i5 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 20;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 20:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               this.i0 = li32(this.i6);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 21;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1941);
               break;
            case 21:
               mstate.esp += 4;
               addr1941:
               this.i0 = 10;
               this.i2 = li32(this.i4);
               this.i5 = li32(this.i3);
               this.i2 -= this.i5;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 22:
               mstate.esp += 12;
               this.i0 = li32(this.i4);
               this.i0 += -108;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 23:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               this.i0 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 24:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i4);
               this.i5 = this.i0;
               this.i7 = this.i0 + 12;
               if(uint(this.i7) >= uint(this.i2))
               {
                  this.i0 = this.i2;
               }
               else
               {
                  this.i0 += 12;
                  this.i2 = this.i5;
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i5 = li32(this.i2 + 20);
                     si32(this.i5,this.i2 + 8);
                     this.i2 = li32(this.i4);
                     this.i5 = this.i0 + 12;
                     this.i7 = this.i0;
                     if(uint(this.i5) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i0 = this.i5;
                     this.i2 = this.i7;
                  }
                  this.i0 = this.i2;
               }
               this.i0 += -12;
               si32(this.i0,this.i4);
               this.i0 = li32(this.i6);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 25;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr2326);
               break;
            case 25:
               mstate.esp += 4;
               addr2326:
               this.i0 = 2;
               this.i2 = li32(this.i4);
               this.i3 = li32(this.i3);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 26;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 26:
               mstate.esp += 12;
               this.i0 = li32(this.i4);
               this.i0 += -12;
               si32(this.i0,this.i4);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 27;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 27:
               mstate.esp += 4;
               break;
            default:
               throw "Invalid state in _as3_isas3value";
         }
         this.i0 = 1;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
