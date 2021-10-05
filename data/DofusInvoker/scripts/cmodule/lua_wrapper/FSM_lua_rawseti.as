package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_lua_rawseti extends Machine
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
      
      public function FSM_lua_rawseti()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_lua_rawseti = null;
         _loc1_ = new FSM_lua_rawseti();
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
               this.i0 = _luaO_nilobject_;
               this.i1 = li32(mstate.ebp + 8);
               mstate.esp -= 8;
               this.i2 = li32(mstate.ebp + 12);
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 8);
               this.i4 = li32(this.i2);
               mstate.esp -= 8;
               this.i5 = li32(mstate.ebp + 16);
               si32(this.i4,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 2:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i7 = this.i1 + 8;
               if(this.i6 != this.i0)
               {
                  this.i4 = this.i6;
                  break;
               }
               this.i0 = 3;
               this.f0 = Number(this.i5);
               sf64(this.f0,mstate.ebp + -16);
               si32(this.i0,mstate.ebp + -8);
               mstate.esp -= 12;
               this.i0 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_newkey.start();
               return;
               break;
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               break;
            default:
               throw "Invalid state in _lua_rawseti";
         }
         this.i0 = this.i4;
         this.f0 = lf64(this.i3 + -12);
         sf64(this.f0,this.i0);
         this.i3 = li32(this.i3 + -4);
         si32(this.i3,this.i0 + 8);
         this.i0 = li32(this.i7);
         this.i3 = li32(this.i0 + -4);
         if(this.i3 >= 4)
         {
            this.i3 = li32(this.i0 + -12);
            this.i3 = li8(this.i3 + 5);
            this.i3 &= 3;
            if(this.i3 != 0)
            {
               this.i2 = li32(this.i2);
               this.i3 = li8(this.i2 + 5);
               this.i4 = this.i2 + 5;
               this.i5 = this.i3 & 4;
               if(this.i5 != 0)
               {
                  this.i0 = li32(this.i1 + 16);
                  this.i1 = this.i3 & -5;
                  si8(this.i1,this.i4);
                  this.i1 = li32(this.i0 + 40);
                  si32(this.i1,this.i2 + 24);
                  si32(this.i2,this.i0 + 40);
                  this.i0 = li32(this.i7);
               }
            }
         }
         this.i0 += -12;
         si32(this.i0,this.i7);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
