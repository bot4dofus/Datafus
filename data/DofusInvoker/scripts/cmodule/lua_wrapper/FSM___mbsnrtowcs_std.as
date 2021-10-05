package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___mbsnrtowcs_std extends Machine
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
      
      public function FSM___mbsnrtowcs_std()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___mbsnrtowcs_std = null;
         _loc1_ = new FSM___mbsnrtowcs_std();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(this.i0);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = li32(mstate.ebp + 20);
               this.i5 = li32(mstate.ebp + 24);
               if(this.i2 != 0)
               {
                  this.i6 = 0;
                  this.i7 = this.i6;
                  addr464:
                  this.i8 = this.i2;
                  this.i9 = this.i3;
                  this.i3 = this.i1 + this.i6;
                  this.i2 = this.i8;
                  if(this.i7 == this.i4)
                  {
                     si32(this.i3,this.i0);
                     addr495:
                     mstate.eax = this.i7;
                     break;
                  }
                  this.i10 = li32(___mbrtowc);
                  mstate.esp -= 16;
                  si32(this.i2,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i9,mstate.esp + 8);
                  si32(this.i5,mstate.esp + 12);
                  state = 3;
                  mstate.esp -= 4;
                  mstate.funcs[this.i10]();
                  return;
               }
               this.i0 = mstate.ebp + -4;
               this.i2 = li32(___mbrtowc);
               mstate.esp -= 16;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[this.i2]();
               return;
               break;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               if(this.i0 != -2)
               {
                  if(this.i0 != -1)
                  {
                     if(this.i0 == 0)
                     {
                        addr166:
                        this.i0 = 0;
                     }
                     else
                     {
                        this.i2 = 0;
                        this.i4 = this.i2;
                        §§goto(addr179);
                     }
                  }
                  else
                  {
                     addr526:
                     this.i0 = -1;
                  }
                  addr529:
                  mstate.eax = this.i0;
                  break;
               }
               §§goto(addr166);
            case 2:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               this.i3 = this.i4 + 1;
               if(this.i6 != -2)
               {
                  if(this.i6 != -1)
                  {
                     if(this.i6 != 0)
                     {
                        this.i4 = this.i3;
                        this.i3 = this.i0;
                        this.i0 = this.i6;
                        addr179:
                        this.i6 = mstate.ebp + -4;
                        this.i7 = li32(___mbrtowc);
                        this.i2 += this.i0;
                        mstate.esp -= 16;
                        this.i0 = this.i3 - this.i0;
                        this.i3 = this.i1 + this.i2;
                        si32(this.i6,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        si32(this.i0,mstate.esp + 8);
                        si32(this.i5,mstate.esp + 12);
                        state = 2;
                        mstate.esp -= 4;
                        mstate.funcs[this.i7]();
                        return;
                     }
                     addr293:
                     this.i0 = this.i3;
                  }
                  else
                  {
                     §§goto(addr526);
                  }
                  §§goto(addr529);
               }
               §§goto(addr293);
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               if(this.i2 != -2)
               {
                  if(this.i2 != 0)
                  {
                     if(this.i2 == -1)
                     {
                        this.i2 = -1;
                        si32(this.i3,this.i0);
                        mstate.eax = this.i2;
                        break;
                     }
                     this.i3 = this.i8 + 4;
                     this.i7 += 1;
                     this.i8 = this.i9 - this.i2;
                     this.i6 += this.i2;
                     this.i2 = this.i3;
                     this.i3 = this.i8;
                     §§goto(addr464);
                  }
                  else
                  {
                     this.i2 = 0;
                     addr424:
                     si32(this.i2,this.i0);
                  }
                  §§goto(addr495);
               }
               else
               {
                  this.i2 = this.i6 + this.i9;
                  this.i2 = this.i1 + this.i2;
               }
               §§goto(addr424);
            default:
               throw "Invalid state in ___mbsnrtowcs_std";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
