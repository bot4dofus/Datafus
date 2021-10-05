package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaO_str2d extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      public function FSM_luaO_str2d()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaO_str2d = null;
         _loc1_ = new FSM_luaO_str2d();
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
               mstate.esp -= 4;
               this.i0 = mstate.ebp + -4;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               FSM_strtod.start();
               return;
            case 1:
               this.f0 = mstate.st0;
               this.i0 = li32(mstate.ebp + 12);
               mstate.esp += 8;
               sf64(this.f0,this.i0);
               this.i2 = li32(mstate.ebp + -4);
               if(this.i2 != this.i1)
               {
                  this.i3 = li8(this.i2);
                  if(this.i3 != 120)
                  {
                     this.i4 = this.i3 & 255;
                     if(this.i4 != 88)
                     {
                        this.i0 = this.i3 & 255;
                        if(this.i0 == 0)
                        {
                           addr145:
                           this.i0 = 1;
                        }
                        else
                        {
                           this.i0 = this.i2;
                           addr237:
                           this.i1 = li8(this.i0);
                           this.i2 = li32(__CurrentRuneLocale);
                           this.i1 <<= 2;
                           this.i1 = this.i2 + this.i1;
                           this.i1 = li32(this.i1 + 52);
                           this.i1 &= 16384;
                           if(this.i1 != 0)
                           {
                              while(true)
                              {
                                 this.i1 = this.i0 + 1;
                                 si32(this.i1,mstate.ebp + -4);
                                 this.i0 = li8(this.i0 + 1);
                                 this.i0 <<= 2;
                                 this.i0 = this.i2 + this.i0;
                                 this.i0 = li32(this.i0 + 52);
                                 this.i0 &= 16384;
                                 if(this.i0 == 0)
                                 {
                                    break;
                                 }
                                 this.i0 = this.i1;
                              }
                              this.i0 = this.i1;
                           }
                           this.i0 = li8(this.i0);
                           this.i0 = this.i0 == 0 ? 1 : 0;
                           this.i0 &= 1;
                        }
                        §§goto(addr363);
                     }
                  }
                  this.i2 = 16;
                  mstate.esp -= 12;
                  this.i3 = mstate.ebp + -4;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i2,mstate.esp + 8);
                  mstate.esp -= 4;
                  FSM_strtoul.start();
                  break;
               }
               this.i0 = 0;
               addr363:
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            case 2:
               break;
            default:
               throw "Invalid state in _luaO_str2d";
         }
         this.i1 = mstate.eax;
         mstate.esp += 12;
         this.f0 = Number(uint(this.i1));
         sf64(this.f0,this.i0);
         this.i0 = li32(mstate.ebp + -4);
         this.i1 = li8(this.i0);
         if(this.i1 != 0)
         {
            §§goto(addr237);
         }
         else
         {
            §§goto(addr145);
         }
      }
   }
}
