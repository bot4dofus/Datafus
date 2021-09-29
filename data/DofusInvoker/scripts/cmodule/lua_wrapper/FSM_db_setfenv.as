package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_db_setfenv extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_db_setfenv()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_db_setfenv = null;
         _loc1_ = new FSM_db_setfenv();
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
               this.i0 = 2;
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
                     this.i0 = li32(this.i1 + 12);
                     this.i2 = li32(this.i1 + 8);
                     this.i3 = this.i1 + 12;
                     this.i4 = this.i1 + 8;
                     this.i5 = this.i0 + 24;
                     if(uint(this.i2) >= uint(this.i5))
                     {
                        this.i2 = this.i0;
                     }
                     else
                     {
                        do
                        {
                           this.i0 = 0;
                           si32(this.i0,this.i2 + 8);
                           this.i2 += 12;
                           si32(this.i2,this.i4);
                           this.i0 = li32(this.i3);
                           this.i5 = this.i0 + 24;
                        }
                        while(uint(this.i2) < uint(this.i5));
                        
                        this.i2 = this.i0;
                     }
                     this.i0 = this.i2;
                     this.i2 = 1;
                     this.i0 += 24;
                     si32(this.i0,this.i4);
                     mstate.esp -= 8;
                     si32(this.i1,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_lua_setfenv.start();
                     this.i0 = mstate.eax;
                     mstate.esp += 8;
                     if(this.i0 == 0)
                     {
                        this.i0 = __2E_str42242;
                        mstate.esp -= 8;
                        si32(this.i1,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        state = 4;
                        mstate.esp -= 4;
                        FSM_luaL_error.start();
                        return;
                     }
                     break;
                  }
               }
               this.i0 = 5;
               mstate.esp -= 12;
               this.i2 = 2;
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
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in _db_setfenv";
         }
         this.i0 = 1;
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
