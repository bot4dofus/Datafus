package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_lua_rawset extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 2;
       
      
      public var f1:Number;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_lua_rawset()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_lua_rawset = null;
         _loc1_ = new FSM_lua_rawset();
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
               this.i5 = this.i3 + -24;
               si32(this.i4,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_get.start();
            case 2:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               si8(this.i0,this.i4 + 6);
               this.i0 = this.i1 + 8;
               this.i7 = _luaO_nilobject_;
               if(this.i6 != this.i7)
               {
                  this.i4 = this.i6;
                  break;
               }
               this.i6 = li32(this.i3 + -16);
               if(this.i6 != 3)
               {
                  if(this.i6 == 0)
                  {
                     this.i6 = __2E_str3127;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaG_runerror.start();
                     return;
                  }
               }
               else
               {
                  this.f0 = 0;
                  this.f1 = lf64(this.i3 + -24);
                  if(!(this.f1 != Number.NaN && this.f0 != Number.NaN))
                  {
                     this.i6 = __2E_str4128;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaG_runerror.start();
                     return;
                  }
               }
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_newkey.start();
               return;
               break;
            case 3:
               mstate.esp += 8;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_newkey.start();
               return;
            case 4:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               break;
            case 5:
               mstate.esp += 8;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_newkey.start();
               return;
            case 6:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               break;
            case 7:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               break;
            default:
               throw "Invalid state in _lua_rawset";
         }
         this.f0 = lf64(this.i3 + -12);
         sf64(this.f0,this.i4);
         this.i3 = li32(this.i3 + -4);
         si32(this.i3,this.i4 + 8);
         this.i3 = li32(this.i0);
         this.i4 = li32(this.i3 + -4);
         if(this.i4 >= 4)
         {
            this.i4 = li32(this.i3 + -12);
            this.i4 = li8(this.i4 + 5);
            this.i4 &= 3;
            if(this.i4 != 0)
            {
               this.i2 = li32(this.i2);
               this.i4 = li8(this.i2 + 5);
               this.i5 = this.i2 + 5;
               this.i6 = this.i4 & 4;
               if(this.i6 != 0)
               {
                  this.i3 = li32(this.i1 + 16);
                  this.i1 = this.i4 & -5;
                  si8(this.i1,this.i5);
                  this.i1 = li32(this.i3 + 40);
                  si32(this.i1,this.i2 + 24);
                  si32(this.i2,this.i3 + 40);
                  this.i3 = li32(this.i0);
                  this.i3 += -24;
                  si32(this.i3,this.i0);
               }
               else
               {
                  addr588:
                  this.i1 = this.i3 + -24;
                  si32(this.i1,this.i0);
               }
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            }
         }
         §§goto(addr588);
      }
   }
}
