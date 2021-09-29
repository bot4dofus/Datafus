package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_str_sub extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_str_sub()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_str_sub = null;
         _loc1_ = new FSM_str_sub();
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
               this.i0 = mstate.ebp + -4;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(mstate.ebp + -4);
               mstate.esp -= 8;
               this.i3 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_checkinteger.start();
               return;
            case 2:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               if(this.i3 <= -1)
               {
                  this.i3 += this.i2;
                  this.i3 += 1;
                  this.i3 = this.i3 > -1 ? int(this.i3) : 0;
               }
               else
               {
                  this.i3 = this.i3 > -1 ? int(this.i3) : 0;
               }
               this.i2 = this.i3;
               this.i3 = 3;
               this.i4 = li32(mstate.ebp + -4);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = _luaO_nilobject_;
               if(this.i3 != this.i5)
               {
                  this.i3 = li32(this.i3 + 8);
                  if(this.i3 >= 1)
                  {
                     this.i3 = 3;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaL_checkinteger.start();
                     return;
                  }
               }
               this.i3 = -1;
               addr306:
               if(this.i3 <= -1)
               {
                  this.i3 += this.i4;
                  this.i3 += 1;
                  this.i3 = this.i3 > -1 ? int(this.i3) : 0;
               }
               else
               {
                  this.i3 = this.i3 > -1 ? int(this.i3) : 0;
               }
               this.i4 = li32(mstate.ebp + -4);
               this.i2 = this.i2 < 1 ? 1 : int(this.i2);
               this.i3 = this.i4 < this.i3 ? int(this.i4) : int(this.i3);
               if(this.i2 > this.i3)
               {
                  this.i0 = li32(this.i1 + 16);
                  this.i2 = li32(this.i0 + 68);
                  this.i0 = li32(this.i0 + 64);
                  if(uint(this.i2) >= uint(this.i0))
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_luaC_step.start();
                     return;
                  }
                  break;
               }
               this.i4 = li32(this.i1 + 16);
               this.i0 = this.i2 + this.i0;
               this.i5 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               this.i2 = 1 - this.i2;
               this.i0 += -1;
               this.i2 += this.i3;
               if(uint(this.i5) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr472);
               break;
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr306);
            case 5:
               mstate.esp += 4;
               addr472:
               this.i3 = 4;
               this.i4 = li32(this.i1 + 8);
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i4);
               si32(this.i3,this.i4 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               this.i1 = 1;
               mstate.eax = this.i1;
               §§goto(addr571);
            case 7:
               mstate.esp += 4;
               break;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i2);
               this.i0 = 4;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               this.i0 = 1;
               mstate.eax = this.i0;
               addr571:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _str_sub";
         }
         this.i0 = __2E_str45;
         this.i2 = li32(this.i1 + 8);
         mstate.esp -= 12;
         this.i3 = 0;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 8;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
