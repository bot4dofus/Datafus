package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaF_getlocalname388 extends Machine
   {
       
      
      public function FSM_luaF_getlocalname388()
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
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = li32(mstate.ebp + 16);
         _loc4_ = li32(mstate.ebp + 20);
         _loc5_ = _loc1_;
         if(_loc2_ >= 1)
         {
            _loc6_ = 0;
            while(true)
            {
               _loc7_ = _loc5_;
               _loc5_ = _loc6_;
               _loc6_ = li32(_loc7_ + 4);
               if(_loc6_ > _loc4_)
               {
                  break;
               }
               _loc6_ = li32(_loc7_ + 8);
               if(_loc6_ > _loc4_)
               {
                  _loc6_ = _loc3_ + -1;
                  if(_loc3_ == 1)
                  {
                     _loc3_ = _loc5_ * 12;
                     _loc3_ = _loc1_ + _loc3_;
                     _loc3_ = li32(_loc3_);
                     _loc3_ += 16;
                     mstate.eax = _loc3_;
                  }
                  else
                  {
                     addr157:
                  }
                  _loc3_ = _loc6_;
                  continue;
                  mstate.esp = mstate.ebp;
               }
               continue;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
         }
         _loc1_ = 0;
         mstate.eax = _loc1_;
         §§goto(addr157);
      }
   }
}
