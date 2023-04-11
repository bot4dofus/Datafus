package com.ankamagames.tubul.interfaces
{
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   
   public interface ISoundController extends IEventDispatcher
   {
       
      
      function get effects() : Vector.<IEffect>;
      
      function get volume() : Number;
      
      function set volume(param1:Number) : void;
      
      function get currentFadeVolume() : Number;
      
      function set currentFadeVolume(param1:Number) : void;
      
      function get effectiveVolume() : Number;
      
      function addEffect(param1:IEffect) : void;
      
      function removeEffect(param1:IEffect) : void;
      
      function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void;
   }
}
