package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_newkey extends Machine
   {
      
      public static const intRegCount:int = 17;
      
      public static const NumberRegCount:int = 2;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
      public var f0:Number;
      
      public var i16:int;
      
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
      
      public var f1:Number;
      
      public function FSM_newkey()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_newkey = null;
         _loc1_ = new FSM_newkey();
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
               mstate.esp -= 112;
               this.i0 = mstate.ebp + -112;
               this.i1 = li32(mstate.ebp + 12);
               mstate.esp -= 8;
               this.i2 = li32(mstate.ebp + 16);
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_mainposition.start();
            case 1:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i3 + 8);
               this.i5 = this.i3 + 8;
               this.i6 = li32(mstate.ebp + 8);
               if(this.i4 == 0)
               {
                  this.i4 = _dummynode_;
                  if(this.i3 != this.i4)
                  {
                     this.i0 = this.i3;
                  }
                  else
                  {
                     §§goto(addr189);
                  }
                  this.f0 = lf64(this.i2);
                  sf64(this.f0,this.i0 + 12);
                  this.i3 = li32(this.i2 + 8);
                  si32(this.i3,this.i0 + 20);
                  this.i3 = li32(this.i2 + 8);
                  if(this.i3 >= 4)
                  {
                     this.i2 = li32(this.i2);
                     this.i2 = li8(this.i2 + 5);
                     this.i2 &= 3;
                     if(this.i2 != 0)
                     {
                        this.i2 = li8(this.i1 + 5);
                        this.i3 = this.i1 + 5;
                        this.i4 = this.i2 & 4;
                        if(this.i4 != 0)
                        {
                           this.i4 = li32(this.i6 + 16);
                           this.i2 &= -5;
                           si8(this.i2,this.i3);
                           this.i2 = li32(this.i4 + 40);
                           si32(this.i2,this.i1 + 24);
                           si32(this.i1,this.i4 + 40);
                           break;
                        }
                        break;
                     }
                     break;
                  }
                  break;
               }
               addr189:
               this.i4 = this.i1 + 16;
               this.i7 = this.i1 + 20;
               while(true)
               {
                  this.i9 = li32(this.i7);
                  this.i11 = li32(this.i4);
                  this.i8 = this.i9 + -28;
                  si32(this.i8,this.i7);
                  if(uint(this.i9) <= uint(this.i11))
                  {
                     break;
                  }
                  this.i10 = li32(this.i9 + -8);
                  this.i11 = this.i9 + -8;
                  if(this.i10 != 0)
                  {
                     continue;
                  }
                  if(this.i8 == 0)
                  {
                     break;
                  }
                  addr1151:
                  mstate.esp -= 8;
                  this.i0 = this.i3 + 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_mainposition.start();
                  this.i0 = mstate.eax;
                  mstate.esp += 8;
                  if(this.i0 != this.i3)
                  {
                     this.i4 = li32(this.i0 + 24);
                     this.i0 += 24;
                     if(this.i4 != this.i3)
                     {
                        do
                        {
                           this.i0 = li32(this.i0);
                           this.i4 = li32(this.i0 + 24);
                           this.i0 += 24;
                        }
                        while(this.i4 != this.i3);
                        
                     }
                     this.i4 = 0;
                     si32(this.i8,this.i0);
                     this.f0 = lf64(this.i3);
                     sf64(this.f0,this.i9 + -28);
                     this.i0 = li32(this.i5);
                     si32(this.i0,this.i9 + -20);
                     this.f0 = lf64(this.i3 + 12);
                     sf64(this.f0,this.i9 + -16);
                     this.i0 = li32(this.i3 + 20);
                     si32(this.i0,this.i11);
                     this.i0 = li32(this.i3 + 24);
                     si32(this.i0,this.i9 + -4);
                     si32(this.i4,this.i3 + 24);
                     si32(this.i4,this.i5);
                     this.i0 = this.i3;
                  }
                  else
                  {
                     this.i0 = li32(this.i3 + 24);
                     si32(this.i0,this.i9 + -4);
                     si32(this.i8,this.i3 + 24);
                     this.i0 = this.i8;
                  }
               }
               this.i3 = 0;
               this.i5 = this.i0;
               do
               {
                  this.i8 = 0;
                  si32(this.i8,this.i5);
                  this.i5 += 4;
                  this.i3 += 1;
               }
               while(this.i3 != 27);
               
               this.i9 = 1;
               this.i8 = 0;
               this.i10 = this.i1 + 12;
               this.i3 = this.i1 + 28;
               this.i5 = this.i0;
               this.i11 = this.i8;
               this.i7 = this.i9;
               while(true)
               {
                  this.i12 = this.i5;
                  this.i5 = this.i12;
                  if(this.i11 >= 27)
                  {
                     break;
                  }
                  this.i13 = li32(this.i3);
                  if(this.i13 >= this.i7)
                  {
                     this.i13 = this.i7;
                  }
                  else if(this.i9 > this.i13)
                  {
                     break;
                  }
                  if(this.i9 > this.i13)
                  {
                     this.i13 = 0;
                  }
                  else
                  {
                     this.i14 = 0;
                     this.i15 = li32(this.i10);
                     this.i16 = this.i9 * 12;
                     this.i15 += this.i16;
                     this.i15 += -4;
                     do
                     {
                        this.i16 = li32(this.i15);
                        this.i16 = this.i16 != 0 ? 1 : 0;
                        this.i16 &= 1;
                        this.i15 += 12;
                        this.i9 += 1;
                        this.i14 = this.i16 + this.i14;
                     }
                     while(this.i9 <= this.i13);
                     
                     this.i13 = this.i14;
                  }
                  this.i14 = li32(this.i5);
                  this.i14 += this.i13;
                  si32(this.i14,this.i5);
                  this.i5 = this.i12 + 4;
                  this.i11 += 1;
                  this.i7 <<= 1;
                  this.i8 = this.i13 + this.i8;
               }
               this.i3 = 1;
               this.i5 = li8(this.i1 + 7);
               this.i3 <<= this.i5;
               this.i5 = mstate.ebp + -112;
               if(this.i3 == 0)
               {
                  this.i3 = 0;
                  this.i4 = this.i3;
               }
               else
               {
                  this.i9 = 0;
                  this.i11 = this.i3 * 28;
                  this.i7 = this.i9;
                  this.i10 = this.i9;
                  loop4:
                  while(true)
                  {
                     this.i12 = li32(this.i4);
                     this.i13 = this.i12 + this.i11;
                     this.i13 = li32(this.i13 + -20);
                     if(this.i13 != 0)
                     {
                        this.i13 = this.i11 + this.i12;
                        this.i12 += this.i11;
                        this.f0 = lf64(this.i12 + -16);
                        this.i12 = li32(this.i13 + -8);
                        mstate.esp -= 16;
                        sf64(this.f0,mstate.esp);
                        si32(this.i12,mstate.esp + 8);
                        si32(this.i5,mstate.esp + 12);
                        mstate.esp -= 4;
                        FSM_countint389.start();
                        while(true)
                        {
                           this.i12 = mstate.eax;
                           mstate.esp += 16;
                           this.i10 += 1;
                           this.i9 = this.i12 + this.i9;
                        }
                        addr576:
                     }
                     while(true)
                     {
                        this.i11 += -28;
                        this.i7 += 1;
                        if(this.i7 == this.i3)
                        {
                           break loop4;
                        }
                        continue loop4;
                     }
                  }
                  this.i4 = this.i10;
                  this.i3 = this.i9;
               }
               this.i9 = this.i4;
               this.f0 = lf64(this.i2);
               this.i11 = li32(this.i2 + 8);
               mstate.esp -= 16;
               sf64(this.f0,mstate.esp);
               si32(this.i11,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               mstate.esp -= 4;
               FSM_countint389.start();
               §§goto(addr676);
            case 2:
               §§goto(addr576);
            case 3:
               addr676:
               this.i5 = mstate.eax;
               this.i3 += this.i8;
               mstate.esp += 16;
               this.i3 += this.i5;
               this.i5 = this.i2 + 8;
               this.i11 = this.i2;
               if(this.i3 <= 0)
               {
                  this.i0 = 0;
                  this.i3 = this.i0;
               }
               else
               {
                  this.i4 = 0;
                  this.i7 = 1;
                  this.i10 = this.i4;
                  this.i12 = this.i4;
                  do
                  {
                     this.i13 = li32(this.i0);
                     if(this.i13 > 0)
                     {
                        this.i14 = this.i7 >>> 31;
                        this.i14 = this.i7 + this.i14;
                        this.i13 += this.i10;
                        this.i10 = this.i14 >> 1;
                        if(this.i10 >= this.i13)
                        {
                           this.i10 = this.i13;
                        }
                        else
                        {
                           this.i10 = this.i13;
                           this.i12 = this.i13;
                           this.i4 = this.i7;
                        }
                     }
                     if(this.i3 == this.i10)
                     {
                        break;
                     }
                     this.i7 <<= 1;
                     this.i0 += 4;
                     this.i13 = this.i7 >> 1;
                  }
                  while(this.i13 < this.i3);
                  
                  this.i3 = this.i12;
                  this.i0 = this.i4;
               }
               this.i4 = 0;
               this.i8 += this.i9;
               this.i8 += 1;
               mstate.esp -= 16;
               this.i3 = this.i8 - this.i3;
               si32(this.i6,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_resize.start();
               return;
            case 4:
               mstate.esp += 16;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_get.start();
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si8(this.i4,this.i1 + 6);
               this.i3 = _luaO_nilobject_;
               if(this.i0 != this.i3)
               {
                  addr969:
                  break;
               }
               this.i0 = li32(this.i5);
               if(this.i0 != 3)
               {
                  if(this.i0 == 0)
                  {
                     this.i0 = __2E_str3127;
                     §§goto(addr880);
                  }
               }
               else
               {
                  this.f0 = 0;
                  this.f1 = lf64(this.i11);
                  if(!(this.f1 != Number.NaN && this.f0 != Number.NaN))
                  {
                     this.i0 = __2E_str4128;
                     addr880:
                     mstate.esp -= 8;
                     si32(this.i6,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_luaG_runerror.start();
                     return;
                  }
               }
               §§goto(addr920);
               break;
            case 6:
               mstate.esp += 8;
               addr920:
               mstate.esp -= 12;
               si32(this.i6,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_newkey.start();
               return;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr969);
            case 8:
               §§goto(addr1151);
            default:
               throw "Invalid state in _newkey";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
