package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_tzload extends Machine
   {
      
      public static const intRegCount:int = 9;
      
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
      
      public function FSM_tzload()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_tzload = null;
         _loc1_ = new FSM_tzload();
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
               mstate.esp -= 5136;
               this.i2 = mstate.ebp + -5136;
               this.i3 = li32(mstate.ebp + 8);
               if(this.i3 != 0)
               {
                  this.i0 = __2E_str876;
                  this.i1 = 4;
                  log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               }
               this.i0 = __2E_str2348;
               this.i0 = this.i3 == 0 ? int(this.i0) : int(this.i3);
               this.i1 = li8(this.i0);
               if(this.i1 == 58)
               {
                  this.i0 += 1;
               }
               this.i1 = li8(this.i0);
               this.i3 = this.i1 == 47 ? 1 : 0;
               this.i3 &= 1;
               this.i4 = this.i0;
               if(this.i1 == 47)
               {
                  this.i1 = this.i3;
                  §§goto(addr131);
               }
               else
               {
                  this.i1 &= 255;
                  if(this.i1 != 0)
                  {
                     this.i1 = this.i4;
                     while(true)
                     {
                        this.i5 = li8(this.i1 + 1);
                        this.i1 += 1;
                        this.i6 = this.i1;
                        if(this.i5 == 0)
                        {
                           break;
                        }
                        this.i1 = this.i6;
                     }
                  }
                  else
                  {
                     this.i1 = this.i0;
                  }
                  this.i1 -= this.i4;
                  this.i1 += 21;
                  if(uint(this.i1) <= uint(1024))
                  {
                     this.i1 = mstate.ebp + -5136;
                     this.i5 = __2E_str13349;
                     this.i6 = 20;
                     memcpy(this.i1,this.i5,this.i6);
                     this.i5 = li8(mstate.ebp + -5136);
                     this.i6 = this.i1;
                     if(this.i5 != 0)
                     {
                        this.i1 = this.i2;
                        while(true)
                        {
                           this.i5 = li8(this.i1 + 1);
                           this.i1 += 1;
                           this.i7 = this.i1;
                           if(this.i5 == 0)
                           {
                              break;
                           }
                           this.i1 = this.i7;
                        }
                     }
                     else
                     {
                        this.i1 = this.i6;
                     }
                     this.i5 = mstate.ebp + -5136;
                     this.i1 -= this.i2;
                     this.i7 = 47;
                     this.i8 = 0;
                     this.i1 = this.i5 + this.i1;
                     si8(this.i7,this.i1);
                     si8(this.i8,this.i1 + 1);
                     this.i1 = li8(this.i6);
                     if(this.i1 != 0)
                     {
                        this.i1 = this.i2;
                        while(true)
                        {
                           this.i2 = li8(this.i1 + 1);
                           this.i1 += 1;
                           this.i5 = this.i1;
                           if(this.i2 == 0)
                           {
                              break;
                           }
                           this.i1 = this.i5;
                        }
                     }
                     else
                     {
                        this.i1 = this.i6;
                     }
                     this.i2 = 0;
                     do
                     {
                        this.i5 = this.i4 + this.i2;
                        this.i5 = li8(this.i5);
                        this.i7 = this.i1 + this.i2;
                        si8(this.i5,this.i7);
                        this.i2 += 1;
                     }
                     while(this.i5 != 0);
                     
                     this.i1 = li8(this.i0);
                     if(this.i1 != 46)
                     {
                        this.i0 = this.i4;
                        while(true)
                        {
                           this.i1 = li8(this.i0);
                           if(this.i1 == 0)
                           {
                              this.i0 = 0;
                              break;
                           }
                           this.i1 = li8(this.i0 + 1);
                           this.i0 += 1;
                           this.i2 = this.i0;
                           if(this.i1 == 46)
                           {
                              break;
                           }
                           this.i0 = this.i2;
                        }
                     }
                     this.i0 = this.i0 == 0 ? int(this.i3) : 1;
                     this.i1 = this.i0;
                     this.i0 = this.i6;
                     addr131:
                     this.i2 = this.i0;
                     if(this.i1 != 0)
                     {
                        this.i1 = 4;
                        this.i0 = this.i2;
                        state = 1;
                        addr151:
                        this.i0 = mstate.system.access(this.i0,this.i1);
                        if(this.i0 != 0)
                        {
                           addr561:
                           this.i0 = -1;
                           mstate.eax = this.i0;
                           break;
                        }
                     }
                     this.i0 = 0;
                     mstate.esp -= 8;
                     si32(this.i2,mstate.esp);
                     si32(this.i0,mstate.esp + 4);
                     state = 2;
                     mstate.esp -= 4;
                     FSM_open.start();
                     return;
                  }
               }
               §§goto(addr561);
            case 1:
               §§goto(addr151);
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               if(this.i2 != -1)
               {
                  if(this.i2 >= 2)
                  {
                     this.i0 = this.i2;
                     state = 3;
                     addr230:
                     this.i0 = mstate.system.fsize(this.i0);
                     if(this.i0 <= -1)
                     {
                        this.i0 = __2E_str96;
                        mstate.esp -= 20;
                        this.i1 = __2E_str251;
                        this.i3 = 59;
                        this.i4 = 2;
                        this.i5 = mstate.ebp + -4096;
                        si32(this.i5,mstate.esp);
                        si32(this.i0,mstate.esp + 4);
                        si32(this.i4,mstate.esp + 8);
                        si32(this.i1,mstate.esp + 12);
                        si32(this.i3,mstate.esp + 16);
                        state = 4;
                        mstate.esp -= 4;
                        FSM_sprintf.start();
                        return;
                     }
                  }
                  addr343:
                  this.i1 = -1;
                  this.i0 = this.i2;
                  state = 5;
               }
               else
               {
                  §§goto(addr561);
               }
            case 3:
               §§goto(addr230);
            case 4:
               mstate.esp += 20;
               this.i1 = 3;
               this.i0 = this.i5;
               log(this.i1,mstate.gworker.stringFromPtr(this.i0));
               si32(this.i4,_val_2E_1440);
               §§goto(addr343);
            case 5:
               this.i0 = mstate.system.close(this.i0);
               mstate.eax = this.i1;
               break;
            default:
               throw "Invalid state in _tzload";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
