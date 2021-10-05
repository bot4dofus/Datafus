package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_error_expected extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public function FSM_error_expected()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_error_expected = null;
         _loc1_ = new FSM_error_expected();
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
               mstate.esp -= 80;
               this.i0 = __2E_str95311;
               this.i1 = li32(mstate.ebp + 8);
               mstate.esp -= 8;
               this.i2 = li32(mstate.ebp + 12);
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaX_token2str.start();
               return;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 40);
               mstate.esp -= 12;
               si32(this.i3,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i2 = li32(this.i1 + 52);
               this.i3 = li32(this.i1 + 12);
               mstate.esp -= 12;
               this.i4 = 80;
               this.i5 = mstate.ebp + -80;
               this.i2 += 16;
               si32(this.i5,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 3:
               mstate.esp += 12;
               this.i2 = li32(this.i1 + 4);
               this.i4 = li32(this.i1 + 40);
               mstate.esp -= 20;
               this.i6 = __2E_str15272;
               si32(this.i4,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               si32(this.i0,mstate.esp + 16);
               state = 4;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 20;
               this.i2 = this.i1 + 40;
               if(this.i3 != 0)
               {
                  this.i4 = this.i3 + -284;
                  if(uint(this.i4) <= uint(2))
                  {
                     this.i3 = 0;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_save.start();
                     return;
                  }
                  this.i4 = __2E_str35292;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaX_token2str.start();
                  return;
               }
               this.i0 = 3;
               this.i1 = li32(this.i2);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               addr602:
               si32(this.i0,mstate.esp + 4);
               break;
            case 5:
               mstate.esp += 8;
               this.i1 = li32(this.i1 + 48);
               this.i1 = li32(this.i1);
               this.i3 = li32(this.i2);
               mstate.esp -= 16;
               this.i4 = __2E_str35292;
               si32(this.i3,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = li32(this.i2);
               mstate.esp -= 8;
               this.i1 = 3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               break;
            case 7:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i2);
               mstate.esp -= 16;
               si32(this.i3,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 8;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i2);
               mstate.esp -= 8;
               this.i0 = 3;
               si32(this.i2,mstate.esp);
               §§goto(addr602);
            case 9:
               mstate.esp += 8;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _error_expected";
         }
         state = 9;
         mstate.esp -= 4;
         FSM_luaD_throw.start();
      }
   }
}
