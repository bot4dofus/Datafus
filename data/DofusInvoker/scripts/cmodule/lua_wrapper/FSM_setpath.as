package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_setpath extends Machine
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
      
      public function FSM_setpath()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_setpath = null;
         _loc1_ = new FSM_setpath();
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
               mstate.esp -= 32;
               mstate.esp -= 4;
               this.i0 = li32(mstate.ebp + 16);
               si32(this.i0,mstate.esp);
               mstate.esp -= 4;
               FSM_getenv.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 20);
               this.i4 = this.i1;
               if(this.i0 == 0)
               {
                  this.i0 = -2;
                  mstate.esp -= 8;
                  si32(this.i2,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_lua_pushstring.start();
                  return;
               }
               this.i5 = __2E_str40509;
               mstate.esp -= 16;
               this.i6 = __2E_str41510;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaL_gsub.start();
               return;
               break;
            case 2:
               mstate.esp += 8;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li8(this.i1);
               if(this.i3 != 0)
               {
                  this.i3 = this.i4;
                  while(true)
                  {
                     this.i4 = li8(this.i3 + 1);
                     this.i3 += 1;
                     this.i5 = this.i3;
                     if(this.i4 == 0)
                     {
                        break;
                     }
                     this.i3 = this.i5;
                  }
               }
               else
               {
                  this.i3 = this.i1;
               }
               this.i4 = 4;
               mstate.esp -= 12;
               this.i3 -= this.i1;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 16;
               this.i5 = __2E_str42511;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 5;
               mstate.esp -= 4;
               FSM_luaL_gsub.start();
               return;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i2 + 8);
               this.i5 = this.i2 + 8;
               this.i6 = this.i0;
               this.i7 = this.i0 + 12;
               if(uint(this.i7) >= uint(this.i3))
               {
                  this.i0 = this.i3;
               }
               else
               {
                  this.i0 += 12;
                  this.i3 = this.i6;
                  while(true)
                  {
                     this.f0 = lf64(this.i3 + 12);
                     sf64(this.f0,this.i3);
                     this.i6 = li32(this.i3 + 20);
                     si32(this.i6,this.i3 + 8);
                     this.i3 = li32(this.i5);
                     this.i6 = this.i0 + 12;
                     this.i7 = this.i0;
                     if(uint(this.i6) >= uint(this.i3))
                     {
                        break;
                     }
                     this.i0 = this.i6;
                     this.i3 = this.i7;
                  }
                  this.i0 = this.i3;
               }
               this.i3 = -2;
               this.i0 += -12;
               si32(this.i0,this.i5);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 7:
               break;
            case 8:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,mstate.ebp + -32);
               si32(this.i4,mstate.ebp + -24);
               this.i1 = li32(this.i2 + 8);
               mstate.esp -= 16;
               this.i1 += -12;
               this.i3 = mstate.ebp + -32;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 9;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 9:
               mstate.esp += 16;
               this.i0 = li32(this.i2 + 8);
               this.i0 += -12;
               si32(this.i0,this.i2 + 8);
               §§goto(addr748);
            case 10:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,mstate.ebp + -16);
               si32(this.i6,mstate.ebp + -8);
               this.i1 = li32(this.i5);
               mstate.esp -= 16;
               this.i1 += -12;
               this.i3 = mstate.ebp + -16;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 11;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 11:
               mstate.esp += 16;
               this.i0 = li32(this.i5);
               this.i0 += -12;
               si32(this.i0,this.i5);
               addr748:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _setpath";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i3 = li8(this.i1);
         if(this.i3 != 0)
         {
            this.i3 = this.i4;
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
         }
         else
         {
            this.i3 = this.i1;
         }
         this.i6 = 4;
         mstate.esp -= 12;
         this.i3 -= this.i4;
         si32(this.i2,mstate.esp);
         si32(this.i1,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 10;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
