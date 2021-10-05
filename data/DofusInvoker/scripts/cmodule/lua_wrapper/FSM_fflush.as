package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_fflush extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM_fflush()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_fflush = null;
         _loc1_ = new FSM_fflush();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         loop4:
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = li32(mstate.ebp + 8);
               if(this.i0 == 0)
               {
                  this.i0 = ___sglue;
                  this.i1 = 0;
                  loop0:
                  while(true)
                  {
                     this.i2 = li32(this.i0 + 4);
                     this.i3 = li32(this.i0 + 8);
                     this.i4 = this.i2 + -1;
                     if(this.i4 > -1)
                     {
                        this.i2 += -1;
                        loop1:
                        while(true)
                        {
                           this.i4 = li16(this.i3 + 12);
                           this.i4 <<= 16;
                           this.i4 >>= 16;
                           this.i5 = this.i3;
                           if(this.i4 > 0)
                           {
                              break;
                           }
                           while(true)
                           {
                              this.i3 += 88;
                              this.i2 += -1;
                              if(this.i2 > -1)
                              {
                                 continue loop1;
                              }
                           }
                        }
                        mstate.esp -= 4;
                        si32(this.i5,mstate.esp);
                        state = 1;
                        mstate.esp -= 4;
                        FSM___sflush.start();
                        return;
                     }
                     while(true)
                     {
                        this.i0 = li32(this.i0);
                        if(this.i0 == 0)
                        {
                           break loop0;
                        }
                        continue loop0;
                     }
                     break loop4;
                  }
                  mstate.eax = this.i1;
                  break;
               }
               this.i1 = li16(this.i0 + 12);
               this.i1 &= 24;
               if(this.i1 == 0)
               {
                  this.i0 = 9;
                  si32(this.i0,_val_2E_1440);
                  this.i0 = -1;
                  addr244:
                  mstate.eax = this.i0;
                  break;
               }
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 2;
               mstate.esp -= 4;
               FSM___sflush.start();
               return;
               break;
            case 1:
               this.i4 = mstate.eax;
               mstate.esp += 4;
               this.i1 = this.i4 | this.i1;
               §§goto(addr152);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               §§goto(addr244);
            default:
               throw "Invalid state in _fflush";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
