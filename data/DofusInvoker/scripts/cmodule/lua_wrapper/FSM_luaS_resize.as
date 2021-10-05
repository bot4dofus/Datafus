package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaS_resize extends Machine
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
      
      public function FSM_luaS_resize()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaS_resize = null;
         _loc1_ = new FSM_luaS_resize();
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
               this.i1 = li32(this.i0 + 16);
               this.i2 = li8(this.i1 + 21);
               this.i3 = this.i0 + 16;
               this.i4 = li32(mstate.ebp + 12);
               if(this.i2 != 2)
               {
                  this.i2 = this.i4 + 1;
                  if(uint(this.i2) <= uint(1073741823))
                  {
                     this.i2 = 0;
                     this.i5 = li32(this.i1 + 12);
                     this.i6 = li32(this.i1 + 16);
                     mstate.esp -= 16;
                     this.i7 = this.i4 << 2;
                     si32(this.i6,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i2,mstate.esp + 8);
                     si32(this.i7,mstate.esp + 12);
                     state = 1;
                     mstate.esp -= 4;
                     mstate.funcs[this.i5]();
                     return;
                  }
                  this.i1 = __2E_str149;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaG_runerror.start();
                  return;
               }
               §§goto(addr631);
               break;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               if(this.i2 == 0)
               {
                  if(this.i7 != 0)
                  {
                     this.i5 = 4;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaD_throw.start();
                     return;
                  }
               }
               addr214:
               this.i0 = li32(this.i1 + 68);
               this.i0 = this.i7 + this.i0;
               si32(this.i0,this.i1 + 68);
               this.i0 = li32(this.i3);
               this.i1 = this.i2;
               if(this.i4 > 0)
               {
                  break;
               }
               §§goto(addr252);
               break;
            case 2:
               mstate.esp += 8;
               §§goto(addr214);
            case 3:
               mstate.esp += 8;
               this.i0 = li32(this.i3);
               if(this.i4 > 0)
               {
                  this.i1 = 0;
                  break;
               }
               this.i1 = 0;
               §§goto(addr251);
               break;
            case 4:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               this.i6 = li32(this.i3 + 68);
               this.i5 = this.i6 - this.i5;
               si32(this.i5,this.i3 + 68);
               si32(this.i4,this.i0);
               si32(this.i2,this.i1);
               addr631:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaS_resize";
         }
         this.i2 = 0;
         this.i5 = this.i1;
         do
         {
            this.i6 = 0;
            si32(this.i6,this.i5);
            this.i5 += 4;
            this.i2 += 1;
         }
         while(this.i2 < this.i4);
         
         addr251:
         addr252:
         this.i2 = this.i1;
         this.i1 = this.i0;
         this.i5 = li32(this.i1 + 8);
         this.i0 = this.i1 + 8;
         if(this.i5 > 0)
         {
            this.i5 = 0;
            this.i6 = this.i4 + -1;
            this.i7 = this.i1;
            this.i8 = this.i5;
            do
            {
               this.i9 = li32(this.i7);
               this.i9 += this.i8;
               this.i9 = li32(this.i9);
               if(this.i9 != 0)
               {
                  while(true)
                  {
                     this.i10 = li32(this.i9 + 8);
                     this.i10 &= this.i6;
                     this.i10 <<= 2;
                     this.i10 = this.i2 + this.i10;
                     this.i11 = li32(this.i9);
                     this.i12 = li32(this.i10);
                     si32(this.i12,this.i9);
                     si32(this.i9,this.i10);
                     if(this.i11 == 0)
                     {
                        break;
                     }
                     this.i9 = this.i11;
                  }
               }
               this.i9 = li32(this.i0);
               this.i8 += 4;
               this.i5 += 1;
            }
            while(this.i9 > this.i5);
            
            this.i5 = this.i9;
         }
         this.i6 = 0;
         this.i3 = li32(this.i3);
         this.i7 = li32(this.i1);
         this.i8 = li32(this.i3 + 12);
         this.i9 = li32(this.i3 + 16);
         mstate.esp -= 16;
         this.i5 <<= 2;
         si32(this.i9,mstate.esp);
         si32(this.i7,mstate.esp + 4);
         si32(this.i5,mstate.esp + 8);
         si32(this.i6,mstate.esp + 12);
         state = 4;
         mstate.esp -= 4;
         mstate.funcs[this.i8]();
      }
   }
}
