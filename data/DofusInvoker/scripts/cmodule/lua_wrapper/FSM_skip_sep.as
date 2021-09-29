package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_skip_sep extends Machine
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
      
      public function FSM_skip_sep()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_skip_sep = null;
         _loc1_ = new FSM_skip_sep();
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
               mstate.esp -= 8;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_save.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 44);
               this.i3 = li32(this.i2);
               this.i4 = this.i3 + -1;
               si32(this.i4,this.i2);
               this.i2 = li32(this.i0 + 44);
               this.i4 = this.i0 + 44;
               this.i5 = this.i0;
               if(this.i3 == 0)
               {
                  this.i3 = mstate.ebp + -8;
                  this.i6 = li32(this.i2 + 16);
                  this.i7 = li32(this.i2 + 8);
                  this.i8 = li32(this.i2 + 12);
                  mstate.esp -= 12;
                  si32(this.i6,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  mstate.funcs[this.i7]();
                  return;
               }
               this.i3 = li32(this.i2 + 4);
               this.i6 = li8(this.i3);
               this.i3 += 1;
               si32(this.i3,this.i2 + 4);
               si32(this.i6,this.i5);
               if(this.i6 == 61)
               {
                  this.i2 = 0;
                  this.i3 = this.i6;
                  break;
               }
               this.i0 = 0;
               this.i2 = this.i6;
               §§goto(addr620);
               break;
            case 2:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               if(this.i3 != 0)
               {
                  this.i6 = li32(mstate.ebp + -8);
                  if(this.i6 != 0)
                  {
                     this.i6 += -1;
                     si32(this.i6,this.i2);
                     si32(this.i3,this.i2 + 4);
                     this.i6 = li8(this.i3);
                     this.i3 += 1;
                     si32(this.i3,this.i2 + 4);
                     this.i2 = this.i6;
                  }
                  else
                  {
                     addr251:
                     this.i2 = -1;
                  }
                  this.i3 = 0;
                  si32(this.i2,this.i5);
                  addr598:
                  this.i6 = this.i2;
                  this.i2 = this.i3;
                  if(this.i6 != 61)
                  {
                     this.i0 = this.i2;
                     this.i2 = this.i6;
                     addr620:
                     if(this.i2 != this.i1)
                     {
                        this.i0 ^= -1;
                     }
                     mstate.eax = this.i0;
                     mstate.esp = mstate.ebp;
                     mstate.ebp = li32(mstate.esp);
                     mstate.esp += 4;
                     mstate.esp += 4;
                     mstate.gworker = caller;
                     return;
                  }
                  this.i3 = this.i6;
                  break;
               }
               §§goto(addr251);
            case 3:
               mstate.esp += 8;
               this.i3 = li32(this.i4);
               this.i6 = li32(this.i3);
               this.i7 = this.i6 + -1;
               si32(this.i7,this.i3);
               this.i3 = li32(this.i4);
               if(this.i6 == 0)
               {
                  this.i6 = mstate.ebp + -4;
                  this.i7 = li32(this.i3 + 16);
                  this.i8 = li32(this.i3 + 8);
                  this.i9 = li32(this.i3 + 12);
                  mstate.esp -= 12;
                  si32(this.i7,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  state = 4;
                  mstate.esp -= 4;
                  mstate.funcs[this.i8]();
                  return;
               }
               this.i6 = li32(this.i3 + 4);
               this.i7 = li8(this.i6);
               this.i6 += 1;
               si32(this.i6,this.i3 + 4);
               si32(this.i7,this.i5);
               this.i3 = this.i2 + 1;
               this.i2 = this.i7;
               §§goto(addr598);
               break;
            case 4:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               if(this.i6 != 0)
               {
                  this.i7 = li32(mstate.ebp + -4);
                  if(this.i7 != 0)
                  {
                     this.i7 += -1;
                     si32(this.i7,this.i3);
                     si32(this.i6,this.i3 + 4);
                     this.i7 = li8(this.i6);
                     this.i6 += 1;
                     si32(this.i6,this.i3 + 4);
                     this.i3 = this.i7;
                  }
                  else
                  {
                     addr523:
                     this.i3 = -1;
                  }
                  si32(this.i3,this.i5);
                  this.i6 = this.i2 + 1;
                  this.i2 = this.i3;
                  this.i3 = this.i6;
                  §§goto(addr598);
               }
               §§goto(addr523);
            default:
               throw "Invalid state in _skip_sep";
         }
         mstate.esp -= 8;
         si32(this.i0,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         state = 3;
         mstate.esp -= 4;
         FSM_save.start();
      }
   }
}
