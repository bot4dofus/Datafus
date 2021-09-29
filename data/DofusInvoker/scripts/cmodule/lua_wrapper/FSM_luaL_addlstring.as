package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaL_addlstring extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public function FSM_luaL_addlstring()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_addlstring = null;
         _loc1_ = new FSM_luaL_addlstring();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop2:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 16);
               this.i2 = li32(mstate.ebp + 12);
               if(this.i1 != 0)
               {
                  this.i3 = 0;
                  this.i4 = this.i0 + 1036;
                  this.i5 = this.i0;
                  while(true)
                  {
                     this.i6 = li32(this.i5);
                     this.i7 = this.i2 + this.i3;
                     if(uint(this.i6) >= uint(this.i4))
                     {
                        break;
                     }
                     break loop2;
                  }
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_emptybuffer.start();
                  return;
               }
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 1:
               this.i6 = mstate.eax;
               mstate.esp += 4;
               if(this.i6 != 0)
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               break;
            case 2:
               mstate.esp += 4;
               break;
            default:
               throw "Invalid state in _luaL_addlstring";
         }
         continue loop1;
      }
   }
}
