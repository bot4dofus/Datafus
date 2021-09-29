package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_gsub extends Machine
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
      
      public function FSM_luaL_gsub()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_gsub = null;
         _loc1_ = new FSM_luaL_gsub();
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
               mstate.esp -= 1040;
               this.i0 = li32(mstate.ebp + 16);
               this.i1 = li8(this.i0);
               this.i2 = li32(mstate.ebp + 20);
               this.i3 = li32(mstate.ebp + 8);
               this.i4 = li32(mstate.ebp + 12);
               this.i5 = this.i0;
               this.i6 = this.i2;
               if(this.i1 != 0)
               {
                  this.i1 = this.i5;
                  while(true)
                  {
                     this.i7 = li8(this.i1 + 1);
                     this.i1 += 1;
                     this.i8 = this.i1;
                     if(this.i7 == 0)
                     {
                        break;
                     }
                     this.i1 = this.i8;
                  }
               }
               else
               {
                  this.i1 = this.i0;
               }
               this.i7 = mstate.ebp + -1040;
               si32(this.i3,mstate.ebp + -1032);
               this.i8 = this.i7 + 12;
               si32(this.i8,mstate.ebp + -1040);
               this.i8 = 0;
               si32(this.i8,mstate.ebp + -1036);
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_strstr.start();
            case 3:
               this.i8 = mstate.eax;
               mstate.esp += 8;
               this.i9 = this.i7 + 4;
               this.i7 += 8;
               this.i1 -= this.i5;
               if(this.i8 == 0)
               {
                  this.i0 = this.i4;
                  break;
               }
               this.i5 = this.i8;
               §§goto(addr387);
               break;
            case 1:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i4 = this.i5 + this.i1;
               si32(this.i4,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_strstr.start();
            case 2:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               if(this.i5 != 0)
               {
                  addr387:
                  this.i8 = mstate.ebp + -1040;
                  mstate.esp -= 12;
                  this.i10 = this.i5 - this.i4;
                  si32(this.i8,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i10,mstate.esp + 8);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaL_addlstring.start();
                  return;
               }
               this.i0 = this.i4;
               break;
            case 4:
               mstate.esp += 12;
               this.i4 = li8(this.i2);
               if(this.i4 != 0)
               {
                  this.i4 = this.i6;
                  while(true)
                  {
                     this.i8 = li8(this.i4 + 1);
                     this.i4 += 1;
                     this.i10 = this.i4;
                     if(this.i8 == 0)
                     {
                        break;
                     }
                     this.i4 = this.i10;
                  }
               }
               else
               {
                  this.i4 = this.i2;
               }
               this.i8 = mstate.ebp + -1040;
               mstate.esp -= 12;
               this.i4 -= this.i6;
               si32(this.i8,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_addlstring.start();
               return;
            case 5:
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i4,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               FSM_emptybuffer.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i0 = li32(this.i9);
               this.i1 = li32(this.i7);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 7;
               mstate.esp -= 4;
               FSM_lua_concat.start();
               return;
            case 7:
               mstate.esp += 8;
               this.i0 = 1;
               si32(this.i0,this.i9);
               mstate.esp -= 12;
               this.i0 = -1;
               this.i1 = 0;
               si32(this.i3,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaL_gsub";
         }
         this.i1 = li8(this.i0);
         this.i2 = this.i0;
         if(this.i1 != 0)
         {
            this.i1 = this.i2;
            while(true)
            {
               this.i4 = li8(this.i1 + 1);
               this.i1 += 1;
               this.i5 = this.i1;
               if(this.i4 == 0)
               {
                  break;
               }
               this.i1 = this.i5;
            }
         }
         else
         {
            this.i1 = this.i0;
         }
         this.i4 = mstate.ebp + -1040;
         mstate.esp -= 12;
         this.i1 -= this.i2;
         si32(this.i4,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i1,mstate.esp + 8);
         state = 5;
         mstate.esp -= 4;
         FSM_luaL_addlstring.start();
      }
   }
}
