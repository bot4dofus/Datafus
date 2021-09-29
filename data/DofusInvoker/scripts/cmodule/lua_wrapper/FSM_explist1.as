package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_explist1 extends Machine
   {
      
      public static const intRegCount:int = 13;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var f0:Number;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public var i9:int;
      
      public function FSM_explist1()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_explist1 = null;
         _loc1_ = new FSM_explist1();
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
               mstate.esp -= 12;
               this.i2 = li32(mstate.ebp + 12);
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_subexpr.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i1 + 12);
               this.i3 = this.i1 + 12;
               if(this.i0 == 44)
               {
                  this.i0 = li32(this.i1 + 4);
                  si32(this.i0,this.i1 + 8);
                  this.i0 = li32(this.i1 + 24);
                  this.i4 = this.i1 + 24;
                  if(this.i0 != 287)
                  {
                     this.i5 = 287;
                     si32(this.i0,this.i3);
                     this.f0 = lf64(this.i1 + 28);
                     sf64(this.f0,this.i1 + 16);
                     si32(this.i5,this.i4);
                     addr222:
                     this.i0 = -1;
                     this.i4 = this.i1 + 16;
                     this.i5 = this.i1 + 28;
                     this.i6 = this.i1 + 24;
                     this.i7 = this.i1 + 8;
                     this.i8 = this.i1 + 4;
                     this.i9 = this.i1 + 36;
                     this.i10 = this.i4;
                     break;
                  }
                  mstate.esp -= 8;
                  this.i0 = this.i1 + 16;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_llex.start();
                  return;
               }
               this.i0 = 1;
               §§goto(addr497);
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,this.i3);
               §§goto(addr222);
            case 3:
               mstate.esp += 8;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i11,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_subexpr.start();
               return;
            case 4:
               this.i11 = mstate.eax;
               mstate.esp += 12;
               this.i11 = li32(this.i3);
               if(this.i11 != 44)
               {
                  this.i11 = 1;
               }
               else
               {
                  this.i11 = li32(this.i8);
                  si32(this.i11,this.i7);
                  this.i11 = li32(this.i6);
                  if(this.i11 == 287)
                  {
                     this.i11 = 0;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i10,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  this.i12 = 287;
                  si32(this.i11,this.i3);
                  this.f0 = lf64(this.i5);
                  sf64(this.f0,this.i4);
                  si32(this.i12,this.i6);
                  this.i11 = 0;
               }
               addr470:
               this.i0 += 1;
               this.i11 &= 1;
               if(this.i11 == 0)
               {
                  break;
               }
               this.i0 += 2;
               addr497:
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
               break;
            case 5:
               this.i12 = mstate.eax;
               mstate.esp += 8;
               si32(this.i12,this.i3);
               §§goto(addr470);
            default:
               throw "Invalid state in _explist1";
         }
         this.i11 = 0;
         this.i12 = li32(this.i9);
         mstate.esp -= 8;
         si32(this.i12,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         state = 3;
         mstate.esp -= 4;
         FSM_luaK_exp2nextreg.start();
      }
   }
}
