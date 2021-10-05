package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_db_getlocal extends Machine
   {
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 1;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var f0:Number;
      
      public var i7:int;
      
      public function FSM_db_getlocal()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_db_getlocal = null;
         _loc1_ = new FSM_db_getlocal();
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
               mstate.esp -= 112;
               this.i0 = mstate.ebp + -4;
               mstate.esp -= 8;
               this.i1 = li32(mstate.ebp + 8);
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_getthread.start();
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(mstate.ebp + -4);
               mstate.esp -= 8;
               this.i2 += 1;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               FSM_luaL_checkinteger.start();
               return;
            case 2:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(this.i0 + 20);
               this.i4 = li32(this.i0 + 40);
               mstate.esp -= 16;
               this.i5 = mstate.ebp + -112;
               si32(this.i3,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i5,mstate.esp + 12);
               mstate.esp -= 4;
               FSM_lua_getstack390.start();
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 16;
               this.i3 = li32(mstate.ebp + -4);
               this.i4 = this.i0 + 40;
               if(this.i2 == 0)
               {
                  this.i0 = __2E_str31281;
                  mstate.esp -= 12;
                  this.i3 += 1;
                  si32(this.i1,mstate.esp);
                  si32(this.i3,mstate.esp + 4);
                  si32(this.i0,mstate.esp + 8);
                  state = 4;
                  mstate.esp -= 4;
                  FSM_luaL_argerror.start();
                  return;
               }
               mstate.esp -= 8;
               this.i2 = this.i3 + 2;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 5;
               mstate.esp -= 4;
               FSM_luaL_checkinteger.start();
               return;
               break;
            case 4:
               mstate.esp += 12;
               this.i0 = 0;
               addr780:
               mstate.eax = this.i0;
               break;
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               this.i3 = li32(mstate.ebp + -16);
               this.i4 = li32(this.i4);
               this.i5 = this.i3 * 24;
               mstate.esp -= 12;
               this.i5 = this.i4 + this.i5;
               si32(this.i0,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               mstate.esp -= 4;
               FSM_findlocal.start();
            case 6:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               if(this.i5 != 0)
               {
                  this.i3 *= 24;
                  this.i3 = this.i4 + this.i3;
                  this.i3 = li32(this.i3);
                  this.i2 *= 12;
                  this.i2 += this.i3;
                  this.i3 = li32(this.i0 + 8);
                  this.f0 = lf64(this.i2 + -12);
                  sf64(this.f0,this.i3);
                  this.i2 = li32(this.i2 + -4);
                  si32(this.i2,this.i3 + 8);
                  this.i2 = li32(this.i0 + 8);
                  this.i2 += 12;
                  si32(this.i2,this.i0 + 8);
                  if(this.i0 != this.i1)
                  {
                     this.i2 = 0;
                     this.i3 = li32(this.i0 + 8);
                     this.i3 += -12;
                     si32(this.i3,this.i0 + 8);
                     this.i3 = this.i1 + 8;
                     this.i0 += 8;
                     this.i4 = this.i2;
                     while(true)
                     {
                        this.i6 = li32(this.i3);
                        this.i7 = li32(this.i0);
                        this.i8 = this.i6 + 12;
                        si32(this.i8,this.i3);
                        this.i7 += this.i4;
                        this.f0 = lf64(this.i7);
                        sf64(this.f0,this.i6);
                        this.i7 = li32(this.i7 + 8);
                        si32(this.i7,this.i6 + 8);
                        this.i4 += 12;
                        this.i6 = this.i2 + 1;
                        if(this.i2 == 0)
                        {
                           break;
                        }
                        this.i2 = this.i6;
                     }
                  }
                  this.i0 = -2;
                  mstate.esp -= 8;
                  si32(this.i1,mstate.esp);
                  si32(this.i5,mstate.esp + 4);
                  state = 7;
                  mstate.esp -= 4;
                  FSM_lua_pushstring.start();
                  return;
               }
               this.i0 = 0;
               this.i2 = li32(this.i1 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               this.i0 = 1;
               §§goto(addr780);
               break;
            case 7:
               mstate.esp += 8;
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               this.i2 = li32(this.i1 + 8);
               this.f0 = lf64(this.i0);
               sf64(this.f0,this.i2);
               this.i0 = li32(this.i0 + 8);
               si32(this.i0,this.i2 + 8);
               this.i0 = li32(this.i1 + 8);
               this.i0 += 12;
               si32(this.i0,this.i1 + 8);
               this.i1 = 2;
               mstate.eax = this.i1;
               break;
            default:
               throw "Invalid state in _db_getlocal";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
