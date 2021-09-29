package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_thunk_luaClose extends Machine
   {
      
      public static const intRegCount:int = 13;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public var i9:int;
      
      public function FSM_thunk_luaClose()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_thunk_luaClose = null;
         _loc1_ = new FSM_thunk_luaClose();
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
               mstate.esp -= 68;
               this.i0 = __2E_str12111;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = mstate.ebp + -68;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[_AS3_ArrayValue]();
               return;
            case 1:
               mstate.esp += 12;
               this.i1 = li32(mstate.ebp + -68);
               this.i0 = __2E_str13112;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = li32(this.i1 + 16);
               this.i0 = li32(this.i0 + 104);
               this.i1 = li32(this.i0 + 32);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaF_close.start();
               return;
            case 2:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i1 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaC_separateudata.start();
            case 3:
               this.i1 = mstate.eax;
               this.i1 = mstate.ebp + -64;
               mstate.esp += 8;
               this.i2 = 0;
               si32(this.i2,this.i0 + 108);
               this.i2 = this.i1 + 4;
               this.i3 = this.i0 + 104;
               this.i4 = this.i1 + 52;
               this.i5 = this.i0 + 52;
               this.i6 = this.i0 + 54;
               this.i7 = this.i0 + 12;
               this.i8 = this.i0 + 8;
               this.i9 = this.i0 + 20;
               this.i10 = this.i0 + 40;
               break;
            case 4:
               this.i11 = mstate.eax;
               mstate.esp += 4;
               if(this.i11 == 0)
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_callallgcTM392.start();
                  return;
               }
               addr419:
               this.i11 = li32(this.i1);
               si32(this.i11,this.i3);
               this.i11 = li32(this.i4);
               if(this.i11 == 0)
               {
                  this.i1 = __2E_str14113;
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_close_state.start();
                  return;
               }
               break;
            case 5:
               mstate.esp += 4;
               §§goto(addr419);
            case 6:
               mstate.esp += 4;
               this.i0 = this.i1;
               trace(mstate.gworker.stringFromPtr(this.i0));
               this.i0 = 0;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _thunk_luaClose";
         }
         this.i11 = 0;
         this.i12 = li32(this.i10);
         si32(this.i12,this.i9);
         this.i12 = li32(this.i12);
         si32(this.i12,this.i8);
         si32(this.i12,this.i7);
         si16(this.i11,this.i6);
         si16(this.i11,this.i5);
         si32(this.i11,this.i4);
         this.i11 = li32(this.i3);
         si32(this.i11,this.i1);
         this.i11 = mstate.ebp + -64;
         si32(this.i11,this.i3);
         mstate.esp -= 4;
         si32(this.i2,mstate.esp);
         state = 4;
         mstate.esp -= 4;
         mstate.funcs[__setjmp]();
      }
   }
}
