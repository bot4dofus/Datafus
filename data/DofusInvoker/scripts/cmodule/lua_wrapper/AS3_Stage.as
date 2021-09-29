package cmodule.lua_wrapper
{
   function AS3_Stage() : Object
   {
      return !!gsprite ? gsprite.stage : null;
   }
}
