package com.ankamagames.tiphon.types
{
   import flash.display.DisplayObjectContainer;
   import flash.utils.getQualifiedClassName;
   
   public class CarriedSprite extends DynamicSprite
   {
       
      
      public function CarriedSprite()
      {
         super();
      }
      
      override public function init(handler:IAnimationSpriteHandler) : void
      {
         var splitedName:Array = getQualifiedClassName(this).split("_");
         var c:DisplayObjectContainer = handler.getSubEntitySlot(parseInt(splitedName[1]),parseInt(splitedName[2]));
         if(c)
         {
            addChild(c);
         }
      }
   }
}
