package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_load extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public function FSM_luaB_load()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_load = null;
         _loc1_ = new FSM_luaB_load();
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
               mstate.esp -= 64;
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
               this.i2 = _luaO_nilobject_;
               if(this.i0 != this.i2)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 >= 1)
                  {
                     this.i0 = 0;
                     mstate.esp -= 12;
                     this.i2 = 2;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_luaL_checklstring.start();
                     return;
                  }
               }
               this.i0 = __2E_str52342;
               addr157:
               this.i2 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr157);
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 == 6)
                  {
                     break;
                  }
               }
               this.i2 = 6;
               mstate.esp -= 12;
               this.i3 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_tag_error.start();
               return;
            case 4:
               mstate.esp += 12;
               break;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 20;
               this.i2 = li32(this.i1 + 16);
               this.i4 = li32(mstate.ebp + -20);
               this.i5 = li32(mstate.ebp + -28);
               this.i6 = li32(this.i2 + 12);
               this.i7 = li32(this.i2 + 16);
               mstate.esp -= 16;
               si32(this.i7,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               state = 6;
               mstate.esp -= 4;
               mstate.funcs[this.i6]();
               return;
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 16;
               this.i3 = li32(this.i2 + 68);
               this.i3 -= this.i4;
               si32(this.i3,this.i2 + 68);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_load_aux.start();
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _luaB_load";
         }
         this.i2 = li32(this.i1 + 12);
         this.i3 = li32(this.i1 + 8);
         this.i4 = this.i1 + 12;
         this.i5 = this.i1 + 8;
         this.i6 = this.i2 + 36;
         if(uint(this.i3) >= uint(this.i6))
         {
            this.i3 = this.i2;
         }
         else
         {
            do
            {
               this.i2 = 0;
               si32(this.i2,this.i3 + 8);
               this.i3 += 12;
               si32(this.i3,this.i5);
               this.i2 = li32(this.i4);
               this.i6 = this.i2 + 36;
            }
            while(uint(this.i3) < uint(this.i6));
            
            this.i3 = this.i2;
         }
         this.i2 = this.i3;
         this.i3 = _generic_reader;
         this.i2 += 36;
         si32(this.i2,this.i5);
         si32(this.i1,mstate.ebp + -48);
         si32(this.i3,mstate.ebp + -56);
         this.i3 = 0;
         si32(this.i3,mstate.ebp + -52);
         si32(this.i3,mstate.ebp + -64);
         si32(this.i3,mstate.ebp + -60);
         this.i4 = mstate.ebp + -64;
         this.i5 = __2E_str6354;
         si32(this.i4,mstate.ebp + -32);
         this.i0 = this.i0 == 0 ? int(this.i5) : int(this.i0);
         si32(this.i0,mstate.ebp + -16);
         si32(this.i3,mstate.ebp + -28);
         si32(this.i3,mstate.ebp + -20);
         this.i0 = li32(this.i1 + 32);
         this.i4 = li32(this.i1 + 108);
         mstate.esp -= 20;
         this.i5 = _f_parser;
         this.i0 = this.i2 - this.i0;
         this.i2 = mstate.ebp + -32;
         si32(this.i1,mstate.esp);
         si32(this.i5,mstate.esp + 4);
         si32(this.i2,mstate.esp + 8);
         si32(this.i0,mstate.esp + 12);
         si32(this.i4,mstate.esp + 16);
         state = 5;
         mstate.esp -= 4;
         FSM_luaD_pcall.start();
      }
   }
}
