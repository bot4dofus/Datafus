package com.ankamagames.dofus.kernel.sound.type
{
   import com.ankamagames.dofus.kernel.sound.manager.RegConnectionManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.Tubul;
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import com.ankamagames.tubul.interfaces.IEffect;
   import com.ankamagames.tubul.interfaces.ILocalizedSound;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.types.SoundSilence;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SoundDofus implements ISound, ILocalizedSound
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundDofus));
      
      private static var _currentId:int = -1;
      
      private static var _cache:Dictionary = new Dictionary();
       
      
      protected var _busId:int;
      
      protected var _id:int;
      
      protected var _soundId:String;
      
      protected var _uri:Uri;
      
      protected var _volume:Number;
      
      protected var _fadeVolume:Number;
      
      protected var _busVolume:Number;
      
      protected var _loop:Boolean = false;
      
      protected var _noCutSilence:Boolean;
      
      protected var _effects:Vector.<IEffect>;
      
      protected var _silence:SoundSilence;
      
      private var _pan:Number;
      
      private var _position:Point;
      
      private var _range:Number;
      
      private var _saturationRange:Number;
      
      private var _observerPosition:Point;
      
      private var _volumeMax:Number;
      
      public function SoundDofus(pSoundID:String, useCache:Boolean = false)
      {
         super();
         this.init();
         if(_cache[pSoundID] && useCache)
         {
            this._id = _cache[pSoundID];
         }
         else
         {
            this._id = _currentId--;
            if(useCache)
            {
               _cache[pSoundID] = this._id;
            }
         }
         this._soundId = pSoundID;
         RegConnectionManager.getInstance().send(ProtocolEnum.ADD_SOUND,this._id,this._soundId,true);
      }
      
      public function get duration() : Number
      {
         _log.warn("Cette propriété (\'duration\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return 0;
      }
      
      public function get stereo() : Boolean
      {
         _log.warn("Cette propriété (\'stereo\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return false;
      }
      
      public function get totalLoops() : int
      {
         _log.warn("Cette propriété (\'totalLoops\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return -1;
      }
      
      public function get currentLoop() : uint
      {
         _log.warn("Cette propriété (\'currentLoop\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return 0;
      }
      
      public function get pan() : Number
      {
         _log.warn("Cette propriété (\'pan\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return this._pan;
      }
      
      public function set pan(pan:Number) : void
      {
         if(pan < -1)
         {
            this._pan = -1;
         }
         if(pan > 1)
         {
            this._pan = 1;
         }
         this._pan = pan;
      }
      
      public function get range() : Number
      {
         return this._range;
      }
      
      public function set range(range:Number) : void
      {
         if(range < this._saturationRange)
         {
            range = this._saturationRange;
         }
         this._range = range;
      }
      
      public function get saturationRange() : Number
      {
         return this._saturationRange;
      }
      
      public function set saturationRange(saturationRange:Number) : void
      {
         if(saturationRange >= this._range)
         {
            saturationRange = this._range;
         }
         this._saturationRange = saturationRange;
      }
      
      public function get position() : Point
      {
         return this._position;
      }
      
      public function set position(position:Point) : void
      {
         this._position = position;
      }
      
      public function get volumeMax() : Number
      {
         return this._volumeMax;
      }
      
      public function set volumeMax(pVolumeMax:Number) : void
      {
         if(pVolumeMax > 1)
         {
            pVolumeMax = 1;
         }
         if(pVolumeMax < 0)
         {
            pVolumeMax = 0;
         }
         this._volumeMax = pVolumeMax;
      }
      
      public function get effects() : Vector.<IEffect>
      {
         return this._effects;
      }
      
      public function get volume() : Number
      {
         return this._volume;
      }
      
      public function set volume(pVolume:Number) : void
      {
         if(pVolume > 1)
         {
            pVolume = 1;
         }
         if(pVolume < 0)
         {
            pVolume = 0;
         }
         this._volume = pVolume;
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_VOLUME,this._id,pVolume);
      }
      
      public function get currentFadeVolume() : Number
      {
         return this._fadeVolume;
      }
      
      public function set currentFadeVolume(pFadeVolume:Number) : void
      {
         if(pFadeVolume > 1)
         {
            pFadeVolume = 1;
         }
         if(pFadeVolume < 0)
         {
            pFadeVolume = 0;
         }
         this._fadeVolume = pFadeVolume;
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_FADE_VOLUME,this._id,pFadeVolume);
      }
      
      public function get effectiveVolume() : Number
      {
         _log.warn("Cette propriété (\'effectiveVolume\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return 0;
      }
      
      public function get uri() : Uri
      {
         return this._uri;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         _log.warn("Cette propriété (\'eventDispatcher\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return null;
      }
      
      public function get sound() : Sound
      {
         _log.warn("Cette propriété (\'sound\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return null;
      }
      
      public function set sound(sound:*) : void
      {
      }
      
      public function get busId() : int
      {
         return this._busId;
      }
      
      public function set busId(pBus:int) : void
      {
      }
      
      public function get bus() : IAudioBus
      {
         _log.warn("Cette propriété (\'bus\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return Tubul.getInstance().getBus(this.busId);
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get noCutSilence() : Boolean
      {
         _log.warn("Cette propriété (\'noCutSilence\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return this._noCutSilence;
      }
      
      public function set noCutSilence(pNoCutSilence:Boolean) : void
      {
         this._noCutSilence = pNoCutSilence;
         var o:Object = new Object();
         o.noCutSilence = pNoCutSilence;
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_SOUND_PROPERTIES,this._id,o);
      }
      
      public function get isPlaying() : Boolean
      {
         _log.warn("Cette propriété (\'isPlaying\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return true;
      }
      
      public function get silence() : SoundSilence
      {
         return this._silence;
      }
      
      public function set silence(pSilence:SoundSilence) : void
      {
         this._silence = pSilence;
      }
      
      public function setCurrentLoop(pLoop:uint) : void
      {
      }
      
      public function addEffect(pEffect:IEffect) : void
      {
      }
      
      public function removeEffect(pEffect:IEffect) : void
      {
      }
      
      public function applyDynamicMix(pFadeIn:VolumeFadeEffect, pWaitingTime:uint, pFadeOut:VolumeFadeEffect) : void
      {
      }
      
      public function play(pLoop:Boolean = false, pLoops:int = 0, pFadeIn:VolumeFadeEffect = null, pFadeOut:VolumeFadeEffect = null) : void
      {
         var fadeInBeg:Number = -1;
         var fadeInEnd:Number = -1;
         var fadeInTime:Number = -1;
         var fadeOutBeg:Number = -1;
         var fadeOutEnd:Number = -1;
         var fadeOutTime:Number = -1;
         if(pFadeIn)
         {
            fadeInBeg = pFadeIn.beginningValue;
            fadeInEnd = pFadeIn.endingValue;
            fadeInTime = pFadeIn.timeFade;
         }
         if(pFadeOut)
         {
            fadeOutBeg = pFadeOut.beginningValue;
            fadeOutEnd = pFadeOut.endingValue;
            fadeOutTime = pFadeOut.timeFade;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.PLAY_SOUND,this._id,this._soundId,pLoop,pLoops,fadeInBeg,fadeInEnd,fadeInTime,fadeOutBeg,fadeOutEnd,fadeOutTime);
      }
      
      public function stop(pFadeOut:VolumeFadeEffect = null, mustStopCompletly:Boolean = false) : void
      {
         var fadeOutB:Number = -1;
         var fadeOutE:Number = -1;
         var fadeOutT:Number = -1;
         if(pFadeOut != null)
         {
            fadeOutB = pFadeOut.beginningValue;
            fadeOutE = pFadeOut.endingValue;
            fadeOutT = pFadeOut.timeFade;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.STOP_SOUND,this._id,fadeOutB,fadeOutE,fadeOutT,mustStopCompletly);
      }
      
      public function loadSound(cache:ICache) : void
      {
      }
      
      public function setLoops(pLoops:int) : void
      {
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_LOOPS,this._id,pLoops);
      }
      
      public function clone() : ISound
      {
         _log.warn("Can\'t clone a SoundDofus !");
         return null;
      }
      
      private function init() : void
      {
         this._fadeVolume = 1;
         this._busVolume = 1;
         this._volume = 1;
      }
   }
}
