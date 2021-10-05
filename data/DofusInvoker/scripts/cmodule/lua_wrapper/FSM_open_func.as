package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_open_func extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_open_func()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_open_func = null;
         _loc1_ = new FSM_open_func();
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
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 40);
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 1;
               mstate.esp -= 4;
               FSM_luaF_newproto.start();
               return;
            case 1:
               this.i3 = mstate.eax;
               this.i4 = li32(mstate.ebp + 12);
               mstate.esp += 4;
               si32(this.i3,this.i4);
               this.i5 = li32(this.i1 + 36);
               si32(this.i5,this.i4 + 8);
               si32(this.i1,this.i4 + 12);
               si32(this.i2,this.i4 + 16);
               si32(this.i4,this.i1 + 36);
               si32(this.i0,this.i4 + 24);
               this.i5 = -1;
               si32(this.i5,this.i4 + 28);
               si32(this.i5,this.i4 + 32);
               si32(this.i0,this.i4 + 36);
               si32(this.i0,this.i4 + 40);
               si32(this.i0,this.i4 + 44);
               si16(this.i0,this.i4 + 48);
               si8(this.i0,this.i4 + 50);
               si32(this.i0,this.i4 + 20);
               this.i1 = li32(this.i1 + 52);
               si32(this.i1,this.i3 + 32);
               this.i1 = 2;
               si8(this.i1,this.i3 + 75);
               this.i1 = li32(this.i2 + 16);
               this.i5 = li32(this.i1 + 12);
               this.i6 = li32(this.i1 + 16);
               mstate.esp -= 16;
               this.i7 = 32;
               si32(this.i6,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 2;
               mstate.esp -= 4;
               mstate.funcs[this.i5]();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i5 = this.i2 + 16;
               if(this.i0 == 0)
               {
                  this.i6 = 4;
                  mstate.esp -= 8;
                  si32(this.i2,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               §§goto(addr350);
               break;
            case 3:
               mstate.esp += 8;
               addr350:
               this.i6 = 5;
               this.i7 = li32(this.i1 + 68);
               this.i7 += 32;
               si32(this.i7,this.i1 + 68);
               this.i1 = li32(this.i5);
               this.i7 = li32(this.i1 + 28);
               si32(this.i7,this.i0);
               si32(this.i0,this.i1 + 28);
               this.i1 = li8(this.i1 + 20);
               this.i1 &= 3;
               si8(this.i1,this.i0 + 5);
               si8(this.i6,this.i0 + 4);
               this.i1 = 0;
               si32(this.i1,this.i0 + 8);
               this.i6 = -1;
               si8(this.i6,this.i0 + 6);
               si32(this.i1,this.i0 + 12);
               si32(this.i1,this.i0 + 28);
               si8(this.i1,this.i0 + 7);
               this.i6 = _dummynode_;
               si32(this.i6,this.i0 + 16);
               this.i5 = li32(this.i5);
               this.i6 = li32(this.i5 + 12);
               this.i5 = li32(this.i5 + 16);
               mstate.esp -= 16;
               si32(this.i5,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               mstate.funcs[this.i6]();
               return;
            case 4:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               si32(this.i1,this.i0 + 12);
               this.i1 = li32(this.i0 + 28);
               this.i5 = this.i0 + 28;
               this.i6 = this.i0 + 12;
               this.i7 = this.i0;
               if(this.i1 <= -1)
               {
                  this.i8 = this.i1 * 12;
                  this.i8 += 8;
                  do
                  {
                     this.i9 = 0;
                     this.i10 = li32(this.i6);
                     this.i10 += this.i8;
                     si32(this.i9,this.i10);
                     this.i8 += 12;
                     this.i1 += 1;
                  }
                  while(this.i1 <= -1);
                  
               }
               this.i1 = 0;
               si32(this.i1,this.i5);
               mstate.esp -= 12;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_setnodevector.start();
               return;
            case 5:
               mstate.esp += 12;
               si32(this.i0,this.i4 + 4);
               this.i0 = li32(this.i2 + 8);
               si32(this.i7,this.i0);
               this.i1 = 5;
               si32(this.i1,this.i0 + 8);
               this.i0 = li32(this.i2 + 28);
               this.i1 = li32(this.i2 + 8);
               this.i4 = this.i2 + 28;
               this.i5 = this.i2 + 8;
               this.i0 -= this.i1;
               if(this.i0 <= 12)
               {
                  this.i0 = li32(this.i2 + 44);
                  if(this.i0 >= 1)
                  {
                     mstate.esp -= 8;
                     this.i0 <<= 1;
                     si32(this.i2,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  mstate.esp -= 8;
                  this.i0 += 1;
                  si32(this.i2,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaD_reallocstack.start();
                  return;
               }
               addr860:
               this.i0 = 9;
               this.i1 = li32(this.i5);
               this.i6 = this.i1 + 12;
               si32(this.i6,this.i5);
               si32(this.i3,this.i1 + 12);
               si32(this.i0,this.i1 + 20);
               this.i0 = li32(this.i4);
               this.i1 = li32(this.i5);
               this.i0 -= this.i1;
               if(this.i0 <= 12)
               {
                  this.i1 = li32(this.i2 + 44);
                  if(this.i1 >= 1)
                  {
                     mstate.esp -= 8;
                     this.i1 <<= 1;
                     si32(this.i2,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     state = 8;
                     mstate.esp -= 4;
                     FSM_luaD_reallocstack.start();
                     return;
                  }
                  mstate.esp -= 8;
                  this.i1 += 1;
                  si32(this.i2,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaD_reallocstack.start();
                  return;
               }
               this.i0 = this.i1 + 12;
               si32(this.i0,this.i5);
               break;
            case 6:
               mstate.esp += 8;
               §§goto(addr860);
            case 7:
               mstate.esp += 8;
               §§goto(addr860);
            case 8:
               mstate.esp += 8;
               addr1014:
               this.i1 = li32(this.i5);
               this.i1 += 12;
               si32(this.i1,this.i5);
               break;
            case 9:
               mstate.esp += 8;
               §§goto(addr1014);
            default:
               throw "Invalid state in _open_func";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
