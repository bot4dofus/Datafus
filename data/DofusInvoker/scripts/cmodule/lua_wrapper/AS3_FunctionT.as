package cmodule.lua_wrapper
{
   function AS3_FunctionT(param1:int, param2:int, param3:String, param4:String, param5:Boolean) : Function
   {
      var _loc6_:CTypemap = null;
      _loc6_ = new CProcTypemap(CTypemap.getTypeByName(param3),CTypemap.getTypesByNames(param4),param5);
      return AS3_Function(param1,_loc6_.fromC([param2]));
   }
}