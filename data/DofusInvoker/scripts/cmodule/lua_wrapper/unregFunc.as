package cmodule.lua_wrapper
{
   public function unregFunc(param1:int) : void
   {
      if(param1 + 1 == gstate.funcs.length)
      {
         gstate.funcs.pop();
      }
   }
}
