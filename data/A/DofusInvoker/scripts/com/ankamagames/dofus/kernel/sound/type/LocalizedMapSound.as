package com.ankamagames.dofus.kernel.sound.type
{
   import flash.geom.Point;
   
   public class LocalizedMapSound
   {
       
      
      public var soundId:String;
      
      public var position:Point;
      
      public var range:int;
      
      public var saturationRange:int;
      
      public var silenceMin:int;
      
      public var silenceMax:int;
      
      public var volumeMax:Number;
      
      public function LocalizedMapSound(pSoundId:String, pPosition:Point, pRange:int, pSaturationRange:int, pSilenceMin:int, pSilenceMax:int, pVolumeMax:Number)
      {
         super();
         this.soundId = pSoundId;
         this.position = pPosition;
         this.range = pRange;
         this.saturationRange = pSaturationRange;
         this.silenceMin = pSilenceMin;
         this.silenceMax = pSilenceMax;
         this.volumeMax = pVolumeMax;
      }
   }
}
