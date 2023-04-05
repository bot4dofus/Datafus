package com.ankamagames.tubul.types.bus
{
   import com.TubulConstants;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.resources.CacheableResource;
   import com.ankamagames.tubul.Tubul;
   import com.ankamagames.tubul.enum.EventListenerPriority;
   import com.ankamagames.tubul.events.AudioBusEvent;
   import com.ankamagames.tubul.events.AudioBusVolumeEvent;
   import com.ankamagames.tubul.events.FadeEvent;
   import com.ankamagames.tubul.events.LoadingSound.LoadingSoundEvent;
   import com.ankamagames.tubul.events.SoundCompleteEvent;
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import com.ankamagames.tubul.interfaces.IEffect;
   import com.ankamagames.tubul.interfaces.ILocalizedSoundListener;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   
   public class AudioBus implements IAudioBus
   {
      
      protected static var _totalPlayingSounds:int = 0;
      
      protected static var id_sound:uint = 0;
       
      
      private const _log:Logger = Log.getLogger(getQualifiedClassName(AudioBus));
      
      protected var _id:uint;
      
      protected var _name:String;
      
      protected var _soundVector:Vector.<ISound>;
      
      protected var _volume:Number;
      
      protected var _volumeMax:Number;
      
      protected var _fadeVolume:Number;
      
      protected var _cache:ICache;
      
      protected var _eventDispatcher:EventDispatcher;
      
      protected var _numberSoundsLimitation:int = -1;
      
      protected var _effects:Vector.<IEffect>;
      
      public function AudioBus(id:int, name:String)
      {
         super();
         this.init(id,name);
      }
      
      public function get soundList() : Vector.<ISound>
      {
         return this._soundVector;
      }
      
      public function set volumeMax(pVolMax:Number) : void
      {
         if(pVolMax > 1)
         {
            pVolMax = 1;
         }
         if(pVolMax < 0)
         {
            pVolMax = 0;
         }
         this._volumeMax = pVolMax;
      }
      
      public function get volumeMax() : Number
      {
         return this._volumeMax;
      }
      
      public function get numberSoundsLimitation() : int
      {
         return this._numberSoundsLimitation;
      }
      
      public function set numberSoundsLimitation(pLimit:int) : void
      {
         this._numberSoundsLimitation = pLimit;
      }
      
      public function get effects() : Vector.<IEffect>
      {
         return this._effects;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get id() : uint
      {
         return this._id;
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
         if(isNaN(this.volumeMax))
         {
            this._volumeMax = this._volume;
         }
         this._log.warn("Bus " + "(" + this.id + ") vol. réel : " + this.effectiveVolume + " (vol. max : " + this._volumeMax + " / % vol : " + this._volume + ") [" + this.name + "]");
         this.informSoundsNewVolume();
      }
      
      public function get volume() : Number
      {
         return this._volume;
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
         this.informSoundsNewVolume();
      }
      
      public function get effectiveVolume() : Number
      {
         return Math.round(this._volume * this._volumeMax * this._fadeVolume * 1000) / 1000;
      }
      
      public function clear(pFade:VolumeFadeEffect = null) : void
      {
         var isound:ISound = null;
         for each(isound in this._soundVector)
         {
            this.removeSound(isound,pFade);
         }
      }
      
      public function playISound(newSound:ISound, pLoop:Boolean = false, pLoops:int = -1) : void
      {
         var isound:ISound = null;
         var existingSound:Boolean = false;
         for each(isound in this._soundVector)
         {
            if(isound === newSound)
            {
               existingSound = true;
               break;
            }
         }
         if(!existingSound)
         {
            this.addISound(newSound);
         }
         if(!newSound.isPlaying)
         {
            newSound.play(pLoop,pLoops);
         }
      }
      
      public function addISound(pISound:ISound) : void
      {
         var sound3:ISound = null;
         var sound2:ISound = null;
         var effect:IEffect = null;
         var bus:IAudioBus = null;
         var freedSpace:Boolean = false;
         var freedSpace2:Boolean = false;
         var cr:CacheableResource = null;
         var resource:* = undefined;
         pISound.eventDispatcher.addEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundComplete,false,EventListenerPriority.MINIMAL,true);
         var busState:String = "";
         for each(sound3 in this.soundList)
         {
            busState += " " + sound3.id + ";" + sound3.uri;
         }
         if(Tubul.getInstance().totalPlayingSounds >= TubulConstants.MAXIMUM_SOUNDS_PLAYING_SAME_TIME)
         {
            this._log.warn("We have reached the maximum number of sounds playing simultaneously");
            this._log.warn("");
            for each(bus in Tubul.getInstance().audioBusList)
            {
               this._log.warn("Registered sounds in bus " + bus.name + " :");
               freedSpace = this.cleanBus(bus.soundList);
            }
            if(!freedSpace)
            {
               return;
            }
         }
         if(this._numberSoundsLimitation >= 0 && this.soundList.length >= this._numberSoundsLimitation)
         {
            this._log.warn("We have reached the maximum number of sounds for this bus (" + this._id + " / " + this._name + ")");
            this._log.warn("Registered sounds in bus " + this._name + " :");
            freedSpace2 = this.cleanBus(this.soundList);
            if(!freedSpace2)
            {
               return;
            }
         }
         this._log.warn("Registered sounds in bus " + this._name + " :");
         for each(sound2 in this.soundList)
         {
            this._log.warn("- " + sound2.uri);
         }
         if(this.contains(pISound))
         {
            return;
         }
         pISound.busId = this.id;
         for each(effect in this._effects)
         {
            pISound.addEffect(effect);
         }
         this._soundVector.push(pISound);
         if(this._cache.contains(TubulConstants.PREFIXE_LOADER + pISound.uri.toSum()))
         {
            cr = this._cache.peek(TubulConstants.PREFIXE_LOADER + pISound.uri.toSum());
            resource = cr.resource;
            pISound.sound = resource;
         }
         else
         {
            pISound.loadSound(this._cache);
            pISound.eventDispatcher.addEventListener(LoadingSoundEvent.LOADING_FAILED,this.onLoadFail);
         }
      }
      
      private function cleanBus(sList:Vector.<ISound>) : Boolean
      {
         var sound:ISound = null;
         var freedSpace:Boolean = false;
         for each(sound in sList)
         {
            freedSpace = false;
            if(!sound.isPlaying)
            {
               this.removeSound(sound);
               freedSpace = true;
            }
            this._log.warn("- " + sound.uri);
         }
         return freedSpace;
      }
      
      public function addEffect(pEffect:IEffect) : void
      {
         var effect:IEffect = null;
         var isound:ISound = null;
         for each(effect in this._effects)
         {
            if(effect.name == pEffect.name)
            {
               return;
            }
         }
         this._effects.push(pEffect);
         for each(isound in this._soundVector)
         {
            isound.addEffect(pEffect);
         }
      }
      
      public function removeEffect(pEffect:IEffect) : void
      {
         var effect:IEffect = null;
         var isound:ISound = null;
         var compt:uint = 0;
         for each(effect in this._effects)
         {
            if(effect == pEffect)
            {
               this._effects.splice(compt,1);
            }
            else
            {
               compt++;
            }
         }
         for each(isound in this._soundVector)
         {
            isound.removeEffect(pEffect);
         }
      }
      
      public function play() : void
      {
         var isound:ISound = null;
         for each(isound in this._soundVector)
         {
            isound.play();
         }
      }
      
      public function stop() : void
      {
         var isound:ISound = null;
         for each(isound in this._soundVector)
         {
            isound.stop();
         }
      }
      
      public function applyDynamicMix(pFadeIn:VolumeFadeEffect, pWaitingTime:uint, pFadeOut:VolumeFadeEffect) : void
      {
      }
      
      public function contains(pISound:ISound) : Boolean
      {
         var isound:ISound = null;
         for each(isound in this._soundVector)
         {
            if(isound.id == pISound.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function clearCache() : void
      {
         this._cache.destroy();
         this._cache = Cache.create(TubulConstants.MAXIMUM_BOUNDS_CACHE,new LruGarbageCollector(),getQualifiedClassName(this));
      }
      
      private function init(id:int, name:String) : void
      {
         this._eventDispatcher = new EventDispatcher();
         this._cache = Cache.create(TubulConstants.MAXIMUM_BOUNDS_CACHE,new LruGarbageCollector(),getQualifiedClassName(this));
         this._soundVector = new Vector.<ISound>();
         this._name = name;
         this._id = id;
         this._effects = new Vector.<IEffect>();
         this.volume = 1;
         this.currentFadeVolume = 1;
      }
      
      protected function removeSound(pISound:ISound, pFade:VolumeFadeEffect = null) : uint
      {
         var sound3:ISound = null;
         if(!this._soundVector)
         {
            return 0;
         }
         if(pISound == null)
         {
            this._log.warn("We tried to remove a null-sound.");
            return this._soundVector.length;
         }
         var indexOfSound:int = this._soundVector.indexOf(pISound);
         try
         {
            this._soundVector.splice(indexOfSound,1);
         }
         catch(e:Error)
         {
            _log.warn("We tried to remove a non existing sound. Allready removed ? (" + pISound.uri + ")");
         }
         var busState:String = "";
         for each(sound3 in this.soundList)
         {
            busState += " " + sound3.id + ";" + sound3.uri;
         }
         pISound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE,this.onSoundComplete);
         pISound.eventDispatcher.removeEventListener(LoadingSoundEvent.LOADING_FAILED,this.onLoadFail);
         if(pISound.isPlaying)
         {
            pISound.stop(pFade);
         }
         var pISound:ISound = null;
         return this._soundVector.length;
      }
      
      protected function getOlderSound() : ISound
      {
         var olderSound:ISound = null;
         var isound:ISound = null;
         for each(isound in this._soundVector)
         {
            if(olderSound == null)
            {
               olderSound = isound;
            }
            else if(isound.id < olderSound.id)
            {
               olderSound = isound;
            }
         }
         return olderSound;
      }
      
      protected function informSoundsNewVolume() : void
      {
         var abve:AudioBusVolumeEvent = new AudioBusVolumeEvent(AudioBusVolumeEvent.VOLUME_CHANGED);
         abve.newVolume = this.effectiveVolume;
         this._eventDispatcher.dispatchEvent(abve);
      }
      
      private function onLoadFail(event:LoadingSoundEvent) : void
      {
         this._log.warn("A sound failed to load : " + event.data.uri);
         this.removeSound(event.data);
      }
      
      protected function onSoundComplete(pEvent:SoundCompleteEvent) : void
      {
         var listener:ILocalizedSoundListener = null;
         this._eventDispatcher.dispatchEvent(pEvent);
         for each(listener in Tubul.getInstance().localizedSoundListeners)
         {
            listener.removeSoundEntity(pEvent.sound);
         }
         this.removeSound(pEvent.sound);
         pEvent = null;
      }
      
      protected function onFadeBeforeDeleteComplete(e:FadeEvent) : void
      {
         if(e.soundSource is ISound)
         {
            this.removeSound(e.soundSource as ISound);
         }
      }
      
      private function onRemoveSound(sound:ISound) : void
      {
         var event:AudioBusEvent = new AudioBusEvent(AudioBusEvent.REMOVE_SOUND_IN_BUS);
         event.sound = sound;
         this._eventDispatcher.dispatchEvent(event);
      }
      
      private function onAddSound(sound:ISound) : void
      {
         var event:AudioBusEvent = new AudioBusEvent(AudioBusEvent.ADD_SOUND_IN_BUS);
         event.sound = sound;
         this._eventDispatcher.dispatchEvent(event);
      }
   }
}
