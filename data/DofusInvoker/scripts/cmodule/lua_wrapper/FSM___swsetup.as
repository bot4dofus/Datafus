package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM___swsetup extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM___swsetup()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___swsetup = null;
         _loc1_ = new FSM___swsetup();
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
               this.i1 = li8(___sdidinit_2E_b);
               if(this.i1 == 0)
               {
                  this.i1 = _usual;
                  this.i2 = _usual_extra;
                  this.i3 = 0;
                  this.i1 += 56;
                  do
                  {
                     si32(this.i2,this.i1);
                     this.i2 += 148;
                     this.i1 += 88;
                     this.i3 += 1;
                  }
                  while(this.i3 != 17);
                  
                  this.i1 = 1;
                  si8(this.i1,___cleanup_2E_b);
                  si8(this.i1,___sdidinit_2E_b);
               }
               this.i1 = li16(this.i0 + 12);
               this.i2 = this.i0 + 12;
               this.i3 = this.i1;
               this.i4 = this.i1 & 8;
               if(this.i4 == 0)
               {
                  this.i4 = this.i3 & 16;
                  if(this.i4 == 0)
                  {
                     this.i0 = 9;
                     si32(this.i0,_val_2E_1440);
                     this.i0 = -1;
                     §§goto(addr442);
                  }
                  else
                  {
                     this.i3 &= 4;
                     if(this.i3 != 0)
                     {
                        this.i1 = li32(this.i0 + 48);
                        this.i3 = this.i0 + 48;
                        if(this.i1 != 0)
                        {
                           this.i4 = this.i0 + 64;
                           if(this.i1 != this.i4)
                           {
                              this.i4 = 0;
                              mstate.esp -= 8;
                              si32(this.i1,mstate.esp);
                              si32(this.i4,mstate.esp + 4);
                              state = 1;
                              mstate.esp -= 4;
                              FSM_pubrealloc.start();
                              return;
                           }
                           addr245:
                           this.i1 = 0;
                           si32(this.i1,this.i3);
                        }
                        this.i1 = 0;
                        this.i3 = li16(this.i2);
                        this.i3 &= -37;
                        si16(this.i3,this.i2);
                        si32(this.i1,this.i0 + 4);
                        this.i1 = li32(this.i0 + 16);
                        si32(this.i1,this.i0);
                        this.i1 = this.i3;
                     }
                     this.i1 |= 8;
                     si16(this.i1,this.i2);
                  }
               }
               this.i1 = li32(this.i0 + 16);
               if(this.i1 == 0)
               {
                  mstate.esp -= 4;
                  si32(this.i0,mstate.esp);
                  state = 2;
                  mstate.esp -= 4;
                  FSM___smakebuf.start();
                  return;
               }
               break;
            case 1:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               §§goto(addr245);
            case 2:
               mstate.esp += 4;
               break;
            default:
               throw "Invalid state in ___swsetup";
         }
         this.i1 = li16(this.i2);
         this.i2 = this.i1 & 1;
         if(this.i2 != 0)
         {
            this.i1 = 0;
            si32(this.i1,this.i0 + 8);
            this.i2 = li32(this.i0 + 20);
            this.i2 = 0 - this.i2;
            si32(this.i2,this.i0 + 24);
            addr429:
            mstate.eax = this.i1;
         }
         else
         {
            this.i2 = this.i0 + 8;
            this.i1 &= 2;
            if(this.i1 == 0)
            {
               this.i1 = 0;
               this.i0 = li32(this.i0 + 20);
               si32(this.i0,this.i2);
               §§goto(addr429);
            }
            else
            {
               this.i0 = 0;
               si32(this.i0,this.i2);
               §§goto(addr442);
            }
         }
         addr442:
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
