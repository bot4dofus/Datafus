package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_rawequal extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public function FSM_luaB_rawequal()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_rawequal = null;
         _loc1_ = new FSM_luaB_rawequal();
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
                     §§goto(addr147);
                  }
               }
               this.i0 = __2E_str11186329;
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 2:
               mstate.esp += 12;
               addr147:
               this.i0 = 2;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr177);
            case 3:
               addr177:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 != -1)
                  {
                     §§goto(addr261);
                  }
               }
               this.i0 = __2E_str11186329;
               mstate.esp -= 12;
               this.i2 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 4:
               mstate.esp += 12;
               addr261:
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr291);
            case 5:
               addr291:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr331);
            case 6:
               addr331:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i3 = _luaO_nilobject_;
                  if(this.i0 != this.i3)
                  {
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_luaO_rawequalObj.start();
                     break;
                  }
               }
               this.i0 = 0;
               this.i2 = 1;
               this.i3 = li32(this.i1 + 8);
               si32(this.i0,this.i3);
               si32(this.i2,this.i3 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.eax = this.i2;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 7:
               break;
            default:
               throw "Invalid state in _luaB_rawequal";
         }
         this.i0 = mstate.eax;
         this.i0 = this.i0 != 0 ? 1 : 0;
         mstate.esp += 8;
         this.i0 &= 1;
         §§goto(addr261);
      }
   }
}
