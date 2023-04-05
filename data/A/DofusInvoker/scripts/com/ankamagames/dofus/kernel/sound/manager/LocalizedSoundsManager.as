package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.Layer;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   import com.ankamagames.atouin.data.map.elements.SoundElement;
   import com.ankamagames.dofus.kernel.sound.type.LocalizedMapSound;
   import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
   import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.types.SoundSilence;
   import flash.utils.getQualifiedClassName;
   
   public class LocalizedSoundsManager
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(LocalizedSoundsManager));
       
      
      private var _localizedSounds:Vector.<LocalizedMapSound>;
      
      private var _sounds:Vector.<ISound>;
      
      private var _isInitialized:Boolean;
      
      public function LocalizedSoundsManager()
      {
         super();
         this._isInitialized = false;
      }
      
      public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public function setMap(pMap:Map) : void
      {
         var layer:Layer = null;
         var cell:Cell = null;
         var element:BasicElement = null;
         var elem:SoundElement = null;
         var lms:LocalizedMapSound = null;
         this.removeLocalizedSounds();
         for each(layer in pMap.layers)
         {
            for each(cell in layer.cells)
            {
               for each(element in cell.elements)
               {
                  if(element is SoundElement)
                  {
                     elem = element as SoundElement;
                     lms = new LocalizedMapSound(elem.soundId.toString(),elem.cell.pixelCoords,elem.nullVolumeDistance,elem.fullVolumeDistance,elem.minDelayBetweenLoops,elem.maxDelayBetweenLoops,elem.baseVolume);
                     this._localizedSounds.push(lms);
                  }
               }
            }
         }
         this._isInitialized = true;
      }
      
      public function playLocalizedSounds() : void
      {
         var lms:LocalizedMapSound = null;
         var busId:uint = 0;
         var localizedSound:ISound = null;
         for each(lms in this._localizedSounds)
         {
            busId = SoundUtil.getBusIdBySoundId(lms.soundId);
            localizedSound = new SoundDofus(lms.soundId);
            localizedSound.busId = busId;
            (localizedSound as SoundDofus).saturationRange = lms.saturationRange;
            (localizedSound as SoundDofus).silence = new SoundSilence(lms.silenceMin,lms.silenceMax);
            (localizedSound as SoundDofus).range = lms.range;
            (localizedSound as SoundDofus).volumeMax = lms.volumeMax;
            (localizedSound as SoundDofus).position = lms.position;
            localizedSound.play();
            this._sounds.push(localizedSound);
         }
      }
      
      public function stopLocalizedSounds() : void
      {
         var sound:ISound = null;
         for each(sound in this._sounds)
         {
            sound.stop();
            sound = null;
         }
         this._sounds = new Vector.<ISound>();
      }
      
      private function removeLocalizedSounds() : void
      {
         this.stopLocalizedSounds();
         this._localizedSounds = new Vector.<LocalizedMapSound>();
      }
   }
}
