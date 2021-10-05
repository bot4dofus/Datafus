package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_generic_reader extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_generic_reader()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_generic_reader = null;
         _loc1_ = new FSM_generic_reader();
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
               state = 1;
               mstate.esp -= 4;
               FSM_lua_checkstack.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               this.i2 = li32(mstate.ebp + 16);
               mstate.esp += 8;
               if(this.i0 == 0)
               {
                  this.i0 = __2E_str10185328;
                  mstate.esp -= 12;
                  this.i3 = __2E_str50340;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               addr142:
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 2:
               mstate.esp += 12;
               §§goto(addr142);
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i1 + 8);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i4);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i4 + 8);
               this.i3 = li32(this.i1 + 8);
               this.i4 = this.i3 + 12;
               si32(this.i4,this.i1 + 8);
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
            case 4:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i0 != this.i3)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 0)
                  {
                     this.i1 = 0;
                     si32(this.i1,this.i2);
                     addr350:
                     mstate.eax = this.i1;
                     break;
                  }
               }
               this.i0 = -1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i0 != this.i3)
               {
                  this.i0 = li32(this.i0 + 8);
                  this.i0 += -3;
                  if(uint(this.i0) <= uint(1))
                  {
                     this.i0 = 3;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_lua_replace.start();
                     return;
                  }
               }
               this.i0 = __2E_str51341;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
            case 7:
               mstate.esp += 8;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 8:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr350);
            case 9:
               mstate.esp += 8;
               this.i0 = 0;
               mstate.eax = this.i0;
               break;
            default:
               throw "Invalid state in _generic_reader";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
