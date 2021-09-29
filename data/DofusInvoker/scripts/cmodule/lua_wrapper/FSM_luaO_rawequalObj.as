package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_luaO_rawequalObj extends Machine
   {
       
      
      public function FSM_luaO_rawequalObj()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = li32(_loc1_ + 8);
         _loc4_ = li32(_loc2_ + 8);
         if(_loc3_ != _loc4_)
         {
            _loc1_ = 0;
         }
         else
         {
            if(_loc3_ <= 1)
            {
               if(_loc3_ != 0)
               {
                  if(_loc3_ != 1)
                  {
                     addr141:
                     addr142:
                  }
                  _loc1_ = int(li32(_loc1_));
                  _loc2_ = li32(_loc2_);
                  _loc1_ = int(_loc1_ == _loc2_ ? 1 : 0);
                  addr136:
                  _loc1_ &= 1;
               }
               else
               {
                  _loc1_ = 1;
               }
               §§goto(addr146);
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
            if(_loc3_ != 2)
            {
               if(_loc3_ != 3)
               {
                  §§goto(addr141);
               }
               else
               {
                  _loc5_ = lf64(_loc1_);
                  _loc6_ = lf64(_loc2_);
                  _loc1_ = int(_loc5_ == _loc6_ ? 1 : 0);
               }
               §§goto(addr136);
            }
            §§goto(addr142);
         }
         §§goto(addr136);
      }
   }
}
