package cmodule.lua_wrapper
{
   function AS3_UnregAbused_jmp_buf(param1:int) : void
   {
      log(4,"unregAbused: " + param1);
      log(1,"Can\'t UnregAbused -- abuse support disabled");
   }
}
