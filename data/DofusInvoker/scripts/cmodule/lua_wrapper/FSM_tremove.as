package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_tremove extends Machine
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
      
      public function FSM_tremove()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_tremove = null;
         _loc1_ = new FSM_tremove();
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
                  if(this.i0 == 5)
                  {
                     §§goto(addr145);
                  }
               }
               this.i0 = 5;
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
               addr145:
               this.i0 = 1;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_lua_objlen.start();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 8;
               this.i2 = 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i2 != this.i3)
               {
                  this.i2 = li32(this.i2 + 8);
                  if(this.i2 >= 1)
                  {
                     this.i2 = 2;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_luaL_checkinteger.start();
                     return;
                  }
               }
               this.i2 = this.i0;
               §§goto(addr303);
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr303);
            case 6:
               §§goto(addr344);
            case 7:
               §§goto(addr344);
            case 10:
               mstate.esp += 12;
               this.i4 += 1;
               if(this.i4 != this.i6)
               {
                  §§goto(addr477);
               }
               else
               {
                  §§goto(addr675);
               }
            case 8:
               §§goto(addr477);
            case 9:
               break;
            case 11:
               mstate.esp += 12;
               mstate.eax = this.i2;
               addr303:
               if(this.i2 >= 1)
               {
                  if(this.i2 <= this.i0)
                  {
                     this.i3 = 1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i3,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     addr344:
                     this.i3 = mstate.eax;
                     mstate.esp += 8;
                     this.i3 = li32(this.i3);
                     mstate.esp -= 8;
                     si32(this.i3,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_luaH_getnum.start();
                     this.i3 = mstate.eax;
                     mstate.esp += 8;
                     this.i4 = li32(this.i1 + 8);
                     this.f0 = lf64(this.i3);
                     sf64(this.f0,this.i4);
                     this.i3 = li32(this.i3 + 8);
                     si32(this.i3,this.i4 + 8);
                     this.i3 = li32(this.i1 + 8);
                     this.i3 += 12;
                     si32(this.i3,this.i1 + 8);
                     this.i3 = this.i1 + 8;
                     if(this.i2 < this.i0)
                     {
                        this.i4 = 0;
                        this.i5 = this.i2 + 1;
                        this.i6 = this.i0 - this.i2;
                        addr477:
                        this.i7 = 1;
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i7,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM_index2adr.start();
                        this.i8 = mstate.eax;
                        mstate.esp += 8;
                        this.i8 = li32(this.i8);
                        mstate.esp -= 8;
                        this.i9 = this.i5 + this.i4;
                        si32(this.i8,mstate.esp);
                        si32(this.i9,mstate.esp + 4);
                        mstate.esp -= 4;
                        FSM_luaH_getnum.start();
                        break;
                     }
                     addr675:
                     this.i2 = 0;
                     this.i4 = li32(this.i3);
                     si32(this.i2,this.i4 + 8);
                     this.i2 = li32(this.i3);
                     this.i2 += 12;
                     si32(this.i2,this.i3);
                     mstate.esp -= 12;
                     this.i2 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     si32(this.i0,mstate.esp + 8);
                     state = 11;
                     mstate.esp -= 4;
                     FSM_lua_rawseti.start();
                     return;
                  }
               }
               this.i0 = 0;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _tremove";
         }
         this.i8 = mstate.eax;
         mstate.esp += 8;
         this.i9 = li32(this.i3);
         this.f0 = lf64(this.i8);
         sf64(this.f0,this.i9);
         this.i8 = li32(this.i8 + 8);
         si32(this.i8,this.i9 + 8);
         this.i8 = li32(this.i3);
         this.i8 += 12;
         si32(this.i8,this.i3);
         mstate.esp -= 12;
         this.i8 = this.i2 + this.i4;
         si32(this.i1,mstate.esp);
         si32(this.i7,mstate.esp + 4);
         si32(this.i8,mstate.esp + 8);
         state = 10;
         mstate.esp -= 4;
         FSM_lua_rawseti.start();
      }
   }
}
