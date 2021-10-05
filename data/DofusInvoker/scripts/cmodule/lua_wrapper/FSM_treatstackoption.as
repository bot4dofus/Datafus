package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_treatstackoption extends Machine
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
      
      public function FSM_treatstackoption()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_treatstackoption = null;
         _loc1_ = new FSM_treatstackoption();
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
               mstate.esp -= 32;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = this.i2;
               if(this.i0 == this.i1)
               {
                  this.i1 = -2;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  if(this.i1 != this.i0)
                  {
                     this.i4 = 0;
                     this.i5 = li32(this.i1 + 8);
                     this.i5 += -12;
                     si32(this.i5,this.i1 + 8);
                     this.i5 = this.i0 + 8;
                     this.i1 += 8;
                     this.i6 = this.i4;
                     while(true)
                     {
                        this.i7 = li32(this.i5);
                        this.i8 = li32(this.i1);
                        this.i9 = this.i7 + 12;
                        si32(this.i9,this.i5);
                        this.i8 += this.i6;
                        this.f0 = lf64(this.i8);
                        sf64(this.f0,this.i7);
                        this.i8 = li32(this.i8 + 8);
                        si32(this.i8,this.i7 + 8);
                        this.i6 += 12;
                        this.i7 = this.i4 + 1;
                        if(this.i4 == 0)
                        {
                           break;
                        }
                        this.i4 = this.i7;
                     }
                  }
                  this.i1 = -2;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i0 + 8);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i4);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i4 + 8);
               this.i1 = li32(this.i0 + 8);
               this.i1 += 12;
               si32(this.i1,this.i0 + 8);
               mstate.esp -= 8;
               this.i1 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i0 + 8);
               this.i5 = this.i0 + 8;
               this.i6 = this.i1;
               this.i7 = this.i1 + 12;
               if(uint(this.i7) >= uint(this.i4))
               {
                  this.i1 = this.i4;
               }
               else
               {
                  this.i1 += 12;
                  this.i4 = this.i6;
                  while(true)
                  {
                     this.f0 = lf64(this.i4 + 12);
                     sf64(this.f0,this.i4);
                     this.i6 = li32(this.i4 + 20);
                     si32(this.i6,this.i4 + 8);
                     this.i4 = li32(this.i5);
                     this.i6 = this.i1 + 12;
                     this.i7 = this.i1;
                     if(uint(this.i6) >= uint(this.i4))
                     {
                        break;
                     }
                     this.i1 = this.i6;
                     this.i4 = this.i7;
                  }
                  this.i1 = this.i4;
               }
               this.i4 = -2;
               this.i1 += -12;
               si32(this.i1,this.i5);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 3:
               break;
            case 4:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li8(this.i2);
               if(this.i4 != 0)
               {
                  this.i4 = this.i3;
                  while(true)
                  {
                     this.i5 = li8(this.i4 + 1);
                     this.i4 += 1;
                     this.i6 = this.i4;
                     if(this.i5 == 0)
                     {
                        break;
                     }
                     this.i4 = this.i6;
                  }
               }
               else
               {
                  this.i4 = this.i2;
               }
               this.i5 = 4;
               mstate.esp -= 12;
               this.i3 = this.i4 - this.i3;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -16);
               si32(this.i4,mstate.ebp + -8);
               this.i2 = li32(this.i5);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i3 = mstate.ebp + -16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 6:
               mstate.esp += 16;
               this.i0 = li32(this.i5);
               this.i0 += -12;
               si32(this.i0,this.i5);
               §§goto(addr764);
            case 7:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -32);
               si32(this.i5,mstate.ebp + -24);
               this.i2 = li32(this.i0 + 8);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i3 = mstate.ebp + -32;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 8;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 8:
               mstate.esp += 16;
               this.i1 = li32(this.i0 + 8);
               this.i1 += -12;
               si32(this.i1,this.i0 + 8);
               addr764:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _treatstackoption";
         }
         this.i1 = mstate.eax;
         mstate.esp += 8;
         this.i4 = li8(this.i2);
         if(this.i4 != 0)
         {
            while(true)
            {
               this.i4 = li8(this.i3 + 1);
               this.i3 += 1;
               this.i6 = this.i3;
               if(this.i4 == 0)
               {
                  break;
               }
               this.i3 = this.i6;
            }
         }
         else
         {
            this.i3 = this.i2;
         }
         this.i4 = 4;
         mstate.esp -= 12;
         this.i3 -= this.i2;
         si32(this.i0,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 5;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
