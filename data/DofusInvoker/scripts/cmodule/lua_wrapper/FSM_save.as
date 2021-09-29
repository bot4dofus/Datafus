package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_save extends Machine
   {
      
      public static const intRegCount:int = 12;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
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
      
      public function FSM_save()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_save = null;
         _loc1_ = new FSM_save();
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
               mstate.esp -= 80;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 48);
               this.i2 = li32(this.i1 + 4);
               this.i3 = li32(this.i1 + 8);
               this.i4 = this.i1 + 8;
               this.i5 = this.i1 + 4;
               this.i6 = li32(mstate.ebp + 12);
               this.i2 += 1;
               if(uint(this.i2) <= uint(this.i3))
               {
                  break;
               }
               if(uint(this.i3) < uint(2147483646))
               {
                  addr291:
                  this.i2 = li32(this.i4);
                  this.i3 = this.i2 << 1;
                  this.i7 = this.i1;
                  this.i8 = this.i3 | 1;
                  if(uint(this.i8) <= uint(-3))
                  {
                     this.i0 = li32(this.i0 + 40);
                     this.i8 = li32(this.i0 + 16);
                     this.i9 = li32(this.i7);
                     this.i10 = li32(this.i8 + 12);
                     this.i11 = li32(this.i8 + 16);
                     mstate.esp -= 16;
                     si32(this.i11,mstate.esp);
                     si32(this.i9,mstate.esp + 4);
                     si32(this.i2,mstate.esp + 8);
                     si32(this.i3,mstate.esp + 12);
                     state = 4;
                     mstate.esp -= 4;
                     mstate.funcs[this.i10]();
                     return;
                  }
                  this.i2 = __2E_str149;
                  this.i0 = li32(this.i0 + 40);
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               this.i2 = 80;
               this.i3 = li32(this.i0 + 52);
               mstate.esp -= 12;
               this.i7 = mstate.ebp + -80;
               this.i3 += 16;
               si32(this.i7,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 1:
               mstate.esp += 12;
               this.i2 = li32(this.i0 + 4);
               this.i3 = li32(this.i0 + 40);
               mstate.esp -= 20;
               this.i8 = __2E_str15272;
               this.i9 = __2E_str36293;
               si32(this.i3,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               si32(this.i9,mstate.esp + 16);
               state = 2;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i0 + 40);
               mstate.esp -= 8;
               this.i3 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 3:
               mstate.esp += 8;
               §§goto(addr291);
            case 4:
               this.i9 = mstate.eax;
               mstate.esp += 16;
               if(this.i9 == 0)
               {
                  if(this.i3 != 0)
                  {
                     this.i10 = 4;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i10,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr465:
               this.i0 = li32(this.i8 + 68);
               this.i2 = this.i3 - this.i2;
               this.i0 = this.i2 + this.i0;
               si32(this.i0,this.i8 + 68);
               si32(this.i9,this.i7);
               si32(this.i3,this.i4);
               break;
            case 5:
               mstate.esp += 8;
               §§goto(addr465);
            case 6:
               mstate.esp += 8;
               this.i0 = 0;
               si32(this.i0,this.i7);
               si32(this.i3,this.i4);
               break;
            default:
               throw "Invalid state in _save";
         }
         this.i0 = li32(this.i5);
         this.i1 = li32(this.i1);
         this.i1 += this.i0;
         si8(this.i6,this.i1);
         this.i0 += 1;
         si32(this.i0,this.i5);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
