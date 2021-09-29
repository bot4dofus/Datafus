package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_str_char extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public function FSM_str_char()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_str_char = null;
         _loc1_ = new FSM_str_char();
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
               mstate.esp -= 1040;
               this.i0 = mstate.ebp + -1040;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               si32(this.i1,mstate.ebp + -1032);
               this.i4 = this.i0 + 12;
               this.i2 -= this.i3;
               si32(this.i4,mstate.ebp + -1040);
               this.i3 = 0;
               si32(this.i3,mstate.ebp + -1036);
               this.i3 = this.i0 + 4;
               this.i4 = this.i0 + 8;
               this.i5 = this.i2 / 12;
               if(this.i2 < 12)
               {
                  break;
               }
               this.i2 = mstate.ebp + -1040;
               this.i2 += 1036;
               this.i6 = 1;
               §§goto(addr130);
               break;
            case 1:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i8 = this.i7 & 255;
               if(this.i8 != this.i7)
               {
                  this.i8 = __2E_str17447;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  si32(this.i8,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               addr231:
               this.i8 = li32(this.i0);
               if(uint(this.i8) >= uint(this.i2))
               {
                  this.i8 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i8,mstate.esp);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_emptybuffer.start();
                  return;
               }
               addr327:
               this.i8 = li32(this.i0);
               si8(this.i7,this.i8);
               this.i7 = this.i8 + 1;
               si32(this.i7,this.i0);
               this.i6 += 1;
               if(this.i6 <= this.i5)
               {
                  addr130:
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaL_checkinteger.start();
                  return;
               }
               break;
            case 2:
               mstate.esp += 12;
               §§goto(addr231);
            case 3:
               this.i8 = mstate.eax;
               mstate.esp += 4;
               if(this.i8 != 0)
               {
                  this.i8 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i8,mstate.esp);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr327);
               break;
            case 4:
               mstate.esp += 4;
               §§goto(addr327);
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i0 = li32(this.i3);
               this.i1 = li32(this.i4);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 6;
               mstate.esp -= 4;
               FSM_lua_concat.start();
               return;
            case 6:
               mstate.esp += 8;
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _str_char";
         }
         this.i0 = mstate.ebp + -1040;
         mstate.esp -= 4;
         si32(this.i0,mstate.esp);
         state = 5;
         mstate.esp -= 4;
         FSM_emptybuffer.start();
      }
   }
}
