package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___ucmpdi2 extends Machine
   {
       
      
      public function FSM___ucmpdi2()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 12);
         _loc2_ = li32(mstate.ebp + 20);
         _loc3_ = li32(mstate.ebp + 8);
         _loc4_ = li32(mstate.ebp + 16);
         _loc5_ = _loc2_;
         _loc5_ = _loc1_;
         if(uint(_loc1_) >= uint(_loc2_))
         {
            if(uint(_loc1_) > uint(_loc2_))
            {
               _loc1_ = 2;
            }
            else
            {
               _loc1_ = _loc4_;
               _loc2_ = _loc3_;
               if(uint(_loc3_) >= uint(_loc4_))
               {
                  _loc1_ = uint(_loc2_) > uint(_loc1_) ? 2 : 1;
               }
               else
               {
                  addr90:
                  _loc1_ = 0;
               }
            }
            mstate.eax = _loc1_;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr90);
      }
   }
}
