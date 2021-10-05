package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_luaF_close extends Machine
   {
      
      public static const intRegCount:int = 12;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
      public var i11:int;
      
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
      
      public function FSM_luaF_close()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaF_close = null;
         _loc1_ = new FSM_luaF_close();
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
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(this.i0 + 96);
               this.i2 = this.i0 + 96;
               this.i3 = li32(mstate.ebp + 12);
               if(this.i1 != 0)
               {
                  this.i4 = li32(this.i0 + 16);
                  this.i4 += 20;
                  this.i5 = this.i0 + 16;
                  loop0:
                  while(true)
                  {
                     this.i7 = this.i1;
                     this.i8 = li32(this.i7 + 8);
                     this.i6 = this.i7 + 8;
                     this.i1 = this.i7;
                     if(uint(this.i8) < uint(this.i3))
                     {
                        break;
                     }
                     this.i8 = li32(this.i7);
                     si32(this.i8,this.i2);
                     this.i8 = li8(this.i4);
                     this.i9 = li8(this.i7 + 5);
                     this.i8 ^= 3;
                     this.i10 = this.i7 + 5;
                     this.i8 &= this.i9;
                     this.i9 = this.i7;
                     this.i8 &= 3;
                     if(this.i8 != 0)
                     {
                        this.i6 = li32(this.i6);
                        this.i9 = this.i1 + 12;
                        if(this.i6 != this.i9)
                        {
                           this.i6 = 0;
                           this.i9 = li32(this.i1 + 16);
                           this.i10 = li32(this.i1 + 12);
                           si32(this.i10,this.i9 + 12);
                           this.i9 = li32(this.i1 + 12);
                           this.i1 = li32(this.i1 + 16);
                           si32(this.i1,this.i9 + 16);
                           mstate.esp -= 16;
                           this.i1 = 24;
                           si32(this.i0,mstate.esp);
                           si32(this.i7,mstate.esp + 4);
                           si32(this.i1,mstate.esp + 8);
                           si32(this.i6,mstate.esp + 12);
                           state = 1;
                           mstate.esp -= 4;
                           FSM_luaM_realloc_.start();
                           return;
                        }
                        this.i1 = 0;
                        mstate.esp -= 16;
                        this.i6 = 24;
                        si32(this.i0,mstate.esp);
                        si32(this.i7,mstate.esp + 4);
                        si32(this.i6,mstate.esp + 8);
                        si32(this.i1,mstate.esp + 12);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_luaM_realloc_.start();
                        return;
                     }
                     this.i8 = li32(this.i1 + 16);
                     this.i11 = li32(this.i1 + 12);
                     si32(this.i11,this.i8 + 12);
                     this.i8 = li32(this.i1 + 12);
                     this.i11 = li32(this.i1 + 16);
                     si32(this.i11,this.i8 + 16);
                     this.i8 = li32(this.i6);
                     this.f0 = lf64(this.i8);
                     sf64(this.f0,this.i1 + 12);
                     this.i8 = li32(this.i8 + 8);
                     si32(this.i8,this.i1 + 20);
                     this.i1 += 12;
                     si32(this.i1,this.i6);
                     this.i1 = li32(this.i5);
                     this.i8 = li32(this.i1 + 28);
                     si32(this.i8,this.i9);
                     si32(this.i7,this.i1 + 28);
                     this.i7 = li8(this.i10);
                     this.i8 = this.i7;
                     this.i9 = this.i7 & 4;
                     if(this.i9 == 0)
                     {
                        this.i8 &= 3;
                        if(this.i8 == 0)
                        {
                           this.i8 = li8(this.i1 + 21);
                           if(this.i8 == 1)
                           {
                              this.i1 = this.i7 | 4;
                              si8(this.i1,this.i10);
                              this.i7 = li32(this.i6);
                              this.i6 = li32(this.i7 + 8);
                              if(this.i6 >= 4)
                              {
                                 this.i7 = li32(this.i7);
                                 this.i6 = li8(this.i7 + 5);
                                 this.i6 &= 3;
                                 if(this.i6 != 0)
                                 {
                                    this.i6 = li32(this.i5);
                                    this.i8 = li8(this.i6 + 21);
                                    if(this.i8 == 1)
                                    {
                                       mstate.esp -= 8;
                                       si32(this.i6,mstate.esp);
                                       si32(this.i7,mstate.esp + 4);
                                       mstate.esp -= 4;
                                       FSM_reallymarkobject.start();
                                       break loop3;
                                    }
                                    this.i7 = li8(this.i6 + 20);
                                    this.i1 &= -8;
                                    this.i7 &= 3;
                                    this.i1 = this.i7 | this.i1;
                                    si8(this.i1,this.i10);
                                 }
                              }
                           }
                           else
                           {
                              this.i1 = li8(this.i1 + 20);
                              this.i6 = this.i7 & -8;
                              this.i1 &= 3;
                              this.i1 |= this.i6;
                              si8(this.i1,this.i10);
                           }
                        }
                     }
                     while(true)
                     {
                        this.i1 = li32(this.i2);
                        if(this.i1 == 0)
                        {
                           break loop0;
                        }
                        continue loop0;
                     }
                  }
                  addr658:
               }
               §§goto(addr689);
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               §§goto(addr317);
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               addr317:
               this.i1 = li32(this.i2);
               if(this.i1 != 0)
               {
                  §§goto(addr658);
               }
               addr689:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 3:
               break;
            default:
               throw "Invalid state in _luaF_close";
         }
         continue loop1;
      }
   }
}
