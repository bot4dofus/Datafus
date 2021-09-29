package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_lua_pushcclosure extends Machine
   {
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_lua_pushcclosure()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_lua_pushcclosure = null;
         _loc1_ = new FSM_lua_pushcclosure();
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
               this.i4 = li32(mstate.ebp + 16);
               this.i5 = this.i0 + 16;
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 1:
               mstate.esp += 4;
               break;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               if(this.i2 == 0)
               {
                  if(this.i9 != 0)
                  {
                     this.i7 = 4;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               §§goto(addr307);
            case 3:
               mstate.esp += 8;
               addr307:
               this.i7 = 6;
               this.i8 = li32(this.i6 + 68);
               this.i8 = this.i9 + this.i8;
               si32(this.i8,this.i6 + 68);
               this.i5 = li32(this.i5);
               this.i6 = li32(this.i5 + 28);
               si32(this.i6,this.i2);
               si32(this.i2,this.i5 + 28);
               this.i5 = li8(this.i5 + 20);
               this.i5 &= 3;
               si8(this.i5,this.i2 + 5);
               si8(this.i7,this.i2 + 4);
               this.i5 = 1;
               si8(this.i5,this.i2 + 6);
               si32(this.i1,this.i2 + 12);
               si8(this.i4,this.i2 + 7);
               this.i1 = 0 - this.i4;
               si32(this.i3,this.i2 + 16);
               this.i3 = li32(this.i0 + 8);
               this.i1 *= 12;
               this.i1 = this.i3 + this.i1;
               si32(this.i1,this.i0 + 8);
               this.i0 += 8;
               this.i3 = this.i2;
               if(this.i4 != 0)
               {
                  this.i5 = 0;
                  this.i6 = this.i4 * 12;
                  do
                  {
                     this.i1 += this.i6;
                     this.f0 = lf64(this.i1 + -12);
                     this.i7 = this.i2 + this.i6;
                     sf64(this.f0,this.i7 + 8);
                     this.i1 = li32(this.i1 + -4);
                     si32(this.i1,this.i7 + 16);
                     this.i1 = li32(this.i0);
                     this.i6 += -12;
                     this.i5 += 1;
                  }
                  while(this.i5 != this.i4);
                  
               }
               this.i2 = 6;
               si32(this.i3,this.i1);
               si32(this.i2,this.i1 + 8);
               this.i1 = li32(this.i0);
               this.i1 += 12;
               si32(this.i1,this.i0);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _lua_pushcclosure";
         }
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
         this.i2 = 0;
         this.i6 = li32(this.i5);
         this.i7 = li32(this.i6 + 12);
         this.i8 = li32(this.i6 + 16);
         this.i9 = this.i4 * 12;
         mstate.esp -= 16;
         this.i9 += 20;
         si32(this.i8,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         si32(this.i9,mstate.esp + 12);
         state = 2;
         mstate.esp -= 4;
         mstate.funcs[this.i7]();
      }
   }
}
