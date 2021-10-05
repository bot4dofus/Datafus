package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_maxn extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 2;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var i3:int;
      
      public function FSM_maxn()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_maxn = null;
         _loc1_ = new FSM_maxn();
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
               this.i0 = 0;
               this.i2 = li32(this.i1 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 3;
               mstate.esp -= 4;
               FSM_lua_next.start();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i1 + 8;
               if(this.i0 != 0)
               {
                  this.f0 = 0;
                  addr233:
                  this.i0 = -1;
                  this.i3 = li32(this.i2);
                  this.i3 += -12;
                  si32(this.i3,this.i2);
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
               }
               else
               {
                  this.f0 = 0;
                  §§goto(addr414);
               }
               break;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               if(this.i0 == 0)
               {
                  addr414:
                  this.i0 = 3;
                  this.i1 = li32(this.i2);
                  sf64(this.f0,this.i1);
                  si32(this.i0,this.i1 + 8);
                  this.i0 = li32(this.i2);
                  this.i0 += 12;
                  si32(this.i0,this.i2);
                  this.i0 = 1;
                  mstate.eax = this.i0;
                  mstate.esp = mstate.ebp;
                  mstate.ebp = li32(mstate.esp);
                  mstate.esp += 4;
                  mstate.esp += 4;
                  mstate.gworker = caller;
                  return;
               }
               §§goto(addr233);
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i3 = _luaO_nilobject_;
               if(this.i0 != this.i3)
               {
                  this.i0 = li32(this.i0 + 8);
                  if(this.i0 == 3)
                  {
                     this.i0 = -1;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 5;
                     mstate.esp -= 4;
                     FSM_lua_tonumber.start();
                     return;
                  }
                  break;
               }
               addr370:
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 6;
               mstate.esp -= 4;
               FSM_lua_next.start();
               return;
               addr302:
               break;
            case 5:
               this.f1 = mstate.st0;
               mstate.esp += 8;
               if(this.f1 <= this.f0)
               {
                  break;
               }
               this.f0 = this.f1;
               §§goto(addr370);
               break;
            default:
               throw "Invalid state in _maxn";
         }
         §§goto(addr302);
      }
   }
}
