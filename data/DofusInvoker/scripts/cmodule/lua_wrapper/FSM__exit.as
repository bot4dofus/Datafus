package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM__exit extends Machine
   {
       
      
      public function FSM__exit()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         throw new AlchemyExit(_loc1_);
      }
   }
}
