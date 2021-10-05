package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_getmetafield extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_luaL_getmetafield()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_getmetafield = null;
         _loc1_ = new FSM_luaL_getmetafield();
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
               FSM_lua_getmetatable.start();
            case 1:
               this.i0 = mstate.eax;
               this.i2 = li32(mstate.ebp + 12);
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = -2;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_lua_pushstring.start();
                  return;
               }
               this.i0 = 0;
               mstate.eax = this.i0;
               break;
            case 2:
               mstate.esp += 8;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 8);
               this.i0 = li32(this.i0);
               mstate.esp -= 8;
               this.i3 = this.i2 + -12;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_get.start();
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2 + -12);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + -4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = this.i1 + 8;
               this.i3 = _luaO_nilobject_;
               if(this.i0 != this.i3)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 0)
                  {
                     this.i1 = 0;
                     this.i0 = li32(this.i2);
                     this.i0 += -24;
                  }
                  else
                  {
                     addr327:
                     this.i0 = -2;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr357:
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     this.i1 = li32(this.i2);
                     this.i3 = this.i0;
                     this.i4 = this.i0 + 12;
                     if(uint(this.i4) >= uint(this.i1))
                     {
                        this.i0 = this.i1;
                     }
                     else
                     {
                        this.i0 += 12;
                        this.i1 = this.i3;
                        while(true)
                        {
                           this.f0 = lf64(this.i1 + 12);
                           sf64(this.f0,this.i1);
                           this.i3 = li32(this.i1 + 20);
                           si32(this.i3,this.i1 + 8);
                           this.i1 = li32(this.i2);
                           this.i3 = this.i0 + 12;
                           this.i4 = this.i0;
                           if(uint(this.i3) >= uint(this.i1))
                           {
                              break;
                           }
                           this.i0 = this.i3;
                           this.i1 = this.i4;
                        }
                        this.i0 = this.i1;
                     }
                     this.i1 = 1;
                     this.i0 += -12;
                  }
                  si32(this.i0,this.i2);
                  mstate.eax = this.i1;
                  break;
               }
               §§goto(addr327);
            case 6:
               §§goto(addr357);
            default:
               throw "Invalid state in _luaL_getmetafield";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
