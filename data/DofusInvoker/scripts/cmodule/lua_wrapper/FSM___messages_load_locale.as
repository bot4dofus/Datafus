package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___messages_load_locale extends Machine
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
      
      public function FSM___messages_load_locale()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___messages_load_locale = null;
         _loc1_ = new FSM___messages_load_locale();
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
               this.i0 = __messages_using_locale;
               mstate.esp -= 28;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = __messages_locale_buf;
               this.i3 = __2E_str417;
               this.i4 = __messages_locale;
               this.i5 = 2;
               this.i6 = 4;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               si32(this.i6,mstate.esp + 16);
               si32(this.i5,mstate.esp + 20);
               si32(this.i4,mstate.esp + 24);
               state = 1;
               mstate.esp -= 4;
               FSM___part_load_locale.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 28;
               if(this.i0 == 0)
               {
                  this.i1 = li32(__messages_locale + 8);
                  if(this.i1 == 0)
                  {
                     this.i1 = _empty;
                     si32(this.i1,__messages_locale + 8);
                  }
                  this.i1 = li32(__messages_locale + 12);
                  if(this.i1 == 0)
                  {
                     this.i1 = _empty;
                     si32(this.i1,__messages_locale + 12);
                  }
               }
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in ___messages_load_locale";
         }
      }
   }
}
