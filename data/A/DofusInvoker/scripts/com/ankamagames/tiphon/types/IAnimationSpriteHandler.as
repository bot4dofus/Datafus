package com.ankamagames.tiphon.types
{
   import com.ankamagames.jerakine.entities.interfaces.ISubEntityContainer;
   import com.ankamagames.tiphon.engine.TiphonEventsManager;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public interface IAnimationSpriteHandler extends ISubEntityContainer
   {
       
      
      function registerColoredSprite(param1:ColoredSprite, param2:uint) : void;
      
      function registerInfoSprite(param1:DisplayInfoSprite, param2:String) : void;
      
      function getSkinSprite(param1:EquipmentSprite) : Sprite;
      
      function onAnimationEvent(param1:String, param2:String = "") : void;
      
      function getColorTransform(param1:uint) : ColorTransform;
      
      function get tiphonEventManager() : TiphonEventsManager;
      
      function get maxFrame() : uint;
      
      function getAnimation() : String;
      
      function getDirection() : uint;
   }
}
