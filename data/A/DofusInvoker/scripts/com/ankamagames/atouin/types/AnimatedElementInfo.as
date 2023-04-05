package com.ankamagames.atouin.types
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.utils.getTimer;
   
   public final class AnimatedElementInfo
   {
       
      
      public var tiphonSprite:TiphonSprite;
      
      public var min:int;
      
      public var max:int;
      
      public var nextAnimation:int;
      
      public function AnimatedElementInfo(tiphonSprite:TiphonSprite, min:int, max:int)
      {
         super();
         this.tiphonSprite = tiphonSprite;
         this.min = min;
         this.max = max;
         this.setNextAnimation();
      }
      
      public function setNextAnimation() : void
      {
         this.nextAnimation = getTimer() + this.min + int(Math.random() * (this.max - this.min));
      }
   }
}
