package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_pcall extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_luaB_pcall()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_pcall = null;
         _loc1_ = new FSM_luaB_pcall();
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
               mstate.esp -= 8;
               this.i0 = 1;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 != -1)
                  {
                     break;
                  }
               }
               this.i0 = __2E_str11186329;
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 2:
               mstate.esp += 12;
               break;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i1 + 20);
               this.i3 = li32(this.i1 + 8);
               this.i4 = li32(this.i2 + 8);
               this.i2 += 8;
               this.i5 = this.i1 + 12;
               this.i6 = this.i1 + 8;
               if(uint(this.i3) >= uint(this.i4))
               {
                  si32(this.i3,this.i2);
               }
               this.i2 = 1;
               this.i0 = this.i0 == 0 ? 1 : 0;
               this.i3 = li32(this.i6);
               this.i0 &= 1;
               si32(this.i0,this.i3);
               si32(this.i2,this.i3 + 8);
               this.i0 = li32(this.i6);
               this.i0 += 12;
               si32(this.i0,this.i6);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i1 = li32(this.i6);
               this.i2 = this.i1;
               if(uint(this.i1) > uint(this.i0))
               {
                  this.i3 = 0;
                  do
                  {
                     this.i4 = this.i3 ^ -1;
                     this.i4 *= 12;
                     this.i4 = this.i2 + this.i4;
                     this.f0 = lf64(this.i4);
                     sf64(this.f0,this.i1);
                     this.i7 = li32(this.i4 + 8);
                     si32(this.i7,this.i1 + 8);
                     this.i1 += -12;
                     this.i3 += 1;
                  }
                  while(uint(this.i4) > uint(this.i0));
                  
               }
               this.i1 = li32(this.i6);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i0);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i0 + 8);
               this.i0 = li32(this.i6);
               this.i1 = li32(this.i5);
               this.i0 -= this.i1;
               this.i0 /= 12;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaB_pcall";
         }
         this.i0 = -1;
         this.i2 = li32(this.i1 + 8);
         this.i3 = li32(this.i1 + 12);
         this.i3 = this.i2 - this.i3;
         this.i3 /= -12;
         this.i3 *= 12;
         this.i2 += this.i3;
         si32(this.i2,mstate.ebp + -8);
         si32(this.i0,mstate.ebp + -4);
         this.i0 = li32(this.i1 + 32);
         mstate.esp -= 20;
         this.i3 = _f_call;
         this.i4 = 0;
         this.i0 = this.i2 - this.i0;
         this.i2 = mstate.ebp + -8;
         si32(this.i1,mstate.esp);
         si32(this.i3,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         si32(this.i0,mstate.esp + 12);
         si32(this.i4,mstate.esp + 16);
         state = 3;
         mstate.esp -= 4;
         FSM_luaD_pcall.start();
      }
   }
}
