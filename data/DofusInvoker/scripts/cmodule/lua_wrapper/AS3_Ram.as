package cmodule.lua_wrapper
{
   import flash.utils.ByteArray;
   
   function AS3_Ram() : ByteArray
   {
      return gstate.ds;
   }
}
