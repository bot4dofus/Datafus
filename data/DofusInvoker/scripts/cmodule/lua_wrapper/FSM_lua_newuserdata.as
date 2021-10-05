package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_lua_newuserdata extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public function FSM_lua_newuserdata()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_lua_newuserdata = null;
         _loc1_ = new FSM_lua_newuserdata();
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
               addr107:
               this.i1 = li32(this.i0 + 20);
               this.i2 = li32(this.i0 + 40);
               if(this.i1 == this.i2)
               {
                  this.i1 = li32(this.i0 + 72);
               }
               else
               {
                  this.i1 = li32(this.i1 + 4);
                  this.i1 = li32(this.i1);
                  this.i1 = li32(this.i1 + 12);
               }
               if(uint(this.i3) >= uint(-22))
               {
                  this.i2 = __2E_str149;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               break;
            case 1:
               mstate.esp += 4;
               §§goto(addr107);
            case 2:
               mstate.esp += 8;
               break;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               if(this.i2 == 0)
               {
                  if(this.i8 != 0)
                  {
                     this.i6 = 4;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               §§goto(addr344);
            case 4:
               mstate.esp += 8;
               addr344:
               this.i6 = 7;
               this.i7 = li32(this.i5 + 68);
               this.i7 = this.i8 + this.i7;
               si32(this.i7,this.i5 + 68);
               this.i5 = li32(this.i4);
               this.i5 = li8(this.i5 + 20);
               this.i5 &= 3;
               si8(this.i5,this.i2 + 5);
               si8(this.i6,this.i2 + 4);
               si32(this.i3,this.i2 + 16);
               this.i3 = 0;
               si32(this.i3,this.i2 + 8);
               si32(this.i1,this.i2 + 12);
               this.i1 = li32(this.i4);
               this.i1 = li32(this.i1 + 104);
               this.i1 = li32(this.i1);
               si32(this.i1,this.i2);
               this.i1 = li32(this.i4);
               this.i1 = li32(this.i1 + 104);
               si32(this.i2,this.i1);
               this.i1 = li32(this.i0 + 8);
               si32(this.i2,this.i1);
               si32(this.i6,this.i1 + 8);
               this.i1 = li32(this.i0 + 8);
               this.i1 += 12;
               si32(this.i1,this.i0 + 8);
               this.i0 = this.i2 + 20;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _lua_newuserdata";
         }
         this.i2 = 0;
         this.i5 = li32(this.i4);
         this.i6 = li32(this.i5 + 12);
         this.i7 = li32(this.i5 + 16);
         mstate.esp -= 16;
         this.i8 = this.i3 + 20;
         si32(this.i7,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         si32(this.i8,mstate.esp + 12);
         state = 3;
         mstate.esp -= 4;
         mstate.funcs[this.i6]();
      }
   }
}
