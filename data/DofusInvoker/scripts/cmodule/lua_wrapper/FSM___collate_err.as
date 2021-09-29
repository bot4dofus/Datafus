package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___collate_err extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM___collate_err()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___collate_err = null;
         _loc1_ = new FSM___collate_err();
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
               this.i0 = li32(___progname);
               this.i1 = li8(this.i0);
               this.i2 = this.i0;
               if(this.i1 != 0)
               {
                  this.i1 = this.i0;
                  while(true)
                  {
                     this.i3 = li8(this.i1 + 1);
                     this.i1 += 1;
                     this.i4 = this.i1;
                     if(this.i3 == 0)
                     {
                        break;
                     }
                     this.i1 = this.i4;
                  }
               }
               else
               {
                  this.i1 = this.i2;
               }
               this.i3 = 2;
               this.i4 = this.i1 - this.i0;
               this.i5 = __2E_str159130;
               this.i0 = this.i3;
               this.i1 = this.i2;
               this.i2 = this.i4;
               state = 1;
            case 1:
               this.i0 = mstate.system.write(this.i0,this.i1,this.i2);
               this.i0 = this.i3;
               this.i1 = this.i5;
               this.i2 = this.i3;
               state = 2;
            case 2:
               this.i0 = mstate.system.write(this.i0,this.i1,this.i2);
         }
         throw "Invalid state in ___collate_err";
      }
   }
}
