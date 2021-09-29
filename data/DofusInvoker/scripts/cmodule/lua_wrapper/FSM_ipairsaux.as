package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_ipairsaux extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i3:int;
      
      public function FSM_ipairsaux()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_ipairsaux = null;
         _loc1_ = new FSM_ipairsaux();
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
               FSM_luaL_checkinteger.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = 1;
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
                  if(this.i2 == 5)
                  {
                     addr189:
                     this.i2 = 3;
                     this.i0 += 1;
                     this.i3 = li32(this.i1 + 8);
                     this.f0 = Number(this.i0);
                     sf64(this.f0,this.i3);
                     si32(this.i2,this.i3 + 8);
                     this.i2 = li32(this.i1 + 8);
                     this.i2 += 12;
                     si32(this.i2,this.i1 + 8);
                     mstate.esp -= 8;
                     this.i2 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr273:
                     this.i2 = mstate.eax;
                     mstate.esp += 8;
                     this.i2 = li32(this.i2);
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_luaH_getnum.start();
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
                     this.i0 = -1;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     break;
                  }
               }
               this.i2 = 5;
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_tag_error.start();
               return;
            case 3:
               mstate.esp += 12;
               §§goto(addr189);
            case 4:
               §§goto(addr273);
            case 5:
               §§goto(addr189);
            case 6:
               break;
            default:
               throw "Invalid state in _ipairsaux";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i1 = _luaO_nilobject_;
         if(this.i0 == this.i1)
         {
            this.i0 = 0;
         }
         else
         {
            this.i0 = li32(this.i0 + 8);
            this.i0 = this.i0 == 0 ? 1 : 0;
         }
         this.i0 &= 1;
         this.i0 = this.i0 != 0 ? 0 : 2;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
