package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM___ungetc extends Machine
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
      
      public function FSM___ungetc()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___ungetc = null;
         _loc1_ = new FSM___ungetc();
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
               if(this.i0 != -1)
               {
                  this.i2 = li16(this.i1 + 12);
                  this.i3 = this.i1 + 12;
                  this.i4 = this.i2;
                  this.i5 = this.i2 & 4;
                  if(this.i5 == 0)
                  {
                     this.i5 = this.i4 & 16;
                     if(this.i5 != 0)
                     {
                        this.i4 &= 8;
                        if(this.i4 != 0)
                        {
                           mstate.esp -= 4;
                           si32(this.i1,mstate.esp);
                           state = 1;
                           mstate.esp -= 4;
                           FSM___sflush.start();
                           return;
                        }
                        addr175:
                        this.i2 |= 4;
                        si16(this.i2,this.i3);
                     }
                     break;
                  }
                  this.i4 = li32(this.i1 + 48);
                  this.i5 = this.i1 + 48;
                  if(this.i4 != 0)
                  {
                     this.i2 = li32(this.i1 + 4);
                     this.i3 = li32(this.i1 + 52);
                     this.i6 = this.i1 + 52;
                     this.i7 = this.i1 + 4;
                     if(this.i2 >= this.i3)
                     {
                        this.i2 = this.i1 + 64;
                        if(this.i4 == this.i2)
                        {
                           this.i3 = 1024;
                           mstate.esp -= 8;
                           this.i4 = 0;
                           si32(this.i4,mstate.esp);
                           si32(this.i3,mstate.esp + 4);
                           state = 2;
                           mstate.esp -= 4;
                           FSM_pubrealloc.start();
                           return;
                        }
                        mstate.esp -= 8;
                        this.i2 = this.i3 << 1;
                        si32(this.i4,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        state = 3;
                        mstate.esp -= 4;
                        FSM_pubrealloc.start();
                        return;
                     }
                     addr456:
                     this.i2 = li32(this.i1);
                     this.i3 = this.i2 + -1;
                     si32(this.i3,this.i1);
                     si8(this.i0,this.i2 + -1);
                     this.i0 = li32(this.i7);
                     this.i0 += 1;
                     si32(this.i0,this.i7);
                     break;
                  }
                  this.i2 &= -33;
                  si16(this.i2,this.i3);
                  this.i2 = li32(this.i1 + 16);
                  if(this.i2 != 0)
                  {
                     this.i3 = li32(this.i1);
                     this.i4 = this.i1;
                     if(uint(this.i3) > uint(this.i2))
                     {
                        this.i2 = li8(this.i3 + -1);
                        this.i3 += -1;
                        this.i6 = this.i0 & 255;
                        if(this.i2 == this.i6)
                        {
                           si32(this.i3,this.i4);
                           this.i0 = li32(this.i1 + 4);
                           this.i0 += 1;
                        }
                        else
                        {
                           addr617:
                           this.i2 = 3;
                           this.i3 = li32(this.i1 + 4);
                           si32(this.i3,this.i1 + 60);
                           this.i3 = li32(this.i1 + 56);
                           this.i4 = li32(this.i1);
                           si32(this.i4,this.i3);
                           this.i3 = this.i1 + 64;
                           si32(this.i3,this.i5);
                           si32(this.i2,this.i1 + 52);
                           si8(this.i0,this.i1 + 66);
                           this.i0 = this.i1 + 66;
                           si32(this.i0,this.i1);
                           this.i0 = 1;
                        }
                        si32(this.i0,this.i1 + 4);
                        break;
                     }
                  }
                  §§goto(addr617);
               }
               break;
            case 1:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               if(this.i2 == 0)
               {
                  this.i2 = 0;
                  this.i4 = li16(this.i3);
                  this.i4 &= -9;
                  si16(this.i4,this.i3);
                  si32(this.i2,this.i1 + 8);
                  si32(this.i2,this.i1 + 24);
                  this.i2 = this.i4;
                  §§goto(addr175);
               }
               break;
            case 2:
               this.i3 = mstate.eax;
               mstate.esp += 8;
               this.i4 = this.i3;
               if(this.i3 != 0)
               {
                  this.i8 = 1024;
                  si32(this.i3,this.i5);
                  si32(this.i8,this.i6);
                  this.i3 = li8(this.i1 + 66);
                  si8(this.i3,this.i4 + 1023);
                  this.i3 = li8(this.i1 + 65);
                  si8(this.i3,this.i4 + 1022);
                  this.i3 = li8(this.i2);
                  si8(this.i3,this.i4 + 1021);
                  this.i3 = this.i4 + 1021;
                  si32(this.i3,this.i1);
                  §§goto(addr456);
               }
               break;
            case 3:
               this.i4 = mstate.eax;
               mstate.esp += 8;
               if(this.i4 != 0)
               {
                  this.i8 = this.i4 + this.i3;
                  this.i9 = this.i4;
                  memcpy(this.i8,this.i9,this.i3);
                  si32(this.i8,this.i1);
                  si32(this.i4,this.i5);
                  si32(this.i2,this.i6);
                  §§goto(addr456);
               }
               break;
            default:
               throw "Invalid state in ___ungetc";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
