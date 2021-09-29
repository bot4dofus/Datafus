package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_lua_pushstring extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_lua_pushstring()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_lua_pushstring = null;
         _loc1_ = new FSM_lua_pushstring();
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
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = this.i1;
               if(this.i1 == 0)
               {
                  this.i1 = 0;
                  this.i2 = li32(this.i0 + 8);
                  si32(this.i1,this.i2 + 8);
                  break;
               }
               this.i3 = li8(this.i1);
               if(this.i3 != 0)
               {
                  this.i3 = this.i2;
                  while(true)
                  {
                     this.i4 = li8(this.i3 + 1);
                     this.i3 += 1;
                     this.i5 = this.i3;
                     if(this.i4 == 0)
                     {
                        break;
                     }
                     this.i3 = this.i5;
                  }
               }
               else
               {
                  this.i3 = this.i1;
               }
               this.i4 = li32(this.i0 + 16);
               this.i5 = li32(this.i4 + 68);
               this.i4 = li32(this.i4 + 64);
               this.i2 = this.i3 - this.i2;
               if(uint(this.i5) >= uint(this.i4))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr233);
               break;
            case 1:
               mstate.esp += 4;
               addr233:
               this.i3 = 4;
               this.i4 = li32(this.i0 + 8);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i4);
               si32(this.i3,this.i4 + 8);
               break;
            default:
               throw "Invalid state in _lua_pushstring";
         }
         this.i1 = li32(this.i0 + 8);
         this.i1 += 12;
         si32(this.i1,this.i0 + 8);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
