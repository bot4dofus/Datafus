package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_fclose extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_fclose()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_fclose = null;
         _loc1_ = new FSM_fclose();
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
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li16(this.i0 + 12);
               this.i2 = this.i0 + 12;
               if(this.i1 == 0)
               {
                  this.i0 = 9;
                  si32(this.i0,_val_2E_1440);
                  this.i0 = -1;
                  mstate.eax = this.i0;
                  §§goto(addr69);
               }
               else
               {
                  this.i1 &= 8;
                  if(this.i1 != 0)
                  {
                     mstate.esp -= 4;
                     si32(this.i0,mstate.esp);
                     state = 1;
                     mstate.esp -= 4;
                     FSM___sflush.start();
                     return;
                  }
                  this.i1 = 0;
                  addr144:
                  this.i3 = li32(this.i0 + 32);
                  if(this.i3 != 0)
                  {
                     this.i4 = li32(this.i0 + 28);
                     mstate.esp -= 4;
                     si32(this.i4,mstate.esp);
                     state = 2;
                     mstate.esp -= 4;
                     mstate.funcs[this.i3]();
                     return;
                  }
                  addr214:
                  this.i3 = li16(this.i2);
                  this.i3 &= 128;
                  if(this.i3 != 0)
                  {
                     this.i3 = 0;
                     this.i4 = li32(this.i0 + 16);
                     mstate.esp -= 8;
                     si32(this.i4,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
                  addr281:
                  this.i3 = li32(this.i0 + 48);
                  this.i4 = this.i0 + 48;
                  if(this.i3 != 0)
                  {
                     this.i5 = this.i0 + 64;
                     if(this.i3 != this.i5)
                     {
                        this.i5 = 0;
                        mstate.esp -= 8;
                        si32(this.i3,mstate.esp);
                        si32(this.i5,mstate.esp + 4);
                        state = 4;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     addr355:
                     this.i3 = 0;
                     si32(this.i3,this.i4);
                  }
                  this.i3 = li32(this.i0 + 68);
                  this.i4 = this.i0 + 68;
                  if(this.i3 != 0)
                  {
                     this.i5 = 0;
                     mstate.esp -= 8;
                     si32(this.i3,mstate.esp);
                     si32(this.i5,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_pubrealloc.start();
                     return;
                  }
                  break;
                  addr159:
               }
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               §§goto(addr144);
            case 2:
               this.i3 = mstate.eax;
               mstate.esp += 4;
               if(this.i3 <= -1)
               {
                  this.i1 = -1;
               }
               else
               {
                  §§goto(addr159);
               }
               §§goto(addr214);
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr281);
            case 4:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr355);
            case 5:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               si32(this.i5,this.i4);
               break;
            default:
               throw "Invalid state in _fclose";
         }
         this.i3 = -1;
         si16(this.i3,this.i0 + 14);
         this.i3 = 0;
         si32(this.i3,this.i0 + 8);
         si32(this.i3,this.i0 + 4);
         si16(this.i3,this.i2);
         mstate.eax = this.i1;
         addr69:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
