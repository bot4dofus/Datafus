package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_getF extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_getF()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_getF = null;
         _loc1_ = new FSM_getF();
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
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = li32(this.i0);
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = this.i0;
               if(this.i1 == 0)
               {
                  this.i0 = li32(this.i3 + 4);
                  this.i1 = li16(this.i0 + 12);
                  this.i1 &= 32;
                  if(this.i1 == 0)
                  {
                     this.i1 = 1024;
                     mstate.esp -= 16;
                     this.i4 = 1;
                     this.i3 += 8;
                     si32(this.i3,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     si32(this.i1,mstate.esp + 8);
                     si32(this.i0,mstate.esp + 12);
                     state = 1;
                     mstate.esp -= 4;
                     FSM___fread.start();
                     return;
                  }
                  this.i0 = 0;
                  break;
               }
               this.i3 = 0;
               si32(this.i3,this.i0);
               this.i3 = 1;
               si32(this.i3,this.i2);
               this.i2 = __2E_str10143;
               mstate.eax = this.i2;
               §§goto(addr196);
               break;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               si32(this.i0,this.i2);
               this.i0 = this.i0 == 0 ? 0 : int(this.i3);
               break;
            default:
               throw "Invalid state in _getF";
         }
         mstate.eax = this.i0;
         addr196:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
