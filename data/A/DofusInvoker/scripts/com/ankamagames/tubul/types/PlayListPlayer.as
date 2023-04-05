package com.ankamagames.tubul.types
{
   import com.ankamagames.jerakine.BalanceManager.BalanceManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.tubul.enum.EventListenerPriority;
   import com.ankamagames.tubul.events.FadeEvent;
   import com.ankamagames.tubul.events.PlaylistEvent;
   import com.ankamagames.tubul.events.SoundFadingOutEvent;
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.types.sounds.LocalizedSound;
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   
   [Event(name="new_sound",type="com.ankamagames.tubul.events.PlaylistEvent")]
   [Event(name="complete",type="com.ankamagames.tubul.events.PlaylistEvent")]
   public class PlayListPlayer extends EventDispatcher
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayListPlayer));
       
      
      private var _sounds:Vector.<ISound>;
      
      private var _playingSound:ISound;
      
      private var _lastPlayedSound:ISound;
      
      private var _playingSoundIndex:int;
      
      private var _mustCloneSounds:Boolean;
      
      public var loop:Boolean;
      
      private var _random:Boolean;
      
      private var _startRandom:Boolean;
      
      private var _randomOnce:Boolean;
      
      private var _isPlaying:Boolean = false;
      
      private var _balanceManager:BalanceManager;
      
      private var _fadeIn:VolumeFadeEffect;
      
      private var _fadeOut:VolumeFadeEffect;
      
      public var isAmbiance:Boolean = false;
      
      public function PlayListPlayer(pLoop:Boolean = false, pSilence:SoundSilence = null, pFadeIn:VolumeFadeEffect = null, pFadeOut:VolumeFadeEffect = null, pMustCloneSounds:Boolean = false, startRandom:Boolean = false, randomOnce:Boolean = false, random:Boolean = false)
      {
         super();
         this.loop = pLoop;
         this._fadeIn = pFadeIn;
         this._fadeOut = pFadeOut;
         this._mustCloneSounds = pMustCloneSounds;
         this._random = random;
         this._startRandom = startRandom;
         this._randomOnce = randomOnce;
         this.init();
      }
      
      public function get tracklist() : Vector.<ISound>
      {
         return this._sounds;
      }
      
      public function get playingSound() : ISound
      {
         if(this._isPlaying)
         {
            return this._playingSound;
         }
         return null;
      }
      
      public function get playingSoundIndex() : int
      {
         if(this._isPlaying)
         {
            this._playingSoundIndex;
         }
         return -1;
      }
      
      public function get running() : Boolean
      {
         return this._isPlaying;
      }
      
      public function get fadeOut() : VolumeFadeEffect
      {
         return this._fadeOut;
      }
      
      public function addSound(pSound:ISound) : uint
      {
         if(this._sounds.indexOf(pSound) == -1)
         {
            if(this._randomOnce)
            {
               this._sounds.insertAt(Math.floor(Math.random() * (this._sounds.length + 1)),pSound);
            }
            else
            {
               this._sounds.push(pSound);
            }
            this._balanceManager.addItem(pSound);
         }
         return this._sounds.length;
      }
      
      public function removeSound(pSound:ISound) : uint
      {
         var index:int = this._sounds.indexOf(pSound);
         if(index != -1)
         {
            if(pSound.isPlaying)
            {
               pSound.stop();
            }
            this._balanceManager.removeItem(pSound);
            this._sounds.splice(index,1);
         }
         return this._sounds.length;
      }
      
      public function removeSoundBySoundId(pSoundId:String, pRemoveAll:Boolean = true) : uint
      {
         var sound:ISound = null;
         var index:int = 0;
         for each(sound in this._sounds)
         {
            if(sound.uri.fileName.split(".")[0] == pSoundId)
            {
               index = this._sounds.indexOf(sound);
               if(index != -1)
               {
                  if(sound.isPlaying)
                  {
                     sound.stop();
                  }
                  this._balanceManager.removeItem(sound);
                  this._sounds.splice(index,1);
               }
            }
         }
         return this._sounds.length;
      }
      
      public function play() : void
      {
         var soundToPlay:ISound = null;
         if(this._isPlaying)
         {
            return;
         }
         if(this._sounds && this._sounds.length > 0)
         {
            this._isPlaying = true;
            if(this._startRandom)
            {
               soundToPlay = this._balanceManager.callItem() as ISound;
            }
            else
            {
               soundToPlay = this._sounds[0] as ISound;
            }
            this.playSound(soundToPlay,true);
         }
      }
      
      public function playLastSound(loopNumber:int) : void
      {
         var mustFade:Boolean = false;
         if(this._playingSound && this._playingSound.isPlaying)
         {
            this._playingSound.stop();
         }
         if(this._lastPlayedSound)
         {
            this._lastPlayedSound.setLoops(loopNumber);
            this.playSound(this._lastPlayedSound,mustFade);
         }
      }
      
      public function nextSound(pFadeOutCurrentSound:VolumeFadeEffect = null, pPlaySilenceBefore:Boolean = false, mustFade:Boolean = false) : void
      {
         var soundToPlay:ISound = null;
         var index:int = 0;
         if(this._playingSound.isPlaying)
         {
            this._playingSound.stop(pFadeOutCurrentSound);
         }
         this._lastPlayedSound = this._playingSound;
         if(pPlaySilenceBefore && this._playingSound)
         {
            return;
         }
         if(this._random && this._sounds.length > 1 && !this._randomOnce)
         {
            do
            {
               soundToPlay = this._balanceManager.callItem() as ISound;
            }
            while(soundToPlay.id == this._lastPlayedSound.id);
            
         }
         else
         {
            index = this._playingSoundIndex;
            if(index == this._sounds.length - 1)
            {
               _log.info("We reached the end of the playlist.");
               if(this.loop)
               {
                  _log.info("Playlist is in loop mode. Looping.");
                  soundToPlay = this._sounds[0] as ISound;
               }
               else
               {
                  _log.info("Playlist stop.");
                  this._playingSound = null;
                  this._isPlaying = false;
               }
               dispatchEvent(new PlaylistEvent(PlaylistEvent.COMPLETE));
            }
            else if(this._sounds.length > index + 1)
            {
               soundToPlay = this._sounds[index + 1] as ISound;
            }
         }
         if(soundToPlay)
         {
            this.playSound(soundToPlay,mustFade);
         }
      }
      
      public function stop(pFadeOut:VolumeFadeEffect = null) : void
      {
         if(pFadeOut)
         {
            pFadeOut.addEventListener(FadeEvent.COMPLETE,this.onFadeOutStopPlaylistComplete);
         }
         if(this.playingSound)
         {
            this._playingSound.eventDispatcher.removeEventListener(SoundFadingOutEvent.SOUND_FADING_OUT,this.onSoundComplete);
            this._playingSound.stop(pFadeOut);
         }
         this._isPlaying = false;
         dispatchEvent(new PlaylistEvent(PlaylistEvent.COMPLETE));
      }
      
      public function reset(pFadeOut:VolumeFadeEffect = null) : void
      {
         this.stop(pFadeOut);
         this.init();
      }
      
      private function init() : void
      {
         var s:ISound = null;
         if(this._sounds)
         {
            for each(s in this._sounds)
            {
               if(s != null)
               {
                  s.stop();
                  s = null;
               }
            }
         }
         this._sounds = new Vector.<ISound>();
         this._balanceManager = new BalanceManager();
         this._isPlaying = false;
      }
      
      private function playSound(pSound:ISound, mustFade:Boolean = false) : void
      {
         var fadeIn:VolumeFadeEffect = null;
         var loop:Boolean = false;
         var fadeOut:VolumeFadeEffect = null;
         var event:PlaylistEvent = null;
         if(!this._isPlaying)
         {
            this._isPlaying = true;
         }
         this._lastPlayedSound = this._playingSound;
         this._playingSoundIndex = this._sounds.indexOf(pSound);
         if(this._mustCloneSounds)
         {
            this._playingSound = pSound.clone();
         }
         else
         {
            this._playingSound = pSound;
         }
         if(this._lastPlayedSound && this._playingSound.id == this._lastPlayedSound.id && this._playingSound.isPlaying)
         {
            this._playingSound = this._playingSound.clone();
         }
         this._playingSound.eventDispatcher.addEventListener(SoundFadingOutEvent.SOUND_FADING_OUT,this.onSoundComplete,false,EventListenerPriority.NORMAL);
         var bus:IAudioBus = this._playingSound.bus;
         if(bus != null)
         {
            loop = false;
            if(this._playingSound.totalLoops > -1)
            {
               loop = true;
            }
            if(this._fadeIn && mustFade)
            {
               fadeIn = this._fadeIn.clone();
            }
            else
            {
               fadeIn = new VolumeFadeEffect(0,1,0.5);
               this._playingSound.currentFadeVolume = 1;
            }
            if(this._fadeOut && mustFade)
            {
               fadeOut = this._fadeOut.clone();
            }
            else
            {
               fadeOut = new VolumeFadeEffect(1,0,0.5);
            }
            this._playingSound.play(loop,this._playingSound.totalLoops,fadeIn,fadeOut);
            event = new PlaylistEvent(PlaylistEvent.NEW_SOUND);
            event.newSound = this._playingSound;
            dispatchEvent(event);
         }
      }
      
      private function onSoundComplete(pEvent:SoundFadingOutEvent) : void
      {
         var sound:ISound = null;
         this._playingSound.eventDispatcher.removeEventListener(SoundFadingOutEvent.SOUND_FADING_OUT,this.onSoundComplete);
         if(this._sounds.indexOf(pEvent.sound) != -1)
         {
            pEvent.stopImmediatePropagation();
            dispatchEvent(new PlaylistEvent(PlaylistEvent.SOUND_ENDED));
            return;
         }
         for each(sound in this._sounds)
         {
            if(sound is LocalizedSound && pEvent.sound is LocalizedSound && (sound as LocalizedSound).soundWrapper.sound == (pEvent.sound as LocalizedSound).soundWrapper.sound)
            {
               pEvent.stopImmediatePropagation();
               dispatchEvent(new PlaylistEvent(PlaylistEvent.SOUND_ENDED));
               return;
            }
         }
      }
      
      private function onFadeOutStopPlaylistComplete(pEvent:FadeEvent) : void
      {
         (pEvent.target as VolumeFadeEffect).removeEventListener(FadeEvent.COMPLETE,this.onFadeOutStopPlaylistComplete);
         this.stop();
      }
   }
}
