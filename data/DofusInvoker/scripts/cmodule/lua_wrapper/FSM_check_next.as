package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_check_next extends Machine
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
      
      public function FSM_check_next()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_check_next = null;
         _loc1_ = new FSM_check_next();
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
               mstate.esp -= 4;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(this.i0);
               this.i3 = li8(this.i1);
               this.i4 = this.i2;
               this.i5 = this.i0;
               this.i6 = this.i1;
               this.i7 = this.i2 & 255;
               if(this.i3 != this.i7)
               {
                  this.i1 = this.i6;
                  while(true)
                  {
                     this.i3 = li8(this.i1);
                     if(this.i3 == 0)
                     {
                        this.i1 = 0;
                        break;
                     }
                     this.i3 = li8(this.i1 + 1);
                     this.i1 += 1;
                     this.i6 = this.i1;
                     this.i7 = this.i2 & 255;
                     if(this.i3 == this.i7)
                     {
                        break;
                     }
                     this.i1 = this.i6;
                  }
               }
               if(this.i1 != 0)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_save.start();
                  return;
               }
               this.i0 = 0;
               mstate.eax = this.i0;
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               if(this.i1 != 0)
               {
                  this.i2 = li32(mstate.ebp + -4);
                  if(this.i2 != 0)
                  {
                     this.i2 += -1;
                     si32(this.i2,this.i0);
                     si32(this.i1,this.i0 + 4);
                     this.i2 = li8(this.i1);
                     this.i1 += 1;
                     si32(this.i1,this.i0 + 4);
                     this.i0 = this.i2;
                  }
                  else
                  {
                     addr219:
                     this.i0 = -1;
                  }
                  this.i1 = 1;
                  si32(this.i0,this.i5);
                  addr285:
                  mstate.eax = this.i1;
                  break;
               }
               §§goto(addr219);
            case 2:
               mstate.esp += 8;
               this.i1 = li32(this.i0 + 44);
               this.i2 = li32(this.i1);
               this.i3 = this.i2 + -1;
               si32(this.i3,this.i1);
               this.i0 = li32(this.i0 + 44);
               if(this.i2 == 0)
               {
                  this.i1 = mstate.ebp + -4;
                  this.i2 = li32(this.i0 + 16);
                  this.i3 = li32(this.i0 + 8);
                  this.i4 = li32(this.i0 + 12);
                  mstate.esp -= 12;
                  si32(this.i2,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  state = 1;
                  mstate.esp -= 4;
                  mstate.funcs[this.i3]();
                  return;
               }
               this.i1 = 1;
               this.i2 = li32(this.i0 + 4);
               this.i3 = li8(this.i2);
               this.i2 += 1;
               si32(this.i2,this.i0 + 4);
               si32(this.i3,this.i5);
               §§goto(addr285);
               break;
            default:
               throw "Invalid state in _check_next";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
