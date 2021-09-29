package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_lua_createtable extends Machine
   {
      
      public static const intRegCount:int = 12;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
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
      
      public function FSM_lua_createtable()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_lua_createtable = null;
         _loc1_ = new FSM_lua_createtable();
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
               this.i1 = li32(this.i0 + 16);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = this.i0 + 16;
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr107);
               break;
            case 1:
               mstate.esp += 4;
               addr107:
               this.i1 = 32;
               this.i2 = li32(this.i4);
               this.i5 = li32(this.i0 + 8);
               this.i6 = li32(this.i2 + 12);
               this.i7 = li32(this.i2 + 16);
               mstate.esp -= 16;
               this.i8 = 0;
               si32(this.i7,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 2;
               mstate.esp -= 4;
               mstate.funcs[this.i6]();
               return;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i6 = this.i0 + 8;
               if(this.i1 == 0)
               {
                  this.i7 = 4;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               break;
            case 3:
               mstate.esp += 8;
               break;
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               si32(this.i2,this.i1 + 12);
               this.i2 = li32(this.i1 + 28);
               this.i4 = this.i1 + 28;
               this.i7 = this.i1 + 12;
               this.i8 = this.i1;
               if(this.i2 <= -1)
               {
                  this.i9 = this.i2 * 12;
                  this.i9 += 8;
                  do
                  {
                     this.i10 = 0;
                     this.i11 = li32(this.i7);
                     this.i11 += this.i9;
                     si32(this.i10,this.i11);
                     this.i9 += 12;
                     this.i2 += 1;
                  }
                  while(this.i2 <= -1);
                  
               }
               this.i2 = 0;
               si32(this.i2,this.i4);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_setnodevector.start();
               return;
            case 5:
               mstate.esp += 12;
               si32(this.i8,this.i5);
               this.i0 = 5;
               si32(this.i0,this.i5 + 8);
               this.i0 = li32(this.i6);
               this.i0 += 12;
               si32(this.i0,this.i6);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _lua_createtable";
         }
         this.i7 = 5;
         this.i8 = li32(this.i2 + 68);
         this.i8 += 32;
         si32(this.i8,this.i2 + 68);
         this.i2 = li32(this.i4);
         this.i8 = li32(this.i2 + 28);
         si32(this.i8,this.i1);
         si32(this.i1,this.i2 + 28);
         this.i2 = li8(this.i2 + 20);
         this.i2 &= 3;
         si8(this.i2,this.i1 + 5);
         si8(this.i7,this.i1 + 4);
         this.i2 = 0;
         si32(this.i2,this.i1 + 8);
         this.i7 = -1;
         si8(this.i7,this.i1 + 6);
         si32(this.i2,this.i1 + 12);
         si32(this.i2,this.i1 + 28);
         si8(this.i2,this.i1 + 7);
         this.i7 = _dummynode_;
         si32(this.i7,this.i1 + 16);
         this.i4 = li32(this.i4);
         this.i7 = li32(this.i4 + 12);
         this.i4 = li32(this.i4 + 16);
         mstate.esp -= 16;
         si32(this.i4,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         si32(this.i2,mstate.esp + 12);
         state = 4;
         mstate.esp -= 4;
         mstate.funcs[this.i7]();
      }
   }
}
