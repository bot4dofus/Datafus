package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_resume extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_resume()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_resume = null;
         _loc1_ = new FSM_resume();
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
               this.i1 = li8(this.i0 + 6);
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = this.i0 + 6;
               if(this.i1 == 0)
               {
                  this.i3 = -1;
                  mstate.esp -= 12;
                  this.i2 += -12;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i3,mstate.esp + 8);
                  state = 1;
                  mstate.esp -= 4;
                  FSM_luaD_precall.start();
                  return;
               }
               this.i1 = 0;
               this.i4 = li32(this.i0 + 20);
               si8(this.i1,this.i3);
               this.i1 = li32(this.i4 + 4);
               this.i1 = li32(this.i1);
               this.i1 = li8(this.i1 + 6);
               this.i3 = this.i0 + 20;
               if(this.i1 != 0)
               {
                  mstate.esp -= 8;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_luaD_poscall.start();
                  return;
               }
               this.i1 = li32(this.i4);
               si32(this.i1,this.i0 + 12);
               break;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 12;
               if(this.i2 == 0)
               {
                  break;
               }
               §§goto(addr309);
               break;
            case 2:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               if(this.i4 != 0)
               {
                  this.i4 = li32(this.i3);
                  this.i4 = li32(this.i4 + 8);
                  si32(this.i4,this.i0 + 8);
                  break;
               }
               break;
            case 3:
               mstate.esp += 8;
               addr309:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _resume";
         }
         this.i1 = li32(this.i0 + 20);
         this.i2 = li32(this.i0 + 40);
         this.i1 -= this.i2;
         mstate.esp -= 8;
         this.i1 /= 24;
         si32(this.i0,mstate.esp);
         si32(this.i1,mstate.esp + 4);
         state = 3;
         mstate.esp -= 4;
         FSM_luaV_execute.start();
      }
   }
}
