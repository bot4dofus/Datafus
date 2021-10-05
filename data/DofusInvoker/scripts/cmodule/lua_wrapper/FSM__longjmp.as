package cmodule.lua_wrapper
{
   public class FSM__longjmp extends Machine
   {
       
      
      public function FSM__longjmp()
      {
         super();
      }
      
      public static function start() : void
      {
         gstate.gworker = new FSM__longjmp();
         throw new AlchemyDispatch();
      }
      
      override public function work() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Machine = null;
         mstate.pop();
         _loc1_ = _mr32(mstate.esp);
         _loc2_ = _mr32(mstate.esp + 4);
         log(4,"longjmp: " + _loc1_);
         _loc3_ = _mr32(_loc1_ + 4);
         _loc4_ = _mr32(_loc1_ + 8);
         _loc5_ = _mr32(_loc1_ + 12);
         log(3,"longjmp -- buf: " + _loc1_ + " state: " + _loc3_ + " esp: " + _loc4_ + " ebp: " + _loc5_);
         if(!_loc1_ || !_loc4_ || !_loc5_)
         {
            throw "longjmp -- bad jmp_buf";
         }
         _loc6_ = findMachineForESP(_loc4_);
         if(!_loc6_)
         {
            debugTraceMem(_loc1_ - 24,_loc1_ + 24);
            throw "longjmp -- bad esp";
         }
         delete gsetjmpMachine2ESPMap[_loc6_];
         mstate.gworker = _loc6_;
         _loc6_.state = _loc3_;
         mstate.esp = _loc4_;
         mstate.ebp = _loc5_;
         mstate.eax = _loc2_;
         throw new AlchemyDispatch();
      }
   }
}
