package cmodule.lua_wrapper
{
   public function isnan(param1:Number) : int
   {
      return int(param1 === Number.NaN);
   }
}
