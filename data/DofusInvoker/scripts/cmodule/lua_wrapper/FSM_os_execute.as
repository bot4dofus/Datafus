package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_os_execute extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_os_execute()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_os_execute = null;
         _loc1_ = new FSM_os_execute();
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
               this.i0 = 1;
               mstate.esp -= 8;
               this.i2 = li32(mstate.ebp + 8);
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i1 = _luaO_nilobject_;
               if(this.i0 != this.i1)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 >= 1)
                  {
                     this.i0 = 0;
                     mstate.esp -= 12;
                     this.i1 = 1;
                     si32(this.i2,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaL_checklstring.start();
                     return;
                  }
                  break;
               }
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               break;
            case 3:
               mstate.esp += 20;
               this.i3 = 3;
               this.i0 = this.i5;
               this.i1 = this.i3;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i4,_val_2E_1440);
               this.i0 = li32(this.i2 + 8);
               this.i1 = -1074790400;
               this.i4 = 0;
               si32(this.i4,this.i0);
               si32(this.i1,this.i0 + 4);
               si32(this.i3,this.i0 + 8);
               this.i0 = li32(this.i2 + 8);
               this.i0 += 12;
               si32(this.i0,this.i2 + 8);
               this.i0 = 1;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _os_execute";
         }
         this.i0 = __2E_str47;
         this.i1 = 4;
         log(this.i1,mstate.gworker.stringFromPtr(this.i0));
         mstate.esp -= 20;
         this.i0 = __2E_str96;
         this.i1 = __2E_str13;
         this.i3 = 145;
         this.i4 = 78;
         this.i5 = mstate.ebp + -4096;
         si32(this.i5,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i4,mstate.esp + 8);
         si32(this.i1,mstate.esp + 12);
         si32(this.i3,mstate.esp + 16);
         state = 3;
         mstate.esp -= 4;
         FSM_sprintf.start();
      }
   }
}
