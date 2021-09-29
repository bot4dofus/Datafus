package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_gmatch_aux extends Machine
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
      
      public function FSM_gmatch_aux()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_gmatch_aux = null;
         _loc1_ = new FSM_gmatch_aux();
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
               mstate.esp -= 276;
               this.i0 = mstate.ebp + -276;
               mstate.esp -= 12;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = -10003;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 12;
               this.i2 = -10004;
               this.i3 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               state = 2;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               si32(this.i1,mstate.ebp + -264);
               si32(this.i0,mstate.ebp + -272);
               this.i3 = li32(mstate.ebp + -276);
               this.i3 = this.i0 + this.i3;
               si32(this.i3,mstate.ebp + -268);
               mstate.esp -= 8;
               this.i3 = -10005;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               FSM_lua_tointeger.start();
               return;
            case 3:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = mstate.ebp + -272;
               this.i5 = li32(mstate.ebp + -268);
               this.i4 += 4;
               this.i6 = this.i0 + this.i3;
               if(uint(this.i5) < uint(this.i6))
               {
                  addr550:
                  this.i0 = 0;
                  mstate.eax = this.i0;
                  break;
               }
               this.i5 = mstate.ebp + -272;
               this.i3 += this.i0;
               this.i5 += 12;
               §§goto(addr280);
               break;
            case 4:
               this.i6 = mstate.eax;
               mstate.esp += 12;
               this.i7 = this.i3;
               if(this.i6 != 0)
               {
                  this.i3 = 3;
                  this.i2 = this.i6 == this.i7 ? 1 : 0;
                  this.i2 &= 1;
                  this.i0 = this.i6 - this.i0;
                  this.i0 += this.i2;
                  this.i2 = li32(this.i1 + 8);
                  this.f0 = Number(this.i0);
                  sf64(this.f0,this.i2);
                  si32(this.i3,this.i2 + 8);
                  this.i3 = li32(this.i1 + 8);
                  this.i3 += 12;
                  si32(this.i3,this.i1 + 8);
                  mstate.esp -= 8;
                  this.i3 = -10005;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_lua_replace.start();
                  return;
               }
               this.i6 = li32(this.i4);
               this.i3 += 1;
               if(uint(this.i6) >= uint(this.i3))
               {
                  addr280:
                  this.i6 = 0;
                  si32(this.i6,this.i5);
                  mstate.esp -= 12;
                  this.i6 = mstate.ebp + -272;
                  si32(this.i6,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_match384.start();
                  return;
               }
               §§goto(addr550);
               break;
            case 5:
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i3 = mstate.ebp + -272;
               si32(this.i3,mstate.esp);
               si32(this.i7,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_push_captures.start();
               return;
            case 6:
               this.i3 = mstate.eax;
               mstate.esp += 12;
               mstate.eax = this.i3;
               break;
            default:
               throw "Invalid state in _gmatch_aux";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
