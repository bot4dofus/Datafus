package cmodule.lua_wrapper
{
   public function vgl_unlock() : void
   {
      if(gvglbmd && gvglpixels)
      {
         gstate.ds.position = gvglpixels;
         gvglbmd.setPixels(gvglbmd.rect,gstate.ds);
      }
   }
}
