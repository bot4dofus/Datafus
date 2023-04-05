package com.ankamagames.tubul.types
{
   public class RollOffPreset
   {
       
      
      private var _maxVolume:uint;
      
      private var _maxRange:uint;
      
      private var _maxSaturationRange:uint;
      
      public function RollOffPreset(pMaxVolume:uint, pRange:uint, pMaxSaturationRange:uint)
      {
         super();
         this._maxVolume = pMaxVolume;
         this._maxRange = pRange;
         this._maxSaturationRange = pMaxSaturationRange;
      }
      
      public function get maxVolume() : uint
      {
         return this._maxVolume;
      }
      
      public function get maxRange() : uint
      {
         return this._maxRange;
      }
      
      public function get maxSaturationRange() : uint
      {
         return this._maxSaturationRange;
      }
   }
}
