package cmodule.lua_wrapper
{
   public function _brk(param1:int) : int
   {
      var _loc2_:int = 0;
      _loc2_ = param1;
      gstate.ds.length = _loc2_;
      return 0;
   }
}
