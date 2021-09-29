package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaG_typeerror extends Machine
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
      
      public function FSM_luaG_typeerror()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaG_typeerror = null;
         _loc1_ = new FSM_luaG_typeerror();
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
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + 12);
               si32(this.i0,mstate.ebp + -4);
               this.i0 = li32(this.i1 + 8);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = _luaT_typenames;
               this.i0 <<= 2;
               this.i4 = li32(this.i2 + 20);
               this.i0 = this.i3 + this.i0;
               this.i0 = li32(this.i0);
               this.i3 = li32(this.i4);
               this.i5 = li32(this.i4 + 8);
               this.i6 = li32(mstate.ebp + 16);
               if(uint(this.i5) <= uint(this.i3))
               {
                  addr117:
                  this.i1 = 0;
               }
               else
               {
                  while(true)
                  {
                     if(this.i3 == this.i1)
                     {
                        this.i3 = mstate.ebp + -4;
                        this.i5 = li32(this.i2 + 12);
                        this.i1 -= this.i5;
                        mstate.esp -= 16;
                        this.i1 /= 12;
                        si32(this.i2,mstate.esp);
                        si32(this.i4,mstate.esp + 4);
                        si32(this.i1,mstate.esp + 8);
                        si32(this.i3,mstate.esp + 12);
                        mstate.esp -= 4;
                        FSM_getobjname.start();
                        addr212:
                        this.i1 = mstate.eax;
                        mstate.esp += 16;
                        break;
                     }
                     this.i3 += 12;
                     if(uint(this.i5) > uint(this.i3))
                     {
                        continue;
                     }
                     §§goto(addr117);
                  }
               }
               if(this.i1 != 0)
               {
                  this.i3 = __2E_str18275;
                  this.i4 = li32(mstate.ebp + -4);
                  mstate.esp -= 24;
                  si32(this.i2,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  si32(this.i1,mstate.esp + 12);
                  si32(this.i4,mstate.esp + 16);
                  si32(this.i0,mstate.esp + 20);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               this.i1 = __2E_str19276;
               mstate.esp -= 16;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 3;
               mstate.esp -= 4;
               FSM_luaG_runerror.start();
               return;
            case 1:
               §§goto(addr212);
            case 2:
               mstate.esp += 24;
               break;
            case 3:
               mstate.esp += 16;
               break;
            default:
               throw "Invalid state in _luaG_typeerror";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
