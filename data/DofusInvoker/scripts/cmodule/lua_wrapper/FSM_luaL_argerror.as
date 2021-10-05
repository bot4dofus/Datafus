package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_argerror extends Machine
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
      
      public function FSM_luaL_argerror()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_argerror = null;
         _loc1_ = new FSM_luaL_argerror();
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
               mstate.esp -= 112;
               this.i0 = mstate.ebp + -112;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 20);
               this.i3 = li32(this.i1 + 40);
               mstate.esp -= 16;
               this.i4 = 0;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               mstate.esp -= 4;
               FSM_lua_getstack390.start();
            case 1:
               this.i0 = mstate.eax;
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               mstate.esp += 16;
               if(this.i0 == 0)
               {
                  this.i0 = __2E_str3178321;
                  mstate.esp -= 16;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  break;
               }
               this.i0 = __2E_str515;
               mstate.esp -= 12;
               this.i4 = mstate.ebp + -112;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_lua_getinfo.start();
               return;
               break;
            case 2:
               mstate.esp += 16;
               §§goto(addr186);
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(mstate.ebp + -104);
               this.i4 = li8(this.i0);
               if(this.i4 == 109)
               {
                  this.i5 = __2E_str7264;
                  this.i6 = 0;
                  while(true)
                  {
                     this.i7 = this.i5 + this.i6;
                     this.i7 += 1;
                     this.i4 &= 255;
                     if(this.i4 != 0)
                     {
                        this.i4 = this.i0 + this.i6;
                        this.i4 = li8(this.i4 + 1);
                        this.i7 = li8(this.i7);
                        this.i6 += 1;
                        if(this.i4 != this.i7)
                        {
                           this.i0 = __2E_str7264;
                           this.i0 += this.i6;
                           this.i0 = li8(this.i0);
                        }
                        else
                        {
                           addr368:
                        }
                        continue;
                        this.i4 &= 255;
                        if(this.i4 != this.i0)
                        {
                           §§goto(addr402);
                        }
                        break;
                     }
                     break;
                  }
                  this.i0 = this.i2 + -1;
                  if(this.i2 != 1)
                  {
                     this.i2 = this.i0;
                     addr402:
                     this.i0 = this.i2;
                     this.i2 = mstate.ebp + -112;
                     this.i4 = li32(mstate.ebp + -108);
                     this.i2 += 4;
                     if(this.i4 == 0)
                     {
                        this.i4 = __2E_str6354;
                        si32(this.i4,this.i2);
                        mstate.esp -= 20;
                        this.i2 = __2E_str8183326;
                     }
                     else
                     {
                        this.i2 = __2E_str8183326;
                        mstate.esp -= 20;
                     }
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     si32(this.i4,mstate.esp + 12);
                     si32(this.i3,mstate.esp + 16);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaL_error.start();
                     return;
                  }
                  this.i2 = __2E_str6181324;
                  this.i0 = li32(mstate.ebp + -108);
                  mstate.esp -= 16;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  break;
               }
               this.i0 = __2E_str7264;
               §§goto(addr368);
            case 4:
               mstate.esp += 20;
               addr186:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaL_argerror";
         }
         si32(this.i3,mstate.esp + 12);
         state = 2;
         mstate.esp -= 4;
         FSM_luaL_error.start();
      }
   }
}
