package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM___swbuf extends Machine
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
      
      public function FSM___swbuf()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___swbuf = null;
         _loc1_ = new FSM___swbuf();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(this.i0 + 24);
               si32(this.i1,this.i0 + 8);
               this.i1 = li16(this.i0 + 12);
               this.i2 = this.i0 + 12;
               this.i3 = this.i0 + 8;
               this.i4 = li32(mstate.ebp + 8);
               this.i5 = this.i1 & 8;
               if(this.i5 != 0)
               {
                  this.i5 = li32(this.i0 + 16);
                  if(this.i5 == 0)
                  {
                     this.i1 &= 512;
                     if(this.i1 == 0)
                     {
                        §§goto(addr109);
                     }
                  }
                  addr154:
                  this.i1 = li32(this.i0 + 56);
                  this.i5 = li32(this.i1 + 16);
                  this.i1 += 16;
                  this.i6 = this.i4 & 255;
                  if(this.i5 == 0)
                  {
                     this.i5 = -1;
                     si32(this.i5,this.i1);
                  }
                  this.i1 = li32(this.i0);
                  this.i5 = li32(this.i0 + 16);
                  this.i7 = li32(this.i0 + 20);
                  this.i8 = this.i0 + 20;
                  this.i1 -= this.i5;
                  this.i5 = this.i0;
                  if(this.i7 <= this.i1)
                  {
                     mstate.esp -= 4;
                     si32(this.i0,mstate.esp);
                     state = 2;
                     mstate.esp -= 4;
                     FSM___fflush.start();
                     return;
                  }
                  §§goto(addr280);
               }
               addr109:
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 1;
               mstate.esp -= 4;
               FSM___swsetup.start();
               return;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               if(this.i1 != 0)
               {
                  addr150:
                  this.i0 = -1;
                  break;
               }
               §§goto(addr154);
               break;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               if(this.i1 == 0)
               {
                  this.i1 = 0;
                  addr280:
                  this.i7 = li32(this.i3);
                  this.i7 += -1;
                  si32(this.i7,this.i3);
                  this.i3 = li32(this.i5);
                  si8(this.i4,this.i3);
                  this.i3 += 1;
                  si32(this.i3,this.i5);
                  this.i3 = li32(this.i8);
                  this.i1 += 1;
                  if(this.i1 != this.i3)
                  {
                     this.i1 = li16(this.i2);
                     this.i1 &= 1;
                     if(this.i1 != 0)
                     {
                        this.i1 = this.i4 & 255;
                        if(this.i1 == 10)
                        {
                           §§goto(addr366);
                        }
                     }
                     this.i0 = this.i6;
                     break;
                  }
                  addr366:
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 3;
                  mstate.esp -= 4;
                  FSM___fflush.start();
                  return;
               }
               §§goto(addr150);
               break;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i0 = this.i0 == 0 ? int(this.i6) : -1;
               break;
            default:
               throw "Invalid state in ___swbuf";
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
