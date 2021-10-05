package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_ll_loadlib extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_ll_loadlib()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_ll_loadlib = null;
         _loc1_ = new FSM_ll_loadlib();
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
               this.i0 = 0;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i3 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_ll_loadfunc.start();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 == 0)
               {
                  this.i0 = 1;
                  break;
               }
               this.i2 = 0;
               this.i3 = li32(this.i1 + 8);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 8);
               this.i4 = this.i1 + 8;
               this.i5 = this.i3;
               if(uint(this.i3) > uint(this.i2))
               {
                  this.i6 = 0;
                  do
                  {
                     this.i7 = this.i6 ^ -1;
                     this.i7 *= 12;
                     this.i7 = this.i5 + this.i7;
                     this.f0 = lf64(this.i7);
                     sf64(this.f0,this.i3);
                     this.i8 = li32(this.i7 + 8);
                     si32(this.i8,this.i3 + 8);
                     this.i3 += -12;
                     this.i6 += 1;
                  }
                  while(uint(this.i7) > uint(this.i2));
                  
               }
               this.i3 = __2E_str8479;
               this.i4 = li32(this.i4);
               this.f0 = lf64(this.i4);
               sf64(this.f0,this.i2);
               this.i4 = li32(this.i4 + 8);
               si32(this.i4,this.i2 + 8);
               this.i2 = __2E_str9480;
               mstate.esp -= 8;
               this.i0 = this.i0 == 1 ? int(this.i3) : int(this.i2);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_lua_pushstring.start();
               return;
            case 5:
               mstate.esp += 8;
               this.i0 = 3;
               break;
            default:
               throw "Invalid state in _ll_loadlib";
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
