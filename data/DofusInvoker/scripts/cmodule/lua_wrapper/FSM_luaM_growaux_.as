package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaM_growaux_ extends Machine
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
      
      public function FSM_luaM_growaux_()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaM_growaux_ = null;
         _loc1_ = new FSM_luaM_growaux_();
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
               this.i0 = li32(mstate.ebp + 24);
               this.i1 = li32(mstate.ebp + 16);
               this.i2 = li32(this.i1);
               this.i3 = this.i0 >>> 31;
               this.i4 = li32(mstate.ebp + 8);
               this.i5 = li32(mstate.ebp + 12);
               this.i6 = li32(mstate.ebp + 20);
               this.i7 = li32(mstate.ebp + 28);
               this.i3 = this.i0 + this.i3;
               this.i3 >>= 1;
               if(this.i2 >= this.i3)
               {
                  if(this.i2 >= this.i0)
                  {
                     mstate.esp -= 8;
                     si32(this.i4,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaG_runerror.start();
                     return;
                  }
               }
               else
               {
                  this.i0 = this.i2 << 1;
                  if(this.i0 < 4)
                  {
                     this.i0 = 4;
                  }
               }
               this.i2 = uint(-3) / uint(this.i6);
               this.i3 = this.i0 + 1;
               if(uint(this.i3) <= uint(this.i2))
               {
                  §§goto(addr211);
               }
               else
               {
                  §§goto(addr429);
               }
            case 1:
               mstate.esp += 8;
               this.i2 = uint(-3) / uint(this.i6);
               this.i3 = this.i0 + 1;
               if(uint(this.i3) <= uint(this.i2))
               {
                  addr211:
                  this.i2 = li32(this.i4 + 16);
                  this.i3 = li32(this.i1);
                  this.i7 = li32(this.i2 + 12);
                  this.i8 = li32(this.i2 + 16);
                  mstate.esp -= 16;
                  this.i3 *= this.i6;
                  this.i6 = this.i0 * this.i6;
                  si32(this.i8,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  si32(this.i6,mstate.esp + 12);
                  state = 2;
                  mstate.esp -= 4;
                  mstate.funcs[this.i7]();
                  return;
               }
               addr429:
               this.i2 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 2:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               if(this.i5 == 0)
               {
                  if(this.i6 != 0)
                  {
                     this.i7 = 4;
                     mstate.esp -= 8;
                     si32(this.i4,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr362:
               this.i4 = li32(this.i2 + 68);
               this.i3 = this.i6 - this.i3;
               this.i4 = this.i3 + this.i4;
               si32(this.i4,this.i2 + 68);
               si32(this.i0,this.i1);
               mstate.eax = this.i5;
               break;
            case 3:
               mstate.esp += 8;
               §§goto(addr362);
            case 4:
               mstate.esp += 8;
               si32(this.i0,this.i1);
               this.i0 = 0;
               mstate.eax = this.i0;
               break;
            default:
               throw "Invalid state in _luaM_growaux_";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
