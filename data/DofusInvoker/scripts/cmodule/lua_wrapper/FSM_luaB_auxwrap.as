package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_auxwrap extends Machine
   {
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_luaB_auxwrap()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_auxwrap = null;
         _loc1_ = new FSM_luaB_auxwrap();
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
               this.i0 = -10003;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 8);
               if(this.i2 != 8)
               {
                  this.i0 = 0;
               }
               else
               {
                  this.i0 = li32(this.i0);
               }
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               this.i2 -= this.i3;
               mstate.esp -= 12;
               this.i2 /= 12;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_auxresume.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i2 = this.i1 + 12;
               this.i3 = this.i1 + 8;
               if(this.i0 <= -1)
               {
                  this.i4 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  §§goto(addr640);
               }
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = _luaO_nilobject_;
               if(this.i4 != this.i5)
               {
                  this.i4 = li32(this.i4 + 8);
                  this.i4 += -3;
                  if(uint(this.i4) <= uint(1))
                  {
                     this.i4 = 1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaL_where.start();
                     return;
                  }
                  break;
               }
               break;
            case 4:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i4 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i3);
               this.i6 = this.i5;
               if(uint(this.i5) > uint(this.i4))
               {
                  this.i7 = 0;
                  do
                  {
                     this.i8 = this.i7 ^ -1;
                     this.i8 *= 12;
                     this.i8 = this.i6 + this.i8;
                     this.f0 = lf64(this.i8);
                     sf64(this.f0,this.i5);
                     this.i9 = li32(this.i8 + 8);
                     si32(this.i9,this.i5 + 8);
                     this.i5 += -12;
                     this.i7 += 1;
                  }
                  while(uint(this.i8) > uint(this.i4));
                  
               }
               this.i5 = li32(this.i3);
               this.f0 = lf64(this.i5);
               sf64(this.f0,this.i4);
               this.i5 = li32(this.i5 + 8);
               si32(this.i5,this.i4 + 8);
               this.i4 = li32(this.i1 + 16);
               this.i5 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               if(uint(this.i5) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr518);
               break;
            case 6:
               mstate.esp += 4;
               addr518:
               this.i4 = 2;
               this.i5 = li32(this.i3);
               this.i2 = li32(this.i2);
               this.i2 = this.i5 - this.i2;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 7:
               mstate.esp += 12;
               this.i2 = li32(this.i3);
               this.i2 += -12;
               si32(this.i2,this.i3);
               break;
            case 8:
               mstate.esp += 4;
               addr640:
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaB_auxwrap";
         }
         mstate.esp -= 4;
         si32(this.i1,mstate.esp);
         state = 8;
         mstate.esp -= 4;
         FSM_luaG_errormsg.start();
      }
   }
}
