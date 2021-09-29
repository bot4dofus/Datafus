package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaD_throw extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
      
      public function FSM_luaD_throw()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaD_throw = null;
         _loc1_ = new FSM_luaD_throw();
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
               this.i1 = li32(this.i0 + 104);
               this.i2 = this.i0 + 104;
               this.i3 = li32(mstate.ebp + 12);
               if(this.i1 != 0)
               {
                  this.i0 = 1;
                  si32(this.i3,this.i1 + 52);
                  this.i2 = li32(this.i2);
                  mstate.esp -= 8;
                  this.i2 += 4;
                  si32(this.i2,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  mstate.funcs[__longjmp]();
                  return;
               }
               addr121:
               si8(this.i3,this.i0 + 6);
               this.i1 = li32(this.i0 + 16);
               this.i1 = li32(this.i1 + 88);
               this.i4 = this.i0 + 16;
               if(this.i1 != 0)
               {
                  this.i1 = li32(this.i0 + 40);
                  si32(this.i1,this.i0 + 20);
                  this.i1 = li32(this.i1);
                  si32(this.i1,this.i0 + 12);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaF_close.start();
                  return;
               }
               this.i0 = 1;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               §§goto(addr623);
               break;
            case 1:
               mstate.esp += 8;
               §§goto(addr121);
            case 2:
               mstate.esp += 8;
               this.i1 = li32(this.i0 + 12);
               this.i5 = this.i3 + -2;
               if(uint(this.i5) >= uint(2))
               {
                  if(this.i3 != 5)
                  {
                     if(this.i3 == 4)
                     {
                        this.i3 = __2E_str111;
                        mstate.esp -= 12;
                        this.i5 = 17;
                        si32(this.i0,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        si32(this.i5,mstate.esp + 8);
                        state = 3;
                        mstate.esp -= 4;
                        FSM_luaS_newlstr.start();
                        return;
                     }
                     this.i1 += 12;
                     si32(this.i1,this.i0 + 8);
                     break;
                  }
                  this.i3 = __2E_str212;
                  mstate.esp -= 12;
                  this.i5 = 23;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaS_newlstr.start();
                  return;
               }
               this.i3 = li32(this.i0 + 8);
               this.f0 = lf64(this.i3 + -12);
               sf64(this.f0,this.i1);
               this.i3 = li32(this.i3 + -4);
               si32(this.i3,this.i1 + 8);
               this.i1 += 12;
               si32(this.i1,this.i0 + 8);
               break;
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i1);
               this.i3 = 4;
               si32(this.i3,this.i1 + 8);
               this.i1 += 12;
               si32(this.i1,this.i0 + 8);
               break;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i1);
               this.i3 = 4;
               si32(this.i3,this.i1 + 8);
               this.i1 += 12;
               si32(this.i1,this.i0 + 8);
               break;
            case 5:
               mstate.esp += 4;
               this.i3 = 0;
               si32(this.i3,this.i0 + 108);
               si32(this.i3,this.i2);
               this.i2 = li32(this.i4);
               this.i2 = li32(this.i2 + 88);
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               mstate.funcs[this.i2]();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               addr623:
               state = 7;
               mstate.esp -= 4;
               FSM_exit.start();
               return;
            case 7:
               mstate.esp += 4;
            default:
               throw "Invalid state in _luaD_throw";
         }
         this.i1 = 1;
         this.i3 = li16(this.i0 + 54);
         si16(this.i3,this.i0 + 52);
         si8(this.i1,this.i0 + 57);
         mstate.esp -= 4;
         si32(this.i0,mstate.esp);
         state = 5;
         mstate.esp -= 4;
         FSM_restore_stack_limit.start();
      }
   }
}
