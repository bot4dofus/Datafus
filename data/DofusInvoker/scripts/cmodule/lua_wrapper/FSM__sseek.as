package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM__sseek extends Machine
   {
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public function FSM__sseek()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM__sseek = null;
         _loc1_ = new FSM__sseek();
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
               this.i0 = 0;
               this.i1 = li32(_val_2E_1440);
               this.i2 = li32(mstate.ebp + 8);
               si32(this.i0,_val_2E_1440);
               this.i0 = li32(this.i2 + 40);
               this.i3 = li32(this.i2 + 28);
               mstate.esp -= 16;
               this.i4 = li32(mstate.ebp + 20);
               this.i5 = li32(mstate.ebp + 12);
               this.i6 = li32(mstate.ebp + 16);
               si32(this.i3,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i6,mstate.esp + 8);
               si32(this.i4,mstate.esp + 12);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[this.i0]();
               return;
            case 1:
               this.i0 = mstate.eax;
               this.i3 = mstate.edx;
               mstate.esp += 16;
               this.i7 = li32(_val_2E_1440);
               if(this.i7 == 0)
               {
                  si32(this.i1,_val_2E_1440);
               }
               this.i1 = this.i2 + 12;
               if(this.i3 <= -1)
               {
                  if(this.i7 != 29)
                  {
                     if(this.i7 == 0)
                     {
                        if(this.i4 == 1)
                        {
                           this.i0 = this.i5 | this.i6;
                           if(this.i0 != 0)
                           {
                              addr201:
                              this.i0 = li32(this.i2 + 48);
                              this.i3 = this.i2 + 48;
                              if(this.i0 != 0)
                              {
                                 this.i4 = this.i2 + 64;
                                 if(this.i0 != this.i4)
                                 {
                                    this.i4 = 0;
                                    mstate.esp -= 8;
                                    si32(this.i0,mstate.esp);
                                    si32(this.i4,mstate.esp + 4);
                                    state = 2;
                                    mstate.esp -= 4;
                                    FSM_pubrealloc.start();
                                    return;
                                 }
                                 break;
                              }
                              this.i0 = 0;
                              this.i3 = li32(this.i2 + 16);
                              si32(this.i3,this.i2);
                              si32(this.i0,this.i2 + 4);
                              this.i0 = li16(this.i1);
                              this.i0 &= -33;
                              si16(this.i0,this.i1);
                           }
                           this.i0 = 22;
                           this.i2 = li16(this.i1);
                           this.i2 |= 64;
                           si16(this.i2,this.i1);
                           si32(this.i0,_val_2E_1440);
                           this.i0 = li16(this.i1);
                           this.i0 &= -4097;
                           si16(this.i0,this.i1);
                           this.i0 = -1;
                           §§goto(addr386);
                        }
                        §§goto(addr201);
                     }
                     else
                     {
                        this.i0 = -1;
                        this.i2 = li16(this.i1);
                        this.i2 &= -4097;
                        addr381:
                        si16(this.i2,this.i1);
                     }
                     §§goto(addr386);
                  }
                  else
                  {
                     this.i0 = -1;
                     this.i2 = li16(this.i1);
                     this.i2 &= -4353;
                  }
                  §§goto(addr381);
               }
               else
               {
                  this.i4 = li16(this.i1);
                  this.i5 = this.i4 & 1024;
                  if(this.i5 != 0)
                  {
                     this.i4 |= 4096;
                     si16(this.i4,this.i1);
                     si32(this.i0,this.i2 + 80);
                     si32(this.i3,this.i2 + 84);
                  }
                  mstate.edx = this.i3;
               }
               addr386:
               mstate.edx = this.i0;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               break;
            default:
               throw "Invalid state in __sseek";
         }
         this.i0 = 0;
         si32(this.i0,this.i3);
         §§goto(addr201);
      }
   }
}
