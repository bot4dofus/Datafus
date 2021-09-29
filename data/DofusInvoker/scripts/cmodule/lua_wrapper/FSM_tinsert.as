package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_tinsert extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public function FSM_tinsert()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_tinsert = null;
         _loc1_ = new FSM_tinsert();
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
               this.i2 = li32(this.i1 + 8);
               this.i3 = li32(this.i1 + 12);
               this.i2 -= this.i3;
               this.i2 /= 12;
               this.i3 = this.i1 + 8;
               this.i4 = this.i0 + 1;
               if(this.i2 == 3)
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
               if(this.i2 != 2)
               {
                  this.i0 = __2E_str10425;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 9;
                  mstate.esp -= 4;
                  FSM_luaL_error.start();
                  return;
               }
               this.i0 = this.i4;
               §§goto(addr246);
               break;
            case 4:
               mstate.esp += 12;
               §§goto(addr587);
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               if(this.i2 >= this.i4)
               {
                  §§goto(addr346);
               }
               else
               {
                  addr352:
                  this.i4 = 1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i4,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               break;
            case 8:
               mstate.esp += 12;
               this.i4 = this.i0 + -1;
               if(this.i0 <= this.i2)
               {
                  addr346:
                  this.i0 = this.i2;
                  addr246:
                  this.i2 = 1;
                  mstate.esp -= 12;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_lua_rawseti.start();
                  return;
               }
               this.i0 = this.i4;
               §§goto(addr352);
            case 6:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               this.i5 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i5,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_getnum.start();
               break;
            case 7:
               break;
            case 9:
               mstate.esp += 8;
               addr587:
               this.i0 = 0;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _tinsert";
         }
         this.i5 = mstate.eax;
         mstate.esp += 8;
         this.i6 = li32(this.i3);
         this.f0 = lf64(this.i5);
         sf64(this.f0,this.i6);
         this.i5 = li32(this.i5 + 8);
         si32(this.i5,this.i6 + 8);
         this.i5 = li32(this.i3);
         this.i5 += 12;
         si32(this.i5,this.i3);
         mstate.esp -= 12;
         this.i5 = this.i0 + 1;
         si32(this.i1,mstate.esp);
         si32(this.i4,mstate.esp + 4);
         si32(this.i5,mstate.esp + 8);
         state = 8;
         mstate.esp -= 4;
         FSM_lua_rawseti.start();
      }
   }
}
