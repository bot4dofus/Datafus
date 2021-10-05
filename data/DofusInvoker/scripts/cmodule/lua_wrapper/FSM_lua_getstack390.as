package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_lua_getstack390 extends Machine
   {
       
      
      public function FSM_lua_getstack390()
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
         var _loc7_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = li32(mstate.ebp + 16);
         _loc4_ = li32(mstate.ebp + 20);
         _loc5_ = _loc1_;
         if(_loc3_ >= 1)
         {
            _loc6_ = 0;
            while(true)
            {
               _loc7_ = int(_loc5_);
               if(uint(_loc5_) <= uint(_loc2_))
               {
                  _loc1_ = _loc7_;
                  break;
               }
               _loc7_ = int(li32(_loc5_ + 4));
               _loc7_ = int(li32(_loc7_));
               _loc7_ = int(li8(_loc7_ + 6));
               _loc3_ += -1;
               if(_loc7_ == 0)
               {
                  _loc7_ = int(li32(_loc5_ + 20));
                  _loc3_ -= _loc7_;
               }
               _loc7_ = _loc6_ ^ -1;
               _loc7_ *= 24;
               _loc5_ += -24;
               _loc6_ += 1;
               _loc7_ = int(_loc1_ + _loc7_);
               if(_loc3_ < 1)
               {
                  _loc1_ = _loc7_;
               }
            }
         }
         if(_loc3_ == 0)
         {
            if(uint(_loc1_) > uint(_loc2_))
            {
               _loc3_ = 1;
               _loc1_ -= _loc2_;
               _loc1_ /= 24;
               si32(_loc1_,_loc4_ + 96);
               mstate.eax = _loc3_;
            }
            else
            {
               addr207:
               if(_loc3_ <= -1)
               {
                  _loc1_ = 0;
                  si32(_loc1_,_loc4_ + 96);
                  _loc1_ = 1;
               }
               else
               {
                  _loc1_ = 0;
               }
               mstate.eax = _loc1_;
            }
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr207);
      }
   }
}
