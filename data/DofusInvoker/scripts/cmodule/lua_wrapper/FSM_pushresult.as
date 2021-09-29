package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_pushresult extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
      
      public function FSM_pushresult()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_pushresult = null;
         _loc1_ = new FSM_pushresult();
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
               this.i1 = li32(_val_2E_1440);
               this.i2 = li32(this.i0 + 8);
               this.i3 = this.i0 + 8;
               this.i4 = li32(mstate.ebp + 16);
               this.i5 = li32(mstate.ebp + 12);
               if(this.i5 != 0)
               {
                  this.i0 = 1;
                  si32(this.i0,this.i2);
                  si32(this.i0,this.i2 + 8);
                  this.i1 = li32(this.i3);
                  this.i1 += 12;
                  si32(this.i1,this.i3);
                  mstate.eax = this.i0;
                  break;
               }
               this.i5 = 0;
               si32(this.i5,this.i2 + 8);
               this.i2 = li32(this.i3);
               this.i2 += 12;
               si32(this.i2,this.i3);
               mstate.esp -= 12;
               this.i2 = _ebuf_2E_1986;
               this.i5 = 2048;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i5,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_strerror_r.start();
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i2 != 0)
               {
                  this.i2 = 22;
                  si32(this.i2,_val_2E_1440);
               }
               if(this.i4 != 0)
               {
                  this.i2 = __2E_str15318;
                  mstate.esp -= 16;
                  this.i5 = _ebuf_2E_1986;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i4,mstate.esp + 8);
                  si32(this.i5,mstate.esp + 12);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_lua_pushfstring.start();
                  return;
               }
               this.i2 = __2E_str54344;
               mstate.esp -= 12;
               this.i4 = _ebuf_2E_1986;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               state = 3;
               mstate.esp -= 4;
               FSM_lua_pushfstring.start();
               return;
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               addr347:
               this.i0 = li32(this.i3);
               this.f0 = Number(this.i1);
               sf64(this.f0,this.i0);
               this.i1 = 3;
               si32(this.i1,this.i0 + 8);
               this.i0 = li32(this.i3);
               this.i0 += 12;
               si32(this.i0,this.i3);
               mstate.eax = this.i1;
               break;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr347);
            default:
               throw "Invalid state in _pushresult";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
