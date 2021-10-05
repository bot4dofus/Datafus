package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_error extends Machine
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
      
      public function FSM_luaB_error()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_error = null;
         _loc1_ = new FSM_luaB_error();
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
               this.i0 = 2;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 >= 1)
                  {
                     this.i0 = 2;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaL_checkinteger.start();
                     return;
                  }
               }
               this.i0 = 1;
               addr146:
               this.i2 = li32(this.i1 + 12);
               this.i3 = li32(this.i1 + 8);
               this.i4 = this.i1 + 12;
               this.i5 = this.i1 + 8;
               this.i6 = this.i2 + 12;
               if(uint(this.i3) >= uint(this.i6))
               {
                  this.i3 = this.i2;
               }
               else
               {
                  while(true)
                  {
                     this.i2 = 0;
                     si32(this.i2,this.i3 + 8);
                     this.i2 = this.i3 + 12;
                     si32(this.i2,this.i5);
                     this.i6 = li32(this.i4);
                     if(this.i3 >= this.i6)
                     {
                        break;
                     }
                     this.i3 = this.i2;
                  }
                  this.i3 = this.i6;
               }
               this.i2 = this.i3;
               this.i3 = 1;
               this.i2 += 12;
               si32(this.i2,this.i5);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr146);
            case 3:
               break;
            case 4:
               mstate.esp += 8;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i5);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i5);
               this.i0 += 12;
               si32(this.i0,this.i5);
               this.i0 = li32(this.i1 + 16);
               this.i2 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i2) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr538);
               break;
            case 6:
               mstate.esp += 4;
               addr538:
               this.i0 = 2;
               this.i2 = li32(this.i5);
               this.i3 = li32(this.i4);
               this.i2 -= this.i3;
               this.i2 /= 12;
               mstate.esp -= 12;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaV_concat.start();
               return;
            case 7:
               mstate.esp += 12;
               this.i0 = li32(this.i5);
               this.i0 += -12;
               si32(this.i0,this.i5);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 8;
               mstate.esp -= 4;
               FSM_luaG_errormsg.start();
               return;
            case 8:
               mstate.esp += 4;
               this.i1 = 0;
               mstate.eax = this.i1;
               §§goto(addr705);
            case 9:
               mstate.esp += 4;
               mstate.eax = this.i0;
               addr705:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaB_error";
         }
         this.i2 = mstate.eax;
         mstate.esp += 8;
         this.i3 = _luaO_nilobject_;
         if(this.i2 == this.i3)
         {
            this.i2 = 0;
         }
         else
         {
            this.i2 = li32(this.i2 + 8);
            this.i2 += -3;
            this.i2 = uint(this.i2) < uint(2) ? 1 : 0;
         }
         this.i2 ^= 1;
         this.i2 &= 1;
         if(this.i2 == 0)
         {
            if(this.i0 >= 1)
            {
               this.i2 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaL_where.start();
               return;
            }
         }
         this.i0 = 0;
         mstate.esp -= 4;
         si32(this.i1,mstate.esp);
         state = 9;
         mstate.esp -= 4;
         FSM_luaG_errormsg.start();
      }
   }
}
