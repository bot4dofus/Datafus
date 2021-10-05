package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_io_close extends Machine
   {
      
      public static const intRegCount:int = 3;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public function FSM_io_close()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_io_close = null;
         _loc1_ = new FSM_io_close();
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
               this.i0 = 1;
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
                  if(this.i0 != -1)
                  {
                     this.i0 = __2E_str17320;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_luaL_checkudata.start();
                     return;
                  }
               }
               this.i0 = -10001;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               mstate.esp -= 8;
               this.i2 = 2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
               break;
            case 3:
               break;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               if(this.i0 == 0)
               {
                  this.i0 = __2E_str20323;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               §§goto(addr329);
               break;
            case 5:
               mstate.esp += 8;
               addr329:
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               FSM_aux_close.start();
               return;
            case 6:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               mstate.eax = this.i1;
               §§goto(addr369);
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i0);
               if(this.i0 == 0)
               {
                  this.i0 = __2E_str20323;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               §§goto(addr491);
               break;
            case 8:
               mstate.esp += 8;
               addr491:
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 9;
               mstate.esp -= 4;
               FSM_aux_close.start();
               return;
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               mstate.eax = this.i0;
               addr369:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _io_close";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i2 = li32(this.i1 + 8);
         this.f0 = lf64(this.i0);
         sf64(this.f0,this.i2);
         this.i0 = li32(this.i0 + 8);
         si32(this.i0,this.i2 + 8);
         this.i0 = li32(this.i1 + 8);
         this.i0 += 12;
         si32(this.i0,this.i1 + 8);
         mstate.esp -= 8;
         this.i0 = __2E_str17320;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         state = 4;
         mstate.esp -= 4;
         FSM_luaL_checkudata.start();
      }
   }
}
