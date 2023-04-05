package com.ankamagames.tiphon.types
{
   import flash.utils.getQualifiedClassName;
   
   public class DisplayInfoSprite extends DynamicSprite
   {
       
      
      public function DisplayInfoSprite()
      {
         super();
      }
      
      override public function init(handler:IAnimationSpriteHandler) : void
      {
         alpha = 0;
         var nViewIndex:String = getQualifiedClassName(this).split("_")[1];
         handler.registerInfoSprite(this,nViewIndex);
      }
   }
}
