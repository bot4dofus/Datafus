package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_os_difftime extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 2;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var i3:int;
      
      public function FSM_os_difftime()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_os_difftime = null;
         _loc1_ = new FSM_os_difftime();
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
                     FSM_luaL_checknumber.start();
                     return;
                  }
               }
               this.f0 = 0;
               break;
            case 2:
               this.f0 = mstate.st0;
               this.i0 = int(this.f0);
               mstate.esp += 8;
               this.f0 = Number(this.i0);
               break;
            case 3:
               this.f1 = mstate.st0;
               this.i2 = int(this.f1);
               mstate.esp += 8;
               this.f1 = Number(this.i2);
               this.i2 = li32(this.i1 + 8);
               this.f0 = this.f1 - this.f0;
               sf64(this.f0,this.i2);
               this.i3 = 3;
               si32(this.i3,this.i2 + 8);
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _os_difftime";
         }
         this.i0 = 1;
         mstate.esp -= 8;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         state = 3;
         mstate.esp -= 4;
         FSM_luaL_checknumber.start();
      }
   }
}
