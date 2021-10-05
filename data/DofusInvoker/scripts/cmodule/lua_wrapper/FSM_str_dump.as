package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_str_dump extends Machine
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
      
      public function FSM_str_dump()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_str_dump = null;
         _loc1_ = new FSM_str_dump();
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
               mstate.esp -= 1088;
               this.i0 = 1;
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
                  if(this.i0 == 6)
                  {
                     addr145:
                     this.i0 = li32(this.i1 + 12);
                     this.i2 = li32(this.i1 + 8);
                     this.i3 = this.i1 + 12;
                     this.i4 = this.i1 + 8;
                     this.i5 = this.i0 + 12;
                     if(uint(this.i2) >= uint(this.i5))
                     {
                        this.i2 = this.i0;
                     }
                     else
                     {
                        while(true)
                        {
                           this.i0 = 0;
                           si32(this.i0,this.i2 + 8);
                           this.i0 = this.i2 + 12;
                           si32(this.i0,this.i4);
                           this.i5 = li32(this.i3);
                           if(this.i2 >= this.i5)
                           {
                              break;
                           }
                           this.i2 = this.i0;
                        }
                        this.i2 = this.i5;
                     }
                     this.i0 = this.i2;
                     this.i2 = mstate.ebp + -1088;
                     this.i3 = this.i0 + 12;
                     si32(this.i3,this.i4);
                     si32(this.i1,mstate.ebp + -1080);
                     this.i3 = this.i2 + 12;
                     si32(this.i3,mstate.ebp + -1088);
                     this.i3 = 0;
                     si32(this.i3,mstate.ebp + -1084);
                     this.i3 = li32(this.i0 + 8);
                     this.i4 = this.i2 + 4;
                     this.i5 = this.i2 + 8;
                     if(this.i3 == 6)
                     {
                        this.i0 = li32(this.i0);
                        this.i3 = li8(this.i0 + 6);
                        if(this.i3 != 0)
                        {
                           break;
                        }
                        this.i3 = _writer;
                        this.i0 = li32(this.i0 + 16);
                        si32(this.i1,mstate.ebp + -32);
                        si32(this.i3,mstate.ebp + -28);
                        si32(this.i2,mstate.ebp + -24);
                        this.i2 = 0;
                        si32(this.i2,mstate.ebp + -20);
                        si32(this.i2,mstate.ebp + -16);
                        this.i3 = 27;
                        this.i6 = 76;
                        this.i7 = 117;
                        this.i8 = 97;
                        si8(this.i3,mstate.ebp + -48);
                        si8(this.i6,mstate.ebp + -47);
                        si8(this.i7,mstate.ebp + -46);
                        si8(this.i8,mstate.ebp + -45);
                        this.i3 = 81;
                        si8(this.i3,mstate.ebp + -44);
                        si8(this.i2,mstate.ebp + -43);
                        this.i3 = 1;
                        si8(this.i3,mstate.ebp + -42);
                        this.i3 = 4;
                        si8(this.i3,mstate.ebp + -41);
                        si8(this.i3,mstate.ebp + -40);
                        si8(this.i3,mstate.ebp + -39);
                        this.i3 = 8;
                        si8(this.i3,mstate.ebp + -38);
                        this.i3 = mstate.ebp + -32;
                        si8(this.i2,mstate.ebp + -37);
                        this.i2 = li32(mstate.ebp + -16);
                        this.i6 = mstate.ebp + -48;
                        this.i7 = this.i3 + 16;
                        this.i8 = this.i3 + 8;
                        this.i9 = this.i3 + 4;
                        if(this.i2 == 0)
                        {
                           this.i2 = 12;
                           this.i9 = li32(this.i9);
                           this.i8 = li32(this.i8);
                           this.i3 = li32(this.i3);
                           mstate.esp -= 16;
                           si32(this.i3,mstate.esp);
                           si32(this.i6,mstate.esp + 4);
                           si32(this.i2,mstate.esp + 8);
                           si32(this.i8,mstate.esp + 12);
                           state = 3;
                           mstate.esp -= 4;
                           mstate.funcs[this.i9]();
                           return;
                        }
                        §§goto(addr612);
                     }
                     break;
                  }
               }
               this.i0 = 6;
               mstate.esp -= 12;
               this.i2 = 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_tag_error.start();
               return;
            case 2:
               mstate.esp += 12;
               §§goto(addr145);
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               si32(this.i2,this.i7);
               addr612:
               this.i2 = mstate.ebp + -32;
               mstate.esp -= 12;
               this.i3 = 0;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 4;
               mstate.esp -= 4;
               FSM_DumpFunction.start();
               return;
            case 4:
               mstate.esp += 12;
               this.i0 = li32(this.i7);
               if(this.i0 != 0)
               {
                  break;
               }
               this.i0 = mstate.ebp + -1088;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 8;
               mstate.esp -= 4;
               FSM_emptybuffer.start();
               return;
               break;
            case 5:
               mstate.esp += 8;
               mstate.esp -= 4;
               this.i0 = mstate.ebp + -1088;
               si32(this.i0,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               FSM_emptybuffer.start();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i4 = li32(this.i4);
               this.i5 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i5,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               state = 7;
               mstate.esp -= 4;
               FSM_lua_concat.start();
               return;
            case 7:
               mstate.esp += 8;
               this.i4 = 1;
               mstate.eax = this.i4;
               §§goto(addr905);
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i0 = li32(this.i4);
               this.i1 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               FSM_lua_concat.start();
               return;
            case 9:
               mstate.esp += 8;
               this.i0 = 1;
               mstate.eax = this.i0;
               addr905:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _str_dump";
         }
         this.i0 = __2E_str18448;
         mstate.esp -= 8;
         si32(this.i1,mstate.esp);
         si32(this.i0,mstate.esp + 4);
         state = 5;
         mstate.esp -= 4;
         FSM_luaL_error.start();
      }
   }
}
