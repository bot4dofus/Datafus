package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_fgets extends Machine
   {
      
      public static const intRegCount:int = 15;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
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
      
      public function FSM_fgets()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_fgets = null;
         _loc1_ = new FSM_fgets();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop3:
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
               if(this.i1 >= 1)
               {
                  this.i3 = li32(this.i2 + 56);
                  this.i4 = li32(this.i3 + 16);
                  this.i1 += -1;
                  this.i3 += 16;
                  if(this.i4 == 0)
                  {
                     this.i4 = -1;
                     si32(this.i4,this.i3);
                     if(this.i1 == 0)
                     {
                        §§goto(addr100);
                     }
                  }
                  else if(this.i1 == 0)
                  {
                     §§goto(addr100);
                  }
                  this.i3 = 0;
                  this.i4 = this.i2 + 4;
                  this.i5 = this.i2;
                  while(true)
                  {
                     this.i6 = li32(this.i4);
                     this.i7 = this.i0 + this.i3;
                     if(this.i6 != 0)
                     {
                        this.i8 = this.i6;
                        break loop3;
                     }
                     break;
                     this.i1 = this.i7;
                  }
                  mstate.esp -= 4;
                  si32(this.i2,mstate.esp);
                  state = 1;
                  mstate.esp -= 4;
                  FSM___srefill.start();
                  return;
               }
               addr452:
               this.i0 = 0;
               addr100:
               this.i1 = this.i0;
               §§goto(addr443);
            case 1:
               this.i6 = mstate.eax;
               mstate.esp += 4;
               if(this.i6 == 0)
               {
                  this.i6 = li32(this.i4);
                  this.i8 = this.i6;
                  break;
               }
               if(this.i3 != 0)
               {
                  this.i1 = this.i7;
                  addr443:
                  this.i2 = 0;
                  si8(this.i2,this.i1);
                  mstate.eax = this.i0;
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  mstate.gworker = caller;
                  return;
               }
               §§goto(addr452);
               §§goto(addr100);
               break;
            default:
               throw "Invalid state in _fgets";
         }
         continue loop1;
      }
   }
}
