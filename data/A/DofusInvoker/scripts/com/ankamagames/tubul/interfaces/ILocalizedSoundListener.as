package com.ankamagames.tubul.interfaces
{
   import flash.utils.Dictionary;
   
   public interface ILocalizedSoundListener
   {
       
      
      function get entitySounds() : Array;
      
      function get reverseEntitySounds() : Dictionary;
      
      function addSoundEntity(param1:ISound, param2:Number) : void;
      
      function removeSoundEntity(param1:ISound) : void;
   }
}
