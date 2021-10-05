package com.ankamagames.atouin.managers
{
   import com.ankamagames.atouin.types.WorldEntitySprite;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.utils.getQualifiedClassName;
   
   public class AlwaysAnimatedElementManager
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(AlwaysAnimatedElementManager));
      
      private static const MAX_ALWAYS_ANIMATED_ELEMENTS:uint = 3;
      
      private static var _elements:Vector.<WorldEntitySprite> = new Vector.<WorldEntitySprite>();
      
      private static var _currentIndex:int;
      
      private static var _elementsReady:int;
       
      
      public function AlwaysAnimatedElementManager()
      {
         super();
      }
      
      public static function reset() : void
      {
         _elements.length = 0;
      }
      
      public static function addAnimatedElement(sprite:WorldEntitySprite) : void
      {
         _elements.push(sprite);
         stopAnimation(sprite);
      }
      
      public static function removeAnimatedElement(sprite:WorldEntitySprite) : void
      {
         var i:int = _elements.indexOf(sprite);
         if(i != -1)
         {
            _elements.splice(i,1);
         }
      }
      
      public static function startAnims() : void
      {
         var sprite:WorldEntitySprite = null;
         _currentIndex = 0;
         _elementsReady = 0;
         for each(sprite in _elements)
         {
            sprite.setAnimation("AnimStart");
            if(!sprite.rawAnimation)
            {
               sprite.addEventListener(TiphonEvent.RENDER_SUCCEED,onRenderSucceed);
            }
            else
            {
               ++_elementsReady;
               stopAnimation(sprite);
            }
         }
         if(_elementsReady)
         {
            checkAnimsReady();
         }
      }
      
      private static function onRenderSucceed(event:TiphonEvent) : void
      {
         event.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,onRenderSucceed);
         ++_elementsReady;
         stopAnimation(event.sprite);
         checkAnimsReady();
      }
      
      private static function checkAnimsReady() : void
      {
         var sprite:WorldEntitySprite = null;
         if(_elementsReady == _elements.length)
         {
            if(_elements.length > MAX_ALWAYS_ANIMATED_ELEMENTS)
            {
               onAnimationEnd();
            }
            else
            {
               for each(sprite in _elements)
               {
                  sprite.restartAnimation();
               }
            }
         }
      }
      
      private static function onAnimationEnd(event:TiphonEvent = null) : void
      {
         var sprite:WorldEntitySprite = null;
         if(event)
         {
            event.currentTarget.removeEventListener(TiphonEvent.ANIMATION_END,onAnimationEnd);
            event.currentTarget.stopAnimation();
         }
         if(_currentIndex < _elements.length)
         {
            sprite = _elements[_currentIndex];
            sprite.addEventListener(TiphonEvent.ANIMATION_END,onAnimationEnd);
            ++_currentIndex;
            sprite.setAnimation("AnimStart");
         }
         else
         {
            startAnims();
         }
      }
      
      private static function stopAnimation(sprite:TiphonSprite) : void
      {
         if(sprite.rawAnimation)
         {
            sprite.rawAnimation.gotoAndStop(0);
            FpsControler.uncontrolFps(sprite.rawAnimation);
         }
      }
   }
}
