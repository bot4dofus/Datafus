package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_read_chars extends Machine
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
      
      public function FSM_read_chars()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_read_chars = null;
         _loc1_ = new FSM_read_chars();
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
               mstate.esp -= 1040;
               this.i0 = mstate.ebp + -1040;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.ebp + -1032);
               this.i2 = this.i0 + 12;
               si32(this.i2,mstate.ebp + -1040);
               this.i3 = 0;
               si32(this.i3,mstate.ebp + -1036);
               this.i3 = 1024;
               this.i4 = this.i0 + 4;
               this.i5 = this.i0 + 8;
               this.i6 = li32(mstate.ebp + 12);
               this.i7 = li32(mstate.ebp + 16);
               break;
            case 1:
               this.i8 = mstate.eax;
               mstate.esp += 4;
               if(this.i8 != 0)
               {
                  this.i8 = mstate.ebp + -1040;
                  mstate.esp -= 4;
                  si32(this.i8,mstate.esp);
                  state = 2;
                  mstate.esp -= 4;
                  FSM_adjuststack.start();
                  return;
               }
               §§goto(addr181);
               break;
            case 2:
               mstate.esp += 4;
               addr181:
               this.i8 = 1;
               mstate.esp -= 16;
               this.i3 = uint(this.i3) > uint(this.i7) ? int(this.i7) : int(this.i3);
               si32(this.i2,mstate.esp);
               si32(this.i8,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i6,mstate.esp + 12);
               state = 3;
               mstate.esp -= 4;
               FSM___fread.start();
               return;
            case 3:
               this.i8 = mstate.eax;
               mstate.esp += 16;
               this.i9 = li32(this.i0);
               this.i9 += this.i8;
               si32(this.i9,this.i0);
               this.i9 = this.i7 - this.i8;
               if(this.i7 != this.i8)
               {
                  if(this.i8 == this.i3)
                  {
                     this.i7 = this.i9;
                     break;
                  }
               }
               this.i0 = mstate.ebp + -1040;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 4;
               mstate.esp -= 4;
               FSM_emptybuffer.start();
               return;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               this.i0 = li32(this.i4);
               this.i2 = li32(this.i5);
               mstate.esp -= 8;
               si32(this.i2,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_lua_concat.start();
               return;
            case 5:
               mstate.esp += 8;
               this.i0 = 1;
               si32(this.i0,this.i4);
               if(this.i7 != this.i8)
               {
                  this.i0 = -1;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i0,mstate.esp + 4);
                  state = 6;
                  mstate.esp -= 4;
                  FSM_lua_objlen.start();
                  return;
               }
               this.i0 = 1;
               §§goto(addr463);
               break;
            case 6:
               this.i0 = mstate.eax;
               this.i0 = this.i0 != 0 ? 1 : 0;
               mstate.esp += 8;
               this.i0 &= 1;
               addr463:
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _read_chars";
         }
         this.i8 = mstate.ebp + -1040;
         mstate.esp -= 4;
         si32(this.i8,mstate.esp);
         state = 1;
         mstate.esp -= 4;
         FSM_emptybuffer.start();
      }
   }
}
