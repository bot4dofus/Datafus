package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaD_poscall extends Machine
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
      
      public function FSM_luaD_poscall()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaD_poscall = null;
         _loc1_ = new FSM_luaD_poscall();
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
               this.i1 = li8(this.i0 + 56);
               this.i2 = this.i0 + 56;
               this.i3 = li32(mstate.ebp + 12);
               this.i1 &= 2;
               if(this.i1 == 0)
               {
                  this.i2 = this.i3;
                  break;
               }
               this.i1 = -1;
               this.i4 = li32(this.i0 + 32);
               mstate.esp -= 12;
               this.i5 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaD_callhook.start();
               return;
               break;
            case 1:
               mstate.esp += 12;
               this.i1 = li32(this.i0 + 20);
               this.i1 = li32(this.i1 + 4);
               this.i1 = li32(this.i1);
               this.i1 = li8(this.i1 + 6);
               this.i5 = this.i0 + 20;
               this.i3 -= this.i4;
               this.i4 = this.i0 + 32;
               if(this.i1 == 0)
               {
                  addr229:
                  this.i1 = li8(this.i2);
                  this.i1 &= 2;
                  if(this.i1 != 0)
                  {
                     this.i1 = li32(this.i5);
                     this.i6 = li32(this.i1 + 20);
                     this.i7 = this.i6 + -1;
                     si32(this.i7,this.i1 + 20);
                     if(this.i6 != 0)
                     {
                        this.i1 = -1;
                        mstate.esp -= 12;
                        this.i6 = 4;
                        si32(this.i0,mstate.esp);
                        si32(this.i6,mstate.esp + 4);
                        si32(this.i1,mstate.esp + 8);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_luaD_callhook.start();
                        return;
                     }
                  }
               }
               this.i2 = li32(this.i4);
               this.i2 += this.i3;
               break;
            case 2:
               mstate.esp += 12;
               §§goto(addr229);
            default:
               throw "Invalid state in _luaD_poscall";
         }
         this.i1 = this.i2;
         this.i2 = li32(this.i0 + 20);
         this.i3 = this.i2 + -24;
         si32(this.i3,this.i0 + 20);
         this.i3 = li32(this.i2 + 4);
         this.i4 = li32(this.i2 + 16);
         this.i5 = li32(this.i2 + -24);
         si32(this.i5,this.i0 + 12);
         this.i2 = li32(this.i2 + -12);
         si32(this.i2,this.i0 + 24);
         this.i2 = this.i3;
         if(this.i4 == 0)
         {
            this.i1 = this.i2;
            this.i3 = this.i4;
         }
         else
         {
            this.i2 = 0;
            this.i5 = this.i0 + 8;
            this.i6 = this.i4;
            while(true)
            {
               this.i7 = this.i2;
               this.i2 = this.i6;
               this.i6 = li32(this.i5);
               this.i8 = this.i1 + this.i7;
               if(uint(this.i6) <= uint(this.i8))
               {
                  this.i1 = this.i3 + this.i7;
                  this.i3 = this.i2;
                  break;
               }
               this.i6 = this.i1 + this.i7;
               this.f0 = lf64(this.i6);
               this.i8 = this.i3 + this.i7;
               sf64(this.f0,this.i8);
               this.i6 = li32(this.i6 + 8);
               si32(this.i6,this.i8 + 8);
               this.i6 = this.i7 + 12;
               this.i7 = this.i2 + -1;
               if(this.i7 == 0)
               {
                  this.i1 = this.i3 + this.i6;
                  this.i3 = this.i7;
               }
               this.i2 = this.i6;
               this.i6 = this.i7;
            }
         }
         this.i2 = this.i3;
         this.i3 = this.i1;
         if(this.i2 > 0)
         {
            this.i5 = 0;
            this.i3 += 8;
            do
            {
               this.i6 = 0;
               si32(this.i6,this.i3);
               this.i3 += 12;
               this.i2 += -1;
               this.i5 += 1;
            }
            while(this.i2 >= 1);
            
            this.i2 = this.i5 * 12;
            this.i1 += this.i2;
         }
         si32(this.i1,this.i0 + 8);
         this.i0 = this.i4 + 1;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
