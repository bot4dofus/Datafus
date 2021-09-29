package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_DumpString extends Machine
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
      
      public function FSM_DumpString()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_DumpString = null;
         _loc1_ = new FSM_DumpString();
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
               this.i1 = li32(mstate.ebp + 12);
               if(this.i0 != 0)
               {
                  this.i2 = this.i0 + 16;
                  if(this.i2 != 0)
                  {
                     this.i0 = li32(this.i0 + 12);
                     this.i0 += 1;
                     si32(this.i0,mstate.ebp + -8);
                     this.i0 = li32(this.i1 + 16);
                     this.i3 = this.i1 + 16;
                     if(this.i0 == 0)
                     {
                        this.i0 = 4;
                        this.i4 = li32(this.i1 + 4);
                        this.i5 = li32(this.i1 + 8);
                        this.i6 = li32(this.i1);
                        mstate.esp -= 16;
                        this.i7 = mstate.ebp + -8;
                        si32(this.i6,mstate.esp);
                        si32(this.i7,mstate.esp + 4);
                        si32(this.i0,mstate.esp + 8);
                        si32(this.i5,mstate.esp + 12);
                        state = 2;
                        mstate.esp -= 4;
                        mstate.funcs[this.i4]();
                        return;
                     }
                     addr338:
                     if(this.i0 == 0)
                     {
                        this.i0 = li32(mstate.ebp + -8);
                        this.i4 = li32(this.i1 + 4);
                        this.i5 = li32(this.i1 + 8);
                        this.i1 = li32(this.i1);
                        mstate.esp -= 16;
                        si32(this.i1,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        si32(this.i0,mstate.esp + 8);
                        si32(this.i5,mstate.esp + 12);
                        state = 3;
                        mstate.esp -= 4;
                        mstate.funcs[this.i4]();
                        return;
                     }
                     break;
                     addr435:
                  }
               }
               this.i0 = 0;
               si32(this.i0,mstate.ebp + -4);
               this.i0 = li32(this.i1 + 16);
               this.i2 = this.i1 + 16;
               if(this.i0 == 0)
               {
                  this.i0 = 4;
                  this.i3 = li32(this.i1 + 4);
                  this.i4 = li32(this.i1 + 8);
                  this.i1 = li32(this.i1);
                  mstate.esp -= 16;
                  this.i5 = mstate.ebp + -4;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  si32(this.i4,mstate.esp + 12);
                  state = 1;
                  mstate.esp -= 4;
                  mstate.funcs[this.i3]();
                  return;
               }
               break;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               si32(this.i0,this.i2);
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               si32(this.i0,this.i3);
               §§goto(addr338);
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               si32(this.i0,this.i3);
               §§goto(addr435);
            default:
               throw "Invalid state in _DumpString";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
