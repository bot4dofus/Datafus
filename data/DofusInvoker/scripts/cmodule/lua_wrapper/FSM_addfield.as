package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_addfield extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_addfield()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_addfield = null;
         _loc1_ = new FSM_addfield();
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
               this.i0 = li32(this.i0);
               mstate.esp -= 8;
               this.i2 = li32(mstate.ebp + 16);
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i3);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = _luaO_nilobject_;
               if(this.i0 != this.i4)
               {
                  this.i0 = li32(this.i0 + 8);
                  this.i0 += -3;
                  if(uint(this.i0) < uint(2))
                  {
                     §§goto(addr402);
                  }
               }
               this.i0 = -1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 4:
               break;
            case 5:
               mstate.esp += 16;
               addr402:
               mstate.esp -= 4;
               si32(this.i3,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               FSM_luaL_addvalue.start();
               return;
            case 6:
               mstate.esp += 4;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _addfield";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i4 = _luaO_nilobject_;
         if(this.i0 == this.i4)
         {
            this.i0 = -1;
         }
         else
         {
            this.i0 = li32(this.i0 + 8);
         }
         if(this.i0 == -1)
         {
            this.i0 = __2E_str2251;
         }
         else
         {
            this.i4 = _luaT_typenames;
            this.i0 <<= 2;
            this.i0 = this.i4 + this.i0;
            this.i0 = li32(this.i0);
         }
         this.i4 = __2E_str11426;
         mstate.esp -= 16;
         si32(this.i1,mstate.esp);
         si32(this.i4,mstate.esp + 4);
         si32(this.i0,mstate.esp + 8);
         si32(this.i2,mstate.esp + 12);
         state = 5;
         mstate.esp -= 4;
         FSM_luaL_error.start();
      }
   }
}
