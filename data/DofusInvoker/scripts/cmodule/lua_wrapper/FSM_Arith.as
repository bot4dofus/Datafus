package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_Arith extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 3;
       
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var f2:Number;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public function FSM_Arith()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_Arith = null;
         _loc1_ = new FSM_Arith();
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
               mstate.esp -= 80;
               this.i0 = li32(mstate.ebp + 16);
               this.i1 = li32(this.i0 + 8);
               this.i2 = this.i0 + 8;
               this.i3 = li32(mstate.ebp + 8);
               this.i4 = li32(mstate.ebp + 12);
               this.i5 = li32(mstate.ebp + 20);
               this.i6 = li32(mstate.ebp + 24);
               if(this.i1 == 4)
               {
                  this.i1 = mstate.ebp + -48;
                  this.i7 = li32(this.i0);
                  mstate.esp -= 8;
                  this.i7 += 16;
                  si32(this.i7,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaO_str2d.start();
                  return;
               }
               if(this.i1 == 3)
               {
                  this.i1 = this.i0;
               }
               else
               {
                  this.i1 = 0;
               }
               addr164:
               if(this.i1 != 0)
               {
                  this.i7 = li32(this.i5 + 8);
                  if(this.i7 == 4)
                  {
                     this.i7 = mstate.ebp + -40;
                     this.i8 = li32(this.i5);
                     mstate.esp -= 8;
                     this.i8 += 16;
                     si32(this.i8,mstate.esp);
                     si32(this.i7,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaO_str2d.start();
                     return;
                  }
                  if(this.i7 == 3)
                  {
                     this.i7 = this.i5;
                  }
                  else
                  {
                     this.i7 = 0;
                  }
                  addr266:
                  if(this.i7 != 0)
                  {
                     this.f1 = lf64(this.i1);
                     this.f2 = lf64(this.i7);
                     if(this.i6 <= 7)
                     {
                        if(this.i6 != 5)
                        {
                           if(this.i6 != 6)
                           {
                              if(this.i6 == 7)
                              {
                                 this.i0 = 3;
                                 this.f1 *= this.f2;
                                 addr401:
                                 sf64(this.f1,this.i4);
                                 addr406:
                                 si32(this.i0,this.i4 + 8);
                              }
                              §§goto(addr416);
                           }
                           else
                           {
                              this.i0 = 3;
                              addr392:
                              this.f1 -= this.f2;
                           }
                        }
                        else
                        {
                           this.i0 = 3;
                           this.f1 += this.f2;
                        }
                     }
                     else
                     {
                        if(this.i6 <= 9)
                        {
                           if(this.i6 != 8)
                           {
                              if(this.i6 == 9)
                              {
                                 this.i0 = 3;
                                 this.f0 = this.f1 / this.f2;
                                 this.f0 = Math.floor(this.f0);
                                 this.f2 = this.f0 * this.f2;
                                 §§goto(addr392);
                              }
                              §§goto(addr416);
                           }
                           else
                           {
                              this.i0 = 3;
                              this.f1 /= this.f2;
                           }
                        }
                        else
                        {
                           if(this.i6 != 10)
                           {
                              if(this.i6 == 11)
                              {
                                 this.i0 = 3;
                                 this.f0 = -this.f1;
                                 sf64(this.f0,this.i4);
                                 §§goto(addr406);
                              }
                              addr416:
                              mstate.esp = mstate.ebp;
                              mstate.ebp = li32(mstate.esp);
                              mstate.esp += 4;
                              mstate.esp += 4;
                              mstate.gworker = caller;
                              return;
                           }
                           this.i0 = 3;
                           this.f0 = this.f1;
                           this.f1 = this.f2;
                           this.f0 = Math.pow(this.f0,this.f1);
                           this.f1 = this.f0;
                           addr400:
                           §§goto(addr401);
                        }
                        §§goto(addr401);
                     }
                     §§goto(addr401);
                  }
               }
               mstate.esp -= 12;
               si32(this.i3,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_luaT_gettmbyobj.start();
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               if(this.i1 == 0)
               {
                  this.i1 = 0;
               }
               else
               {
                  this.i1 = 3;
                  this.f0 = lf64(mstate.ebp + -48);
                  sf64(this.f0,mstate.ebp + -64);
                  si32(this.i1,mstate.ebp + -56);
                  this.i1 = mstate.ebp + -64;
               }
               §§goto(addr164);
            case 2:
               this.i7 = mstate.eax;
               mstate.esp += 8;
               if(this.i7 == 0)
               {
                  this.i7 = 0;
               }
               else
               {
                  this.i7 = 3;
                  this.f0 = lf64(mstate.ebp + -40);
                  sf64(this.f0,mstate.ebp + -80);
                  si32(this.i7,mstate.ebp + -72);
                  this.i7 = mstate.ebp + -80;
               }
               §§goto(addr266);
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               this.i7 = li32(this.i1 + 8);
               if(this.i7 != 0)
               {
                  this.i6 = this.i1;
               }
               else
               {
                  mstate.esp -= 12;
                  si32(this.i3,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_luaT_gettmbyobj.start();
                  addr571:
                  this.i6 = mstate.eax;
                  mstate.esp += 12;
               }
               this.i1 = this.i6;
               this.i6 = li32(this.i1 + 8);
               if(this.i6 != 0)
               {
                  mstate.esp -= 20;
                  si32(this.i3,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  si32(this.i0,mstate.esp + 12);
                  si32(this.i5,mstate.esp + 16);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_callTMres.start();
                  return;
               }
               this.i1 = li32(this.i2);
               if(this.i1 != 4)
               {
                  if(this.i1 == 3)
                  {
                     this.i1 = this.i0;
                     break;
                  }
                  this.i1 = 0;
                  break;
               }
               this.i1 = mstate.ebp + -8;
               this.i2 = li32(this.i0);
               mstate.esp -= 8;
               this.i2 += 16;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 6;
               mstate.esp -= 4;
               FSM_luaO_str2d.start();
               return;
            case 4:
               §§goto(addr571);
            case 5:
               mstate.esp += 20;
               addr414:
               §§goto(addr401);
            case 6:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               if(this.i1 == 0)
               {
                  this.i1 = 0;
                  break;
               }
               this.i1 = 3;
               this.f0 = lf64(mstate.ebp + -8);
               sf64(this.f0,mstate.ebp + -32);
               si32(this.i1,mstate.ebp + -24);
               this.i1 = mstate.ebp + -32;
               break;
            case 7:
               mstate.esp += 12;
               §§goto(addr414);
            default:
               throw "Invalid state in _Arith";
         }
         this.i2 = __2E_str20277;
         mstate.esp -= 12;
         this.i0 = this.i1 == 0 ? int(this.i0) : int(this.i5);
         si32(this.i3,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         state = 7;
         mstate.esp -= 4;
         FSM_luaG_typeerror.start();
      }
   }
}
