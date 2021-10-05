package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaV_lessthan extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 2;
       
      
      public var f1:Number;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public function FSM_luaV_lessthan()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaV_lessthan = null;
         _loc1_ = new FSM_luaV_lessthan();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(mstate.ebp + 16);
               this.i2 = li32(this.i0 + 8);
               this.i3 = li32(this.i1 + 8);
               this.i4 = this.i1 + 8;
               this.i5 = this.i0 + 8;
               this.i6 = li32(mstate.ebp + 8);
               if(this.i2 == this.i3)
               {
                  if(this.i2 != 4)
                  {
                     if(this.i2 == 3)
                     {
                        this.f0 = lf64(this.i0);
                        this.f1 = lf64(this.i1);
                        this.i0 = this.f0 < this.f1 ? 1 : 0;
                        this.i0 &= 1;
                        addr197:
                        break;
                     }
                     this.i2 = 13;
                     mstate.esp -= 16;
                     si32(this.i6,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     si32(this.i1,mstate.esp + 8);
                     si32(this.i2,mstate.esp + 12);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_call_orderTM.start();
                     return;
                  }
                  this.i1 = li32(this.i1);
                  this.i0 = li32(this.i0);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_l_strcmp.start();
                  return;
               }
               this.i0 = _luaT_typenames;
               this.i1 = this.i3 << 2;
               this.i2 <<= 2;
               this.i1 = this.i0 + this.i1;
               this.i0 += this.i2;
               this.i0 = li32(this.i0);
               this.i1 = li32(this.i1);
               this.i2 = li8(this.i0 + 2);
               this.i4 = li8(this.i1 + 2);
               if(this.i2 == this.i4)
               {
                  §§goto(addr142);
               }
               else
               {
                  §§goto(addr373);
               }
               break;
            case 1:
               mstate.esp += 12;
               addr192:
               this.i0 = 0;
               §§goto(addr197);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               if(this.i0 == -1)
               {
                  this.i0 = _luaT_typenames;
                  this.i1 = li32(this.i5);
                  this.i2 = li32(this.i4);
                  this.i2 <<= 2;
                  this.i1 <<= 2;
                  this.i2 = this.i0 + this.i2;
                  this.i0 += this.i1;
                  this.i0 = li32(this.i0);
                  this.i1 = li32(this.i2);
                  this.i2 = li8(this.i0 + 2);
                  this.i3 = li8(this.i1 + 2);
                  if(this.i2 == this.i3)
                  {
                     addr142:
                     this.i1 = __2E_str16273;
                     mstate.esp -= 12;
                     si32(this.i6,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaG_runerror.start();
                     return;
                  }
                  addr373:
                  this.i2 = __2E_str17274;
                  mstate.esp -= 16;
                  si32(this.i6,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  si32(this.i1,mstate.esp + 12);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               break;
            case 3:
               mstate.esp += 16;
               §§goto(addr192);
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 >>>= 31;
               break;
            default:
               throw "Invalid state in _luaV_lessthan";
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
