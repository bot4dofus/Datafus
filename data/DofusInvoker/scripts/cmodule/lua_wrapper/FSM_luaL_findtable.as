package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_findtable extends Machine
   {
      
      public static const intRegCount:int = 10;
      
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
      
      public var i9:int;
      
      public function FSM_luaL_findtable()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_findtable = null;
         _loc1_ = new FSM_luaL_findtable();
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
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 12);
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 8);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i2);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i2 + 8);
               this.i1 = li32(this.i0 + 8);
               this.i1 += 12;
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = li32(mstate.ebp + 20);
               si32(this.i1,this.i0 + 8);
               this.i1 = this.i0 + 16;
               this.i4 = this.i0 + 8;
               addr156:
               this.i5 = li8(this.i2);
               this.i6 = this.i2;
               if(this.i5 != 46)
               {
                  this.i7 = this.i6;
                  while(true)
                  {
                     this.i8 = li8(this.i7);
                     if(this.i8 == 0)
                     {
                        this.i7 = 0;
                        break;
                     }
                     this.i8 = li8(this.i7 + 1);
                     this.i7 += 1;
                     this.i9 = this.i7;
                     if(this.i8 == 46)
                     {
                        break;
                     }
                     this.i7 = this.i9;
                  }
               }
               else
               {
                  this.i7 = this.i2;
               }
               if(this.i7 != 0)
               {
                  this.i5 = this.i7;
               }
               else
               {
                  this.i5 &= 255;
                  if(this.i5 != 0)
                  {
                     this.i5 = this.i6;
                     while(true)
                     {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 += 1;
                        this.i8 = this.i5;
                        if(this.i7 == 0)
                        {
                           break;
                        }
                        this.i5 = this.i8;
                     }
                  }
                  else
                  {
                     this.i5 = this.i2;
                  }
               }
               this.i7 = li32(this.i1);
               this.i8 = li32(this.i7 + 68);
               this.i7 = li32(this.i7 + 64);
               this.i6 = this.i5 - this.i6;
               if(uint(this.i8) >= uint(this.i7))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 11;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               break;
            case 2:
               mstate.esp += 8;
               this.i7 = li32(this.i1);
               this.i9 = li32(this.i7 + 68);
               this.i7 = li32(this.i7 + 64);
               if(uint(this.i9) >= uint(this.i7))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr436);
               break;
            case 3:
               mstate.esp += 4;
               addr436:
               this.i7 = 4;
               this.i9 = li32(this.i4);
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,this.i9);
               si32(this.i7,this.i9 + 8);
               this.i2 = li32(this.i4);
               this.i2 += 12;
               si32(this.i2,this.i4);
               mstate.esp -= 8;
               this.i2 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i4);
               this.f0 = lf64(this.i6);
               sf64(this.f0,this.i7);
               this.i6 = li32(this.i6 + 8);
               si32(this.i6,this.i7 + 8);
               this.i6 = li32(this.i4);
               this.i6 += 12;
               si32(this.i6,this.i4);
               mstate.esp -= 8;
               this.i6 = -4;
               si32(this.i0,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 6:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li32(this.i4);
               mstate.esp -= 16;
               this.i9 = this.i7 + -24;
               this.i7 += -12;
               si32(this.i0,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 7:
               mstate.esp += 16;
               this.i6 = li32(this.i4);
               this.i6 += -24;
               si32(this.i6,this.i4);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 8:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i6 = li32(this.i4);
               this.i7 = this.i2;
               this.i9 = this.i2 + 12;
               if(uint(this.i9) >= uint(this.i6))
               {
                  this.i2 = this.i6;
               }
               else
               {
                  this.i2 += 12;
                  this.i6 = this.i7;
                  while(true)
                  {
                     this.f0 = lf64(this.i6 + 12);
                     sf64(this.f0,this.i6);
                     this.i7 = li32(this.i6 + 20);
                     si32(this.i7,this.i6 + 8);
                     this.i6 = li32(this.i4);
                     this.i7 = this.i2 + 12;
                     this.i9 = this.i2;
                     if(uint(this.i7) >= uint(this.i6))
                     {
                        break;
                     }
                     this.i2 = this.i7;
                     this.i6 = this.i9;
                  }
                  this.i2 = this.i6;
               }
               this.i2 += -12;
               si32(this.i2,this.i4);
               this.i2 = li8(this.i5);
               if(this.i2 == 46)
               {
                  addr888:
                  this.i2 = this.i8;
                  §§goto(addr156);
               }
               else
               {
                  §§goto(addr1135);
               }
            case 12:
               this.i9 = mstate.eax;
               mstate.esp += 12;
               si32(this.i9,this.i8);
               si32(this.i7,this.i8 + 8);
               this.i7 = li32(this.i4);
               this.i7 += 12;
               si32(this.i7,this.i4);
               mstate.esp -= 8;
               this.i7 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 13:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i8 = li32(this.i4);
               this.i7 = li32(this.i7);
               mstate.esp -= 8;
               this.i9 = this.i8 + -12;
               si32(this.i7,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_get.start();
            case 14:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.f0 = lf64(this.i7);
               sf64(this.f0,this.i8 + -12);
               this.i7 = li32(this.i7 + 8);
               si32(this.i7,this.i8 + -4);
               mstate.esp -= 8;
               this.i7 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 15:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               this.i8 = _luaO_nilobject_;
               if(this.i7 == this.i8)
               {
                  this.i7 = 0;
               }
               else
               {
                  this.i7 = li32(this.i7 + 8);
                  this.i7 = this.i7 == 0 ? 1 : 0;
               }
               this.i7 ^= 1;
               this.i8 = this.i5 + 1;
               this.i7 &= 1;
               if(this.i7 == 0)
               {
                  this.i7 = li32(this.i4);
                  this.i7 += -12;
                  si32(this.i7,this.i4);
                  this.i7 = li8(this.i5);
                  mstate.esp -= 8;
                  this.i7 = this.i7 == 46 ? 1 : int(this.i3);
                  si32(this.i0,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_lua_createtable.start();
                  return;
               }
               this.i6 = -1;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 9:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i7 = _luaO_nilobject_;
               if(this.i6 != this.i7)
               {
                  this.i6 = li32(this.i6 + 8);
                  if(this.i6 != 5)
                  {
                     addr955:
                     this.i0 = li32(this.i4);
                     this.i0 += -24;
                     si32(this.i0,this.i4);
                     mstate.eax = this.i2;
                  }
                  else
                  {
                     this.i2 = -2;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr1006:
                     this.i2 = mstate.eax;
                     mstate.esp += 8;
                     this.i6 = li32(this.i4);
                     this.i7 = this.i2;
                     this.i9 = this.i2 + 12;
                     if(uint(this.i9) >= uint(this.i6))
                     {
                        this.i2 = this.i6;
                     }
                     else
                     {
                        this.i2 += 12;
                        this.i6 = this.i7;
                        while(true)
                        {
                           this.f0 = lf64(this.i6 + 12);
                           sf64(this.f0,this.i6);
                           this.i7 = li32(this.i6 + 20);
                           si32(this.i7,this.i6 + 8);
                           this.i6 = li32(this.i4);
                           this.i7 = this.i2 + 12;
                           this.i9 = this.i2;
                           if(uint(this.i7) >= uint(this.i6))
                           {
                              break;
                           }
                           this.i2 = this.i7;
                           this.i6 = this.i9;
                        }
                        this.i2 = this.i6;
                     }
                     this.i2 += -12;
                     si32(this.i2,this.i4);
                     this.i2 = li8(this.i5);
                     if(this.i2 != 46)
                     {
                        §§goto(addr1135);
                     }
                     else
                     {
                        §§goto(addr888);
                     }
                  }
                  addr1135:
                  this.i0 = 0;
                  mstate.eax = this.i0;
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  mstate.gworker = caller;
                  return;
               }
               §§goto(addr955);
            case 10:
               §§goto(addr1006);
            case 11:
               mstate.esp += 4;
               break;
            default:
               throw "Invalid state in _luaL_findtable";
         }
         this.i7 = 4;
         this.i8 = li32(this.i4);
         mstate.esp -= 12;
         si32(this.i0,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         si32(this.i6,mstate.esp + 8);
         state = 12;
         mstate.esp -= 4;
         FSM_luaS_newlstr.start();
      }
   }
}
