package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaK_code extends Machine
   {
      
      public static const intRegCount:int = 13;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public var i9:int;
      
      public function FSM_luaK_code()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaK_code = null;
         _loc1_ = new FSM_luaK_code();
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
               this.i1 = li32(this.i0);
               this.i2 = li32(this.i0 + 24);
               this.i3 = li32(this.i0 + 32);
               this.i4 = this.i0 + 32;
               this.i5 = this.i0 + 24;
               this.i6 = li32(mstate.ebp + 12);
               this.i7 = li32(mstate.ebp + 16);
               this.i8 = this.i0;
               if(this.i3 == -1)
               {
                  addr285:
                  this.i2 = -1;
                  si32(this.i2,this.i4);
                  this.i2 = li32(this.i5);
                  this.i3 = li32(this.i1 + 44);
                  this.i4 = this.i1 + 44;
                  this.i2 += 1;
                  if(this.i2 > this.i3)
                  {
                     this.i2 = __2E_str43257;
                     this.i3 = li32(this.i1 + 12);
                     this.i8 = li32(this.i0 + 16);
                     mstate.esp -= 24;
                     this.i9 = 2147483645;
                     this.i10 = 4;
                     si32(this.i8,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     si32(this.i4,mstate.esp + 8);
                     si32(this.i10,mstate.esp + 12);
                     si32(this.i9,mstate.esp + 16);
                     si32(this.i2,mstate.esp + 20);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaM_growaux_.start();
                     return;
                  }
                  addr423:
                  this.i2 = li32(this.i5);
                  this.i3 = li32(this.i1 + 12);
                  this.i2 <<= 2;
                  this.i2 = this.i3 + this.i2;
                  si32(this.i6,this.i2);
                  this.i2 = li32(this.i5);
                  this.i3 = li32(this.i1 + 48);
                  this.i4 = this.i1 + 48;
                  this.i2 += 1;
                  if(this.i2 > this.i3)
                  {
                     this.i2 = __2E_str43257;
                     this.i3 = li32(this.i1 + 20);
                     this.i0 = li32(this.i0 + 16);
                     mstate.esp -= 24;
                     this.i6 = 2147483645;
                     this.i8 = 4;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     si32(this.i4,mstate.esp + 8);
                     si32(this.i8,mstate.esp + 12);
                     si32(this.i6,mstate.esp + 16);
                     si32(this.i2,mstate.esp + 20);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaM_growaux_.start();
                     return;
                  }
                  break;
               }
               this.i9 = this.i0 + 12;
               addr95:
               this.i10 = li32(this.i8);
               this.i10 = li32(this.i10 + 12);
               this.i11 = this.i3 << 2;
               this.i11 = this.i10 + this.i11;
               this.i11 = li32(this.i11);
               this.i11 >>>= 14;
               this.i11 += -131071;
               if(this.i11 == -1)
               {
                  this.i11 = -1;
               }
               else
               {
                  this.i11 = this.i3 + this.i11;
                  this.i11 += 1;
               }
               this.i12 = 255;
               mstate.esp -= 12;
               si32(this.i10,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_patchtestreg395396.start();
               break;
            case 2:
               mstate.esp += 16;
               if(this.i11 != -1)
               {
                  this.i3 = this.i11;
                  §§goto(addr95);
               }
               else
               {
                  §§goto(addr285);
               }
            case 1:
               this.i10 = mstate.eax;
               mstate.esp += 12;
               this.i10 = li32(this.i8);
               this.i12 = li32(this.i9);
               this.i10 = li32(this.i10 + 12);
               mstate.esp -= 16;
               si32(this.i10,mstate.esp);
               si32(this.i12,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 2;
               mstate.esp -= 4;
               FSM_fixjump393394.start();
               return;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 24;
               si32(this.i2,this.i1 + 12);
               §§goto(addr423);
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 24;
               si32(this.i0,this.i1 + 20);
               break;
            default:
               throw "Invalid state in _luaK_code";
         }
         this.i0 = li32(this.i5);
         this.i1 = li32(this.i1 + 20);
         this.i0 <<= 2;
         this.i0 = this.i1 + this.i0;
         si32(this.i7,this.i0);
         this.i0 = li32(this.i5);
         this.i1 = this.i0 + 1;
         si32(this.i1,this.i5);
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
