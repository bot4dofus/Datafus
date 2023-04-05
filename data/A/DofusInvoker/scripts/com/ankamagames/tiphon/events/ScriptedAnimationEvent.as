package com.ankamagames.tiphon.events
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.events.Event;
   
   public class ScriptedAnimationEvent extends Event
   {
      
      public static const SCRIPTED_ANIMATION_ADDED:String = "scripted_animation_added";
       
      
      private var _entity:TiphonSprite;
      
      public function ScriptedAnimationEvent(name:String, entity:TiphonSprite)
      {
         super(name);
         this._entity = entity;
      }
      
      public function get entity() : TiphonSprite
      {
         return this._entity;
      }
   }
}
