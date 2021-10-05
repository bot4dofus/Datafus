package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM___numeric_load_locale extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM___numeric_load_locale()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___numeric_load_locale = null;
         _loc1_ = new FSM___numeric_load_locale();
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
               this.i0 = __numeric_using_locale;
               mstate.esp -= 28;
               this.i1 = 3;
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = __numeric_locale_buf;
               this.i4 = __2E_str223;
               this.i5 = __numeric_locale;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               si32(this.i1,mstate.esp + 16);
               si32(this.i1,mstate.esp + 20);
               si32(this.i5,mstate.esp + 24);
               state = 1;
               mstate.esp -= 4;
               FSM___part_load_locale.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 28;
               if(this.i0 != -1)
               {
                  this.i1 = 0;
                  si8(this.i1,___nlocale_changed_2E_b);
                  if(this.i0 == 0)
                  {
                     this.i1 = li32(__numeric_locale);
                     this.i1 = li8(this.i1);
                     if(this.i1 == 0)
                     {
                        this.i1 = __2E_str20159;
                        si32(this.i1,__numeric_locale);
                     }
                     this.i1 = li32(__numeric_locale + 8);
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     mstate.esp -= 4;
                     FSM___fix_locale_grouping_str.start();
                     break;
                  }
               }
               §§goto(addr216);
            case 2:
               break;
            default:
               throw "Invalid state in ___numeric_load_locale";
         }
         this.i1 = mstate.eax;
         mstate.esp += 4;
         si32(this.i1,__numeric_locale + 8);
         addr216:
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
