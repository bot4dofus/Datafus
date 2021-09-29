package cmodule.lua_wrapper
{
   public function vgl_end(param1:int) : int
   {
      var _loc2_:int = 0;
      _loc2_ = gvglpixels;
      gvglpixels = 0;
      return _loc2_;
   }
}
