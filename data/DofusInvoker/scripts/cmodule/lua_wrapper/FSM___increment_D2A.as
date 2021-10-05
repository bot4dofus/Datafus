package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___increment_D2A extends Machine
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
      
      public function FSM___increment_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___increment_D2A = null;
         _loc1_ = new FSM___increment_D2A();
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
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 16);
               this.i3 = this.i1 + 20;
               this.i4 = this.i1 + 16;
               while(true)
               {
                  this.i5 = li32(this.i3);
                  this.i6 = this.i3;
                  if(this.i5 != -1)
                  {
                     this.i0 = this.i5 + 1;
                     si32(this.i0,this.i6);
                     mstate.eax = this.i1;
                     break;
                  }
                  this.i5 = 0;
                  si32(this.i5,this.i6);
                  this.i3 += 4;
                  this.i0 += 1;
                  if(this.i0 >= this.i2)
                  {
                     this.i0 = li32(this.i1 + 8);
                     if(this.i2 < this.i0)
                     {
                        break loop1;
                     }
                     this.i0 = li32(this.i1 + 4);
                     mstate.esp -= 4;
                     this.i0 += 1;
                  }
                  continue;
                  si32(this.i0,mstate.esp);
                  state = 1;
                  mstate.esp -= 4;
                  FSM___Balloc_D2A.start();
                  return;
               }
               §§goto(addr88);
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i2 = li32(this.i4);
               this.i3 = this.i0 + 12;
               this.i2 <<= 2;
               this.i4 = this.i1 + 12;
               this.i2 += 8;
               memcpy(this.i3,this.i4,this.i2);
               this.i2 = this.i1 + 4;
               if(this.i1 == 0)
               {
                  this.i1 = this.i0;
                  break;
               }
               this.i3 = _freelist;
               this.i2 = li32(this.i2);
               this.i2 <<= 2;
               this.i2 = this.i3 + this.i2;
               this.i3 = li32(this.i2);
               si32(this.i3,this.i1);
               si32(this.i1,this.i2);
               this.i1 = this.i0;
               break;
            default:
               throw "Invalid state in ___increment_D2A";
         }
         this.i0 = this.i1;
         this.i1 = 1;
         this.i2 = li32(this.i0 + 16);
         this.i3 = this.i2 << 2;
         this.i3 = this.i0 + this.i3;
         si32(this.i1,this.i3 + 20);
         this.i1 = this.i2 + 1;
         si32(this.i1,this.i0 + 16);
         mstate.eax = this.i0;
         addr88:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
