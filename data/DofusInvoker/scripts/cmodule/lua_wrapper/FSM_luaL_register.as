package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_register extends Machine
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
      
      public function FSM_luaL_register()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_register = null;
         _loc1_ = new FSM_luaL_register();
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
               mstate.esp -= 48;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               this.i3 = this.i2;
               this.i4 = this.i1;
               if(this.i1 != 0)
               {
                  this.i5 = li32(this.i2);
                  this.i6 = this.i2;
                  if(this.i5 == 0)
                  {
                     this.i3 = 0;
                  }
                  else
                  {
                     this.i5 = 0;
                     this.i3 += 8;
                     do
                     {
                        this.i7 = li32(this.i3);
                        this.i3 += 8;
                        this.i5 += 1;
                     }
                     while(this.i7 != 0);
                     
                     this.i3 = this.i5;
                  }
                  this.i5 = __2E_str13188331;
                  mstate.esp -= 16;
                  this.i7 = 1;
                  this.i8 = -10000;
                  si32(this.i0,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i5,mstate.esp + 8);
                  si32(this.i7,mstate.esp + 12);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaL_findtable.start();
                  return;
               }
               this.i1 = this.i2;
               addr1365:
               this.i2 = li32(this.i1);
               if(this.i2 == 0)
               {
                  break;
               }
               §§goto(addr763);
               break;
            case 1:
               this.i5 = mstate.eax;
               mstate.esp += 16;
               mstate.esp -= 8;
               this.i5 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i7 = li8(this.i1);
               if(this.i7 != 0)
               {
                  this.i7 = this.i4;
                  while(true)
                  {
                     this.i8 = li8(this.i7 + 1);
                     this.i7 += 1;
                     this.i9 = this.i7;
                     if(this.i8 == 0)
                     {
                        break;
                     }
                     this.i7 = this.i9;
                  }
               }
               else
               {
                  this.i7 = this.i1;
               }
               this.i8 = 4;
               mstate.esp -= 12;
               this.i7 -= this.i4;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,mstate.ebp + -16);
               si32(this.i8,mstate.ebp + -8);
               this.i1 = li32(this.i7);
               mstate.esp -= 16;
               this.i1 += -12;
               this.i4 = mstate.ebp + -16;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 4:
               mstate.esp += 16;
               this.i1 = li32(this.i7);
               this.i1 += -12;
               si32(this.i1,this.i7);
               mstate.esp -= 8;
               this.i1 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i7);
               this.i4 = this.i1;
               this.i5 = this.i1 + 12;
               if(uint(this.i5) >= uint(this.i3))
               {
                  this.i1 = this.i3;
               }
               else
               {
                  this.i1 += 12;
                  this.i3 = this.i4;
                  while(true)
                  {
                     this.f0 = lf64(this.i3 + 12);
                     sf64(this.f0,this.i3);
                     this.i4 = li32(this.i3 + 20);
                     si32(this.i4,this.i3 + 8);
                     this.i3 = li32(this.i7);
                     this.i4 = this.i1 + 12;
                     this.i5 = this.i1;
                     if(uint(this.i4) >= uint(this.i3))
                     {
                        break;
                     }
                     this.i1 = this.i4;
                     this.i3 = this.i5;
                  }
                  this.i1 = this.i3;
               }
               this.i3 = -1;
               this.i1 += -12;
               si32(this.i1,this.i7);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 6:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i7);
               this.i4 = this.i3;
               if(uint(this.i3) > uint(this.i1))
               {
                  this.i5 = 0;
                  do
                  {
                     this.i8 = this.i5 ^ -1;
                     this.i8 *= 12;
                     this.i8 = this.i4 + this.i8;
                     this.f0 = lf64(this.i8);
                     sf64(this.f0,this.i3);
                     this.i9 = li32(this.i8 + 8);
                     si32(this.i9,this.i3 + 8);
                     this.i3 += -12;
                     this.i5 += 1;
                  }
                  while(uint(this.i8) > uint(this.i1));
                  
               }
               this.i7 = li32(this.i7);
               this.f0 = lf64(this.i7);
               sf64(this.f0,this.i1);
               this.i7 = li32(this.i7 + 8);
               si32(this.i7,this.i1 + 8);
               this.i1 = li32(this.i6);
               if(this.i1 == 0)
               {
                  break;
               }
               §§goto(addr756);
               break;
            case 7:
               mstate.esp += 12;
               this.i2 = li32(this.i1);
               mstate.esp -= 8;
               this.i3 = -2;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 8:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li8(this.i2);
               this.i5 = this.i2;
               if(this.i4 != 0)
               {
                  this.i4 = this.i2;
                  while(true)
                  {
                     this.i6 = li8(this.i4 + 1);
                     this.i4 += 1;
                     this.i7 = this.i4;
                     if(this.i6 == 0)
                     {
                        break;
                     }
                     this.i4 = this.i7;
                  }
               }
               else
               {
                  this.i4 = this.i5;
               }
               this.i6 = 4;
               mstate.esp -= 12;
               this.i2 = this.i4 - this.i2;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               mstate.esp += 16;
               this.i5 = li32(this.i0 + 8);
               this.i5 += 12;
               si32(this.i5,this.i0 + 8);
               mstate.esp -= 8;
               this.i5 = -1;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 15:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i7 = this.i0 + 8;
               this.i8 = _luaO_nilobject_;
               if(this.i5 != this.i8)
               {
                  this.i5 = li32(this.i5 + 8);
                  if(this.i5 == 5)
                  {
                     this.i1 = -2;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr943:
                     this.i1 = mstate.eax;
                     mstate.esp += 8;
                     this.i3 = li32(this.i7);
                     this.i4 = this.i1;
                     this.i5 = this.i1 + 12;
                     if(uint(this.i5) >= uint(this.i3))
                     {
                        this.i1 = this.i3;
                     }
                     else
                     {
                        this.i1 += 12;
                        this.i3 = this.i4;
                        while(true)
                        {
                           this.f0 = lf64(this.i3 + 12);
                           sf64(this.f0,this.i3);
                           this.i4 = li32(this.i3 + 20);
                           si32(this.i4,this.i3 + 8);
                           this.i3 = li32(this.i7);
                           this.i4 = this.i1 + 12;
                           this.i5 = this.i1;
                           if(uint(this.i4) >= uint(this.i3))
                           {
                              break;
                           }
                           this.i1 = this.i4;
                           this.i3 = this.i5;
                        }
                        this.i1 = this.i3;
                     }
                     this.i3 = -1;
                     this.i1 += -12;
                     si32(this.i1,this.i7);
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr1092:
                     this.i1 = mstate.eax;
                     mstate.esp += 8;
                     this.i3 = li32(this.i7);
                     this.i4 = this.i3;
                     if(uint(this.i3) > uint(this.i1))
                     {
                        this.i5 = 0;
                        do
                        {
                           this.i8 = this.i5 ^ -1;
                           this.i8 *= 12;
                           this.i8 = this.i4 + this.i8;
                           this.f0 = lf64(this.i8);
                           sf64(this.f0,this.i3);
                           this.i9 = li32(this.i8 + 8);
                           si32(this.i9,this.i3 + 8);
                           this.i3 += -12;
                           this.i5 += 1;
                        }
                        while(uint(this.i8) > uint(this.i1));
                        
                     }
                     this.i3 = li32(this.i7);
                     this.f0 = lf64(this.i3);
                     sf64(this.f0,this.i1);
                     this.i3 = li32(this.i3 + 8);
                     si32(this.i3,this.i1 + 8);
                     this.i1 = li32(this.i6);
                     if(this.i1 != 0)
                     {
                        addr756:
                        this.i1 = this.i2;
                        addr763:
                        this.i2 = 0;
                        this.i3 = li32(this.i1 + 4);
                        mstate.esp -= 12;
                        si32(this.i0,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        si32(this.i2,mstate.esp + 8);
                        state = 7;
                        mstate.esp -= 4;
                        FSM_lua_pushcclosure.start();
                        return;
                     }
                     break;
                  }
               }
               this.i5 = -10002;
               this.i8 = li32(this.i7);
               this.i8 += -12;
               si32(this.i8,this.i7);
               mstate.esp -= 16;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 16;
               mstate.esp -= 4;
               FSM_luaL_findtable.start();
               return;
            case 9:
               §§goto(addr943);
            case 10:
               §§goto(addr1092);
            case 11:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i2,mstate.ebp + -32);
               si32(this.i6,mstate.ebp + -24);
               this.i2 = li32(this.i0 + 8);
               mstate.esp -= 16;
               this.i2 += -12;
               this.i4 = mstate.ebp + -32;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i2,mstate.esp + 12);
               state = 12;
               mstate.esp -= 4;
               FSM_luaV_settable.start();
               return;
            case 12:
               mstate.esp += 16;
               this.i2 = li32(this.i0 + 8);
               this.i2 += -12;
               si32(this.i2,this.i0 + 8);
               this.i1 += 8;
               §§goto(addr1365);
            case 13:
               this.i7 = mstate.eax;
               mstate.esp += 12;
               si32(this.i7,mstate.ebp + -48);
               si32(this.i8,mstate.ebp + -40);
               this.i7 = li32(this.i0 + 8);
               mstate.esp -= 16;
               this.i8 = mstate.ebp + -48;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               si32(this.i7,mstate.esp + 12);
               state = 14;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 16:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               if(this.i3 != 0)
               {
                  this.i3 = __2E_str14189332;
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  state = 17;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               addr1801:
               this.i3 = -1;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 17:
               mstate.esp += 12;
               §§goto(addr1801);
            case 18:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i7);
               this.f0 = lf64(this.i3);
               sf64(this.f0,this.i5);
               this.i3 = li32(this.i3 + 8);
               si32(this.i3,this.i5 + 8);
               this.i3 = li32(this.i7);
               this.i3 += 12;
               si32(this.i3,this.i7);
               mstate.esp -= 8;
               this.i3 = -3;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 19:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li8(this.i1);
               if(this.i5 != 0)
               {
                  this.i5 = this.i4;
                  while(true)
                  {
                     this.i8 = li8(this.i5 + 1);
                     this.i5 += 1;
                     this.i9 = this.i5;
                     if(this.i8 == 0)
                     {
                        break;
                     }
                     this.i5 = this.i9;
                  }
               }
               else
               {
                  this.i5 = this.i1;
               }
               this.i8 = 4;
               mstate.esp -= 12;
               this.i4 = this.i5 - this.i4;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            default:
               throw "Invalid state in _luaL_register";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
