package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_os_rename extends Machine
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
      
      public function FSM_os_rename()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_os_rename = null;
         _loc1_ = new FSM_os_rename();
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
               mstate.esp -= 4096;
               this.i2 = 0;
               this.i3 = li32(mstate.ebp + 8);
               mstate.esp -= 12;
               this.i0 = 1;
               si32(this.i3,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 1:
               this.i4 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i0 = 2;
               si32(this.i3,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = __2E_str2987;
               this.i1 = 4;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 20;
               this.i0 = __2E_str96;
               this.i1 = __2E_str13;
               this.i5 = 368;
               this.i6 = 78;
               this.i7 = mstate.ebp + -4096;
               si32(this.i7,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               si32(this.i5,mstate.esp + 16);
               state = 3;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 3:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i7;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i6,_val_2E_1440);
               this.i0 = li32(this.i3 + 8);
               si32(this.i2,this.i0 + 8);
               this.i0 = li32(this.i3 + 8);
               this.i0 += 12;
               si32(this.i0,this.i3 + 8);
               mstate.esp -= 12;
               this.i0 = _ebuf_2E_1986;
               this.i1 = 2048;
               si32(this.i6,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_strerror_r.start();
               break;
            case 4:
               break;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = li32(this.i1);
               this.i2 = 1079214080;
               this.i3 = 0;
               si32(this.i3,this.i0);
               si32(this.i2,this.i0 + 4);
               this.i2 = 3;
               si32(this.i2,this.i0 + 8);
               this.i0 = li32(this.i1);
               this.i0 += 12;
               si32(this.i0,this.i1);
               mstate.eax = this.i2;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _os_rename";
         }
         this.i0 = mstate.eax;
         mstate.esp += 12;
         this.i1 = this.i3 + 8;
         if(this.i0 != 0)
         {
            this.i0 = 22;
            si32(this.i0,_val_2E_1440);
         }
         this.i0 = __2E_str15318;
         mstate.esp -= 16;
         this.i2 = _ebuf_2E_1986;
         si32(this.i3,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i4,mstate.esp + 8);
         si32(this.i2,mstate.esp + 12);
         state = 5;
         mstate.esp -= 4;
         FSM_lua_pushfstring.start();
      }
   }
}
