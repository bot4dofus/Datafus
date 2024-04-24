package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.WorldEntitySprite;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.playlists.Playlist;
   import com.ankamagames.dofus.datacenter.sounds.SoundAnimation;
   import com.ankamagames.dofus.datacenter.sounds.SoundBones;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.TubulSoundConfiguration;
   import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
   import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.enums.PlaylistTypeEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.jerakine.types.SoundEventParamWrapper;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.parser.FLAEventLabelParser;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.tubul.enum.EnumSoundType;
   import com.ankamagames.tubul.events.AudioBusEvent;
   import com.ankamagames.tubul.events.SoundCompleteEvent;
   import com.ankamagames.tubul.factory.SoundFactory;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.types.PlayListPlayer;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class RegSoundManager extends EventDispatcher implements ISoundManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RegSoundManager));
      
      private static var _self:ISoundManager;
       
      
      private var _previousSubareaId:int;
      
      private var _criterionSubarea:int;
      
      private var _entitySounds:Array;
      
      private var _reverseEntitySounds:Dictionary;
      
      private var _entityDictionary:Dictionary;
      
      private var _adminSounds:Dictionary;
      
      private var _ambientManager:AmbientSoundsManager;
      
      private var _localizedSoundsManager:LocalizedSoundsManager;
      
      private var _fightMusicManager:FightMusicManager;
      
      private var _forceSounds:Boolean = true;
      
      private var _soundDirectoryExist:Boolean = true;
      
      private var _inFight:Boolean;
      
      private var _adminPlaylist:PlayListPlayer;
      
      private var _stopableSounds:Array;
      
      public function RegSoundManager()
      {
         super();
         this.init();
      }
      
      public function set soundDirectoryExist(pExists:Boolean) : void
      {
         this._soundDirectoryExist = pExists;
      }
      
      public function get soundDirectoryExist() : Boolean
      {
         return this._soundDirectoryExist;
      }
      
      public function get soundIsActivate() : Boolean
      {
         return this.checkIfAvailable();
      }
      
      public function get entitySounds() : Array
      {
         return this._entitySounds;
      }
      
      public function get reverseEntitySounds() : Dictionary
      {
         return this._reverseEntitySounds;
      }
      
      public function set forceSoundsDebugMode(pForce:Boolean) : void
      {
         this._forceSounds = pForce;
      }
      
      public function playMainClientSounds() : void
      {
         if(this._localizedSoundsManager != null && this._localizedSoundsManager.isInitialized)
         {
            this._localizedSoundsManager.playLocalizedSounds();
         }
         if(this._ambientManager != null && Kernel.getWorker().getFrame(FightContextFrame) == null)
         {
            this._ambientManager.playMusicAndAmbient();
         }
         else if(this._fightMusicManager != null)
         {
            this._fightMusicManager.startFightPlaylist();
         }
         this.playIntroMusic();
         SoundManager.getInstance().setSoundOptions();
      }
      
      public function stopMainClientSounds() : void
      {
         if(this._localizedSoundsManager != null && this._localizedSoundsManager.isInitialized)
         {
            this._localizedSoundsManager.stopLocalizedSounds();
         }
         if(this._ambientManager != null)
         {
            this._ambientManager.stopMusicAndAmbient();
         }
         if(this._fightMusicManager != null && this._inFight)
         {
            this._fightMusicManager.stopFightMusic();
         }
         this.stopAllStopableSounds();
         this.stopIntroMusic(true);
      }
      
      public function activateSound() : void
      {
         this._forceSounds = true;
         this.playMainClientSounds();
         RegConnectionManager.getInstance().send(ProtocolEnum.DEACTIVATE_SOUNDS,false);
      }
      
      public function deactivateSound() : void
      {
         this.stopMainClientSounds();
         this._forceSounds = false;
         RegConnectionManager.getInstance().send(ProtocolEnum.DEACTIVATE_SOUNDS,true);
      }
      
      public function setSubArea(pMap:Map = null) : void
      {
         var musicPlaylist:Playlist = null;
         var ambiantPlaylist:Playlist = null;
         var combatPlaylist:Playlist = null;
         var bossFightPlaylist:Playlist = null;
         var plV:Vector.<int> = null;
         var plM:Vector.<int> = null;
         var mp:MapPosition = MapPosition.getMapPositionById(pMap.id);
         this.removeLocalizedSounds();
         this._localizedSoundsManager.setMap(pMap);
         if(this.soundIsActivate && RegConnectionManager.getInstance().isMain)
         {
            this._localizedSoundsManager.playLocalizedSounds();
         }
         this._previousSubareaId = pMap.subareaId;
         this._criterionSubarea = 1;
         var subArea:SubArea = SubArea.getSubAreaById(pMap.subareaId);
         if(subArea == null)
         {
            return;
         }
         if(mp.playlists && mp.playlists.length > 0)
         {
            for each(plM in mp.playlists)
            {
               if(plM[0] == PlaylistTypeEnum.ROLEPLAY_MUSIC)
               {
                  musicPlaylist = Playlist.getPlaylistById(plM[1]);
               }
               if(plM[0] == PlaylistTypeEnum.AMBIANCE_MUSIC)
               {
                  ambiantPlaylist = Playlist.getPlaylistById(plM[1]);
               }
               if(plM[0] == PlaylistTypeEnum.COMBAT_MUSIC)
               {
                  combatPlaylist = Playlist.getPlaylistById(plM[1]);
               }
               if(plM[0] == PlaylistTypeEnum.BOSS_MUSIC)
               {
                  bossFightPlaylist = Playlist.getPlaylistById(plM[1]);
               }
            }
         }
         for each(plV in subArea.playlists)
         {
            if(plV[0] == PlaylistTypeEnum.ROLEPLAY_MUSIC && !musicPlaylist)
            {
               musicPlaylist = Playlist.getPlaylistById(plV[1]);
            }
            if(plV[0] == PlaylistTypeEnum.AMBIANCE_MUSIC && !ambiantPlaylist)
            {
               ambiantPlaylist = Playlist.getPlaylistById(plV[1]);
            }
            if(plV[0] == PlaylistTypeEnum.COMBAT_MUSIC && !combatPlaylist)
            {
               combatPlaylist = Playlist.getPlaylistById(plV[1]);
            }
            if(plV[0] == PlaylistTypeEnum.BOSS_MUSIC && !bossFightPlaylist)
            {
               bossFightPlaylist = Playlist.getPlaylistById(plV[1]);
            }
         }
         _log.info("Subarea Id : " + subArea.id + " / Map id : " + pMap.id);
         this._ambientManager.setAmbientSounds(musicPlaylist,ambiantPlaylist);
         this._ambientManager.selectValidSounds();
         this._ambientManager.playMusicAndAmbient();
         this._fightMusicManager.setFightSounds(combatPlaylist,bossFightPlaylist);
      }
      
      public function setCustomFightPlaylist(id:int) : void
      {
         this._fightMusicManager.setCustomFightSounds(Playlist.getPlaylistById(id));
      }
      
      public function playUISound(pSoundId:String, pLoop:Boolean = false) : void
      {
         if(!this.checkIfAvailable())
         {
            return;
         }
         var newSound:SoundDofus = new SoundDofus(pSoundId);
         newSound.play(pLoop);
      }
      
      public function playSound(pSound:ISound, pLoop:Boolean = false, pLoops:int = -1) : ISound
      {
         var prop:* = null;
         if(!this.checkIfAvailable())
         {
            return null;
         }
         var soundID:String = pSound.uri.fileName.split(".mp3")[0];
         var newSound:SoundDofus = new SoundDofus(soundID,true);
         for(prop in pSound)
         {
            if(newSound.hasOwnProperty(prop))
            {
               newSound[prop] = pSound;
            }
         }
         newSound.play(pLoop,pLoops);
         return newSound;
      }
      
      public function upFightMusicVolume() : void
      {
         this._inFight = true;
         this.fadeBusVolume(TubulSoundConfiguration.BUS_FIGHT_MUSIC_ID,1,0);
      }
      
      public function playFightMusic(hasBoss:Boolean = false, playCustom:Boolean = false) : void
      {
         this._fightMusicManager.prepareFightMusic();
         this._fightMusicManager.selectValidSounds();
         this._fightMusicManager.hasBoss = hasBoss;
         this._fightMusicManager.playCustom = playCustom;
         this._fightMusicManager.startFightPlaylist();
      }
      
      public function stopFightMusic() : void
      {
         this._inFight = false;
         this._fightMusicManager.stopFightMusic();
      }
      
      public function handleFLAEvent(pAnimationName:String, pType:String, pParams:String, pSprite:Object = null) : void
      {
         var actorInfo:GameContextActorInformations = null;
         var fightFrame:FightEntitiesFrame = null;
         var sprite:TiphonSprite = null;
         var parent:Object = null;
         var tempEntity:AnimatedCharacter = null;
         if(!(this.soundIsActivate && RegConnectionManager.getInstance().isMain))
         {
            return;
         }
         if(pSprite is TiphonSprite && TiphonSprite(pSprite).parentSprite && TiphonSprite(pSprite).parentSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,0))
         {
            return;
         }
         var rpEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var followed:AnimatedCharacter = pSprite is AnimatedCharacter ? (pSprite as AnimatedCharacter).followed : null;
         if(rpEntitiesFrame && followed && rpEntitiesFrame.getEntityInfos(followed.id) is GameRolePlayGroupMonsterInformations)
         {
            return;
         }
         var posX:Number = 0;
         var posY:Number = 0;
         var entityId:Number = -1;
         if(pSprite.hasOwnProperty("absoluteBounds"))
         {
            if(rpEntitiesFrame)
            {
               actorInfo = rpEntitiesFrame.getEntityInfos(pSprite.id);
            }
            else
            {
               fightFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
               if(fightFrame)
               {
                  actorInfo = fightFrame.getEntityInfos(pSprite.id);
               }
            }
            if(actorInfo)
            {
               posX = InteractiveCellManager.getInstance().getCell(actorInfo.disposition.cellId).x;
               posY = InteractiveCellManager.getInstance().getCell(actorInfo.disposition.cellId).y;
            }
            else
            {
               posX = pSprite.absoluteBounds.x;
               posY = pSprite.absoluteBounds.y;
            }
            entityId = pSprite.id;
            if(entityId != PlayedCharacterManager.getInstance().id && entityId > 0 && Kernel.getWorker().getFrame(FightBattleFrame) == null)
            {
               return;
            }
         }
         else if(pSprite is WorldEntitySprite)
         {
            posX = InteractiveCellManager.getInstance().getCell((pSprite as WorldEntitySprite).cellId).x;
            posY = InteractiveCellManager.getInstance().getCell((pSprite as WorldEntitySprite).cellId).y;
            entityId = (pSprite as WorldEntitySprite).id;
         }
         else
         {
            if(!(pSprite is TiphonSprite))
            {
               return;
            }
            sprite = pSprite as TiphonSprite;
            if(sprite.parentSprite is TiphonSprite)
            {
               if(sprite.parentSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) != null)
               {
                  parent = sprite.parentSprite;
                  if(parent.hasOwnProperty("absoluteBounds"))
                  {
                     posX = parent.absoluteBounds.x;
                     posY = parent.absoluteBounds.y;
                     entityId = parent.id;
                     if(entityId != PlayedCharacterManager.getInstance().id && entityId > 0 && Kernel.getWorker().getFrame(FightBattleFrame) == null)
                     {
                        return;
                     }
                  }
               }
            }
            else
            {
               if(!(sprite.parent is EntityDisplayer))
               {
                  return;
               }
               if(rpEntitiesFrame)
               {
                  actorInfo = rpEntitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id);
               }
               else
               {
                  fightFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                  if(fightFrame)
                  {
                     actorInfo = fightFrame.getEntityInfos(PlayedCharacterManager.getInstance().id);
                  }
               }
               if(actorInfo)
               {
                  posX = InteractiveCellManager.getInstance().getCell(actorInfo.disposition.cellId).x;
                  posY = InteractiveCellManager.getInstance().getCell(actorInfo.disposition.cellId).y;
               }
               if(sprite.look.getBone() == 1)
               {
                  entityId = PlayedCharacterManager.getInstance().id;
               }
               else
               {
                  tempEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),sprite.look);
                  tempEntity.allowMovementThrough = true;
                  EntitiesManager.getInstance().addAnimatedEntity(tempEntity.id,tempEntity);
                  (sprite.parent as EntityDisplayer).animatedCharacter = tempEntity;
                  entityId = tempEntity.id;
               }
            }
         }
         switch(pType)
         {
            case "Sound":
               if(sprite && sprite.parent && sprite.parent is EntityDisplayer)
               {
                  pParams += ";isLocalized=0";
               }
               pParams += "*";
               break;
            case "DataSound":
               pParams = this.buildSoundLabel(entityId,pAnimationName,pParams) + "*";
         }
         var skin:int = -1;
         if(pSprite.look.skins)
         {
            skin = TiphonEntityLook(pSprite.look).firstSkin;
         }
         if(pParams && pParams != "null" && pParams != "null*")
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.FLA_EVENT,pParams,entityId,posX,posY,skin);
         }
      }
      
      public function applyDynamicMix(pFadeIn:VolumeFadeEffect, pWaitingTime:uint, pFadeOut:VolumeFadeEffect) : void
      {
         RegConnectionManager.getInstance().send(ProtocolEnum.DYNAMIC_MIX,pFadeIn.endingValue,pFadeIn.timeFade,pWaitingTime,pFadeOut.timeFade);
      }
      
      public function retriveRollOffPresets() : void
      {
      }
      
      public function setSoundSourcePosition(pEntityId:Number, pPosition:Point) : void
      {
         if(!this.checkIfAvailable())
         {
            return;
         }
         if(pEntityId == PlayedCharacterManager.getInstance().id)
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_PLAYER_POSITION,pPosition.x,pPosition.y);
         }
         else
         {
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_SOUND_SOURCE_POSITION,this._entitySounds[pEntityId],pPosition.x,pPosition.y);
         }
      }
      
      public function addSoundEntity(pISound:ISound, pEntityId:Number) : void
      {
         if(!this.checkIfAvailable())
         {
            return;
         }
         if(this._entitySounds[pEntityId] == null)
         {
            this._entitySounds[pEntityId] = new Vector.<ISound>();
         }
         this._entityDictionary[DofusEntities.getEntity(pEntityId)] = this._entitySounds[pEntityId];
         this._entitySounds[pEntityId].push(pISound);
         this._reverseEntitySounds[pISound] = pEntityId;
      }
      
      public function removeSoundEntity(pISound:ISound) : void
      {
         var isound:ISound = null;
         var entityId:Number = this._reverseEntitySounds[pISound];
         if(!this._entitySounds[entityId])
         {
            return;
         }
         for each(isound in this._entitySounds[entityId])
         {
            if(isound == pISound)
            {
               isound.stop();
               this._entitySounds[entityId].splice(this._entitySounds[entityId].indexOf(isound),1);
               delete this._reverseEntitySounds[pISound];
               if(this._entitySounds[entityId].length == 0)
               {
                  this._entitySounds[entityId] = null;
               }
               return;
            }
         }
      }
      
      public function removeEntitySound(pEntityId:IEntity) : void
      {
         var isound:ISound = null;
         var fadeOut:VolumeFadeEffect = null;
         if(this._entityDictionary[pEntityId] == null)
         {
            return;
         }
         for each(isound in this._entityDictionary[pEntityId])
         {
            fadeOut = new VolumeFadeEffect(-1,0,0.1);
            isound.stop(fadeOut);
         }
         delete this._entityDictionary[pEntityId];
      }
      
      public function playIntroMusic(pFirstHarmonic:Boolean = true) : void
      {
         if(!(this.soundIsActivate && RegConnectionManager.getInstance().isMain))
         {
            return;
         }
         var sysApi:SystemApi = new SystemApi();
         if(sysApi.isInGame())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.PLAY_INTRO);
      }
      
      public function switchIntroMusic(pFirstHarmonic:Boolean) : void
      {
         if(!(this.soundIsActivate && RegConnectionManager.getInstance().isMain))
         {
            return;
         }
         var sysApi:SystemApi = new SystemApi();
         if(sysApi.isInGame())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.SWITCH_INTRO,pFirstHarmonic);
      }
      
      public function stopIntroMusic(pImmediatly:Boolean = false) : void
      {
         if(!this.checkIfAvailable())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.STOP_INTRO,pImmediatly);
      }
      
      public function removeAllSounds(pFade:Number = 0, pFadeTime:Number = 0) : void
      {
         RegConnectionManager.getInstance().send(ProtocolEnum.REMOVE_ALL_SOUNDS);
      }
      
      public function fadeBusVolume(pBusID:int, pFade:Number, pFadeTime:Number) : void
      {
         RegConnectionManager.getInstance().send(ProtocolEnum.FADE_BUS,pBusID,pFade,pFadeTime);
      }
      
      public function setBusVolume(pBusID:int, pNewVolume:Number) : void
      {
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_BUS_VOLUME,pBusID,pNewVolume);
      }
      
      public function reset() : void
      {
         this.stopMainClientSounds();
         this.removeAllSounds();
      }
      
      private function init() : void
      {
         this._previousSubareaId = -1;
         this._localizedSoundsManager = new LocalizedSoundsManager();
         this._ambientManager = new AmbientSoundsManager();
         this._fightMusicManager = new FightMusicManager();
         this._entitySounds = new Array();
         this._reverseEntitySounds = new Dictionary();
         this._adminSounds = new Dictionary();
         this._stopableSounds = new Array();
         this._entityDictionary = new Dictionary();
      }
      
      private function removeLocalizedSounds() : void
      {
         this._entitySounds = new Array();
         this._reverseEntitySounds = new Dictionary();
         RegConnectionManager.getInstance().send(ProtocolEnum.REMOVE_LOCALIZED_SOUNDS);
      }
      
      private function checkIfAvailable() : Boolean
      {
         return this._forceSounds && this._soundDirectoryExist;
      }
      
      public function playAdminSound(pSoundId:String, pVolume:Number, pLoop:Boolean, pType:uint) : void
      {
         var isound:ISound = new SoundDofus(pSoundId);
         RegConnectionManager.getInstance().send(ProtocolEnum.TEST_MUSIC,isound.id);
      }
      
      public function stopAdminSound(pType:uint) : void
      {
         var isound:ISound = this._adminSounds[pType] as ISound;
         isound.stop();
      }
      
      public function addSoundInPlaylist(pSoundId:String, pVolume:Number, pSilenceMin:uint, pSilenceMax:uint) : Boolean
      {
         if(this._adminPlaylist == null)
         {
            this._adminPlaylist = new PlayListPlayer(true);
         }
         var busId:uint = SoundUtil.getBusIdBySoundId(pSoundId);
         var soundPath:String = SoundUtil.getConfigEntryByBusId(busId);
         var soundUri:Uri = new Uri(soundPath + pSoundId + ".mp3");
         var isound:ISound = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,soundUri);
         isound.busId = busId;
         if(this._adminPlaylist.addSound(isound) > 0)
         {
            return true;
         }
         return false;
      }
      
      public function removeSoundInPLaylist(pSoundId:String) : Boolean
      {
         if(this._adminPlaylist == null)
         {
            return false;
         }
         this._adminPlaylist.removeSoundBySoundId(pSoundId,true);
         return true;
      }
      
      public function playPlaylist() : void
      {
         if(this.checkIfAvailable())
         {
            return;
         }
         if(this._adminPlaylist == null)
         {
            return;
         }
         this._adminPlaylist.play();
      }
      
      public function stopPlaylist() : void
      {
         if(this.checkIfAvailable())
         {
            return;
         }
         if(this._adminPlaylist == null)
         {
            return;
         }
         this._adminPlaylist.stop();
      }
      
      public function resetPlaylist() : void
      {
         if(this._adminPlaylist)
         {
            this._adminPlaylist.reset();
         }
      }
      
      private function onRemoveSoundInTubul(pEvent:AudioBusEvent) : void
      {
         this.removeSoundEntity(pEvent.sound);
      }
      
      private function onSoundAdminComplete(pEvent:SoundCompleteEvent) : void
      {
         pEvent.sound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundAdminComplete);
         var soundId:String = pEvent.sound.uri.fileName.split(".mp3")[0];
         this._adminSounds[soundId] = null;
         delete this._adminSounds[soundId];
      }
      
      public function buildSoundLabel(entityId:Number, animationType:String, params:String) : String
      {
         var r:RegExp = null;
         if(params != null)
         {
            r = /^\s*(.*?)\s*$/g;
            params = params.replace(r,"$1");
            if(params.length == 0)
            {
               params = null;
            }
         }
         var entity:TiphonSprite = DofusEntities.getEntity(entityId) as TiphonSprite;
         if(!entity || !entity.look)
         {
            return null;
         }
         var bonesId:int = entity.look.getBone();
         var sb:SoundBones = SoundBones.getSoundBonesById(bonesId);
         var soundEvents:Vector.<SoundEventParamWrapper> = new Vector.<SoundEventParamWrapper>();
         if(sb != null)
         {
            soundEvents = this.createSoundEvent(sb,animationType,params);
         }
         if(soundEvents.length <= 0)
         {
            bonesId = (TiphonUtility.getEntityWithoutMount(entity) as TiphonSprite).look.getBone();
            sb = SoundBones.getSoundBonesById(bonesId);
            if(sb != null)
            {
               soundEvents = this.createSoundEvent(sb,animationType,params);
            }
         }
         if(soundEvents.length > 0)
         {
            return FLAEventLabelParser.buildSoundLabel(soundEvents);
         }
         return null;
      }
      
      public function playStopableSound(pSoundFileName:String) : void
      {
         var busId:uint = 0;
         var isound:ISound = null;
         if(this._forceSounds)
         {
            busId = SoundUtil.getBusIdBySoundId(pSoundFileName);
            isound = new SoundDofus(pSoundFileName);
            isound.busId = busId;
            isound.volume = 100 / 100;
            this._stopableSounds[pSoundFileName] = [isound,pSoundFileName];
            isound.play(false,1);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.StopableSoundEnded,pSoundFileName);
         }
      }
      
      public function stopStopableSound(pSoundId:String) : void
      {
         if(!this._stopableSounds[pSoundId])
         {
            return;
         }
         var isound:ISound = this._stopableSounds[pSoundId][0] as ISound;
         var timeFade:Number = 0;
         var fade:VolumeFadeEffect = new VolumeFadeEffect(-1,0,timeFade);
         isound.stop(fade);
      }
      
      public function stopAllStopableSounds() : void
      {
         var soundArray:Array = null;
         for each(soundArray in this._stopableSounds)
         {
            soundArray[0].stop(null,true);
            if(soundArray.length > 0)
            {
               KernelEventsManager.getInstance().processCallback(HookList.StopableSoundEnded,soundArray[1]);
            }
         }
      }
      
      public function endOfSound(pSoundID:int) : void
      {
         var dicArray:Array = null;
         var sound:ISound = null;
         for each(dicArray in this._stopableSounds)
         {
            sound = dicArray[0];
            if(sound.id == pSoundID)
            {
               KernelEventsManager.getInstance().processCallback(HookList.StopableSoundEnded,dicArray[1]);
               delete global[this._stopableSounds.indexOf(sound)];
               break;
            }
         }
      }
      
      private function createSoundEvent(sb:SoundBones, animationType:String, params:String) : Vector.<SoundEventParamWrapper>
      {
         var sa:SoundAnimation = null;
         var soundEvents:Vector.<SoundEventParamWrapper> = new Vector.<SoundEventParamWrapper>();
         for each(sa in sb.getSoundAnimationByLabel(animationType,params))
         {
            if(!sa.filename)
            {
               throw new Error("SoundEventParamWrapper.id will be null. soundBones Keys : " + sb.keys);
            }
            soundEvents.push(new SoundEventParamWrapper(sa.filename,sa.volume,sa.rolloff,sa.automationDuration,sa.automationVolume,sa.automationFadeIn,sa.automationFadeOut,sa.noCutSilence));
         }
         return soundEvents;
      }
      
      public function removeRegSentry() : void
      {
         if(!this.checkIfAvailable())
         {
            return;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.QUIT,true);
      }
   }
}
