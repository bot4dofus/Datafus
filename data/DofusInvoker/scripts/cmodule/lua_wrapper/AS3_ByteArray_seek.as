package cmodule.lua_wrapper
{
   import flash.utils.ByteArray;
   
   function AS3_ByteArray_seek(param1:ByteArray, param2:int, param3:int) : int
   {
      if(param3 == 0)
      {
         param1.position = param2;
      }
      else if(param3 == 1)
      {
         param1.position += param2;
      }
      else
      {
         if(param3 != 2)
         {
            return -1;
         }
         param1.position = param1.length + param2;
      }
      return param1.position;
   }
}
