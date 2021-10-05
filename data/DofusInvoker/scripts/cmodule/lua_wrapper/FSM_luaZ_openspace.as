package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaZ_openspace extends Machine
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
      
      public function FSM_luaZ_openspace()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaZ_openspace = null;
         _loc1_ = new FSM_luaZ_openspace();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(this.i0 + 8);
               this.i2 = this.i0 + 8;
               this.i3 = li32(mstate.ebp + 8);
               this.i4 = li32(mstate.ebp + 16);
               if(uint(this.i1) < uint(this.i4))
               {
                  this.i4 = uint(this.i4) < uint(32) ? 32 : int(this.i4);
                  this.i5 = this.i4 + 1;
                  if(uint(this.i5) <= uint(-3))
                  {
                     this.i5 = li32(this.i3 + 16);
                     this.i6 = li32(this.i0);
                     this.i7 = li32(this.i5 + 12);
                     this.i8 = li32(this.i5 + 16);
                     mstate.esp -= 16;
                     si32(this.i8,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     si32(this.i1,mstate.esp + 8);
                     si32(this.i4,mstate.esp + 12);
                     state = 1;
                     mstate.esp -= 4;
                     mstate.funcs[this.i7]();
                     return;
                  }
                  this.i1 = __2E_str149;
                  mstate.esp -= 8;
                  si32(this.i3,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               this.i0 = li32(this.i0);
               mstate.eax = this.i0;
               break;
            case 1:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               if(this.i6 == 0)
               {
                  if(this.i4 != 0)
                  {
                     this.i7 = 4;
                     mstate.esp -= 8;
                     si32(this.i3,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr237:
               this.i3 = li32(this.i5 + 68);
               this.i1 = this.i4 - this.i1;
               this.i3 = this.i1 + this.i3;
               si32(this.i3,this.i5 + 68);
               si32(this.i6,this.i0);
               si32(this.i4,this.i2);
               mstate.eax = this.i6;
               break;
            case 2:
               mstate.esp += 8;
               §§goto(addr237);
            case 3:
               mstate.esp += 8;
               this.i1 = 0;
               si32(this.i1,this.i0);
               si32(this.i4,this.i2);
               mstate.eax = this.i1;
               break;
            default:
               throw "Invalid state in _luaZ_openspace";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
