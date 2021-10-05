package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_sort_comp extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_sort_comp()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_sort_comp = null;
         _loc1_ = new FSM_sort_comp();
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
               this.i0 = 2;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               this.i4 = _luaO_nilobject_;
               if(this.i0 != this.i4)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 0)
                  {
                     this.i0 = _luaO_nilobject_;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr584:
                     this.i2 = mstate.eax;
                     mstate.esp += 8;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr621:
                     this.i3 = mstate.eax;
                     mstate.esp += 8;
                     if(this.i3 != this.i0)
                     {
                        this.i0 = _luaO_nilobject_;
                        if(this.i2 != this.i0)
                        {
                           mstate.esp -= 12;
                           si32(this.i1,mstate.esp);
                           si32(this.i2,mstate.esp + 4);
                           si32(this.i3,mstate.esp + 8);
                           state = 9;
                           mstate.esp -= 4;
                           FSM_luaV_lessthan.start();
                           return;
                        }
                     }
                     this.i0 = 0;
                     mstate.eax = this.i0;
                     break;
                  }
               }
               this.i0 = 2;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i4 = li32(this.i1 + 8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i4);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i4 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 8;
               this.i2 += -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i0 = li32(this.i1 + 8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i0);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i0 + 8);
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               mstate.esp -= 8;
               this.i2 = this.i3 + -2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 8);
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i3);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i3 + 8);
               this.i2 = li32(this.i1 + 8);
               this.i3 = this.i2 + 12;
               si32(this.i3,this.i1 + 8);
               mstate.esp -= 12;
               this.i3 = 1;
               this.i2 += -24;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 5;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
            case 5:
               mstate.esp += 12;
               mstate.esp -= 8;
               this.i2 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 6:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i2 + 8);
               this.i1 += 8;
               if(this.i3 != 0)
               {
                  if(this.i3 != 1)
                  {
                     this.i2 = 1;
                  }
                  else
                  {
                     this.i2 = li32(this.i2);
                     this.i2 = this.i2 != 0 ? 1 : 0;
                     this.i2 &= 1;
                  }
               }
               else
               {
                  this.i2 = 0;
               }
               this.i3 = li32(this.i1);
               this.i3 += -12;
               si32(this.i3,this.i1);
               mstate.eax = this.i2;
               break;
            case 7:
               §§goto(addr584);
            case 8:
               §§goto(addr621);
            case 9:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr584);
            default:
               throw "Invalid state in _sort_comp";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
