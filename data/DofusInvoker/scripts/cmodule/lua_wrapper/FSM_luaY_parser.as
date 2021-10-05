package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaY_parser extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var f0:Number;
      
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
      
      public function FSM_luaY_parser()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaY_parser = null;
         _loc1_ = new FSM_luaY_parser();
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
               mstate.esp -= 640;
               this.i0 = mstate.ebp + -64;
               this.i1 = li32(mstate.ebp + 16);
               this.i2 = li32(mstate.ebp + 20);
               si32(this.i1,mstate.ebp + -16);
               this.i1 = li8(this.i2);
               this.i0 += 48;
               this.i3 = li32(mstate.ebp + 8);
               this.i4 = li32(mstate.ebp + 12);
               this.i5 = this.i2;
               if(this.i1 != 0)
               {
                  this.i1 = this.i5;
                  while(true)
                  {
                     this.i6 = li8(this.i1 + 1);
                     this.i1 += 1;
                     this.i7 = this.i1;
                     if(this.i6 == 0)
                     {
                        break;
                     }
                     this.i1 = this.i7;
                  }
               }
               else
               {
                  this.i1 = this.i2;
               }
               this.i6 = 46;
               mstate.esp -= 12;
               this.i1 -= this.i5;
               si32(this.i3,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               if(this.i1 != 0)
               {
                  this.i3 = li32(mstate.ebp + -4);
                  if(this.i3 != 0)
                  {
                     this.i3 += -1;
                     si32(this.i3,this.i0);
                     si32(this.i1,this.i0 + 4);
                     this.i3 = li8(this.i1);
                     this.i1 += 1;
                     si32(this.i1,this.i0 + 4);
                     this.i0 = this.i3;
                     break;
                  }
               }
               this.i0 = -1;
               break;
            case 2:
               mstate.esp += 8;
               this.i0 = li32(mstate.ebp + -640);
               this.i2 = 2;
               si8(this.i2,this.i0 + 74);
               this.i0 = li32(this.i8);
               si32(this.i0,this.i7);
               this.i0 = li32(this.i5);
               if(this.i0 == 287)
               {
                  this.i0 = mstate.ebp + -64;
                  mstate.esp -= 8;
                  this.i2 = this.i0 + 16;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_llex.start();
                  return;
               }
               this.i2 = 287;
               si32(this.i0,mstate.ebp + -52);
               this.f0 = lf64(mstate.ebp + -36);
               sf64(this.f0,mstate.ebp + -48);
               si32(this.i2,this.i5);
               §§goto(addr449);
               break;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,mstate.ebp + -52);
               addr449:
               this.i0 = mstate.ebp + -64;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 4;
               mstate.esp -= 4;
               FSM_chunk.start();
               return;
            case 4:
               mstate.esp += 4;
               this.i0 = li32(mstate.ebp + -52);
               if(this.i0 != 287)
               {
                  this.i0 = 287;
                  mstate.esp -= 8;
                  this.i2 = mstate.ebp + -64;
                  si32(this.i2,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_error_expected.start();
                  return;
               }
               §§goto(addr543);
               break;
            case 5:
               mstate.esp += 8;
               addr543:
               this.i0 = mstate.ebp + -64;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               FSM_close_func.start();
               return;
            case 6:
               mstate.esp += 4;
               this.i0 = li32(this.i1);
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 7:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si8(this.i6,mstate.ebp + -8);
               si32(this.i3,mstate.ebp + -24);
               this.i2 = 287;
               si32(this.i2,mstate.ebp + -40);
               si32(this.i4,mstate.ebp + -20);
               this.i2 = 0;
               si32(this.i2,mstate.ebp + -28);
               this.i2 = 1;
               si32(this.i2,mstate.ebp + -60);
               si32(this.i2,mstate.ebp + -56);
               si32(this.i1,mstate.ebp + -12);
               this.i1 = li32(this.i0);
               this.i2 = li32(this.i3 + 16);
               this.i4 = li32(this.i1 + 8);
               this.i5 = li32(this.i1);
               this.i6 = li32(this.i2 + 12);
               this.i7 = li32(this.i2 + 16);
               mstate.esp -= 16;
               this.i8 = 32;
               si32(this.i7,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               this.i5 = mstate.ebp + -64;
               state = 8;
               mstate.esp -= 4;
               mstate.funcs[this.i6]();
               return;
            case 8:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               this.i7 = this.i5 + 8;
               this.i8 = this.i5 + 4;
               this.i9 = this.i5 + 44;
               this.i5 += 24;
               if(this.i6 == 0)
               {
                  this.i10 = 4;
                  mstate.esp -= 8;
                  si32(this.i3,mstate.esp);
                  si32(this.i10,mstate.esp + 4);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               addr920:
               this.i3 = 32;
               this.i10 = li32(this.i2 + 68);
               this.i4 = 32 - this.i4;
               this.i4 += this.i10;
               si32(this.i4,this.i2 + 68);
               si32(this.i6,this.i1);
               this.i0 = li32(this.i0);
               si32(this.i3,this.i0 + 8);
               this.i0 = li32(this.i9);
               this.i1 = li32(this.i0);
               this.i2 = this.i1 + -1;
               si32(this.i2,this.i0);
               this.i0 = li32(this.i9);
               this.i2 = mstate.ebp + -64;
               if(this.i1 != 0)
               {
                  this.i1 = li32(this.i0 + 4);
                  this.i3 = li8(this.i1);
                  this.i1 += 1;
                  si32(this.i1,this.i0 + 4);
                  this.i0 = this.i3;
                  break;
               }
               this.i1 = mstate.ebp + -4;
               this.i3 = li32(this.i0 + 16);
               this.i4 = li32(this.i0 + 8);
               this.i6 = li32(this.i0 + 12);
               mstate.esp -= 12;
               si32(this.i3,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[this.i4]();
               return;
               break;
            case 9:
               mstate.esp += 8;
               §§goto(addr920);
            default:
               throw "Invalid state in _luaY_parser";
         }
         this.i1 = mstate.ebp + -640;
         si32(this.i0,this.i2);
         mstate.esp -= 8;
         this.i0 = mstate.ebp + -64;
         si32(this.i0,mstate.esp);
         si32(this.i1,mstate.esp + 4);
         state = 2;
         mstate.esp -= 4;
         FSM_open_func.start();
      }
   }
}
