package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_costatus extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaB_costatus()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_costatus = null;
         _loc1_ = new FSM_luaB_costatus();
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
               mstate.esp -= 224;
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
               this.i2 = li32(this.i0 + 8);
               if(this.i2 != 8)
               {
                  this.i0 = 0;
               }
               else
               {
                  this.i0 = li32(this.i0);
               }
               if(this.i0 == 0)
               {
                  this.i2 = __2E_str63352;
                  mstate.esp -= 12;
                  this.i3 = 1;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               if(this.i0 == this.i1)
               {
                  this.i0 = 0;
               }
               else
               {
                  this.i2 = li8(this.i0 + 6);
                  if(this.i2 != 0)
                  {
                     if(this.i2 == 1)
                     {
                        this.i0 = 1;
                     }
                     else
                     {
                        this.i0 = 3;
                     }
                  }
                  else
                  {
                     this.i2 = mstate.ebp + -112;
                     this.i3 = li32(this.i0 + 20);
                     this.i4 = li32(this.i0 + 40);
                     mstate.esp -= 16;
                     this.i5 = 0;
                     si32(this.i3,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     si32(this.i5,mstate.esp + 8);
                     si32(this.i2,mstate.esp + 12);
                     mstate.esp -= 4;
                     FSM_lua_getstack390.start();
                     addr501:
                     this.i2 = mstate.eax;
                     mstate.esp += 16;
                     if(this.i2 >= 1)
                     {
                        this.i0 = 2;
                     }
                     else
                     {
                        this.i2 = li32(this.i0 + 8);
                        this.i0 = li32(this.i0 + 12);
                        this.i0 = this.i2 - this.i0;
                        this.i0 += 11;
                        this.i0 = uint(this.i0) < uint(23) ? 3 : 1;
                     }
                  }
               }
               break;
            case 5:
               §§goto(addr501);
            case 2:
               mstate.esp += 12;
               if(this.i0 == this.i1)
               {
                  this.i0 = 0;
                  break;
               }
               this.i2 = li8(this.i0 + 6);
               if(this.i2 != 0)
               {
                  if(this.i2 == 1)
                  {
                     this.i0 = 1;
                     break;
                  }
                  this.i0 = 3;
                  break;
               }
               this.i2 = mstate.ebp + -224;
               this.i3 = li32(this.i0 + 20);
               this.i4 = li32(this.i0 + 40);
               mstate.esp -= 16;
               this.i5 = 0;
               si32(this.i3,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               mstate.esp -= 4;
               FSM_lua_getstack390.start();
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               if(this.i2 >= 1)
               {
                  this.i0 = 2;
                  break;
               }
               this.i2 = li32(this.i0 + 8);
               this.i0 = li32(this.i0 + 12);
               this.i0 = this.i2 - this.i0;
               this.i0 += 11;
               this.i0 = uint(this.i0) < uint(23) ? 3 : 1;
               break;
            case 4:
               mstate.esp += 8;
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaB_costatus";
         }
         this.i2 = _statnames;
         this.i0 <<= 2;
         this.i0 = this.i2 + this.i0;
         this.i0 = li32(this.i0);
         mstate.esp -= 8;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         state = 4;
         mstate.esp -= 4;
         FSM_lua_pushstring.start();
      }
   }
}
