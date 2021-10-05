package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_g_write extends Machine
   {
      
      public static const intRegCount:int = 15;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var f0:Number;
      
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
      
      public function FSM_g_write()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_g_write = null;
         _loc1_ = new FSM_g_write();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop4:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 36;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 8);
               this.i2 = li32(this.i0 + 12);
               this.i1 -= this.i2;
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = this.i1 + -12;
               if(uint(this.i4) <= uint(11))
               {
                  this.i1 = 1;
                  this.i2 = 0;
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_pushresult.start();
                  return;
               }
               this.i4 = mstate.ebp + -32;
               this.i5 = mstate.ebp + -8;
               this.i1 /= 12;
               this.i6 = 1;
               this.i7 = 0;
               this.i8 = this.i2 + 56;
               this.i9 = this.i4 + 4;
               this.i10 = this.i4 + 8;
               this.i11 = this.i5 + 4;
               this.i1 += -1;
               while(true)
               {
                  this.i12 = _luaO_nilobject_;
                  mstate.esp -= 8;
                  this.i13 = this.i3 + this.i7;
                  si32(this.i0,mstate.esp);
                  si32(this.i13,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               addr143:
               break;
            case 3:
               this.i6 = mstate.eax;
               mstate.esp += 16;
               if(this.i6 >= 1)
               {
                  addr322:
                  this.i6 = 1;
                  break;
               }
               while(true)
               {
                  this.i6 = 0;
                  break loop4;
               }
               addr218:
               break;
            case 4:
               this.i12 = mstate.eax;
               mstate.esp += 12;
               if(this.i6 != 0)
               {
                  this.i6 = mstate.ebp + -8;
                  this.i13 = li32(mstate.ebp + -36);
                  si32(this.i12,this.i5);
                  si32(this.i13,this.i11);
                  si32(this.i13,this.i10);
                  si32(this.i6,this.i4);
                  this.i6 = 1;
                  si32(this.i6,this.i9);
                  this.i6 = li32(this.i8);
                  this.i12 = li32(this.i6 + 16);
                  this.i6 += 16;
                  if(this.i12 == 0)
                  {
                     this.i12 = -1;
                     si32(this.i12,this.i6);
                  }
                  this.i6 = mstate.ebp + -32;
                  mstate.esp -= 8;
                  si32(this.i2,mstate.esp);
                  si32(this.i6,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM___sfvwrite.start();
                  return;
               }
               addr541:
               this.i6 = 0;
               break;
            case 5:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               if(this.i6 == 0)
               {
                  this.i6 = this.i13;
               }
               else
               {
                  this.i6 = li32(this.i10);
                  this.i6 = this.i13 - this.i6;
               }
               this.i12 = li32(mstate.ebp + -36);
               if(this.i6 != this.i12)
               {
                  §§goto(addr541);
               }
               else
               {
                  §§goto(addr322);
               }
            case 1:
               while(true)
               {
                  this.i14 = mstate.eax;
                  mstate.esp += 8;
                  if(this.i14 != this.i12)
                  {
                     this.i12 = li32(this.i14 + 8);
                     if(this.i12 != 3)
                     {
                        break;
                     }
                     if(this.i6 != 0)
                     {
                        this.i6 = __2E_str1166;
                        mstate.esp -= 8;
                        si32(this.i0,mstate.esp);
                        si32(this.i13,mstate.esp + 4);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_lua_tonumber.start();
                        return;
                     }
                     §§goto(addr218);
                  }
                  break;
                  §§goto(addr143);
               }
               this.i12 = mstate.ebp + -36;
               mstate.esp -= 12;
               si32(this.i0,mstate.esp);
               si32(this.i13,mstate.esp + 4);
               si32(this.i12,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 2:
               this.f0 = mstate.st0;
               mstate.esp += 8;
               mstate.esp -= 16;
               si32(this.i2,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               sf64(this.f0,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_fprintf.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _g_write";
         }
         continue loop3;
      }
   }
}
