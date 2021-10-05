package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_f_luaopen391 extends Machine
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
      
      public function FSM_f_luaopen391()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_f_luaopen391 = null;
         _loc1_ = new FSM_f_luaopen391();
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
               this.i0 = 32;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 16);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_stack_init.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 16);
               this.i4 = li32(this.i3 + 12);
               this.i5 = li32(this.i3 + 16);
               mstate.esp -= 16;
               this.i6 = 0;
               si32(this.i5,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 2;
               mstate.esp -= 4;
               mstate.funcs[this.i4]();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i4 = this.i1 + 72;
               this.i5 = this.i1 + 16;
               if(this.i0 == 0)
               {
                  this.i6 = 4;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               §§goto(addr222);
               break;
            case 3:
               mstate.esp += 8;
               addr222:
               this.i6 = 5;
               this.i7 = li32(this.i3 + 68);
               this.i7 += 32;
               si32(this.i7,this.i3 + 68);
               this.i3 = li32(this.i5);
               this.i7 = li32(this.i3 + 28);
               si32(this.i7,this.i0);
               si32(this.i0,this.i3 + 28);
               this.i3 = li8(this.i3 + 20);
               this.i3 &= 3;
               si8(this.i3,this.i0 + 5);
               si8(this.i6,this.i0 + 4);
               this.i3 = 0;
               si32(this.i3,this.i0 + 8);
               this.i6 = -1;
               si8(this.i6,this.i0 + 6);
               si32(this.i3,this.i0 + 12);
               si32(this.i3,this.i0 + 28);
               si8(this.i3,this.i0 + 7);
               this.i6 = _dummynode_;
               si32(this.i6,this.i0 + 16);
               this.i6 = li32(this.i5);
               this.i7 = li32(this.i6 + 12);
               this.i6 = li32(this.i6 + 16);
               mstate.esp -= 16;
               si32(this.i6,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               mstate.funcs[this.i7]();
               return;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               si32(this.i3,this.i0 + 12);
               this.i3 = li32(this.i0 + 28);
               this.i6 = this.i0 + 28;
               this.i7 = this.i0 + 12;
               this.i8 = this.i0;
               if(this.i3 <= -1)
               {
                  this.i9 = this.i3 * 12;
                  this.i9 += 8;
                  do
                  {
                     this.i10 = 0;
                     this.i11 = li32(this.i7);
                     this.i11 += this.i9;
                     si32(this.i10,this.i11);
                     this.i9 += 12;
                     this.i3 += 1;
                  }
                  while(this.i3 <= -1);
                  
               }
               this.i3 = 0;
               si32(this.i3,this.i6);
               mstate.esp -= 12;
               this.i6 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_setnodevector.start();
               return;
            case 5:
               mstate.esp += 12;
               si32(this.i8,this.i4);
               this.i0 = 5;
               si32(this.i0,this.i1 + 80);
               this.i0 = li32(this.i5);
               this.i4 = li32(this.i0 + 12);
               this.i6 = li32(this.i0 + 16);
               mstate.esp -= 16;
               this.i7 = 32;
               si32(this.i6,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               mstate.funcs[this.i4]();
               return;
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               this.i4 = this.i0 + 92;
               if(this.i3 == 0)
               {
                  this.i6 = 4;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               break;
            case 7:
               mstate.esp += 8;
               break;
            case 8:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               si32(this.i6,this.i3 + 12);
               this.i6 = li32(this.i3 + 28);
               this.i7 = this.i3 + 28;
               this.i8 = this.i3 + 12;
               this.i9 = this.i3;
               if(this.i6 <= -1)
               {
                  this.i10 = this.i6 * 12;
                  this.i10 += 8;
                  do
                  {
                     this.i11 = 0;
                     this.i12 = li32(this.i8);
                     this.i12 += this.i10;
                     si32(this.i11,this.i12);
                     this.i10 += 12;
                     this.i6 += 1;
                  }
                  while(this.i6 <= -1);
                  
               }
               this.i6 = 0;
               si32(this.i6,this.i7);
               mstate.esp -= 12;
               this.i7 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM_setnodevector.start();
               return;
            case 9:
               mstate.esp += 12;
               si32(this.i9,this.i4);
               this.i3 = 5;
               si32(this.i3,this.i0 + 100);
               mstate.esp -= 8;
               this.i0 = 32;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 10;
               mstate.esp -= 4;
               FSM_luaS_resize.start();
               return;
            case 10:
               mstate.esp += 8;
               this.i0 = _luaT_eventname_2E_2633;
               this.i3 = this.i6;
               this.i4 = this.i6;
               §§goto(addr1134);
            case 11:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i1 = li8(this.i0 + 5);
               this.i1 |= 32;
               si8(this.i1,this.i0 + 5);
               this.i0 = li32(this.i2 + 68);
               this.i0 <<= 2;
               si32(this.i0,this.i2 + 64);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 12:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               this.i7 += this.i3;
               si32(this.i6,this.i7 + 168);
               this.i6 = li32(this.i5);
               this.i6 += this.i3;
               this.i6 = li32(this.i6 + 168);
               this.i7 = li8(this.i6 + 5);
               this.i7 |= 32;
               si8(this.i7,this.i6 + 5);
               this.i3 += 4;
               this.i4 += 1;
               if(this.i4 != 17)
               {
                  addr1134:
                  this.i6 = this.i0 + this.i3;
                  this.i6 = li32(this.i6);
                  this.i7 = li32(this.i5);
                  this.i8 = li8(this.i6);
                  this.i9 = this.i6;
                  if(this.i8 != 0)
                  {
                     this.i8 = this.i6;
                     while(true)
                     {
                        this.i10 = li8(this.i8 + 1);
                        this.i8 += 1;
                        this.i11 = this.i8;
                        if(this.i10 == 0)
                        {
                           break;
                        }
                        this.i8 = this.i11;
                     }
                  }
                  else
                  {
                     this.i8 = this.i9;
                  }
                  mstate.esp -= 12;
                  this.i6 = this.i8 - this.i6;
                  si32(this.i1,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  state = 12;
                  mstate.esp -= 4;
                  FSM_luaS_newlstr.start();
                  return;
               }
               this.i0 = _luaX_tokens;
               this.i3 = 0;
               this.i4 = 1;
               §§goto(addr1212);
               break;
            case 13:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               this.i6 = li8(this.i5 + 5);
               this.i6 |= 32;
               si8(this.i6,this.i5 + 5);
               si8(this.i4,this.i5 + 6);
               this.i4 += 1;
               this.i0 += 4;
               this.i3 += 1;
               if(this.i3 != 21)
               {
                  addr1212:
                  this.i5 = li32(this.i0);
                  this.i6 = li8(this.i5);
                  this.i7 = this.i5;
                  if(this.i6 != 0)
                  {
                     this.i6 = this.i5;
                     while(true)
                     {
                        this.i8 = li8(this.i6 + 1);
                        this.i6 += 1;
                        this.i9 = this.i6;
                        if(this.i8 == 0)
                        {
                           break;
                        }
                        this.i6 = this.i9;
                     }
                  }
                  else
                  {
                     this.i6 = this.i7;
                  }
                  mstate.esp -= 12;
                  this.i5 = this.i6 - this.i5;
                  si32(this.i1,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  state = 13;
                  mstate.esp -= 4;
                  FSM_luaS_newlstr.start();
                  return;
               }
               this.i0 = __2E_str111;
               mstate.esp -= 12;
               this.i3 = 17;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
               break;
            default:
               throw "Invalid state in _f_luaopen391";
         }
         this.i6 = 5;
         this.i7 = li32(this.i0 + 68);
         this.i7 += 32;
         si32(this.i7,this.i0 + 68);
         this.i7 = li32(this.i5);
         this.i8 = li32(this.i7 + 28);
         si32(this.i8,this.i3);
         si32(this.i3,this.i7 + 28);
         this.i7 = li8(this.i7 + 20);
         this.i7 &= 3;
         si8(this.i7,this.i3 + 5);
         si8(this.i6,this.i3 + 4);
         this.i6 = 0;
         si32(this.i6,this.i3 + 8);
         this.i7 = -1;
         si8(this.i7,this.i3 + 6);
         si32(this.i6,this.i3 + 12);
         si32(this.i6,this.i3 + 28);
         si8(this.i6,this.i3 + 7);
         this.i7 = _dummynode_;
         si32(this.i7,this.i3 + 16);
         this.i7 = li32(this.i5);
         this.i8 = li32(this.i7 + 12);
         this.i7 = li32(this.i7 + 16);
         mstate.esp -= 16;
         si32(this.i7,mstate.esp);
         si32(this.i6,mstate.esp + 4);
         si32(this.i6,mstate.esp + 8);
         si32(this.i6,mstate.esp + 12);
         state = 8;
         mstate.esp -= 4;
         mstate.funcs[this.i8]();
      }
   }
}
