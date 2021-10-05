package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaL_addvalue extends Machine
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
      
      public function FSM_luaL_addvalue()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaL_addvalue = null;
         _loc1_ = new FSM_luaL_addvalue();
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
               mstate.esp -= 4;
               this.i0 = mstate.ebp + -4;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = li32(this.i1 + 8);
               mstate.esp -= 12;
               this.i3 = -1;
               si32(this.i2,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i0,mstate.esp + 8);
               state = 1;
               mstate.esp -= 4;
               FSM_lua_tolstring.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               this.i3 = li32(this.i1);
               this.i4 = li32(mstate.ebp + -4);
               this.i5 = this.i1 + 1036;
               this.i6 = this.i1;
               this.i5 -= this.i3;
               if(uint(this.i5) >= uint(this.i4))
               {
                  this.i1 = this.i3;
                  this.i3 = this.i4;
                  memcpy(this.i1,this.i0,this.i3);
                  this.i1 = li32(this.i6);
                  this.i0 = li32(mstate.ebp + -4);
                  this.i1 += this.i0;
                  si32(this.i1,this.i6);
                  this.i1 = li32(this.i2 + 8);
                  this.i1 += -12;
                  si32(this.i1,this.i2 + 8);
                  break;
               }
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 2;
               mstate.esp -= 4;
               FSM_emptybuffer.start();
               return;
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               if(this.i0 != 0)
               {
                  this.i0 = -2;
                  mstate.esp -= 8;
                  si32(this.i2,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_index2adr.start();
                  addr292:
                  this.i0 = mstate.eax;
                  mstate.esp += 8;
                  this.i3 = li32(this.i2 + 8);
                  this.i2 += 8;
                  this.i4 = this.i3;
                  if(uint(this.i3) > uint(this.i0))
                  {
                     this.i5 = 0;
                     do
                     {
                        this.i6 = this.i5 ^ -1;
                        this.i6 *= 12;
                        this.i6 = this.i4 + this.i6;
                        this.f0 = lf64(this.i6);
                        sf64(this.f0,this.i3);
                        this.i7 = li32(this.i6 + 8);
                        si32(this.i7,this.i3 + 8);
                        this.i3 += -12;
                        this.i5 += 1;
                     }
                     while(uint(this.i6) > uint(this.i0));
                     
                  }
                  this.i2 = li32(this.i2);
                  this.f0 = lf64(this.i2);
                  sf64(this.f0,this.i0);
                  this.i2 = li32(this.i2 + 8);
                  si32(this.i2,this.i0 + 8);
               }
               this.i0 = li32(this.i1 + 4);
               this.i0 += 1;
               si32(this.i0,this.i1 + 4);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 4;
               mstate.esp -= 4;
               FSM_adjuststack.start();
               return;
            case 3:
               §§goto(addr292);
            case 4:
               mstate.esp += 4;
               break;
            default:
               throw "Invalid state in _luaL_addvalue";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
