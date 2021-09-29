package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaF_newLclosure extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public function FSM_luaF_newLclosure()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaF_newLclosure = null;
         _loc1_ = new FSM_luaF_newLclosure();
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
               this.i2 = li32(this.i1 + 16);
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = li32(this.i2 + 12);
               this.i5 = li32(this.i2 + 16);
               this.i6 = this.i3 << 2;
               mstate.esp -= 16;
               this.i6 += 20;
               si32(this.i5,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[this.i4]();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i4 = this.i1 + 16;
               this.i5 = li32(mstate.ebp + 16);
               if(this.i0 == 0)
               {
                  if(this.i6 != 0)
                  {
                     this.i7 = 4;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
                  break;
               }
               break;
            case 2:
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _luaF_newLclosure";
         }
         this.i1 = 6;
         this.i7 = li32(this.i2 + 68);
         this.i6 += this.i7;
         si32(this.i6,this.i2 + 68);
         this.i2 = li32(this.i4);
         this.i4 = li32(this.i2 + 28);
         si32(this.i4,this.i0);
         si32(this.i0,this.i2 + 28);
         this.i2 = li8(this.i2 + 20);
         this.i2 &= 3;
         si8(this.i2,this.i0 + 5);
         si8(this.i1,this.i0 + 4);
         this.i1 = 0;
         si8(this.i1,this.i0 + 6);
         si32(this.i5,this.i0 + 12);
         si8(this.i3,this.i0 + 7);
         this.i1 = this.i0;
         if(this.i3 != 0)
         {
            this.i2 = 0;
            this.i4 = this.i3 << 2;
            this.i1 += this.i4;
            this.i1 += 16;
            do
            {
               this.i4 = 0;
               si32(this.i4,this.i1);
               this.i1 += -4;
               this.i2 += 1;
            }
            while(this.i2 != this.i3);
            
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
