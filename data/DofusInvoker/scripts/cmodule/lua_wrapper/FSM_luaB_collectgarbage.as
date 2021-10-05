package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_collectgarbage extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 2;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var i3:int;
      
      public function FSM_luaB_collectgarbage()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_collectgarbage = null;
         _loc1_ = new FSM_luaB_collectgarbage();
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
               this.i0 = __2E_str45245;
               mstate.esp -= 16;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = _opts_2E_2859;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checkoption.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 8;
               this.i2 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 >= 1)
                  {
                     this.i2 = 2;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaL_checkinteger.start();
                     return;
                  }
               }
               this.i2 = 0;
               break;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               break;
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 != 5)
               {
                  if(this.i0 == 3)
                  {
                     this.i0 = 0;
                     mstate.esp -= 12;
                     this.i3 = 4;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_lua_gc.start();
                     return;
                  }
                  this.i0 = 3;
                  this.i3 = li32(this.i1 + 8);
                  this.f0 = Number(this.i2);
                  sf64(this.f0,this.i3);
                  si32(this.i0,this.i3 + 8);
                  this.i0 = li32(this.i1 + 8);
                  this.i0 += 12;
                  si32(this.i0,this.i1 + 8);
                  this.i0 = 1;
               }
               else
               {
                  this.i0 = 1;
                  this.i2 = this.i2 != 0 ? 1 : 0;
                  this.i3 = li32(this.i1 + 8);
                  this.i2 &= 1;
                  si32(this.i2,this.i3);
                  si32(this.i0,this.i3 + 8);
                  this.i2 = li32(this.i1 + 8);
                  this.i2 += 12;
                  si32(this.i2,this.i1 + 8);
               }
               mstate.eax = this.i0;
               §§goto(addr485);
            case 5:
               this.i0 = mstate.eax;
               this.f0 = Number(this.i0);
               mstate.esp += 12;
               this.f0 *= 0.000976562;
               this.f1 = Number(this.i2);
               this.i2 = li32(this.i1 + 8);
               this.f0 = this.f1 + this.f0;
               sf64(this.f0,this.i2);
               this.i0 = 3;
               si32(this.i0,this.i2 + 8);
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               this.i1 = 1;
               mstate.eax = this.i1;
               addr485:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaB_collectgarbage";
         }
         this.i3 = _optsnum_2E_2860;
         this.i0 <<= 2;
         this.i0 = this.i3 + this.i0;
         this.i0 = li32(this.i0);
         mstate.esp -= 12;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 4;
         mstate.esp -= 4;
         FSM_lua_gc.start();
      }
   }
}
