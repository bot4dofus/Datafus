package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_io_open extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public function FSM_io_open()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_io_open = null;
         _loc1_ = new FSM_io_open();
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
               this.i0 = 0;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i2 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 >= 1)
                  {
                     this.i2 = 0;
                     mstate.esp -= 12;
                     this.i3 = 2;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     si32(this.i2,mstate.esp + 8);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaL_checklstring.start();
                     return;
                  }
               }
               this.i2 = __2E_str19170;
               break;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               break;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = 0;
               si32(this.i4,this.i3);
               mstate.esp -= 8;
               this.i4 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = __2E_str17320;
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
               this.i6 = __2E_str17320;
               mstate.esp -= 12;
               this.i5 -= this.i6;
               si32(this.i1,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               si32(this.i5,mstate.ebp + -16);
               this.i5 = 4;
               si32(this.i5,mstate.ebp + -8);
               this.i5 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i6 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 7:
               mstate.esp += 16;
               this.i4 = li32(this.i1 + 8);
               this.i4 += 12;
               si32(this.i4,this.i1 + 8);
               mstate.esp -= 8;
               this.i4 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 8:
               mstate.esp += 8;
               this.i4 = li8(this.i2);
               this.i5 = li8(this.i2 + 1);
               this.i2 = li8(this.i2 + 2);
               mstate.esp -= 16;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 9;
               mstate.esp -= 4;
               FSM_fopen387.start();
               return;
            case 9:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               si32(this.i2,this.i3);
               if(this.i2 == 0)
               {
                  this.i2 = 0;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 10;
                  mstate.esp -= 4;
                  FSM_pushresult.start();
                  return;
               }
               this.i0 = 1;
               §§goto(addr672);
               break;
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               addr672:
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _io_open";
         }
         this.i3 = 4;
         mstate.esp -= 8;
         si32(this.i1,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         state = 4;
         mstate.esp -= 4;
         FSM_lua_newuserdata.start();
      }
   }
}
