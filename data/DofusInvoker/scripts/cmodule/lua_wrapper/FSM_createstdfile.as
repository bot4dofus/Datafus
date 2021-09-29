package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_createstdfile extends Machine
   {
      
      public static const intRegCount:int = 10;
      
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
      
      public var i9:int;
      
      public function FSM_createstdfile()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_createstdfile = null;
         _loc1_ = new FSM_createstdfile();
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
               this.i0 = 4;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_lua_newuserdata.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = 0;
               si32(this.i2,this.i0);
               mstate.esp -= 8;
               this.i2 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(mstate.ebp + 20);
               this.i4 = __2E_str17320;
               this.i5 = li32(mstate.ebp + 12);
               this.i6 = li32(mstate.ebp + 16);
               this.i7 = this.i3;
               while(true)
               {
                  this.i8 = li8(this.i4 + 1);
                  this.i4 += 1;
                  this.i9 = this.i4;
                  if(this.i8 == 0)
                  {
                     break;
                  }
                  this.i4 = this.i9;
               }
               this.i8 = __2E_str17320;
               mstate.esp -= 12;
               this.i4 -= this.i8;
               si32(this.i1,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,mstate.ebp + -48);
               this.i4 = 4;
               si32(this.i4,mstate.ebp + -40);
               this.i4 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i8 = mstate.ebp + -48;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 4:
               mstate.esp += 16;
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 5:
               mstate.esp += 8;
               si32(this.i5,this.i0);
               this.i0 = this.i1 + 8;
               if(this.i6 >= 1)
               {
                  this.i2 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  this.i2 = -2;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
            case 11:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i0);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i5);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i5 + 8);
               this.i4 = li32(this.i0);
               this.i4 += 12;
               si32(this.i4,this.i0);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setfenv.start();
            case 12:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 13:
               break;
            case 6:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i0);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i4);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i0);
               this.i2 += 12;
               si32(this.i2,this.i0);
               mstate.esp -= 12;
               this.i2 = -10001;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_lua_rawseti.start();
               return;
            case 7:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 8:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i0);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i5);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i5 + 8);
               this.i4 = li32(this.i0);
               this.i4 += 12;
               si32(this.i4,this.i0);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setfenv.start();
            case 9:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 10:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li8(this.i3);
               if(this.i4 != 0)
               {
                  while(true)
                  {
                     this.i4 = li8(this.i7 + 1);
                     this.i7 += 1;
                     this.i5 = this.i7;
                     if(this.i4 == 0)
                     {
                        break;
                     }
                     this.i7 = this.i5;
                  }
               }
               else
               {
                  this.i7 = this.i3;
               }
               this.i4 = 4;
               mstate.esp -= 12;
               this.i7 -= this.i3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -16);
               si32(this.i4,mstate.ebp + -8);
               this.i3 = li32(this.i0);
               mstate.esp -= 16;
               this.i3 += -12;
               this.i7 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               §§goto(addr1057);
            case 15:
               mstate.esp += 16;
               this.i1 = li32(this.i0);
               this.i1 += -12;
               si32(this.i1,this.i0);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 16:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -32);
               si32(this.i5,mstate.ebp + -24);
               this.i3 = li32(this.i0);
               mstate.esp -= 16;
               this.i3 += -12;
               this.i4 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               addr1057:
               si32(this.i3,mstate.esp + 12);
               state = 15;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            default:
               throw "Invalid state in _createstdfile";
         }
         this.i2 = mstate.eax;
         mstate.esp += 8;
         this.i4 = li8(this.i3);
         if(this.i4 != 0)
         {
            this.i4 = this.i7;
            while(true)
            {
               this.i5 = li8(this.i4 + 1);
               this.i4 += 1;
               this.i6 = this.i4;
               if(this.i5 == 0)
               {
                  break;
               }
               this.i4 = this.i6;
            }
         }
         else
         {
            this.i4 = this.i3;
         }
         this.i5 = 4;
         mstate.esp -= 12;
         this.i4 -= this.i7;
         si32(this.i1,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         si32(this.i4,mstate.esp + 8);
         state = 16;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
