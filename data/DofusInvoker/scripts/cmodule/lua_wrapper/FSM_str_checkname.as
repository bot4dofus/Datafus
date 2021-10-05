package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_str_checkname extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
      
      public function FSM_str_checkname()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_str_checkname = null;
         _loc1_ = new FSM_str_checkname();
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
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 12);
               this.i2 = this.i0 + 12;
               if(this.i1 != 285)
               {
                  this.i1 = 285;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_error_expected.start();
                  return;
               }
               addr91:
               this.i1 = li32(this.i0 + 16);
               this.i3 = li32(this.i0 + 4);
               si32(this.i3,this.i0 + 8);
               this.i3 = li32(this.i0 + 24);
               this.i4 = this.i0 + 16;
               this.i5 = this.i0 + 24;
               if(this.i3 != 287)
               {
                  this.i4 = 287;
                  si32(this.i3,this.i2);
                  this.f0 = lf64(this.i0 + 28);
                  sf64(this.f0,this.i0 + 16);
                  si32(this.i4,this.i5);
                  break;
               }
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_llex.start();
               return;
               break;
            case 1:
               mstate.esp += 8;
               §§goto(addr91);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,this.i2);
               break;
            default:
               throw "Invalid state in _str_checkname";
         }
         mstate.eax = this.i1;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
