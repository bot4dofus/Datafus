package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_breakstat extends Machine
   {
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_breakstat()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_breakstat = null;
         _loc1_ = new FSM_breakstat();
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
               mstate.esp -= 96;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 36);
               this.i2 = li32(this.i1 + 20);
               if(this.i2 != 0)
               {
                  this.i3 = 0;
                  do
                  {
                     this.i4 = li8(this.i2 + 10);
                     if(this.i4 != 0)
                     {
                        break;
                     }
                     this.i4 = li8(this.i2 + 9);
                     this.i2 = li32(this.i2);
                     this.i3 = this.i4 | this.i3;
                  }
                  while(this.i2 != 0);
                  
               }
               else
               {
                  this.i3 = 0;
               }
               if(this.i2 != 0)
               {
                  break;
               }
               this.i4 = 80;
               this.i5 = li32(this.i0 + 52);
               this.i6 = li32(this.i0 + 12);
               mstate.esp -= 12;
               this.i7 = mstate.ebp + -96;
               this.i5 += 16;
               si32(this.i7,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaO_chunkid.start();
            case 1:
               mstate.esp += 12;
               this.i4 = li32(this.i0 + 4);
               this.i5 = li32(this.i0 + 40);
               mstate.esp -= 20;
               this.i8 = __2E_str15272;
               this.i9 = __2E_str9104;
               si32(this.i5,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               si32(this.i9,mstate.esp + 16);
               state = 2;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 2:
               this.i4 = mstate.eax;
               mstate.esp += 20;
               this.i5 = this.i0 + 40;
               if(this.i6 != 0)
               {
                  this.i7 = this.i6 + -284;
                  if(uint(this.i7) <= uint(2))
                  {
                     this.i6 = 0;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i6,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_save.start();
                     return;
                  }
                  this.i7 = __2E_str35292;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_luaX_token2str.start();
                  return;
               }
               this.i0 = 3;
               this.i4 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i4,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
               break;
            case 3:
               mstate.esp += 8;
               this.i0 = li32(this.i0 + 48);
               this.i0 = li32(this.i0);
               this.i6 = li32(this.i5);
               mstate.esp -= 16;
               this.i7 = __2E_str35292;
               si32(this.i6,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = li32(this.i5);
               mstate.esp -= 8;
               this.i4 = 3;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 5:
               mstate.esp += 8;
               break;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i6 = li32(this.i5);
               mstate.esp -= 16;
               si32(this.i6,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 7;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i5 = li32(this.i5);
               mstate.esp -= 8;
               this.i0 = 3;
               si32(this.i5,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 8;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 8:
               mstate.esp += 8;
               break;
            case 9:
               mstate.esp += 8;
               break;
            case 10:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(this.i1 + 32);
               si32(this.i0,this.i1 + 32);
               this.i0 = li32(this.i1 + 12);
               this.i0 = li32(this.i0 + 8);
               mstate.esp -= 12;
               this.i4 = 2147450902;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 11;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 11:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,mstate.ebp + -4);
               mstate.esp -= 12;
               this.i0 = mstate.ebp + -4;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 12:
               mstate.esp += 12;
               this.i0 = li32(mstate.ebp + -4);
               §§goto(addr1022);
            case 13:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,mstate.ebp + -8);
               mstate.esp -= 12;
               this.i0 = mstate.ebp + -8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 14:
               mstate.esp += 12;
               this.i0 = li32(mstate.ebp + -8);
               addr1022:
               mstate.esp -= 12;
               this.i2 += 4;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 15;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 15:
               mstate.esp += 12;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _breakstat";
         }
         if(this.i3 != 0)
         {
            this.i0 = -1;
            this.i3 = li32(this.i1 + 12);
            this.i4 = li8(this.i2 + 8);
            this.i3 = li32(this.i3 + 8);
            this.i4 <<= 6;
            mstate.esp -= 12;
            this.i4 |= 35;
            si32(this.i1,mstate.esp);
            si32(this.i4,mstate.esp + 4);
            si32(this.i3,mstate.esp + 8);
            state = 10;
            mstate.esp -= 4;
            FSM_luaK_code.start();
            return;
         }
         this.i0 = -1;
         this.i3 = li32(this.i1 + 32);
         si32(this.i0,this.i1 + 32);
         this.i0 = li32(this.i1 + 12);
         this.i0 = li32(this.i0 + 8);
         mstate.esp -= 12;
         this.i4 = 2147450902;
         si32(this.i1,mstate.esp);
         si32(this.i4,mstate.esp + 4);
         si32(this.i0,mstate.esp + 8);
         state = 13;
         mstate.esp -= 4;
         FSM_luaK_code.start();
      }
   }
}
