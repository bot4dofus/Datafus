package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_newmetatable extends Machine
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
      
      public function FSM_luaL_newmetatable()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_newmetatable = null;
         _loc1_ = new FSM_luaL_newmetatable();
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
               this.i0 = -10000;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               this.i2 = li32(mstate.ebp + 12);
               mstate.esp += 8;
               this.i3 = li8(this.i2);
               this.i4 = this.i2;
               if(this.i3 != 0)
               {
                  this.i3 = this.i4;
                  while(true)
                  {
                     this.i5 = li8(this.i3 + 1);
                     this.i3 += 1;
                     this.i6 = this.i3;
                     if(this.i5 == 0)
                     {
                        break;
                     }
                     this.i3 = this.i6;
                  }
               }
               else
               {
                  this.i3 = this.i2;
               }
               this.i5 = 4;
               mstate.esp -= 12;
               this.i3 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -16);
               si32(this.i6,mstate.ebp + -8);
               this.i2 = li32(this.i3);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 3;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 3:
               mstate.esp += 16;
               this.i0 = li32(this.i3);
               this.i0 += -12;
               si32(this.i0,this.i3);
               §§goto(addr294);
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -32);
               si32(this.i5,mstate.ebp + -24);
               this.i3 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i5 = mstate.ebp + -32;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 5;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 5:
               mstate.esp += 16;
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = this.i1 + 8;
               this.i5 = _luaO_nilobject_;
               if(this.i0 != this.i5)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 0)
                  {
                     this.i0 = 0;
                     this.i5 = li32(this.i3);
                     this.i5 += -12;
                     si32(this.i5,this.i3);
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_lua_createtable.start();
                     return;
                  }
               }
               addr294:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 7:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i3);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i5);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i5 + 8);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 9:
               break;
            default:
               throw "Invalid state in _luaL_newmetatable";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i5 = li8(this.i2);
         if(this.i5 != 0)
         {
            this.i5 = this.i4;
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
         }
         else
         {
            this.i5 = this.i2;
         }
         this.i6 = 4;
         mstate.esp -= 12;
         this.i4 = this.i5 - this.i4;
         si32(this.i1,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i4,mstate.esp + 8);
         state = 2;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
