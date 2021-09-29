package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_lua_getfenv extends Machine
   {
       
      
      public function FSM_lua_getfenv()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         mstate.esp -= 8;
         _loc2_ = li32(mstate.ebp + 12);
         si32(_loc1_,mstate.esp);
         si32(_loc2_,mstate.esp + 4);
         mstate.esp -= 4;
         FSM_index2adr.start();
         _loc2_ = mstate.eax;
         mstate.esp += 8;
         _loc3_ = li32(_loc2_ + 8);
         _loc1_ += 8;
         if(_loc3_ != 8)
         {
            if(_loc3_ != 7)
            {
               if(_loc3_ == 6)
               {
                  addr128:
                  _loc3_ = 5;
                  _loc2_ = li32(_loc2_);
                  _loc4_ = li32(_loc1_);
                  _loc2_ = li32(_loc2_ + 12);
                  si32(_loc2_,_loc4_);
                  si32(_loc3_,_loc4_ + 8);
               }
               else
               {
                  _loc2_ = 0;
                  _loc3_ = li32(_loc1_);
                  addr184:
                  si32(_loc2_,_loc3_ + 8);
               }
               _loc2_ = li32(_loc1_);
               _loc2_ += 12;
               si32(_loc2_,_loc1_);
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
            §§goto(addr128);
         }
         else
         {
            _loc2_ = li32(_loc2_);
            _loc3_ = li32(_loc1_);
            _loc5_ = lf64(_loc2_ + 72);
            sf64(_loc5_,_loc3_);
            _loc2_ = li32(_loc2_ + 80);
         }
         §§goto(addr184);
      }
   }
}
