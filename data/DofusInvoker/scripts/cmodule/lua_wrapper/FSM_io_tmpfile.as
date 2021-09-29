package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_io_tmpfile extends Machine
   {
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i10:int;
      
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
      
      public function FSM_io_tmpfile()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_io_tmpfile = null;
         _loc1_ = new FSM_io_tmpfile();
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
               mstate.esp -= 20512;
               this.i0 = 4;
               mstate.esp -= 8;
               this.i2 = li32(mstate.ebp + 8);
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_lua_newuserdata.start();
               return;
            case 1:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i0 = 0;
               si32(this.i0,this.i3);
               mstate.esp -= 8;
               this.i0 = -10000;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i1 = __2E_str17320;
               while(true)
               {
                  this.i4 = li8(this.i1 + 1);
                  this.i1 += 1;
                  this.i5 = this.i1;
                  if(this.i4 == 0)
                  {
                     break;
                  }
                  this.i1 = this.i5;
               }
               this.i4 = __2E_str17320;
               mstate.esp -= 12;
               this.i1 -= this.i4;
               si32(this.i2,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_luaS_newlstr.start();
               return;
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,mstate.ebp + -20512);
               this.i1 = 4;
               si32(this.i1,mstate.ebp + -20504);
               this.i4 = li32(this.i2 + 8);
               mstate.esp -= 16;
               this.i5 = mstate.ebp + -20512;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_luaV_gettable.start();
               return;
            case 4:
               mstate.esp += 16;
               this.i0 = li32(this.i2 + 8);
               this.i0 += 12;
               si32(this.i0,this.i2 + 8);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_lua_setmetatable.start();
            case 5:
               mstate.esp += 8;
               this.i0 = __2E_str876;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 4;
               this.i0 = __2E_str14274;
               si32(this.i0,mstate.esp);
               mstate.esp -= 4;
               FSM_getenv.start();
            case 6:
               this.i0 = mstate.eax;
               this.i1 = __2E_str7280;
               mstate.esp += 4;
               this.i0 = this.i0 == 0 ? int(this.i1) : int(this.i0);
               this.i1 = li8(this.i0);
               this.i4 = this.i2 + 8;
               this.i5 = this.i0;
               if(this.i1 != 0)
               {
                  this.i1 = this.i0;
                  while(true)
                  {
                     this.i6 = li8(this.i1 + 1);
                     this.i1 += 1;
                     this.i7 = this.i1;
                     if(this.i6 == 0)
                     {
                        break;
                     }
                     this.i1 = this.i7;
                  }
               }
               else
               {
                  this.i1 = this.i5;
               }
               this.i6 = __2E_str45;
               this.i0 = this.i1 - this.i0;
               this.i0 += this.i5;
               this.i0 = li8(this.i0 + -1);
               this.i1 = __2E_str5151;
               mstate.esp -= 16;
               this.i0 = this.i0 == 47 ? int(this.i6) : int(this.i1);
               this.i1 = __2E_str513;
               this.i6 = mstate.ebp + -20488;
               si32(this.i6,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               state = 11;
               mstate.esp -= 4;
               FSM_asprintf.start();
               return;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = __2E_str340;
               this.i1 = 4;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 20;
               this.i0 = __2E_str96;
               this.i1 = __2E_str138;
               this.i5 = 34;
               this.i6 = 78;
               this.i7 = mstate.ebp + -20480;
               si32(this.i7,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               si32(this.i5,mstate.esp + 16);
               state = 8;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 8:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i7;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i6,_val_2E_1440);
               addr641:
               this.i0 = 0;
               si32(this.i0,this.i3);
               this.i1 = li32(_val_2E_1440);
               this.i3 = li32(this.i4);
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.esp -= 12;
               this.i0 = _ebuf_2E_1986;
               this.i3 = 2048;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_strerror_r.start();
               break;
            case 11:
               mstate.esp += 16;
               this.i0 = li32(mstate.ebp + -20488);
               if(this.i0 != 0)
               {
                  this.i0 = __2E_str340;
                  this.i1 = 4;
                  log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                  mstate.esp -= 20;
                  this.i0 = __2E_str96;
                  this.i1 = __2E_str138;
                  this.i5 = 34;
                  this.i6 = 78;
                  this.i7 = mstate.ebp + -4096;
                  si32(this.i7,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  si32(this.i6,mstate.esp + 8);
                  si32(this.i1,mstate.esp + 12);
                  si32(this.i5,mstate.esp + 16);
                  state = 12;
                  mstate.esp -= 4;
                  FSM_sprintf.start();
                  return;
               }
               addr640:
               §§goto(addr641);
               break;
            case 17:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i8;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i7,_val_2E_1440);
               this.i0 = this.i5;
               state = 18;
            case 18:
               this.i0 = mstate.system.close(this.i0);
               si32(this.i7,_val_2E_1440);
               §§goto(addr640);
            case 9:
               break;
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i4);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i0);
               this.i1 = 3;
               si32(this.i1,this.i0 + 8);
               this.i0 = li32(this.i4);
               this.i0 += 12;
               si32(this.i0,this.i4);
               mstate.eax = this.i1;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 12:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i7;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i6,_val_2E_1440);
               this.i0 = li32(mstate.ebp + -20488);
               mstate.esp -= 8;
               this.i1 = mstate.ebp + -20484;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 13;
               mstate.esp -= 4;
               FSM__gettemp.start();
               return;
            case 13:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i1 = li32(mstate.ebp + -20484);
               this.i5 = this.i0 == 0 ? -1 : int(this.i1);
               if(this.i5 != -1)
               {
                  this.i0 = __2E_str26;
                  this.i6 = 4;
                  this.i1 = this.i6;
                  log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                  mstate.esp -= 20;
                  this.i7 = __2E_str96;
                  this.i0 = __2E_str13;
                  this.i1 = 400;
                  this.i8 = 78;
                  this.i9 = mstate.ebp + -8192;
                  si32(this.i9,mstate.esp);
                  si32(this.i7,mstate.esp + 4);
                  si32(this.i8,mstate.esp + 8);
                  si32(this.i0,mstate.esp + 12);
                  si32(this.i1,mstate.esp + 16);
                  state = 14;
                  mstate.esp -= 4;
                  FSM_sprintf.start();
                  return;
               }
               this.i0 = 0;
               this.i1 = li32(mstate.ebp + -20488);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 7;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
               break;
            case 14:
               mstate.esp += 20;
               this.i10 = 3;
               this.i0 = this.i9;
               this.i1 = this.i10;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i8,_val_2E_1440);
               this.i0 = li32(mstate.ebp + -20488);
               mstate.esp -= 8;
               this.i1 = 0;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 15;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
            case 15:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i0 = __2E_str340;
               this.i1 = this.i6;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 20;
               this.i0 = __2E_str138;
               this.i1 = 34;
               this.i6 = mstate.ebp + -12288;
               si32(this.i6,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i8,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               si32(this.i1,mstate.esp + 16);
               state = 16;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 16:
               mstate.esp += 20;
               this.i0 = this.i6;
               this.i1 = this.i10;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i8,_val_2E_1440);
               this.i0 = li8(_nofile_2E_3458_2E_b);
               if(this.i0 == 0)
               {
                  this.i0 = __2E_str270;
                  this.i1 = 4;
                  this.i6 = 1;
                  log(this.i1,mstate.gworker.stringFromPtr(this.i0));
                  si8(this.i6,_nofile_2E_3458_2E_b);
               }
               this.i0 = __2E_str32;
               this.i1 = 4;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 20;
               this.i0 = __2E_str96;
               this.i1 = __2E_str13;
               this.i6 = 345;
               this.i7 = 78;
               this.i8 = mstate.ebp + -16384;
               si32(this.i8,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i7,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               si32(this.i6,mstate.esp + 16);
               state = 17;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            default:
               throw "Invalid state in _io_tmpfile";
         }
         this.i0 = mstate.eax;
         mstate.esp += 12;
         if(this.i0 != 0)
         {
            this.i0 = 22;
            si32(this.i0,_val_2E_1440);
         }
         this.i0 = __2E_str54344;
         mstate.esp -= 12;
         this.i3 = _ebuf_2E_1986;
         si32(this.i2,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i3,mstate.esp + 8);
         state = 10;
         mstate.esp -= 4;
         FSM_lua_pushfstring.start();
      }
   }
}
