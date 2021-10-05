package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.jerakine.interfaces.ISoundPositionListener;
   import com.ankamagames.tubul.interfaces.ILocalizedSoundListener;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   
   public interface ISoundManager extends ILocalizedSoundListener, IInterfaceListener, IFLAEventHandler, ISoundPositionListener
   {
       
      
      function set soundDirectoryExist(param1:Boolean) : void;
      
      function get soundDirectoryExist() : Boolean;
      
      function get soundIsActivate() : Boolean;
      
      function retriveRollOffPresets() : void;
      
      function setSubArea(param1:Map = null) : void;
      
      function playSound(param1:ISound, param2:Boolean = false, param3:int = -1) : ISound;
      
      function upFightMusicVolume() : void;
      
      function playFightMusic(param1:Boolean = false) : void;
      
      function stopFightMusic() : void;
      
      function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void;
      
      function playIntroMusic(param1:Boolean = true) : void;
      
      function switchIntroMusic(param1:Boolean) : void;
      
      function stopIntroMusic(param1:Boolean = false) : void;
      
      function removeAllSounds(param1:Number = 0, param2:Number = 0) : void;
      
      function reset() : void;
      
      function fadeBusVolume(param1:int, param2:Number, param3:Number) : void;
      
      function setBusVolume(param1:int, param2:Number) : void;
      
      function activateSound() : void;
      
      function deactivateSound() : void;
      
      function playAdminSound(param1:String, param2:Number, param3:Boolean, param4:uint) : void;
      
      function stopAdminSound(param1:uint) : void;
      
      function addSoundInPlaylist(param1:String, param2:Number, param3:uint, param4:uint) : Boolean;
      
      function removeSoundInPLaylist(param1:String) : Boolean;
      
      function playPlaylist() : void;
      
      function stopPlaylist() : void;
      
      function resetPlaylist() : void;
      
      function playStopableSound(param1:String) : void;
      
      function stopStopableSound(param1:String) : void;
      
      function stopAllStopableSounds() : void;
      
      function endOfSound(param1:int) : void;
   }
}
