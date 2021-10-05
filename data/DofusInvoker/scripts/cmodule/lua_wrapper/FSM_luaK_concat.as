package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaK_concat extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_luaK_concat()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaK_concat = null;
         _loc1_ = new FSM_luaK_concat();
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
               this.i1 = li32(mstate.ebp + 12);
               this.i2 = li32(mstate.ebp + 16);
               if(this.i2 != -1)
               {
                  this.i3 = li32(this.i1);
                  if(this.i3 != -1)
                  {
                     this.i1 = li32(this.i0);
                     this.i4 = li32(this.i1 + 12);
                     while(true)
                     {
                        this.i5 = this.i3 << 2;
                        this.i5 = this.i4 + this.i5;
                        this.i5 = li32(this.i5);
                        this.i5 >>>= 14;
                        this.i5 += -131071;
                        if(this.i5 == -1)
                        {
                           this.i5 = -1;
                        }
                        else
                        {
                           this.i5 = this.i3 + this.i5;
                           this.i5 += 1;
                        }
                        if(this.i5 == -1)
                        {
                           break;
                        }
                        this.i3 = this.i5;
                     }
                     this.i0 = li32(this.i0 + 12);
                     this.i1 = li32(this.i1 + 12);
                     mstate.esp -= 16;
                     si32(this.i1,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     si32(this.i3,mstate.esp + 8);
                     si32(this.i2,mstate.esp + 12);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_fixjump393394.start();
                     return;
                  }
                  si32(this.i2,this.i1);
                  break;
               }
               break;
            case 1:
               mstate.esp += 16;
               break;
            default:
               throw "Invalid state in _luaK_concat";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
