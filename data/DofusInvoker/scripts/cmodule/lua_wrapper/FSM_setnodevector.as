package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_setnodevector extends Machine
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
      
      public function FSM_setnodevector()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_setnodevector = null;
         _loc1_ = new FSM_setnodevector();
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
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               if(this.i2 == 0)
               {
                  this.i0 = _dummynode_;
                  si32(this.i0,this.i1 + 16);
                  this.i0 = 0;
                  break;
               }
               this.i2 += -1;
               if(uint(this.i2) <= uint(255))
               {
                  this.i3 = -1;
               }
               else
               {
                  this.i3 = -1;
                  do
                  {
                     this.i3 += 1;
                     this.i2 >>>= 8;
                  }
                  while(uint(this.i2) >= uint(256));
                  
                  this.i3 <<= 3;
                  this.i3 |= 7;
               }
               this.i4 = _log_2_2E_3461;
               this.i2 = this.i4 + this.i2;
               this.i2 = li8(this.i2);
               this.i2 += this.i3;
               this.i3 = this.i2 + 1;
               if(this.i3 >= 27)
               {
                  this.i2 = __2E_str2126;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               addr262:
               this.i2 = 1;
               this.i2 <<= this.i3;
               this.i4 = this.i1 + 16;
               this.i5 = this.i2 + 1;
               if(uint(this.i5) <= uint(153391689))
               {
                  this.i5 = 0;
                  this.i6 = li32(this.i0 + 16);
                  this.i7 = li32(this.i6 + 12);
                  this.i8 = li32(this.i6 + 16);
                  mstate.esp -= 16;
                  this.i9 = this.i2 * 28;
                  si32(this.i8,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  si32(this.i9,mstate.esp + 12);
                  state = 2;
                  mstate.esp -= 4;
                  mstate.funcs[this.i7]();
                  return;
               }
               this.i5 = __2E_str149;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
               break;
            case 1:
               mstate.esp += 8;
               §§goto(addr262);
            case 2:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               if(this.i5 == 0)
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
               addr434:
               this.i0 = li32(this.i6 + 68);
               this.i0 = this.i9 + this.i0;
               si32(this.i0,this.i6 + 68);
               si32(this.i5,this.i4);
               if(this.i2 > 0)
               {
                  addr527:
                  this.i0 = 0;
                  this.i5 = this.i0;
                  do
                  {
                     this.i6 = 0;
                     this.i7 = li32(this.i4);
                     this.i7 += this.i5;
                     si32(this.i6,this.i7 + 24);
                     si32(this.i6,this.i7 + 20);
                     si32(this.i6,this.i7 + 8);
                     this.i5 += 28;
                     this.i0 += 1;
                  }
                  while(this.i0 < this.i2);
                  
               }
               this.i0 = this.i3;
               break;
            case 3:
               mstate.esp += 8;
               §§goto(addr434);
            case 4:
               mstate.esp += 8;
               this.i0 = 0;
               si32(this.i0,this.i4);
               if(this.i2 > 0)
               {
               }
               §§goto(addr527);
            default:
               throw "Invalid state in _setnodevector";
         }
         si8(this.i0,this.i1 + 7);
         this.i0 = li32(this.i1 + 16);
         this.i2 *= 28;
         this.i0 += this.i2;
         si32(this.i0,this.i1 + 20);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
