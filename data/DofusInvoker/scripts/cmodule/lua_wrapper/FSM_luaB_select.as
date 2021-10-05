package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_select extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_luaB_select()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_select = null;
         _loc1_ = new FSM_luaB_select();
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
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               this.i2 -= this.i3;
               mstate.esp += 8;
               this.i2 /= 12;
               this.i3 = this.i1 + 8;
               this.i4 = _luaO_nilobject_;
               if(this.i0 != this.i4)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 4)
                  {
                     this.i0 = 0;
                     mstate.esp -= 12;
                     this.i4 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_lua_tolstring.start();
                     return;
                  }
               }
               §§goto(addr250);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li8(this.i0);
               if(this.i0 == 35)
               {
                  this.i1 = 3;
                  this.i2 += -1;
                  this.i0 = li32(this.i3);
                  this.f0 = Number(this.i2);
                  sf64(this.f0,this.i0);
                  si32(this.i1,this.i0 + 8);
                  this.i1 = li32(this.i3);
                  this.i1 += 12;
                  si32(this.i1,this.i3);
                  this.i1 = 1;
                  mstate.eax = this.i1;
                  break;
               }
               addr250:
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaL_checkinteger.start();
               return;
               break;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 <= -1)
               {
                  this.i0 += this.i2;
                  if(this.i0 <= 0)
                  {
                     §§goto(addr333);
                  }
               }
               else
               {
                  this.i0 = this.i0 > this.i2 ? int(this.i2) : int(this.i0);
                  if(this.i0 <= 0)
                  {
                     addr333:
                     this.i3 = __2E_str56346;
                     mstate.esp -= 12;
                     this.i4 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     si32(this.i3,mstate.esp + 8);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaL_argerror.start();
                     return;
                  }
               }
               addr386:
               this.i0 = this.i2 - this.i0;
               mstate.eax = this.i0;
               break;
            case 4:
               mstate.esp += 12;
               §§goto(addr386);
            default:
               throw "Invalid state in _luaB_select";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
