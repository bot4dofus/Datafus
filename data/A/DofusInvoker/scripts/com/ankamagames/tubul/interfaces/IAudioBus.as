package com.ankamagames.tubul.interfaces
{
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   
   public interface IAudioBus extends ISoundController
   {
       
      
      function get soundList() : Vector.<ISound>;
      
      function get id() : uint;
      
      function get name() : String;
      
      function set volumeMax(param1:Number) : void;
      
      function get volumeMax() : Number;
      
      function get numberSoundsLimitation() : int;
      
      function set numberSoundsLimitation(param1:int) : void;
      
      function addISound(param1:ISound) : void;
      
      function playISound(param1:ISound, param2:Boolean = false, param3:int = -1) : void;
      
      function clear(param1:VolumeFadeEffect = null) : void;
      
      function contains(param1:ISound) : Boolean;
      
      function clearCache() : void;
   }
}
