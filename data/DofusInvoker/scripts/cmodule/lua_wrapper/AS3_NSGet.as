package cmodule.lua_wrapper
{
   function AS3_NSGet(param1:*, param2:*) : *
   {
      var _loc3_:* = null;
      _loc3_ = typeof param1;
      if(_loc3_ == "undefined" || !(param1 instanceof Namespace))
      {
         if(_loc3_ == "string")
         {
            param1 = new Namespace(param1);
         }
         else
         {
            param1 = new Namespace();
         }
      }
      return param1::[param2];
   }
}
