package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_errfile extends Machine
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
      
      public function FSM_errfile()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_errfile = null;
         _loc1_ = new FSM_errfile();
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
               this.i0 = _ebuf_2E_1986;
               this.i1 = li32(_val_2E_1440);
               mstate.esp -= 12;
               this.i2 = 2048;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_strerror_r.start();
               break;
            case 1:
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 20;
               this.i4 = __2E_str16191334;
               this.i5 = _ebuf_2E_1986;
               this.i0 += 1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               si32(this.i5,mstate.esp + 16);
               state = 3;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 20;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 8);
               this.i1 += 8;
               this.i3 = this.i0;
               this.i4 = this.i0 + 12;
               if(uint(this.i4) >= uint(this.i2))
               {
                  this.i0 = this.i2;
               }
               else
               {
                  this.i0 += 12;
                  this.i2 = this.i3;
                  while(true)
                  {
                     this.f0 = lf64(this.i2 + 12);
                     sf64(this.f0,this.i2);
                     this.i3 = li32(this.i2 + 20);
                     si32(this.i3,this.i2 + 8);
                     this.i2 = li32(this.i1);
                     this.i3 = this.i0 + 12;
                     this.i4 = this.i0;
                     if(uint(this.i3) >= uint(this.i2))
                     {
                        break;
                     }
                     this.i0 = this.i3;
                     this.i2 = this.i4;
                  }
                  this.i0 = this.i2;
               }
               this.i0 += -12;
               si32(this.i0,this.i1);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _errfile";
         }
         this.i0 = mstate.eax;
         this.i1 = li32(mstate.ebp + 8);
         this.i2 = li32(mstate.ebp + 12);
         this.i3 = li32(mstate.ebp + 16);
         mstate.esp += 12;
         if(this.i0 != 0)
         {
            this.i0 = 22;
            si32(this.i0,_val_2E_1440);
         }
         this.i0 = 0;
         mstate.esp -= 12;
         si32(this.i1,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         si32(this.i0,mstate.esp + 8);
         state = 2;
         mstate.esp -= 4;
         FSM_lua_tolstring.start();
      }
   }
}
