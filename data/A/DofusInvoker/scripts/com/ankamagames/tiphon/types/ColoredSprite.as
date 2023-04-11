package com.ankamagames.tiphon.types
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.ColorTransform;
   import flash.utils.getQualifiedClassName;
   
   public class ColoredSprite extends DynamicSprite
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ColoredSprite));
      
      private static const NEUTRAL_COLOR_TRANSFORM:ColorTransform = new ColorTransform();
       
      
      public function ColoredSprite()
      {
         super();
      }
      
      override public function init(handler:IAnimationSpriteHandler) : void
      {
         var colorT:ColorTransform = null;
         var qualifiedClassName:String = getQualifiedClassName(this);
         var firstIndexOf:int = qualifiedClassName.indexOf("_");
         var secondIndexOf:int = qualifiedClassName.indexOf("_",firstIndexOf + 1);
         var colorIndex:String = secondIndexOf < 0 ? qualifiedClassName.substring(firstIndexOf + 1) : qualifiedClassName.substring(firstIndexOf + 1,secondIndexOf);
         var nColorIndex:uint = parseInt(colorIndex);
         colorT = handler.getColorTransform(nColorIndex);
         if(colorT)
         {
            this.colorize(colorT);
         }
         handler.registerColoredSprite(this,nColorIndex);
      }
      
      public function colorize(colorT:ColorTransform) : void
      {
         if(colorT)
         {
            transform.colorTransform = colorT;
         }
         else
         {
            transform.colorTransform = NEUTRAL_COLOR_TRANSFORM;
         }
      }
   }
}
