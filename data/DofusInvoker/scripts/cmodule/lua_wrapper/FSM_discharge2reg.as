package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_discharge2reg extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_discharge2reg()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_discharge2reg = null;
         _loc1_ = new FSM_discharge2reg();
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
               mstate.esp -= 16;
               this.i0 = li32(mstate.ebp + 8);
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 12);
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_dischargevars.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i2 = li32(this.i1);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = this.i1;
               if(this.i2 <= 4)
               {
                  if(this.i2 != 1)
                  {
                     this.i5 = this.i2 + -2;
                     if(uint(this.i5) >= uint(2))
                     {
                        if(this.i2 != 4)
                        {
                           break;
                        }
                        this.i2 = 12;
                        this.i5 = li32(this.i1 + 4);
                        this.i6 = li32(this.i0 + 12);
                        this.i6 = li32(this.i6 + 8);
                        this.i5 <<= 14;
                        this.i7 = this.i3 << 6;
                        this.i5 = this.i7 | this.i5;
                        mstate.esp -= 12;
                        this.i5 |= 1;
                        si32(this.i0,mstate.esp);
                        si32(this.i5,mstate.esp + 4);
                        si32(this.i6,mstate.esp + 8);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_luaK_code.start();
                        return;
                     }
                     this.i5 = 12;
                     this.i2 = this.i2 == 2 ? 1 : 0;
                     this.i2 &= 1;
                     this.i6 = li32(this.i0 + 12);
                     this.i6 = li32(this.i6 + 8);
                     this.i2 <<= 23;
                     this.i7 = this.i3 << 6;
                     this.i2 = this.i7 | this.i2;
                     mstate.esp -= 12;
                     this.i2 |= 2;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i6,mstate.esp + 8);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaK_code.start();
                     return;
                  }
                  this.i2 = 1;
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaK_nil.start();
                  return;
               }
               if(this.i2 != 5)
               {
                  if(this.i2 != 11)
                  {
                     if(this.i2 != 12)
                     {
                        break;
                     }
                     this.i2 = li32(this.i1 + 4);
                     this.i1 += 4;
                     if(this.i2 != this.i3)
                     {
                        this.i5 = 12;
                        this.i6 = li32(this.i0 + 12);
                        this.i6 = li32(this.i6 + 8);
                        this.i2 <<= 23;
                        this.i7 = this.i3 << 6;
                        mstate.esp -= 12;
                        this.i2 = this.i7 | this.i2;
                        si32(this.i0,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        si32(this.i6,mstate.esp + 8);
                        state = 3;
                        mstate.esp -= 4;
                        FSM_luaK_code.start();
                        return;
                     }
                     this.i0 = 12;
                     si32(this.i3,this.i1);
                     addr780:
                     si32(this.i0,this.i4);
                     break;
                  }
                  this.i2 = 12;
                  this.i5 = li32(this.i1 + 4);
                  this.i0 = li32(this.i0);
                  this.i0 = li32(this.i0 + 12);
                  this.i5 <<= 2;
                  this.i0 += this.i5;
                  this.i5 = li32(this.i0);
                  this.i6 = this.i3 << 6;
                  this.i6 &= 16320;
                  this.i5 &= -16321;
                  this.i5 |= this.i6;
                  si32(this.i5,this.i0);
                  addr759:
                  si32(this.i3,this.i1 + 4);
                  si32(this.i2,this.i4);
                  break;
               }
               this.i2 = 3;
               this.f0 = lf64(this.i1 + 4);
               sf64(this.f0,mstate.ebp + -16);
               si32(this.i2,mstate.ebp + -8);
               mstate.esp -= 12;
               this.i2 = mstate.ebp + -16;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_addk.start();
               return;
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr759);
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i1);
               addr350:
               si32(this.i5,this.i4);
               break;
            case 4:
               addr399:
               mstate.esp += 12;
               si32(this.i3,this.i1 + 4);
               this.i0 = 12;
               §§goto(addr780);
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,this.i1 + 4);
               §§goto(addr350);
            case 6:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i5 = li32(this.i0 + 12);
               this.i5 = li32(this.i5 + 8);
               this.i2 <<= 14;
               this.i6 = this.i3 << 6;
               this.i2 = this.i6 | this.i2;
               mstate.esp -= 12;
               this.i2 |= 1;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 7:
               this.i0 = mstate.eax;
               §§goto(addr399);
            default:
               throw "Invalid state in _discharge2reg";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
