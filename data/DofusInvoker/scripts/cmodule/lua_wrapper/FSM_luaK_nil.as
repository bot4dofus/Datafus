package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaK_nil extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public function FSM_luaK_nil()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaK_nil = null;
         _loc1_ = new FSM_luaK_nil();
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
               this.i1 = li32(this.i0 + 24);
               this.i2 = li32(this.i0 + 28);
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = li32(mstate.ebp + 16);
               if(this.i1 > this.i2)
               {
                  if(this.i1 == 0)
                  {
                     this.i1 = li8(this.i0 + 50);
                     if(this.i1 <= this.i3)
                     {
                        break;
                     }
                  }
                  else
                  {
                     this.i2 = li32(this.i0);
                     this.i2 = li32(this.i2 + 12);
                     this.i1 <<= 2;
                     this.i1 += this.i2;
                     this.i2 = li32(this.i1 + -4);
                     this.i1 += -4;
                     this.i5 = this.i2 & 63;
                     if(this.i5 == 3)
                     {
                        this.i5 = this.i2 >>> 6;
                        this.i6 = this.i2 >>> 23;
                        this.i5 &= 255;
                        if(this.i5 <= this.i3)
                        {
                           this.i5 = this.i6 + 1;
                           if(this.i5 >= this.i3)
                           {
                              this.i0 = this.i3 + this.i4;
                              this.i0 += -1;
                              if(this.i0 > this.i6)
                              {
                                 this.i0 = this.i4 + this.i3;
                                 this.i0 <<= 23;
                                 this.i0 += -8388608;
                                 this.i3 = this.i2 & 8388607;
                                 this.i0 = this.i3 | this.i0;
                                 si32(this.i0,this.i1);
                                 break;
                              }
                              break;
                           }
                        }
                     }
                  }
               }
               this.i1 = this.i3 + this.i4;
               this.i1 += 511;
               this.i2 = li32(this.i0 + 12);
               this.i2 = li32(this.i2 + 8);
               this.i1 <<= 23;
               this.i3 <<= 6;
               this.i1 = this.i3 | this.i1;
               mstate.esp -= 12;
               this.i1 |= 3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               break;
            default:
               throw "Invalid state in _luaK_nil";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
