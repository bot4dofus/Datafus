package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_io_pclose extends Machine
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
      
      public function FSM_io_pclose()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_io_pclose = null;
         _loc1_ = new FSM_io_pclose();
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
               mstate.esp -= 4096;
               this.i0 = __2E_str17320;
               mstate.esp -= 8;
               this.i2 = li32(mstate.ebp + 8);
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_checkudata.start();
               return;
            case 1:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i3);
               this.i1 = _pidlist;
               this.i4 = 0;
               while(true)
               {
                  this.i5 = this.i4;
                  this.i4 = this.i1;
                  this.i4 = li32(this.i4);
                  if(this.i4 != 0)
                  {
                     this.i1 = li32(this.i4 + 4);
                     if(this.i1 == this.i0)
                     {
                        if(this.i4 != 0)
                        {
                           this.i1 = li32(this.i4);
                           if(this.i5 == 0)
                           {
                              si32(this.i1,_pidlist);
                           }
                           else
                           {
                              si32(this.i1,this.i5);
                           }
                           this.i1 = __2E_str92;
                           mstate.esp -= 4;
                           si32(this.i0,mstate.esp);
                           state = 2;
                           mstate.esp -= 4;
                           FSM_fclose.start();
                           return;
                        }
                     }
                     continue;
                     break;
                  }
                  break;
               }
               addr356:
               this.i0 = 0;
               si32(this.i0,this.i3);
               this.i1 = li32(_val_2E_1440);
               this.i3 = li32(this.i2 + 8);
               si32(this.i0,this.i3 + 8);
               this.i0 = li32(this.i2 + 8);
               this.i0 += 12;
               si32(this.i0,this.i2 + 8);
               mstate.esp -= 12;
               this.i0 = _ebuf_2E_1986;
               this.i3 = 2048;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_strerror_r.start();
               break;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr356);
            case 5:
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i5 = 4;
               this.i0 = this.i1;
               this.i1 = this.i5;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               mstate.esp -= 20;
               this.i0 = __2E_str96;
               this.i1 = __2E_str193;
               this.i5 = 24;
               this.i6 = 78;
               this.i7 = mstate.ebp + -4096;
               si32(this.i7,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i1,mstate.esp + 12);
               si32(this.i5,mstate.esp + 16);
               state = 3;
               mstate.esp -= 4;
               FSM_sprintf.start();
               return;
            case 3:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i7;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i6,_val_2E_1440);
               mstate.esp -= 8;
               this.i0 = 0;
               si32(this.i4,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               FSM_pubrealloc.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i0 = li32(this.i3);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i0);
               this.i1 = 3;
               si32(this.i1,this.i0 + 8);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.eax = this.i1;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _io_pclose";
         }
         this.i0 = mstate.eax;
         mstate.esp += 12;
         this.i3 = this.i2 + 8;
         if(this.i0 != 0)
         {
            this.i0 = 22;
            si32(this.i0,_val_2E_1440);
         }
         this.i0 = __2E_str54344;
         mstate.esp -= 12;
         this.i4 = _ebuf_2E_1986;
         si32(this.i2,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         si32(this.i4,mstate.esp + 8);
         state = 6;
         mstate.esp -= 4;
         FSM_lua_pushfstring.start();
      }
   }
}
