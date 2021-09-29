package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_inclinenumber extends Machine
   {
      
      public static const intRegCount:int = 9;
      
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
      
      public function FSM_inclinenumber()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_inclinenumber = null;
         _loc1_ = new FSM_inclinenumber();
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
               mstate.esp -= 100;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 44);
               this.i2 = li32(this.i1);
               this.i3 = li32(this.i0);
               this.i4 = this.i2 + -1;
               si32(this.i4,this.i1);
               this.i1 = li32(this.i0 + 44);
               this.i4 = this.i0 + 44;
               this.i5 = this.i0;
               if(this.i2 == 0)
               {
                  this.i2 = mstate.ebp + -100;
                  this.i6 = li32(this.i1 + 16);
                  this.i7 = li32(this.i1 + 8);
                  this.i8 = li32(this.i1 + 12);
                  mstate.esp -= 12;
                  si32(this.i6,mstate.esp);
                  si32(this.i8,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 1;
                  mstate.esp -= 4;
                  mstate.funcs[this.i7]();
                  return;
               }
               this.i2 = li32(this.i1 + 4);
               this.i6 = li8(this.i2);
               this.i2 += 1;
               si32(this.i2,this.i1 + 4);
               si32(this.i6,this.i5);
               if(this.i6 != 10)
               {
                  if(this.i6 == 13)
                  {
                     addr124:
                     this.i1 = this.i6;
                     if(this.i1 != this.i3)
                     {
                        this.i1 = li32(this.i4);
                        this.i2 = li32(this.i1);
                        this.i3 = this.i2 + -1;
                        si32(this.i3,this.i1);
                        this.i1 = li32(this.i4);
                        if(this.i2 == 0)
                        {
                           this.i2 = mstate.ebp + -4;
                           this.i3 = li32(this.i1 + 16);
                           this.i4 = li32(this.i1 + 8);
                           this.i6 = li32(this.i1 + 12);
                           mstate.esp -= 12;
                           si32(this.i3,mstate.esp);
                           si32(this.i6,mstate.esp + 4);
                           si32(this.i2,mstate.esp + 8);
                           state = 2;
                           mstate.esp -= 4;
                           mstate.funcs[this.i4]();
                           return;
                        }
                        this.i2 = li32(this.i1 + 4);
                        this.i3 = li8(this.i2);
                        this.i2 += 1;
                        si32(this.i2,this.i1 + 4);
                        si32(this.i3,this.i5);
                     }
                  }
                  addr506:
                  this.i1 = li32(this.i0 + 4);
                  this.i1 += 1;
                  si32(this.i1,this.i0 + 4);
                  this.i2 = this.i0 + 4;
                  if(this.i1 < 2147483645)
                  {
                     break;
                  }
                  this.i1 = 80;
                  this.i3 = li32(this.i0 + 52);
                  this.i4 = li32(this.i0 + 12);
                  mstate.esp -= 12;
                  this.i5 = mstate.ebp + -96;
                  this.i3 += 16;
                  si32(this.i5,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaO_chunkid.start();
                  §§goto(addr600);
               }
               §§goto(addr124);
               break;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i2 != 0)
               {
                  this.i6 = li32(mstate.ebp + -100);
                  if(this.i6 != 0)
                  {
                     this.i6 += -1;
                     si32(this.i6,this.i1);
                     si32(this.i2,this.i1 + 4);
                     this.i6 = li8(this.i2);
                     this.i2 += 1;
                     si32(this.i2,this.i1 + 4);
                     this.i1 = this.i6;
                  }
                  else
                  {
                     addr217:
                     this.i1 = -1;
                  }
                  si32(this.i1,this.i5);
                  if(this.i1 != 10)
                  {
                     if(this.i1 == 13)
                     {
                        §§goto(addr124);
                     }
                     §§goto(addr506);
                  }
                  §§goto(addr124);
               }
               §§goto(addr217);
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i2 != 0)
               {
                  this.i3 = li32(mstate.ebp + -4);
                  if(this.i3 != 0)
                  {
                     this.i3 += -1;
                     si32(this.i3,this.i1);
                     si32(this.i2,this.i1 + 4);
                     this.i3 = li8(this.i2);
                     this.i2 += 1;
                     si32(this.i2,this.i1 + 4);
                     this.i1 = this.i3;
                  }
                  else
                  {
                     addr445:
                     this.i1 = -1;
                  }
                  si32(this.i1,this.i5);
                  §§goto(addr506);
               }
               §§goto(addr445);
            case 3:
               addr600:
               mstate.esp += 12;
               this.i1 = li32(this.i2);
               this.i2 = li32(this.i0 + 40);
               mstate.esp -= 20;
               this.i3 = __2E_str15272;
               this.i6 = __2E_str3747;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               si32(this.i6,mstate.esp + 16);
               state = 4;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 4:
               this.i1 = mstate.eax;
               mstate.esp += 20;
               this.i2 = this.i0 + 40;
               if(this.i4 != 0)
               {
                  this.i3 = this.i4 + -284;
                  if(uint(this.i3) <= uint(2))
                  {
                     this.i4 = 0;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_save.start();
                     return;
                  }
                  this.i3 = __2E_str35292;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_luaX_token2str.start();
                  return;
               }
               this.i0 = 3;
               this.i1 = li32(this.i2);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               addr1001:
               si32(this.i0,mstate.esp + 4);
               §§goto(addr1008);
               break;
            case 5:
               mstate.esp += 8;
               this.i0 = li32(this.i0 + 48);
               this.i0 = li32(this.i0);
               this.i4 = li32(this.i2);
               mstate.esp -= 16;
               this.i3 = __2E_str35292;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = li32(this.i2);
               mstate.esp -= 8;
               this.i1 = 3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               addr1008:
               state = 9;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i2);
               mstate.esp -= 16;
               si32(this.i4,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 8;
               mstate.esp -= 4;
               FSM_luaO_pushfstring.start();
               return;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i2 = li32(this.i2);
               mstate.esp -= 8;
               this.i0 = 3;
               si32(this.i2,mstate.esp);
               §§goto(addr1001);
            case 9:
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _inclinenumber";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
