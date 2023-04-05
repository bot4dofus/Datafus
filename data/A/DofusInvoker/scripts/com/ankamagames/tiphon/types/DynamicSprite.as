package com.ankamagames.tiphon.types
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class DynamicSprite extends MovieClip
   {
       
      
      public function DynamicSprite()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
      }
      
      public function init(handler:IAnimationSpriteHandler) : void
      {
      }
      
      private function onAdded(e:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         var currentDo:DisplayObject = e.target as DisplayObject;
         while(!(currentDo is TiphonSprite) && currentDo.parent)
         {
            currentDo = currentDo.parent;
         }
         if(currentDo is TiphonSprite)
         {
            this.init(currentDo as TiphonSprite);
         }
      }
      
      public function getRoot() : ScriptedAnimation
      {
         var current:DisplayObject = this;
         while(current)
         {
            if(current is ScriptedAnimation)
            {
               return current as ScriptedAnimation;
            }
            current = current.parent;
         }
         return null;
      }
   }
}
