package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.dofus.datacenter.ambientSounds.PlaylistSound;
   import com.ankamagames.dofus.datacenter.playlists.Playlist;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.TubulSoundConfiguration;
   import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
   import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
   import com.ankamagames.jerakine.BalanceManager.BalanceManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.interfaces.ISound;
   import flash.utils.getQualifiedClassName;
   
   public class FightMusicManager
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(FightMusicManager));
       
      
      private var _fightMusic:PlaylistSound;
      
      private var _bossMusic:PlaylistSound;
      
      private var _hasBoss:Boolean;
      
      private var _fightMusicsId:Array;
      
      private var _fightMusicBalanceManager:BalanceManager;
      
      private var _fightMusicPlaylist:Playlist;
      
      private var _bossMusicPlaylist:Playlist;
      
      public function FightMusicManager()
      {
         super();
         this.init();
      }
      
      public function set hasBoss(boss:Boolean) : void
      {
         this._hasBoss = boss;
      }
      
      public function prepareFightMusic() : void
      {
         if(!RegConnectionManager.getInstance().isMain)
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.PREPARE_FIGHT_MUSIC);
      }
      
      public function startFightPlaylist(fadeStartVolume:Number = -1, fadeEndVolume:Number = 1) : void
      {
         if(!SoundManager.getInstance().manager.soundIsActivate)
         {
            return;
         }
         if(!RegConnectionManager.getInstance().isMain)
         {
            return;
         }
         var fightSongs:Array = new Array();
         var playlist:Playlist = null;
         if(this._hasBoss && this._bossMusicPlaylist)
         {
            fightSongs = this.createPlaylistSounds(this._bossMusicPlaylist);
            playlist = this._bossMusicPlaylist;
         }
         else if(this._fightMusicPlaylist)
         {
            fightSongs = this.createPlaylistSounds(this._fightMusicPlaylist);
            playlist = this._fightMusicPlaylist;
         }
         if(fightSongs.length > 0)
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.ADD_SOUNDS_PLAYLIST,playlist.crossfadeDuration,playlist.startRandom,playlist.startRandomOnce,playlist.random,fightSongs);
         }
      }
      
      public function stopFightMusic() : void
      {
         if(!SoundManager.getInstance().manager.soundIsActivate)
         {
            return;
         }
         if(!RegConnectionManager.getInstance().isMain)
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.STOP_FIGHT_MUSIC);
      }
      
      public function setFightSounds(combatPlaylist:Playlist, bossFightPlaylist:Playlist) : void
      {
         this._fightMusicPlaylist = combatPlaylist;
         this._bossMusicPlaylist = bossFightPlaylist;
         if((!this._fightMusicPlaylist || this._fightMusicPlaylist.sounds.length == 0) && (!this._bossMusicPlaylist || this._bossMusicPlaylist.sounds.length == 0))
         {
            _log.info("Ni musique de combat, ni musique de boss ???");
         }
      }
      
      public function selectValidSounds() : void
      {
         var rnd:int = 0;
         var playlistSound:PlaylistSound = null;
         var count:int = 0;
         if(this._fightMusicPlaylist && this._fightMusicPlaylist.sounds.length > 0)
         {
            count = this._fightMusicPlaylist.sounds.length;
            rnd = int(Math.random() * count);
            for each(playlistSound in this._fightMusicPlaylist.sounds)
            {
               if(rnd == 0)
               {
                  this._fightMusic = playlistSound;
                  break;
               }
               rnd--;
            }
         }
         if(this._bossMusicPlaylist && this._bossMusicPlaylist.sounds.length > 0)
         {
            count = this._bossMusicPlaylist.sounds.length;
            rnd = int(Math.random() * count);
            for each(playlistSound in this._bossMusicPlaylist.sounds)
            {
               if(rnd == 0)
               {
                  this._bossMusic = playlistSound;
                  break;
               }
               rnd--;
            }
         }
      }
      
      private function init() : void
      {
         this._fightMusicsId = TubulSoundConfiguration.fightMusicIds;
         this._fightMusicBalanceManager = new BalanceManager(this._fightMusicsId);
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
