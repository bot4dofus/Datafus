package cmodule.lua_wrapper
{
   public function log(param1:int, param2:String) : void
   {
      if(param1 < glogLvl)
      {
         trace(param2);
      }
   }
}
