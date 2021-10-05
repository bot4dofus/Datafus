package cmodule.lua_wrapper
{
   interface ICAllocator
   {
       
      
      function free(param1:int) : void;
      
      function alloc(param1:int) : int;
   }
}
