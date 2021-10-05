package cmodule.lua_wrapper
{
   public function importSym(param1:String) : int
   {
      var res:int = 0;
      var s:String = param1;
      res = gstate.syms[s];
      if(!res)
      {
         log(3,"Undefined sym: " + s);
         return exportSym(s,regFunc(function():*
         {
            throw "Undefined sym: " + s;
         }));
      }
      return res;
   }
}
