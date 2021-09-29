package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_dofile extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaB_dofile()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_dofile = null;
         _loc1_ = new FSM_luaB_dofile();
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
                  if(this.i0 >= 1)
                  {
                     this.i0 = 0;
                     mstate.esp -= 12;
                     this.i2 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaL_checklstring.start();
                     return;
                  }
               }
               this.i0 = 0;
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               break;
            case 3:
               this.i0 = mstate.eax;
               this.i2 -= this.i3;
               mstate.esp += 8;
               this.i2 /= 12;
               this.i3 = this.i1 + 12;
               this.i4 = this.i1 + 8;
               if(this.i0 != 0)
               {
                  this.i0 = -1;
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaG_errormsg.start();
                  return;
               }
               this.i0 = -1;
               this.i5 = li32(this.i4);
               mstate.esp -= 12;
               this.i5 += -12;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
               break;
            case 4:
               mstate.esp += 4;
               this.i5 = li32(this.i4);
               mstate.esp -= 12;
               this.i5 += -12;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
            case 5:
               mstate.esp += 12;
               this.i1 = li32(this.i1 + 20);
               this.i0 = li32(this.i4);
               this.i5 = li32(this.i1 + 8);
               this.i1 += 8;
               if(uint(this.i0) >= uint(this.i5))
               {
                  si32(this.i0,this.i1);
               }
               this.i1 = li32(this.i4);
               this.i3 = li32(this.i3);
               this.i1 -= this.i3;
               this.i1 /= 12;
               this.i1 -= this.i2;
               mstate.eax = this.i1;
               §§goto(addr405);
            case 6:
               mstate.esp += 12;
               this.i0 = li32(this.i1 + 20);
               this.i1 = li32(this.i4);
               this.i5 = li32(this.i0 + 8);
               this.i0 += 8;
               if(uint(this.i1) >= uint(this.i5))
               {
                  si32(this.i1,this.i0);
               }
               this.i0 = li32(this.i4);
               this.i1 = li32(this.i3);
               this.i0 -= this.i1;
               this.i0 /= 12;
               this.i0 -= this.i2;
               mstate.eax = this.i0;
               addr405:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaB_dofile";
         }
         this.i2 = li32(this.i1 + 8);
         this.i3 = li32(this.i1 + 12);
         mstate.esp -= 8;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         state = 3;
         mstate.esp -= 4;
         FSM_luaL_loadfile.start();
      }
   }
}
