package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_auxupvalue extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_auxupvalue()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_auxupvalue = null;
         _loc1_ = new FSM_auxupvalue();
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
               mstate.esp -= 8;
               this.i0 = 2;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checkinteger.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = _luaO_nilobject_;
               if(this.i2 != this.i4)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 == 6)
                  {
                     addr196:
                     this.i2 = 1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     this.i2 = mstate.eax;
                     mstate.esp += 8;
                     this.i4 = li32(this.i2 + 8);
                     if(this.i4 == 6)
                     {
                        this.i2 = li32(this.i2);
                        this.i2 = li8(this.i2 + 6);
                        if(this.i2 == 0)
                        {
                           addr267:
                           this.i2 = _luaO_nilobject_;
                           this.i4 = li32(this.i1 + 12);
                           this.i5 = li32(this.i1 + 8);
                           this.i2 = uint(this.i5) > uint(this.i4) ? int(this.i4) : int(this.i2);
                           this.i4 = this.i1 + 8;
                           if(this.i3 != 0)
                           {
                              this.i5 = mstate.ebp + -4;
                              mstate.esp -= 12;
                              si32(this.i2,mstate.esp);
                              si32(this.i0,mstate.esp + 4);
                              si32(this.i5,mstate.esp + 8);
                              mstate.esp -= 4;
                              FSM_aux_upvalue.start();
                              addr354:
                              this.i0 = mstate.eax;
                              mstate.esp += 12;
                              if(this.i0 != 0)
                              {
                                 this.i2 = li32(mstate.ebp + -4);
                                 this.i5 = li32(this.i4);
                                 this.f0 = lf64(this.i2);
                                 sf64(this.f0,this.i5);
                                 this.i2 = li32(this.i2 + 8);
                                 si32(this.i2,this.i5 + 8);
                                 this.i2 = li32(this.i4);
                                 this.i2 += 12;
                                 si32(this.i2,this.i4);
                                 §§goto(addr685);
                              }
                           }
                           else
                           {
                              this.i5 = mstate.ebp + -8;
                              mstate.esp -= 12;
                              si32(this.i2,mstate.esp);
                              si32(this.i0,mstate.esp + 4);
                              si32(this.i5,mstate.esp + 8);
                              mstate.esp -= 4;
                              FSM_aux_upvalue.start();
                              addr462:
                              this.i0 = mstate.eax;
                              mstate.esp += 12;
                              if(this.i0 != 0)
                              {
                                 this.i5 = li32(this.i4);
                                 this.i6 = this.i5 + -12;
                                 si32(this.i6,this.i4);
                                 this.i6 = li32(mstate.ebp + -8);
                                 this.f0 = lf64(this.i5 + -12);
                                 sf64(this.f0,this.i6);
                                 this.i5 = li32(this.i5 + -4);
                                 si32(this.i5,this.i6 + 8);
                                 this.i4 = li32(this.i4);
                                 this.i5 = li32(this.i4 + 8);
                                 if(this.i5 >= 4)
                                 {
                                    this.i4 = li32(this.i4);
                                    this.i5 = li8(this.i4 + 5);
                                    this.i5 &= 3;
                                    if(this.i5 != 0)
                                    {
                                       this.i2 = li32(this.i2);
                                       this.i5 = li8(this.i2 + 5);
                                       this.i2 += 5;
                                       this.i6 = this.i5 & 4;
                                       if(this.i6 != 0)
                                       {
                                          this.i6 = li32(this.i1 + 16);
                                          this.i7 = li8(this.i6 + 21);
                                          if(this.i7 == 1)
                                          {
                                             mstate.esp -= 8;
                                             si32(this.i6,mstate.esp);
                                             si32(this.i4,mstate.esp + 4);
                                             mstate.esp -= 4;
                                             FSM_reallymarkobject.start();
                                             addr642:
                                             mstate.esp += 8;
                                          }
                                          else
                                          {
                                             this.i4 = li8(this.i6 + 20);
                                             this.i5 &= -8;
                                             this.i4 &= 3;
                                             this.i4 |= this.i5;
                                             si8(this.i4,this.i2);
                                          }
                                       }
                                    }
                                 }
                                 if(this.i0 != 0)
                                 {
                                    addr685:
                                    mstate.esp -= 8;
                                    si32(this.i1,mstate.esp);
                                    si32(this.i0,mstate.esp + 4);
                                    state = 8;
                                    mstate.esp -= 4;
                                    FSM_lua_pushstring.start();
                                    return;
                                 }
                              }
                           }
                        }
                        this.i0 = 0;
                        break;
                     }
                     §§goto(addr267);
                  }
               }
               this.i2 = 6;
               mstate.esp -= 12;
               this.i4 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_tag_error.start();
               return;
            case 3:
               mstate.esp += 12;
               §§goto(addr196);
            case 4:
               §§goto(addr196);
            case 6:
               §§goto(addr462);
            case 7:
               §§goto(addr642);
            case 5:
               §§goto(addr354);
            case 8:
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i0 = this.i3 ^ -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 8);
               this.i1 += 8;
               this.i4 = this.i2;
               if(uint(this.i2) > uint(this.i0))
               {
                  this.i5 = 0;
                  do
                  {
                     this.i6 = this.i5 ^ -1;
                     this.i6 *= 12;
                     this.i6 = this.i4 + this.i6;
                     this.f0 = lf64(this.i6);
                     sf64(this.f0,this.i2);
                     this.i7 = li32(this.i6 + 8);
                     si32(this.i7,this.i2 + 8);
                     this.i2 += -12;
                     this.i5 += 1;
                  }
                  while(uint(this.i6) > uint(this.i0));
                  
               }
               this.i1 = li32(this.i1);
               this.f0 = lf64(this.i1);
               sf64(this.f0,this.i0);
               this.i1 = li32(this.i1 + 8);
               si32(this.i1,this.i0 + 8);
               this.i0 = this.i3 + 1;
               break;
            default:
               throw "Invalid state in _auxupvalue";
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
