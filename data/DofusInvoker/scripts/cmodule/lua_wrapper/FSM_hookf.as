package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_hookf extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_hookf()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_hookf = null;
         _loc1_ = new FSM_hookf();
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
               this.i0 = _KEY_HOOK;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               si32(this.i0,this.i2);
               this.i0 = 2;
               si32(this.i0,this.i2 + 8);
               this.i2 = li32(this.i1 + 8);
               this.i2 += 12;
               si32(this.i2,this.i1 + 8);
               mstate.esp -= 8;
               this.i2 = -10000;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i1 + 8);
               this.i2 = li32(this.i2);
               mstate.esp -= 8;
               this.i4 = this.i3 + -12;
               si32(this.i2,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_get.start();
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.f0 = lf64(this.i2);
               sf64(this.f0,this.i3 + -12);
               this.i2 = li32(this.i2 + 8);
               si32(this.i2,this.i3 + -4);
               this.i2 = li32(this.i1 + 8);
               si32(this.i1,this.i2);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 8;
               this.i0 = -2;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 8);
               this.i0 = li32(this.i0);
               mstate.esp -= 8;
               this.i3 = this.i2 + -12;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_luaH_get.start();
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2 + -12);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + -4);
               mstate.esp -= 8;
               this.i0 = -1;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = this.i1 + 8;
               this.i3 = li32(mstate.ebp + 12);
               this.i4 = _luaO_nilobject_;
               if(this.i0 != this.i4)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 6)
                  {
                     this.i0 = _hooknames_2E_2751;
                     this.i4 = li32(this.i3);
                     this.i4 <<= 2;
                     this.i0 += this.i4;
                     this.i0 = li32(this.i0);
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 6;
                     mstate.esp -= 4;
                     FSM_lua_pushstring.start();
                     return;
                  }
                  break;
               }
               break;
            case 6:
               mstate.esp += 8;
               this.i0 = li32(this.i3 + 20);
               this.i3 = li32(this.i2);
               if(this.i0 >= 0)
               {
                  this.i4 = 3;
                  this.f0 = Number(this.i0);
                  sf64(this.f0,this.i3);
                  si32(this.i4,this.i3 + 8);
                  this.i3 = li32(this.i2);
                  this.i0 = this.i3 + 12;
                  si32(this.i0,this.i2);
                  mstate.esp -= 12;
                  this.i2 = 0;
                  this.i3 += -24;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
               }
               else
               {
                  this.i0 = 0;
                  si32(this.i0,this.i3 + 8);
                  this.i3 = li32(this.i2);
                  this.i4 = this.i3 + 12;
                  si32(this.i4,this.i2);
                  mstate.esp -= 12;
                  this.i2 = this.i3 + -24;
                  si32(this.i1,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
               }
               state = 7;
               mstate.esp -= 4;
               FSM_luaD_call.start();
               return;
            case 7:
               mstate.esp += 12;
               break;
            default:
               throw "Invalid state in _hookf";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
