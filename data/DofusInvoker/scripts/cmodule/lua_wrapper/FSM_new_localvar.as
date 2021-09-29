package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi16;
   
   public final class FSM_new_localvar extends Machine
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
      
      public function FSM_new_localvar()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_new_localvar = null;
         _loc1_ = new FSM_new_localvar();
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
               mstate.esp -= 160;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 36);
               this.i2 = li8(this.i1 + 50);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = this.i1 + 50;
               this.i5 = this.i0 + 36;
               this.i6 = li32(mstate.ebp + 12);
               this.i2 = this.i3 + this.i2;
               this.i2 += 1;
               if(this.i2 >= 201)
               {
                  this.i2 = li32(this.i1);
                  this.i2 = li32(this.i2 + 60);
                  this.i7 = li32(this.i1 + 16);
                  this.i8 = this.i1 + 12;
                  if(this.i2 == 0)
                  {
                     this.i2 = __2E_str196;
                     mstate.esp -= 16;
                     this.i9 = __2E_str499;
                     this.i10 = 200;
                     si32(this.i7,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i10,mstate.esp + 8);
                     si32(this.i9,mstate.esp + 12);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaO_pushfstring.start();
                     return;
                  }
                  this.i9 = __2E_str297;
                  mstate.esp -= 20;
                  this.i10 = __2E_str499;
                  this.i11 = 200;
                  si32(this.i7,mstate.esp);
                  si32(this.i9,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  si32(this.i11,mstate.esp + 12);
                  si32(this.i10,mstate.esp + 16);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               addr650:
               this.i2 = li32(this.i5);
               this.i5 = li32(this.i2);
               this.i7 = si16(li16(this.i2 + 48));
               this.i4 = li8(this.i4);
               this.i8 = li32(this.i5 + 56);
               this.i2 += 48;
               this.i9 = this.i5 + 56;
               this.i3 = this.i4 + this.i3;
               this.i4 = this.i7 + 1;
               if(this.i4 > this.i8)
               {
                  this.i4 = __2E_str5100;
                  this.i7 = li32(this.i5 + 24);
                  this.i10 = li32(this.i0 + 40);
                  mstate.esp -= 24;
                  this.i11 = 32767;
                  this.i12 = 12;
                  si32(this.i10,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i9,mstate.esp + 8);
                  si32(this.i12,mstate.esp + 12);
                  si32(this.i11,mstate.esp + 16);
                  si32(this.i4,mstate.esp + 20);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaM_growaux_.start();
                  return;
               }
               loop0:
               while(true)
               {
                  this.i4 = li32(this.i9);
                  this.i7 = li32(this.i5 + 24);
                  if(this.i4 <= this.i8)
                  {
                     break;
                  }
                  this.i4 = this.i7;
                  addr834:
                  while(true)
                  {
                     this.i7 = 0;
                     this.i10 = this.i8 * 12;
                     this.i4 += this.i10;
                     si32(this.i7,this.i4);
                     this.i8 += 1;
                     continue loop0;
                  }
               }
               this.i8 = this.i7;
               §§goto(addr884);
               break;
            case 4:
               mstate.esp += 8;
               §§goto(addr650);
            case 8:
               mstate.esp += 8;
               §§goto(addr650);
            case 9:
               this.i4 = mstate.eax;
               mstate.esp += 24;
               si32(this.i4,this.i5 + 24);
               this.i7 = li32(this.i9);
               if(this.i7 <= this.i8)
               {
                  this.i8 = this.i4;
               }
               else
               {
                  §§goto(addr834);
               }
               §§goto(addr884);
            case 10:
               break;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i7 = li32(this.i8);
               this.i8 = li32(this.i7 + 52);
               mstate.esp -= 12;
               this.i9 = 80;
               this.i10 = mstate.ebp + -160;
               this.i8 += 16;
               si32(this.i10,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 2:
               mstate.esp += 12;
               this.i8 = li32(this.i7 + 4);
               this.i9 = li32(this.i7 + 40);
               mstate.esp -= 20;
               this.i11 = __2E_str15272;
               si32(this.i9,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               si32(this.i2,mstate.esp + 16);
               state = 3;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i7 + 40);
               mstate.esp -= 8;
               this.i7 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 20;
               this.i7 = li32(this.i8);
               this.i8 = li32(this.i7 + 52);
               mstate.esp -= 12;
               this.i9 = 80;
               this.i10 = mstate.ebp + -80;
               this.i8 += 16;
               si32(this.i10,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 6:
               mstate.esp += 12;
               this.i8 = li32(this.i7 + 4);
               this.i9 = li32(this.i7 + 40);
               mstate.esp -= 20;
               this.i11 = __2E_str15272;
               si32(this.i9,mstate.esp);
               si32(this.i11,mstate.esp + 4);
               si32(this.i10,mstate.esp + 8);
               si32(this.i8,mstate.esp + 12);
               si32(this.i2,mstate.esp + 16);
               state = 7;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 7:
               this.i2 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i7 + 40);
               mstate.esp -= 8;
               this.i7 = 3;
               si32(this.i2,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            default:
               throw "Invalid state in _new_localvar";
         }
         mstate.esp += 8;
         addr884:
         this.i4 = this.i8;
         this.i7 = si16(li16(this.i2));
         this.i7 *= 12;
         this.i4 += this.i7;
         si32(this.i6,this.i4);
         this.i4 = li8(this.i6 + 5);
         this.i4 &= 3;
         if(this.i4 != 0)
         {
            this.i4 = li8(this.i5 + 5);
            this.i5 += 5;
            this.i7 = this.i4 & 4;
            if(this.i7 != 0)
            {
               this.i0 = li32(this.i0 + 40);
               this.i0 = li32(this.i0 + 16);
               this.i7 = li8(this.i0 + 21);
               if(this.i7 == 1)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_reallymarkobject.start();
                  break loop2;
               }
               this.i0 = li8(this.i0 + 20);
               this.i4 &= -8;
               this.i0 &= 3;
               this.i0 |= this.i4;
               si8(this.i0,this.i5);
            }
         }
         this.i0 = li16(this.i2);
         this.i4 = this.i0 + 1;
         this.i3 <<= 1;
         si16(this.i4,this.i2);
         this.i1 += this.i3;
         si16(this.i0,this.i1 + 172);
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
