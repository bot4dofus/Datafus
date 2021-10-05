package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaB_pairs extends Machine
   {
      
      public static const intRegCount:int = 3;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public function FSM_luaB_pairs()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaB_pairs = null;
         _loc1_ = new FSM_luaB_pairs();
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
                     addr145:
                     this.i0 = -10003;
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     this.i2 = li32(this.i1 + 8);
                     this.f0 = lf64(this.i0);
                     sf64(this.f0,this.i2);
                     this.i0 = li32(this.i0 + 8);
                     si32(this.i0,this.i2 + 8);
                     this.i0 = li32(this.i1 + 8);
                     this.i0 += 12;
                     si32(this.i0,this.i1 + 8);
                     mstate.esp -= 8;
                     this.i0 = 1;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_index2adr.start();
                     break;
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
               §§goto(addr145);
            case 3:
               §§goto(addr145);
            case 4:
               break;
            default:
               throw "Invalid state in _luaB_pairs";
         }
         this.i0 = mstate.eax;
         mstate.esp += 8;
         this.i2 = li32(this.i1 + 8);
         this.f0 = lf64(this.i0);
         sf64(this.f0,this.i2);
         this.i0 = li32(this.i0 + 8);
         si32(this.i0,this.i2 + 8);
         this.i0 = li32(this.i1 + 8);
         this.i2 = this.i0 + 12;
         si32(this.i2,this.i1 + 8);
         this.i2 = 0;
         si32(this.i2,this.i0 + 20);
         this.i0 = li32(this.i1 + 8);
         this.i0 += 12;
         si32(this.i0,this.i1 + 8);
         this.i0 = 3;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
