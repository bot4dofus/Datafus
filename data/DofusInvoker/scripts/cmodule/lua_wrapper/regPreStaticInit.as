package cmodule.lua_wrapper
{
   public function regPreStaticInit(param1:Function) : void
   {
      if(!gpreStaticInits)
      {
         gpreStaticInits = [];
      }
      gpreStaticInits.push(param1);
   }
}
