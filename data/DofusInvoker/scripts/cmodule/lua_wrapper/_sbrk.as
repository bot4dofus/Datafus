package cmodule.lua_wrapper
{
   public function _sbrk(param1:int) : int
   {
      var _loc2_:int = 0;
      var _loc3_:int = 0;
      _loc2_ = gstate.ds.length;
      _loc3_ = _loc2_ + param1;
      gstate.ds.length = _loc3_;
      return _loc2_;
   }
}
