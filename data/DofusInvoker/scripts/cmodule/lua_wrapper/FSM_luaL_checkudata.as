package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_checkudata extends Machine
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
      
      public function FSM_luaL_checkudata()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_checkudata = null;
         _loc1_ = new FSM_luaL_checkudata();
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
               mstate.esp -= 16;
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
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = this.i3;
               if(this.i2 != 2)
               {
                  if(this.i2 != 7)
                  {
                     this.i0 = 0;
                  }
                  else
                  {
                     this.i0 = li32(this.i0);
                     this.i0 += 20;
                  }
               }
               else
               {
                  this.i0 = li32(this.i0);
               }
               if(this.i0 != 0)
               {
                  this.i2 = 1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_lua_getmetatable.start();
                  addr157:
                  this.i2 = mstate.eax;
                  mstate.esp += 8;
                  if(this.i2 != 0)
                  {
                     this.i2 = -10000;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     §§goto(addr202);
                  }
               }
               addr257:
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 2:
               §§goto(addr157);
            case 8:
               mstate.esp += 16;
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               mstate.esp -= 8;
               this.i2 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 9:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i4 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 10:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = this.i1 + 8;
               this.i6 = _luaO_nilobject_;
               if(this.i4 != this.i6)
               {
                  this.i6 = _luaO_nilobject_;
                  if(this.i2 != this.i6)
                  {
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_luaO_rawequalObj.start();
                     addr758:
                     this.i2 = mstate.eax;
                     mstate.esp += 8;
                     if(this.i2 != 0)
                     {
                        this.i1 = li32(this.i5);
                        this.i1 += -24;
                        si32(this.i1,this.i5);
                        §§goto(addr791);
                     }
                  }
               }
               §§goto(addr257);
            case 11:
               §§goto(addr758);
            case 4:
               break;
            case 3:
               addr202:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li8(this.i3);
               if(this.i5 != 0)
               {
                  this.i5 = this.i4;
                  while(true)
                  {
                     this.i6 = li8(this.i5 + 1);
                     this.i5 += 1;
                     this.i7 = this.i5;
                     if(this.i6 == 0)
                     {
                        break;
                     }
                     this.i5 = this.i7;
                  }
               }
               else
               {
                  this.i5 = this.i3;
               }
               this.i6 = 4;
               mstate.esp -= 12;
               this.i4 = this.i5 - this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 6:
               mstate.esp += 12;
               this.i0 = 0;
               addr791:
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 7:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               si32(this.i4,mstate.ebp + -16);
               si32(this.i6,mstate.ebp + -8);
               this.i4 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i5 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 8;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            default:
               throw "Invalid state in _luaL_checkudata";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i2 = _luaO_nilobject_;
         if(this.i0 == this.i2)
         {
            this.i0 = -1;
         }
         else
         {
            this.i0 = li32(this.i0 + 8);
         }
         if(this.i0 == -1)
         {
            this.i0 = __2E_str2251;
         }
         else
         {
            this.i2 = _luaT_typenames;
            this.i0 <<= 2;
            this.i0 = this.i2 + this.i0;
            this.i0 = li32(this.i0);
         }
         this.i2 = __2E_str9184327;
         mstate.esp -= 16;
         si32(this.i1,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         si32(this.i0,mstate.esp + 12);
         state = 5;
         mstate.esp -= 4;
         FSM_lua_pushfstring.start();
      }
   }
}
