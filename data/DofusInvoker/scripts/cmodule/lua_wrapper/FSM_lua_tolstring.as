package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_lua_tolstring extends Machine
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
      
      public function FSM_lua_tolstring()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_lua_tolstring = null;
         _loc1_ = new FSM_lua_tolstring();
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
               mstate.esp -= 32;
               this.i0 = mstate.ebp + -32;
               this.i1 = li32(mstate.ebp + 8);
               mstate.esp -= 8;
               this.i2 = li32(mstate.ebp + 12);
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i3 + 8);
               this.i5 = this.i3 + 8;
               this.i6 = li32(mstate.ebp + 16);
               if(this.i4 == 3)
               {
                  this.i4 = __2E_str1166;
                  this.f0 = lf64(this.i3);
                  mstate.esp -= 16;
                  this.i7 = mstate.ebp + -32;
                  si32(this.i7,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  sf64(this.f0,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_sprintf.start();
                  return;
               }
               if(this.i4 != 4)
               {
                  if(this.i6 != 0)
                  {
                     this.i0 = 0;
                     si32(this.i0,this.i6);
                     break;
                  }
                  this.i0 = 0;
                  break;
               }
               this.i0 = this.i3;
               addr121:
               this.i1 = li32(this.i0);
               if(this.i6 == 0)
               {
                  this.i0 = this.i1 + 16;
                  break;
               }
               this.i1 = li32(this.i1 + 12);
               si32(this.i1,this.i6);
               this.i1 = li32(this.i0);
               this.i1 += 16;
               mstate.eax = this.i1;
               §§goto(addr291);
               break;
            case 2:
               mstate.esp += 16;
               this.i4 = li8(mstate.ebp + -32);
               if(this.i4 != 0)
               {
                  this.i4 = this.i0;
                  while(true)
                  {
                     this.i8 = li8(this.i4 + 1);
                     this.i4 += 1;
                     this.i9 = this.i4;
                     if(this.i8 == 0)
                     {
                        break;
                     }
                     this.i4 = this.i9;
                  }
               }
               else
               {
                  this.i4 = this.i7;
               }
               this.i8 = 4;
               mstate.esp -= 12;
               this.i0 = this.i4 - this.i0;
               si32(this.i1,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               si32(this.i8,this.i5);
               this.i0 = li32(this.i1 + 16);
               this.i3 = li32(this.i0 + 68);
               this.i0 = li32(this.i0 + 64);
               if(uint(this.i3) >= uint(this.i0))
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               addr456:
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 4:
               mstate.esp += 4;
               §§goto(addr456);
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr121);
            default:
               throw "Invalid state in _lua_tolstring";
         }
         mstate.eax = this.i0;
         addr291:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
