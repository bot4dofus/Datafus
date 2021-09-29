package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_LoadBlock extends Machine
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
      
      public function FSM_LoadBlock()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_LoadBlock = null;
         _loc1_ = new FSM_LoadBlock();
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
               this.i1 = li32(this.i0 + 4);
               this.i2 = li32(mstate.ebp + 12);
               this.i3 = li32(mstate.ebp + 16);
               if(this.i3 == 0)
               {
                  addr62:
                  this.i1 = 0;
                  if(this.i1 != 0)
                  {
                     this.i1 = __2E_str156317;
                     this.i2 = li32(this.i0 + 12);
                     this.i3 = li32(this.i0);
                     mstate.esp -= 16;
                     this.i4 = __2E_str1157;
                     si32(this.i3,mstate.esp);
                     si32(this.i1,mstate.esp + 4);
                     si32(this.i2,mstate.esp + 8);
                     si32(this.i4,mstate.esp + 12);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaO_pushfstring.start();
                     return;
                  }
                  break;
               }
               this.i4 = 0;
               this.i5 = this.i1 + 4;
               this.i6 = this.i1;
               §§goto(addr235);
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 16;
               this.i0 = li32(this.i0);
               mstate.esp -= 8;
               this.i1 = 3;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaD_throw.start();
               return;
            case 2:
               mstate.esp += 8;
               break;
            case 3:
               this.i7 = mstate.eax;
               mstate.esp += 4;
               if(this.i7 == -1)
               {
                  this.i1 = this.i3;
               }
               else
               {
                  this.i7 = li32(this.i6);
                  this.i8 = li32(this.i5);
                  this.i9 = this.i2 + this.i4;
                  this.i7 = uint(this.i7) <= uint(this.i3) ? int(this.i7) : int(this.i3);
                  memcpy(this.i9,this.i8,this.i7);
                  this.i8 = li32(this.i6);
                  this.i8 -= this.i7;
                  si32(this.i8,this.i6);
                  this.i8 = li32(this.i5);
                  this.i8 += this.i7;
                  si32(this.i8,this.i5);
                  this.i8 = this.i3 - this.i7;
                  this.i4 += this.i7;
                  if(this.i3 != this.i7)
                  {
                     this.i3 = this.i8;
                     addr235:
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     state = 3;
                     mstate.esp -= 4;
                     FSM_luaZ_lookahead.start();
                     return;
                  }
                  §§goto(addr62);
               }
               §§goto(addr62);
            default:
               throw "Invalid state in _LoadBlock";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
