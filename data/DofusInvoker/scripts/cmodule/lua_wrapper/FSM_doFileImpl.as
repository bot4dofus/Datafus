package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_doFileImpl extends Machine
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
      
      public function FSM_doFileImpl()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_doFileImpl = null;
         _loc1_ = new FSM_doFileImpl();
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
               mstate.esp -= 4;
               this.i1 = li32(mstate.ebp + 12);
               si32(this.i1,mstate.esp);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[_AS3_StringValue]();
               return;
            case 1:
               this.i1 = mstate.eax;
               this.i2 = li32(mstate.ebp + 8);
               mstate.esp += 4;
               this.i3 = li32(this.i2 + 8);
               this.i4 = li32(this.i2 + 12);
               si32(this.i0,this.i3);
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i2 + 8);
               this.i0 += 12;
               si32(this.i0,this.i2 + 8);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_loadfile.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i5 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
            case 3:
               this.i1 = mstate.eax;
               this.i1 = this.i3 - this.i4;
               mstate.esp += 8;
               this.i1 /= 12;
               this.i3 = this.i2 + 12;
               this.i4 = this.i2 + 8;
               this.i5 = si8(li8(mstate.ebp + 16));
               if(this.i0 != 0)
               {
                  this.i5 = this.i0;
                  addr2136:
                  this.i0 = this.i5;
                  if(this.i0 != 0)
                  {
                     this.i0 = -1;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                  }
                  else
                  {
                     §§goto(addr2410);
                  }
               }
               else
               {
                  this.i0 = li32(this.i4);
                  this.i6 = li32(this.i3);
                  this.i0 -= this.i6;
                  this.i6 = this.i1 + 2;
                  this.i0 /= 12;
                  if(this.i0 != this.i6)
                  {
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_dump_lua_stack.start();
                     return;
                  }
                  §§goto(addr2085);
               }
               break;
            case 25:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr2136);
            case 26:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i6 = li32(this.i4);
               this.f0 = lf64(this.i5);
               sf64(this.f0,this.i6);
               this.i5 = li32(this.i5 + 8);
               si32(this.i5,this.i6 + 8);
               this.i5 = li32(this.i4);
               this.i5 += 12;
               si32(this.i5,this.i4);
               mstate.esp -= 12;
               this.i5 = 0;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 27;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 4:
               mstate.esp += 8;
               this.i5 = li32(this.i2 + 16);
               this.i0 = li32(this.i5 + 68);
               this.i5 = li32(this.i5 + 64);
               this.i7 = this.i2 + 16;
               if(uint(this.i0) >= uint(this.i5))
               {
                  mstate.esp -= 4;
                  si32(this.i2,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr395);
               break;
            case 5:
               mstate.esp += 4;
               addr395:
               this.i5 = __2E_str99;
               this.i0 = li32(this.i4);
               mstate.esp -= 12;
               this.i8 = 14;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,this.i0);
               this.i5 = 4;
               si32(this.i5,this.i0 + 8);
               this.i5 = li32(this.i4);
               this.i5 += 12;
               si32(this.i5,this.i4);
               this.i5 = li32(this.i7);
               this.i0 = li32(this.i5 + 68);
               this.i5 = li32(this.i5 + 64);
               if(uint(this.i0) >= uint(this.i5))
               {
                  mstate.esp -= 4;
                  si32(this.i2,mstate.esp);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr545);
               break;
            case 7:
               mstate.esp += 4;
               addr545:
               this.i5 = __2E_str1100;
               this.i0 = li32(this.i4);
               mstate.esp -= 12;
               this.i8 = 1;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 8:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,this.i0);
               this.i5 = 4;
               si32(this.i5,this.i0 + 8);
               this.i5 = li32(this.i4);
               this.i0 = this.i5 + 12;
               si32(this.i0,this.i4);
               this.i0 = 1080475648;
               this.i8 = 0;
               si32(this.i8,this.i5 + 12);
               si32(this.i0,this.i5 + 16);
               this.i0 = 3;
               si32(this.i0,this.i5 + 20);
               this.i5 = li32(this.i4);
               this.i5 += 12;
               si32(this.i5,this.i4);
               this.i5 = li32(this.i7);
               this.i0 = li32(this.i5 + 68);
               this.i5 = li32(this.i5 + 64);
               if(uint(this.i0) >= uint(this.i5))
               {
                  mstate.esp -= 4;
                  si32(this.i2,mstate.esp);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr741);
               break;
            case 9:
               mstate.esp += 4;
               addr741:
               this.i5 = __2E_str2101;
               this.i0 = li32(this.i4);
               mstate.esp -= 12;
               this.i8 = 38;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 10:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,this.i0);
               this.i5 = 4;
               si32(this.i5,this.i0 + 8);
               this.i5 = li32(this.i4);
               this.i0 = this.i5 + 12;
               si32(this.i0,this.i4);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i5 + 12);
               this.i1 = 3;
               si32(this.i1,this.i5 + 20);
               this.i5 = li32(this.i4);
               this.i5 += 12;
               si32(this.i5,this.i4);
               this.i5 = li32(this.i7);
               this.i1 = li32(this.i5 + 68);
               this.i5 = li32(this.i5 + 64);
               if(uint(this.i1) >= uint(this.i5))
               {
                  mstate.esp -= 4;
                  si32(this.i2,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr930);
               break;
            case 11:
               mstate.esp += 4;
               addr930:
               this.i5 = __2E_str3102;
               this.i1 = li32(this.i4);
               mstate.esp -= 12;
               this.i0 = 16;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 12:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,this.i1);
               this.i5 = 4;
               si32(this.i5,this.i1 + 8);
               this.i5 = li32(this.i4);
               this.i1 = this.i5 + 12;
               si32(this.i1,this.i4);
               this.i0 = li32(this.i3);
               this.i1 -= this.i0;
               this.i1 /= 12;
               this.i1 += -7;
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i5 + 12);
               this.i1 = 3;
               si32(this.i1,this.i5 + 20);
               this.i5 = li32(this.i4);
               this.i5 += 12;
               si32(this.i5,this.i4);
               this.i5 = li32(this.i7);
               this.i1 = li32(this.i5 + 68);
               this.i5 = li32(this.i5 + 64);
               if(uint(this.i1) >= uint(this.i5))
               {
                  mstate.esp -= 4;
                  si32(this.i2,mstate.esp);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1143);
               break;
            case 13:
               mstate.esp += 4;
               addr1143:
               this.i5 = __2E_str4103;
               this.i1 = li32(this.i4);
               mstate.esp -= 12;
               this.i0 = 18;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,this.i1);
               this.i5 = 4;
               si32(this.i5,this.i1 + 8);
               this.i5 = li32(this.i4);
               this.i1 = this.i5 + 12;
               si32(this.i1,this.i4);
               this.f0 = Number(this.i6);
               sf64(this.f0,this.i5 + 12);
               this.i1 = 3;
               si32(this.i1,this.i5 + 20);
               this.i5 = li32(this.i4);
               this.i5 += 12;
               si32(this.i5,this.i4);
               this.i5 = li32(this.i7);
               this.i1 = li32(this.i5 + 68);
               this.i5 = li32(this.i5 + 64);
               if(uint(this.i1) >= uint(this.i5))
               {
                  mstate.esp -= 4;
                  si32(this.i2,mstate.esp);
                  state = 15;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1332);
               break;
            case 15:
               mstate.esp += 4;
               addr1332:
               this.i5 = __2E_str10143;
               this.i1 = li32(this.i4);
               mstate.esp -= 12;
               this.i0 = 1;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 16:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,this.i1);
               this.i5 = 4;
               si32(this.i5,this.i1 + 8);
               this.i5 = li32(this.i4);
               this.i5 += 12;
               si32(this.i5,this.i4);
               this.i5 = li32(this.i7);
               this.i1 = li32(this.i5 + 68);
               this.i5 = li32(this.i5 + 64);
               if(uint(this.i1) >= uint(this.i5))
               {
                  mstate.esp -= 4;
                  si32(this.i2,mstate.esp);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr1482);
               break;
            case 17:
               mstate.esp += 4;
               addr1482:
               this.i5 = 10;
               this.i1 = li32(this.i4);
               this.i0 = li32(this.i3);
               this.i1 -= this.i0;
               this.i1 /= 12;
               mstate.esp -= 12;
               this.i1 += -1;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 18;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 18:
               mstate.esp += 12;
               this.i5 = li32(this.i4);
               this.i5 += -108;
               si32(this.i5,this.i4);
               mstate.esp -= 8;
               this.i5 = -2;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 19:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i1 = li32(this.i4);
               this.f0 = lf64(this.i5);
               sf64(this.f0,this.i1);
               this.i5 = li32(this.i5 + 8);
               si32(this.i5,this.i1 + 8);
               this.i5 = li32(this.i4);
               this.i5 += 12;
               si32(this.i5,this.i4);
               mstate.esp -= 8;
               this.i5 = -3;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 20:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i1 = li32(this.i4);
               this.i0 = this.i5;
               this.i6 = this.i5 + 12;
               if(uint(this.i6) >= uint(this.i1))
               {
                  this.i5 = this.i1;
               }
               else
               {
                  this.i5 += 12;
                  this.i1 = this.i0;
                  while(true)
                  {
                     this.f0 = lf64(this.i1 + 12);
                     sf64(this.f0,this.i1);
                     this.i0 = li32(this.i1 + 20);
                     si32(this.i0,this.i1 + 8);
                     this.i1 = li32(this.i4);
                     this.i0 = this.i5 + 12;
                     this.i6 = this.i5;
                     if(uint(this.i0) >= uint(this.i1))
                     {
                        break;
                     }
                     this.i5 = this.i0;
                     this.i1 = this.i6;
                  }
                  this.i5 = this.i1;
               }
               this.i5 += -12;
               si32(this.i5,this.i4);
               this.i5 = li32(this.i7);
               this.i1 = li32(this.i5 + 68);
               this.i5 = li32(this.i5 + 64);
               if(uint(this.i1) >= uint(this.i5))
               {
                  mstate.esp -= 4;
                  si32(this.i2,mstate.esp);
                  state = 21;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 21:
               mstate.esp += 4;
               break;
            case 22:
               mstate.esp += 12;
               this.i5 = li32(this.i4);
               this.i5 += -12;
               si32(this.i5,this.i4);
               mstate.esp -= 12;
               this.i5 = 0;
               this.i1 = -1;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 23;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 23:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i4);
               this.i2 += -12;
               si32(this.i2,this.i4);
               this.i2 = __2E_str157;
               this.i0 = this.i2;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i5;
               trace(mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 24;
               mstate.esp -= 4;
               FSM_exit.start();
               return;
            case 24:
               mstate.esp += 4;
               addr2085:
               this.i0 = 0;
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 25;
               mstate.esp -= 4;
               FSM_do_pcall_with_traceback.start();
               return;
            case 27:
               this.i0 = mstate.eax;
               this.i6 = __2E_str6105;
               mstate.esp += 12;
               this.i7 = __2E_str7106;
               this.i6 = this.i0 == 0 ? int(this.i6) : int(this.i0);
               this.i0 = this.i7;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = this.i6;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = li32(this.i4);
               this.i6 = this.i0 + -12;
               si32(this.i6,this.i4);
               si32(this.i5,this.i0 + -12);
               this.i5 = 1;
               si32(this.i5,this.i0 + -4);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 28;
               mstate.esp -= 4;
               FSM_lua_replace.start();
               return;
            case 28:
               mstate.esp += 8;
               addr2410:
               this.i0 = 0;
               this.i5 = li32(this.i4);
               this.i6 = li32(this.i3);
               this.i5 -= this.i6;
               mstate.esp -= 16;
               this.i6 = this.i1 + 1;
               this.i5 /= 12;
               si32(this.i2,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 29;
               mstate.esp -= 4;
               FSM_create_as3_value_from_lua_stack.start();
               return;
            case 29:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i4);
               this.i5 = li32(this.i3);
               this.i6 = this.i2 - this.i5;
               this.i1 += -1;
               this.i6 /= 12;
               this.i1 -= this.i6;
               if(this.i1 >= 0)
               {
                  this.i6 = this.i1 * 12;
                  this.i6 = this.i5 + this.i6;
                  if(uint(this.i2) >= uint(this.i6))
                  {
                     this.i2 = this.i5;
                  }
                  else
                  {
                     do
                     {
                        this.i5 = 0;
                        si32(this.i5,this.i2 + 8);
                        this.i2 += 12;
                        si32(this.i2,this.i4);
                        this.i5 = li32(this.i3);
                        this.i6 = this.i1 * 12;
                        this.i6 = this.i5 + this.i6;
                     }
                     while(uint(this.i2) < uint(this.i6));
                     
                     this.i2 = this.i5;
                  }
                  this.i1 *= 12;
                  this.i1 = this.i2 + this.i1;
               }
               else
               {
                  this.i1 *= 12;
                  this.i1 += this.i2;
                  this.i1 += 12;
               }
               si32(this.i1,this.i4);
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _doFileImpl";
         }
         this.i5 = 2;
         this.i1 = li32(this.i4);
         this.i3 = li32(this.i3);
         this.i1 -= this.i3;
         this.i1 /= 12;
         mstate.esp -= 12;
         this.i1 += -1;
         si32(this.i2,mstate.esp);
         si32(this.i5,mstate.esp + 4);
         si32(this.i1,mstate.esp + 8);
         state = 22;
         mstate.esp -= 4;
         FSM_luaV_concat.start();
      }
   }
}
