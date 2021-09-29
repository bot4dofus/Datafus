package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___wcsnrtombs_std extends Machine
   {
      
      public static const intRegCount:int = 17;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var i16:int;
      
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
      
      public function FSM___wcsnrtombs_std()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___wcsnrtombs_std = null;
         _loc1_ = new FSM___wcsnrtombs_std();
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
               mstate.esp -= 144;
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(this.i0);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = li32(mstate.ebp + 20);
               this.i5 = li32(mstate.ebp + 24);
               if(this.i2 != 0)
               {
                  this.i6 = 0;
                  this.i7 = mstate.ebp + -16;
                  this.i8 = mstate.ebp + -144;
                  this.i9 = this.i5;
                  this.i10 = this.i6;
                  this.i11 = this.i6;
                  addr615:
                  this.i13 = this.i1;
                  this.i12 = this.i10;
                  this.i10 = this.i11;
                  this.i1 = this.i4;
                  this.i11 = this.i6;
                  this.i6 = this.i2 + this.i11;
                  this.i4 = this.i13;
                  if(this.i1 != 0)
                  {
                     if(this.i12 != this.i3)
                     {
                        this.i14 = li32(___mb_cur_max);
                        if(uint(this.i14) < uint(this.i1))
                        {
                           this.i14 = li32(___wcrtomb);
                           this.i15 = li32(this.i4);
                           mstate.esp -= 12;
                           si32(this.i6,mstate.esp);
                           si32(this.i15,mstate.esp + 4);
                           si32(this.i5,mstate.esp + 8);
                           state = 2;
                           mstate.esp -= 4;
                           mstate.funcs[this.i14]();
                           return;
                        }
                        this.i14 = 128;
                        this.i15 = this.i8;
                        this.i16 = this.i9;
                        memcpy(this.i15,this.i16,this.i14);
                        this.i14 = li32(___wcrtomb);
                        this.i15 = li32(this.i4);
                        mstate.esp -= 12;
                        si32(this.i7,mstate.esp);
                        si32(this.i15,mstate.esp + 4);
                        si32(this.i5,mstate.esp + 8);
                        state = 3;
                        mstate.esp -= 4;
                        mstate.funcs[this.i14]();
                        return;
                     }
                  }
                  si32(this.i4,this.i0);
                  mstate.eax = this.i10;
               }
               else if(this.i3 == 0)
               {
                  this.i1 = 0;
                  addr669:
                  this.i0 = this.i1;
                  mstate.eax = this.i0;
               }
               else
               {
                  this.i6 = 0;
                  this.i2 = this.i3 + -1;
                  this.i4 = -1;
                  this.i0 = mstate.ebp + -16;
                  this.i3 = this.i1;
                  this.i1 = this.i6;
                  §§goto(addr129);
               }
               break;
            case 1:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               this.i7 = this.i3;
               if(this.i6 == -1)
               {
                  this.i1 = -1;
               }
               else
               {
                  this.i7 = li32(this.i7);
                  if(this.i7 == 0)
                  {
                     this.i1 += this.i6;
                     this.i1 += -1;
                     addr363:
                     mstate.eax = this.i1;
                     break;
                  }
                  this.i3 += 4;
                  this.i4 += 1;
                  this.i1 = this.i6 + this.i1;
                  if(this.i2 != this.i4)
                  {
                     addr129:
                     this.i6 = li32(___wcrtomb);
                     this.i7 = li32(this.i3);
                     mstate.esp -= 12;
                     si32(this.i0,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     si32(this.i5,mstate.esp + 8);
                     state = 1;
                     mstate.esp -= 4;
                     mstate.funcs[this.i6]();
                     return;
                  }
               }
               §§goto(addr669);
            case 2:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               if(this.i6 != -1)
               {
                  addr533:
                  this.i4 = li32(this.i4);
                  if(this.i4 == 0)
                  {
                     this.i1 = 0;
                     this.i6 = this.i10 + this.i6;
                     si32(this.i1,this.i0);
                     this.i1 = this.i6 + -1;
                  }
                  else
                  {
                     this.i4 = this.i13 + 4;
                     this.i12 += 1;
                     this.i13 = this.i6 + this.i10;
                     this.i14 = this.i1 - this.i6;
                     this.i6 = this.i11 + this.i6;
                     this.i1 = this.i4;
                     this.i10 = this.i12;
                     this.i11 = this.i13;
                     this.i4 = this.i14;
                     §§goto(addr615);
                  }
               }
               else
               {
                  addr353:
                  this.i1 = -1;
                  si32(this.i4,this.i0);
               }
               §§goto(addr363);
            case 3:
               this.i14 = mstate.eax;
               mstate.esp += 12;
               if(this.i14 == -1)
               {
                  §§goto(addr353);
               }
               else
               {
                  if(uint(this.i14) > uint(this.i1))
                  {
                     this.i1 = 128;
                     this.i6 = this.i9;
                     this.i11 = this.i8;
                     memcpy(this.i6,this.i11,this.i1);
                  }
                  else
                  {
                     this.i15 = this.i7;
                     this.i16 = this.i14;
                     memcpy(this.i6,this.i15,this.i16);
                     this.i6 = this.i14;
                     §§goto(addr533);
                  }
                  §§goto(addr615);
               }
            default:
               throw "Invalid state in ___wcsnrtombs_std";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
