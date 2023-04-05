package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.managers.CursorSpriteManager;
   
   public class CursorConstant
   {
      
      public static var resizeV:Class = CursorConstant_resizeV;
      
      public static var resizeH:Class = CursorConstant_resizeH;
      
      public static var resizeL:Class = CursorConstant_resizeL;
      
      public static var resizeR:Class = CursorConstant_resizeR;
      
      public static var drag:Class = CursorConstant_drag;
       
      
      public function CursorConstant()
      {
         super();
      }
      
      public static function init() : void
      {
         CursorSpriteManager.registerSpecificCursor("resizeV",new CursorConstant.resizeV());
         CursorSpriteManager.registerSpecificCursor("resizeH",new CursorConstant.resizeH());
         CursorSpriteManager.registerSpecificCursor("resizeL",new CursorConstant.resizeL());
         CursorSpriteManager.registerSpecificCursor("resizeR",new CursorConstant.resizeR());
         CursorSpriteManager.registerSpecificCursor("drag",new CursorConstant.drag());
      }
   }
}
