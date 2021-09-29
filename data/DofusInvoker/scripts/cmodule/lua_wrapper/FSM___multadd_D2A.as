package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___multadd_D2A extends Machine
   {
      
      public static const intRegCount:int = 12;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
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
      
      public function FSM___multadd_D2A()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___multadd_D2A = null;
         _loc1_ = new FSM___multadd_D2A();
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
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = li32(this.i1 + 16);
               this.i5 = this.i3 >> 31;
               this.i6 = this.i2 >> 31;
               this.i7 = this.i1 + 20;
               this.i8 = this.i1 + 16;
               while(true)
               {
                  this.i9 = 0;
                  mstate.esp -= 16;
                  this.i10 = li32(this.i7);
                  si32(this.i10,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  si32(this.i5,mstate.esp + 12);
                  mstate.esp -= 4;
                  mstate.funcs[___muldi3]();
                  addr194:
                  this.i7 = this.i2;
                  this.i2 = this.i6;
                  this.i6 = this.i9;
               }
               addr83:
            case 1:
               while(true)
               {
                  this.i10 = mstate.eax;
                  this.i11 = mstate.edx;
                  this.i2 = __addc(this.i10,this.i2);
                  this.i6 = __adde(this.i11,this.i6);
                  si32(this.i2,this.i7);
                  this.i2 = this.i7 + 4;
                  this.i0 += 1;
                  mstate.esp += 16;
                  this.i7 = this.i6;
                  if(this.i0 >= this.i4)
                  {
                     break;
                  }
                  §§goto(addr194);
                  §§goto(addr83);
               }
               this.i0 = this.i7 == 0 ? 1 : 0;
               if(this.i0 == 0)
               {
                  this.i0 = li32(this.i1 + 8);
                  if(this.i0 > this.i4)
                  {
                     addr378:
                     this.i0 = this.i4 << 2;
                     this.i0 = this.i1 + this.i0;
                     si32(this.i6,this.i0 + 20);
                     this.i0 = this.i4 + 1;
                     si32(this.i0,this.i1 + 16);
                     break;
                  }
                  this.i0 = li32(this.i1 + 4);
                  mstate.esp -= 4;
                  this.i0 += 1;
                  si32(this.i0,mstate.esp);
                  state = 2;
                  mstate.esp -= 4;
                  FSM___Balloc_D2A.start();
                  return;
               }
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i2 = li32(this.i8);
               this.i3 = this.i0 + 12;
               this.i2 <<= 2;
               this.i5 = this.i1 + 12;
               this.i2 += 8;
               memcpy(this.i3,this.i5,this.i2);
               this.i2 = this.i1 + 4;
               if(this.i1 == 0)
               {
                  this.i1 = this.i0;
               }
               else
               {
                  this.i3 = _freelist;
                  this.i2 = li32(this.i2);
                  this.i2 <<= 2;
                  this.i2 = this.i3 + this.i2;
                  this.i3 = li32(this.i2);
                  si32(this.i3,this.i1);
                  si32(this.i1,this.i2);
                  this.i1 = this.i0;
               }
               §§goto(addr378);
            default:
               throw "Invalid state in ___multadd_D2A";
         }
         mstate.eax = this.i1;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
