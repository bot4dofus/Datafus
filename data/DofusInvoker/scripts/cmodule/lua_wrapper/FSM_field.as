package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_field extends Machine
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
      
      public function FSM_field()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_field = null;
         _loc1_ = new FSM_field();
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
               mstate.esp -= 48;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 36);
               mstate.esp -= 8;
               this.i2 = li32(mstate.ebp + 12);
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaK_dischargevars.start();
               return;
            case 1:
               mstate.esp += 8;
               this.i3 = li32(this.i2);
               this.i4 = this.i0 + 36;
               this.i5 = this.i2;
               if(this.i3 == 12)
               {
                  this.i3 = li32(this.i2 + 12);
                  this.i6 = li32(this.i2 + 16);
                  this.i7 = li32(this.i2 + 4);
                  if(this.i3 == this.i6)
                  {
                     addr227:
                     this.i3 = li32(this.i0 + 4);
                     si32(this.i3,this.i0 + 8);
                     this.i3 = li32(this.i0 + 24);
                     this.i6 = this.i0 + 24;
                     if(this.i3 != 287)
                     {
                        this.i7 = 287;
                        si32(this.i3,this.i0 + 12);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0,this.i0 + 16);
                        si32(this.i7,this.i6);
                        break;
                     }
                     mstate.esp -= 8;
                     this.i3 = this.i0 + 16;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_llex.start();
                     return;
                  }
                  this.i3 = li8(this.i1 + 50);
                  if(this.i7 >= this.i3)
                  {
                     mstate.esp -= 12;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i7,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_exp2reg.start();
                     return;
                  }
               }
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaK_exp2nextreg.start();
               return;
            case 2:
               mstate.esp += 12;
               §§goto(addr227);
            case 3:
               mstate.esp += 8;
               §§goto(addr227);
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               si32(this.i3,this.i0 + 12);
               break;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i4 = li32(this.i4);
               si32(this.i0,mstate.ebp + -16);
               si32(this.i3,mstate.ebp + -8);
               mstate.esp -= 12;
               this.i0 = mstate.ebp + -16;
               si32(this.i4,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_addk.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i4 = -1;
               si32(this.i4,mstate.ebp + -36);
               si32(this.i4,mstate.ebp + -32);
               si32(this.i3,mstate.ebp + -48);
               si32(this.i0,mstate.ebp + -44);
               mstate.esp -= 8;
               this.i0 = mstate.ebp + -48;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 7;
               mstate.esp -= 4;
               FSM_luaK_exp2RK.start();
               return;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,this.i2 + 8);
               this.i0 = 9;
               si32(this.i0,this.i5);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _field";
         }
         this.i3 = 4;
         mstate.esp -= 4;
         si32(this.i0,mstate.esp);
         state = 5;
         mstate.esp -= 4;
         FSM_str_checkname.start();
      }
   }
}
