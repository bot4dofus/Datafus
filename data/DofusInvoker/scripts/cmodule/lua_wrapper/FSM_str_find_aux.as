package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_str_find_aux extends Machine
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
      
      public function FSM_str_find_aux()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_str_find_aux = null;
         _loc1_ = new FSM_str_find_aux();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop5:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 288;
               this.i0 = mstate.ebp + -4;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i2 = mstate.ebp + -8;
               this.i3 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(mstate.ebp + -4);
               mstate.esp -= 8;
               this.i4 = 3;
               si32(this.i1,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(mstate.ebp + 12);
               this.i6 = this.i2;
               this.i7 = this.i0;
               this.i8 = _luaO_nilobject_;
               if(this.i4 != this.i8)
               {
                  this.i4 = li32(this.i4 + 8);
                  if(this.i4 >= 1)
                  {
                     this.i4 = 3;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     state = 4;
                     mstate.esp -= 4;
                     FSM_luaL_checkinteger.start();
                     return;
                  }
               }
               this.i4 = 1;
               addr282:
               if(this.i4 <= -1)
               {
                  this.i4 += this.i3;
                  this.i4 += 1;
                  this.i4 = this.i4 > -1 ? int(this.i4) : 0;
               }
               else
               {
                  this.i4 = this.i4 > -1 ? int(this.i4) : 0;
               }
               this.i3 = this.i4;
               this.i3 += -1;
               if(this.i3 <= -1)
               {
                  this.i3 = 0;
               }
               else
               {
                  this.i4 = li32(mstate.ebp + -4);
                  if(uint(this.i3) > uint(this.i4))
                  {
                     this.i3 = this.i4;
                  }
               }
               if(this.i5 != 0)
               {
                  this.i4 = 4;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  addr399:
                  this.i4 = mstate.eax;
                  mstate.esp += 8;
                  this.i8 = li32(this.i4 + 8);
                  if(this.i8 != 0)
                  {
                     if(this.i8 == 1)
                     {
                        this.i4 = li32(this.i4);
                        if(this.i4 == 0)
                        {
                           addr438:
                           this.i4 = li8(this.i2);
                           if(this.i4 == 0)
                           {
                              addr451:
                              this.i4 = 0;
                           }
                           else
                           {
                              this.i8 = this.i6 + 1;
                              this.i9 = this.i2;
                              loop3:
                              while(true)
                              {
                                 this.i10 = __2E_str37467;
                                 this.i11 = this.i8;
                                 while(true)
                                 {
                                    this.i12 = this.i10;
                                    this.i10 = li8(this.i12);
                                    if(this.i10 != 0)
                                    {
                                       this.i12 += 1;
                                       this.i13 = this.i4 & 255;
                                       this.i10 &= 255;
                                       if(this.i10 == this.i13)
                                       {
                                          this.i4 = this.i9;
                                       }
                                       this.i10 = this.i12;
                                       continue;
                                       break;
                                    }
                                    this.i4 = li8(this.i11);
                                    this.i8 += 1;
                                    if(this.i4 != 0)
                                    {
                                       continue loop3;
                                    }
                                    §§goto(addr451);
                                 }
                              }
                           }
                           if(this.i4 != 0)
                           {
                              addr968:
                              this.i4 = li8(this.i2);
                              if(this.i4 != 94)
                              {
                                 this.i4 = 1;
                              }
                              else
                              {
                                 this.i4 = 0;
                                 this.i2 += 1;
                              }
                              this.i6 = mstate.ebp + -288;
                              si32(this.i1,mstate.ebp + -280);
                              si32(this.i0,mstate.ebp + -288);
                              this.i8 = li32(mstate.ebp + -4);
                              this.i8 = this.i0 + this.i8;
                              si32(this.i8,mstate.ebp + -284);
                              this.i8 = this.i6 + 12;
                              this.i6 += 4;
                              this.i4 ^= 1;
                              this.i4 &= 1;
                              if(this.i4 != 0)
                              {
                                 this.i4 = 0;
                                 si32(this.i4,this.i8);
                                 mstate.esp -= 12;
                                 this.i4 = mstate.ebp + -288;
                                 this.i3 = this.i0 + this.i3;
                                 si32(this.i4,mstate.esp);
                                 si32(this.i3,mstate.esp + 4);
                                 si32(this.i2,mstate.esp + 8);
                                 state = 7;
                                 mstate.esp -= 4;
                                 FSM_match384.start();
                                 return;
                              }
                              this.i0 = this.i3 + this.i7;
                              §§goto(addr1071);
                           }
                        }
                     }
                     this.i5 = li32(mstate.ebp + -8);
                     this.i7 = li32(mstate.ebp + -4);
                     this.i4 = this.i0 + this.i3;
                     this.i3 = this.i7 - this.i3;
                     if(this.i5 == 0)
                     {
                        this.i3 = this.i4;
                     }
                     else
                     {
                        if(uint(this.i5) <= uint(this.i3))
                        {
                           this.i7 = this.i5 + -1;
                           this.i8 = this.i3 - this.i7;
                           if(this.i3 != this.i7)
                           {
                              this.i3 = li8(this.i2);
                              this.i2 = this.i8;
                              loop0:
                              while(true)
                              {
                                 this.i9 = this.i2;
                                 this.i2 = this.i4;
                                 this.i8 = this.i2;
                                 if(this.i9 != 0)
                                 {
                                    this.i2 = this.i9 + 1;
                                    this.i4 = this.i8;
                                    while(true)
                                    {
                                       this.i10 = li8(this.i4);
                                       this.i11 = this.i3 & 255;
                                       this.i12 = this.i4;
                                       if(this.i10 == this.i11)
                                       {
                                          this.i2 = this.i12;
                                          break;
                                       }
                                       this.i2 += -1;
                                       this.i4 += 1;
                                       if(this.i2 != 1)
                                       {
                                          continue;
                                       }
                                    }
                                    addr757:
                                    this.i4 = this.i2;
                                    this.i2 = this.i4;
                                    if(this.i4 != 0)
                                    {
                                       this.i10 = this.i4 + 1;
                                       if(this.i7 != 0)
                                       {
                                          this.i11 = 1;
                                          this.i12 = this.i5;
                                          while(true)
                                          {
                                             this.i13 = this.i6 + this.i11;
                                             this.i14 = this.i2 + this.i11;
                                             this.i14 = li8(this.i14);
                                             this.i13 = li8(this.i13);
                                             if(this.i14 != this.i13)
                                             {
                                                this.i2 = this.i8 - this.i10;
                                                this.i2 += this.i9;
                                                if(this.i2 == 0)
                                                {
                                                   this.i3 = 0;
                                                }
                                                else
                                                {
                                                   addr603:
                                                }
                                             }
                                             this.i12 += -1;
                                             this.i11 += 1;
                                             if(this.i12 == 1)
                                             {
                                                break loop0;
                                             }
                                          }
                                          addr833:
                                          this.i2 = this.i3;
                                          if(this.i2 != 0)
                                          {
                                             this.i3 = 3;
                                             this.i5 = 1 - this.i0;
                                             this.i5 = this.i2 + this.i5;
                                             this.i7 = li32(this.i1 + 8);
                                             this.f0 = Number(this.i5);
                                             sf64(this.f0,this.i7);
                                             si32(this.i3,this.i7 + 8);
                                             this.i5 = li32(this.i1 + 8);
                                             this.i7 = this.i5 + 12;
                                             si32(this.i7,this.i1 + 8);
                                             this.i7 = li32(mstate.ebp + -8);
                                             this.i0 = this.i2 - this.i0;
                                             this.i0 += this.i7;
                                             this.f0 = Number(this.i0);
                                             sf64(this.f0,this.i5 + 12);
                                             si32(this.i3,this.i5 + 20);
                                             this.i0 = li32(this.i1 + 8);
                                             this.i0 += 12;
                                             si32(this.i0,this.i1 + 8);
                                             this.i0 = 2;
                                          }
                                          else
                                          {
                                             addr1491:
                                             this.i0 = 0;
                                             this.i2 = li32(this.i1 + 8);
                                             si32(this.i0,this.i2 + 8);
                                             this.i0 = li32(this.i1 + 8);
                                             this.i0 += 12;
                                             si32(this.i0,this.i1 + 8);
                                             this.i0 = 1;
                                          }
                                          mstate.eax = this.i0;
                                          break loop5;
                                       }
                                       break;
                                    }
                                    §§goto(addr603);
                                 }
                                 this.i2 = 0;
                                 §§goto(addr757);
                                 this.i4 = this.i10;
                              }
                              this.i3 = this.i4;
                              §§goto(addr833);
                           }
                        }
                        §§goto(addr603);
                     }
                     §§goto(addr833);
                  }
                  §§goto(addr438);
               }
               §§goto(addr968);
            case 4:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr282);
            case 5:
               §§goto(addr399);
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               this.i4 = this.i0;
               if(this.i3 != 0)
               {
                  this.i0 = this.i3;
                  this.i2 = this.i4;
                  addr1255:
                  if(this.i5 != 0)
                  {
                     this.i3 = 3;
                     this.i4 = 1 - this.i7;
                     this.i2 += this.i4;
                     this.i4 = li32(this.i1 + 8);
                     this.f0 = Number(this.i2);
                     sf64(this.f0,this.i4);
                     si32(this.i3,this.i4 + 8);
                     this.i2 = li32(this.i1 + 8);
                     this.i0 -= this.i7;
                     this.i4 = this.i2 + 12;
                     si32(this.i4,this.i1 + 8);
                     this.f0 = Number(this.i0);
                     sf64(this.f0,this.i2 + 12);
                     si32(this.i3,this.i2 + 20);
                     this.i0 = li32(this.i1 + 8);
                     this.i0 += 12;
                     si32(this.i0,this.i1 + 8);
                     mstate.esp -= 12;
                     this.i0 = 0;
                     this.i1 = mstate.ebp + -288;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 8;
                     mstate.esp -= 4;
                     FSM_push_captures.start();
                     return;
                  }
                  this.i1 = mstate.ebp + -288;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_push_captures.start();
                  return;
               }
               this.i3 = li32(this.i6);
               this.i4 = this.i0 + 1;
               if(uint(this.i0) < uint(this.i3))
               {
                  this.i0 = this.i4;
                  addr1071:
                  this.i3 = 0;
                  si32(this.i3,this.i8);
                  mstate.esp -= 12;
                  this.i3 = mstate.ebp + -288;
                  si32(this.i3,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_match384.start();
                  return;
               }
               §§goto(addr1491);
               break;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 != 0)
               {
                  this.i2 = this.i3;
                  §§goto(addr1255);
               }
               else
               {
                  §§goto(addr1491);
               }
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 += 2;
               §§goto(addr833);
            case 9:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               mstate.eax = this.i1;
               break;
            default:
               throw "Invalid state in _str_find_aux";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
