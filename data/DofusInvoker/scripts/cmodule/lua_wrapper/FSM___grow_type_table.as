package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___grow_type_table extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public function FSM___grow_type_table()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___grow_type_table = null;
         _loc1_ = new FSM___grow_type_table();
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
               this.i1 = li32(this.i0);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = li32(this.i3);
               this.i2 += 1;
               this.i5 = this.i1 << 1;
               this.i2 = this.i2 > this.i5 ? int(this.i2) : int(this.i5);
               if(this.i1 == 8)
               {
                  this.i5 = 0;
                  mstate.esp -= 8;
                  this.i6 = this.i2 << 2;
                  si32(this.i5,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_pubrealloc.start();
                  return;
               }
               mstate.esp -= 8;
               this.i5 = this.i2 << 2;
               si32(this.i4,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
               break;
            case 1:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i6 = this.i5;
               if(this.i5 == 0)
               {
                  state = 2;
                  mstate.esp -= 4;
                  FSM_abort1.start();
                  return;
               }
            case 2:
               mstate.esp -= 12;
               this.i7 = this.i1 << 2;
               si32(this.i4,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_bcopy.start();
            case 3:
               mstate.esp += 12;
               if(this.i1 < this.i2)
               {
                  this.i4 = this.i6;
                  break;
               }
               this.i1 = this.i6;
               §§goto(addr414);
               break;
            case 4:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i6 = this.i4;
               if(this.i5 == 0)
               {
                  if(this.i4 != 0)
                  {
                     this.i4 = 0;
                     mstate.esp -= 8;
                     si32(this.i6,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
               }
               addr380:
               if(this.i5 == 0)
               {
                  state = 6;
                  mstate.esp -= 4;
                  FSM_abort1.start();
                  return;
               }
               break;
            case 5:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr380);
            case 6:
               this.i4 = this.i5;
               if(this.i1 < this.i2)
               {
                  break;
               }
               this.i1 = this.i4;
               §§goto(addr414);
               break;
            default:
               throw "Invalid state in ___grow_type_table";
         }
         this.i5 = this.i1 << 2;
         this.i5 = this.i4 + this.i5;
         do
         {
            this.i6 = 0;
            si32(this.i6,this.i5);
            this.i5 += 4;
            this.i1 += 1;
         }
         while(this.i1 < this.i2);
         
         this.i1 = this.i4;
         addr414:
         si32(this.i1,this.i3);
         si32(this.i2,this.i0);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
