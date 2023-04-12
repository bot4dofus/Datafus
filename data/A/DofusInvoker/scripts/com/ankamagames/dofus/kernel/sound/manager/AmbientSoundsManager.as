package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.dofus.datacenter.ambientSounds.PlaylistSound;
   import com.ankamagames.dofus.datacenter.playlists.Playlist;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.TubulSoundConfiguration;
   import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
   import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import flash.utils.getQualifiedClassName;
   
   public class AmbientSoundsManager
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(AmbientSoundsManager));
       
      
      private var _roleplayPlaylist:Playlist;
      
      private var _ambiantPlaylist:Playlist;
      
      private var _music:ISound;
      
      private var _previousMusic:ISound;
      
      private var _ambience:ISound;
      
      private var _previousAmbience:ISound;
      
      private var _musicA:PlaylistSound;
      
      private var _ambienceA:PlaylistSound;
      
      private var _previousMusicId:String;
      
      private var _previousMusicPlaylistID:int;
      
      private var _previousAmbienceId:String;
      
      private var _previousAmbiancePlaylistId:int;
      
      private var tubulOption:OptionManager;
      
      public function AmbientSoundsManager()
      {
         super();
         this.init();
      }
      
      public function get music() : ISound
      {
         return this._music;
      }
      
      public function get ambience() : ISound
      {
         return this._ambience;
      }
      
      public function setAmbientSounds(plMusic:Playlist = null, plAmbiant:Playlist = null) : void
      {
         var asound:PlaylistSound = null;
         this._roleplayPlaylist = plMusic;
         this._ambiantPlaylist = plAmbiant;
         var logText:* = "";
         if((!this._roleplayPlaylist || this._roleplayPlaylist.sounds.length == 0) && (!this._ambiantPlaylist || this._ambiantPlaylist.sounds.length == 0))
         {
            logText = "Ni musique ni ambiance pour cette map ??!!";
         }
         else
         {
            logText = "Cette map contient une playlist contenant les musique d\'id";
            if(this._roleplayPlaylist)
            {
               for each(asound in this._roleplayPlaylist.sounds)
               {
                  logText += asound.id + ", ";
               }
            }
            logText += "et une playlist contenant les ambiances d\'id";
            if(this._ambiantPlaylist)
            {
               for each(asound in this._ambiantPlaylist.sounds)
               {
                  logText += asound.id + ", ";
               }
            }
         }
         _log.info(logText);
      }
      
      public function selectValidSounds() : void
      {
         var rnd:int = 0;
         var playlistSound:PlaylistSound = null;
         var count:int = 0;
         if(this._ambiantPlaylist && this._ambiantPlaylist.sounds.length > 0)
         {
            count = this._ambiantPlaylist.sounds.length;
            rnd = !!this._ambiantPlaylist.startRandom ? int(int(Math.random() * count)) : 0;
            for each(playlistSound in this._ambiantPlaylist.sounds)
            {
               if(rnd == 0)
               {
                  this._ambienceA = playlistSound;
                  break;
               }
               rnd--;
            }
         }
         if(this._roleplayPlaylist && this._roleplayPlaylist.sounds.length > 0)
         {
            count = this._roleplayPlaylist.sounds.length;
            rnd = int(Math.random() * count);
            for each(playlistSound in this._roleplayPlaylist.sounds)
            {
               if(rnd == 0)
               {
                  this._musicA = playlistSound;
                  break;
               }
               rnd--;
            }
         }
      }
      
      public function playMusicAndAmbient() : void
      {
         var fade:VolumeFadeEffect = null;
         var fadeOut:VolumeFadeEffect = null;
         var roleplaySounds:Array = null;
         var fadeMusic:VolumeFadeEffect = null;
         var fadeOutMusic:VolumeFadeEffect = null;
         var roleplaySounds2:Array = null;
         if(!SoundManager.getInstance().manager.soundIsActivate)
         {
            return;
         }
         if(!RegConnectionManager.getInstance().isMain)
         {
            return;
         }
         if(this._ambienceA == null)
         {
            _log.warn("It seems that we have no ambiance for this map");
         }
         else
         {
            if(this._previousAmbienceId == this._ambienceA.id || this._ambiantPlaylist && this._previousAmbiancePlaylistId == this._ambiantPlaylist.id)
            {
               _log.warn("Same ambiance as in the previous map, we just adjust its volume");
               this._ambience.volume = this._ambienceA.volume / 100;
            }
            else
            {
               if(this._previousAmbience != null)
               {
                  fadeOut = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_OUT_AMBIANCE);
                  this._previousAmbience.stop(fadeOut);
               }
               this._ambience = new SoundDofus(String(this._ambienceA.id));
               this._ambience.volume = this._ambienceA.volume / 100;
               this._ambience.currentFadeVolume = 0;
               fade = new VolumeFadeEffect(-1,1,TubulSoundConfiguration.TIME_FADE_IN_AMBIANCE);
               if(this._ambiantPlaylist && this._ambiantPlaylist.sounds.length > 0)
               {
                  roleplaySounds = this.createPlaylistSounds(this._ambiantPlaylist);
                  RegConnectionManager.getInstance().send(ProtocolEnum.ADD_SOUNDS_PLAYLIST,this._ambiantPlaylist.crossfadeDuration,this._ambiantPlaylist.startRandom,this._ambiantPlaylist.startRandomOnce,this._ambiantPlaylist.random,roleplaySounds);
               }
            }
            this._previousAmbienceId = this._ambienceA.id;
         }
         this._previousAmbience = this._ambience;
         if(this._ambiantPlaylist)
         {
            this._previousAmbiancePlaylistId = this._ambiantPlaylist.id;
         }
         if(this._musicA == null)
         {
            _log.warn("It seems that we have no music for this map");
         }
         else
         {
            if(this._previousMusicId == this._musicA.id || this._roleplayPlaylist && this._previousMusicPlaylistID == this._roleplayPlaylist.id)
            {
               _log.warn("Same music as in the previous map");
               this._music.volume = this._musicA.volume / 100;
            }
            else
            {
               if(this._previousMusic != null)
               {
                  fadeOutMusic = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
                  this._previousMusic.stop(fadeOutMusic);
               }
               this._music = new SoundDofus(String(this._musicA.id));
               this._music.volume = this._musicA.volume / 100;
               this._music.currentFadeVolume = 0;
               this.tubulOption = OptionManager.getOptionManager("tubul");
               if(this._roleplayPlaylist && this._roleplayPlaylist.sounds.length > 0)
               {
                  roleplaySounds2 = this.createPlaylistSounds(this._roleplayPlaylist);
                  RegConnectionManager.getInstance().send(ProtocolEnum.ADD_SOUNDS_PLAYLIST,this._roleplayPlaylist.crossfadeDuration,this._roleplayPlaylist.startRandom,this._roleplayPlaylist.startRandomOnce,this._roleplayPlaylist.random,roleplaySounds2);
               }
               fadeMusic = new VolumeFadeEffect(-1,1,TubulSoundConfiguration.TIME_FADE_IN_MUSIC);
               fadeMusic.attachToSoundSource(this._music);
               fadeMusic.start();
            }
            this._previousMusicId = this._musicA.id;
         }
         this._previousMusic = this._music;
         if(this._roleplayPlaylist)
         {
            this._previousMusicPlaylistID = this._roleplayPlaylist.id;
         }
      }
      
      public function stopMusicAndAmbient() : void
      {
         if(this.ambience)
         {
            this.ambience.stop();
         }
         if(this.music)
         {
            this.music.stop();
         }
         this._previousAmbienceId = "";
         this._previousMusicId = "";
         this._previousAmbiancePlaylistId = -1;
         this._previousMusicPlaylistID = -1;
      }
      
      public function clear(pFade:Number = 0, pFadeTime:Number = 0) : void
      {
         this.stopMusicAndAmbient();
      }
      
      private function init() : void
      {
      }
      
      private function createPlaylistSounds(playlist:Playlist) : Array
      {
         var playlistSound:PlaylistSound = null;
         var music:ISound = null;
         var soundUriM:Uri = null;
         var soundPathM:String = null;
         var songsContainer:Array = new Array();
         for each(playlistSound in playlist.sounds)
         {
            soundPathM = SoundUtil.getConfigEntryByBusId(playlistSound.channel);
            soundUriM = new Uri(soundPathM + playlistSound.id + ".mp3");
            music = new SoundDofus(String(playlistSound.id));
            music.volume = playlistSound.volume / 100;
            music.currentFadeVolume = 0;
            songsContainer.push(music.id);
         }
         return songsContainer;
      }
   }
}
