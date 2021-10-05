package cmodule.lua_wrapper
{
   function AS3_Shim(param1:Function, param2:Object, param3:String, param4:String, param5:Boolean) : int
   {
      var retType:CTypemap = null;
      var argTypes:Array = null;
      var tm:CTypemap = null;
      var id:int = 0;
      var func:Function = param1;
      var thiz:Object = param2;
      var rt:String = param3;
      var tt:String = param4;
      var varargs:Boolean = param5;
      retType = CTypemap.getTypeByName(rt);
      argTypes = CTypemap.getTypesByNames(tt);
      tm = new CProcTypemap(retType,argTypes,varargs);
      id = tm.createC(function(... rest):*
      {
         return func.apply(thiz,rest);
      })[0];
      return id;
   }
}
