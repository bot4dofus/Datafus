package cmodule.lua_wrapper
{
   public function establishEnv() : void
   {
      var ns:Namespace = null;
      try
      {
         ns = new Namespace("avmplus");
         gdomainClass = ns::["Domain"];
         gshell = true;
      }
      catch(e:*)
      {
      }
      if(!gdomainClass)
      {
         ns = new Namespace("flash.system");
         gdomainClass = ns::["ApplicationDomain"];
      }
   }
}
