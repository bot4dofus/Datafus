package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_setarrayvector extends Machine
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
      
      public function FSM_setarrayvector()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_setarrayvector = null;
         _loc1_ = new FSM_setarrayvector();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop1:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(mstate.ebp + 16);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = this.i0 + 28;
               this.i0 += 12;
               this.i4 = this.i1 + 1;
               if(uint(this.i4) <= uint(357913941))
               {
                  this.i4 = li32(this.i2 + 16);
                  this.i5 = li32(this.i3);
                  this.i6 = li32(this.i0);
                  this.i7 = li32(this.i4 + 12);
                  this.i8 = li32(this.i4 + 16);
                  mstate.esp -= 16;
                  this.i5 *= 12;
                  this.i9 = this.i1 * 12;
                  si32(this.i8,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  si32(this.i9,mstate.esp + 12);
                  state = 1;
                  mstate.esp -= 4;
                  mstate.funcs[this.i7]();
                  return;
               }
               this.i4 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
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
                  if(this.i9 != 0)
                  {
                     this.i7 = 4;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr228:
               this.i2 = li32(this.i4 + 68);
               this.i5 = this.i9 - this.i5;
               this.i2 = this.i5 + this.i2;
               si32(this.i2,this.i4 + 68);
               si32(this.i6,this.i0);
               this.i2 = li32(this.i3);
               if(this.i2 < this.i1)
               {
                  addr333:
                  this.i4 = this.i2 * 12;
                  this.i4 += 8;
                  while(true)
                  {
                     this.i5 = 0;
                     this.i6 = li32(this.i0);
                     this.i6 += this.i4;
                     si32(this.i5,this.i6);
                     this.i4 += 12;
                     this.i2 += 1;
                     if(this.i2 >= this.i1)
                     {
                        break loop1;
                     }
                  }
                  break;
               }
               break;
            case 2:
               mstate.esp += 8;
               §§goto(addr228);
            case 3:
               mstate.esp += 8;
               this.i2 = 0;
               si32(this.i2,this.i0);
               this.i2 = li32(this.i3);
               if(this.i2 < this.i1)
               {
                  §§goto(addr333);
               }
               break;
            default:
               throw "Invalid state in _setarrayvector";
         }
         si32(this.i1,this.i3);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
