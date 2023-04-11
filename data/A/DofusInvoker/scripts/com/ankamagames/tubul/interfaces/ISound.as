package com.ankamagames.tubul.interfaces
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.types.SoundSilence;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import flash.media.Sound;
   
   public interface ISound extends ISoundController
   {
       
      
      function get silence() : SoundSilence;
      
      function set silence(param1:SoundSilence) : void;
      
      function get duration() : Number;
      
      function get stereo() : Boolean;
      
      function get totalLoops() : int;
      
      function get currentLoop() : uint;
      
      function get uri() : Uri;
      
      function get sound() : Sound;
      
      function set sound(param1:*) : void;
      
      function get busId() : int;
      
      function set busId(param1:int) : void;
      
      function get bus() : IAudioBus;
      
      function get id() : int;
      
      function get noCutSilence() : Boolean;
      
      function set noCutSilence(param1:Boolean) : void;
      
      function get isPlaying() : Boolean;
      
      function play(param1:Boolean = false, param2:int = 0, param3:VolumeFadeEffect = null, param4:VolumeFadeEffect = null) : void;
      
      function stop(param1:VolumeFadeEffect = null, param2:Boolean = false) : void;
      
      function loadSound(param1:ICache) : void;
      
      function setLoops(param1:int) : void;
      
      function setCurrentLoop(param1:uint) : void;
      
      function clone() : ISound;
   }
}
