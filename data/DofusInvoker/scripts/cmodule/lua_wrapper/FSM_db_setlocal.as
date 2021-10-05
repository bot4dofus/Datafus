package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_db_setlocal extends Machine
   {
      
      public static const intRegCount:int = 10;
      
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
      
      public var i9:int;
      
      public function FSM_db_setlocal()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_db_setlocal = null;
         _loc1_ = new FSM_db_setlocal();
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
               this.i2 = _luaO_nilobject_;
               mstate.esp -= 8;
               this.i3 += 3;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_index2adr.start();
            case 5:
               this.i5 = mstate.eax;
               mstate.esp += 8;
               if(this.i5 != this.i2)
               {
                  this.i2 = li32(this.i5 + 8);
                  if(this.i2 != -1)
                  {
                     break;
                  }
               }
               this.i2 = __2E_str11186329;
               mstate.esp -= 12;
               si32(this.i1,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 6;
               mstate.esp -= 4;
               FSM_luaL_argerror.start();
               return;
            case 4:
               mstate.esp += 12;
               this.i0 = 0;
               mstate.eax = this.i0;
               §§goto(addr934);
            case 6:
               mstate.esp += 12;
               break;
            case 7:
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
            case 8:
               this.i5 = mstate.eax;
               mstate.esp += 12;
               this.i6 = li32(this.i0 + 8);
               this.i0 += 8;
               if(this.i5 == 0)
               {
                  this.i2 = this.i6;
               }
               else
               {
                  this.i3 *= 24;
                  this.i3 = this.i4 + this.i3;
                  this.i3 = li32(this.i3);
                  this.f0 = lf64(this.i6 + -12);
                  this.i2 *= 12;
                  this.i2 += this.i3;
                  sf64(this.f0,this.i2 + -12);
                  this.i3 = li32(this.i6 + -4);
                  si32(this.i3,this.i2 + -4);
                  this.i2 = li32(this.i0);
               }
               this.i3 = 1;
               this.i2 += -12;
               si32(this.i2,this.i0);
               mstate.esp -= 8;
               si32(this.i1,mstate.esp);
               si32(this.i5,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               FSM_lua_pushstring.start();
               return;
            case 9:
               mstate.esp += 8;
               mstate.eax = this.i3;
               addr934:
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _db_setlocal";
         }
         this.i2 = li32(mstate.ebp + -4);
         this.i3 = li32(this.i1 + 8);
         this.i5 = this.i1 + 8;
         this.i6 = this.i2 + 3;
         if(this.i6 >= 0)
         {
            this.i2 = li32(this.i1 + 12);
            this.i7 = this.i1 + 12;
            this.i8 = this.i6 * 12;
            this.i8 = this.i2 + this.i8;
            if(uint(this.i3) < uint(this.i8))
            {
               this.i2 = this.i3;
               do
               {
                  this.i3 = 0;
                  si32(this.i3,this.i2 + 8);
                  this.i2 += 12;
                  si32(this.i2,this.i5);
                  this.i3 = li32(this.i7);
                  this.i8 = this.i6 * 12;
                  this.i8 = this.i3 + this.i8;
               }
               while(uint(this.i2) < uint(this.i8));
               
               this.i2 = this.i3;
            }
            this.i3 = this.i6 * 12;
            this.i2 += this.i3;
         }
         else
         {
            this.i2 *= 12;
            this.i2 += this.i3;
            this.i2 += 48;
         }
         si32(this.i2,this.i5);
         if(this.i0 != this.i1)
         {
            this.i3 = 0;
            this.i2 += -12;
            si32(this.i2,this.i5);
            this.i2 = this.i0 + 8;
            this.i6 = this.i3;
            while(true)
            {
               this.i7 = li32(this.i2);
               this.i8 = li32(this.i5);
               this.i9 = this.i7 + 12;
               si32(this.i9,this.i2);
               this.i8 += this.i6;
               this.f0 = lf64(this.i8);
               sf64(this.f0,this.i7);
               this.i8 = li32(this.i8 + 8);
               si32(this.i8,this.i7 + 8);
               this.i6 += 12;
               this.i7 = this.i3 + 1;
               if(this.i3 == 0)
               {
                  break;
               }
               this.i3 = this.i7;
            }
         }
         this.i2 = li32(mstate.ebp + -4);
         mstate.esp -= 8;
         this.i2 += 2;
         si32(this.i1,mstate.esp);
         si32(this.i2,mstate.esp + 4);
         state = 7;
         mstate.esp -= 4;
         FSM_luaL_checkinteger.start();
      }
   }
}
