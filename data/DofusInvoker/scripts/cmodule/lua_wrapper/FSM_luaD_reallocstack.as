package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaD_reallocstack extends Machine
   {
      
      public static const intRegCount:int = 10;
      
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
      
      public var i9:int;
      
      public function FSM_luaD_reallocstack()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaD_reallocstack = null;
         _loc1_ = new FSM_luaD_reallocstack();
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
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 32);
               this.i3 = this.i0 + 6;
               this.i4 = this.i1 + 32;
               this.i5 = this.i0 + 7;
               if(uint(this.i5) <= uint(357913941))
               {
                  this.i5 = li32(this.i1 + 16);
                  this.i6 = li32(this.i1 + 44);
                  this.i7 = li32(this.i5 + 12);
                  this.i8 = li32(this.i5 + 16);
                  mstate.esp -= 16;
                  this.i6 *= 12;
                  this.i9 = this.i3 * 12;
                  si32(this.i8,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  si32(this.i9,mstate.esp + 12);
                  state = 1;
                  mstate.esp -= 4;
                  mstate.funcs[this.i7]();
                  return;
               }
               this.i5 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 1:
               this.i7 = mstate.eax;
               mstate.esp += 16;
               if(this.i7 == 0)
               {
                  if(this.i9 != 0)
                  {
                     this.i8 = 4;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i8,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr225:
               this.i8 = li32(this.i5 + 68);
               this.i6 = this.i9 - this.i6;
               this.i6 += this.i8;
               si32(this.i6,this.i5 + 68);
               this.i5 = this.i7;
               break;
            case 2:
               mstate.esp += 8;
               §§goto(addr225);
            case 3:
               mstate.esp += 8;
               this.i5 = 0;
               break;
            default:
               throw "Invalid state in _luaD_reallocstack";
         }
         this.i0 *= 12;
         si32(this.i5,this.i4);
         si32(this.i3,this.i1 + 44);
         this.i0 = this.i5 + this.i0;
         si32(this.i0,this.i1 + 28);
         this.i0 = li32(this.i1 + 8);
         this.i0 -= this.i2;
         this.i0 /= 12;
         this.i0 *= 12;
         this.i0 = this.i5 + this.i0;
         si32(this.i0,this.i1 + 8);
         this.i0 = li32(this.i1 + 96);
         if(this.i0 != 0)
         {
            do
            {
               this.i3 = li32(this.i0 + 8);
               this.i3 -= this.i2;
               this.i3 /= 12;
               this.i5 = li32(this.i4);
               this.i3 *= 12;
               this.i3 = this.i5 + this.i3;
               si32(this.i3,this.i0 + 8);
               this.i0 = li32(this.i0);
            }
            while(this.i0 != 0);
            
         }
         this.i0 = li32(this.i1 + 40);
         this.i3 = li32(this.i1 + 20);
         this.i5 = li32(this.i4);
         this.i6 = this.i1 + 20;
         if(uint(this.i3) >= uint(this.i0))
         {
            while(true)
            {
               this.i3 = li32(this.i0 + 8);
               this.i3 -= this.i2;
               this.i3 /= 12;
               this.i3 *= 12;
               this.i5 += this.i3;
               si32(this.i5,this.i0 + 8);
               this.i5 = li32(this.i0);
               this.i5 -= this.i2;
               this.i5 /= 12;
               this.i3 = li32(this.i4);
               this.i5 *= 12;
               this.i5 = this.i3 + this.i5;
               si32(this.i5,this.i0);
               this.i5 = li32(this.i0 + 4);
               this.i5 -= this.i2;
               this.i5 /= 12;
               this.i3 = li32(this.i4);
               this.i5 *= 12;
               this.i5 = this.i3 + this.i5;
               si32(this.i5,this.i0 + 4);
               this.i5 = li32(this.i6);
               this.i3 = li32(this.i4);
               this.i0 += 24;
               if(uint(this.i5) < uint(this.i0))
               {
                  break;
               }
               this.i5 = this.i3;
            }
            this.i0 = this.i3;
         }
         else
         {
            this.i0 = this.i5;
         }
         this.i3 = li32(this.i1 + 12);
         this.i2 = this.i3 - this.i2;
         this.i2 /= 12;
         this.i2 *= 12;
         this.i0 += this.i2;
         si32(this.i0,this.i1 + 12);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
