package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_checkoption extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_luaL_checkoption()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_checkoption = null;
         _loc1_ = new FSM_luaL_checkoption();
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
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = li32(mstate.ebp + 20);
               this.i4 = this.i3;
               if(this.i2 != 0)
               {
                  this.i5 = 0;
                  mstate.esp -= 16;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  si32(this.i5,mstate.esp + 12);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaL_optlstring.start();
                  return;
               }
               this.i2 = 0;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
               break;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i3 = li32(this.i3);
               if(this.i3 != 0)
               {
                  addr332:
                  this.i3 = 0;
                  this.i5 = li8(this.i2);
                  this.i6 = this.i2;
                  loop0:
                  while(true)
                  {
                     this.i7 = li32(this.i4);
                     this.i8 = li8(this.i7);
                     this.i9 = this.i5 & 255;
                     if(this.i8 == this.i9)
                     {
                        this.i9 = 0;
                        while(true)
                        {
                           this.i10 = this.i6 + this.i9;
                           this.i10 += 1;
                           this.i8 &= 255;
                           if(this.i8 == 0)
                           {
                              break;
                           }
                           this.i8 = this.i7 + this.i9;
                           this.i8 = li8(this.i8 + 1);
                           this.i10 = li8(this.i10);
                           this.i9 += 1;
                           if(this.i8 == this.i10)
                           {
                              continue;
                           }
                           addr442:
                           this.i7 = this.i6 + this.i9;
                           this.i7 = li8(this.i7);
                           this.i8 &= 255;
                           if(this.i8 == this.i7)
                           {
                              break;
                           }
                           this.i7 = li32(this.i4 + 4);
                           this.i3 += 1;
                           this.i4 += 4;
                           if(this.i7 == 0)
                           {
                              break loop0;
                           }
                           continue loop0;
                        }
                        break loop2;
                     }
                     this.i7 = this.i2;
                     §§goto(addr442);
                  }
               }
               this.i3 = this.i2;
               this.i2 = __2E_str12187330;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
            case 2:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 3:
               mstate.esp += 12;
               this.i3 = 0;
               break;
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(this.i3);
               if(this.i3 != 0)
               {
               }
               §§goto(addr332);
            default:
               throw "Invalid state in _luaL_checkoption";
         }
         mstate.eax = this.i3;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
