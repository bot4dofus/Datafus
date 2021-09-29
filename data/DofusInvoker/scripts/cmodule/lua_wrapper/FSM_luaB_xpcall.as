package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_xpcall extends Machine
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
      
      public function FSM_luaB_xpcall()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_xpcall = null;
         _loc1_ = new FSM_luaB_xpcall();
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
               this.i0 = 2;
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
                     addr147:
                     this.i0 = li32(this.i1 + 12);
                     this.i2 = li32(this.i1 + 8);
                     this.i3 = this.i1 + 12;
                     this.i4 = this.i1 + 8;
                     this.i5 = this.i0 + 24;
                     if(uint(this.i2) >= uint(this.i5))
                     {
                        this.i2 = this.i0;
                     }
                     else
                     {
                        do
                        {
                           this.i0 = 0;
                           si32(this.i0,this.i2 + 8);
                           this.i2 += 12;
                           si32(this.i2,this.i4);
                           this.i0 = li32(this.i3);
                           this.i5 = this.i0 + 24;
                        }
                        while(uint(this.i2) < uint(this.i5));
                        
                        this.i2 = this.i0;
                     }
                     this.i0 = this.i2;
                     this.i2 = 1;
                     this.i0 += 24;
                     si32(this.i0,this.i4);
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr288:
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     this.i2 = li32(this.i4);
                     this.i5 = this.i2;
                     if(uint(this.i2) > uint(this.i0))
                     {
                        this.i6 = 0;
                        do
                        {
                           this.i7 = this.i6 ^ -1;
                           this.i7 *= 12;
                           this.i7 = this.i5 + this.i7;
                           this.f0 = lf64(this.i7);
                           sf64(this.f0,this.i2);
                           this.i8 = li32(this.i7 + 8);
                           si32(this.i8,this.i2 + 8);
                           this.i2 += -12;
                           this.i6 += 1;
                        }
                        while(uint(this.i7) > uint(this.i0));
                        
                     }
                     this.i2 = 1;
                     this.i5 = li32(this.i4);
                     this.f0 = lf64(this.i5);
                     sf64(this.f0,this.i0);
                     this.i5 = li32(this.i5 + 8);
                     si32(this.i5,this.i0 + 8);
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     break;
                  }
               }
               this.i0 = __2E_str11186329;
               mstate.esp -= 12;
               this.i2 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 2:
               mstate.esp += 12;
               §§goto(addr147);
            case 3:
               §§goto(addr288);
            case 4:
               break;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i1 + 20);
               this.i5 = li32(this.i4);
               this.i6 = li32(this.i2 + 8);
               this.i2 += 8;
               if(uint(this.i5) >= uint(this.i6))
               {
                  si32(this.i5,this.i2);
               }
               this.i2 = 1;
               this.i0 = this.i0 == 0 ? 1 : 0;
               this.i5 = li32(this.i4);
               this.i0 &= 1;
               si32(this.i0,this.i5);
               si32(this.i2,this.i5 + 8);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 6;
               mstate.esp -= 4;
               FSM_lua_replace.start();
               return;
            case 6:
               mstate.esp += 8;
               this.i0 = li32(this.i4);
               this.i1 = li32(this.i3);
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
               throw "Invalid state in _luaB_xpcall";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i2 = li32(this.i1 + 32);
         this.i5 = li32(this.i4);
         this.i5 += -12;
         si32(this.i5,mstate.ebp + -8);
         this.i6 = -1;
         si32(this.i6,mstate.ebp + -4);
         mstate.esp -= 20;
         this.i6 = _f_call;
         this.i5 -= this.i2;
         this.i7 = mstate.ebp + -8;
         this.i0 -= this.i2;
         si32(this.i1,mstate.esp);
         si32(this.i6,mstate.esp + 4);
         si32(this.i7,mstate.esp + 8);
         si32(this.i5,mstate.esp + 12);
         si32(this.i0,mstate.esp + 16);
         state = 5;
         mstate.esp -= 4;
         FSM_luaD_pcall.start();
      }
   }
}
