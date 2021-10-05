package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_codearith extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 4;
       
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var f2:Number;
      
      public var f3:Number;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public function FSM_codearith()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_codearith = null;
         _loc1_ = new FSM_codearith();
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
               this.i0 = li32(mstate.ebp + 16);
               this.i1 = li32(this.i0);
               this.i2 = li32(mstate.ebp + 8);
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = li32(mstate.ebp + 20);
               this.i5 = this.i0;
               if(this.i1 == 5)
               {
                  this.i1 = li32(this.i0 + 12);
                  if(this.i1 == -1)
                  {
                     this.i1 = li32(this.i0 + 16);
                     if(this.i1 == -1)
                     {
                        this.i1 = li32(this.i4);
                        if(this.i1 == 5)
                        {
                           this.i1 = li32(this.i4 + 12);
                           if(this.i1 == -1)
                           {
                              this.i1 = li32(this.i4 + 16);
                              if(this.i1 == -1)
                              {
                                 this.f1 = lf64(this.i0 + 4);
                                 this.f2 = lf64(this.i4 + 4);
                                 this.i1 = this.i0 + 4;
                                 if(this.i3 <= 15)
                                 {
                                    if(this.i3 <= 13)
                                    {
                                       if(this.i3 != 12)
                                       {
                                          if(this.i3 != 13)
                                          {
                                             addr264:
                                             this.f1 = 0;
                                          }
                                          else
                                          {
                                             this.f0 = 0;
                                             this.f1 -= this.f2;
                                             if(!(this.f1 == Number.NaN || this.f0 == Number.NaN))
                                             {
                                                addr449:
                                                this.f0 = this.f1;
                                                sf64(this.f0,this.i1);
                                                break;
                                             }
                                             §§goto(addr485);
                                          }
                                          §§goto(addr485);
                                       }
                                       else
                                       {
                                          this.f0 = 0;
                                          this.f1 += this.f2;
                                          if(!(this.f1 == Number.NaN || this.f0 == Number.NaN))
                                          {
                                             §§goto(addr449);
                                          }
                                          else
                                          {
                                             §§goto(addr485);
                                          }
                                       }
                                    }
                                    else if(this.i3 != 14)
                                    {
                                       if(this.i3 != 15)
                                       {
                                          §§goto(addr264);
                                       }
                                       else
                                       {
                                          this.f0 = 0;
                                          if(this.f2 != this.f0)
                                          {
                                             this.f0 = 0;
                                             this.f1 /= this.f2;
                                             if(!(this.f1 == Number.NaN || this.f0 == Number.NaN))
                                             {
                                                §§goto(addr449);
                                             }
                                             else
                                             {
                                                §§goto(addr485);
                                             }
                                          }
                                          §§goto(addr485);
                                       }
                                    }
                                    else
                                    {
                                       this.f0 = 0;
                                       this.f1 *= this.f2;
                                       if(!(this.f1 == Number.NaN || this.f0 == Number.NaN))
                                       {
                                          §§goto(addr449);
                                       }
                                       else
                                       {
                                          §§goto(addr485);
                                       }
                                    }
                                    §§goto(addr485);
                                 }
                                 else if(this.i3 <= 17)
                                 {
                                    if(this.i3 != 16)
                                    {
                                       if(this.i3 != 17)
                                       {
                                          §§goto(addr264);
                                       }
                                       else
                                       {
                                          this.f3 = 0;
                                          this.f0 = this.f1;
                                          this.f1 = this.f2;
                                          this.f0 = Math.pow(this.f0,this.f1);
                                          this.f1 = this.f0;
                                          if(!(this.f1 == Number.NaN || this.f3 == Number.NaN))
                                          {
                                             §§goto(addr449);
                                          }
                                          else
                                          {
                                             §§goto(addr485);
                                          }
                                       }
                                    }
                                    else
                                    {
                                       this.f0 = 0;
                                       if(this.f2 != this.f0)
                                       {
                                          this.f3 = 0;
                                          this.f0 = this.f1 / this.f2;
                                          this.f0 = Math.floor(this.f0);
                                          this.f2 = this.f0 * this.f2;
                                          this.f1 -= this.f2;
                                          if(!(this.f1 == Number.NaN || this.f3 == Number.NaN))
                                          {
                                             §§goto(addr449);
                                          }
                                          else
                                          {
                                             §§goto(addr485);
                                          }
                                       }
                                    }
                                    §§goto(addr485);
                                    §§goto(addr281);
                                 }
                                 else
                                 {
                                    if(this.i3 != 18)
                                    {
                                       if(this.i3 != 20)
                                       {
                                          §§goto(addr264);
                                       }
                                       addr281:
                                       this.i1 = 0;
                                       mstate.esp -= 8;
                                       si32(this.i2,mstate.esp);
                                       si32(this.i0,mstate.esp + 4);
                                       state = 2;
                                       mstate.esp -= 4;
                                       FSM_luaK_exp2RK.start();
                                       return;
                                    }
                                    this.f1 = -this.f1;
                                 }
                                 this.f0 = 0;
                                 if(!(this.f1 == Number.NaN || this.f0 == Number.NaN))
                                 {
                                    §§goto(addr449);
                                 }
                              }
                           }
                        }
                     }
                  }
               }
               §§goto(addr485);
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr485);
            case 2:
               this.i6 = mstate.eax;
               mstate.esp += 8;
               this.i0 += 4;
               if(this.i6 > this.i1)
               {
                  this.i7 = li32(this.i5);
                  if(this.i7 == 12)
                  {
                     this.i7 = li32(this.i0);
                     this.i8 = this.i7 & 256;
                     if(this.i8 == 0)
                     {
                        this.i8 = li8(this.i2 + 50);
                        if(this.i8 <= this.i7)
                        {
                           this.i7 = li32(this.i2 + 36);
                           this.i7 += -1;
                           si32(this.i7,this.i2 + 36);
                        }
                     }
                  }
                  this.i7 = li32(this.i4);
                  if(this.i7 == 12)
                  {
                     this.i4 = li32(this.i4 + 4);
                     this.i7 = this.i4 & 256;
                     if(this.i7 == 0)
                     {
                        this.i7 = li8(this.i2 + 50);
                        if(this.i7 <= this.i4)
                        {
                           this.i4 = li32(this.i2 + 36);
                           this.i4 += -1;
                           si32(this.i4,this.i2 + 36);
                        }
                     }
                  }
               }
               else
               {
                  this.i7 = li32(this.i4);
                  if(this.i7 == 12)
                  {
                     this.i4 = li32(this.i4 + 4);
                     this.i7 = this.i4 & 256;
                     if(this.i7 == 0)
                     {
                        this.i7 = li8(this.i2 + 50);
                        if(this.i7 <= this.i4)
                        {
                           this.i4 = li32(this.i2 + 36);
                           this.i4 += -1;
                           si32(this.i4,this.i2 + 36);
                        }
                     }
                  }
                  this.i4 = li32(this.i5);
                  if(this.i4 == 12)
                  {
                     this.i4 = li32(this.i0);
                     this.i7 = this.i4 & 256;
                     if(this.i7 == 0)
                     {
                        this.i7 = li8(this.i2 + 50);
                        if(this.i7 <= this.i4)
                        {
                           this.i4 = li32(this.i2 + 36);
                           this.i4 += -1;
                           si32(this.i4,this.i2 + 36);
                        }
                     }
                  }
               }
               this.i4 = 11;
               this.i7 = li32(this.i2 + 12);
               this.i7 = li32(this.i7 + 8);
               this.i6 <<= 23;
               this.i3 = this.i6 | this.i3;
               this.i1 <<= 14;
               mstate.esp -= 12;
               this.i1 = this.i3 | this.i1;
               si32(this.i2,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaK_code.start();
               return;
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,this.i0);
               si32(this.i4,this.i5);
               break;
            default:
               throw "Invalid state in _codearith";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
