package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_io_type extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_io_type()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_io_type = null;
         _loc1_ = new FSM_io_type();
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
               mstate.esp -= 16;
               this.i0 = 1;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 != -1)
                  {
                     §§goto(addr147);
                  }
               }
               this.i0 = __2E_str11186329;
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 2:
               mstate.esp += 12;
               addr147:
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr177);
            case 3:
               addr177:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i0 + 8);
               if(this.i2 != 2)
               {
                  if(this.i2 != 7)
                  {
                     this.i0 = 0;
                  }
                  else
                  {
                     this.i0 = li32(this.i0);
                     this.i0 += 20;
                  }
               }
               else
               {
                  this.i0 = li32(this.i0);
               }
               this.i2 = -10000;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               §§goto(addr255);
            case 4:
               addr255:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = __2E_str17320;
               while(true)
               {
                  this.i4 = li8(this.i3 + 1);
                  this.i3 += 1;
                  this.i5 = this.i3;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i3 = this.i5;
               }
               this.i4 = __2E_str17320;
               mstate.esp -= 12;
               this.i3 -= this.i4;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 5:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               si32(this.i3,mstate.ebp + -16);
               this.i3 = 4;
               si32(this.i3,mstate.ebp + -8);
               this.i3 = li32(this.i1 + 8);
               mstate.esp -= 16;
               this.i4 = mstate.ebp + -16;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 6:
               mstate.esp += 16;
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               this.i2 = this.i1 + 8;
               if(this.i0 != 0)
               {
                  this.i3 = 1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_lua_getmetatable.start();
                  addr499:
                  this.i3 = mstate.eax;
                  mstate.esp += 8;
                  if(this.i3 != 0)
                  {
                     this.i3 = -2;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr544:
                     this.i3 = mstate.eax;
                     mstate.esp += 8;
                     mstate.esp -= 8;
                     this.i4 = -1;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     this.i4 = mstate.eax;
                     mstate.esp += 8;
                     this.i5 = _luaO_nilobject_;
                     if(this.i4 != this.i5)
                     {
                        this.i5 = _luaO_nilobject_;
                        if(this.i3 != this.i5)
                        {
                           mstate.esp -= 8;
                           si32(this.i3,mstate.esp);
                           si32(this.i4,mstate.esp + 4);
                           mstate.esp -= 4;
                           FSM_luaO_rawequalObj.start();
                           addr641:
                           this.i3 = mstate.eax;
                           mstate.esp += 8;
                           if(this.i3 != 0)
                           {
                              this.i3 = li32(this.i1 + 16);
                              this.i0 = li32(this.i0);
                              this.i4 = li32(this.i3 + 68);
                              this.i3 = li32(this.i3 + 64);
                              if(this.i0 == 0)
                              {
                                 if(uint(this.i4) >= uint(this.i3))
                                 {
                                    mstate.esp -= 4;
                                    si32(this.i1,mstate.esp);
                                    state = 11;
                                    mstate.esp -= 4;
                                    FSM_luaC_step.start();
                                    return;
                                 }
                                 §§goto(addr796);
                              }
                              else
                              {
                                 if(uint(this.i4) >= uint(this.i3))
                                 {
                                    mstate.esp -= 4;
                                    si32(this.i1,mstate.esp);
                                    state = 13;
                                    mstate.esp -= 4;
                                    FSM_luaC_step.start();
                                    return;
                                 }
                                 §§goto(addr935);
                              }
                           }
                        }
                     }
                  }
               }
               this.i0 = 0;
               this.i1 = li32(this.i2);
               si32(this.i0,this.i1 + 8);
               addr674:
               this.i0 = li32(this.i2);
               this.i0 += 12;
               si32(this.i0,this.i2);
               this.i0 = 1;
               mstate.eax = this.i0;
               break;
            case 7:
               §§goto(addr499);
            case 8:
               §§goto(addr544);
            case 9:
               §§goto(addr544);
            case 10:
               §§goto(addr641);
            case 11:
               mstate.esp += 4;
               addr796:
               this.i3 = __2E_str18321;
               this.i4 = li32(this.i2);
               mstate.esp -= 12;
               this.i0 = 11;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 12;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 12:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i4);
               this.i1 = 4;
               si32(this.i1,this.i4 + 8);
               this.i1 = li32(this.i2);
               this.i1 += 12;
               si32(this.i1,this.i2);
               this.i1 = 1;
               mstate.eax = this.i1;
               break;
            case 13:
               mstate.esp += 4;
               addr935:
               this.i0 = __2E_str19322;
               this.i3 = li32(this.i2);
               mstate.esp -= 12;
               this.i4 = 4;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 14;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 14:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               si32(this.i0,this.i3);
               si32(this.i4,this.i3 + 8);
               §§goto(addr674);
            default:
               throw "Invalid state in _io_type";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
