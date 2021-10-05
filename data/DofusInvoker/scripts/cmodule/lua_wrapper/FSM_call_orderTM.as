package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_call_orderTM extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public function FSM_call_orderTM()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_call_orderTM = null;
         _loc1_ = new FSM_call_orderTM();
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
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 20);
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaT_gettmbyobj.start();
            case 1:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               this.i4 = li32(this.i3 + 8);
               this.i5 = this.i3 + 8;
               this.i6 = li32(mstate.ebp + 16);
               if(this.i4 != 0)
               {
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaT_gettmbyobj.start();
                  addr157:
                  this.i2 = mstate.eax;
                  mstate.esp += 12;
                  mstate.esp -= 8;
                  si32(this.i3,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_luaO_rawequalObj.start();
                  this.i2 = mstate.eax;
                  mstate.esp += 8;
                  if(this.i2 != 0)
                  {
                     this.i2 = li32(this.i0 + 8);
                     this.i4 = li32(this.i0 + 32);
                     this.f0 = lf64(this.i3);
                     sf64(this.f0,this.i2);
                     this.i3 = li32(this.i5);
                     si32(this.i3,this.i2 + 8);
                     this.i3 = li32(this.i0 + 8);
                     this.f0 = lf64(this.i1);
                     sf64(this.f0,this.i3 + 12);
                     this.i1 = li32(this.i1 + 8);
                     si32(this.i1,this.i3 + 20);
                     this.i1 = li32(this.i0 + 8);
                     this.f0 = lf64(this.i6);
                     sf64(this.f0,this.i1 + 24);
                     this.i3 = li32(this.i6 + 8);
                     si32(this.i3,this.i1 + 32);
                     this.i1 = li32(this.i0 + 28);
                     this.i3 = li32(this.i0 + 8);
                     this.i2 -= this.i4;
                     this.i4 = this.i0 + 32;
                     this.i5 = this.i0 + 8;
                     this.i1 -= this.i3;
                     if(this.i1 <= 36)
                     {
                        this.i1 = 3;
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i1,mstate.esp + 4);
                        state = 4;
                        mstate.esp -= 4;
                        FSM_luaD_growstack.start();
                        return;
                     }
                     §§goto(addr396);
                  }
               }
               this.i0 = -1;
               break;
            case 2:
               §§goto(addr157);
            case 3:
               §§goto(addr157);
            case 4:
               mstate.esp += 8;
               addr396:
               this.i1 = 1;
               this.i3 = li32(this.i5);
               this.i6 = this.i3 + 36;
               si32(this.i6,this.i5);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
            case 5:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i1 = li32(this.i4);
               this.i3 = this.i0 + -12;
               si32(this.i3,this.i5);
               this.f0 = lf64(this.i0 + -12);
               this.i1 += this.i2;
               sf64(this.f0,this.i1);
               this.i0 = li32(this.i0 + -4);
               si32(this.i0,this.i1 + 8);
               this.i0 = li32(this.i5);
               this.i1 = li32(this.i0 + 8);
               if(this.i1 != 0)
               {
                  if(this.i1 != 1)
                  {
                     this.i0 = 1;
                     break;
                  }
                  this.i0 = li32(this.i0);
                  this.i0 = this.i0 != 0 ? 1 : 0;
                  this.i0 &= 1;
                  break;
               }
               this.i0 = 0;
               break;
            default:
               throw "Invalid state in _call_orderTM";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
