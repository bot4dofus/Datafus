package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_lua_replace extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
      
      public function FSM_lua_replace()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_lua_replace = null;
         _loc1_ = new FSM_lua_replace();
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
               if(this.i1 == -10001)
               {
                  this.i2 = li32(this.i0 + 20);
                  this.i3 = li32(this.i0 + 40);
                  if(this.i2 == this.i3)
                  {
                     this.i2 = __2E_str1250;
                     mstate.esp -= 8;
                     si32(this.i0,mstate.esp);
                     si32(this.i2,mstate.esp + 4);
                     state = 1;
                     mstate.esp -= 4;
                     FSM_luaG_runerror.start();
                     return;
                  }
               }
               addr108:
               mstate.esp -= 8;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
               break;
            case 1:
               mstate.esp += 8;
               §§goto(addr108);
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               if(this.i1 == -10001)
               {
                  this.i1 = li32(this.i0 + 20);
                  this.i1 = li32(this.i1 + 4);
                  this.i2 = li32(this.i0 + 8);
                  this.i1 = li32(this.i1);
                  this.i2 = li32(this.i2 + -12);
                  si32(this.i2,this.i1 + 12);
                  this.i2 = li32(this.i0 + 8);
                  this.i3 = li32(this.i2 + -4);
                  this.i4 = this.i0 + 8;
                  if(this.i3 >= 4)
                  {
                     this.i2 = li32(this.i2 + -12);
                     this.i3 = li8(this.i2 + 5);
                     this.i3 &= 3;
                     if(this.i3 != 0)
                     {
                        this.i3 = li8(this.i1 + 5);
                        this.i1 += 5;
                        this.i5 = this.i3 & 4;
                        if(this.i5 != 0)
                        {
                           this.i0 = li32(this.i0 + 16);
                           this.i5 = li8(this.i0 + 21);
                           if(this.i5 == 1)
                           {
                              mstate.esp -= 8;
                              si32(this.i0,mstate.esp);
                              si32(this.i2,mstate.esp + 4);
                              mstate.esp -= 4;
                              FSM_reallymarkobject.start();
                              addr312:
                              mstate.esp += 8;
                           }
                           else
                           {
                              this.i0 = li8(this.i0 + 20);
                              this.i2 = this.i3 & -8;
                              this.i0 &= 3;
                              this.i0 |= this.i2;
                              si8(this.i0,this.i1);
                           }
                           this.i0 = li32(this.i4);
                           this.i0 += -12;
                           si32(this.i0,this.i4);
                           break;
                        }
                     }
                  }
               }
               else
               {
                  this.i3 = li32(this.i0 + 8);
                  this.f0 = lf64(this.i3 + -12);
                  sf64(this.f0,this.i2);
                  this.i3 = li32(this.i3 + -4);
                  si32(this.i3,this.i2 + 8);
                  this.i2 = this.i0 + 8;
                  if(this.i1 <= -10003)
                  {
                     this.i1 = li32(this.i2);
                     this.i3 = li32(this.i1 + -4);
                     if(this.i3 >= 4)
                     {
                        this.i1 = li32(this.i1 + -12);
                        this.i3 = li8(this.i1 + 5);
                        this.i3 &= 3;
                        if(this.i3 != 0)
                        {
                           this.i3 = li32(this.i0 + 20);
                           this.i3 = li32(this.i3 + 4);
                           this.i3 = li32(this.i3);
                           this.i4 = li8(this.i3 + 5);
                           this.i3 += 5;
                           this.i5 = this.i4 & 4;
                           if(this.i5 != 0)
                           {
                              this.i0 = li32(this.i0 + 16);
                              this.i5 = li8(this.i0 + 21);
                              if(this.i5 == 1)
                              {
                                 mstate.esp -= 8;
                                 si32(this.i0,mstate.esp);
                                 si32(this.i1,mstate.esp + 4);
                                 mstate.esp -= 4;
                                 FSM_reallymarkobject.start();
                                 addr543:
                                 mstate.esp += 8;
                              }
                              else
                              {
                                 this.i0 = li8(this.i0 + 20);
                                 this.i1 = this.i4 & -8;
                                 this.i0 &= 3;
                                 this.i0 |= this.i1;
                                 si8(this.i0,this.i3);
                              }
                              this.i0 = li32(this.i2);
                              this.i0 += -12;
                              si32(this.i0,this.i2);
                              break;
                           }
                        }
                     }
                  }
               }
               this.i1 = li32(this.i0 + 8);
               this.i1 += -12;
               si32(this.i1,this.i0 + 8);
               break;
            case 4:
               §§goto(addr543);
            case 3:
               §§goto(addr312);
            default:
               throw "Invalid state in _lua_replace";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
