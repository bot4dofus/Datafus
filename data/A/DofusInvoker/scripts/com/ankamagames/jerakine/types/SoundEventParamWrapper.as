package com.ankamagames.jerakine.types
{
   public class SoundEventParamWrapper
   {
       
      
      public var id:String;
      
      public var volume:uint;
      
      public var rollOff:uint;
      
      public var berceauDuree:int;
      
      public var berceauVol:int;
      
      public var berceauFadeIn:int;
      
      public var berceauFadeOut:int;
      
      public var noCutSilence:Boolean;
      
      public var isLocalized:int;
      
      public function SoundEventParamWrapper(pId:String, pVolume:uint, pRollOff:uint, pBerceauDuree:int = -1, pBerceauVol:int = -1, pBerceauFadeIn:int = -1, pBerceauFadeOut:int = -1, pNoCutSilence:Boolean = false, pIsLocalized:int = -1)
      {
         super();
         this.id = pId;
         this.volume = pVolume;
         this.rollOff = pRollOff;
         this.berceauDuree = pBerceauDuree;
         this.berceauVol = pBerceauVol;
         this.berceauFadeIn = pBerceauFadeIn;
         this.berceauFadeOut = pBerceauFadeOut;
         this.noCutSilence = pNoCutSilence;
         this.isLocalized = pIsLocalized;
      }
   }
}
