package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_l_strcmp extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
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
      
      public function FSM_l_strcmp()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_l_strcmp = null;
         _loc1_ = new FSM_l_strcmp();
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
               this.i2 = li32(this.i0 + 12);
               this.i3 = li32(this.i1 + 12);
               mstate.esp -= 8;
               this.i0 += 16;
               this.i1 += 16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_strcoll.start();
               return;
            case 1:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = this.i0;
               if(this.i4 == 0)
               {
                  this.i4 = 0;
                  this.i6 = this.i4;
                  break;
               }
               this.i0 = this.i4;
               §§goto(addr333);
               break;
            case 2:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i3 -= this.i7;
               this.i2 -= this.i7;
               if(this.i8 == 0)
               {
                  break;
               }
               this.i0 = this.i8;
               §§goto(addr333);
               break;
            default:
               throw "Invalid state in _l_strcmp";
         }
         this.i7 = this.i0 + this.i4;
         this.i8 = li8(this.i7);
         if(this.i8 == 0)
         {
            this.i8 = this.i7;
         }
         else
         {
            this.i8 = this.i4 + this.i5;
            while(true)
            {
               this.i9 = li8(this.i8 + 1);
               this.i8 += 1;
               this.i10 = this.i8;
               if(this.i9 == 0)
               {
                  break;
               }
               this.i8 = this.i10;
            }
         }
         this.i7 = this.i8 - this.i7;
         if(this.i7 == this.i3)
         {
            this.i0 = this.i7 != this.i2 ? 1 : 0;
            this.i0 &= 1;
         }
         else
         {
            if(this.i7 != this.i2)
            {
               this.i7 += 1;
               this.i6 += this.i7;
               this.i4 += this.i7;
               mstate.esp -= 8;
               this.i8 = this.i1 + this.i6;
               this.i9 = this.i0 + this.i4;
               si32(this.i9,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_strcoll.start();
               return;
            }
            this.i0 = -1;
         }
         addr333:
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
