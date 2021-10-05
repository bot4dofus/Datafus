package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_adjuststack extends Machine
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
      
      public function FSM_adjuststack()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_adjuststack = null;
         _loc1_ = new FSM_adjuststack();
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
               this.i1 = li32(this.i0 + 4);
               this.i2 = this.i0 + 4;
               if(this.i1 >= 2)
               {
                  this.i1 = -1;
                  this.i0 = li32(this.i0 + 8);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_lua_objlen.start();
                  return;
               }
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i3 = 1;
               this.i4 = 0;
               §§goto(addr110);
            case 2:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i6 = li32(this.i2);
               this.i7 = this.i6 + this.i4;
               if(this.i7 <= 9)
               {
                  if(uint(this.i1) <= uint(this.i5))
                  {
                     this.i1 = this.i3;
                  }
                  else
                  {
                     addr189:
                     this.i4 += -1;
                     this.i3 += 1;
                     this.i1 = this.i5 + this.i1;
                     if(this.i6 > this.i3)
                     {
                        addr110:
                        mstate.esp -= 8;
                        this.i5 = this.i4 + -2;
                        si32(this.i0,mstate.esp);
                        si32(this.i5,mstate.esp + 4);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_lua_objlen.start();
                        return;
                     }
                     this.i1 = this.i3;
                  }
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_lua_concat.start();
                  return;
               }
               §§goto(addr189);
            case 3:
               mstate.esp += 8;
               this.i0 = li32(this.i2);
               this.i1 = 1 - this.i1;
               this.i0 = this.i1 + this.i0;
               si32(this.i0,this.i2);
               break;
            default:
               throw "Invalid state in _adjuststack";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
