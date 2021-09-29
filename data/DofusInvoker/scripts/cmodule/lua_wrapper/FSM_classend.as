package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_classend extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public function FSM_classend()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_classend = null;
         _loc1_ = new FSM_classend();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop2:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = si8(li8(this.i0));
               this.i2 = this.i0 + 1;
               this.i3 = li32(mstate.ebp + 8);
               if(this.i1 != 37)
               {
                  if(this.i1 != 91)
                  {
                     this.i0 = this.i2;
                     break;
                  }
                  this.i1 = li8(this.i2);
                  if(this.i1 != 94)
                  {
                     this.i0 = this.i2;
                  }
                  else
                  {
                     this.i0 += 2;
                  }
                  this.i1 = this.i3 + 8;
                  loop0:
                  while(true)
                  {
                     this.i2 = li8(this.i0);
                     if(this.i2 == 0)
                     {
                        this.i2 = __2E_str20450;
                        this.i3 = li32(this.i1);
                        mstate.esp -= 8;
                        si32(this.i3,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_luaL_error.start();
                        return;
                     }
                     addr219:
                     while(true)
                     {
                        this.i2 = li8(this.i0);
                        this.i3 = this.i0 + 1;
                        if(this.i2 == 37)
                        {
                           this.i2 = li8(this.i3);
                           if(this.i2 != 0)
                           {
                              this.i0 += 2;
                           }
                           else
                           {
                              addr237:
                              this.i0 = this.i3;
                           }
                           this.i2 = li8(this.i0);
                           if(this.i2 == 93)
                           {
                              break loop0;
                           }
                           continue loop0;
                        }
                        §§goto(addr237);
                     }
                     break loop2;
                  }
                  this.i0 += 1;
                  break;
               }
               this.i2 = li8(this.i2);
               this.i0 += 2;
               if(this.i2 != 0)
               {
                  break;
               }
               this.i2 = __2E_str19449;
               this.i3 = li32(this.i3 + 8);
               mstate.esp -= 8;
               si32(this.i3,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_luaL_error.start();
               return;
               break;
            case 1:
               mstate.esp += 8;
               break;
            case 2:
               mstate.esp += 8;
               §§goto(addr219);
            default:
               throw "Invalid state in _classend";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
