package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM___s2b_D2A extends Machine
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
      
      public function FSM___s2b_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___s2b_D2A = null;
         _loc1_ = new FSM___s2b_D2A();
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
               this.i0 = li32(mstate.ebp + 16);
               this.i1 = this.i0 + 8;
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = li32(mstate.ebp + 20);
               this.i5 = this.i1 / 9;
               this.i6 = this.i2;
               if(this.i1 >= 18)
               {
                  this.i1 = 1;
                  this.i7 = 0;
                  do
                  {
                     this.i7 += 1;
                     this.i1 <<= 1;
                  }
                  while(this.i5 > this.i1);
                  
                  this.i1 = this.i7;
               }
               else
               {
                  this.i1 = 0;
               }
               this.i5 = 1;
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 1;
               mstate.esp -= 4;
               FSM___Balloc_D2A.start();
               return;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               si32(this.i4,this.i1 + 20);
               si32(this.i5,this.i1 + 16);
               if(this.i3 >= 10)
               {
                  this.i4 = 0;
                  this.i5 = this.i3 + -9;
                  §§goto(addr179);
               }
               else
               {
                  this.i2 += 10;
                  if(this.i0 > 9)
                  {
                     this.i3 = 9;
                     addr306:
                     this.i4 = 0;
                     break;
                  }
                  §§goto(addr401);
               }
               break;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i4 += 1;
               if(this.i4 != this.i5)
               {
                  addr179:
                  this.i7 = 10;
                  this.i8 = this.i6 + this.i4;
                  this.i8 = si8(li8(this.i8 + 9));
                  mstate.esp -= 12;
                  this.i8 += -48;
                  si32(this.i1,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i8,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  FSM___multadd_D2A.start();
                  return;
               }
               this.i4 <<= 0;
               this.i2 = this.i4 + this.i2;
               this.i2 += 10;
               if(this.i3 >= this.i0)
               {
                  §§goto(addr401);
               }
               else
               {
                  §§goto(addr306);
               }
               break;
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i4 += 1;
               this.i5 = this.i3 + this.i4;
               if(this.i5 >= this.i0)
               {
                  addr401:
                  this.i0 = this.i1;
                  mstate.eax = this.i0;
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  mstate.gworker = caller;
                  return;
               }
               break;
            default:
               throw "Invalid state in ___s2b_D2A";
         }
         this.i5 = 10;
         this.i6 = this.i2 + this.i4;
         this.i6 = si8(li8(this.i6));
         mstate.esp -= 12;
         this.i6 += -48;
         si32(this.i1,mstate.esp);
         si32(this.i5,mstate.esp + 4);
         si32(this.i6,mstate.esp + 8);
         state = 3;
         mstate.esp -= 4;
         FSM___multadd_D2A.start();
      }
   }
}
