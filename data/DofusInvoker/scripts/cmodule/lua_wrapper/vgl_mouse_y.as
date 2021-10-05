package cmodule.lua_wrapper
{
   import flash.display.Stage;
   
   function vgl_mouse_y() : int
   {
      var _loc1_:Stage = null;
      _loc1_ = gsprite.stage;
      return _loc1_.mouseY;
   }
}
