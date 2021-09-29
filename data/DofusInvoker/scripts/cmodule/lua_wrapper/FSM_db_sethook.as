package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_db_sethook extends Machine
   {
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public var i9:int;
      
      public function FSM_db_sethook()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_db_sethook = null;
         _loc1_ = new FSM_db_sethook();
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
               mstate.esp -= 4;
               this.i0 = mstate.ebp + -4;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_getthread.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(mstate.ebp + -4);
               mstate.esp -= 8;
               this.i2 += 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 == this.i3)
               {
                  this.i2 = 1;
               }
               else
               {
                  this.i2 = li32(this.i2 + 8);
                  this.i2 = this.i2 < 1 ? 1 : 0;
               }
               this.i3 = li32(mstate.ebp + -4);
               this.i2 ^= 1;
               this.i2 &= 1;
               if(this.i2 == 0)
               {
                  this.i2 = li32(this.i1 + 8);
                  this.i4 = this.i1 + 8;
                  this.i5 = this.i3 + 1;
                  if(this.i5 >= 0)
                  {
                     this.i3 = li32(this.i1 + 12);
                     this.i6 = this.i1 + 12;
                     this.i7 = this.i5 * 12;
                     this.i7 = this.i3 + this.i7;
                     if(uint(this.i2) >= uint(this.i7))
                     {
                        this.i2 = this.i3;
                     }
                     else
                     {
                        do
                        {
                           this.i3 = 0;
                           si32(this.i3,this.i2 + 8);
                           this.i2 += 12;
                           si32(this.i2,this.i4);
                           this.i3 = li32(this.i6);
                           this.i7 = this.i5 * 12;
                           this.i7 = this.i3 + this.i7;
                        }
                        while(uint(this.i2) < uint(this.i7));
                        
                        this.i2 = this.i3;
                     }
                     this.i3 = this.i5 * 12;
                     this.i2 += this.i3;
                  }
                  else
                  {
                     this.i3 *= 12;
                     this.i2 = this.i3 + this.i2;
                     this.i2 += 24;
                  }
                  this.i3 = this.i2;
                  this.i2 = 0;
                  si32(this.i3,this.i4);
                  this.i3 = this.i2;
                  this.i4 = this.i2;
                  break;
               }
               this.i2 = 0;
               mstate.esp -= 12;
               this.i3 += 2;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaL_checklstring.start();
               return;
               break;
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(mstate.ebp + -4);
               mstate.esp -= 8;
               this.i3 += 1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               this.i5 = this.i2;
               this.i6 = _luaO_nilobject_;
               if(this.i4 != this.i6)
               {
                  this.i4 = li32(this.i4 + 8);
                  if(this.i4 == 6)
                  {
                     addr537:
                     this.i3 = _luaO_nilobject_;
                     this.i4 = li32(mstate.ebp + -4);
                     mstate.esp -= 8;
                     this.i4 += 3;
                     si32(this.i1,mstate.esp);
                     si32(this.i4,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr581:
                     this.i6 = mstate.eax;
                     mstate.esp += 8;
                     if(this.i6 != this.i3)
                     {
                        this.i3 = li32(this.i6 + 8);
                        if(this.i3 >= 1)
                        {
                           mstate.esp -= 8;
                           si32(this.i1,mstate.esp);
                           si32(this.i4,mstate.esp + 4);
                           state = 7;
                           mstate.esp -= 4;
                           FSM_luaL_checkinteger.start();
                           return;
                        }
                     }
                     this.i4 = 0;
                     addr657:
                     this.i3 = this.i4;
                     this.i4 = li8(this.i2);
                     if(this.i4 != 99)
                     {
                        this.i6 = this.i5;
                        while(true)
                        {
                           this.i7 = li8(this.i6);
                           if(this.i7 == 0)
                           {
                              this.i6 = 0;
                              break;
                           }
                           this.i7 = li8(this.i6 + 1);
                           this.i6 += 1;
                           this.i8 = this.i6;
                           if(this.i7 == 99)
                           {
                              break;
                           }
                           this.i6 = this.i8;
                        }
                     }
                     else
                     {
                        this.i6 = this.i2;
                     }
                     this.i6 = this.i6 != 0 ? 1 : 0;
                     this.i6 &= 1;
                     this.i7 = this.i4 & 255;
                     if(this.i7 != 114)
                     {
                        this.i7 = this.i5;
                        while(true)
                        {
                           this.i8 = li8(this.i7);
                           if(this.i8 == 0)
                           {
                              this.i7 = 0;
                              break;
                           }
                           this.i8 = li8(this.i7 + 1);
                           this.i7 += 1;
                           this.i9 = this.i7;
                           if(this.i8 == 114)
                           {
                              break;
                           }
                           this.i7 = this.i9;
                        }
                     }
                     else
                     {
                        this.i7 = this.i2;
                     }
                     this.i7 = this.i7 == 0 ? 0 : 2;
                     this.i4 &= 255;
                     if(this.i4 != 108)
                     {
                        this.i2 = this.i5;
                        while(true)
                        {
                           this.i4 = li8(this.i2);
                           if(this.i4 == 0)
                           {
                              this.i2 = 0;
                              break;
                           }
                           this.i4 = li8(this.i2 + 1);
                           this.i2 += 1;
                           this.i5 = this.i2;
                           if(this.i4 == 108)
                           {
                              break;
                           }
                           this.i2 = this.i5;
                        }
                     }
                     this.i2 = this.i2 == 0 ? 0 : 4;
                     this.i4 = this.i7 | this.i6;
                     this.i2 = this.i4 | this.i2;
                     if(this.i3 <= 0)
                     {
                        this.i5 = _hookf;
                        this.i4 = this.i2;
                        this.i2 = this.i3;
                        this.i3 = this.i5;
                        break;
                     }
                     this.i5 = _hookf;
                     this.i2 |= 8;
                     this.i4 = this.i2;
                     this.i2 = this.i3;
                     this.i3 = this.i5;
                     break;
                  }
               }
               this.i4 = 6;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_tag_error.start();
               return;
            case 5:
               mstate.esp += 12;
               §§goto(addr537);
            case 6:
               §§goto(addr581);
            case 7:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr657);
            case 8:
               mstate.esp += 4;
               this.i6 = li32(this.i1 + 8);
               si32(this.i0,this.i6);
               si32(this.i5,this.i6 + 8);
               this.i5 = li32(this.i1 + 8);
               this.i5 += 12;
               si32(this.i5,this.i1 + 8);
               this.i5 = li32(mstate.ebp + -4);
               mstate.esp -= 8;
               this.i5 += 1;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 9:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i6 = li32(this.i1 + 8);
               this.f0 = lf64(this.i5);
               sf64(this.f0,this.i6);
               this.i5 = li32(this.i5 + 8);
               si32(this.i5,this.i6 + 8);
               this.i5 = li32(this.i1 + 8);
               this.i5 += 12;
               si32(this.i5,this.i1 + 8);
               mstate.esp -= 8;
               this.i5 = -3;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 10;
               mstate.esp -= 4;
               FSM_lua_rawset.start();
               return;
            case 10:
               mstate.esp += 8;
               this.i5 = this.i3 == 0 ? 1 : 0;
               this.i6 = this.i4 == 0 ? 1 : 0;
               this.i7 = li32(this.i1 + 8);
               this.i5 = this.i6 | this.i5;
               this.i5 &= 1;
               this.i6 = this.i7 + -12;
               si32(this.i6,this.i1 + 8);
               this.i1 = this.i5 != 0 ? 0 : int(this.i3);
               si32(this.i1,this.i0 + 68);
               si32(this.i2,this.i0 + 60);
               si32(this.i2,this.i0 + 64);
               this.i1 = this.i5 != 0 ? 0 : int(this.i4);
               si8(this.i1,this.i0 + 56);
               this.i0 = 0;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _db_sethook";
         }
         this.i5 = 2;
         mstate.esp -= 4;
         si32(this.i1,mstate.esp);
         state = 8;
         mstate.esp -= 4;
         FSM_gethooktable.start();
      }
   }
}
