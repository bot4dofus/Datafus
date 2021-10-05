package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_gethooktable extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i3:int;
      
      public function FSM_gethooktable()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_gethooktable = null;
         _loc1_ = new FSM_gethooktable();
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
               this.i0 = _KEY_HOOK;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               si32(this.i0,this.i2);
               this.i0 = 2;
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 8;
               this.i0 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 8);
               this.i0 = li32(this.i0);
               mstate.esp -= 8;
               this.i3 = this.i2 + -12;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_get.start();
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2 + -12);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + -4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = this.i1 + 8;
               this.i3 = _luaO_nilobject_;
               if(this.i0 != this.i3)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 5)
                  {
                     break;
                  }
               }
               this.i0 = 1;
               this.i3 = li32(this.i2);
               this.i3 += -12;
               si32(this.i3,this.i2);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_lua_createtable.start();
               return;
            case 4:
               mstate.esp += 8;
               this.i0 = li32(this.i2);
               this.i3 = _KEY_HOOK;
               si32(this.i3,this.i0);
               this.i3 = 2;
               si32(this.i3,this.i0 + 8);
               this.i0 = li32(this.i2);
               this.i0 += 12;
               si32(this.i0,this.i2);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i2);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i3);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i2);
               this.i0 += 12;
               si32(this.i0,this.i2);
               mstate.esp -= 8;
               this.i0 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 6;
               mstate.esp -= 4;
               FSM_lua_rawset.start();
               return;
            case 6:
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _gethooktable";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
