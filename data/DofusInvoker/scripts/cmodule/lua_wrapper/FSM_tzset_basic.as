package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_tzset_basic extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public function FSM_tzset_basic()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_tzset_basic = null;
         _loc1_ = new FSM_tzset_basic();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop3:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = __2E_str5353;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               mstate.esp -= 4;
               FSM_getenv.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i1 = li32(_lcl_is_set);
               this.i2 = this.i0;
               if(this.i0 == 0)
               {
                  if(this.i1 >= 0)
                  {
                     this.i0 = -1;
                     si32(this.i0,_lcl_is_set);
                     mstate.esp -= 8;
                     this.i0 = _lclmem;
                     this.i1 = 0;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_tzload.start();
                     return;
                  }
               }
               else
               {
                  if(this.i1 >= 1)
                  {
                     this.i1 = li8(_lcl_TZname);
                     this.i3 = li8(this.i0);
                     if(this.i1 != this.i3)
                     {
                        this.i3 = this.i0;
                     }
                     else
                     {
                        this.i3 = _lcl_TZname;
                        this.i4 = 0;
                        while(true)
                        {
                           this.i5 = this.i2 + this.i4;
                           this.i5 += 1;
                           this.i1 &= 255;
                           if(this.i1 != 0)
                           {
                              this.i1 = this.i3 + this.i4;
                              this.i1 = li8(this.i1 + 1);
                              this.i5 = li8(this.i5);
                              this.i4 += 1;
                              if(this.i1 == this.i5)
                              {
                                 continue;
                              }
                              addr394:
                              this.i3 = this.i2 + this.i4;
                              this.i3 = li8(this.i3);
                              this.i1 &= 255;
                              if(this.i1 == this.i3)
                              {
                                 break;
                              }
                              this.i1 = li8(this.i0);
                              if(this.i1 != 0)
                              {
                                 this.i3 = this.i2;
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
                              }
                              else
                              {
                                 this.i3 = this.i0;
                              }
                              this.i3 -= this.i2;
                              this.i4 = uint(this.i3) < uint(256) ? 1 : 0;
                              this.i4 &= 1;
                              si32(this.i4,_lcl_is_set);
                              if(uint(this.i3) <= uint(255))
                              {
                                 si8(this.i1,_lcl_TZname);
                                 this.i3 = this.i1 & 255;
                                 if(this.i3 != 0)
                                 {
                                    this.i3 = _lcl_TZname;
                                    this.i4 = 1;
                                    do
                                    {
                                       this.i5 = this.i2 + this.i4;
                                       this.i5 = li8(this.i5);
                                       this.i6 = this.i3 + this.i4;
                                       si8(this.i5,this.i6);
                                       this.i4 += 1;
                                    }
                                    while(this.i5 != 0);
                                    
                                    addr455:
                                    this.i1 &= 255;
                                    if(this.i1 != 0)
                                    {
                                       this.i1 = _lclmem;
                                       mstate.esp -= 8;
                                       si32(this.i0,mstate.esp);
                                       si32(this.i1,mstate.esp + 4);
                                       state = 6;
                                       mstate.esp -= 4;
                                       FSM_tzload.start();
                                       return;
                                    }
                                 }
                                 this.i0 = 0;
                                 si32(this.i0,_lclmem);
                                 si32(this.i0,_lclmem + 4);
                                 si32(this.i0,_lclmem + 8);
                                 si32(this.i0,_lclmem + 1872);
                                 si32(this.i0,_lclmem + 1868);
                                 si32(this.i0,_lclmem + 1876);
                                 this.i1 = 85;
                                 this.i2 = 84;
                                 this.i3 = 67;
                                 si8(this.i1,_lclmem + 6988);
                                 si8(this.i2,_lclmem + 6989);
                                 si8(this.i3,_lclmem + 6990);
                                 si8(this.i0,_lclmem + 6991);
                                 addr256:
                                 mstate.esp -= 4;
                                 FSM_settzname.start();
                                 break loop3;
                                 addr787:
                                 addr786:
                              }
                              §§goto(addr455);
                           }
                           break;
                        }
                        addr270:
                        mstate.esp = mstate.ebp;
                        mstate.ebp = li32(mstate.esp);
                        mstate.esp += 4;
                        mstate.esp += 4;
                        mstate.gworker = caller;
                        return;
                        addr268:
                     }
                     §§goto(addr394);
                  }
                  §§goto(addr411);
               }
               §§goto(addr270);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = _gmt;
                  mstate.esp -= 8;
                  this.i1 = _lclmem;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_tzload.start();
                  return;
               }
               §§goto(addr787);
               break;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = _gmt;
                  mstate.esp -= 12;
                  this.i1 = _lclmem;
                  this.i2 = 1;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_tzparse.start();
                  return;
               }
               §§goto(addr256);
               break;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr256);
            case 6:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               if(this.i1 != 0)
               {
                  this.i1 = li8(this.i0);
                  if(this.i1 != 58)
                  {
                     this.i1 = _lclmem;
                     mstate.esp -= 12;
                     this.i2 = 0;
                     si32(this.i0,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i2,mstate.esp + 8);
                     state = 7;
                     mstate.esp -= 4;
                     FSM_tzparse.start();
                     return;
                  }
                  §§goto(addr671);
               }
               else
               {
                  §§goto(addr786);
                  addr788:
               }
               break;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               if(this.i0 != 0)
               {
                  addr671:
                  this.i0 = _gmt;
                  mstate.esp -= 8;
                  this.i1 = _lclmem;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  state = 8;
                  mstate.esp -= 4;
                  FSM_tzload.start();
                  return;
               }
               §§goto(addr788);
               break;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               if(this.i0 != 0)
               {
                  this.i0 = _gmt;
                  mstate.esp -= 12;
                  this.i1 = _lclmem;
                  this.i2 = 1;
                  si32(this.i0,mstate.esp);
                  si32(this.i1,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_tzparse.start();
                  return;
               }
               §§goto(addr256);
               break;
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr256);
            case 5:
               break;
            default:
               throw "Invalid state in _tzset_basic";
         }
         §§goto(addr268);
      }
   }
}
