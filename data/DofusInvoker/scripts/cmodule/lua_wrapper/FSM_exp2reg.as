package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_exp2reg extends Machine
   {
      
      public static const intRegCount:int = 16;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      public var i14:int;
      
      public var i15:int;
      
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
      
      public function FSM_exp2reg()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_exp2reg = null;
         _loc1_ = new FSM_exp2reg();
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
               mstate.esp -= 4;
               this.i0 = li32(mstate.ebp + 8);
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_discharge2reg.start();
               return;
            case 1:
               mstate.esp += 12;
               this.i3 = li32(this.i1);
               this.i4 = this.i1;
               if(this.i3 == 10)
               {
                  this.i3 = li32(this.i1 + 4);
                  mstate.esp -= 12;
                  this.i5 = this.i1 + 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaK_concat.start();
                  return;
               }
               §§goto(addr163);
               break;
            case 2:
               mstate.esp += 12;
               addr163:
               this.i3 = li32(this.i1 + 12);
               this.i5 = li32(this.i1 + 16);
               this.i6 = this.i1 + 16;
               this.i7 = this.i1 + 12;
               if(this.i3 != this.i5)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_need_value.start();
                  addr222:
                  this.i3 = mstate.eax;
                  mstate.esp += 8;
                  if(this.i3 == 0)
                  {
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_need_value.start();
                     addr265:
                     this.i3 = mstate.eax;
                     mstate.esp += 8;
                     if(this.i3 == 0)
                     {
                        this.i3 = -1;
                        this.i5 = this.i3;
                        addr688:
                        this.i8 = li32(this.i0 + 24);
                        si32(this.i8,this.i0 + 28);
                        this.i9 = li32(this.i6);
                        if(this.i9 != -1)
                        {
                           this.i10 = this.i0 + 12;
                           this.i11 = this.i0;
                           addr724:
                           this.i12 = li32(this.i11);
                           this.i12 = li32(this.i12 + 12);
                           this.i13 = this.i9 << 2;
                           this.i13 = this.i12 + this.i13;
                           this.i13 = li32(this.i13);
                           this.i13 >>>= 14;
                           this.i13 += -131071;
                           if(this.i13 == -1)
                           {
                              this.i13 = -1;
                           }
                           else
                           {
                              this.i13 = this.i9 + this.i13;
                              this.i13 += 1;
                           }
                           mstate.esp -= 12;
                           si32(this.i12,mstate.esp);
                           si32(this.i9,mstate.esp + 4);
                           si32(this.i2,mstate.esp + 8);
                           mstate.esp -= 4;
                           FSM_patchtestreg395396.start();
                           this.i12 = mstate.eax;
                           mstate.esp += 12;
                           this.i14 = li32(this.i11);
                           this.i15 = li32(this.i10);
                           this.i14 = li32(this.i14 + 12);
                           if(this.i12 != 0)
                           {
                              mstate.esp -= 16;
                              si32(this.i14,mstate.esp);
                              si32(this.i15,mstate.esp + 4);
                              si32(this.i9,mstate.esp + 8);
                              si32(this.i8,mstate.esp + 12);
                              state = 11;
                              mstate.esp -= 4;
                              FSM_fixjump393394.start();
                              return;
                           }
                           mstate.esp -= 16;
                           si32(this.i14,mstate.esp);
                           si32(this.i15,mstate.esp + 4);
                           si32(this.i9,mstate.esp + 8);
                           si32(this.i5,mstate.esp + 12);
                           state = 12;
                           mstate.esp -= 4;
                           FSM_fixjump393394.start();
                           return;
                        }
                        addr975:
                        this.i5 = li32(this.i7);
                        if(this.i5 != -1)
                        {
                           this.i9 = this.i0 + 12;
                           addr993:
                           this.i10 = li32(this.i0);
                           this.i10 = li32(this.i10 + 12);
                           this.i11 = this.i5 << 2;
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
                              this.i11 = this.i5 + this.i11;
                              this.i11 += 1;
                           }
                           mstate.esp -= 12;
                           si32(this.i10,mstate.esp);
                           si32(this.i5,mstate.esp + 4);
                           si32(this.i2,mstate.esp + 8);
                           mstate.esp -= 4;
                           FSM_patchtestreg395396.start();
                           break;
                        }
                        §§goto(addr1244);
                     }
                  }
                  this.i3 = li32(this.i4);
                  if(this.i3 != 10)
                  {
                     this.i3 = -1;
                     this.i5 = li32(this.i0 + 32);
                     si32(this.i3,this.i0 + 32);
                     this.i3 = li32(this.i0 + 12);
                     this.i3 = li32(this.i3 + 8);
                     mstate.esp -= 12;
                     this.i8 = 2147450902;
                     si32(this.i0,mstate.esp);
                     si32(this.i8,mstate.esp + 4);
                     si32(this.i3,mstate.esp + 8);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaK_code.start();
                     return;
                  }
                  this.i3 = -1;
                  §§goto(addr450);
               }
               §§goto(addr1244);
            case 3:
               §§goto(addr222);
            case 4:
               §§goto(addr265);
            case 9:
               mstate.esp += 12;
               this.i3 = this.i8;
               §§goto(addr688);
            case 11:
               mstate.esp += 16;
               if(this.i13 != -1)
               {
                  addr913:
                  this.i9 = this.i13;
                  §§goto(addr724);
               }
               else
               {
                  §§goto(addr975);
               }
            case 12:
               mstate.esp += 16;
               if(this.i13 == -1)
               {
                  §§goto(addr975);
               }
               else
               {
                  §§goto(addr913);
               }
            case 10:
               §§goto(addr724);
            case 14:
               mstate.esp += 16;
               if(this.i11 != -1)
               {
                  addr1182:
                  this.i5 = this.i11;
                  §§goto(addr993);
               }
               else
               {
                  §§goto(addr1244);
               }
            case 15:
               mstate.esp += 16;
               if(this.i11 == -1)
               {
                  addr1244:
                  this.i0 = -1;
                  si32(this.i0,this.i7);
                  si32(this.i0,this.i6);
                  si32(this.i2,this.i1 + 4);
                  this.i0 = 12;
                  si32(this.i0,this.i4);
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  mstate.gworker = caller;
                  return;
               }
               §§goto(addr1182);
            case 13:
               break;
            case 5:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -4);
               mstate.esp -= 12;
               this.i3 = mstate.ebp + -4;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            case 6:
               mstate.esp += 12;
               this.i3 = li32(mstate.ebp + -4);
               addr450:
               this.i5 = li32(this.i0 + 24);
               si32(this.i5,this.i0 + 28);
               this.i5 = li32(this.i0 + 12);
               this.i5 = li32(this.i5 + 8);
               this.i8 = this.i2 << 6;
               mstate.esp -= 12;
               this.i9 = this.i8 | 16386;
               si32(this.i0,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 7:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               this.i9 = li32(this.i0 + 24);
               si32(this.i9,this.i0 + 28);
               this.i9 = li32(this.i0 + 12);
               this.i9 = li32(this.i9 + 8);
               mstate.esp -= 12;
               this.i8 |= 8388610;
               si32(this.i0,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i9,mstate.esp + 8);
               state = 8;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 8:
               this.i8 = mstate.eax;
               mstate.esp += 12;
               this.i9 = li32(this.i0 + 24);
               si32(this.i9,this.i0 + 28);
               mstate.esp -= 12;
               this.i9 = this.i0 + 32;
               si32(this.i0,mstate.esp);
               si32(this.i9,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 9;
               mstate.esp -= 4;
               FSM_luaK_concat.start();
               return;
            default:
               throw "Invalid state in _exp2reg";
         }
         this.i10 = mstate.eax;
         mstate.esp += 12;
         this.i12 = li32(this.i0);
         this.i13 = li32(this.i9);
         this.i12 = li32(this.i12 + 12);
         if(this.i10 != 0)
         {
            mstate.esp -= 16;
            si32(this.i12,mstate.esp);
            si32(this.i13,mstate.esp + 4);
            si32(this.i5,mstate.esp + 8);
            si32(this.i8,mstate.esp + 12);
            state = 14;
            mstate.esp -= 4;
            FSM_fixjump393394.start();
            return;
         }
         mstate.esp -= 16;
         si32(this.i12,mstate.esp);
         si32(this.i13,mstate.esp + 4);
         si32(this.i5,mstate.esp + 8);
         si32(this.i3,mstate.esp + 12);
         state = 15;
         mstate.esp -= 4;
         FSM_fixjump393394.start();
      }
   }
}
