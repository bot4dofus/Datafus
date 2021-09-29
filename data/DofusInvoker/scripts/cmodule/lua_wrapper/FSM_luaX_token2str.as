package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaX_token2str extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public function FSM_luaX_token2str()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_luaX_token2str = null;
         _loc1_ = new FSM_luaX_token2str();
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
               if(this.i1 <= 256)
               {
                  this.i0 += 40;
                  if(uint(this.i1) >= uint(256))
                  {
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     mstate.esp -= 4;
                     FSM____runetype.start();
                     addr80:
                     this.i2 = mstate.eax;
                     mstate.esp += 4;
                     this.i0 = li32(this.i0);
                     this.i2 &= 512;
                     if(this.i2 != 0)
                     {
                        §§goto(addr149);
                     }
                  }
                  else
                  {
                     this.i2 = li32(__CurrentRuneLocale);
                     this.i3 = this.i1 << 2;
                     this.i2 += this.i3;
                     this.i2 = li32(this.i2 + 52);
                     this.i0 = li32(this.i0);
                     this.i2 &= 512;
                     if(this.i2 != 0)
                     {
                        addr149:
                        this.i2 = __2E_str3246;
                        mstate.esp -= 12;
                        si32(this.i0,mstate.esp);
                        si32(this.i2,mstate.esp + 4);
                        si32(this.i1,mstate.esp + 8);
                        state = 2;
                        mstate.esp -= 4;
                        FSM_luaO_pushfstring.start();
                        return;
                     }
                  }
                  this.i2 = __2E_str19367;
                  mstate.esp -= 12;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  state = 3;
                  mstate.esp -= 4;
                  FSM_luaO_pushfstring.start();
                  return;
               }
               this.i0 = _luaX_tokens;
               this.i1 <<= 2;
               this.i0 = this.i1 + this.i0;
               this.i0 = li32(this.i0 + -1028);
               addr286:
               mstate.eax = this.i0;
               break;
            case 1:
               §§goto(addr80);
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               §§goto(addr286);
            case 3:
               this.i1 = mstate.eax;
               mstate.esp += 12;
               mstate.eax = this.i1;
               break;
            default:
               throw "Invalid state in _luaX_token2str";
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
