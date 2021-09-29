package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaZ_lookahead extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaZ_lookahead()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaZ_lookahead = null;
         _loc1_ = new FSM_luaZ_lookahead();
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
               mstate.esp -= 4;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0);
               this.i2 = this.i0;
               if(this.i1 == 0)
               {
                  this.i1 = mstate.ebp + -4;
                  this.i3 = li32(this.i0 + 16);
                  this.i4 = li32(this.i0 + 8);
                  this.i5 = li32(this.i0 + 12);
                  mstate.esp -= 12;
                  si32(this.i3,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  state = 1;
                  mstate.esp -= 4;
                  mstate.funcs[this.i4]();
                  return;
               }
               this.i0 = li32(this.i0 + 4);
               this.i0 = li8(this.i0);
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               if(this.i1 != 0)
               {
                  this.i3 = li32(mstate.ebp + -4);
                  if(this.i3 != 0)
                  {
                     this.i3 += -1;
                     si32(this.i3,this.i2);
                     this.i1 += 1;
                     si32(this.i1,this.i0 + 4);
                     this.i1 = li32(this.i2);
                     this.i1 += 1;
                     si32(this.i1,this.i2);
                     this.i1 = li32(this.i0 + 4);
                     this.i2 = this.i1 + -1;
                     si32(this.i2,this.i0 + 4);
                     this.i0 = li8(this.i1 + -1);
                     break;
                  }
               }
               this.i0 = -1;
               break;
            default:
               throw "Invalid state in _luaZ_lookahead";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
