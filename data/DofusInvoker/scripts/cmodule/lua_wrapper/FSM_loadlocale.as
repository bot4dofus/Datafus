package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_loadlocale extends Machine
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
      
      public function FSM_loadlocale()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_loadlocale = null;
         _loc1_ = new FSM_loadlocale();
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
               this.i0 = _new_categories;
               this.i2 = li32(mstate.ebp + 8);
               this.i1 = this.i2 << 5;
               this.i3 = _current_categories;
               this.i4 = this.i0 + this.i1;
               this.i0 = li8(this.i4);
               this.i3 += this.i1;
               if(this.i0 != 46)
               {
                  this.i0 &= 255;
                  if(this.i0 == 47)
                  {
                     addr85:
                     this.i0 = this.i4;
                  }
                  else
                  {
                     addr197:
                     this.i0 = _new_categories;
                     this.i1 = this.i2 << 5;
                     this.i0 += this.i1;
                     while(true)
                     {
                        this.i1 = li8(this.i0);
                        if(this.i1 == 0)
                        {
                           this.i0 = 0;
                           break;
                        }
                        this.i1 = li8(this.i0 + 1);
                        this.i0 += 1;
                        this.i5 = this.i0;
                        if(this.i1 == 47)
                        {
                           break;
                        }
                        this.i0 = this.i5;
                     }
                  }
                  addr92:
                  if(this.i0 == 0)
                  {
                     this.i5 = li32(_val_2E_1440);
                     this.i0 = li32(__PathLocale);
                     if(this.i0 != 0)
                     {
                        addr275:
                        this.i0 = 0;
                     }
                     else
                     {
                        this.i0 = __2E_str940;
                        mstate.esp -= 4;
                        si32(this.i0,mstate.esp);
                        mstate.esp -= 4;
                        FSM_getenv.start();
                        addr303:
                        this.i6 = mstate.eax;
                        mstate.esp += 4;
                        this.i7 = this.i6;
                        if(this.i6 != 0)
                        {
                           this.i0 = __2E_str876;
                           this.i1 = 4;
                           log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                           this.i0 = li8(this.i6);
                           if(this.i0 != 0)
                           {
                              this.i1 = this.i7;
                              while(true)
                              {
                                 this.i8 = li8(this.i1 + 1);
                                 this.i1 += 1;
                                 this.i9 = this.i1;
                                 if(this.i8 == 0)
                                 {
                                    break;
                                 }
                                 this.i1 = this.i9;
                              }
                           }
                           else
                           {
                              this.i1 = this.i6;
                           }
                           this.i1 -= this.i7;
                           this.i1 += 44;
                           if(uint(this.i1) < uint(1024))
                           {
                              this.i0 &= 255;
                              if(this.i0 != 0)
                              {
                                 this.i0 = this.i7;
                                 while(true)
                                 {
                                    this.i1 = li8(this.i0 + 1);
                                    this.i0 += 1;
                                    this.i8 = this.i0;
                                    if(this.i1 == 0)
                                    {
                                       break;
                                    }
                                    this.i0 = this.i8;
                                 }
                              }
                              else
                              {
                                 this.i0 = this.i6;
                              }
                              this.i1 = 0;
                              this.i0 -= this.i7;
                              mstate.esp -= 8;
                              this.i0 += 1;
                              si32(this.i1,mstate.esp);
                              si32(this.i0,mstate.esp + 4);
                              state = 3;
                              mstate.esp -= 4;
                              FSM_pubrealloc.start();
                              return;
                           }
                           this.i0 = 63;
                        }
                        else
                        {
                           this.i0 = __2E_str1041;
                           si32(this.i0,__PathLocale);
                           this.i0 = 0;
                        }
                     }
                     addr488:
                     si32(this.i0,_val_2E_1440);
                     if(this.i0 != 0)
                     {
                        addr500:
                        this.i2 = 0;
                        break;
                     }
                     si32(this.i5,_val_2E_1440);
                     if(this.i2 <= 3)
                     {
                        if(this.i2 != 1)
                        {
                           if(this.i2 != 2)
                           {
                              if(this.i2 != 3)
                              {
                                 addr100:
                                 this.i2 = 22;
                                 si32(this.i2,_val_2E_1440);
                                 this.i2 = 0;
                                 mstate.eax = this.i2;
                                 mstate.esp = mstate.ebp;
                                 mstate.ebp = li32(mstate.esp);
                                 mstate.esp += 4;
                                 mstate.esp += 4;
                                 mstate.gworker = caller;
                                 return;
                                 addr1202:
                                 addr99:
                              }
                              else
                              {
                                 this.i0 = li8(this.i4);
                                 this.i1 = li8(this.i3);
                                 if(this.i0 != this.i1)
                                 {
                                    this.i1 = this.i3;
                                    addr1074:
                                    this.i1 = li8(this.i1);
                                    this.i0 &= 255;
                                    if(this.i0 != this.i1)
                                    {
                                       this.i0 = ___monetary_load_locale;
                                       §§goto(addr1329);
                                    }
                                 }
                                 else
                                 {
                                    this.i1 = _current_categories;
                                    this.i5 = _new_categories;
                                    this.i6 = this.i2 << 5;
                                    while(true)
                                    {
                                       this.i7 = this.i1 + this.i6;
                                       this.i7 += 1;
                                       this.i0 &= 255;
                                       if(this.i0 != 0)
                                       {
                                          this.i0 = this.i5 + this.i6;
                                          this.i0 = li8(this.i0 + 1);
                                          this.i7 = li8(this.i7);
                                          this.i6 += 1;
                                          if(this.i0 == this.i7)
                                          {
                                             continue;
                                          }
                                          this.i1 = _current_categories;
                                          this.i1 += this.i6;
                                          §§goto(addr1074);
                                       }
                                    }
                                 }
                              }
                           }
                           else
                           {
                              this.i0 = li8(this.i4);
                              this.i1 = li8(this.i3);
                              if(this.i0 != this.i1)
                              {
                                 this.i1 = this.i3;
                                 addr1308:
                                 this.i1 = li8(this.i1);
                                 this.i0 &= 255;
                                 if(this.i0 != this.i1)
                                 {
                                    this.i0 = ___wrap_setrunelocale;
                                    §§goto(addr1329);
                                 }
                              }
                              else
                              {
                                 this.i1 = _current_categories;
                                 this.i5 = _new_categories;
                                 this.i6 = this.i2 << 5;
                                 while(true)
                                 {
                                    this.i7 = this.i1 + this.i6;
                                    this.i7 += 1;
                                    this.i0 &= 255;
                                    if(this.i0 != 0)
                                    {
                                       this.i0 = this.i5 + this.i6;
                                       this.i0 = li8(this.i0 + 1);
                                       this.i7 = li8(this.i7);
                                       this.i6 += 1;
                                       if(this.i0 == this.i7)
                                       {
                                          continue;
                                       }
                                       this.i1 = _current_categories;
                                       this.i1 += this.i6;
                                       §§goto(addr1308);
                                    }
                                 }
                              }
                           }
                        }
                        else
                        {
                           this.i0 = li8(this.i4);
                           this.i1 = li8(this.i3);
                           if(this.i0 == this.i1)
                           {
                              this.i1 = _current_categories;
                              this.i5 = _new_categories;
                              this.i6 = this.i2 << 5;
                              while(true)
                              {
                                 this.i7 = this.i1 + this.i6;
                                 this.i7 += 1;
                                 this.i0 &= 255;
                                 if(this.i0 == 0)
                                 {
                                    break;
                                 }
                                 this.i0 = this.i5 + this.i6;
                                 this.i0 = li8(this.i0 + 1);
                                 this.i7 = li8(this.i7);
                                 this.i6 += 1;
                                 if(this.i0 == this.i7)
                                 {
                                    continue;
                                 }
                                 this.i1 = _current_categories;
                                 this.i1 += this.i6;
                              }
                              addr665:
                              this.i2 = this.i3;
                              break;
                           }
                           this.i1 = this.i3;
                           this.i1 = li8(this.i1);
                           this.i0 &= 255;
                           if(this.i0 != this.i1)
                           {
                              this.i0 = ___collate_load_tables;
                              §§goto(addr1329);
                           }
                        }
                     }
                     else if(this.i2 != 4)
                     {
                        if(this.i2 != 5)
                        {
                           if(this.i2 != 6)
                           {
                              §§goto(addr1202);
                           }
                           else
                           {
                              this.i0 = li8(this.i4);
                              this.i1 = li8(this.i3);
                              if(this.i0 != this.i1)
                              {
                                 this.i1 = this.i3;
                                 addr1180:
                                 this.i1 = li8(this.i1);
                                 this.i0 &= 255;
                                 if(this.i0 != this.i1)
                                 {
                                    this.i0 = ___messages_load_locale;
                                    §§goto(addr1329);
                                 }
                              }
                              else
                              {
                                 this.i1 = _current_categories;
                                 this.i5 = _new_categories;
                                 this.i6 = this.i2 << 5;
                                 while(true)
                                 {
                                    this.i7 = this.i1 + this.i6;
                                    this.i7 += 1;
                                    this.i0 &= 255;
                                    if(this.i0 != 0)
                                    {
                                       this.i0 = this.i5 + this.i6;
                                       this.i0 = li8(this.i0 + 1);
                                       this.i7 = li8(this.i7);
                                       this.i6 += 1;
                                       if(this.i0 == this.i7)
                                       {
                                          continue;
                                       }
                                       this.i1 = _current_categories;
                                       this.i1 += this.i6;
                                       §§goto(addr1180);
                                    }
                                 }
                              }
                           }
                        }
                        else
                        {
                           this.i0 = li8(this.i4);
                           this.i1 = li8(this.i3);
                           if(this.i0 != this.i1)
                           {
                              this.i1 = this.i3;
                              addr841:
                              this.i1 = li8(this.i1);
                              this.i0 &= 255;
                              if(this.i0 != this.i1)
                              {
                                 this.i0 = ___time_load_locale;
                                 §§goto(addr1329);
                              }
                           }
                           else
                           {
                              this.i1 = _current_categories;
                              this.i5 = _new_categories;
                              this.i6 = this.i2 << 5;
                              while(true)
                              {
                                 this.i7 = this.i1 + this.i6;
                                 this.i7 += 1;
                                 this.i0 &= 255;
                                 if(this.i0 != 0)
                                 {
                                    this.i0 = this.i5 + this.i6;
                                    this.i0 = li8(this.i0 + 1);
                                    this.i7 = li8(this.i7);
                                    this.i6 += 1;
                                    if(this.i0 == this.i7)
                                    {
                                       continue;
                                    }
                                    this.i1 = _current_categories;
                                    this.i1 += this.i6;
                                    §§goto(addr841);
                                 }
                              }
                           }
                        }
                     }
                     else
                     {
                        this.i0 = li8(this.i4);
                        this.i1 = li8(this.i3);
                        if(this.i0 != this.i1)
                        {
                           this.i1 = this.i3;
                        }
                        else
                        {
                           this.i1 = _current_categories;
                           this.i5 = _new_categories;
                           this.i6 = this.i2 << 5;
                           while(true)
                           {
                              this.i7 = this.i1 + this.i6;
                              this.i7 += 1;
                              this.i0 &= 255;
                              if(this.i0 != 0)
                              {
                                 this.i0 = this.i5 + this.i6;
                                 this.i0 = li8(this.i0 + 1);
                                 this.i7 = li8(this.i7);
                                 this.i6 += 1;
                                 if(this.i0 == this.i7)
                                 {
                                    continue;
                                 }
                                 this.i1 = _current_categories;
                                 this.i1 += this.i6;
                              }
                              break;
                           }
                           addr664:
                           §§goto(addr665);
                        }
                        this.i1 = li8(this.i1);
                        this.i0 &= 255;
                        if(this.i0 != this.i1)
                        {
                           this.i0 = ___numeric_load_locale;
                           addr1329:
                           mstate.esp -= 4;
                           si32(this.i4,mstate.esp);
                           state = 2;
                           mstate.esp -= 4;
                           mstate.funcs[this.i0]();
                           return;
                        }
                     }
                     §§goto(addr664);
                  }
                  §§goto(addr100);
               }
               else
               {
                  this.i1 = _new_categories;
                  this.i5 = this.i2 << 5;
                  this.i1 += this.i5;
                  this.i1 = li8(this.i1 + 1);
                  if(this.i1 != 0)
                  {
                     this.i1 &= 255;
                     if(this.i1 == 46)
                     {
                        this.i1 = _new_categories;
                        this.i5 = this.i2 << 5;
                        this.i1 += this.i5;
                        this.i1 = li8(this.i1 + 2);
                        if(this.i1 != 0)
                        {
                        }
                        §§goto(addr99);
                     }
                     this.i0 &= 255;
                     if(this.i0 != 47)
                     {
                        §§goto(addr197);
                     }
                     else
                     {
                        §§goto(addr85);
                     }
                  }
               }
               §§goto(addr100);
            case 1:
               §§goto(addr303);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               if(this.i0 != -1)
               {
                  this.i0 = li8(this.i4);
                  si8(this.i0,this.i3);
                  if(this.i0 != 0)
                  {
                     this.i0 = _new_categories;
                     this.i2 <<= 5;
                     this.i1 = _current_categories;
                     this.i2 |= 1;
                     do
                     {
                        this.i4 = this.i0 + this.i2;
                        this.i4 = li8(this.i4);
                        this.i5 = this.i1 + this.i2;
                        si8(this.i4,this.i5);
                        this.i2 += 1;
                     }
                     while(this.i4 != 0);
                     
                  }
                  mstate.eax = this.i3;
                  §§goto(addr100);
               }
               else
               {
                  §§goto(addr500);
               }
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               if(this.i1 == 0)
               {
                  this.i0 = 0;
               }
               else
               {
                  this.i7 = this.i1;
                  memcpy(this.i7,this.i6,this.i0);
                  this.i0 = this.i1;
               }
               si32(this.i0,__PathLocale);
               if(this.i0 == 0)
               {
                  this.i0 = li32(_val_2E_1440);
                  if(this.i0 == 0)
                  {
                     this.i0 = 12;
                  }
               }
               else
               {
                  §§goto(addr275);
               }
               §§goto(addr488);
            default:
               throw "Invalid state in _loadlocale";
         }
         this.i0 = this.i2;
         mstate.eax = this.i0;
         §§goto(addr100);
      }
   }
}
