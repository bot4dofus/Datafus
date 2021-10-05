package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaB_cocreate extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public function FSM_luaB_cocreate()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_cocreate = null;
         _loc1_ = new FSM_luaB_cocreate();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop2:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 16);
               this.i2 = li32(this.i1 + 68);
               this.i1 = li32(this.i1 + 64);
               this.i3 = this.i0 + 16;
               if(uint(this.i2) >= uint(this.i1))
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaC_step.start();
                  return;
               }
               §§goto(addr100);
               break;
            case 1:
               mstate.esp += 4;
               addr100:
               this.i1 = 112;
               this.i2 = li32(this.i3);
               this.i4 = li32(this.i2 + 12);
               this.i5 = li32(this.i2 + 16);
               mstate.esp -= 16;
               this.i6 = 0;
               si32(this.i5,mstate.esp);
               si32(this.i6,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 2;
               mstate.esp -= 4;
               mstate.funcs[this.i4]();
               return;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               if(this.i1 == 0)
               {
                  this.i4 = 4;
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaD_throw.start();
                  return;
               }
               §§goto(addr231);
               break;
            case 3:
               mstate.esp += 8;
               addr231:
               this.i4 = 8;
               this.i5 = li32(this.i2 + 68);
               this.i5 += 112;
               si32(this.i5,this.i2 + 68);
               this.i2 = li32(this.i3);
               this.i5 = li32(this.i2 + 28);
               si32(this.i5,this.i1);
               si32(this.i1,this.i2 + 28);
               this.i2 = li8(this.i2 + 20);
               this.i2 &= 3;
               si8(this.i2,this.i1 + 5);
               si8(this.i4,this.i1 + 4);
               this.i2 = li32(this.i3);
               si32(this.i2,this.i1 + 16);
               this.i2 = 0;
               si32(this.i2,this.i1 + 32);
               si32(this.i2,this.i1 + 44);
               si32(this.i2,this.i1 + 104);
               si32(this.i2,this.i1 + 68);
               si8(this.i2,this.i1 + 56);
               si32(this.i2,this.i1 + 60);
               this.i3 = 1;
               si8(this.i3,this.i1 + 57);
               this.i5 = li32(this.i1 + 60);
               si32(this.i5,this.i1 + 64);
               si32(this.i2,this.i1 + 96);
               si32(this.i2,this.i1 + 48);
               si16(this.i2,this.i1 + 54);
               si16(this.i2,this.i1 + 52);
               si8(this.i2,this.i1 + 6);
               si32(this.i2,this.i1 + 20);
               si32(this.i2,this.i1 + 40);
               si32(this.i2,this.i1 + 24);
               si32(this.i2,this.i1 + 108);
               si32(this.i2,this.i1 + 80);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_stack_init.start();
               return;
            case 4:
               mstate.esp += 8;
               this.f0 = lf64(this.i0 + 72);
               sf64(this.f0,this.i1 + 72);
               this.i2 = li32(this.i0 + 80);
               si32(this.i2,this.i1 + 80);
               this.i2 = li8(this.i0 + 56);
               si8(this.i2,this.i1 + 56);
               this.i2 = li32(this.i0 + 60);
               si32(this.i2,this.i1 + 60);
               this.i5 = li32(this.i0 + 68);
               si32(this.i5,this.i1 + 68);
               si32(this.i2,this.i1 + 64);
               this.i2 = li32(this.i0 + 8);
               si32(this.i1,this.i2);
               si32(this.i4,this.i2 + 8);
               this.i2 = li32(this.i0 + 8);
               this.i2 += 12;
               si32(this.i2,this.i0 + 8);
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = this.i0 + 8;
               this.i4 = _luaO_nilobject_;
               if(this.i2 != this.i4)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 == 6)
                  {
                     this.i2 = 1;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr705:
                     this.i2 = mstate.eax;
                     mstate.esp += 8;
                     this.i4 = li32(this.i2 + 8);
                     if(this.i4 == 6)
                     {
                        this.i2 = li32(this.i2);
                        this.i2 = li8(this.i2 + 6);
                        if(this.i2 != 0)
                        {
                           §§goto(addr745);
                        }
                     }
                     this.i2 = 1;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr1008:
                     this.i2 = mstate.eax;
                     mstate.esp += 8;
                     this.i4 = li32(this.i3);
                     this.f0 = lf64(this.i2);
                     sf64(this.f0,this.i4);
                     this.i2 = li32(this.i2 + 8);
                     si32(this.i2,this.i4 + 8);
                     this.i2 = li32(this.i3);
                     this.i4 = this.i2 + 12;
                     si32(this.i4,this.i3);
                     if(this.i1 != this.i0)
                     {
                        this.i0 = 0;
                        si32(this.i2,this.i3);
                        this.i1 += 8;
                        this.i2 = this.i0;
                        while(true)
                        {
                           this.i4 = li32(this.i1);
                           this.i5 = li32(this.i3);
                           this.i6 = this.i4 + 12;
                           si32(this.i6,this.i1);
                           this.i5 += this.i2;
                           this.f0 = lf64(this.i5);
                           sf64(this.f0,this.i4);
                           this.i5 = li32(this.i5 + 8);
                           si32(this.i5,this.i4 + 8);
                           this.i2 += 12;
                           this.i4 = this.i0 + 1;
                           if(this.i0 == 0)
                           {
                              break;
                           }
                           this.i0 = this.i4;
                        }
                     }
                     break;
                  }
               }
               addr745:
               this.i2 = __2E_str67356;
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 7;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 6:
               §§goto(addr705);
            case 9:
               §§goto(addr1008);
            case 7:
               mstate.esp += 12;
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 8:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i3);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i4);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i4 + 8);
               this.i2 = li32(this.i3);
               this.i4 = this.i2 + 12;
               si32(this.i4,this.i3);
               if(this.i1 != this.i0)
               {
                  this.i0 = 0;
                  si32(this.i2,this.i3);
                  this.i1 += 8;
                  this.i2 = this.i0;
                  while(true)
                  {
                     this.i4 = li32(this.i1);
                     this.i5 = li32(this.i3);
                     this.i6 = this.i4 + 12;
                     si32(this.i6,this.i1);
                     this.i5 += this.i2;
                     this.f0 = lf64(this.i5);
                     sf64(this.f0,this.i4);
                     this.i5 = li32(this.i5 + 8);
                     si32(this.i5,this.i4 + 8);
                     this.i2 += 12;
                     this.i4 = this.i0 + 1;
                     if(this.i0 == 0)
                     {
                        break loop2;
                     }
                     this.i0 = this.i4;
                  }
                  break;
               }
               break;
            default:
               throw "Invalid state in _luaB_cocreate";
         }
         this.i0 = 1;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
