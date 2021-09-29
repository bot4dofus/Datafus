package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaD_reallocCI extends Machine
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
      
      public function FSM_luaD_reallocCI()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaD_reallocCI = null;
         _loc1_ = new FSM_luaD_reallocCI();
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
               this.i1 = li32(this.i0 + 40);
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = this.i0 + 40;
               this.i4 = this.i2 + 1;
               if(uint(this.i4) <= uint(178956970))
               {
                  this.i4 = li32(this.i0 + 16);
                  this.i5 = li32(this.i0 + 48);
                  this.i6 = li32(this.i4 + 12);
                  this.i7 = li32(this.i4 + 16);
                  mstate.esp -= 16;
                  this.i5 *= 24;
                  this.i8 = this.i2 * 24;
                  si32(this.i7,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  si32(this.i8,mstate.esp + 12);
                  state = 1;
                  mstate.esp -= 4;
                  mstate.funcs[this.i6]();
                  return;
               }
               this.i4 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 1:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               if(this.i6 == 0)
               {
                  if(this.i8 != 0)
                  {
                     this.i7 = 4;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr219:
               this.i7 = li32(this.i4 + 68);
               this.i5 = this.i8 - this.i5;
               this.i5 += this.i7;
               si32(this.i5,this.i4 + 68);
               this.i4 = this.i6;
               break;
            case 2:
               mstate.esp += 8;
               §§goto(addr219);
            case 3:
               mstate.esp += 8;
               this.i4 = 0;
               break;
            default:
               throw "Invalid state in _luaD_reallocCI";
         }
         si32(this.i4,this.i3);
         si32(this.i2,this.i0 + 48);
         this.i3 = li32(this.i0 + 20);
         this.i1 = this.i3 - this.i1;
         this.i1 /= 24;
         this.i2 *= 24;
         this.i1 *= 24;
         this.i2 += this.i4;
         this.i1 = this.i4 + this.i1;
         si32(this.i1,this.i0 + 20);
         this.i1 = this.i2 + -24;
         si32(this.i1,this.i0 + 36);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
