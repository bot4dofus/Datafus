package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_aux_close extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_aux_close()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_aux_close = null;
         _loc1_ = new FSM_aux_close();
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
               mstate.esp -= 16;
               this.i0 = 1;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_getfenv.start();
            case 1:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 2:
               break;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -16);
               this.i2 = 4;
               si32(this.i2,mstate.ebp + -8);
               this.i2 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i3 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 4:
               mstate.esp += 16;
               this.i0 = li32(this.i1 + 8);
               this.i2 = this.i0 + 12;
               si32(this.i2,this.i1 + 8);
               this.i2 = li32(this.i0 + 8);
               if(this.i2 == 6)
               {
                  this.i0 = li32(this.i0);
                  this.i2 = li8(this.i0 + 6);
                  if(this.i2 != 0)
                  {
                     this.i0 = li32(this.i0 + 16);
                  }
                  else
                  {
                     addr316:
                     this.i0 = 0;
                  }
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  state = 5;
                  mstate.esp -= 4;
                  mstate.funcs[this.i0]();
                  return;
               }
               §§goto(addr316);
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _aux_close";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i2 = __2E_str22325;
         while(true)
         {
            this.i3 = li8(this.i2 + 1);
            this.i2 += 1;
            this.i4 = this.i2;
            if(this.i3 == 0)
            {
               break;
            }
            this.i2 = this.i4;
         }
         this.i3 = __2E_str22325;
         mstate.esp -= 12;
         this.i2 -= this.i3;
         si32(this.i1,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 3;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
